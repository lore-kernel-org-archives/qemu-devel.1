Received: from eggs.gnu.org ([2001:4830:134:3::10]:45310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gByWO-0003qz-2U
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gByWG-0003WH-RT
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:46:36 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51082)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gByWC-0003Ok-Ov
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:46:29 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
In-Reply-To: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
Date: Mon, 15 Oct 2018 11:46:24 +0300
Message-ID: <001701d46463$8dff3680$a9fda380$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v7 00/19] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, war2jordan@live.com, mst@redhat.com, jasowang@redhat.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.com, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, kwolf@redhat.com, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru

Ping?

Paolo, what do you think about upstreaming this before soft freeze?

Pavel Dovgalyuk


> -----Original Message-----
> From: Pavel Dovgalyuk [mailto:Pavel.Dovgaluk@ispras.ru]
> Sent: Wednesday, October 10, 2018 4:34 PM
> To: qemu-devel@nongnu.org
> Cc: peter.maydell@linaro.org; war2jordan@live.com; pavel.dovgaluk@ispras.ru; mst@redhat.com;
> jasowang@redhat.com; zuban32s@gmail.com; kraxel@redhat.com; thomas.dullien@googlemail.com;
> artem.k.pisarenko@gmail.com; quintela@redhat.com; ciro.santilli@gmail.com; armbru@redhat.com;
> dovgaluk@ispras.ru; dgilbert@redhat.com; boost.lists@gmail.com; alex.bennee@linaro.org;
> rth@twiddle.net; kwolf@redhat.com; crosthwaite.peter@gmail.com; mreitz@redhat.com;
> maria.klimushenkova@ispras.ru; pbonzini@redhat.com
> Subject: [PATCH v7 00/19] Fixing record/replay and adding reverse debugging
> 
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
> https://github.com/ispras/qemu/tree/rr-181010
> 
> v7 changes:
>  - rebased to the new master with upstreamed patches from the series
>  - several improvements in hmp/qmp commands handling (suggested by Markus Armbruster)
>  - fixed record/replay with '-rtc base' option enabled
>  - added document with virtual hardware requirements
> 
> v6 changes:
>  - rebased to the new version of master
>  - fixed build of linux-user configurations
>  - added new clock for slirp and vnc timers
> 
> v5 changes:
>  - multiple fixes of record/replay bugs appeared after QEMU core update
>  - changed reverse debugging to 'since 3.1'
> 
> v4 changes:
>  - changed 'since 2.13' to 'since 3.0' in json (as suggested by Eric Blake)
> 
> v3 changes:
>  - Fixed PS/2 bug with save/load vm, which caused failures of the replay.
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
>       replay: provide and accessor for rr filename
>       replay: introduce info hmp/qmp command
>       replay: introduce breakpoint at the specified step
>       replay: implement replay-seek command to proceed to the desired step
>       replay: refine replay-time module
>       replay: flush rr queue before loading the vmstate
>       gdbstub: add reverse step support in replay mode
>       gdbstub: add reverse continue support in replay mode
>       replay: describe reverse debugging in docs/replay.txt
>       replay: add BH oneshot event for block layer
>       replay: init rtc after enabling the replay
>       replay: document development rules
> 
> 
>  accel/tcg/translator.c    |    1
>  block/blkreplay.c         |    8 +
>  block/block-backend.c     |    3
>  block/io.c                |   22 +++
>  block/qapi.c              |   17 ++
>  block/qcow2-snapshot.c    |    9 +
>  block/qcow2.h             |    2
>  blockdev.c                |   10 +
>  cpus.c                    |   19 ++-
>  docs/devel/replay.txt     |   45 ++++++
>  docs/interop/qcow2.txt    |    4 +
>  docs/replay.txt           |   45 ++++++
>  exec.c                    |    6 +
>  gdbstub.c                 |   50 +++++++
>  hmp-commands-info.hx      |   14 ++
>  hmp-commands.hx           |   44 ++++++
>  hmp.h                     |    4 +
>  include/block/snapshot.h  |    1
>  include/sysemu/replay.h   |   20 +++
>  migration/savevm.c        |   15 +-
>  qapi/block-core.json      |    7 +
>  qapi/block.json           |    3
>  qapi/misc.json            |   77 +++++++++++
>  replay/Makefile.objs      |    3
>  replay/replay-debugging.c |  319 +++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay-events.c    |   16 ++
>  replay/replay-internal.h  |    7 +
>  replay/replay-time.c      |   32 ++---
>  replay/replay.c           |   26 ++++
>  stubs/Makefile.objs       |    1
>  stubs/replay-user.c       |    9 +
>  stubs/replay.c            |   10 +
>  vl.c                      |   22 ++-
>  33 files changed, 818 insertions(+), 53 deletions(-)
>  create mode 100644 docs/devel/replay.txt
>  create mode 100644 replay/replay-debugging.c
>  create mode 100644 stubs/replay-user.c
> 
> --
> Pavel Dovgalyuk
