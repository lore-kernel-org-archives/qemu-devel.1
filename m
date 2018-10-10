Received: from eggs.gnu.org ([2001:4830:134:3::10]:36559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gA5RI-0001wY-9q
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 23:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gA5RF-0000ZB-Jn
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 23:45:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gA5RF-0000YC-Cj
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 23:45:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA95830001E0
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 03:45:31 +0000 (UTC)
Date: Wed, 10 Oct 2018 11:45:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181010034525.GM18728@xz-x1>
References: <20181009131251.721-1-marcandre.lureau@redhat.com>
	<20181009131251.721-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009131251.721-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] monitor: accept chardev input from
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

On Tue, Oct 09, 2018 at 05:12:47PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Chardev backends may not handle safely IO events from concurrent
> threads. Better to wake up the chardev from the monitor IO thread if
> it's being used as the chardev context.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index ab60c9f87e..a25514490a 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4297,6 +4297,13 @@ int monitor_suspend(Monitor *mon)
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
> @@ -4310,13 +4317,14 @@ void monitor_resume(Monitor *mon)
>               * let's kick the thread in case it's sleeping.
>               */
>              if (mon->use_io_thread) {
> -                aio_notify(iothread_get_aio_context(mon_iothread));
> +                aio_bh_schedule_oneshot(iothread_get_aio_context(mon_i=
othread),
> +                                        monitor_accept_input, mon);

Just to make sure: this will definitely cover the previous
aio_notify(), am I right?

Imho some comment would always be nice here because QMPs with
use_io_thread=3Dtrue seems special anyway.

>              }
>          } else {
>              assert(mon->rs);
>              readline_show_prompt(mon->rs);
> +            monitor_accept_input(mon);
>          }
> -        qemu_chr_fe_accept_input(&mon->chr);

How about the QMP monitors with oob=3Doff?  Will it miss the call?

I would consider caching the aio context into Monitor struct when
monitor init, then call aio_bh_schedule_oneshot() always with the
per-monitor aio cache.  This could unify the code paths too so we keep
the oob special path as less as possible.

>      }
>      trace_monitor_suspend(mon, -1);
>  }
> --=20
> 2.19.0.271.gfe8321ec05
>=20

Regards,

--=20
Peter Xu
