Received: from eggs.gnu.org ([209.51.188.92]:52095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghsL2-0006rx-NG
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghsL1-0007si-NQ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:38:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghsL1-0007ra-CP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:38:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
	<154703594930.13472.14801510978993753998.stgit@pasha-VirtualBox>
Date: Fri, 11 Jan 2019 09:38:39 +0100
In-Reply-To: <154703594930.13472.14801510978993753998.stgit@pasha-VirtualBox>
	(Pavel Dovgalyuk's message of "Wed, 09 Jan 2019 15:12:29 +0300")
Message-ID: <87lg3r8u7k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 12/21] replay: introduce breakpoint at
 the specified step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> This patch introduces replay_break, replay_delete_break
> qmp and hmp commands.
> These commands allow stopping at the specified instruction.
> It may be useful for debugging when there are some known
> events that should be investigated.
> replay_break command has one argument - number of instructions
> executed since the start of the replay.
> replay_delete_break removes previously set breakpoint.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> --
>
> v2:
>  - renamed replay_break qmp command into replay-break
>    (suggested by Eric Blake)
> v7:
>  - introduces replay_delete_break command
> v9:
>  - changed 'step' parameter name to 'icount'
>  - moved json stuff to replay.json and updated the description
>    (suggested by Markus Armbruster)
> ---
>  hmp-commands.hx           |   34 ++++++++++++++++++
>  hmp.h                     |    2 +
>  qapi/replay.json          |   36 +++++++++++++++++++
>  replay/replay-debugging.c |   85 +++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay-internal.h  |    4 ++
>  replay/replay.c           |   17 +++++++++
>  6 files changed, 178 insertions(+)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index ba71558..6d04c02 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1890,6 +1890,40 @@ Set QOM property @var{property} of object at location @var{path} to value @var{v
>  ETEXI
>  
>      {
> +        .name       = "replay_break",
> +        .args_type  = "icount:i",
> +        .params     = "icount",
> +        .help       = "sets breakpoint on the step specified by the icount of the replay",

"set replay breakpoint at the specified instruction count"

> +        .cmd        = hmp_replay_break,
> +    },
> +
> +STEXI
> +@item replay_break @var{icount}
> +@findex replay_break
> +Set breakpoint on the step of the replay specified by @var{icount}.
> +Execution stops when the specified @var{icount} is reached.
> +icount for the reference may be observed with 'info replay' command.
> +There could be at most one breakpoint. When breakpoint is set, the prior
> +one is removed. The breakpoints may be set only in replay mode and only
> +at the step in the future.

This still uses both "step" and "instruction count".

Suggest

   Set replay breakpoint at instruction count @var{icount}.
   Execution stops when the specified instruction is reached.
   There can be at most one breakpoint.  When breakpoint is set, any prior
   one is removed.  The breakpoint may be set only in replay mode and only
   "in the future", i.e. at instruction counts greater than the current one.
   The current instruction count can be observed with 'info replay'.


> +ETEXI
> +
> +    {
> +        .name       = "replay_delete_break",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "removes replay breakpoint",
> +        .cmd        = hmp_replay_delete_break,
> +    },
> +
> +STEXI
> +@item replay_delete_break
> +@findex replay_delete_break
> +Removes replay breakpoint which was previously set with replay_break.
> +The command is ignored when there are no replay breakpoints.
> +ETEXI
> +
> +    {
>          .name       = "info",
>          .args_type  = "item:s?",
>          .params     = "[subcommand]",
> diff --git a/hmp.h b/hmp.h
> index d792149..c9b9b4f 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -149,5 +149,7 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
>  void hmp_info_sev(Monitor *mon, const QDict *qdict);
>  void hmp_info_replay(Monitor *mon, const QDict *qdict);
> +void hmp_replay_break(Monitor *mon, const QDict *qdict);
> +void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/qapi/replay.json b/qapi/replay.json
> index d7e76cf..a63219c 100644
> --- a/qapi/replay.json
> +++ b/qapi/replay.json
> @@ -63,3 +63,39 @@
>  ##
>  { 'command': 'query-replay',
>    'returns': 'ReplayInfo' }
> +
> +##
> +# @replay-break:
> +#
> +# Set breakpoint on the step of the replay specified by @icount.
> +# Execution stops when the specified @icount is reached.
> +# icount for the reference may be obtained with @query-replay command.
> +# There could be at most one breakpoint. When breakpoint is set, the prior
> +# one is removed. The breakpoints may be set only in replay mode and only
> +# at the step in the future.

My comment on hmp-commands.hx applies.

> +#
> +# @icount: execution step to stop at

s/execution step/instruction count/

> +#
> +# Since: 4.0
> +#
> +# Example:
> +#
> +# -> { "execute": "replay-break", "data": { "icount": 220414 } }
> +#
> +##
> +{ 'command': 'replay-break', 'data': { 'icount': 'int' } }
> +
> +##
> +# @replay-delete-break:
> +#
> +# Removes replay breakpoint which was set with @replay-break.
> +# The command is ignored when there are no replay breakpoints.
> +#
> +# Since: 4.0
> +#
> +# Example:
> +#
> +# -> { "execute": "replay-delete-break" }
> +#
> +##
> +{ 'command': 'replay-delete-break' }
[...]

We're down to phrasing help and documentation.  Almost done :)
