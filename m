Received: from eggs.gnu.org ([2001:4830:134:3::10]:36616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fnBAm-0001w7-4z
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 19:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fnBAj-0003xH-G5
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 19:13:52 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1fnBAj-0003wi-52
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 19:13:49 -0400
Received: by mail-it0-x244.google.com with SMTP id d70-v6so451727ith.1
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 16:13:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Wed, 8 Aug 2018 00:13:27 +0100
Message-ID: <CAFXrp_dgDh+YG2_3rF9sqWr4Tr15Mc7yip=0rQzAYGTcOeyMOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 00/24] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

OK, finally got some time to try it out, I'm using
c42634d8e3428cfa60672c3ba89cabefc720cde9 from rr-180725.

Replay works well as far as I can tell, so I moved to the reverse debugging:

/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_
64/buildroot/build/host-qemu-custom.rr/x86_64-softmmu/qemu-system-x86_64 \
-M pc \
-append 'root=/dev/sda nopat console_msg_format=syslog nokaslr norandmaps
printk.devkmsg=on printk.time=y console=ttyS0 -  lkmc_eval_base64="
L3JhbmRfY2hlY2sub3V0Oy9wb3dlcm9mZi5vdXQ7"' \
-kernel '/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_
64/buildroot/build/linux-custom.default/arch/x86/boot/bzImage' \
-m '256M' \
-monitor 'telnet::45454,server,nowait' \
-nographic \
-serial mon:stdio \
-smp '1' \
\
-drive 'file=/home/ciro/bak/git/linux-kernel-module-cheat/out/
x86_64/buildroot/images/rootfs.ext2.qcow2,format=qcow2,if=none,id=img-direct'
\
-drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
-device ide-hd,drive=img-blkreplay \
\
-object filter-replay,id=replay,netdev=net0 \
-device rtl8139,netdev=net0 \
-netdev 'user,hostfwd=tcp::45455-:45455,hostfwd=tcp::45456-:22,id=net0' \
\
-icount 'shift=7,rr=record,rrfile=/home/ciro/bak/git/linux-
kernel-module-cheat/out/x86_64/qemu/0/rrfile' \

and replay with:

-icount 'shift=7,rr=replay,rrfile=/home/ciro/bak/git/linux-
kernel-module-cheat/out/x86_64/qemu/0/rrfile' \
-gdb 'tcp::45457' \
-S \

Then, I do

/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_
64/buildroot/host/usr/bin/x86_64-linux-gdb \
 -q \
-ex 'add-auto-load-safe-path /home/ciro/bak/git/linux-kernel-module-cheat' \
-ex 'file vmlinux' \
-ex 'target remote localhost:45457' \
-ex 'break start_kernel' \
  -ex continue \
-ex 'lx-symbols ../kernel_module-1.0/' \

Then in GDB:

n
n
n
n
reverse-continue

expecting it to return me to start_kernel, but instead it left me in the
same place that I'm at.

I also tried to manually checkpoint from qemu monitor at the very start,
but it didn't change anything.

bzImage at: https://github.com/cirosantilli/linux-kernel-
module-cheat/releases/download/sha-19f4d00f9b13aa67369e32ec7cd351
8950c6f30e/bzImage and docs at: https://github.com/
cirosantilli/linux-kernel-module-cheat/tree/19f4d00f9b13aa67369e32ec7cd351
8950c6f30e#qemu-record-and-replay


On Wed, Jul 25, 2018 at 1:13 PM, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
wrote:

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
>  - fixes of record/replay caused by the QEMU core changes
>  - gdbstub update for reverse debugging support
>  - functions that automatically perform reverse step and reverse
>    continue operations
>  - hmp/qmp commands for manipulating the replay process
>  - improvement of the snapshotting for saving the execution step
>    in the snapshot parameters
>  - other record/replay fixes
>
> The patches are available in the repository:
> https://github.com/ispras/qemu/tree/rr-180725
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
> Pavel Dovgalyuk (24):
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
>       ps2: prevent changing irq state on save and load
>       replay: wake up vCPU when replaying
>       replay: replay BH for IDE trim operation
>       replay: add BH oneshot event for block layer
>       slirp: fix ipv6 timers
>
>
>  accel/tcg/translator.c    |    9 +
>  block/blkreplay.c         |    8 +
>  block/block-backend.c     |    3
>  block/io.c                |   22 +++
>  block/qapi.c              |   17 ++-
>  block/qcow2-snapshot.c    |    9 +
>  block/qcow2.h             |    2
>  blockdev.c                |   10 ++
>  cpus.c                    |   50 +++++---
>  docs/interop/qcow2.txt    |    4 +
>  docs/replay.txt           |   45 +++++++
>  exec.c                    |    6 +
>  gdbstub.c                 |   50 +++++++-
>  hmp-commands-info.hx      |   14 ++
>  hmp-commands.hx           |   30 +++++
>  hmp.h                     |    3
>  hw/ide/core.c             |    3
>  hw/input/ps2.c            |    8 +
>  include/block/snapshot.h  |    1
>  include/sysemu/replay.h   |   24 ++++
>  migration/savevm.c        |   15 +-
>  qapi/block-core.json      |    5 +
>  qapi/block.json           |    3
>  qapi/misc.json            |   68 +++++++++++
>  replay/Makefile.objs      |    3
>  replay/replay-debugging.c |  287 ++++++++++++++++++++++++++++++
> +++++++++++++++
>  replay/replay-events.c    |   30 +++--
>  replay/replay-internal.h  |   11 +-
>  replay/replay-snapshot.c  |   17 ++-
>  replay/replay-time.c      |   27 ++--
>  replay/replay.c           |   36 +++++-
>  slirp/ip6_icmp.c          |    6 -
>  stubs/replay.c            |   16 +++
>  util/qemu-timer.c         |   11 --
>  vl.c                      |   18 ++-
>  35 files changed, 772 insertions(+), 99 deletions(-)
>  create mode 100644 replay/replay-debugging.c
>
> --
> Pavel Dovgalyuk
>
