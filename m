Received: from eggs.gnu.org ([2001:4830:134:3::10]:57516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98w8-0000Nw-L4
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98w4-0000F0-MK
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:16 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:44186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98w4-0000E5-GJ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:12 -0400
Received: from player792.ha.ovh.net (unknown [10.109.122.68])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 59B2CDFF63
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:45:11 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:11 +0200
Message-Id: <20180419124331.3915-16-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 15/35] sysbus: add a sysbus_mmio_unmap()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This will be used to remove the MMIO regions of the POWER9 XIVE
interrupt controller when the sPAPR machine is reseted.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/core/sysbus.c    | 10 ++++++++++
 include/hw/sysbus.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 5d0887f499de..e31f8e6be2f1 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -152,6 +152,16 @@ static void sysbus_mmio_map_common(SysBusDevice *dev=
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
diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index e88bb6dae0c1..2446983de167 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -92,6 +92,7 @@ qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, in=
t n);
 void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority);
+void sysbus_mmio_unmap(SysBusDevice *dev, int n);
 void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
                    MemoryRegion *mem);
 MemoryRegion *sysbus_address_space(SysBusDevice *dev);
--=20
2.13.6
