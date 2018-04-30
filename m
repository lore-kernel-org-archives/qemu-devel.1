Received: from eggs.gnu.org ([2001:4830:134:3::10]:48515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1fD9jU-0001Jn-0x
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1fD9jQ-0000Hk-O5
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:24:48 -0400
Received: from mail.ispras.ru ([83.149.199.45]:37268)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1fD9jQ-0000HF-Bc
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:24:44 -0400
In-Reply-To: <CAFXrp_duRj1rZ6Opffa3ihw+zou6B+oPn3g2BNRPSEgB7F_P8Q@mail.gmail.com>
References: <20180428123627.12445.9923.stgit@pasha-VirtualBox>
	<CAFXrp_duRj1rZ6Opffa3ihw+zou6B+oPn3g2BNRPSEgB7F_P8Q@mail.gmail.com>
MIME-Version: 1.0
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Mon, 30 Apr 2018 17:24:41 +0300
Message-ID: <666afe29-36a5-4371-866e-a39fb427f6aa@ispras.ru>
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/19] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ciro Santilli <ciro.santilli@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

I'll try to reproduce it next week=2E

=E2=81=A3=D0=9E=D1=82=D0=BF=D1=80=D0=
=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE =D1=81 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=
=8C=D1=8E BlueMail =E2=80=8B

=D0=9D=D0=B0 30 =D0=90=D0=BF=D1=80 2018 =D0=
=B3=2E, 17:20, =D0=B2 17:20, Ciro Santilli <ciro=2Esantilli@gmail=2Ecom> =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:=D0=BF>Did you manage to reprodu=
ce and solve the savevm and loadvm problems I
>mentioned at:
>http://lists=
=2Enongnu=2Eorg/archive/html/qemu-devel/2018-04/msg05219=2Ehtml
>?
>
>I sti=
ll observe them on the current patch=2E
>
>On Sat, Apr 28, 2018 at 1:36 PM,=
 Pavel Dovgalyuk
><Pavel=2EDovgaluk@ispras=2Eru> wrote:
>> GDB remote proto=
col supports reverse debugging of the targets=2E
>> It includes 'reverse st=
ep' and 'reverse continue' operations=2E
>> The first one finds the previou=
s step of the execution,
>> and the second one is intended to stop at the l=
ast breakpoint that
>> would happen when the program is executed normally=
=2E
>>
>> Reverse debugging is possible in the replay mode, when at least
>=
> one snapshot was created at the record or replay phase=2E
>> QEMU can use=
 these snapshots for travelling back in time with GDB=2E
>>
>> Running the =
execution in replay mode allows using GDB reverse
>debugging
>> commands:
>=
>  - reverse-stepi (or rsi): Steps one instruction to the past=2E
>>    QEM=
U loads on of the prior snapshots and proceeds to the desired
>>    instruc=
tion forward=2E When that step is reaches, execution stops=2E
>>  - reverse=
-continue (or rc): Runs execution "backwards"=2E
>>    QEMU tries to find b=
reakpoint or watchpoint by loaded prior
>snapshot
>>    and replaying the e=
xecution=2E Then QEMU loads snapshots again and
>>    replays to the latest=
 breakpoint=2E When there are no breakpoints in
>>    the examined section =
of the execution, QEMU finds one more
>snapshot
>>    and tries again=2E Af=
ter the first snapshot is processed, execution
>>    stops at this snapshot=
=2E
>>
>> The set of patches include the following modifications:
>>  - gdb=
stub update for reverse debugging support
>>  - functions that automaticall=
y perform reverse step and reverse
>>    continue operations
>>  - hmp/qmp =
commands for manipulating the replay process
>>  - improvement of the snaps=
hotting for saving the execution step
>>    in the snapshot parameters
>>  =
- other record/replay fixes
>>
>> The patches are available in the reposito=
ry:
>> https://github=2Ecom/ispras/qemu/tree/rr-180428
>>
>> v2 changes:
>>=
  - documented reverse debugging
>>  - fixed start vmstate loading in recor=
d mode
>>  - documented qcow2 changes (as suggested by Eric Blake)
>>  - ma=
de icount SnapshotInfo field optional (as suggested by Eric
>Blake)
>>  - r=
enamed qmp commands (as suggested by Eric Blake)
>>  - minor changes
>>
>> =
---
>>
>> Pavel Dovgalyuk (19):
>>       block: implement bdrv_snapshot_got=
o for blkreplay
>>       replay: disable default snapshot for record/replay=

>>       replay: update docs for record/replay with block devices
>>      =
 replay: don't drain/flush bdrv queue while RR is working
>>       replay: =
finish record/replay before closing the disks
>>       qcow2: introduce ico=
unt field for snapshots
>>       migration: introduce icount field for snap=
shots
>>       replay: introduce info hmp/qmp command
>>       replay: intr=
oduce breakpoint at the specified step
>>       replay: implement replay-se=
ek command to proceed to the desired
>step
>>       replay: flush events wh=
en exitting
>>       timer: remove replay clock probe in deadline calculati=
on
>>       replay: refine replay-time module
>>       translator: fix brea=
kpoint processing
>>       replay: flush rr queue before loading the vmstat=
e
>>       gdbstub: add reverse step support in replay mode
>>       gdbstu=
b: add reverse continue support in replay mode
>>       replay: describe re=
verse debugging in docs/replay=2Etxt
>>       replay: allow loading any sna=
pshots before recording
>>
>>
>>  accel/tcg/translator=2Ec    |    8 +
>>  =
block/blkreplay=2Ec         |    8 +
>>  block/io=2Ec                |   22=
 +++
>>  block/qapi=2Ec              |   17 ++-
>>  block/qcow2-snapshot=2E=
c    |    9 +
>>  block/qcow2=2Eh             |    2
>>  blockdev=2Ec      =
          |   10 ++
>>  cpus=2Ec                    |   19 ++-
>>  docs/int=
erop/qcow2=2Etxt    |    4 +
>>  docs/replay=2Etxt           |   45 +++++++=

>>  exec=2Ec                    |    6 +
>>  gdbstub=2Ec                 |=
   50 +++++++-
>>  hmp-commands-info=2Ehx      |   14 ++
>>  hmp-commands=
=2Ehx           |   30 +++++
>>  hmp=2Eh                     |    3
>>  inc=
lude/block/snapshot=2Eh  |    1
>>  include/sysemu/replay=2Eh   |   18 +++
=
>>  migration/savevm=2Ec        |   15 +-
>>  qapi/block-core=2Ejson      |=
    5 +
>>  qapi/block=2Ejson           |    3
>>  qapi/misc=2Ejson        =
    |   68 +++++++++++
>>  replay/Makefile=2Eobjs      |    3
>>  replay/re=
play-debugging=2Ec |  287
>+++++++++++++++++++++++++++++++++++++++++++++
>>=
  replay/replay-events=2Ec    |   14 --
>>  replay/replay-internal=2Eh  |  =
 10 +-
>>  replay/replay-snapshot=2Ec  |   17 ++-
>>  replay/replay-time=2E=
c      |   27 ++--
>>  replay/replay=2Ec           |   22 +++
>>  stubs/rep=
lay=2Ec            |   10 ++
>>  util/qemu-timer=2Ec         |   11 --
>>  =
vl=2Ec                      |   18 ++-
>>  31 files changed, 695 insertions=
(+), 81 deletions(-)
>>  create mode 100644 replay/replay-debugging=2Ec
>>
=
>> --
>> Pavel Dovgalyuk
