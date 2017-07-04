Received: from eggs.gnu.org ([2001:4830:134:3::10]:41822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZY-0004LW-Hh
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZX-0003BY-IN
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZX-0003BC-9Y
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E8AD8553F
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:30 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:45 +0800
Message-Id: <20170704064347.7022-19-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 18/20] mips_cmgcr: Convert to
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
 hw/misc/mips_cmgcr.c         | 22 ++++++----------------
 include/hw/misc/mips_cmgcr.h |  5 +++--
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index a1edb53..f9b2a67 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -48,9 +48,9 @@ static inline void update_cpc_base(MIPSGCRState *gcr, uint64_t val)
     if (is_cpc_connected(gcr)) {
         gcr->cpc_base = val & GCR_CPC_BASE_MSK;
         memory_region_transaction_begin();
-        memory_region_set_address(gcr->cpc_mr,
+        memory_region_set_address(MEMORY_REGION(gcr->cpc_mr),
                                   gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK);
-        memory_region_set_enabled(gcr->cpc_mr,
+        memory_region_set_enabled(MEMORY_REGION(gcr->cpc_mr),
                                   gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
         memory_region_transaction_commit();
     }
@@ -61,9 +61,9 @@ static inline void update_gic_base(MIPSGCRState *gcr, uint64_t val)
     if (is_gic_connected(gcr)) {
         gcr->gic_base = val & GCR_GIC_BASE_MSK;
         memory_region_transaction_begin();
-        memory_region_set_address(gcr->gic_mr,
+        memory_region_set_address(MEMORY_REGION(gcr->gic_mr),
                                   gcr->gic_base & GCR_GIC_BASE_GICBASE_MSK);
-        memory_region_set_enabled(gcr->gic_mr,
+        memory_region_set_enabled(MEMORY_REGION(gcr->gic_mr),
                                   gcr->gic_base & GCR_GIC_BASE_GICEN_MSK);
         memory_region_transaction_commit();
     }
@@ -181,18 +181,6 @@ static void mips_gcr_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     MIPSGCRState *s = MIPS_GCR(obj);
 
-    object_property_add_link(obj, "gic", TYPE_MEMORY_REGION,
-                             (Object **)&s->gic_mr,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-
-    object_property_add_link(obj, "cpc", TYPE_MEMORY_REGION,
-                             (Object **)&s->cpc_mr,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-
     memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
                           "mips-gcr", GCR_ADDRSPACE_SZ);
     sysbus_init_mmio(sbd, &s->iomem);
@@ -227,6 +215,8 @@ static Property mips_gcr_properties[] = {
     DEFINE_PROP_INT32("num-vp", MIPSGCRState, num_vps, 1),
     DEFINE_PROP_INT32("gcr-rev", MIPSGCRState, gcr_rev, 0x800),
     DEFINE_PROP_UINT64("gcr-base", MIPSGCRState, gcr_base, GCR_BASE_ADDR),
+    DEFINE_PROP_LINK("gic", MIPSGCRState, gic_mr, TYPE_MEMORY_REGION),
+    DEFINE_PROP_LINK("cpc", MIPSGCRState, cpc_mr, TYPE_MEMORY_REGION),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/misc/mips_cmgcr.h b/include/hw/misc/mips_cmgcr.h
index c9dfcb4..f2b3577 100644
--- a/include/hw/misc/mips_cmgcr.h
+++ b/include/hw/misc/mips_cmgcr.h
@@ -76,8 +76,9 @@ struct MIPSGCRState {
     int32_t num_vps;
     hwaddr gcr_base;
     MemoryRegion iomem;
-    MemoryRegion *cpc_mr;
-    MemoryRegion *gic_mr;
+    /* MemoryRegion pointers for cpc and gic, to be filled by link property */
+    Object *cpc_mr;
+    Object *gic_mr;
 
     uint64_t cpc_base;
     uint64_t gic_base;
-- 
2.9.4
