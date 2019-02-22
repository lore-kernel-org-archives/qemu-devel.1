Received: from eggs.gnu.org ([209.51.188.92]:48530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gx4MQ-00008C-U0
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gx4MP-0006gp-TT
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:31:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gx4MP-0006SM-LU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:31:01 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so1343659qtr.9
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 22:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-4-peterx@redhat.com>
In-Reply-To: <20190222031413.20250-4-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 22 Feb 2019 07:30:30 +0100
Message-ID: <CAMxuvazPDe_DKpNaAjWCFpzCuYOZmdB1+w6qATtOuL7eNYy3-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] iothread: create main loop
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com> wrote:
>
> Since we've have the gcontext always there, create the main loop
> altogether.  The iothread_run() is even cleaner.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  iothread.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/iothread.c b/iothread.c
> index 6fa87876e0..9abdbace66 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -66,17 +66,8 @@ static void *iothread_run(void *opaque)
>           * changed in previous aio_poll()
>           */
>          if (iothread->running && atomic_read(&iothread->run_gcontext)) {
> -            GMainLoop *loop;
> -
>              g_main_context_push_thread_default(iothread->worker_context)=
;
> -            iothread->main_loop =3D
> -                g_main_loop_new(iothread->worker_context, TRUE);
> -            loop =3D iothread->main_loop;
> -
>              g_main_loop_run(iothread->main_loop);
> -            iothread->main_loop =3D NULL;
> -            g_main_loop_unref(loop);
> -
>              g_main_context_pop_thread_default(iothread->worker_context);
>          }
>      }
> @@ -141,6 +132,8 @@ static void iothread_instance_finalize(Object *obj)
>      if (iothread->worker_context) {
>          g_main_context_unref(iothread->worker_context);
>          iothread->worker_context =3D NULL;
> +        g_main_loop_unref(iothread->main_loop);
> +        iothread->main_loop =3D NULL;
>      }
>      qemu_sem_destroy(&iothread->init_done_sem);
>  }
> @@ -153,6 +146,7 @@ static void iothread_init_gcontext(IOThread *iothread=
)
>      source =3D aio_get_g_source(iothread_get_aio_context(iothread));
>      g_source_attach(source, iothread->worker_context);
>      g_source_unref(source);
> +    iothread->main_loop =3D g_main_loop_new(iothread->worker_context, TR=
UE);
>  }
>
>  static void iothread_complete(UserCreatable *obj, Error **errp)
> --
> 2.17.1
>
