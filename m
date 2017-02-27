Received: from eggs.gnu.org ([2001:4830:134:3::10]:35227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDc9-0000hA-Ez
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDc6-0006k9-7m
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:12:49 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 27 Feb 2017 16:12:31 +1100
Message-Id: <20170227051239.2680-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170227051239.2680-1-david@gibson.dropbear.id.au>
References: <20170227051239.2680-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 1/9] target/ppc: Fix KVM-HV HPTE accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, aik@ozlabs.ru, sjitindarsingh@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

When a 'pseries' guest is running with KVM-HV, the guest's hashed page
table (HPT) is stored within the host kernel, so it is not directly
accessible to qemu.  Most of the time, qemu doesn't need to access it:
we're using the hardware MMU, and KVM itself implements the guest
hypercalls for manipulating the HPT.

However, qemu does need access to the in-KVM HPT to implement
get_phys_page_debug() for the benefit of the gdbstub, and maybe for
other debug operations.

To allow this, 7c43bca "target-ppc: Fix page table lookup with kvm
enabled" added kvmppc_hash64_read_pteg() to target/ppc/kvm.c to read
in a batch of HPTEs from the KVM table.  Unfortunately, there are a
couple of problems with this:

First, the name of the function implies it always reads a whole PTEG
from the HPT, but in fact in some cases it's used to grab individual
HPTEs (which ends up pulling 8 HPTEs, not aligned to a PTEG from the
kernel).

Second, and more importantly, the code to read the HPTEs from KVM is
simply wrong, in general.  The data from the fd that KVM provides is
designed mostly for compact migration rather than this sort of one-off
access, and so needs some decoding for this purpose.  The current code
will work in some cases, but if there are invalid HPTEs then it will
not get sane results.

This patch rewrite the HPTE reading function to have a simpler
interface (just read n HPTEs into a caller provided buffer), and to
correctly decode the stream from the kernel.

For consistency we also clean up the similar function for altering
HPTEs within KVM (introduced in c138593 "target-ppc: Update
ppc_hash64_store_hpte to support updating in-kernel htab").

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h        |   1 +
 target/ppc/kvm.c        | 126 +++++++++++++++++++++++-------------------------
 target/ppc/kvm_ppc.h    |  20 ++------
 target/ppc/mmu-hash64.c |   8 +--
 target/ppc/mmu-hash64.h |   2 +-
 5 files changed, 73 insertions(+), 84 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b559b67..c022984 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -228,6 +228,7 @@ typedef struct DisasContext DisasContext;
 typedef struct ppc_spr_t ppc_spr_t;
 typedef union ppc_avr_t ppc_avr_t;
 typedef union ppc_tlb_t ppc_tlb_t;
+typedef struct ppc_hash_pte64 ppc_hash_pte64_t;
 
 /* SPR access micro-ops generations callbacks */
 struct ppc_spr_t {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 52bbea5..79c1da6 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2596,89 +2596,85 @@ void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
 
-struct kvm_get_htab_buf {
-    struct kvm_get_htab_header header;
-    /*
-     * We require one extra byte for read
-     */
-    target_ulong hpte[(HPTES_PER_GROUP * 2) + 1];
-};
-
-uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu, target_ulong pte_index)
+void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n)
 {
-    int htab_fd;
-    struct kvm_get_htab_fd ghf;
-    struct kvm_get_htab_buf  *hpte_buf;
+    struct kvm_get_htab_fd ghf = {
+        .flags = 0,
+        .start_index = ptex,
+    };
+    int fd, rc;
+    int i;
 
-    ghf.flags = 0;
-    ghf.start_index = pte_index;
-    htab_fd = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &ghf);
-    if (htab_fd < 0) {
-        goto error_out;
+    fd = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &ghf);
+    if (fd < 0) {
+        hw_error("kvmppc_read_hptes: Unable to open HPT fd");
     }
 
-    hpte_buf = g_malloc0(sizeof(*hpte_buf));
-    /*
-     * Read the hpte group
-     */
-    if (read(htab_fd, hpte_buf, sizeof(*hpte_buf)) < 0) {
-        goto out_close;
-    }
+    i = 0;
+    while (i < n) {
+        struct kvm_get_htab_header *hdr;
+        int m = n < HPTES_PER_GROUP ? n : HPTES_PER_GROUP;
+        char buf[sizeof(*hdr) + m * HASH_PTE_SIZE_64];
 
-    close(htab_fd);
-    return (uint64_t)(uintptr_t) hpte_buf->hpte;
+        rc = read(fd, buf, sizeof(buf));
+        if (rc < 0) {
+            hw_error("kvmppc_read_hptes: Unable to read HPTEs");
+        }
 
-out_close:
-    g_free(hpte_buf);
-    close(htab_fd);
-error_out:
-    return 0;
-}
+        hdr = (struct kvm_get_htab_header *)buf;
+        while ((i < n) && ((char *)hdr < (buf + rc))) {
+            int invalid = hdr->n_invalid;
 
-void kvmppc_hash64_free_pteg(uint64_t token)
-{
-    struct kvm_get_htab_buf *htab_buf;
+            if (hdr->index != (ptex + i)) {
+                hw_error("kvmppc_read_hptes: Unexpected HPTE index %"PRIu32
+                         " != (%"HWADDR_PRIu" + %d", hdr->index, ptex, i);
+            }
+
+            memcpy(hptes + i, hdr + 1, HASH_PTE_SIZE_64 * hdr->n_valid);
+            i += hdr->n_valid;
 
-    htab_buf = container_of((void *)(uintptr_t) token, struct kvm_get_htab_buf,
-                            hpte);
-    g_free(htab_buf);
-    return;
+            if ((n - i) < invalid) {
+                invalid = n - i;
+            }
+            memset(hptes + i, 0, invalid * HASH_PTE_SIZE_64);
+            i += hdr->n_invalid;
+
+            hdr = (struct kvm_get_htab_header *)
+                ((char *)(hdr + 1) + HASH_PTE_SIZE_64 * hdr->n_valid);
+        }
+    }
+
+    close(fd);
 }
 
