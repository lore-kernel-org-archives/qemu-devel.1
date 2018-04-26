Received: from eggs.gnu.org ([2001:4830:134:3::10]:33949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fBfu7-00017D-A1
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fBfu5-0004dM-Py
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:21:39 -0400
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:34322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1fBfu5-0004dC-JV
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:21:37 -0400
Received: by mail-io0-x235.google.com with SMTP id p124-v6so5544219iod.1
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 05:21:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Thu, 26 Apr 2018 13:21:15 +0100
Message-ID: <CAFXrp_f-r4+G1BOVaCh9a6kzR45rnqgvq5UEnMzNjfHB=BDBCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 00/17] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, war2jordan@live.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor R <boost.lists@gmail.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, armbru@redhat.com, maria.klimushenkova@ispras.ru, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Dullien <thomas.dullien@googlemail.com>, Paolo Bonzini <pbonzini@redhat.com>, mreitz@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, dgilbert@redhat.com, rth@twiddle.net

On Wed, Apr 25, 2018 at 1:45 PM, Pavel Dovgalyuk
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

Hi Pavel,

1)

Can you provide more details on how to run the reverse debugging? In
particular how to take the checkpoint?

My test setup is described in detail at:
https://github.com/cirosantilli/qemu-test/tree/8127452e5685ed233dc7357a1fe34b7a2d173480
command "x86_64/reverse-debug".

Here are the actual commands:

#!/usr/bin/env bash
set -eu
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
cmd="\
time \
./x86_64-softmmu/qemu-system-x86_64 \
-M pc \
-append 'root=/dev/sda console=ttyS0 nokaslr printk.time=y -
lkmc_eval=\"/rand_check.out;/sbin/ifup -a;wget -S
google.com;/poweroff.out;\"' \
-kernel '${dir}/out/x86_64/buildroot/images/bzImage' \
-nographic \
-serial mon:stdio \
-monitor telnet::45454,server,nowait \
\
-drive file='${dir}/out/x86_64/buildroot/images/rootfs.ext2.qcow2,if=none,id=img-direct,format=qcow2,snapshot'
\
-drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
-device ide-hd,drive=img-blkreplay \
\
-netdev user,id=net1 \
-device rtl8139,netdev=net1 \
-object filter-replay,id=replay,netdev=net1 \
"
cmd="${cmd} $@"
echo "$cmd"
eval "$cmd -icount 'shift=7,rr=record,rrfile=replay.bin'"
eval "$cmd -icount 'shift=7,rr=replay,rrfile=replay.bin' -S -s"

Then I take a snapshot right at the beginning of the execution:

telnet 45454
savevm a

And on another shell:

/data/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/usr/bin/x86_64-linux-gdb
\
-q \
-ex 'file vmlinux' \
-ex 'target remote localhost:1234' \
-ex 'break start_kernel' \
-ex 'continue' \

But now if I try on GDB:

next
next
next
reverse-continue

hoping to go back to start_kernel, but nothing happens.

Same behavior if I take the snapshot after reaching start_kernel instead.

2)

I wonder if it would be possible to expose checkpoint taking through
GDB example via:
https://sourceware.org/gdb/onlinedocs/gdb/Checkpoint_002fRestart.html

Or some other more convenient checkpoint generation method, e.g.
automatically take checkpoints every N instructions.

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
> https://github.com/ispras/qemu/tree/rr-180207
>
> ---
>
> Pavel Dovgalyuk (17):
>       block: implement bdrv_snapshot_goto for blkreplay
>       replay: disable default snapshot for record/replay
>       replay: update docs for record/replay with block devices
>       replay: don't drain/flush bdrv queue while RR is working
>       replay: finish record/replay before closing the disks
>       migration: introduce icount field for snapshots
>       qcow2: introduce icount field for snapshots
>       replay: introduce info hmp/qmp command
>       replay: introduce breakpoint at the specified step
>       replay: implement replay_seek command to proceed to the desired step
>       replay: flush events when exitting
>       timer: remove replay clock probe in deadline calculation
>       replay: refine replay-time module
>       translator: fix breakpoint processing
>       replay: flush rr queue before loading the vmstate
>       gdbstub: add reverse step support in replay mode
>       gdbstub: add reverse continue support in replay mode
>
>
>  accel/tcg/translator.c    |    8 +
>  block/blkreplay.c         |    8 +
>  block/io.c                |   22 +++
>  block/qapi.c              |   11 +-
>  block/qcow2-snapshot.c    |    9 +
>  block/qcow2.h             |    2
>  blockdev.c                |    3
>  cpus.c                    |   19 ++-
>  docs/replay.txt           |   12 +-
>  exec.c                    |    6 +
>  gdbstub.c                 |   50 +++++++-
>  hmp-commands-info.hx      |   14 ++
>  hmp-commands.hx           |   30 +++++
>  hmp.h                     |    3
>  include/block/snapshot.h  |    1
>  include/sysemu/replay.h   |   18 +++
>  migration/savevm.c        |   11 +-
>  qapi/block-core.json      |    5 +
>  qapi/block.json           |    3
>  qapi/misc.json            |   69 +++++++++++
>  replay/Makefile.objs      |    3
>  replay/replay-debugging.c |  286 +++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay-events.c    |   14 --
>  replay/replay-internal.h  |   10 +-
>  replay/replay-time.c      |   27 ++--
>  replay/replay.c           |   22 +++
>  stubs/replay.c            |   10 ++
>  util/qemu-timer.c         |   11 --
>  vl.c                      |   11 +-
>  29 files changed, 625 insertions(+), 73 deletions(-)
>  create mode 100644 replay/replay-debugging.c
>
> --
> Pavel Dovgalyuk
