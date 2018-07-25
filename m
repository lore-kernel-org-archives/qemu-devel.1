Received: from eggs.gnu.org ([2001:4830:134:3::10]:53224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fiLDv-0008T1-D5
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fiLDs-0006ZW-FA
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:57:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fiLDs-0006W3-3X
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:57:04 -0400
Date: Wed, 25 Jul 2018 15:56:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180725145651.GC2365@work-vm>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121400.12867.82957.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725121400.12867.82957.stgit@pasha-VirtualBox>
Subject: Re: [Qemu-devel] [PATCH v5 08/24] replay: introduce info hmp/qmp
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, rth@twiddle.net

* Pavel Dovgalyuk (Pavel.Dovgaluk@ispras.ru) wrote:
> This patch introduces 'info replay' monitor command and
> corresponding qmp request.
> These commands request the current record/replay mode, replay log file name,
> and the execution step (number or recorded/replayed instructions).
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

ACK for HMP

Note you might want to make an accessor for the filename rather than
making it a global?

Dave

> 
> --
> 
> v2:
>  - renamed info_replay qmp into query-replay (suggested by Eric Blake)
> ---
>  hmp-commands-info.hx      |   14 ++++++++++++++
>  hmp.h                     |    1 +
>  qapi/misc.json            |   35 +++++++++++++++++++++++++++++++++++
>  replay/Makefile.objs      |    3 ++-
>  replay/replay-debugging.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  replay/replay-internal.h  |    2 ++
>  replay/replay.c           |    3 +--
>  7 files changed, 96 insertions(+), 3 deletions(-)
>  create mode 100644 replay/replay-debugging.c
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 70639f6..1b24714 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -896,6 +896,20 @@ STEXI
>  Show SEV information.
>  ETEXI
>  
> +    {
> +        .name       = "replay",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show parameters of the record/replay",
> +        .cmd        = hmp_info_replay,
> +    },
> +
> +STEXI
> +@item info replay
> +@findex info replay
> +Display the current record/replay mode and the currently executing step.
> +ETEXI
> +
>  STEXI
>  @end table
>  ETEXI
> diff --git a/hmp.h b/hmp.h
> index 33354f1..9d12c63 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -147,5 +147,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
>  void hmp_info_sev(Monitor *mon, const QDict *qdict);
> +void hmp_info_replay(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/qapi/misc.json b/qapi/misc.json
> index d450cfe..e246ce3 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -3100,6 +3100,41 @@
>    'data': [ 'none', 'record', 'play' ] }
>  
>  ##
> +# @ReplayInfo:
> +#
> +# Status of the record/replay mode.
> +#
> +# @mode: current mode.
> +#
> +# @filename: name of the record/replay log file.
> +#
> +# @step: current step number.
> +#
> +# Since: 3.1
> +#
> +##
> +{ 'struct': 'ReplayInfo',
> +  'data': { 'mode': 'ReplayMode', '*filename': 'str', 'step': 'int' } }
> +
> +##
> +# @query-replay:
> +#
> +# Retrieves the status of the execution record/replay.
> +#
> +# Returns: structure with the properties of the record/replay.
> +#
> +# Since: 3.1
> +#
> +# Example:
> +#
> +# -> { "execute": "query-replay" }
> +# <- { "return": { "mode": "play", "filename": "log.rr", "step": 220414 } }
> +#
> +##
> +{ 'command': 'query-replay',
> +  'returns': 'ReplayInfo' }
> +
> +##
>  # @xen-load-devices-state:
>  #
>  # Load the state of all devices from file. The RAM and the block devices
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
> index 0000000..03e7db8
> --- /dev/null
> +++ b/replay/replay-debugging.c
> @@ -0,0 +1,41 @@
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
> +#include "qapi/qapi-commands-misc.h"
> +
> +void hmp_info_replay(Monitor *mon, const QDict *qdict)
> +{
> +    if (replay_mode == REPLAY_MODE_NONE) {
> +        monitor_printf(mon, "No record/replay\n");
> +    } else {
> +        monitor_printf(mon, "%s execution '%s': current step = %"PRId64"\n",
> +            replay_mode == REPLAY_MODE_RECORD ? "Recording" : "Replaying",
> +            replay_filename, replay_get_current_step());
> +    }
> +}
> +
> +ReplayInfo *qmp_query_replay(Error **errp)
> +{
> +    ReplayInfo *retval = g_new0(ReplayInfo, 1);
> +    retval->mode = replay_mode;
> +    if (replay_filename) {
> +        retval->filename = g_strdup(replay_filename);
> +        retval->has_filename = true;
> +    }
> +    retval->step = replay_get_current_step();
> +    return retval;
> +}
> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> index ac4b27b..ef82b5e 100644
> --- a/replay/replay-internal.h
> +++ b/replay/replay-internal.h
> @@ -91,6 +91,8 @@ extern ReplayState replay_state;
>  
>  /* File for replay writing */
>  extern FILE *replay_file;
> +/*! Name of replay file  */
> +extern char *replay_filename;
>  
>  void replay_put_byte(uint8_t byte);
>  void replay_put_event(uint8_t event);
> diff --git a/replay/replay.c b/replay/replay.c
> index 58a986f..8b70d7d 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -29,8 +29,7 @@
>  ReplayMode replay_mode = REPLAY_MODE_NONE;
>  char *replay_snapshot;
>  
> -/* Name of replay file  */
> -static char *replay_filename;
> +char *replay_filename;
>  ReplayState replay_state;
>  static GSList *replay_blockers;
>  
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
