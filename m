Received: from eggs.gnu.org ([2001:4830:134:3::10]:41740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZN-00049O-1i
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZK-00036L-Hr
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZK-000365-As
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43523369C9
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:17 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:39 +0800
Message-Id: <20170704064347.7022-13-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/20] armv7m: Convert bitband.source-mamory
 to DEFINE_PROP_LINK
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
 hw/arm/armv7m.c         | 10 +++-------
 include/hw/arm/armv7m.h |  3 ++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index c8a11f2..3a13d82 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -97,12 +97,6 @@ static void bitband_init(Object *obj)
     BitBandState *s = BITBAND(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    object_property_add_link(obj, "source-memory",
-                             TYPE_MEMORY_REGION,
-                             (Object **)&s->source_memory,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
     memory_region_init_io(&s->iomem, obj, &bitband_ops, s,
                           "bitband", 0x02000000);
     sysbus_init_mmio(dev, &s->iomem);
@@ -117,7 +111,7 @@ static void bitband_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    s->source_as = address_space_init_shareable(s->source_memory,
+    s->source_as = address_space_init_shareable(MEMORY_REGION(s->source_memory),
                                                 "bitband-source");
 }
 
@@ -349,6 +343,8 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
 
 static Property bitband_properties[] = {
     DEFINE_PROP_UINT32("base", BitBandState, base, 0),
+    DEFINE_PROP_LINK("source-memory", BitBandState, source_memory,
+                     TYPE_MEMORY_REGION),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index a9b3f2a..1b4ce5b 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -24,7 +24,8 @@ typedef struct {
     AddressSpace *source_as;
     MemoryRegion iomem;
     uint32_t base;
-    MemoryRegion *source_memory;
+    /* MemoryRegion pointer to be filled by link property */
+    Object *source_memory;
 } BitBandState;
 
 #define TYPE_ARMV7M "armv7m"
-- 
2.9.4
