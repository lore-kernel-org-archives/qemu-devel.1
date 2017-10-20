Received: from eggs.gnu.org ([2001:4830:134:3::10]:59911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vv1-00044F-1A
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vux-0004Fh-8C
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:51 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:18 +0200
Message-Id: <20171020115418.2050-47-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 46/46] s390x/tcg: low-address protection support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

This is a neat way to implement low address protection, whereby
only the first 512 bytes of the first two pages (each 4096 bytes) of
every address space are protected.

Store a tec of 0 for the access exception, this is what is defined by
Enhanced Suppression on Protection in case of a low address protection
(Bit 61 set to 0, rest undefined).

We have to make sure to to pass the access address, not the masked page
address into mmu_translate*().

Drop the check from testblock. So we can properly test this via
kvm-unit-tests.

This will check every access going through one of the MMUs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171016202358.3633-3-david@redhat.com>
[CH: restored error message for access register mode]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/excp_helper.c |  3 +-
 target/s390x/mem_helper.c  |  8 ----
 target/s390x/mmu_helper.c  | 96 +++++++++++++++++++++++++++++-----------------
 3 files changed, 62 insertions(+), 45 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index cff308a18d..e04b670663 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -95,7 +95,6 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
     DPRINTF("%s: address 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
             __func__, orig_vaddr, rw, mmu_idx);
 
-    orig_vaddr &= TARGET_PAGE_MASK;
     vaddr = orig_vaddr;
 
     if (mmu_idx < MMU_REAL_IDX) {
@@ -127,7 +126,7 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
     qemu_log_mask(CPU_LOG_MMU, "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
             __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
 
-    tlb_set_page(cs, orig_vaddr, raddr, prot,
+    tlb_set_page(cs, orig_vaddr & TARGET_PAGE_MASK, raddr, prot,
                  mmu_idx, TARGET_PAGE_SIZE);
 
     return 0;
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index bbbe1c62b3..69a16867d4 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1687,18 +1687,10 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
 {
     uintptr_t ra = GETPC();
-    CPUState *cs = CPU(s390_env_get_cpu(env));
     int i;
 
     real_addr = wrap_address(env, real_addr) & TARGET_PAGE_MASK;
 
-    /* Check low-address protection */
-    if ((env->cregs[0] & CR0_LOWPROT) && real_addr < 0x2000) {
-        cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_PROTECTION, 4);
-        return 1;
-    }
-
     for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
         cpu_stq_real_ra(env, real_addr + i, 0, ra);
     }
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 9daa0fd8e2..31e3f3f415 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -106,6 +106,37 @@ static void trigger_page_fault(CPUS390XState *env, target_ulong vaddr,
     trigger_access_exception(env, type, ilen, tec);
 }
 
+/* check whether the address would be proteted by Low-Address Protection */
+static bool is_low_address(uint64_t addr)
+{
+    return addr <= 511 || (addr >= 4096 && addr <= 4607);
+}
+
+/* check whether Low-Address Protection is enabled for mmu_translate() */
+static bool lowprot_enabled(const CPUS390XState *env, uint64_t asc)
+{
+    if (!(env->cregs[0] & CR0_LOWPROT)) {
+        return false;
+    }
+    if (!(env->psw.mask & PSW_MASK_DAT)) {
+        return true;
+    }
+
+    /* Check the private-space control bit */
+    switch (asc) {
+    case PSW_ASC_PRIMARY:
+        return !(env->cregs[1] & _ASCE_PRIVATE_SPACE);
+    case PSW_ASC_SECONDARY:
+        return !(env->cregs[7] & _ASCE_PRIVATE_SPACE);
+    case PSW_ASC_HOME:
+        return !(env->cregs[13] & _ASCE_PRIVATE_SPACE);
+    default:
+        /* We don't support access register mode */
+        error_report("unsupported addressing mode");
+        exit(1);
+    }
+}
+
 /**
  * Translate real address to absolute (= physical)
  * address by taking care of the prefix mapping.
@@ -323,6 +354,24 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
     }
 
     *flags = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    if (is_low_address(vaddr & TARGET_PAGE_MASK) && lowprot_enabled(env, asc)) {
+        /*
+         * If any part of this page is currently protected, make sure the
+         * TLB entry will not be reused.
+         *
+         * As the protected range is always the first 512 bytes of the
+         * two first pages, we are able to catch all writes to these areas
+         * just by looking at the start address (triggering the tlb miss).
+         */
+        *flags |= PAGE_WRITE_INV;
+        if (is_low_address(vaddr) && rw == MMU_DATA_STORE) {
+            if (exc) {
+                trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, 0);
+            }
+            return -EACCES;
+        }
+    }
+
     vaddr &= TARGET_PAGE_MASK;
 
     if (!(env->psw.mask & PSW_MASK_DAT)) {
@@ -392,50 +441,17 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
 }
 
 /**
- * lowprot_enabled: Check whether low-address protection is enabled
- */
-static bool lowprot_enabled(const CPUS390XState *env)
-{
-    if (!(env->cregs[0] & CR0_LOWPROT)) {
-        return false;
-    }
-    if (!(env->psw.mask & PSW_MASK_DAT)) {
-        return true;
-    }
-
-    /* Check the private-space control bit */
-    switch (env->psw.mask & PSW_MASK_ASC) {
-    case PSW_ASC_PRIMARY:
-        return !(env->cregs[1] & _ASCE_PRIVATE_SPACE);
-    case PSW_ASC_SECONDARY:
-        return !(env->cregs[7] & _ASCE_PRIVATE_SPACE);
-    case PSW_ASC_HOME:
-        return !(env->cregs[13] & _ASCE_PRIVATE_SPACE);
-    default:
-        /* We don't support access register mode */
-        error_report("unsupported addressing mode");
-        exit(1);
-    }
-}
-
-/**
  * translate_pages: Translate a set of consecutive logical page addresses
  * to absolute addresses
  */
 static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
                            target_ulong *pages, bool is_write)
 {
-    bool lowprot = is_write && lowprot_enabled(&cpu->env);
     uint64_t asc = cpu->env.psw.mask & PSW_MASK_ASC;
     CPUS390XState *env = &cpu->env;
     int ret, i, pflags;
 
     for (i = 0; i < nr_pages; i++) {
-        /* Low-address protection? */
-        if (lowprot && (addr < 512 || (addr >= 4096 && addr < 4096 + 512))) {
-            trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, 0);
-            return -EACCES;
-        }
         ret = mmu_translate(env, addr, is_write, asc, &pages[i], &pflags, true);
         if (ret) {
             return ret;
@@ -509,9 +525,19 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
                        target_ulong *addr, int *flags)
 {
-    /* TODO: low address protection once we flush the tlb on cr changes */
+    const bool lowprot_enabled = env->cregs[0] & CR0_LOWPROT;
+
     *flags = PAGE_READ | PAGE_WRITE;
-    *addr = mmu_real2abs(env, raddr);
+    if (is_low_address(raddr & TARGET_PAGE_MASK) && lowprot_enabled) {
+        /* see comment in mmu_translate() how this works */
+        *flags |= PAGE_WRITE_INV;
+        if (is_low_address(raddr) && rw == MMU_DATA_STORE) {
+            trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, 0);
+            return -EACCES;
+        }
+    }
+
+    *addr = mmu_real2abs(env, raddr & TARGET_PAGE_MASK);
 
     /* TODO: storage key handling */
     return 0;
-- 
2.13.6
