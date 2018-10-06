Received: from eggs.gnu.org ([2001:4830:134:3::10]:34499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO9-0000Ac-Rf
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO8-0007If-3o
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:29 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52577)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8uO7-0007FI-Qf
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  6 Oct 2018 17:45:07 -0400
Message-Id: <20181006214508.5331-6-cota@braap.org>
In-Reply-To: <20181006214508.5331-1-cota@braap.org>
References: <20181006214508.5331-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 5/6] cpu-defs: define MIN_CPU_TLB_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/cpu-defs.h   | 6 +++---
 accel/tcg/cputlb.c        | 2 +-
 tcg/i386/tcg-target.inc.c | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index af9fe04b0b..27b9433976 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -67,7 +67,7 @@ typedef uint64_t target_ulong;
 #define CPU_TLB_ENTRY_BITS 5
 #endif
 
-/* TCG_TARGET_TLB_DISPLACEMENT_BITS is used in CPU_TLB_BITS to ensure that
+/* TCG_TARGET_TLB_DISPLACEMENT_BITS is used in MIN_CPU_TLB_BITS to ensure that
  * the TLB is not unnecessarily small, but still small enough for the
  * TLB lookup instruction sequence used by the TCG target.
  *
@@ -89,7 +89,7 @@ typedef uint64_t target_ulong;
  * 0x18 (the offset of the addend field in each TLB entry) plus the offset
  * of tlb_table inside env (which is non-trivial but not huge).
  */
-#define CPU_TLB_BITS                                             \
+#define MIN_CPU_TLB_BITS                                         \
     MIN(8,                                                       \
         TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
         (NB_MMU_MODES <= 1 ? 0 :                                 \
@@ -97,7 +97,7 @@ typedef uint64_t target_ulong;
          NB_MMU_MODES <= 4 ? 2 :                                 \
          NB_MMU_MODES <= 8 ? 3 : 4))
 
-#define CPU_TLB_SIZE (1 << CPU_TLB_BITS)
+#define MIN_CPU_TLB_SIZE (1 << MIN_CPU_TLB_BITS)
 
 typedef struct CPUTLBEntry {
     /* bit TARGET_LONG_BITS to TARGET_PAGE_BITS : virtual address
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ed19ac0e40..1ca71ecfc4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -82,7 +82,7 @@ void tlb_init(CPUState *cpu)
     for (i = 0; i < NB_MMU_MODES; i++) {
         CPUTLBDesc *desc = &env->tlb_desc[i];
 
-        desc->size = CPU_TLB_SIZE;
+        desc->size = MIN_CPU_TLB_SIZE;
         desc->mask = (desc->size - 1) << CPU_TLB_ENTRY_BITS;
         desc->used = 0;
         env->tlb_table[i] = g_new(CPUTLBEntry, desc->size);
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index fce6a94e22..60d8ed5264 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1626,7 +1626,8 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         }
         if (TCG_TYPE_PTR == TCG_TYPE_I64) {
             hrexw = P_REXW;
-            if (TARGET_PAGE_BITS + CPU_TLB_BITS > 32) {
+            /* XXX the size here is variable */
+            if (TARGET_PAGE_BITS + MIN_CPU_TLB_BITS > 32) {
                 tlbtype = TCG_TYPE_I64;
                 tlbrexw = P_REXW;
             }
-- 
2.17.1
