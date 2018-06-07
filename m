Received: from eggs.gnu.org ([2001:4830:134:3::10]:49991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQqeJ-0001em-OB
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQqeG-0004dg-Nj
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:52:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQqeG-0004dG-I8
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:52:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17FE4401EF11
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 08:52:00 +0000 (UTC)
Date: Thu, 7 Jun 2018 16:51:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607085155.GJ750@xz-mi>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180605122636.33654-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605122636.33654-3-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] hmp: Allow help on preconfig commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com

On Tue, Jun 05, 2018 at 01:26:32PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Allow the 'help' command in preconfig state but
> make it only list the preconfig commands.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hmp-commands.hx | 1 +
>  monitor.c       | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 0734fea931..8bf590ae4b 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -15,6 +15,7 @@ ETEXI
>          .params     = "[cmd]",
>          .help       = "show the help",
>          .cmd        = do_help_cmd,
> +        .flags      = "p",
>      },
>  
>  STEXI
> diff --git a/monitor.c b/monitor.c
> index 50b95f41db..7d1709c225 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -957,6 +957,10 @@ static void help_cmd_dump_one(Monitor *mon,
>  {
>      int i;
>  
> +    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
> +        return;
> +    }
> +
>      for (i = 0; i < prefix_args_nb; i++) {
>          monitor_printf(mon, "%s ", prefix_args[i]);
>      }
> @@ -979,7 +983,9 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
>  
>      /* Find one entry to dump */
>      for (cmd = cmds; cmd->name != NULL; cmd++) {
> -        if (compare_cmd(args[arg_index], cmd->name)) {
> +        if (compare_cmd(args[arg_index], cmd->name) &&
> +            ((!runstate_check(RUN_STATE_PRECONFIG) ||
> +                cmd_can_preconfig(cmd)))) {

I saw that this pattern is used for multiple times already.  Maybe
it's time to introduce hmp_cmd_is_available(). :) I'll leave the
decision to you...

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
