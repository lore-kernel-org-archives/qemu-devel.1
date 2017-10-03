Received: from eggs.gnu.org ([2001:4830:134:3::10]:57722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzFZw-0007Cs-3C
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 01:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzFZr-0000xt-NI
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 01:17:12 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue,  3 Oct 2017 16:17:01 +1100
Message-Id: <20171003051701.17721-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu v2] ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>

SLOF receives a device tree and updates it with various properties
before switching to the guest kernel and QEMU is not aware of any changes
made by SLOF. Since there is no real RTAS and QEMU implements it,
it makes sense to pass the SLOF device tree to QEMU so the latter could
implement RTAS related tasks better.

Specifially, now QEMU can find out the actual XICS phandle (for PHB
hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
assisted NMI - FWNMI).

This stores the initial DT blob in the sPAPR machine and replaces it
in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.

This implements a very basic validity check of the new blob - magic and
size are checked; the new blob size should not increase more than twice.

This requires SLOF update: "fdt: Pass the resulting device tree to QEMU".

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I could store just a size of the QEMU's blob, or a tree, not sure
which one makes more sense here.

This allows up to 2 times blob increase. Not 1.5 just to avoid
float/double, just looks a bit ugly imho.
---
 include/hw/ppc/spapr.h |  4 +++-
 hw/ppc/spapr.c         |  4 +++-
 hw/ppc/spapr_hcall.c   | 33 +++++++++++++++++++++++++++++++++
 hw/ppc/trace-events    |  2 ++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a805b817a5..09f3a54dc2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -92,6 +92,7 @@ struct sPAPRMachineState {
     int vrma_adjust;
     ssize_t rtas_size;
     void *rtas_blob;
+    void *fdt_blob;
     long kernel_size;
     bool kernel_le;
     uint32_t initrd_base;
@@ -400,7 +401,8 @@ struct sPAPRMachineState {
 #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
 /* Client Architecture support */
 #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
-#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
+#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
+#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
 
 typedef struct sPAPRDeviceTreeUpdateHeader {
     uint32_t version_id;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 17ea77618c..b471f7e1ff 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1453,7 +1453,9 @@ static void ppc_spapr_reset(void)
     /* Load the fdt */
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
-    g_free(fdt);
+    g_free(spapr->fdt_blob);
+    spapr->fdt_blob = fdt;
+    spapr->fdt_size = fdt_totalsize(fdt);
 
     /* Set up the entry state */
     first_ppc_cpu = POWERPC_CPU(first_cpu);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 57bb411394..a11831d3b2 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1635,6 +1635,37 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                                target_ulong opcode, target_ulong *args)
+{
+    target_ulong dt = ppc64_phys_to_real(args[0]);
+    struct fdt_header hdr = { 0 };
+    unsigned cb, magic, old_cb = fdt_totalsize(spapr->fdt_blob);
+
+    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
+    cb = fdt32_to_cpu(hdr.totalsize);
+    magic = fdt32_to_cpu(hdr.magic);
+    if (magic != FDT_MAGIC || cb / old_cb > 2) {
+        trace_spapr_update_dt_failed(old_cb, cb, magic);
+        return H_PARAMETER;
+    }
+
+    g_free(spapr->fdt_blob);
+    spapr->fdt_blob = g_malloc0(cb);
+    cpu_physical_memory_read(dt, spapr->fdt_blob, cb);
+
+#ifdef DEBUG
+    {
+        FILE *f = fopen("dbg.dtb", "wb");
+        fwrite(spapr->fdt_blob, cb, 1, f);
+        fclose(f);
+    }
+#endif
+    trace_spapr_update_dt(cb);
+
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -1732,6 +1763,8 @@ static void hypercall_register_types(void)
 
     /* ibm,client-architecture-support support */
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
+
+    spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 4a6a6490fa..60ee4e3a4b 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -18,6 +18,8 @@ spapr_cas_pvr_try(uint32_t pvr) "0x%x"
 spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=0x%x, explicit_match=%u, new=0x%x"
 spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
 spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
+spapr_update_dt(unsigned cb) "New blob %u bytes"
+spapr_update_dt_failed(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 
 # hw/ppc/spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
-- 
2.11.0
