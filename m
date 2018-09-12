Received: from eggs.gnu.org ([2001:4830:134:3::10]:46921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00LU-0000Co-No
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00LP-0007rS-MP
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:17:56 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55602)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00LP-0007qZ-80
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:17:51 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 12 Sep 2018 11:17:48 +0300
Message-ID: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 00/25] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

GDB remote protocol supports reverse debugging of the targets.
It includes 'reverse step' and 'reverse continue' operations.
The first one finds the previous step of the execution,
and the second one is intended to stop at the last breakpoint that
would happen when the program is executed normally.

Reverse debugging is possible in the replay mode, when at least
one snapshot was created at the record or replay phase.
QEMU can use these snapshots for travelling back in time with GDB.

Running the execution in replay mode allows using GDB reverse debugging
commands:
 - reverse-stepi (or rsi): Steps one instruction to the past.
   QEMU loads on of the prior snapshots and proceeds to the desired
   instruction forward. When that step is reaches, execution stops.
 - reverse-continue (or rc): Runs execution "backwards".
   QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
   and replaying the execution. Then QEMU loads snapshots again and
   replays to the latest breakpoint. When there are no breakpoints in
   the examined section of the execution, QEMU finds one more snapshot
   and tries again. After the first snapshot is processed, execution
   stops at this snapshot.

The set of patches include the following modifications:
 - fixes of record/replay caused by the QEMU core changes
 - gdbstub update for reverse debugging support
 - functions that automatically perform reverse step and reverse
   continue operations
 - hmp/qmp commands for manipulating the replay process
 - improvement of the snapshotting for saving the execution step
   in the snapshot parameters
 - adding new clock for correct timer events from vnc and slirp
 - other record/replay fixes

The patches are available in the repository:
https://github.com/ispras/qemu/tree/rr-180911

v6 changes:
 - rebased to the new version of master
 - fixed build of linux-user configurations
 - added new clock for slirp and vnc timers

v5 changes:
 - multiple fixes of record/replay bugs appeared after QEMU core update
 - changed reverse debugging to 'since 3.1'

v4 changes:
 - changed 'since 2.13' to 'since 3.0' in json (as suggested by Eric Blake)

v3 changes:
 - Fixed PS/2 bug with save/load vm, which caused failures of the replay.
 - Rebased to the new code base.
 - Minor fixes.

v2 changes:
 - documented reverse debugging
 - fixed start vmstate loading in record mode
 - documented qcow2 changes (as suggested by Eric Blake)
 - made icount SnapshotInfo field optional (as suggested by Eric Blake)
 - renamed qmp commands (as suggested by Eric Blake)
 - minor changes

---

Pavel Dovgalyuk (25):
      block: implement bdrv_snapshot_goto for blkreplay
      replay: disable default snapshot for record/replay
      replay: update docs for record/replay with block devices
      replay: don't drain/flush bdrv queue while RR is working
      replay: finish record/replay before closing the disks
      qcow2: introduce icount field for snapshots
      migration: introduce icount field for snapshots
      replay: provide and accessor for rr filename
      replay: introduce info hmp/qmp command
      replay: introduce breakpoint at the specified step
      replay: implement replay-seek command to proceed to the desired step
      replay: flush events when exiting
      replay: refine replay-time module
      translator: fix breakpoint processing
      replay: flush rr queue before loading the vmstate
      gdbstub: add reverse step support in replay mode
      gdbstub: add reverse continue support in replay mode
      replay: describe reverse debugging in docs/replay.txt
      replay: allow loading any snapshots before recording
      replay: wake up vCPU when replaying
      replay: replay BH for IDE trim operation
      replay: add BH oneshot event for block layer
      timer: introduce new virtual clock
      slirp: fix ipv6 timers
      ui: fix virtual timers


 accel/tcg/translator.c    |    9 +
 block/blkreplay.c         |    8 +
 block/block-backend.c     |    3 
 block/io.c                |   22 +++
 block/qapi.c              |   17 ++-
 block/qcow2-snapshot.c    |    9 +
 block/qcow2.h             |    2 
 blockdev.c                |   10 ++
 cpus.c                    |   50 +++++---
 docs/interop/qcow2.txt    |    4 +
 docs/replay.txt           |   45 +++++++
 exec.c                    |    6 +
 gdbstub.c                 |   50 +++++++-
 hmp-commands-info.hx      |   14 ++
 hmp-commands.hx           |   30 +++++
 hmp.h                     |    3 
 hw/ide/core.c             |    3 
 include/block/snapshot.h  |    1 
 include/qemu/timer.h      |    9 +
 include/sysemu/replay.h   |   26 ++++
 migration/savevm.c        |   15 +-
 qapi/block-core.json      |    5 +
 qapi/block.json           |    3 
 qapi/misc.json            |   68 +++++++++++
 replay/Makefile.objs      |    3 
 replay/replay-debugging.c |  287 +++++++++++++++++++++++++++++++++++++++++++++
 replay/replay-events.c    |   30 +++--
 replay/replay-internal.h  |    9 +
 replay/replay-snapshot.c  |   17 ++-
 replay/replay-time.c      |   32 ++---
 replay/replay.c           |   38 ++++++
 slirp/ip6_icmp.c          |    7 +
 stubs/Makefile.objs       |    1 
 stubs/replay-user.c       |    9 +
 stubs/replay.c            |   10 ++
 ui/input.c                |    8 +
 util/qemu-timer.c         |    2 
 vl.c                      |   18 ++-
 38 files changed, 791 insertions(+), 92 deletions(-)
 create mode 100644 replay/replay-debugging.c
 create mode 100644 stubs/replay-user.c

-- 
Pavel Dovgalyuk
