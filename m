Received: from eggs.gnu.org ([2001:4830:134:3::10]:55954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI0-0001Hs-Dt
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2THx-0003I7-C7
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:45 +1000
Message-Id: <20170424015927.8933-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/47] target-ppc: kvm: make use of
 KVM_CREATE_SPAPR_TCE_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

KVM_CAP_SPAPR_TCE capability allows creating TCE tables in KVM which
allows having in-kernel acceleration for H_PUT_TCE_xxx hypercalls.
However it only supports 32bit DMA windows at zero bus offset.

There is a new KVM_CAP_SPAPR_TCE_64 capability which supports 64bit
window size, variable page size and bus offset.

This makes use of the new capability. The kernel headers are already
updated as the kernel support went in to v4.6.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_iommu.c |  8 +++++---
 target/ppc/kvm.c     | 48 +++++++++++++++++++++++++++++++++++++-----------
 target/ppc/kvm_ppc.h | 12 +++++++-----
 3 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index ae30bbe..29c80bb 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -79,15 +79,16 @@ static IOMMUAccessFlags spapr_tce_iommu_access_flags(uint64_t tce)
 
 static uint64_t *spapr_tce_alloc_table(uint32_t liobn,
                                        uint32_t page_shift,
+                                       uint64_t bus_offset,
                                        uint32_t nb_table,
                                        int *fd,
                                        bool need_vfio)
 {
     uint64_t *table = NULL;
-    uint64_t window_size = (uint64_t)nb_table << page_shift;
 
-    if (kvm_enabled() && !(window_size >> 32)) {
-        table = kvmppc_create_spapr_tce(liobn, window_size, fd, need_vfio);
+    if (kvm_enabled()) {
+        table = kvmppc_create_spapr_tce(liobn, page_shift, bus_offset, nb_table,
+                                        fd, need_vfio);
     }
 
     if (!table) {
@@ -342,6 +343,7 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet,
     tcet->nb_table = nb_table;
     tcet->table = spapr_tce_alloc_table(tcet->liobn,
                                         tcet->page_shift,
+                                        tcet->bus_offset,
                                         tcet->nb_table,
                                         &tcet->fd,
                                         tcet->need_vfio);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index c3d4262..79b90a6 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -74,6 +74,7 @@ static int cap_booke_sregs;
 static int cap_ppc_smt;
 static int cap_ppc_rma;
 static int cap_spapr_tce;
+static int cap_spapr_tce_64;
 static int cap_spapr_multitce;
 static int cap_spapr_vfio;
 static int cap_hior;
@@ -126,6 +127,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_ppc_smt = kvm_check_extension(s, KVM_CAP_PPC_SMT);
     cap_ppc_rma = kvm_check_extension(s, KVM_CAP_PPC_RMA);
     cap_spapr_tce = kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
+    cap_spapr_tce_64 = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
     cap_spapr_multitce = kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE);
     cap_spapr_vfio = false;
     cap_one_reg = kvm_check_extension(s, KVM_CAP_ONE_REG);
@@ -2136,13 +2138,10 @@ bool kvmppc_spapr_use_multitce(void)
     return cap_spapr_multitce;
 }
 
-void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size, int *pfd,
-                              bool need_vfio)
+void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
+                              uint64_t bus_offset, uint32_t nb_table,
+                              int *pfd, bool need_vfio)
 {
-    struct kvm_create_spapr_tce args = {
-        .liobn = liobn,
-        .window_size = window_size,
-    };
     long len;
     int fd;
     void *table;
@@ -2155,14 +2154,41 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size, int *pfd,
         return NULL;
     }
 
-    fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args);
-    if (fd < 0) {
-        fprintf(stderr, "KVM: Failed to create TCE table for liobn 0x%x\n",
-                liobn);
+    if (cap_spapr_tce_64) {
+        struct kvm_create_spapr_tce_64 args = {
+            .liobn = liobn,
+            .page_shift = page_shift,
+            .offset = bus_offset >> page_shift,
+            .size = nb_table,
+            .flags = 0
+        };
+        fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE_64, &args);
+        if (fd < 0) {
+            fprintf(stderr,
+                    "KVM: Failed to create TCE64 table for liobn 0x%x\n",
+                    liobn);
+            return NULL;
+        }
+    } else if (cap_spapr_tce) {
+        uint64_t window_size = (uint64_t) nb_table << page_shift;
+        struct kvm_create_spapr_tce args = {
+            .liobn = liobn,
+            .window_size = window_size,
+        };
+        if ((window_size != args.window_size) || bus_offset) {
+            return NULL;
+        }
+        fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args);
+        if (fd < 0) {
+            fprintf(stderr, "KVM: Failed to create TCE table for liobn 0x%x\n",
+                    liobn);
+            return NULL;
+        }
+    } else {
         return NULL;
     }
 
-    len = (window_size / SPAPR_TCE_PAGE_SIZE) * sizeof(uint64_t);
+    len = nb_table * sizeof(uint64_t);
     /* FIXME: round this up to page size */
 
     table = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 8e9f42d..08ecf75 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -36,8 +36,9 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
 #ifndef CONFIG_USER_ONLY
 off_t kvmppc_alloc_rma(void **rma);
 bool kvmppc_spapr_use_multitce(void);
-void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size, int *pfd,
-                              bool need_vfio);
+void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
+                              uint64_t bus_offset, uint32_t nb_table,
+                              int *pfd, bool need_vfio);
 int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
 int kvmppc_reset_htab(int shift_hint);
 uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
@@ -167,9 +168,10 @@ static inline bool kvmppc_spapr_use_multitce(void)
     return false;
 }
 
-static inline void *kvmppc_create_spapr_tce(uint32_t liobn,
-                                            uint32_t window_size, int *fd,
-                                            bool need_vfio)
+static inline void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
+                                            uint64_t bus_offset,
+                                            uint32_t nb_table,
+                                            int *pfd, bool need_vfio)
 {
     return NULL;
 }
-- 
2.9.3
