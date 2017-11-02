Received: from eggs.gnu.org ([2001:4830:134:3::10]:38036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAGLC-0000nb-Ps
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAGL8-0005cg-QJ
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:19:30 -0400
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a0750de5-d3ce-3f15-ba12-ce383ded143d@redhat.com>
Date: Thu, 2 Nov 2017 15:19:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Crash with pcie-pci-bridge on qemu-system-s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org
Cc: Aleksandr Bezzubikov <zuban32s@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

 Hi,

seems like there's a new way to crash QEMU with the pcie-pci-bridge
device (using QEMU master branch of today):

$ s390x-softmmu/qemu-system-s390x -nographic -S
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) device_add pcie-pci-bridge,id=3Dx
Segmentation fault (core dumped)

Does anybody have a clue what might be wrong here?

Backtrace looks like this:

#0  0x000055555577064b in pci_default_write_config (d=3Dd@entry=3D0x0,
addr=3Daddr@entry=3D26, val_in=3D1, l=3Dl@entry=3D1) at
/home/thuth/devel/qemu/hw/pci/pci.c:1367
#1  0x00005555556c885f in s390_pcihost_hot_plug (hotplug_dev=3D<optimized
out>, dev=3D0x55555639b160, errp=3D0x7fffffffc5a0) at
/home/thuth/devel/qemu/hw/s390x/s390-pci-bus.c:684
#2  0x000055555575afeb in device_set_realized (obj=3D<optimized out>,
value=3D<optimized out>, errp=3D0x7fffffffc6d8) at
/home/thuth/devel/qemu/hw/core/qdev.c:936
#3  0x00005555557ee48e in property_set_bool (obj=3D0x55555639b160,
v=3D<optimized out>, name=3D<optimized out>, opaque=3D0x555556399fe0,
errp=3D0x7fffffffc6d8)
    at /home/thuth/devel/qemu/qom/object.c:1906
#4  0x00005555557f25ff in object_property_set_qobject
(obj=3Dobj@entry=3D0x55555639b160, value=3Dvalue@entry=3D0x55555639d170,
name=3Dname@entry=3D0x5555559a4157 "realized",
errp=3Derrp@entry=3D0x7fffffffc6d8) at
/home/thuth/devel/qemu/qom/qom-qobject.c:27
#5  0x00005555557f0270 in object_property_set_bool (obj=3D0x55555639b160,
value=3D<optimized out>, name=3D0x5555559a4157 "realized", errp=3D0x7ffff=
fffc6d8)
    at /home/thuth/devel/qemu/qom/object.c:1171
#6  0x000055555570b549 in qdev_device_add
(opts=3Dopts@entry=3D0x55555640cb50, errp=3Derrp@entry=3D0x7fffffffc7b0) =
at
/home/thuth/devel/qemu/qdev-monitor.c:632
...

 Thomas
