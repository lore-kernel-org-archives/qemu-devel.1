Received: from eggs.gnu.org ([2001:4830:134:3::10]:41988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etZdg-0001ky-9o
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etZdb-0002LG-Gq
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:01:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1etZdb-0002Kh-CO
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:01:47 -0500
Date: Wed, 7 Mar 2018 14:01:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180307140126.GB3090@work-vm>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-5-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518784641-43151-5-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/9] HMP: disable monitor in preconfig
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

* Igor Mammedov (imammedo@redhat.com) wrote:
> Ban it for now, if someone would need it to work early,
> one would have to implement checks if HMP command is valid
> at preconfig state.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> ---
>  monitor.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/monitor.c b/monitor.c
> index f499250..fcb5386 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3097,6 +3097,10 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
>  
>      trace_handle_hmp_command(mon, cmdline);
>  
> +    if (runstate_check(RUN_STATE_PRECONFIG)) {
> +        monitor_printf(mon, "HMP not available in precofig state\n");
> +    }

But you've not returned, so the command will still get parsed?

Dave

>      cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
>      if (!cmd) {
>          return;
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
