Received: from eggs.gnu.org ([2001:4830:134:3::10]:40783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPrNH-0007ne-Qy
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPrNE-00014d-IC
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:26:23 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fPrNE-00014L-7R
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:26:20 -0400
Received: by mail-wr0-x243.google.com with SMTP id l10-v6so9780427wrn.2
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:26:20 -0700 (PDT)
References: <20180528071332.9424.27343.stgit@pasha-VirtualBox>
	<b2f04223-f52d-44e6-95a6-6ed91d021dad@ispras.ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b2f04223-f52d-44e6-95a6-6ed91d021dad@ispras.ru>
Date: Mon, 04 Jun 2018 16:26:17 +0100
Message-ID: <87in6yd146.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/19] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net


Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru> writes:

> Ping?

I started having a look but I ran into this straight away. First I
recorded a boot of the kernel:

  ./aarch64-softmmu/qemu-system-aarch64 -machine virt,graphics=3Don,gic-ver=
sion=3D3,virtualization=3Don -cpu cortex-a53 --serial mon:stdio -display no=
ne -kernel ../images/aarch64-current-linux-initrd-guest.img -icount shift=
=3D7,rr=3Drecord,rrfile=3Dreplay.bin

Then played back:

  ./aarch64-softmmu/qemu-system-aarch64 -machine virt,graphics=3Don,gic-ver=
sion=3D3,virtualization=3Don -cpu cortex-a53 --serial mon:stdio -display no=
ne -kernel ../images/aarch64-current-linux-initrd-guest.img -icount shift=
=3D7,rr=3Dreplay,rrfile=3Dreplay.bin -s -S

And did the following on gdb:

(gdb) i
0x0000000040000004 in ?? ()
=3D> 0x40000004:  mov     x1, xzr
   0x40000008:  mov     x2, xzr
   0x4000000c:  mov     x3, xzr
(gdb)
0x0000000040000008 in ?? ()
=3D> 0x40000008:  mov     x2, xzr
   0x4000000c:  mov     x3, xzr
   0x40000010:  ldr     x4, 0x40000020
(gdb)
0x000000004000000c in ?? ()
=3D> 0x4000000c:  mov     x3, xzr
   0x40000010:  ldr     x4, 0x40000020
   0x40000014:  br      x4
(gdb)
0x0000000040000010 in ?? ()
=3D> 0x40000010:  ldr     x4, 0x40000020
   0x40000014:  br      x4
   0x40000018:  .inst   0x44000000 ; undefined
(gdb)
0x0000000040000014 in ?? ()
=3D> 0x40000014:  br      x4
   0x40000018:  .inst   0x44000000 ; undefined
   0x4000001c:  .inst   0x00000000 ; undefined
(gdb) p/x $x4
$1 =3D 0x40080000
(gdb) reverse-stepi
warning: Remote failure reply: E14

Surely this is the simple case and doesn't require any snapshots for
block devices as there are none. Am I missing something?


