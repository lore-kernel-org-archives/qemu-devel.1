Received: from eggs.gnu.org ([2001:4830:134:3::10]:35246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSIiz-0007E6-Hl
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSIiu-0000lL-L5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:02:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSIiu-0000l5-Fo
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:02:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B0EC7D84D
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 09:02:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-4-dgilbert@redhat.com>
Date: Mon, 11 Jun 2018 11:02:46 +0200
In-Reply-To: <20180608130846.22234-4-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 8 Jun 2018 14:08:42 +0100")
Message-ID: <87bmchlmq1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/7] hmp: Restrict auto-complete in
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

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Don't show the commands that aren't available.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  monitor.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 31c8f5dc88..c369b392db 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3951,12 +3951,17 @@ static void monitor_find_completion_by_table(Monitor *mon,
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
>                  break;
>              }
>          }

Hmm, I keep seeing

    !runstate_check(RUN_STATE_PRECONFIG) || cmd_can_preconfig(cmd)

Would a helper be worthwhile?  cmd_available(cmd)?
