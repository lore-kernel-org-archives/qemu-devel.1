Received: from eggs.gnu.org ([2001:4830:134:3::10]:57140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gHKvz-0000Rg-6W
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gHKvv-0003tg-VJ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:43:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gHKvv-0003sB-Oc
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:43:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F227A83F3C
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 03:43:10 +0000 (UTC)
Date: Tue, 30 Oct 2018 11:43:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181030034303.GC22523@xz-x1>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029125733.14597-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] monitor: accept chardev input from
 iothread
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

On Mon, Oct 29, 2018 at 04:57:29PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Chardev backends may not handle safely IO events from concurrent
> threads. Better to wake up the chardev from the monitor IO thread if
> it's being used as the chardev context.
>=20
> Unify code paths by using a BH in all cases.
>=20
> Drop the now redundant aio_notify() call.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index 07712d89f9..511dd11d1c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4304,6 +4304,13 @@ int monitor_suspend(Monitor *mon)
>      return 0;
>  }
> =20
> +static void monitor_accept_input(void *opaque)
> +{
> +    Monitor *mon =3D opaque;
> +
> +    qemu_chr_fe_accept_input(&mon->chr);
> +}
> +
>  void monitor_resume(Monitor *mon)
>  {
>      if (monitor_is_hmp_non_interactive(mon)) {
> @@ -4311,20 +4318,24 @@ void monitor_resume(Monitor *mon)
>      }
> =20
>      if (atomic_dec_fetch(&mon->suspend_cnt) =3D=3D 0) {
> +        AioContext *ctx =3D qemu_get_aio_context();
> +
>          if (monitor_is_qmp(mon)) {
>              /*
>               * For QMP monitors that are running in the I/O thread,
>               * let's kick the thread in case it's sleeping.

This comment seems stall, you may consider to touch it up, otherwise
it looks sane to me:

Reviewed-by: Peter Xu <peterx@redhat.com>

>               */
>              if (mon->use_io_thread) {
> -                aio_notify(iothread_get_aio_context(mon_iothread));
> +                ctx =3D iothread_get_aio_context(mon_iothread);
>              }
>          } else {
>              assert(mon->rs);
>              readline_show_prompt(mon->rs);
>          }
> -        qemu_chr_fe_accept_input(&mon->chr);
> +
> +        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
>      }
> +
>      trace_monitor_suspend(mon, -1);
>  }
> =20
> --=20
> 2.19.0.271.gfe8321ec05
>=20

Regards,

--=20
Peter Xu
