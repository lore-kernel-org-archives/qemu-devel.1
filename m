Received: from eggs.gnu.org ([209.51.188.92]:58616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk7md-0000Px-Tq
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk7fE-0008OD-QT
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:24:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gk7fE-0008Jb-I8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:24:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
	<20190117073758.5399.16268.stgit@pasha-VirtualBox>
Date: Thu, 17 Jan 2019 14:24:42 +0100
In-Reply-To: <20190117073758.5399.16268.stgit@pasha-VirtualBox> (Pavel
	Dovgalyuk's message of "Thu, 17 Jan 2019 10:37:59 +0300")
Message-ID: <87tvi72z8l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 12/24] replay: introduce breakpoint at
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
> v10:
>  - updated descriptions (suggested by Markus Armbruster)
> ---
>  hmp-commands.hx           |   34 ++++++++++++++++++
>  hmp.h                     |    2 +
>  qapi/replay.json          |   36 +++++++++++++++++++
>  replay/replay-debugging.c |   86 +++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay-internal.h  |    4 ++
>  replay/replay.c           |   17 +++++++++
>  6 files changed, 179 insertions(+)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index ba71558..d529f24 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1890,6 +1890,40 @@ Set QOM property @var{property} of object at location @var{path} to value @var{v
>  ETEXI
>  
>      {
> +        .name       = "replay_break",
> +        .args_type  = "icount:i",
> +        .params     = "icount",
> +        .help       = "set breakpoint at the specified instruction count",
> +        .cmd        = hmp_replay_break,
> +    },
> +
> +STEXI
> +@item replay_break @var{icount}
> +@findex replay_break
> +Set replay breakpoint at instruction count @var{icount}.
> +Execution stops when the specified instruction is reached.
> +There can be at most one breakpoint. When breakpoint is set, any prior
> +one is removed.  The breakpoint may be set only in replay mode and only
> +"in the future", i.e. at instruction counts greater than the current one.
> +The current instruction count can be observed with 'info replay'.
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
> index ef2fb4b..cb94991 100644
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
> +# Set replay breakpoint at instruction count @icount.
> +# Execution stops when the specified instruction is reached.
> +# There can be at most one breakpoint. When breakpoint is set, any prior
> +# one is removed.  The breakpoint may be set only in replay mode and only
> +# "in the future", i.e. at instruction counts greater than the current one.
> +# The current instruction count can be observed with @query-replay.
> +#
> +# @icount: instruction count to stop at
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
> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> index 51f1c4d..a94685e 100644
> --- a/replay/replay-debugging.c
> +++ b/replay/replay-debugging.c
> @@ -16,6 +16,8 @@
>  #include "hmp.h"
>  #include "monitor/monitor.h"
>  #include "qapi/qapi-commands-replay.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qemu/timer.h"
>  
>  void hmp_info_replay(Monitor *mon, const QDict *qdict)
>  {
> @@ -41,3 +43,87 @@ ReplayInfo *qmp_query_replay(Error **errp)
>      retval->icount = replay_get_current_step();
>      return retval;
>  }
> +
> +static void replay_break(uint64_t icount, QEMUTimerCB callback, void *opaque)
> +{
> +    assert(replay_mode == REPLAY_MODE_PLAY);
> +    assert(replay_mutex_locked());
> +    assert(replay_break_icount >= replay_get_current_step());

The identifier replay_get_current_step() is one of the few remaining
instances of "step" terminology.  Whether to normalize them to "icount"
is entirely up to you.

> +    assert(callback);
> +
> +    replay_break_icount = icount;
> +
> +    if (replay_break_timer) {
> +        timer_del(replay_break_timer);
> +    } else {
> +        replay_break_timer = timer_new_ns(QEMU_CLOCK_REALTIME,
> +                                          callback, opaque);
> +    }
> +}
[...]

QAPI schema part
Acked-by: Markus Armbruster <armbru@redhat.com>
