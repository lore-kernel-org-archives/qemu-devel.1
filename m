Received: from eggs.gnu.org ([2001:4830:134:3::10]:42168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxEbg-0002zj-PZ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxEbd-0001hV-Mw
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:50:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dxEbd-0001hL-GP
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:50:37 -0400
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b5786d73-10f9-bba8-28c6-275cdf623004@redhat.com>
Date: Wed, 27 Sep 2017 17:50:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Problem in pcie_pci_bridge_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Aleksandr Bezzubikov <zuban32s@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

 Hi,

QEMU currently aborts with an assertion when plugging of the
pcie-pci-bridge fails, e.g.:

$ mips64el-softmmu/qemu-system-mips64el -M malta -nographic -S \
                -device pcie-pci-bridge -bios pc-bios/bios.bin=20
qemu-system-mips64el: memory.c:1699: memory_region_finalize:
 Assertion `!mr->container' failed.
Aborted (core dumped)

The backtrace points to the pcie_pci_bridge_realize() function:

#0  0x00007ffff150f1f7 in raise () at /lib64/libc.so.6
#1  0x00007ffff15108e8 in abort () at /lib64/libc.so.6
#2  0x00007ffff1508266 in __assert_fail_base () at /lib64/libc.so.6
#3  0x00007ffff1508312 in  () at /lib64/libc.so.6
#4  0x00005555557cedaf in memory_region_finalize (obj=3D<optimized out>)
    at /home/thuth/devel/qemu/memory.c:1699
#5  0x0000555555a49852 in object_unref (type=3D<optimized out>, obj=3D0x5=
55556e68580)
    at /home/thuth/devel/qemu/qom/object.c:453
#6  0x0000555555a49852 in object_unref (data=3D0x555556e68580) at /home/t=
huth/devel/qemu/qom/object.c:467
#7  0x0000555555a49852 in object_unref (obj=3D0x555556e68580) at /home/th=
uth/devel/qemu/qom/object.c:902
#8  0x0000555555a48887 in object_property_del_child (obj=3D0x555556dc7760=
, child=3Dchild@entry=3D0x555556e68580, errp=3D0x0) at /home/thuth/devel/=
qemu/qom/object.c:427
#9  0x0000555555a490a4 in object_unparent (obj=3Dobj@entry=3D0x555556e685=
80)
    at /home/thuth/devel/qemu/qom/object.c:446
#10 0x00005555559906ae in shpc_free (d=3Dd@entry=3D0x555556dc7760)
    at /home/thuth/devel/qemu/hw/pci/shpc.c:676
#11 0x0000555555987470 in pcie_pci_bridge_realize (d=3D0x555556dc7760, er=
rp=3D0x7fffffffd710)
    at /home/thuth/devel/qemu/hw/pci-bridge/pcie_pci_bridge.c:84
#12 0x000055555598ca67 in pci_qdev_realize (qdev=3D0x555556dc7760, errp=3D=
0x7fffffffd7b0)
    at /home/thuth/devel/qemu/hw/pci/pci.c:2024
#13 0x000055555590ee4a in device_set_realized (obj=3D<optimized out>, val=
ue=3D<optimized out>, errp=3D0x7fffffffd8e8) at /home/thuth/devel/qemu/hw=
/core/qdev.c:914

Any clue what might be wrong here?

 Thomas
