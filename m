Received: from eggs.gnu.org ([209.51.188.92]:36319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grkfn-0006Mg-7j
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grkfl-0004yT-KO
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:29:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1grkfl-0004xh-6x
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:29:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id b8so2259qtr.9
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 06:29:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549545591.git.berto@igalia.com>
	<2c1d9d03c5b3ee26b116db3438caa3df73dffa46.1549545591.git.berto@igalia.com>
In-Reply-To: <2c1d9d03c5b3ee26b116db3438caa3df73dffa46.1549545591.git.berto@igalia.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 7 Feb 2019 15:28:49 +0100
Message-ID: <CAMxuvazff=VRnBdv46CofLg3p5QDQyU4TMQD2pQxu2sFX99tSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] main-loop: Add qemu_idle_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

Hi

On Thu, Feb 7, 2019 at 2:23 PM Alberto Garcia <berto@igalia.com> wrote:
>
> This works like g_idle_add() but allows specifying a different
> GMainContext. It also returns the GSource directly instead of its ID
> number for convenience.
>
> pty_chr_state() and qio_task_thread_worker() are modified to make use
> of this new function.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  chardev/char-pty.c       | 8 ++------
>  include/qemu/main-loop.h | 8 ++++++++
>  io/task.c                | 7 ++-----
>  util/main-loop.c         | 9 +++++++++
>  4 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index f16a5e8d59..6562c38f39 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -209,13 +209,9 @@ static void pty_chr_state(Chardev *chr, int connecte=
d)
>          pty_chr_timer_cancel(s);
>          if (!s->connected) {
>              g_assert(s->open_source =3D=3D NULL);
> -            s->open_source =3D g_idle_source_new();
> +            s->open_source =3D qemu_idle_add(qemu_chr_be_generic_open_fu=
nc,
> +                                           chr, chr->gcontext);
>              s->connected =3D 1;
> -            g_source_set_callback(s->open_source,
> -                                  qemu_chr_be_generic_open_func,
> -                                  chr, NULL);
> -            g_source_attach(s->open_source, chr->gcontext);
> -            g_source_unref(s->open_source);
>          }
>          if (!chr->gsource) {
>              chr->gsource =3D io_add_watch_poll(chr, s->ioc,
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index e59f9ae1e9..1865afd993 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -295,6 +295,14 @@ void qemu_mutex_lock_iothread_impl(const char *file,=
 int line);
>   */
>  void qemu_mutex_unlock_iothread(void);
>
> +/**
> + * qemu_idle_add: Add an idle function to a GMainContext
> + *
> + * This function is similar to GLib's g_idle_add() but it allows
> + * specifying a GMainContext instead of using the global one.
> + */
> +GSource *qemu_idle_add(GSourceFunc func, gpointer data, GMainContext *ct=
x);

I think you should document that returned GSource* isn't ref/owned.

> +
>  /* internal interfaces */
>
>  void qemu_fd_register(int fd);
> diff --git a/io/task.c b/io/task.c
> index c8489fb790..bdd395b0ad 100644
> --- a/io/task.c
> +++ b/io/task.c
> @@ -19,6 +19,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "io/task.h"
>  #include "qapi/error.h"
>  #include "qemu/thread.h"
> @@ -105,7 +106,6 @@ static gboolean qio_task_thread_result(gpointer opaqu=
e)
>  static gpointer qio_task_thread_worker(gpointer opaque)
>  {
>      struct QIOTaskThreadData *data =3D opaque;
> -    GSource *idle;
>
>      trace_qio_task_thread_run(data->task);
>      data->worker(data->task, data->opaque);
> @@ -117,10 +117,7 @@ static gpointer qio_task_thread_worker(gpointer opaq=
ue)
>       */
>      trace_qio_task_thread_exit(data->task);
>
> -    idle =3D g_idle_source_new();
> -    g_source_set_callback(idle, qio_task_thread_result, data, NULL);
> -    g_source_attach(idle, data->context);
> -    g_source_unref(idle);
> +    qemu_idle_add(qio_task_thread_result, data, data->context);
>
>      return NULL;
>  }
> diff --git a/util/main-loop.c b/util/main-loop.c
> index 443cb4cfe8..1c68e3bf5f 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -171,6 +171,15 @@ int qemu_init_main_loop(Error **errp)
>      return 0;
>  }
>
> +GSource *qemu_idle_add(GSourceFunc func, gpointer data, GMainContext *ct=
x)
> +{
> +    GSource *idle =3D g_idle_source_new();
> +    g_source_set_callback(idle, func, data, NULL);
> +    g_source_attach(idle, ctx);
> +    g_source_unref(idle);
> +    return idle;
> +}
> +
>  static int max_priority;
>
>  #ifndef _WIN32
> --
> 2.11.0
>

looks ok otherwise
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
