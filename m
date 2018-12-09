Received: from eggs.gnu.org ([2001:4830:134:3::10]:33297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4u2-0000Xf-KM
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4tx-0004zv-6M
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:09 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4tw-0004wd-O9
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:04 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:20 -0500
Message-Id: <20181209193749.12277-10-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 09/38] cputlb: introduce
 get_page_addr_code_hostp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This will be used by plugins to get the host address
of instructions.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h | 13 +++++++++++++
 accel/tcg/cputlb.c      | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 815e5b1e83..afcc01e0e3 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,6 +22,7 @@
 
 #include "qemu-common.h"
 #include "exec/tb-context.h"
+#include "exec/cpu_ldst.h"
 #include "sysemu/cpus.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
@@ -487,12 +488,24 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong
 {
     return addr;
 }
+
+static inline tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env1,
+                                                      target_ulong addr,
+                                                      void **hostp)
+{
+    if (hostp) {
+        *hostp = g2h(addr);
+    }
+    return addr;
+}
 #else
 static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
 
 /* cputlb.c */
 tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr);
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env1, target_ulong addr,
+                                        void **hostp);
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e3582f2f1d..5c61908084 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1069,7 +1069,8 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
  * is actually a ram_addr_t (in system mode; the user mode emulation
  * version of this function returns a guest virtual address).
  */
-tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+                                        void **hostp)
 {
     uintptr_t mmu_idx = cpu_mmu_index(env, true);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1092,13 +1093,24 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
          *    than a target page, so we must redo the MMU check every insn
          *  - TLB_MMIO: region is not backed by RAM
          */
+        if (hostp) {
+            *hostp = NULL;
+        }
         return -1;
     }
 
     p = (void *)((uintptr_t)addr + entry->addend);
+    if (hostp) {
+        *hostp = p;
+    }
     return qemu_ram_addr_from_host_nofail(p);
 }
 
+tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
+{
+    return get_page_addr_code_hostp(env, addr, NULL);
+}
+
 /* Probe for whether the specified guest write access is permitted.
  * If it is not permitted then an exception will be taken in the same
  * way as if this were a real write access (and we will not return).
-- 
2.17.1
