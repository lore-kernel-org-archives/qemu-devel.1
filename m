Received: from eggs.gnu.org ([2001:4830:134:3::10]:58849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRE-00066J-BM
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PR6-0007iM-GZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PR6-0007hj-4u
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:52 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:35 +0200
Message-Id: <20171006095956.27534-13-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 12/33] s390x/tcg: add MMU for real addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

This makes it easy to access real addresses (prefix) and in addition
checks for valid memory addresses, which is missing when using e.g.
stl_phys().

We can later reuse it to implement low address protection checks (then
we might even decide to introduce yet another MMU for absolute
addresses, just for handling storage keys and low address protection).

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170926183318.12995-3-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h         |  4 +++-
 target/s390x/excp_helper.c | 25 ++++++++++++++++---------
 target/s390x/internal.h    |  2 ++
 target/s390x/mmu_helper.c  | 19 +++++++++++++++++++
 4 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5e2504d679..c57ef71f6d 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -43,12 +43,13 @@
 
 #include "fpu/softfloat.h"
 
-#define NB_MMU_MODES 3
+#define NB_MMU_MODES 4
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
 #define MMU_MODE0_SUFFIX _primary
 #define MMU_MODE1_SUFFIX _secondary
 #define MMU_MODE2_SUFFIX _home
+#define MMU_MODE3_SUFFIX _real
 
 #define MMU_USER_IDX 0
 
@@ -351,6 +352,7 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 #define MMU_PRIMARY_IDX         0
 #define MMU_SECONDARY_IDX       1
 #define MMU_HOME_IDX            2
+#define MMU_REAL_IDX            3
 
 static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 {
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 308605d9ed..3e4349d00b 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -88,8 +88,8 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
-    uint64_t asc = cpu_mmu_idx_to_asc(mmu_idx);
     target_ulong vaddr, raddr;
+    uint64_t asc;
     int prot;
 
     DPRINTF("%s: address 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
@@ -98,14 +98,21 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
     orig_vaddr &= TARGET_PAGE_MASK;
     vaddr = orig_vaddr;
 
-    /* 31-Bit mode */
-    if (!(env->psw.mask & PSW_MASK_64)) {
-        vaddr &= 0x7fffffff;
-    }
-
-    if (mmu_translate(env, vaddr, rw, asc, &raddr, &prot, true)) {
-        /* Translation ended in exception */
-        return 1;
+    if (mmu_idx < MMU_REAL_IDX) {
+        asc = cpu_mmu_idx_to_asc(mmu_idx);
+        /* 31-Bit mode */
+        if (!(env->psw.mask & PSW_MASK_64)) {
+            vaddr &= 0x7fffffff;
+        }
+        if (mmu_translate(env, vaddr, rw, asc, &raddr, &prot, true)) {
+            return 1;
+        }
+    } else if (mmu_idx == MMU_REAL_IDX) {
+        if (mmu_translate_real(env, vaddr, rw, &raddr, &prot)) {
+            return 1;
+        }
+    } else {
+        abort();
     }
 
     /* check out of RAM access */
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 70d2b87e55..14bf3ea5e2 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -389,6 +389,8 @@ target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
 /* mmu_helper.c */
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, bool exc);
+int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
+                       target_ulong *addr, int *flags);
 
 
 /* misc_helper.c */
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index b528c5921d..9daa0fd8e2 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -497,3 +497,22 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
     g_free(pages);
     return ret;
 }
+
+/**
+ * Translate a real address into a physical (absolute) address.
+ * @param raddr  the real address
+ * @param rw     0 = read, 1 = write, 2 = code fetch
+ * @param addr   the translated address is stored to this pointer
+ * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this pointer
+ * @return       0 if the translation was successful, < 0 if a fault occurred
+ */
+int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
+                       target_ulong *addr, int *flags)
+{
+    /* TODO: low address protection once we flush the tlb on cr changes */
+    *flags = PAGE_READ | PAGE_WRITE;
+    *addr = mmu_real2abs(env, raddr);
+
+    /* TODO: storage key handling */
+    return 0;
+}
-- 
2.13.6
