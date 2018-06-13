Received: from eggs.gnu.org ([2001:4830:134:3::10]:34232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSzib-0002wm-UY
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSziX-0006Wx-C5
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:57:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 13 Jun 2018 16:57:03 +1000
Message-Id: <20180613065707.30766-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180613065707.30766-1-david@gibson.dropbear.id.au>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 3/7] pnv_core: Allocate cpu thread objects
 individually
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Currently, we allocate space for all the cpu objects within a single core
in one big block.  This was copied from an older version of the spapr code
and requires some ugly pointer manipulation to extract the individual
objects.

This design was due to a misunderstanding of qemu lifetime conventions and
has already been changed in spapr (in 94ad93bd "spapr_cpu_core: instantiate
CPUs separately".

Make an equivalent change in pnv_core to get rid of the nasty pointer
arithmetic.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c              |  4 ++--
 hw/ppc/pnv_core.c         | 11 +++++------
 include/hw/ppc/pnv_core.h |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0314881316..0b9508d94d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -121,9 +121,9 @@ static int get_cpus_node(void *fdt)
  */
 static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 {
-    CPUState *cs = CPU(DEVICE(pc->threads));
+    PowerPCCPU *cpu = pc->threads[0];
+    CPUState *cs = CPU(cpu);
     DeviceClass *dc = DEVICE_GET_CLASS(cs);
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
     int smt_threads = CPU_CORE(pc)->nr_threads;
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index efb68226bb..59309e149c 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -151,7 +151,6 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     PnvCore *pc = PNV_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
     const char *typename = pnv_core_cpu_typename(pc);
-    size_t size = object_type_get_instance_size(typename);
     Error *local_err = NULL;
     void *obj;
     int i, j;
@@ -165,11 +164,11 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    pc->threads = g_malloc0(size * cc->nr_threads);
+    pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        obj = pc->threads + i * size;
+        obj = object_new(typename);
 
-        object_initialize(obj, size, typename);
+        pc->threads[i] = POWERPC_CPU(obj);
 
         snprintf(name, sizeof(name), "thread[%d]", i);
         object_property_add_child(OBJECT(pc), name, obj, &local_err);
@@ -185,7 +184,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
-        obj = pc->threads + j * size;
+        obj = OBJECT(pc->threads[j]);
 
         pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
         if (local_err) {
@@ -200,7 +199,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
 
 err:
     while (--i >= 0) {
-        obj = pc->threads + i * size;
+        obj = OBJECT(pc->threads[i]);
         object_unparent(obj);
     }
     g_free(pc->threads);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index e337af7a3a..447ae761f7 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -34,7 +34,7 @@ typedef struct PnvCore {
     CPUCore parent_obj;
 
     /*< public >*/
-    void *threads;
+    PowerPCCPU **threads;
     uint32_t pir;
 
     MemoryRegion xscom_regs;
-- 
2.17.1
