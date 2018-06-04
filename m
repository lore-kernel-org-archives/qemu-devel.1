Received: from eggs.gnu.org ([2001:4830:134:3::10]:37577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1fPjD9-0001Kp-Lp
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1fPjD6-0002gi-Bt
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:43:23 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51950)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1fPjD5-0002fo-PJ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:43:20 -0400
In-Reply-To: <20180528071332.9424.27343.stgit@pasha-VirtualBox>
References: <20180528071332.9424.27343.stgit@pasha-VirtualBox>
MIME-Version: 1.0
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Mon, 04 Jun 2018 09:43:12 +0300
Message-ID: <b2f04223-f52d-44e6-95a6-6ed91d021dad@ispras.ru>
Content-Type: text/plain;
 charset=UTF-8
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
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Ping?



=E2=81=A3=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=
=BE =D1=81 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E BlueMail =E2=80=8B

=
=D0=9D=D0=B0 28 =D0=9C=D0=B0=D0=B9 2018 =D0=B3=2E, 10:13, =D0=B2 10:13, Pav=
el Dovgalyuk <pavel=2Edovgaluk@ispras=2Eru> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BB:=D0=BF>GDB remote protocol supports reverse debugging of the t=
argets=2E
>It includes 'reverse step' and 'reverse continue' operations=2E
=
>The first one finds the previous step of the execution,
>and the second on=
e is intended to stop at the last breakpoint that
>would happen when the pr=
ogram is executed normally=2E
>
>Reverse debugging is possible in the repla=
y mode, when at least
>one snapshot was created at the record or replay pha=
se=2E
>QEMU can use these snapshots for travelling back in time with GDB=2E=

>
>Running the execution in replay mode allows using GDB reverse debugging=

>commands:
> - reverse-stepi (or rsi): Steps one instruction to the past=
=2E
>   QEMU loads on of the prior snapshots and proceeds to the desired
> =
  instruction forward=2E When that step is reaches, execution stops=2E
> - =
reverse-continue (or rc): Runs execution "backwards"=2E
>   QEMU tries to f=
ind breakpoint or watchpoint by loaded prior snapshot
>   and replaying the=
 execution=2E Then QEMU loads snapshots again and
>   replays to the latest=
 breakpoint=2E When there are no breakpoints in
>   the examined section of=
 the execution, QEMU finds one more snapshot
>   and tries again=2E After t=
he first snapshot is processed, execution
>   stops at this snapshot=2E
>
>=
The set of patches include the following modifications:
> - gdbstub update =
for reverse debugging support
> - functions that automatically perform reve=
rse step and reverse
>   continue operations
> - hmp/qmp commands for manip=
ulating the replay process
> - improvement of the snapshotting for saving t=
he execution step
>   in the snapshot parameters
> - other record/replay fi=
xes
>
>The patches are available in the repository:
>https://github=2Ecom/i=
spras/qemu/tree/rr-180524
>
>v4 changes:
>- changed 'since 2=2E13' to 'sinc=
e 3=2E0' in json (as suggested by Eric
>Blake)
>
>v3 changes:
>- Fixed PS/2=
 bug with save/load vm, which caused failures of the
>replay=2E
>   The pat=
ch was sent separately=2E
> - Rebased to the new code base=2E
> - Minor fix=
es=2E
>
>v2 changes:
> - documented reverse debugging
> - fixed start vmsta=
te loading in record mode
> - documented qcow2 changes (as suggested by Eri=
c Blake)
> - made icount SnapshotInfo field optional (as suggested by Eric =
Blake)
> - renamed qmp commands (as suggested by Eric Blake)
> - minor chan=
ges
>
>---
>
>Pavel Dovgalyuk (19):
>      block: implement bdrv_snapshot_g=
oto for blkreplay
>      replay: disable default snapshot for record/replay=

>      replay: update docs for record/replay with block devices
>      rep=
lay: don't drain/flush bdrv queue while RR is working
>      replay: finish=
 record/replay before closing the disks
>      qcow2: introduce icount fiel=
d for snapshots
>      migration: introduce icount field for snapshots
>   =
   replay: introduce info hmp/qmp command
>      replay: introduce breakpoi=
nt at the specified step
>   replay: implement replay-seek command to proce=
ed to the desired step
>      replay: flush events when exiting
>      time=
r: remove replay clock probe in deadline calculation
>      replay: refine =
replay-time module
>      translator: fix breakpoint processing
>      repl=
ay: flush rr queue before loading the vmstate
>      gdbstub: add reverse s=
tep support in replay mode
>      gdbstub: add reverse continue support in =
replay mode
>      replay: describe reverse debugging in docs/replay=2Etxt
=
>      replay: allow loading any snapshots before recording
>
>
> accel/tcg=
/translator=2Ec    |    9 +
> block/blkreplay=2Ec         |    8 +
> block/=
io=2Ec                |   22 +++
> block/qapi=2Ec              |   17 ++-
>=
 block/qcow2-snapshot=2Ec    |    9 +
> block/qcow2=2Eh             |    2 =

> blockdev=2Ec                |   10 ++
> cpus=2Ec                    |   =
19 ++-
> docs/interop/qcow2=2Etxt    |    4 +
> docs/replay=2Etxt          =
 |   45 +++++++
> exec=2Ec                    |    6 +
> gdbstub=2Ec       =
          |   50 +++++++-
> hmp-commands-info=2Ehx      |   14 ++
> hmp-com=
mands=2Ehx           |   30 +++++
> hmp=2Eh                     |    3 
> i=
nclude/block/snapshot=2Eh  |    1 
> include/sysemu/replay=2Eh   |   18 +++=

> migration/savevm=2Ec        |   15 +-
> qapi/block-core=2Ejson      |   =
 5 +
> qapi/block=2Ejson           |    3 
> qapi/misc=2Ejson            | =
  68 +++++++++++
> replay/Makefile=2Eobjs      |    3 
>replay/replay-debug=
ging=2Ec |  287
>+++++++++++++++++++++++++++++++++++++++++++++
> replay/rep=
lay-events=2Ec    |   14 --
> replay/replay-internal=2Eh  |   10 +-
> repla=
y/replay-snapshot=2Ec  |   17 ++-
> replay/replay-time=2Ec      |   27 ++--=

> replay/replay=2Ec           |   22 +++
> stubs/replay=2Ec            |  =
 10 ++
> util/qemu-timer=2Ec         |   11 --
> vl=2Ec                    =
  |   18 ++-
> 31 files changed, 696 insertions(+), 81 deletions(-)
> creat=
e mode 100644 replay/replay-debugging=2Ec
>
>-- 
>Pavel Dovgalyuk
