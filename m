Received: from eggs.gnu.org ([2001:4830:134:3::10]:43399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fubhm-0002oB-KG
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fubhl-00004u-RG
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:58:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fubhl-0008WF-K5
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:58:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id v90-v6so1166315wrc.0
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 03:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180821100716.13803-1-marcandre.lureau@redhat.com>
In-Reply-To: <20180821100716.13803-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Aug 2018 12:58:24 +0200
Message-ID: <CAJ+F1CK9-pJyY+sWqUYiYvDAxWO9F_1ETgzNZ=zi1cUBuM5LSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iothread: fix crash with invalid properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

ping
On Tue, Aug 21, 2018 at 12:07 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> -object iothread,id=3Dfoo,? will crash qemu:
>
> qemu-system-x86_64:qemu-thread-posix.c:128: qemu_cond_destroy: Assertion =
`cond->initialized' failed.
>
> Use thread_id !=3D -1 to check if iothread_complete() finished
> successfully and the mutex/cond have been initialized.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  iothread.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/iothread.c b/iothread.c
> index aff1281257..2fb1cdf55d 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -110,6 +110,7 @@ static void iothread_instance_init(Object *obj)
>      IOThread *iothread =3D IOTHREAD(obj);
>
>      iothread->poll_max_ns =3D IOTHREAD_POLL_MAX_NS_DEFAULT;
> +    iothread->thread_id =3D -1;
>  }
>
>  static void iothread_instance_finalize(Object *obj)
> @@ -117,6 +118,11 @@ static void iothread_instance_finalize(Object *obj)
>      IOThread *iothread =3D IOTHREAD(obj);
>
>      iothread_stop(iothread);
> +
> +    if (iothread->thread_id !=3D -1) {
> +        qemu_cond_destroy(&iothread->init_done_cond);
> +        qemu_mutex_destroy(&iothread->init_done_lock);
> +    }
>      /*
>       * Before glib2 2.33.10, there is a glib2 bug that GSource context
>       * pointer may not be cleared even if the context has already been
> @@ -135,8 +141,6 @@ static void iothread_instance_finalize(Object *obj)
>          g_main_context_unref(iothread->worker_context);
>          iothread->worker_context =3D NULL;
>      }
> -    qemu_cond_destroy(&iothread->init_done_cond);
> -    qemu_mutex_destroy(&iothread->init_done_lock);
>  }
>
>  static void iothread_complete(UserCreatable *obj, Error **errp)
> @@ -147,7 +151,6 @@ static void iothread_complete(UserCreatable *obj, Err=
or **errp)
>
>      iothread->stopping =3D false;
>      iothread->running =3D true;
> -    iothread->thread_id =3D -1;
>      iothread->ctx =3D aio_context_new(&local_error);
>      if (!iothread->ctx) {
>          error_propagate(errp, local_error);
> --
> 2.18.0.547.g1d89318c48
>
>


--=20
Marc-Andr=C3=A9 Lureau
