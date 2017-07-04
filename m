Received: from eggs.gnu.org ([2001:4830:134:3::10]:41788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZS-0004Dh-5a
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZR-00039P-8t
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZQ-000391-Vv
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1738C0587DE
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:23 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:42 +0800
Message-Id: <20170704064347.7022-16-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 15/20] xlnx_zynqmp: Convert to
 DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/arm/xlnx-zynqmp.c         | 12 ++++--------
 include/hw/arm/xlnx-zynqmp.h |  3 ++-
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 64f52f8..2ce9cad 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -140,11 +140,6 @@ static void xlnx_zynqmp_init(Object *obj)
                                   &error_abort);
     }
 
-    object_property_add_link(obj, "ddr-ram", TYPE_MEMORY_REGION,
-                             (Object **)&s->ddr_ram,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, &error_abort);
-
     object_initialize(&s->gic, sizeof(s->gic), gic_class_name());
     qdev_set_parent_bus(DEVICE(&s->gic), sysbus_get_default());
 
@@ -192,7 +187,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     qemu_irq gic_spi[GIC_NUM_SPI_INTR];
     Error *err = NULL;
 
-    ram_size = memory_region_size(s->ddr_ram);
+    ram_size = memory_region_size(MEMORY_REGION(s->ddr_ram));
 
     /* Create the DDR Memory Regions. User friendly checks should happen at
      * the board level
@@ -206,7 +201,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         ddr_high_size = ram_size - XLNX_ZYNQMP_MAX_LOW_RAM_SIZE;
 
         memory_region_init_alias(&s->ddr_ram_high, NULL,
-                                 "ddr-ram-high", s->ddr_ram,
+                                 "ddr-ram-high", MEMORY_REGION(s->ddr_ram),
                                   ddr_low_size, ddr_high_size);
         memory_region_add_subregion(get_system_memory(),
                                     XLNX_ZYNQMP_HIGH_RAM_START,
@@ -218,7 +213,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     memory_region_init_alias(&s->ddr_ram_low, NULL,
-                             "ddr-ram-low", s->ddr_ram,
+                             "ddr-ram-low", MEMORY_REGION(s->ddr_ram),
                               0, ddr_low_size);
     memory_region_add_subregion(get_system_memory(), 0, &s->ddr_ram_low);
 
@@ -434,6 +429,7 @@ static Property xlnx_zynqmp_props[] = {
     DEFINE_PROP_STRING("boot-cpu", XlnxZynqMPState, boot_cpu),
     DEFINE_PROP_BOOL("secure", XlnxZynqMPState, secure, false),
     DEFINE_PROP_BOOL("has_rpu", XlnxZynqMPState, has_rpu, false),
+    DEFINE_PROP_LINK("ddr-ram", XlnxZynqMPState, ddr_ram, TYPE_MEMORY_REGION),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index c2931bf..efd4c1a 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -75,7 +75,8 @@ typedef struct XlnxZynqMPState {
 
     MemoryRegion ocm_ram[XLNX_ZYNQMP_NUM_OCM_BANKS];
 
-    MemoryRegion *ddr_ram;
+    /* A MemoryRegion pointer to be filled by link property */
+    Object *ddr_ram;
     MemoryRegion ddr_ram_low, ddr_ram_high;
 
     CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
-- 
2.9.4
