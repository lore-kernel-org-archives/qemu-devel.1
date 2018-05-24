Received: from eggs.gnu.org ([2001:4830:134:3::10]:56669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLsfC-0004ZE-I1
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLsf6-00043D-SJ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:00:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fLsf6-00042E-IC
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:00:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFC9581902A1
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 16:00:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-5-git-send-email-imammedo@redhat.com>
Date: Thu, 24 May 2018 18:00:18 +0200
In-Reply-To: <1525423069-61903-5-git-send-email-imammedo@redhat.com> (Igor
	Mammedov's message of "Fri, 4 May 2018 10:37:42 +0200")
Message-ID: <87h8mx11t9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 04/11] hmp: disable monitor in preconfig
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, ehabkost@redhat.com

Igor Mammedov <imammedo@redhat.com> writes:

> Ban it for now, if someone would need it to work early,
> one would have to implement checks if HMP command is valid
> at preconfig state.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
> v5:
>   * add 'use QMP instead" to error message, suggesting user
>     the right interface to use
> v4:
>   * v3 was only printing error but not preventing command execution,
>     Fix it by returning after printing error message.
>     ("Dr. David Alan Gilbert" <dgilbert@redhat.com>)
> ---
>  monitor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/monitor.c b/monitor.c
> index 39f8ee1..0ffdf1d 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3374,6 +3374,12 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
>  
>      trace_handle_hmp_command(mon, cmdline);
>  
> +    if (runstate_check(RUN_STATE_PRECONFIG)) {
> +        monitor_printf(mon, "HMP not available in preconfig state, "
> +                            "use QMP instead\n");
> +        return;
> +    }
> +
>      cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
>      if (!cmd) {
>          return;

So we offer the user an HMP monitor, but we summarily fail all commands.
I'm sorry, but that's... searching for polite word... embarrassing.  We
should accept HMP output only when we're ready to accept it.  Yes, that
would involve a bit more surgery rather than this cheap hack.  The whole
preconfig thing smells like a cheap hack to me, but let's not overdo it.
