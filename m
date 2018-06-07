Received: from eggs.gnu.org ([2001:4830:134:3::10]:50129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQqeq-00029h-NM
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQqep-0004xH-Rj
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:52:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQqep-0004x3-LO
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:52:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDC98818BAED
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 08:52:34 +0000 (UTC)
Date: Thu, 7 Jun 2018 16:52:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607085230.GK750@xz-mi>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180605122636.33654-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605122636.33654-4-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] hmp: Restrict auto-complete in
 preconfig
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

On Tue, Jun 05, 2018 at 01:26:33PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Don't show the commands that aren't available.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  monitor.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 7d1709c225..9b29787a52 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3950,12 +3950,17 @@ static void monitor_find_completion_by_table(Monitor *mon,
>              cmdname = args[0];
>          readline_set_completion_index(mon->rs, strlen(cmdname));
>          for (cmd = cmd_table; cmd->name != NULL; cmd++) {
> -            cmd_completion(mon, cmdname, cmd->name);
> +            if (!runstate_check(RUN_STATE_PRECONFIG) ||
> +                 cmd_can_preconfig(cmd)) {
> +                cmd_completion(mon, cmdname, cmd->name);
> +            }
>          }
>      } else {
>          /* find the command */
>          for (cmd = cmd_table; cmd->name != NULL; cmd++) {
> -            if (compare_cmd(args[0], cmd->name)) {
> +            if (compare_cmd(args[0], cmd->name) &&
> +                (!runstate_check(RUN_STATE_PRECONFIG) ||
> +                 cmd_can_preconfig(cmd))) {

(so if there is a helper we can also use it here)

Reviewed-by: Peter Xu <peterx@redhat.com>

>                  break;
>              }
>          }
> -- 
> 2.17.0
> 
> 

-- 
Peter Xu
