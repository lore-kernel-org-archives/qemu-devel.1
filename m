Received: from eggs.gnu.org ([2001:4830:134:3::10]:54757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTibk-00024Z-0P
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 02:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTiNQ-0006mK-Mm
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 02:10:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTiNQ-0006lr-EZ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 02:10:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C202307D915
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 07:10:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-3-marcandre.lureau@redhat.com>
Date: Mon, 03 Dec 2018 08:10:37 +0100
In-Reply-To: <20181029125733.14597-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 29 Oct 2018 16:57:29 +0400")
Message-ID: <87in0b84r6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Chardev backends may not handle safely IO events from concurrent
> threads.

What exactly could go wrong?  Or is this a well-known fact that doesn't
need further elaboration?

"safely handle I/O events"

>          Better to wake up the chardev from the monitor IO thread if
> it's being used as the chardev context.
>
> Unify code paths by using a BH in all cases.
>
> Drop the now redundant aio_notify() call.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 07712d89f9..511dd11d1c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4304,6 +4304,13 @@ int monitor_suspend(Monitor *mon)
>      return 0;
>  }
>=20=20
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
>=20=20
>      if (atomic_dec_fetch(&mon->suspend_cnt) =3D=3D 0) {
> +        AioContext *ctx =3D qemu_get_aio_context();
> +
>          if (monitor_is_qmp(mon)) {
>              /*
>               * For QMP monitors that are running in the I/O thread,
>               * let's kick the thread in case it's sleeping.
>               */
>              if (mon->use_io_thread) {
> -                aio_notify(iothread_get_aio_context(mon_iothread));
> +                ctx =3D iothread_get_aio_context(mon_iothread);
>              }
>          } else {
>              assert(mon->rs);
>              readline_show_prompt(mon->rs);
>          }

Correct, since mon->use_io_thread can only be true in a QMP monitor so
far.  But there's no need to depend on that here:

           AioContext *ctx;

           if (mon->use_io_thread) {
               ctx =3D iothread_get_aio_context(mon_iothread);
           } else {
               ctx =3D qemu_get_aio_context();
           }

           if (!monitor_is_qmp(mon)) {
               assert(mon->rs);
               readline_show_prompt(mon->rs);
           }

Same in monitor_suspend(), by the way.

The dependence in monitor_init() is tolerable, because it's the place
where the dependence is established.

> -        qemu_chr_fe_accept_input(&mon->chr);
> +
> +        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
>      }
> +
>      trace_monitor_suspend(mon, -1);
>  }