>
>
>
> =E2=81=A3=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE =D1=
=81 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E BlueMail =E2=80=8B
>
> =D0=9D=D0=B0 28 =D0=9C=D0=B0=D0=B9 2018 =D0=B3., 10:13, =D0=B2 10:13, Pav=
el Dovgalyuk <pavel.dovgaluk@ispras.ru> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:=D0=BF>GDB remote protocol supports reverse debugging of the targ=
ets.
>>It includes 'reverse step' and 'reverse continue' operations.
>>The first one finds the previous step of the execution,
>>and the second one is intended to stop at the last breakpoint that
>>would happen when the program is executed normally.
>>
>>Reverse debugging is possible in the replay mode, when at least
>>one snapshot was created at the record or replay phase.
>>QEMU can use these snapshots for travelling back in time with GDB.
>>
>>Running the execution in replay mode allows using GDB reverse debugging
>>commands:
>> - reverse-stepi (or rsi): Steps one instruction to the past.
>>   QEMU loads on of the prior snapshots and proceeds to the desired
>>   instruction forward. When that step is reaches, execution stops.
>> - reverse-continue (or rc): Runs execution "backwards".
>>   QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
>>   and replaying the execution. Then QEMU loads snapshots again and
>>   replays to the latest breakpoint. When there are no breakpoints in
>>   the examined section of the execution, QEMU finds one more snapshot
>>   and tries again. After the first snapshot is processed, execution
>>   stops at this snapshot.
>>
>>The set of patches include the following modifications:
>> - gdbstub update for reverse debugging support
>> - functions that automatically perform reverse step and reverse
>>   continue operations
>> - hmp/qmp commands for manipulating the replay process
>> - improvement of the snapshotting for saving the execution step
>>   in the snapshot parameters
>> - other record/replay fixes
>>
>>The patches are available in the repository:
>>https://github.com/ispras/qemu/tree/rr-180524
>>
>>v4 changes:
>>- changed 'since 2.13' to 'since 3.0' in json (as suggested by Eric
>>Blake)
>>
>>v3 changes:
>>- Fixed PS/2 bug with save/load vm, which caused failures of the
>>replay.
>>   The patch was sent separately.
>> - Rebased to the new code base.
>> - Minor fixes.
>>
>>v2 changes:
>> - documented reverse debugging
>> - fixed start vmstate loading in record mode
>> - documented qcow2 changes (as suggested by Eric Blake)
>> - made icount SnapshotInfo field optional (as suggested by Eric Blake)
>> - renamed qmp commands (as suggested by Eric Blake)
>> - minor changes
>>
>>---
>>
>>Pavel Dovgalyuk (19):
>>      block: implement bdrv_snapshot_goto for blkreplay
>>      replay: disable default snapshot for record/replay
>>      replay: update docs for record/replay with block devices
>>      replay: don't drain/flush bdrv queue while RR is working
>>      replay: finish record/replay before closing the disks
>>      qcow2: introduce icount field for snapshots
>>      migration: introduce icount field for snapshots
>>      replay: introduce info hmp/qmp command
>>      replay: introduce breakpoint at the specified step
>>   replay: implement replay-seek command to proceed to the desired step
>>      replay: flush events when exiting
>>      timer: remove replay clock probe in deadline calculation
>>      replay: refine replay-time module
>>      translator: fix breakpoint processing
>>      replay: flush rr queue before loading the vmstate
>>      gdbstub: add reverse step support in replay mode
>>      gdbstub: add reverse continue support in replay mode
>>      replay: describe reverse debugging in docs/replay.txt
>>      replay: allow loading any snapshots before recording
>>
>>
>> accel/tcg/translator.c    |    9 +
>> block/blkreplay.c         |    8 +
>> block/io.c                |   22 +++
>> block/qapi.c              |   17 ++-
>> block/qcow2-snapshot.c    |    9 +
>> block/qcow2.h             |    2
>> blockdev.c                |   10 ++
>> cpus.c                    |   19 ++-
>> docs/interop/qcow2.txt    |    4 +
>> docs/replay.txt           |   45 +++++++
>> exec.c                    |    6 +
>> gdbstub.c                 |   50 +++++++-
>> hmp-commands-info.hx      |   14 ++
>> hmp-commands.hx           |   30 +++++
>> hmp.h                     |    3
>> include/block/snapshot.h  |    1
>> include/sysemu/replay.h   |   18 +++
>> migration/savevm.c        |   15 +-
>> qapi/block-core.json      |    5 +
>> qapi/block.json           |    3
>> qapi/misc.json            |   68 +++++++++++
>> replay/Makefile.objs      |    3
>>replay/replay-debugging.c |  287
>>+++++++++++++++++++++++++++++++++++++++++++++
>> replay/replay-events.c    |   14 --
>> replay/replay-internal.h  |   10 +-
>> replay/replay-snapshot.c  |   17 ++-
>> replay/replay-time.c      |   27 ++--
>> replay/replay.c           |   22 +++
>> stubs/replay.c            |   10 ++
>> util/qemu-timer.c         |   11 --
>> vl.c                      |   18 ++-
>> 31 files changed, 696 insertions(+), 81 deletions(-)
>> create mode 100644 replay/replay-debugging.c
>>
>>--
>>Pavel Dovgalyuk


--
Alex Benn=C3=A9e
