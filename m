Received: from eggs.gnu.org ([2001:4830:134:3::10]:37394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fax40-0003Tq-JQ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fax3v-0004xP-OO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:44:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fax3v-0004wJ-Jl
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:44:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21B44406F8B2
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 05:44:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-2-peterx@redhat.com>
Date: Thu, 05 Jul 2018 07:44:09 +0200
In-Reply-To: <20180704084507.14560-2-peterx@redhat.com> (Peter Xu's message of
	"Wed, 4 Jul 2018 16:44:59 +0800")
Message-ID: <87efgick46.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/9] monitor: simplify
 monitor_qmp_setup_handlers_bh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> When we reach monitor_qmp_setup_handlers_bh() we must be using the
> IOThread then, so no need to check against it any more.  Instead, we
> assert.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 14af7b7ea6..0e3ac52d87 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4583,15 +4583,10 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>      Monitor *mon = opaque;
>      GMainContext *context;
>  
> -    if (mon->use_io_thread) {
> -        /* Use @mon_iothread context */
> -        context = monitor_get_io_context();
> -        assert(context);
> -    } else {
> -        /* Use default main loop context */
> -        context = NULL;
> -    }
> -
> +    assert(mon->use_io_thread);
> +    /* Use @mon_iothread context */
> +    context = monitor_get_io_context();
> +    assert(context);
>      qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
>                               monitor_qmp_event, NULL, mon, context, true);
>      monitor_list_append(mon);

Reviewed-by: Markus Armbruster <armbru@redhat.com>
