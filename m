Received: from eggs.gnu.org ([2001:4830:134:3::10]:37266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fBg6h-0008Nn-VU
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fBg6d-0001bQ-8T
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:34:39 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56914)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fBg6c-0001b9-Rn
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:34:35 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<CAFXrp_f-r4+G1BOVaCh9a6kzR45rnqgvq5UEnMzNjfHB=BDBCw@mail.gmail.com>
In-Reply-To: <CAFXrp_f-r4+G1BOVaCh9a6kzR45rnqgvq5UEnMzNjfHB=BDBCw@mail.gmail.com>
Date: Thu, 26 Apr 2018 15:34:23 +0300
Message-ID: <00a401d3dd5a$e8a048d0$b9e0da70$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH 00/17] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Ciro Santilli' <ciro.santilli@gmail.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: 'QEMU Developers' <qemu-devel@nongnu.org>, 'Kevin Wolf' <kwolf@redhat.com>, 'Peter Maydell' <peter.maydell@linaro.org>, war2jordan@live.com, 'Peter Crosthwaite' <crosthwaite.peter@gmail.com>, 'Igor R' <boost.lists@gmail.com>, 'Juan Quintela' <quintela@redhat.com>, 'Jason Wang' <jasowang@redhat.com>, "'Michael S. Tsirkin'" <mst@redhat.com>, 'Aleksandr Bezzubikov' <zuban32s@gmail.com>, armbru@redhat.com, maria.klimushenkova@ispras.ru, 'Gerd Hoffmann' <kraxel@redhat.com>, 'Thomas Dullien' <thomas.dullien@googlemail.com>, 'Paolo Bonzini' <pbonzini@redhat.com>, mreitz@redhat.com, =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, dgilbert@redhat.com, rth@twiddle.net

> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
> On Wed, Apr 25, 2018 at 1:45 PM, Pavel Dovgalyuk
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
>=20
> Hi Pavel,
>=20
> 1)
>=20
> Can you provide more details on how to run the reverse debugging? In
> particular how to take the checkpoint?

There is some information in docs/replay.txt, but I guess, that I can =
give some more.

>=20
> My test setup is described in detail at:
> =
https://github.com/cirosantilli/qemu-test/tree/8127452e5685ed233dc7357a1f=
e34b7a2d173480
> command "x86_64/reverse-debug".
>=20
> Here are the actual commands:
>=20
> #!/usr/bin/env bash
> set -eu
> dir=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
> cmd=3D"\
> time \
> ./x86_64-softmmu/qemu-system-x86_64 \
> -M pc \
> -append 'root=3D/dev/sda console=3DttyS0 nokaslr printk.time=3Dy -
> lkmc_eval=3D\"/rand_check.out;/sbin/ifup -a;wget -S
> google.com;/poweroff.out;\"' \
> -kernel '${dir}/out/x86_64/buildroot/images/bzImage' \
> -nographic \
> -serial mon:stdio \
> -monitor telnet::45454,server,nowait \
> \
> -drive =
file=3D'${dir}/out/x86_64/buildroot/images/rootfs.ext2.qcow2,if=3Dnone,id=
=3Dimg-
> direct,format=3Dqcow2,snapshot'

The main thing for reverse debugging is snapshotting.
Therefore you should have an image that does not use temporary overlay =
file (snapshot option).
I'm using the following command line for record:

rm ./images/xp.ovl
# create overlay to avoid modifying the original image
./bin/qemu-img create -f qcow2 -b xp.qcow2 ./images/xp.ovl
./bin/qemu-system-i386 \
# This is workaround for XP. I wonder is it needed for the current =
version or not.
 -global apic-common.vapic=3Doff \
# using newly created overlay instead of the original image
# rrsnapshot creates the snapshot at the start
 -icount shift=3D7,rr=3Drecord,rrfile=3Dxp.replay,rrsnapshot=3Dinit =
-drive file=3D./images/xp.ovl,if=3Dnone,id=3Dimg-direct \
 -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-replay =
-device ide-hd,drive=3Dimg-replay -net none -m 256M -monitor stdio

While recording I can create some snapshots with savevm.
Command line for replaying differs only in "rr" option. rrsnapshot there =
loads the initial snapshot.
Any of the previously created snapshots may be specified.
You can also create new snapshots while replaying.


> \
> -drive =
driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay \
> -device ide-hd,drive=3Dimg-blkreplay \
> \
> -netdev user,id=3Dnet1 \
> -device rtl8139,netdev=3Dnet1 \
> -object filter-replay,id=3Dreplay,netdev=3Dnet1 \
> "
> cmd=3D"${cmd} $@"
> echo "$cmd"
> eval "$cmd -icount 'shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin'"
> eval "$cmd -icount 'shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin' -S -s"
>=20
> Then I take a snapshot right at the beginning of the execution:
>=20
> telnet 45454
> savevm a
>=20
> And on another shell:
>=20
> =
/data/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/usr/bin/x86=
_64-linux-gdb
> \
> -q \
> -ex 'file vmlinux' \
> -ex 'target remote localhost:1234' \
> -ex 'break start_kernel' \
> -ex 'continue' \
>=20
> But now if I try on GDB:
>=20
> next
> next
> next
> reverse-continue
>=20
> hoping to go back to start_kernel, but nothing happens.

Yes, because you are missing your snapshot, that was actually created in =
the temporary overlay.

> Same behavior if I take the snapshot after reaching start_kernel =
instead.
>=20
> 2)
>=20
> I wonder if it would be possible to expose checkpoint taking through
> GDB example via:
> https://sourceware.org/gdb/onlinedocs/gdb/Checkpoint_002fRestart.html

We'll check this out.

> Or some other more convenient checkpoint generation method, e.g.
> automatically take checkpoints every N instructions.

We implemented 'taking snapshots every N seconds', but I'll prefer to =
submit
it later, after approving the main idea.

> > Running the execution in replay mode allows using GDB reverse =
debugging
> > commands:
> >  - reverse-stepi (or rsi): Steps one instruction to the past.
> >    QEMU loads on of the prior snapshots and proceeds to the desired
> >    instruction forward. When that step is reaches, execution stops.
> >  - reverse-continue (or rc): Runs execution "backwards".
> >    QEMU tries to find breakpoint or watchpoint by loaded prior =
snapshot
> >    and replaying the execution. Then QEMU loads snapshots again and
> >    replays to the latest breakpoint. When there are no breakpoints =
in
> >    the examined section of the execution, QEMU finds one more =
snapshot
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
> > https://github.com/ispras/qemu/tree/rr-180207

Pavel Dovgalyuk
