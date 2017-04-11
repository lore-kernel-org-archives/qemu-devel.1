Received: from eggs.gnu.org ([2001:4830:134:3::10]:34309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxrDF-0001rU-F8
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxrDA-0004Jd-Go
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:31:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:56765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cxrDA-0004JN-BH
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:31:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cxrD8-0006rz-39
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 08:31:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 615152E80E7
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 08:31:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Apr 2017 08:21:40 -0000
From: Lidong Chen <jemmy858585@gmail.com>
Reply-To: Bug 1681688 <1681688@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170411080154.12474.20009.malonedeb@gac.canonical.com>
Message-Id: <20170411082140.1520.57032.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1681688] Re: qemu live migration failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

blk->root->perm is 1 when blk_new_open.

the blk->root->perm is update to 3 during virtio_blk_device_realize.

but after this commit, the blk->root->perm is still 1. and cause
bdrv_aligned_pwritev failed.

Breakpoint 1, blk_set_perm (blk=3D0x14c32b0, perm=3D3, shared_perm=3D29, er=
rp=3D0x7fffffffd380) at block/block-backend.c:579
579     {
(gdb) bt
#0  blk_set_perm (blk=3D0x14c32b0, perm=3D3, shared_perm=3D29, errp=3D0x7ff=
fffffd380) at block/block-backend.c:579
#1  0x000000000063484b in blkconf_apply_backend_options (conf=3D0x2de7fd0, =
readonly=3Dfalse, resizable=3Dtrue, errp=3D0x7fffffffd380) at hw/block/bloc=
k.c:77
#2  0x00000000004a57bd in virtio_blk_device_realize (dev=3D0x2de7e30, errp=
=3D0x7fffffffd3e0) at /data/qemu/hw/block/virtio-blk.c:931
#3  0x00000000004f688e in virtio_device_realize (dev=3D0x2de7e30, errp=3D0x=
7fffffffd468) at /data/qemu/hw/virtio/virtio.c:2485
#4  0x000000000065806f in device_set_realized (obj=3D0x2de7e30, value=3Dtru=
e, errp=3D0x7fffffffd6d8) at hw/core/qdev.c:939
#5  0x000000000083aaf5 in property_set_bool (obj=3D0x2de7e30, v=3D0x2e67a90=
, name=3D0xaf4b53 "realized", opaque=3D0x2de9660, errp=3D0x7fffffffd6d8) at=
 qom/object.c:1860
#6  0x0000000000838c46 in object_property_set (obj=3D0x2de7e30, v=3D0x2e67a=
90, name=3D0xaf4b53 "realized", errp=3D0x7fffffffd6d8) at qom/object.c:1094
#7  0x000000000083c23f in object_property_set_qobject (obj=3D0x2de7e30, val=
ue=3D0x2e679e0, name=3D0xaf4b53 "realized", errp=3D0x7fffffffd6d8) at qom/q=
om-qobject.c:27
#8  0x0000000000838f9a in object_property_set_bool (obj=3D0x2de7e30, value=
=3Dtrue, name=3D0xaf4b53 "realized", errp=3D0x7fffffffd6d8) at qom/object.c=
:1163
#9  0x00000000007bafac in virtio_blk_pci_realize (vpci_dev=3D0x2ddf920, err=
p=3D0x7fffffffd6d8) at hw/virtio/virtio-pci.c:1975
#10 0x00000000007ba966 in virtio_pci_realize (pci_dev=3D0x2ddf920, errp=3D0=
x7fffffffd6d8) at hw/virtio/virtio-pci.c:1853
#11 0x000000000071e439 in pci_qdev_realize (qdev=3D0x2ddf920, errp=3D0x7fff=
ffffd7b8) at hw/pci/pci.c:2001
#12 0x00000000007badaa in virtio_pci_dc_realize (qdev=3D0x2ddf920, errp=3D0=
x7fffffffd7b8) at hw/virtio/virtio-pci.c:1930
#13 0x000000000065806f in device_set_realized (obj=3D0x2ddf920, value=3Dtru=
e, errp=3D0x7fffffffd9a8) at hw/core/qdev.c:939
#14 0x000000000083aaf5 in property_set_bool (obj=3D0x2ddf920, v=3D0x2decfd0=
, name=3D0x9b2c0e "realized", opaque=3D0x2ddf5d0, errp=3D0x7fffffffd9a8) at=
 qom/object.c:1860
#15 0x0000000000838c46 in object_property_set (obj=3D0x2ddf920, v=3D0x2decf=
d0, name=3D0x9b2c0e "realized", errp=3D0x7fffffffd9a8) at qom/object.c:1094
#16 0x000000000083c23f in object_property_set_qobject (obj=3D0x2ddf920, val=
ue=3D0x2dece90, name=3D0x9b2c0e "realized", errp=3D0x7fffffffd9a8) at qom/q=
om-qobject.c:27
#17 0x0000000000838f9a in object_property_set_bool (obj=3D0x2ddf920, value=
=3Dtrue, name=3D0x9b2c0e "realized", errp=3D0x7fffffffd9a8) at qom/object.c=
:1163
#18 0x00000000005bfcea in qdev_device_add (opts=3D0x1451320, errp=3D0x7ffff=
fffda30) at qdev-monitor.c:624
#19 0x00000000005c9662 in device_init_func (opaque=3D0x0, opts=3D0x1451320,=
 errp=3D0x0) at vl.c:2305
#20 0x000000000095f491 in qemu_opts_foreach (list=3D0xe5bd80, func=3D0x5c96=
24 <device_init_func>, opaque=3D0x0, errp=3D0x0) at util/qemu-option.c:1114
#21 0x00000000005ce9be in main (argc=3D46, argv=3D0x7fffffffdeb8, envp=3D0x=
7fffffffe030) at vl.c:4583

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1681688

Title:
  qemu live migration failed

Status in QEMU:
  New

Bug description:
  qemu live migration failed

  the dest qemu report this error.

  Receiving block device images
  Completed 0 %^Mqemu-system-x86_64: block/io.c:1348: bdrv_aligned_pwritev:=
 Assertion `child->perm & BLK_PERM_WRITE' failed.

  this bug is caused by this patch:
  http://git.qemu-project.org/?p=3Dqemu.git;a=3Dcommit;h=3Dd35ff5e6b3aa3a70=
6b0aa3bcf11400fac945b67a

  rollback this commit, the problem solved.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1681688/+subscriptions