-void kvmppc_hash64_write_pte(CPUPPCState *env, target_ulong pte_index,
-                             target_ulong pte0, target_ulong pte1)
+void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
 {
-    int htab_fd;
+    int fd, rc;
     struct kvm_get_htab_fd ghf;
-    struct kvm_get_htab_buf hpte_buf;
+    struct {
+        struct kvm_get_htab_header hdr;
+        uint64_t pte0;
+        uint64_t pte1;
+    } buf;
 
     ghf.flags = 0;
     ghf.start_index = 0;     /* Ignored */
-    htab_fd = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &ghf);
-    if (htab_fd < 0) {
-        goto error_out;
-    }
-
-    hpte_buf.header.n_valid = 1;
-    hpte_buf.header.n_invalid = 0;
-    hpte_buf.header.index = pte_index;
-    hpte_buf.hpte[0] = pte0;
-    hpte_buf.hpte[1] = pte1;
-    /*
-     * Write the hpte entry.
-     * CAUTION: write() has the warn_unused_result attribute. Hence we
-     * need to check the return value, even though we do nothing.
-     */
-    if (write(htab_fd, &hpte_buf, sizeof(hpte_buf)) < 0) {
-        goto out_close;
+    fd = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &ghf);
+    if (fd < 0) {
+        hw_error("kvmppc_write_hpte: Unable to open HPT fd");
     }
 
-out_close:
-    close(htab_fd);
-    return;
+    buf.hdr.n_valid = 1;
+    buf.hdr.n_invalid = 0;
+    buf.hdr.index = ptex;
+    buf.pte0 = cpu_to_be64(pte0);
+    buf.pte1 = cpu_to_be64(pte1);
 
-error_out:
-    return;
+    rc = write(fd, &buf, sizeof(buf));
+    if (rc != sizeof(buf)) {
+        hw_error("kvmppc_write_hpte: Unable to update KVM HPT");
+    }
+    close(fd);
 }
 
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 8da2ee4..8e9f42d 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -49,11 +49,8 @@ int kvmppc_get_htab_fd(bool write);
 int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns);
 int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
                            uint16_t n_valid, uint16_t n_invalid);
-uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu, target_ulong pte_index);
-void kvmppc_hash64_free_pteg(uint64_t token);
-
-void kvmppc_hash64_write_pte(CPUPPCState *env, target_ulong pte_index,
-                             target_ulong pte0, target_ulong pte1);
+void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n);
+void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1);
 bool kvmppc_has_cap_fixup_hcalls(void);
 bool kvmppc_has_cap_htm(void);
 int kvmppc_enable_hwrng(void);
@@ -234,20 +231,13 @@ static inline int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
     abort();
 }
 
-static inline uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu,
-                                               target_ulong pte_index)
-{
-    abort();
-}
-
-static inline void kvmppc_hash64_free_pteg(uint64_t token)
+static inline void kvmppc_read_hptes(ppc_hash_pte64_t *hptes,
+                                     hwaddr ptex, int n)
 {
     abort();
 }
 
-static inline void kvmppc_hash64_write_pte(CPUPPCState *env,
-                                           target_ulong pte_index,
-                                           target_ulong pte0, target_ulong pte1)
+static inline void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
 {
     abort();
 }
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 76669ed..862e50e 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -438,10 +438,12 @@ uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong pte_index)
 
     pte_offset = pte_index * HASH_PTE_SIZE_64;
     if (cpu->env.external_htab == MMU_HASH64_KVM_MANAGED_HPT) {
+        ppc_hash_pte64_t *pteg = g_malloc(HASH_PTEG_SIZE_64);
         /*
          * HTAB is controlled by KVM. Fetch the PTEG into a new buffer.
          */
-        token = kvmppc_hash64_read_pteg(cpu, pte_index);
+        kvmppc_read_hptes(pteg, pte_index, HPTES_PER_GROUP);
+        token = (uint64_t)(uintptr_t)pteg;
     } else if (cpu->env.external_htab) {
         /*
          * HTAB is controlled by QEMU. Just point to the internally
@@ -457,7 +459,7 @@ uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong pte_index)
 void ppc_hash64_stop_access(PowerPCCPU *cpu, uint64_t token)
 {
     if (cpu->env.external_htab == MMU_HASH64_KVM_MANAGED_HPT) {
-        kvmppc_hash64_free_pteg(token);
+        g_free((void *)token);
     }
 }
 
@@ -916,7 +918,7 @@ void ppc_hash64_store_hpte(PowerPCCPU *cpu,
     CPUPPCState *env = &cpu->env;
 
     if (env->external_htab == MMU_HASH64_KVM_MANAGED_HPT) {
-        kvmppc_hash64_write_pte(env, pte_index, pte0, pte1);
+        kvmppc_write_hpte(pte_index, pte0, pte1);
         return;
     }
 
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 7a0b7fc..73aeaa3 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -127,7 +127,7 @@ static inline target_ulong ppc_hash64_load_hpte1(PowerPCCPU *cpu,
     }
 }
 
-typedef struct {
+typedef struct ppc_hash_pte64 {
     uint64_t pte0, pte1;
 } ppc_hash_pte64_t;
 
-- 
2.9.3
