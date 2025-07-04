module Custom exposing (Content, Model, Msg, benchmark, subscriptions, update, view)

import Custom.Benchmark as Benchmark
import Html exposing (Html)
import MyBenchmark exposing (Benchmark)
import SliceShow as Content


type alias Content =
    Content.Content Model Msg


type Model
    = BenchmarkModel Benchmark.Model


type Msg
    = BenchmarkMsg Benchmark.Msg


benchmark : Benchmark -> Content
benchmark benchmark_ =
    Content.custom (BenchmarkModel (Benchmark.init benchmark_))


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case ( action, model ) of
        ( BenchmarkMsg a, BenchmarkModel m ) ->
            let
                ( newModel, newCmd ) =
                    Benchmark.update a m
            in
            ( BenchmarkModel newModel, Cmd.map BenchmarkMsg newCmd )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    case model of
        BenchmarkModel submodel ->
            Html.map BenchmarkMsg (Benchmark.view submodel)
