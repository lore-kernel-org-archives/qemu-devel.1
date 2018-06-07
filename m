Received: from eggs.gnu.org ([2001:4830:134:3::10]:46832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvyF-0006HM-GA
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvyC-00011n-CK
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:32:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQvyC-00011b-7L
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:32:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF538C12B1
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 14:32:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-6-peterx@redhat.com>
Date: Thu, 07 Jun 2018 16:32:54 +0200
In-Reply-To: <20180529055755.12404-6-peterx@redhat.com> (Peter Xu's message of
	"Tue, 29 May 2018 13:57:53 +0800")
Message-ID: <878t7qu0o9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 5/7] monitor: remove event_clock_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Instead, use a dynamic function to detect which clock we'll use.  The
> problem is that the old code will let monitor initialization depends on
> qtest_enabled().  After this change, we don't have such a dependency any
> more.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 2504696d76..bd9ab5597f 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -282,8 +282,6 @@ QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>  
>  Monitor *cur_mon;
>  
> -static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
> -
>  static void monitor_command_cb(void *opaque, const char *cmdline,
>                                 void *readline_opaque);
>  
> @@ -310,6 +308,15 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
>      return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
>  }
>  
> +static inline QEMUClockType monitor_get_clock(void)
> +{
> +    if (qtest_enabled()) {
> +        return QEMU_CLOCK_VIRTUAL;
> +    } else {
> +        return QEMU_CLOCK_REALTIME;
> +    }

Suggest the more laconic

       return qtest_enabled() ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME;

A comment explaining why we want QEMU_CLOCK_VIRTUAL would be nice.

> +}
> +
>  /**
>   * Is the current monitor, if any, a QMP monitor?
>   */
[...]
