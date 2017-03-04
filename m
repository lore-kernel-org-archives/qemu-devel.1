Received: from eggs.gnu.org ([2001:4830:134:3::10]:46090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ckAWy-0002Ql-48
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ckAWt-00021J-UX
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:19:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:60837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ckAWt-000210-OD
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:19:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ckAWs-0006eG-K5
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 14:19:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 924622E8025
	for <qemu-devel@nongnu.org>; Sat,  4 Mar 2017 14:19:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Mar 2017 14:08:32 -0000
From: Richard Jones <rjones@redhat.com>
Reply-To: Bug 1224444 <1224444@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130912120415.31262.22076.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170304140833.21959.77512.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1224444] Re: virtio-serial loses writes when used
 over virtio-mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fixed upstream, see previous comment.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1224444

Title:
  virtio-serial loses writes when used over virtio-mmio

Status in QEMU:
  Fix Released

Bug description:
  virtio-serial appears to lose writes, but only when used on top of
  virtio-mmio.  The scenario is this:

  /home/rjones/d/qemu/arm-softmmu/qemu-system-arm \
  =C2=A0=C2=A0=C2=A0=C2=A0-global virtio-blk-device.scsi=3Doff \
  =C2=A0=C2=A0=C2=A0=C2=A0-nodefconfig \
  =C2=A0=C2=A0=C2=A0=C2=A0-nodefaults \
  =C2=A0=C2=A0=C2=A0=C2=A0-nographic \
  =C2=A0=C2=A0=C2=A0=C2=A0-M vexpress-a15 \
  =C2=A0=C2=A0=C2=A0=C2=A0-machine accel=3Dkvm:tcg \
  =C2=A0=C2=A0=C2=A0=C2=A0-m 500 \
  =C2=A0=C2=A0=C2=A0=C2=A0-no-reboot \
  =C2=A0=C2=A0=C2=A0=C2=A0-kernel /home/rjones/d/libguestfs/tmp/.guestfs-10=
01/kernel.27944 \
  =C2=A0=C2=A0=C2=A0=C2=A0-dtb /home/rjones/d/libguestfs/tmp/.guestfs-1001/=
dtb.27944 \
  =C2=A0=C2=A0=C2=A0=C2=A0-initrd /home/rjones/d/libguestfs/tmp/.guestfs-10=
01/initrd.27944 \
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-scsi-device,id=3Dscsi \
  =C2=A0=C2=A0=C2=A0=C2=A0-drive file=3D/home/rjones/d/libguestfs/tmp/libgu=
estfsLa9dE2/scratch.1,cache=3Dunsafe,format=3Draw,id=3Dhd0,if=3Dnone \
  =C2=A0=C2=A0=C2=A0=C2=A0-device scsi-hd,drive=3Dhd0 \
  =C2=A0=C2=A0=C2=A0=C2=A0-drive file=3D/home/rjones/d/libguestfs/tmp/.gues=
tfs-1001/root.27944,snapshot=3Don,id=3Dappliance,cache=3Dunsafe,if=3Dnone \
  =C2=A0=C2=A0=C2=A0=C2=A0-device scsi-hd,drive=3Dappliance \
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-serial-device \
  =C2=A0=C2=A0=C2=A0=C2=A0-serial stdio \
  =C2=A0=C2=A0=C2=A0=C2=A0-chardev socket,path=3D/home/rjones/d/libguestfs/=
tmp/libguestfsLa9dE2/guestfsd.sock,id=3Dchannel0 \
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtserialport,chardev=3Dchannel0,name=3D=
org.libguestfs.channel.0 \
  =C2=A0=C2=A0=C2=A0=C2=A0-append 'panic=3D1 mem=3D500M console=3DttyAMA0 u=
devtimeout=3D600 no_timer_check acpi=3Doff printk.time=3D1 cgroup_disable=
=3Dmemory root=3D/dev/sdb selinux=3D0 guestfs_verbose=3D1 TERM=3Dxterm-256c=
olor'

  After the guest starts up, a daemon writes 4 bytes to a virtio-serial
  socket.  The host side reads these 4 bytes correctly and writes a 64
  byte message.  The guest never sees this message.

  I enabled virtio-mmio debugging, and this is what is printed (## =3D my
  comment):

  ## guest opens the socket:
  trying to open virtio-serial channel '/dev/virtio-ports/org.libguestfs.ch=
