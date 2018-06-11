Received: from eggs.gnu.org ([2001:4830:134:3::10]:44784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSLYy-00055W-Jk
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSLYv-0007yQ-Fs
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:04:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSLYv-0007xS-A6
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:04:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B52BBBD9E
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 12:04:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-7-dgilbert@redhat.com>
Date: Mon, 11 Jun 2018 14:04:39 +0200
In-Reply-To: <20180608130846.22234-7-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 8 Jun 2018 14:08:45 +0100")
Message-ID: <87r2ldil60.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 6/7] hmp: add exit_preconfig
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
> Add the exit_preconfig command to return to normality.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hmp-commands.hx | 15 +++++++++++++++
>  hmp.c           |  7 +++++++
>  hmp.h           |  1 +
>  3 files changed, 23 insertions(+)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index dc82ed526f..40e2f6ca08 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -55,6 +55,21 @@ STEXI
>  @item q or quit
>  @findex quit
>  Quit the emulator.
> +ETEXI
> +
> +    {
> +        .name       = "exit_preconfig",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "exit the preconfig state",
> +        .cmd        = hmp_exit_preconfig,
> +        .flags      = "p",
> +    },
> +
> +STEXI
> +@item exit_preconfig
> +@findex exit_preconfig
> +Exit the preconfig state

This is awfully terse.  Suggest to steal from the QMP documentation in
misc.json:

# This command makes QEMU exit the preconfig state and proceed with
# VM initialization using configuration data provided on the command line
# and via the QMP monitor during the preconfig state. The command is only
# available during the preconfig state (i.e. when the --preconfig command
# line option was in use).

>  ETEXI
>  
>      {
> diff --git a/hmp.c b/hmp.c
> index ef93f4878b..c7be6ed394 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1065,6 +1065,13 @@ void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
>      qmp_system_powerdown(NULL);
>  }
>  
> +void hmp_exit_preconfig(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    qmp_exit_preconfig(&err);
> +    hmp_handle_error(mon, &err);
> +}
> +

Blank line between declaration and statements, please.

>  void hmp_cpu(Monitor *mon, const QDict *qdict)
>  {
>      int64_t cpu_index;
> diff --git a/hmp.h b/hmp.h
> index 20f27439d3..33354f1bdd 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -44,6 +44,7 @@ void hmp_quit(Monitor *mon, const QDict *qdict);
>  void hmp_stop(Monitor *mon, const QDict *qdict);
>  void hmp_system_reset(Monitor *mon, const QDict *qdict);
>  void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
> +void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
>  void hmp_cpu(Monitor *mon, const QDict *qdict);
>  void hmp_memsave(Monitor *mon, const QDict *qdict);
>  void hmp_pmemsave(Monitor *mon, const QDict *qdict);
