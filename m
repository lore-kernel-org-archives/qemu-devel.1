Received: from eggs.gnu.org ([2001:4830:134:3::10]:57245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cvGLi-0007Tb-Qe
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 00:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cvGLf-0003XP-Nl
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 00:45:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:56396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cvGLf-0003Wk-EN
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 00:45:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cvGLd-00089u-Sw
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 04:45:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D46D52E80C2
	for <qemu-devel@nongnu.org>; Tue,  4 Apr 2017 04:45:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Apr 2017 04:37:19 -0000
From: Alex Williamson <alex.l.williamson@gmail.com>
Reply-To: Bug 1678466 <1678466@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170401120201.1125.46046.malonedeb@gac.canonical.com>
Message-Id: <20170404043719.9723.61824.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1678466] Re: using x-vga=on with vfio-pci leads
 to segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Does this resolve the segfault?

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index e9b493b939db..349085ea12bc 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -660,7 +660,7 @@ static void vfio_probe_nvidia_bar5_quirk(VFIOPCIDevice =
*vdev
     VFIOConfigWindowQuirk *window;
 =

     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
-        !vdev->vga || nr !=3D 5) {
+        !vdev->vga || nr !=3D 5 || !vdev->bars[5].ioport) {
         return;
     }

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1678466

Title:
  using x-vga=3Don with vfio-pci leads to segfault

Status in QEMU:
  New

Bug description:
  bug occures at least with qemu 2.8.0 and 2.8.1 in 64bit-system

  stripped cmd for minimal config:
  qemu-system-i386 -m 2048 -M q35  -enable-kvm -nodefaults -nodefconfig -de=
vice ioh3420,bus=3Dpcie.0,addr=3D0x9,multifunction=3Don,port=3D1,chassis=3D=
1,id=3Droot.1 -device vfio-pci,host=3D01:00.0,bus=3Droot.1,addr=3D01.0,x-vg=
a=3Don

  Backtrace is:
  #0  0x00005555557ca836 in memory_region_update_container_subregions (subr=
egion=3D0x55555828f2f0) at qemu-2.8.1/memory.c:2030
  #1  0x00005555557ca9dc in memory_region_add_subregion_common (mr=3D0x0, o=
ffset=3D8, subregion=3D0x55555828f2f0) at qemu-2.8.1/memory.c:2049
  #2  0x00005555557caa9a in memory_region_add_subregion_overlap (mr=3D0x0, =
offset=3D8, subregion=3D0x55555828f2f0, priority=3D1) at qemu-2.8.1/memory.=
c:2066
  #3  0x0000555555832e48 in vfio_probe_nvidia_bar5_quirk (vdev=3D0x55555805=
aef0, nr=3D5) at qemu-2.8.1/hw/vfio/pci-quirks.c:689
  #4  0x0000555555835433 in vfio_bar_quirk_setup (vdev=3D0x55555805aef0, nr=
=3D5) at qemu-2.8.1/hw/vfio/pci-quirks.c:1652
  #5  0x000055555582f122 in vfio_realize (pdev=3D0x55555805aef0, errp=3D0x7=
fffffffdc78) at qemu-2.8.1/hw/vfio/pci.c:2777
  #6  0x0000555555a86195 in pci_qdev_realize (qdev=3D0x55555805aef0, errp=
=3D0x7fffffffdcf0) at hw/pci/pci.c:1966
  #7  0x00005555559be7b7 in device_set_realized (obj=3D0x55555805aef0, valu=
e=3Dtrue, errp=3D0x7fffffffdeb0) at hw/core/qdev.c:918
  #8  0x0000555555bb017f in property_set_bool (obj=3D0x55555805aef0, v=3D0x=
55555805ced0, name=3D0x555556071b56 "realized", opaque=3D0x555557f15860, er=
rp=3D0x7fffffffdeb0) at qom/object.c:1854
  #9  0x0000555555bae2e6 in object_property_set (obj=3D0x55555805aef0, v=3D=
0x55555805ced0, name=3D0x555556071b56 "realized", errp=3D0x7fffffffdeb0) at=
 qom/object.c:1088
  #10 0x0000555555bb184f in object_property_set_qobject (obj=3D0x55555805ae=
f0, value=3D0x55555805cd70, name=3D0x555556071b56 "realized", errp=3D0x7fff=
ffffdeb0) at qom/qom-qobject.c:27
  #11 0x0000555555bae637 in object_property_set_bool (obj=3D0x55555805aef0,=
 value=3Dtrue, name=3D0x555556071b56 "realized", errp=3D0x7fffffffdeb0) at =
qom/object.c:1157
  #12 0x00005555558fee4b in qdev_device_add (opts=3D0x555556b15160, errp=3D=
0x7fffffffdf28) at qdev-monitor.c:623
  #13 0x00005555559142c1 in device_init_func (opaque=3D0x0, opts=3D0x555556=
b15160, errp=3D0x0) at vl.c:2373
  #14 0x0000555555cc3bb7 in qemu_opts_foreach (list=3D0x555556548b80 <qemu_=
device_opts>, func=3D0x555555914283 <device_init_func>, opaque=3D0x0, errp=
=3D0x0) at util/qemu-option.c:1116
  #15 0x00005555559198aa in main (argc=3D12, argv=3D0x7fffffffe388, envp=3D=
0x7fffffffe3f0) at vl.c:4574

  as I can see, it happens during initialization of the device-option.

  seems that the code tries to loop over a memory-region mr, which is
  null from at least three calls before it crashes.

  because there seems to be special handling for nvidia-cards, here're the =
pci-infos of the card:
  01:00.0 VGA compatible controller [0300]: NVIDIA Corporation G72 [GeForce=
 7300 GS] [10de:01df] (rev a1) (prog-if 00 [VGA controller])
  	Subsystem: Gigabyte Technology Co., Ltd Device [1458:342a]
  	Flags: fast devsel, IRQ 16
  	Memory at de000000 (32-bit, non-prefetchable) [disabled] [size=3D16M]
  	Memory at c0000000 (64-bit, prefetchable) [disabled] [size=3D256M]
  	Memory at dd000000 (64-bit, non-prefetchable) [disabled] [size=3D16M]
  	Expansion ROM at df000000 [disabled] [size=3D128K]
  	Capabilities: [60] Power Management version 2
  	Capabilities: [68] MSI: Enable- Count=3D1/1 Maskable- 64bit+
  	Capabilities: [78] Express Endpoint, MSI 00
  	Capabilities: [100] Virtual Channel
  	Capabilities: [128] Power Budgeting <?>
  	Kernel driver in use: vfio-pci

  at least with a similar card in another slot the crash does not occure.
  (sorry, can't change the slots at the moment)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1678466/+subscriptions
