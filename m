Received: from eggs.gnu.org ([209.51.188.92]:40818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxApT-0000tn-5T
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAeR-0004JF-V9
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35190
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAeP-0003vE-SG
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:02 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDB6me114213
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:39 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qtgx32yn0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:38 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:37 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:18 +0100
In-Reply-To: <20190222131322.26079-1-clg@kaod.org>
References: <20190222131322.26079-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-10-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/13] sysbus: add a sysbus_mmio_unmap()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This will be used to remove the MMIO regions of the POWER9 XIVE
interrupt controller when the sPAPR machine is reseted.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
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
