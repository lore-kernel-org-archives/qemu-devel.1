Received: from eggs.gnu.org ([2001:4830:134:3::10]:32829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSIWR-0002IB-PU
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSIWO-0002t7-Nz
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:49:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55454 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSIWO-0002rc-Hh
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:49:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 948EA401EF00
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 08:49:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-2-dgilbert@redhat.com>
Date: Mon, 11 Jun 2018 10:49:50 +0200
In-Reply-To: <20180608130846.22234-2-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 8 Jun 2018 14:08:40 +0100")
Message-ID: <87k1r5lnbl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/7] hmp: Add flag for preconfig commands
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
> Add a flag to command definitions to allow them to be used in preconfig
> and check it.
> If users try to use commands that aren't available, tell them to use
> the exit_preconfig comand we're adding in a few patches.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  monitor.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/monitor.c b/monitor.c
> index 6d0cec552e..f4a16e6a03 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -128,6 +128,7 @@ typedef struct mon_cmd_t {
>      const char *args_type;
>      const char *params;
>      const char *help;
> +    const char *flags; /* p=preconfig */

I'd add a bool for each flag instead of encoding them in a string.  No
need for a comment then (yours is cryptic).  But your artistic license
applies.

>      void (*cmd)(Monitor *mon, const QDict *qdict);
>      /* @sub_table is a list of 2nd level of commands. If it does not exist,
>       * cmd should be used. If it exists, sub_table[?].cmd should be
> @@ -936,6 +937,19 @@ static int parse_cmdline(const char *cmdline,
>      return -1;
>  }
>  
> +/*
> + * Returns true if the command can be executed in preconfig mode
> + * i.e. it has the 'p' flag.
> + */
> +static bool cmd_can_preconfig(const mon_cmd_t *cmd)
> +{
> +    if (!cmd->flags) {
> +        return false;
> +    }
> +
> +    return strchr(cmd->flags, 'p');
> +}
> +
>  static void help_cmd_dump_one(Monitor *mon,
>                                const mon_cmd_t *cmd,
>                                char **prefix_args,
> @@ -2976,6 +2990,12 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
>                         (int)(p - cmdp_start), cmdp_start);
>          return NULL;
>      }
> +    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
> +        monitor_printf(mon, "Command '%.*s' not available with -preconfig; "
> +                            "use exit_preconfig after configuration.\n",
> +                       (int)(p - cmdp_start), cmdp_start);
> +        return NULL;
> +    }
>  
>      /* filter out following useless space */
>      while (qemu_isspace(*p)) {

Suggest "not available with -preconfig until after exit_preconfig".

Regardless,
Reviewed-by: Markus Armbruster <armbru@redhat.com>
