Received: from eggs.gnu.org ([209.51.188.92]:38813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gqbdj-0007ja-TQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gqbdi-00034y-V9
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:38:11 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gqbdi-00030G-Qs
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:38:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id b15so2966720qto.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 02:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20190123172740.32452-1-berrange@redhat.com>
	<20190123172740.32452-2-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-2-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 4 Feb 2019 11:37:57 +0100
Message-ID: <CAMxuvayRb9_FjR--Y9enzyh40TrkynfyXnx_860xtnkFevNb1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/16] io: store reference to thread
 information in the QIOTask struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yongji Xie <elohimes@gmail.com>

On Wed, Jan 23, 2019 at 6:27 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> Currently the struct QIOTaskThreadData is only needed by the worker
> thread, but a subsequent patch will need to access it from another
> context.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  io/task.c | 53 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 25 deletions(-)
>
> diff --git a/io/task.c b/io/task.c
> index 2886a2c1bc..d100a754d3 100644
> --- a/io/task.c
> +++ b/io/task.c
> @@ -24,6 +24,14 @@
>  #include "qemu/thread.h"
>  #include "trace.h"
>
> +struct QIOTaskThreadData {
> +    QIOTaskWorker worker;
> +    gpointer opaque;
> +    GDestroyNotify destroy;
> +    GMainContext *context;
> +};
> +
> +
>  struct QIOTask {
>      Object *source;
>      QIOTaskFunc func;
> @@ -32,6 +40,7 @@ struct QIOTask {
>      Error *err;
>      gpointer result;
>      GDestroyNotify destroyResult;
> +    struct QIOTaskThreadData *thread;
>  };
>
>
> @@ -72,31 +81,23 @@ static void qio_task_free(QIOTask *task)
>  }
>
>
> -struct QIOTaskThreadData {
> -    QIOTask *task;
> -    QIOTaskWorker worker;
> -    gpointer opaque;
> -    GDestroyNotify destroy;
> -    GMainContext *context;
> -};
> -
> -
>  static gboolean qio_task_thread_result(gpointer opaque)
>  {
> -    struct QIOTaskThreadData *data =3D opaque;
> +    QIOTask *task =3D opaque;
>
> -    trace_qio_task_thread_result(data->task);
> -    qio_task_complete(data->task);
> +    trace_qio_task_thread_result(task);
> +    qio_task_complete(task);
>
> -    if (data->destroy) {
> -        data->destroy(data->opaque);
> +    if (task->thread->destroy) {
> +        task->thread->destroy(task->thread->opaque);
>      }
>
> -    if (data->context) {
> -        g_main_context_unref(data->context);
> +    if (task->thread->context) {
> +        g_main_context_unref(task->thread->context);
>      }
>
> -    g_free(data);
> +    g_free(task->thread);
> +    task->thread =3D NULL;
>
>      return FALSE;
>  }
> @@ -104,22 +105,23 @@ static gboolean qio_task_thread_result(gpointer opa=
que)
>
>  static gpointer qio_task_thread_worker(gpointer opaque)
>  {
> -    struct QIOTaskThreadData *data =3D opaque;
> +    QIOTask *task =3D opaque;
>      GSource *idle;
>
> -    trace_qio_task_thread_run(data->task);
> -    data->worker(data->task, data->opaque);
> +    trace_qio_task_thread_run(task);
> +
> +    task->thread->worker(task, task->thread->opaque);
>
>      /* We're running in the background thread, and must only
>       * ever report the task results in the main event loop
>       * thread. So we schedule an idle callback to report
>       * the worker results
>       */
> -    trace_qio_task_thread_exit(data->task);
> +    trace_qio_task_thread_exit(task);
>
>      idle =3D g_idle_source_new();
> -    g_source_set_callback(idle, qio_task_thread_result, data, NULL);
> -    g_source_attach(idle, data->context);
> +    g_source_set_callback(idle, qio_task_thread_result, task, NULL);
> +    g_source_attach(idle, task->thread->context);
>
>      return NULL;
>  }
> @@ -138,17 +140,18 @@ void qio_task_run_in_thread(QIOTask *task,
>          g_main_context_ref(context);
>      }
>
> -    data->task =3D task;
>      data->worker =3D worker;
>      data->opaque =3D opaque;
>      data->destroy =3D destroy;
>      data->context =3D context;
>
> +    task->thread =3D data;
> +
>      trace_qio_task_thread_start(task, worker, opaque);
>      qemu_thread_create(&thread,
>                         "io-task-worker",
>                         qio_task_thread_worker,
> -                       data,
> +                       task,
>                         QEMU_THREAD_DETACHED);
>  }
>
> --
> 2.20.1
>
