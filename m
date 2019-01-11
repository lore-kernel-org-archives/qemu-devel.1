Received: from eggs.gnu.org ([209.51.188.92]:49908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghsAV-0002HO-Tl
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghsAU-0006jQ-Nk
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:27:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghsAU-0006ig-CL
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:27:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
	<154703594341.13472.10192138424843641646.stgit@pasha-VirtualBox>
Date: Fri, 11 Jan 2019 09:27:44 +0100
In-Reply-To: <154703594341.13472.10192138424843641646.stgit@pasha-VirtualBox>
	(Pavel Dovgalyuk's message of "Wed, 09 Jan 2019 15:12:23 +0300")
Message-ID: <87y37r8upr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 11/21] replay: introduce info hmp/qmp
 command
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

> This patch introduces 'info replay' monitor command and
> corresponding qmp request.
> These commands request the current record/replay mode, replay log file name,
> and the execution step (number or recorded/replayed instructions).

s/or/of/

> User may use step number for replay_seek/replay_break commands and
> for controlling the execution of replay.

Dangling reference: these two commands appear only in the next two
patches.  Suggest:

  These commands request the current record/replay mode, replay log file
  name, and the instruction count (number of recorded/replayed
  instructions).  The instruction count can be used with the
  replay_seek/replay_break commands added in the next two patches.

> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> --
>
> v2:
>  - renamed info_replay qmp into query-replay (suggested by Eric Blake)
> v7:
>  - added empty line (suggested by Markus Armbruster)
> v9:
>  - changed 'step' parameter name to 'icount'
>  - moved json stuff to replay.json and updated the descriptions
>    (suggested by Markus Armbruster)
> ---
>  hmp-commands-info.hx      |   14 ++++++++++++++
>  hmp.h                     |    1 +
>  qapi/replay.json          |   39 +++++++++++++++++++++++++++++++++++++++
>  replay/Makefile.objs      |    3 ++-
>  replay/replay-debugging.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 98 insertions(+), 1 deletion(-)
>  create mode 100644 replay/replay-debugging.c
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index cbee8b9..866bc0f 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -918,6 +918,20 @@ STEXI
>  Show SEV information.
>  ETEXI
>  
> +    {
> +        .name       = "replay",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show parameters of the record/replay",

Recommend "show record/replay information", because that's how you
document the underlying QMP command.

> +        .cmd        = hmp_info_replay,
> +    },
> +
> +STEXI
> +@item info replay
> +@findex info replay
> +Display the record/replay information: mode and the current icount.
> +ETEXI
> +
>  STEXI
>  @end table
>  ETEXI
> diff --git a/hmp.h b/hmp.h
> index 5f1addc..d792149 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -148,5 +148,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
>  void hmp_info_sev(Monitor *mon, const QDict *qdict);
> +void hmp_info_replay(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/qapi/replay.json b/qapi/replay.json
> index 9e13551..d7e76cf 100644
> --- a/qapi/replay.json
> +++ b/qapi/replay.json
> @@ -24,3 +24,42 @@
>  ##
>  { 'enum': 'ReplayMode',
>    'data': [ 'none', 'record', 'play' ] }
> +
> +##
> +# @ReplayInfo:
> +#
> +# Record/replay information.
> +#
> +# @mode: current mode.
> +#
> +# @filename: name of the record/replay log file.
> +#            It is present only in record or replay modes, when the log
> +#            is recorded or replayed.
> +#
> +# @icount: current number of executed instructions.
> +#
> +# Since: 4.0
> +#
> +##
> +{ 'struct': 'ReplayInfo',
> +  'data': { 'mode': 'ReplayMode', '*filename': 'str', 'icount': 'int' } }
> +
> +##
> +# @query-replay:
> +#
> +# Retrieves the record/replay information.
> +# It includes current icount which may be used for replay-break and
> +# replay-seek commands.

Let's say "current instruction count, which".

Dangling reference: these two commands appear only in the next two
patches.  Tolerable if the commit message spells it out.

> +#
> +# Returns: structure with the properties of the record/replay.

I'd simply say "Returns: record/replay information".

> +#
> +# Since: 4.0
> +#
> +# Example:
> +#
> +# -> { "execute": "query-replay" }
> +# <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
> +#
> +##
> +{ 'command': 'query-replay',
> +  'returns': 'ReplayInfo' }
> diff --git a/replay/Makefile.objs b/replay/Makefile.objs
> index cee6539..6694e3e 100644
> --- a/replay/Makefile.objs
> +++ b/replay/Makefile.objs
> @@ -6,4 +6,5 @@ common-obj-y += replay-input.o
>  common-obj-y += replay-char.o
>  common-obj-y += replay-snapshot.o
>  common-obj-y += replay-net.o
> -common-obj-y += replay-audio.o
> \ No newline at end of file
> +common-obj-y += replay-audio.o
> +common-obj-y += replay-debugging.o
> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> new file mode 100644
> index 0000000..9956405
> --- /dev/null
> +++ b/replay/replay-debugging.c

The file name suggests the instruction count is just for debugging.  If
that's true, the documentation should mention it.  Else, the file should
be named less misleadingly, perhaps replay-control.c.

> @@ -0,0 +1,42 @@
> +/*
> + * replay-debugging.c
> + *
> + * Copyright (c) 2010-2018 Institute for System Programming
> + *                         of the Russian Academy of Sciences.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "sysemu/replay.h"
> +#include "replay-internal.h"
> +#include "hmp.h"
> +#include "monitor/monitor.h"
> +#include "qapi/qapi-commands-replay.h"
> +
> +void hmp_info_replay(Monitor *mon, const QDict *qdict)
> +{
> +    if (replay_mode == REPLAY_MODE_NONE) {
> +        monitor_printf(mon, "No record/replay\n");

Perhaps something like "Record/replay not active" would be friendlier.

> +    } else {
> +        monitor_printf(mon, "%s execution '%s': current step = %"PRId64"\n",
> +            replay_mode == REPLAY_MODE_RECORD ? "Recording" : "Replaying",
> +            replay_get_filename(), replay_get_current_step());

You improved documentation to consistently say "instruction count".  The
code still calls it current_step.  So does the HMP UI here.  In your
shoes, I'd go all the way.  Consistent terminology really helps
readers.  Advice, not demand.

> +    }
> +}
> +
> +ReplayInfo *qmp_query_replay(Error **errp)
> +{
> +    ReplayInfo *retval = g_new0(ReplayInfo, 1);
> +
> +    retval->mode = replay_mode;
> +    if (replay_get_filename()) {
> +        retval->filename = g_strdup(replay_get_filename());
> +        retval->has_filename = true;
> +    }
> +    retval->icount = replay_get_current_step();
> +    return retval;
> +}

Looks almost ready.
