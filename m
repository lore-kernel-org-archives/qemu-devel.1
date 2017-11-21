Received: from eggs.gnu.org ([2001:4830:134:3::10]:56873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1eH4S8-0005CV-Mg
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1eH4S4-0007pn-4z
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:02:48 -0500
Message-ID: <1511254945.862.24.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 21 Nov 2017 09:02:25 +0000
In-Reply-To: <e1b4faed-60f1-bfe3-2231-e357718dda1f@ilande.co.uk>
References: <1511222455.862.5.camel@linuxfoundation.org>
	<e1b4faed-60f1-bfe3-2231-e357718dda1f@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-system-ppc hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, 2017-11-21 at 07:50 +0000, Mark Cave-Ayland wrote:
> On 21/11/17 00:00, Richard Purdie wrote:
> > I work on the Yocto Project and we use qemu to test boot our Linux
> > images and run tests against them. We've been noticing some
> > instability
> > for ppc where the images sometimes hang, usually around udevd bring
> > up
> > time so just after booting into userspace.
> >=20
> > To cut a long story short, I've tracked down what I think is the
> > problem. I believe the decrementer timer stops receiving interrupts
> > so
> > tasks in our images hang indefinitely as the timer stopped.=C2=A0
> >=20
> > It can be summed up with this line of debug:
> >=20
> > ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending 00000100req
> > 00000004
> >=20
> > It should normally read:
> >=20
> > ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level=C2=A01 =3D> pending 0000010=
0req
> > 00000002
> >=20
> > The question is why=C2=A0CPU_INTERRUPT_EXITTB ends up being set when =
the
> > lines above this=C2=A0log message clearly sets=C2=A0CPU_INTERRUPT_HAR=
D (via=C2=A0
> > cpu_interrupt() ).
> >=20
> > I note in cpu.h:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0/* updates protected by BQL */
> > =C2=A0=C2=A0=C2=A0=C2=A0uint32_t interrupt_request;
> >=20
> > (for struct CPUState)
> >=20
> > The ppc code does "cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB"
> > in 5
> > places, 3 in excp_helper.c and 2 in helper_regs.h. In all cases, =C2=A0
> > g_assert(qemu_mutex_iothread_locked()); fails. If I do something
> > like:
> >=20
> > if (!qemu_mutex_iothread_locked()) {
> > =C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_lock_iothread();
> > =C2=A0=C2=A0=C2=A0=C2=A0cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> > =C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_unlock_iothread();
> > } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> > }
> >=20
> > in these call sites then I can no longer lock qemu up with my test
> > case.
> >=20
> > I suspect the _HARD setting gets overwritten which stops the=C2=A0
> > decrementer interrupts being delivered.
> >=20
> > I don't know if taking this lock in these situations is going to be
> > bad
> > for performance and whether such a patch would be right/wrong.
> >=20
> > At this point I therefore wanted to seek advice on what the real
> > issue
> > is here and how to fix it!
>
> Thanks for the report - given that a lot of work has been done on
> MTTCG and iothread over the past few releases, it wouldn't be a
> complete surprise if something had crept in here.
>=20
> Firstly let's start off with some basics: what is your host
> architecture, QEMU version and full command line being used to launch
> QEMU?

I'm running this on x86_64, I'm using qemu 2.10.1 and the commandline
being used for qemu is:

qemu-system-ppc -device virtio-net-pci,netdev=3Dnet0,mac=3D52:54:00:12:34=
:02=C2=A0
   -netdev tap,id=3Dnet0,ifname=3Dtap0,script=3Dno,downscript=3Dno=C2=A0
   -drive file=3D./core-image-sato-qemuppc.rootfs.ext4,if=3Dvirtio,format=
=3Draw=C2=A0
   -show-cursor -device virtio-rng-pci=C2=A0=C2=A0-nographic -pidfile /tm=
p/zzqemu.1.pid=C2=A0
   -d unimp,guest_errors,int -D /tmp/qemu.1 -monitor pty -machine mac99=C2=
=A0
   -cpu G4 -m 256 -snapshot -serial mon:stdio -serial null=C2=A0
   -kernel /tmp/repro/vmlinux-qemuppc.bin -append 'root=3D/dev/vda rw hig=
hres=3Doff=C2=A0=C2=A0
    console=3DttyS0 mem=3D256M ip=3D192.168.7.2::192.168.7.1:255.255.255.=
0 console=3Dtty=C2=A0
    console=3DttyS0=C2=A0=C2=A0udev.log-priority=3Ddebug powersave=3Doff'

> Would it also be possible for you to make your test image available
> for other people to see if they can recreate the same issue?

I've shared the image, kernel and my "reproducer" script:=C2=A0

http://www.rpsys.net/wp/rp/qemuppc-hang-reproducer.tgz

We needed to find a way to reproduce this at will and it doesn't seem
to happen often. The scripts in there are partly extracted from our
test setup and partly ugly brute forcing. To run them you'd do
something like:

cc tunctl.c -o tunctl
sudo ./runqemu-gen-tapdevs 1000 1000 50
(This sets up tap0-tap49 accessible by user/group 1000/1000, only need
to do this once - its how we enable easy networking without needing
sudo on our test infrastructure)

vi=C2=A0core-image-sato-qemuppc.qemuboot.conf
[set the last three lines to point at where qemu-system-ppc lives]
vi ./runqemu-parallel.py
[set mydir to wherever you extracted it to]
python3 ./runqemu-parallel.py

This will launch 50 copies of qemu, dumping logging and output into
/tmp/qemu.X and /tmp/*runqemu* files and than monitor the logs to see
which if any "stall". Its normal for the image to stall for a few
seconds towards the end of boot but if any are printing stalled
messages for a minute, they've properly hung. You'll see a:

ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending 00000100req
00000004

in the logs of a hung qemu. The image output would usually stop with a
ep_poll4. The kernel I've provided there is a very verbose debug kernel
which is hang to tell when its hung, if a bit slower to boot.

I didn't promise it was neat, sorry :)

Cheers,

Richard
