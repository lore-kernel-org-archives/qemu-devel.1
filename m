Received: from eggs.gnu.org ([2001:4830:134:3::10]:57127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVvCR-0000js-4r
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVvCM-0000Po-4W
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:44:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fVvCL-0000P5-VS
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:44:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC61D400E9A3
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:44:08 +0000 (UTC)
Date: Thu, 21 Jun 2018 10:44:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180621104405.12cf2e7c@redhat.com>
In-Reply-To: <20180620153947.30834-2-dgilbert@redhat.com>
References: <20180620153947.30834-1-dgilbert@redhat.com>
	<20180620153947.30834-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/7] hmp: Add flag for preconfig commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com

On Wed, 20 Jun 2018 16:39:41 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add a flag to command definitions to allow them to be used in preconfig
> and check it.
> If users try to use commands that aren't available, tell them to use
> the exit_preconfig comand we're adding in a few patches.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  monitor.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/monitor.c b/monitor.c
> index 885e000f9b..8dc86c0c3c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -128,6 +128,7 @@ typedef struct mon_cmd_t {
>      const char *args_type;
>      const char *params;
>      const char *help;
> +    const char *flags; /* p=preconfig */
>      void (*cmd)(Monitor *mon, const QDict *qdict);
>      /* @sub_table is a list of 2nd level of commands. If it does not exist,
>       * cmd should be used. If it exists, sub_table[?].cmd should be
> @@ -958,6 +959,19 @@ static int parse_cmdline(const char *cmdline,
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
> @@ -3041,6 +3055,12 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
>                         (int)(p - cmdp_start), cmdp_start);
>          return NULL;
>      }
> +    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
> +        monitor_printf(mon, "Command '%.*s' not available with -preconfig "
> +                            "until after exit_preconfig.\n",
> +                       (int)(p - cmdp_start), cmdp_start);
> +        return NULL;
> +    }
>  
>      /* filter out following useless space */
>      while (qemu_isspace(*p)) {
