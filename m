Received: from eggs.gnu.org ([2001:4830:134:3::10]:35961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucH-00086S-AD
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucG-0004dl-91
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:25 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:42521)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucG-0004a6-33
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:24 -0500
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
	by Forcepoint Email with ESMTPS id 9C7CB4EA56025
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 20:31:11 +0000 (GMT)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Feb 2017 20:30:55 +0000
Message-ID: <1487622662-62984-2-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1487622662-62984-1-git-send-email-yongbok.kim@imgtec.com>
References: <1487622662-62984-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 1/8] hw/mips_cmgcr: allow GCR base to be moved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Paul Burton <paul.burton@imgtec.com>

Support moving the GCR base address & updating the CPU's CP0 CMGCRBase
register appropriately. This is required if a platform needs to move its
GCRs away from other memory, as the MIPS Boston development board does
to avoid its flash memory.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Leon Alrae <leon.alrae@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/misc/mips_cmgcr.c         | 17 +++++++++++++++++
 include/hw/misc/mips_cmgcr.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index b3ba166..a1edb53 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -29,6 +29,20 @@ static inline bool is_gic_connected(MIPSGCRState *s)
     return s->gic_mr != NULL;
 }
 
+static inline void update_gcr_base(MIPSGCRState *gcr, uint64_t val)
+{
+    CPUState *cpu;
+    MIPSCPU *mips_cpu;
+
+    gcr->gcr_base = val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    CPU_FOREACH(cpu) {
+        mips_cpu = MIPS_CPU(cpu);
+        mips_cpu->env.CP0_CMGCRBase = gcr->gcr_base >> 4;
+    }
+}
+
 static inline void update_cpc_base(MIPSGCRState *gcr, uint64_t val)
 {
     if (is_cpc_connected(gcr)) {
@@ -117,6 +131,9 @@ static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
     MIPSGCRVPState *other_vps = &gcr->vps[current_vps->other];
 
     switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
     case GCR_GIC_BASE_OFS:
         update_gic_base(gcr, data);
         break;
diff --git a/include/hw/misc/mips_cmgcr.h b/include/hw/misc/mips_cmgcr.h
index a209d91..c9dfcb4 100644
--- a/include/hw/misc/mips_cmgcr.h
+++ b/include/hw/misc/mips_cmgcr.h
@@ -41,6 +41,9 @@
 #define GCR_L2_CONFIG_BYPASS_SHF    20
 #define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
 
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
 /* GCR_GIC_BASE register fields */
 #define GCR_GIC_BASE_GICEN_MSK   1
 #define GCR_GIC_BASE_GICBASE_MSK 0xFFFFFFFE0000ULL
-- 
2.7.4
