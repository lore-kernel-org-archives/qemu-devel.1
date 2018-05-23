Received: from eggs.gnu.org ([2001:4830:134:3::10]:55195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fLTk3-0002D0-4P
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fLTk1-0002oB-Ri
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:23:47 -0400
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:36400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1fLTk1-0002my-LP
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:23:45 -0400
Received: by mail-it0-x229.google.com with SMTP id e20-v6so4302056itc.1
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 06:23:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180523064941.26016.74274.stgit@pasha-VirtualBox>
References: <20180523064941.26016.74274.stgit@pasha-VirtualBox>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Wed, 23 May 2018 14:23:24 +0100
Message-ID: <CAFXrp_fOpwvT0qOZO+L+5LJJvGsj3bXp_GxhbLt-mZN9cN2nPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/19] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, May 23, 2018 at 7:49 AM, Pavel Dovgalyuk
<Pavel.Dovgaluk@ispras.ru> wrote:
> GDB remote protocol supports reverse debugging of the targets.
> It includes 'reverse step' and 'reverse continue' operations.
> The first one finds the previous step of the execution,
> and the second one is intended to stop at the last breakpoint that
> would happen when the program is executed normally.
>
> Reverse debugging is possible in the replay mode, when at least
> one snapshot was created at the record or replay phase.
> QEMU can use these snapshots for travelling back in time with GDB.
>
> Running the execution in replay mode allows using GDB reverse debugging
> commands:
>  - reverse-stepi (or rsi): Steps one instruction to the past.
>    QEMU loads on of the prior snapshots and proceeds to the desired
>    instruction forward. When that step is reaches, execution stops.
>  - reverse-continue (or rc): Runs execution "backwards".
>    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
>    and replaying the execution. Then QEMU loads snapshots again and
>    replays to the latest breakpoint. When there are no breakpoints in
>    the examined section of the execution, QEMU finds one more snapshot
>    and tries again. After the first snapshot is processed, execution
>    stops at this snapshot.
>
> The set of patches include the following modifications:
>  - gdbstub update for reverse debugging support
>  - functions that automatically perform reverse step and reverse
>    continue operations
>  - hmp/qmp commands for manipulating the replay process
>  - improvement of the snapshotting for saving the execution step
>    in the snapshot parameters
>  - other record/replay fixes
>
> The patches are available in the repository:
> https://github.com/ispras/qemu/tree/rr-180428
>

This branch appears to contain one month old commits, is it the correct one?

> v3 changes:
>  - Fixed PS/2 bug with save/load vm, which caused failures of the replay.
>    The patch was sent separately.
>  - Rebased to the new code base.
>  - Minor fixes.
>
> v2 changes:
>  - documented reverse debugging
>  - fixed start vmstate loading in record mode
>  - documented qcow2 changes (as suggested by Eric Blake)
>  - made icount SnapshotInfo field optional (as suggested by Eric Blake)
>  - renamed qmp commands (as suggested by Eric Blake)
>  - minor changes
>
> ---
>
> Pavel Dovgalyuk (19):
>       block: implement bdrv_snapshot_goto for blkreplay
>       replay: disable default snapshot for record/replay
>       replay: update docs for record/replay with block devices
>       replay: don't drain/flush bdrv queue while RR is working
>       replay: finish record/replay before closing the disks
>       qcow2: introduce icount field for snapshots
>       migration: introduce icount field for snapshots
>       replay: introduce info hmp/qmp command
>       replay: introduce breakpoint at the specified step
>       replay: implement replay-seek command to proceed to the desired step
>       replay: flush events when exiting
>       timer: remove replay clock probe in deadline calculation
>       replay: refine replay-time module
>       translator: fix breakpoint processing
>       replay: flush rr queue before loading the vmstate
>       gdbstub: add reverse step support in replay mode
>       gdbstub: add reverse continue support in replay mode
>       replay: describe reverse debugging in docs/replay.txt
>       replay: allow loading any snapshots before recording
>
>
>  accel/tcg/translator.c    |    9 +
>  block/blkreplay.c         |    8 +
>  block/io.c                |   22 +++
>  block/qapi.c              |   17 ++-
>  block/qcow2-snapshot.c    |    9 +
>  block/qcow2.h             |    2
>  blockdev.c                |   10 ++
>  cpus.c                    |   19 ++-
>  docs/interop/qcow2.txt    |    4 +
>  docs/replay.txt           |   45 +++++++
>  exec.c                    |    6 +
>  gdbstub.c                 |   50 +++++++-
>  hmp-commands-info.hx      |   14 ++
>  hmp-commands.hx           |   30 +++++
>  hmp.h                     |    3
>  include/block/snapshot.h  |    1
>  include/sysemu/replay.h   |   18 +++
>  migration/savevm.c        |   15 +-
>  qapi/block-core.json      |    5 +
>  qapi/block.json           |    3
>  qapi/misc.json            |   68 +++++++++++
>  replay/Makefile.objs      |    3
>  replay/replay-debugging.c |  287 +++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay-events.c    |   14 --
>  replay/replay-internal.h  |   10 +-
>  replay/replay-snapshot.c  |   17 ++-
>  replay/replay-time.c      |   27 ++--
>  replay/replay.c           |   22 +++
>  stubs/replay.c            |   10 ++
>  util/qemu-timer.c         |   11 --
>  vl.c                      |   18 ++-
>  31 files changed, 696 insertions(+), 81 deletions(-)
>  create mode 100644 replay/replay-debugging.c
>
> --
> Pavel Dovgalyuk
