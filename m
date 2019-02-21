Received: from eggs.gnu.org ([209.51.188.92]:52022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gwjHK-0008F8-UI
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 03:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gwjH9-0004CT-Oj
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 03:00:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gwjH9-0004CE-Hx
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 03:00:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1C6D308AA1F
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 08:00:10 +0000 (UTC)
Date: Thu, 21 Feb 2019 15:59:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190221075959.GB3091@xz-x1>
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
	<20190220160628.6555-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220160628.6555-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] iothread: wait until the glib context
 is acquired
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 20, 2019 at 05:06:25PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Another thread may acquire the glib context (temporarily) before
> g_main_context_push_thread_default().
>=20
> This can happen with the following qemu_chr_fe_set_handlers()
> modifications.
>=20
> Unfortunately, g_main_context_wait() is deprecated in glib
> 2.58 (apparently it was a broken interface). Use a polling loop.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  iothread.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/iothread.c b/iothread.c
> index e615b7ae52..93cc3aa875 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -70,6 +70,11 @@ static void *iothread_run(void *opaque)
>          if (iothread->running && atomic_read(&iothread->worker_context=
)) {
>              GMainLoop *loop;
> =20
> +            /* we may race with another thread acquiring the context *=
/
> +            while (!g_main_context_acquire(iothread->worker_context)) =
{
> +                g_usleep(10000);
> +            }

Could you help explain why need this explicitly?  Since AFAIU
g_main_loop_run() below will do context acquire too so IIUC you're
taking it twice (while g_main_context_acquire should allow it to
happen, though)?

> +
>              g_main_context_push_thread_default(iothread->worker_contex=
t);
>              iothread->main_loop =3D
>                  g_main_loop_new(iothread->worker_context, TRUE);
> @@ -80,6 +85,8 @@ static void *iothread_run(void *opaque)
>              g_main_loop_unref(loop);
> =20
>              g_main_context_pop_thread_default(iothread->worker_context=
);
> +
> +            g_main_context_release(iothread->worker_context);
>          }
>      }
> =20
> --=20
> 2.21.0.rc1
>=20
>=20

Regards,

--=20
Peter Xu
