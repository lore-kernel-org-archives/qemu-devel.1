Received: from eggs.gnu.org ([2001:4830:134:3::10]:42561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fH3TI-0005Zb-0A
	for qemu-devel@nongnu.org; Fri, 11 May 2018 04:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fH3TD-0003aA-QQ
	for qemu-devel@nongnu.org; Fri, 11 May 2018 04:32:11 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45516)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fH3TD-0003Zg-Cs
	for qemu-devel@nongnu.org; Fri, 11 May 2018 04:32:07 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180428123627.12445.9923.stgit@pasha-VirtualBox>
	<CAFXrp_duRj1rZ6Opffa3ihw+zou6B+oPn3g2BNRPSEgB7F_P8Q@mail.gmail.com>
In-Reply-To: <CAFXrp_duRj1rZ6Opffa3ihw+zou6B+oPn3g2BNRPSEgB7F_P8Q@mail.gmail.com>
Date: Fri, 11 May 2018 11:32:01 +0300
Message-ID: <002101d3e902$891ad5c0$9b508140$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/19] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Ciro Santilli' <ciro.santilli@gmail.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, 'QEMU Developers' <qemu-devel@nongnu.org>

> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
> Did you manage to reproduce and solve the savevm and loadvm problems I
> mentioned at: http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg05219.html
> ?

I've tried to debug your scenario and found a bug in saving/loading PS/2 
keyboard state.

Here is the patch for fixing it: https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02518.html

Maybe it will help for your debugging scenario.

Pavel Dovgalyuk

> 
> I still observe them on the current patch.
> 
> On Sat, Apr 28, 2018 at 1:36 PM, Pavel Dovgalyuk
> <Pavel.Dovgaluk@ispras.ru> wrote:
> > GDB remote protocol supports reverse debugging of the targets.
> > It includes 'reverse step' and 'reverse continue' operations.
> > The first one finds the previous step of the execution,
> > and the second one is intended to stop at the last breakpoint that
> > would happen when the program is executed normally.
> >
> > Reverse debugging is possible in the replay mode, when at least
> > one snapshot was created at the record or replay phase.
> > QEMU can use these snapshots for travelling back in time with GDB.
> >
> > Running the execution in replay mode allows using GDB reverse debugging
> > commands:
> >  - reverse-stepi (or rsi): Steps one instruction to the past.
> >    QEMU loads on of the prior snapshots and proceeds to the desired
> >    instruction forward. When that step is reaches, execution stops.
> >  - reverse-continue (or rc): Runs execution "backwards".
> >    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
> >    and replaying the execution. Then QEMU loads snapshots again and
> >    replays to the latest breakpoint. When there are no breakpoints in
> >    the examined section of the execution, QEMU finds one more snapshot
> >    and tries again. After the first snapshot is processed, execution
> >    stops at this snapshot.
> >
> > The set of patches include the following modifications:
> >  - gdbstub update for reverse debugging support
> >  - functions that automatically perform reverse step and reverse
> >    continue operations
> >  - hmp/qmp commands for manipulating the replay process
> >  - improvement of the snapshotting for saving the execution step
> >    in the snapshot parameters
> >  - other record/replay fixes
> >
> > The patches are available in the repository:
> > https://github.com/ispras/qemu/tree/rr-180428
> >
> > v2 changes:
> >  - documented reverse debugging
> >  - fixed start vmstate loading in record mode
> >  - documented qcow2 changes (as suggested by Eric Blake)
> >  - made icount SnapshotInfo field optional (as suggested by Eric Blake)
> >  - renamed qmp commands (as suggested by Eric Blake)
> >  - minor changes
> >
> > ---
> >
> > Pavel Dovgalyuk (19):
> >       block: implement bdrv_snapshot_goto for blkreplay
> >       replay: disable default snapshot for record/replay
> >       replay: update docs for record/replay with block devices
> >       replay: don't drain/flush bdrv queue while RR is working
> >       replay: finish record/replay before closing the disks
> >       qcow2: introduce icount field for snapshots
> >       migration: introduce icount field for snapshots
> >       replay: introduce info hmp/qmp command
> >       replay: introduce breakpoint at the specified step
> >       replay: implement replay-seek command to proceed to the desired step
> >       replay: flush events when exitting
> >       timer: remove replay clock probe in deadline calculation
> >       replay: refine replay-time module
> >       translator: fix breakpoint processing
> >       replay: flush rr queue before loading the vmstate
> >       gdbstub: add reverse step support in replay mode
> >       gdbstub: add reverse continue support in replay mode
> >       replay: describe reverse debugging in docs/replay.txt
> >       replay: allow loading any snapshots before recording
> >
> >
> >  accel/tcg/translator.c    |    8 +
> >  block/blkreplay.c         |    8 +
> >  block/io.c                |   22 +++
> >  block/qapi.c              |   17 ++-
> >  block/qcow2-snapshot.c    |    9 +
> >  block/qcow2.h             |    2
> >  blockdev.c                |   10 ++
> >  cpus.c                    |   19 ++-
> >  docs/interop/qcow2.txt    |    4 +
> >  docs/replay.txt           |   45 +++++++
> >  exec.c                    |    6 +
> >  gdbstub.c                 |   50 +++++++-
> >  hmp-commands-info.hx      |   14 ++
> >  hmp-commands.hx           |   30 +++++
> >  hmp.h                     |    3
> >  include/block/snapshot.h  |    1
> >  include/sysemu/replay.h   |   18 +++
> >  migration/savevm.c        |   15 +-
> >  qapi/block-core.json      |    5 +
> >  qapi/block.json           |    3
> >  qapi/misc.json            |   68 +++++++++++
> >  replay/Makefile.objs      |    3
> >  replay/replay-debugging.c |  287 +++++++++++++++++++++++++++++++++++++++++++++
> >  replay/replay-events.c    |   14 --
> >  replay/replay-internal.h  |   10 +-
> >  replay/replay-snapshot.c  |   17 ++-
> >  replay/replay-time.c      |   27 ++--
> >  replay/replay.c           |   22 +++
> >  stubs/replay.c            |   10 ++
> >  util/qemu-timer.c         |   11 --
> >  vl.c                      |   18 ++-
> >  31 files changed, 695 insertions(+), 81 deletions(-)
> >  create mode 100644 replay/replay-debugging.c
> >
> > --
> > Pavel Dovgalyuk
