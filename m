Received: from eggs.gnu.org ([2001:4830:134:3::10]:39754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQtoI-0003tz-Di
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQtoE-0006t5-Hy
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:14:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQtoE-0006sr-Cc
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:14:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 037F1859B5
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 12:14:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180605122636.33654-2-dgilbert@redhat.com>
Date: Thu, 07 Jun 2018 14:14:28 +0200
In-Reply-To: <20180605122636.33654-2-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Tue, 5 Jun 2018 13:26:31 +0100")
Message-ID: <87sh5yx07v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/6] hmp: Add flag for preconfig commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Add a flag to command definitions to allow them to be used in preconfig
> and check it.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  monitor.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/monitor.c b/monitor.c
> index 6d0cec552e..50b95f41db 100644
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
> @@ -2976,6 +2990,11 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
>                         (int)(p - cmdp_start), cmdp_start);
>          return NULL;
>      }
> +    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
> +        monitor_printf(mon, "Command '%.*s' not available in preconfig\n",
> +                       (int)(p - cmdp_start), cmdp_start);
> +        return NULL;
> +    }
>  
>      /* filter out following useless space */
>      while (qemu_isspace(*p)) {

This

    (qemu) c
    Command 'c' not available in preconfig

is not a nice user experience.  We can do better (paraphrasing myself):

    Command 'c' not available with -preconfig until you complete
    configuration with QMP

Note that this talks to the user in the user's terms (-preconfig)
instead of internal terms ("in preconfig", whatever that is), and is
more specific on how to ready the monitor.

Obviously, "with QMP" needs an update once HMP acquires a command to
exit preconfig state.
