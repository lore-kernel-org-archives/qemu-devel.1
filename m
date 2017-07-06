Received: from eggs.gnu.org ([2001:4830:134:3::10]:49964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dT1Ad-0004zw-35
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dT1AX-0006Vb-T4
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:25:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:38345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dT1AX-0006U4-JA
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:25:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dT1AW-0000iW-I3
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 07:25:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 671A82E8198
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 07:25:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Jul 2017 07:17:20 -0000
From: pork-prince <1702621@bugs.launchpad.net>
Reply-To: Bug 1702621 <1702621@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149932544038.24380.387410318124517933.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1702621] [NEW] colo: secondary vm crash during
 loadvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Following document 'COLO-FT.txt', I test colo feature on my hosts. It seems=
 goes well. But after a while the secondary vm crash.  The stack is as foll=
ows:
#0  0x00007f191456dc37 in raise () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00007f1914571028 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#2  0x00007f1914566bf6 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#3  0x00007f1914566ca2 in __assert_fail () from /lib/x86_64-linux-gnu/libc.=
so.6
#4  0x0000564154ad9147 in pcibus_reset (qbus=3D0x564156760d10) at ../hw/pci=
/pci.c:311
#5  0x0000564154a07cdb in qbus_reset_one (bus=3D0x564156760d10, opaque=3D0x=
0) at hw/core/qdev.c:319
#6  0x0000564154a0d721 in qbus_walk_children (bus=3D0x564156760d10, pre_dev=
fn=3D0, pre_busfn=3D0, =

    post_devfn=3D0x564154a07c26 <qdev_reset_one>, post_busfn=3D0x564154a07c=
6c <qbus_reset_one>, opaque=3D0x0)
    at hw/core/bus.c:68
#7  0x0000564154a08b4d in qdev_walk_children (dev=3D0x56415675f2b0, pre_dev=
fn=3D0, pre_busfn=3D0, =

    post_devfn=3D0x564154a07c26 <qdev_reset_one>, post_busfn=3D0x564154a07c=
6c <qbus_reset_one>, opaque=3D0x0)
    at hw/core/qdev.c:617
#8  0x0000564154a0d6e5 in qbus_walk_children (bus=3D0x564156594d30, pre_dev=
fn=3D0, pre_busfn=3D0, =

    post_devfn=3D0x564154a07c26 <qdev_reset_one>, post_busfn=3D0x564154a07c=
6c <qbus_reset_one>, opaque=3D0x0)
    at hw/core/bus.c:59
#9  0x0000564154a07df5 in qbus_reset_all (bus=3D0x564156594d30) at hw/core/=
qdev.c:336
#10 0x0000564154a07e3a in qbus_reset_all_fn (opaque=3D0x564156594d30) at hw=
/core/qdev.c:342
#11 0x0000564154a0e222 in qemu_devices_reset () at hw/core/reset.c:69
#12 0x00005641548b3b47 in pc_machine_reset () at /vms/git/qemu/hw/i386/pc.c=
:2234
#13 0x0000564154972ca7 in qemu_system_reset (report=3Dfalse) at vl.c:1697
#14 0x0000564154b9d007 in colo_process_incoming_thread (opaque=3D0x5641553c=
1280) at migration/colo.c:617
#15 0x00007f1914907184 in start_thread () from /lib/x86_64-linux-gnu/libpth=
read.so.0
#16 0x00007f1914634bed in clone () from /lib/x86_64-linux-gnu/libc.so.6

(gdb) frame 4
#4  0x0000564154ad9147 in pcibus_reset (qbus=3D0x564156760d10) at ../hw/pci=
/pci.c:311
warning: Source file is more recent than executable.
311             assert(bus->irq_count[i] =3D=3D 0);
(gdb) ^CQuit
(gdb) p bus->irq_count[i]
$1 =3D -1

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "command on primary and secondary vm"
   https://bugs.launchpad.net/bugs/1702621/+attachment/4910131/+files/colo-=
commands.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1702621

Title:
  colo: secondary vm crash during loadvm

Status in QEMU:
  New

Bug description:
  Following document 'COLO-FT.txt', I test colo feature on my hosts. It see=
ms goes well. But after a while the secondary vm crash.  The stack is as fo=
llows:
  #0  0x00007f191456dc37 in raise () from /lib/x86_64-linux-gnu/libc.so.6
  #1  0x00007f1914571028 in abort () from /lib/x86_64-linux-gnu/libc.so.6
  #2  0x00007f1914566bf6 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
  #3  0x00007f1914566ca2 in __assert_fail () from /lib/x86_64-linux-gnu/lib=
c.so.6
  #4  0x0000564154ad9147 in pcibus_reset (qbus=3D0x564156760d10) at ../hw/p=
ci/pci.c:311
  #5  0x0000564154a07cdb in qbus_reset_one (bus=3D0x564156760d10, opaque=3D=
0x0) at hw/core/qdev.c:319
  #6  0x0000564154a0d721 in qbus_walk_children (bus=3D0x564156760d10, pre_d=
evfn=3D0, pre_busfn=3D0, =

      post_devfn=3D0x564154a07c26 <qdev_reset_one>, post_busfn=3D0x564154a0=
7c6c <qbus_reset_one>, opaque=3D0x0)
      at hw/core/bus.c:68
  #7  0x0000564154a08b4d in qdev_walk_children (dev=3D0x56415675f2b0, pre_d=
evfn=3D0, pre_busfn=3D0, =

      post_devfn=3D0x564154a07c26 <qdev_reset_one>, post_busfn=3D0x564154a0=
7c6c <qbus_reset_one>, opaque=3D0x0)
      at hw/core/qdev.c:617
  #8  0x0000564154a0d6e5 in qbus_walk_children (bus=3D0x564156594d30, pre_d=
evfn=3D0, pre_busfn=3D0, =

      post_devfn=3D0x564154a07c26 <qdev_reset_one>, post_busfn=3D0x564154a0=
7c6c <qbus_reset_one>, opaque=3D0x0)
      at hw/core/bus.c:59
  #9  0x0000564154a07df5 in qbus_reset_all (bus=3D0x564156594d30) at hw/cor=
e/qdev.c:336
  #10 0x0000564154a07e3a in qbus_reset_all_fn (opaque=3D0x564156594d30) at =
hw/core/qdev.c:342
  #11 0x0000564154a0e222 in qemu_devices_reset () at hw/core/reset.c:69
  #12 0x00005641548b3b47 in pc_machine_reset () at /vms/git/qemu/hw/i386/pc=
.c:2234
  #13 0x0000564154972ca7 in qemu_system_reset (report=3Dfalse) at vl.c:1697
  #14 0x0000564154b9d007 in colo_process_incoming_thread (opaque=3D0x564155=
3c1280) at migration/colo.c:617
  #15 0x00007f1914907184 in start_thread () from /lib/x86_64-linux-gnu/libp=
thread.so.0
  #16 0x00007f1914634bed in clone () from /lib/x86_64-linux-gnu/libc.so.6

  (gdb) frame 4
  #4  0x0000564154ad9147 in pcibus_reset (qbus=3D0x564156760d10) at ../hw/p=
ci/pci.c:311
  warning: Source file is more recent than executable.
  311             assert(bus->irq_count[i] =3D=3D 0);
  (gdb) ^CQuit
  (gdb) p bus->irq_count[i]
  $1 =3D -1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1702621/+subscriptions
