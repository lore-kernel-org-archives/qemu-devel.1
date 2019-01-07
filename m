Received: from eggs.gnu.org ([209.51.188.92]:43928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZq1-0003RR-Ui
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZpz-00041g-Ia
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:41:25 -0500
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:49809)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ggZpn-0003Rr-2a
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:41:16 -0500
Received: from player687.ha.ovh.net (unknown [10.109.159.132])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id B7EBB44E1D
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 19:41:03 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  7 Jan 2019 19:39:42 +0100
Message-Id: <20190107183946.7230-10-clg@kaod.org>
In-Reply-To: <20190107183946.7230-1-clg@kaod.org>
References: <20190107183946.7230-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/13] sysbus: add a sysbus_mmio_unmap() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This will be used to remove the MMIO regions of the POWER9 XIVE
interrupt controller when the sPAPR machine is reseted.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/sysbus.h |  1 +
 hw/core/sysbus.c    | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 1aedcf05c92b..4c668fbbdc60 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -89,6 +89,7 @@ qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, in=
t n);
 void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority);
+void sysbus_mmio_unmap(SysBusDevice *dev, int n);
 void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
                    MemoryRegion *mem);
 MemoryRegion *sysbus_address_space(SysBusDevice *dev);
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 9f9edbcab96f..f90d87b058c3 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -153,6 +153,16 @@ static void sysbus_mmio_map_common(SysBusDevice *dev=
, int n, hwaddr addr,
     }
 }
=20
+void sysbus_mmio_unmap(SysBusDevice *dev, int n)
+{
+    assert(n >=3D 0 && n < dev->num_mmio);
+
+    if (dev->mmio[n].addr !=3D (hwaddr)-1) {
+        memory_region_del_subregion(get_system_memory(), dev->mmio[n].me=
mory);
+        dev->mmio[n].addr =3D (hwaddr)-1;
+    }
+}
+
 void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
 {
     sysbus_mmio_map_common(dev, n, addr, false, 0);
--=20
2.20.1