annel.0'
  virtio_mmio: virtio_mmio_write offset 0x50 value 0x3
  opened the socket, sock =3D 3
  udevadm settle
  ## guest writes 4 bytes to the socket:
  virtio_mmio: virtio_mmio_write offset 0x50 value 0x5
  virtio_mmio: virtio_mmio setting IRQ 1
  virtio_mmio: virtio_mmio_read offset 0x60
  virtio_mmio: virtio_mmio_write offset 0x64 value 0x1
  virtio_mmio: virtio_mmio setting IRQ 0
  sent magic GUESTFS_LAUNCH_FLAG
  ## host reads 4 bytes successfully:
  main_loop libguestfs: recv_from_daemon: received GUESTFS_LAUNCH_FLAG
  libguestfs: [14605ms] appliance is up
  Guest launched OK.
  ## host writes 64 bytes to socket:
  libguestfs: writing the data to the socket (size =3D 64)
  waiting for next request
  libguestfs: data written OK
  ## hangs here forever with guest in read() call never receiving any data

  I am using qemu from git today (2d1fe1873a984).

  Some notes:

  - It's not 100% reproducible.  Sometimes everything works fine, although =
it fails "often" (eg > 2/3rds of the time).
  - KVM is being used.
  - We've long used virtio-serial on x86 and have never seen anything like =
this.

  This is what the output looks like when it doesn't fail:

  trying to open virtio-serial channel '/dev/virtio-ports/org.libguestfs.ch=
annel.0
  '
  virtio_mmio: virtio_mmio_write offset 0x50 value 0x3
  opened the socket, sock =3D 3
  udevadm settle
  virtio_mmio: virtio_mmio_write offset 0x50 value 0x5
  virtio_mmio: virtio_mmio setting IRQ 1
  virtio_mmio: virtio_mmio_read offset 0x60
  virtio_mmio: virtio_mmio_write offset 0x64 value 0x1
  virtio_mmio: virtio_mmio setting IRQ 0
  sent magic GUESTlibguestfs: recv_from_daemon: received GUESTFS_LAUNCH_FLAG
  libguestfs: [14710ms] appliance is up
  Guest launched OK.
  libguestfs: writing the data to the socket (size =3D 64)
  FS_LAUNCH_FLAG
  main_loop waiting for next request
  libguestfs: data written OK
  virtio_mmio: virtio_mmio_write offset 0x50 value 0x2
  virtio_mmio: virtio_mmio setting IRQ 1
  virtio_mmio: virtio_mmio setting IRQ 1
  virtio_mmio: virtio_mmio_write offset 0x50 value 0x2
  virtio_mmio: virtio_mmio_read offset 0x60
  virtio_mmio: virtio_mmio setting IRQ 1
  virtio_mmio: virtio_mmio_write offset 0x64 value 0x1
  virtio_mmio: virtio_mmio setting IRQ 0
  virtio_mmio: virtio_mmio_read offset 0x60
  virtio_mmio: virtio_mmio_write offset 0x64 value 0x0
  virtio_mmio: virtio_mmio setting IRQ 0
  virtio_mmio: virtio_mmio_read offset 0x60
  virtio_mmio: virtio_mmio_write offset 0x64 value 0x1
  [... more virtio-mmio lines omitted ...]
  virtio_mmio: virtio_mmio_write offset 0x64 value 0x0
  virtio_mmio: virtio_mmio setting IRQ 1
  virtio_mmio: virtio_mmio_read offset 0x60
  virtio_mmio: virtio_mmio_write offset 0x64 value 0x1
  virtio_mmio: virtio_mmio setting IRQ 0
  guestfsd: main_loop: new request, len 0x3c
  virtio_mmio: virtio_mmio_write offset 0x50 value 0x4
  0000: 20 00 f5 f5 00 00 00 04 00 00 00 d2 00 00 00 00 | ...............|v=
irtio_mmio: virtio_mmio_write offset 0x50 value 0x2
  virtio_mmio: virtio_mmio setting IRQ 1

  virtio_mmio: virtio_mmio_read offset 0x60
  virtio_mmio: virtio_mmio_write offset 0x64 value 0x1
  virtio_mmio: virtio_mmio setting IRQ 0
  0010: 00 12 34 00 00 00 00 00 00 00 00 00 00 00 00 00 |..4.............|
  0020: 00 00 00 00 00 00 00 00 00 00 00 08 2f 64 65 76 |............/dev|
  0030: 2f 73 64 61 00 00 00 03 6d 62 72 00             |/sda....mbr.    |
  virtio_mmio: virtio_mmio_write offset 0x50 value 0x2
  virtio_mmio: virtio_mmio setting IRQ 1
  virtio_mmio: virtio_mmio_read offset 0x60
  virtio_mmio: virtio_mmio_write offset 0x64 value 0x1
  virtio_mmio: virtio_mmio setting IRQ 0
  virtio_mmio: virtio_mmio_write offset 0x50 value 0x2
  virtio_mmio: virtio_mmio setting IRQ 1
  virtio_mmio: virtio_mmio_read offset 0x60
  virtio_mmio: virtio_mmio_write offset 0x64 value 0x1
  virtio_mmio: virtio_mmio setting IRQ 0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1224444/+subscriptions
