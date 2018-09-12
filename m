Received: from eggs.gnu.org ([2001:4830:134:3::10]:40529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kallisti5@unixzen.com>) id 1g08yM-0005Uo-Qz
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kallisti5@unixzen.com>) id 1g08yI-0005WU-8n
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:30:38 -0400
Received: from mx.dal1.terarocket.io ([108.61.222.170]:43116)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kallisti5@unixzen.com>) id 1g08yH-0005W7-VG
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:30:34 -0400
MIME-Version: 1.0
Date: Wed, 12 Sep 2018 17:30:29 +0000
From: "Alexander von Gluck IV" <kallisti5@unixzen.com>
Message-ID: <72e9368e256e81fd69e3f6c65e6dd435@unixzen.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Debugging PCI Enhanced Allocation - IOMMU of a bridge?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com

Good morning!=0A=0AI'm working through adding support (or at least ignori=
ng) PCI Enhance Allocation devices under Haiku.=0AWe run into one of thes=
e devices, and crash at boot due to attempting to read an invalid address=
.=0A=0AOur testing showed that with a USB C dongle plugged in, we don't c=
rash. Without it plugged in we get=0Ainvalid addresses from PCI=0A=0A(for=
 a long-drawn out debug ticket, see https://dev.haiku-os.org/ticket/12885=
 )=0ASo, i'm trying to see if I can emulate a PCI bridge with EA under QE=
MU, I found this patch, but it seems  it wasn't accepted:   https://lists=
.gnu.org/archive/html/qemu-devel/2015-05/msg02073.html (https://lists.gnu=
.org/archive/html/qemu-devel/2015-05/msg02073.html)=0A=0AMy other thought=
 is since I have access to two laptops implementing this, I could attach =
the bridge to=0Aqemu via iommu, but the new vfio stuff doesn't seem to wo=
rk with bridges. :-|   Anyone know of a way to:  * emulate a PCI EA in qe=
mu.  * attach the local PCI EA bridge to qemu to troubleshoot using real =
hardware.  For context, here is the suspect EA device:=0A(no USB C dongle=
)=0A$ lspci -tvnn=0A-[0000:00]-+-00.0 Intel Corporation Xeon E3-1200 v5/E=
3-1500 v5/6th Gen Core Processor Host Bridge/DRAM Registers [8086:1910]=
=0A +-1d.6-[06-3e]--=0A=0Avs=0A=0A(USB C dongle)=0A$ lspci -tvnn=0A-[0000=
:00]-+-00.0 Intel Corporation Skylake Host Bridge/DRAM Registers [8086:19=
04]=0A +-1d.6-[06-3e]----00.0-[07-3e]--+-00.0-[08]--=0A | +-01.0-[09-3d]-=
-=0A | -02.0-[3e]----00.0 Intel Corporation DSL6340 USB 3.1 Controller [A=
lpine Ridge] [8086:15b5]=0AThe bride is at 1d.6 in it's own IOMMU group:=
=0A=0AIOMMU group 12=0A 00:1d.6 PCI bridge [0604]: Intel Corporation 100 =
Series/C230 Series Chipset Family PCI Express Root Port #15 [8086:a11e] (=
rev f1)=0A=0A -- Alex
