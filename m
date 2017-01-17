Received: from eggs.gnu.org ([2001:4830:134:3::10]:50997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkm-0003Eo-DD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkl-0003wW-49
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:32 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50304 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkk-0003vz-Nq
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:31 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:53 +0300
Message-Id: <1484644078-21312-14-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 13/18] tcg: do not relay on exact values of
 MO_BSWAP or MO_SIGN in backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/aarch64/tcg-target.inc.c |  4 ++--
 tcg/arm/tcg-target.inc.c     |  4 ++--
 tcg/i386/tcg-target.inc.c    |  4 ++--
 tcg/mips/tcg-target.inc.c    |  4 ++--
 tcg/ppc/tcg-target.inc.c     |  4 ++--
 tcg/s390/tcg-target.inc.c    |  4 ++--
 tcg/sparc/tcg-target.inc.c   | 12 ++++++------
 tcg/tcg-op.c                 |  4 ++--
 tcg/tcg.h                    |  1 +
 9 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1939d35..a3314e3 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1002,7 +1002,7 @@ static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     TCGMemOpIdx oi, uintptr_t ra)
  */
-static void * const qemu_ld_helpers[16] = {
+static void * const qemu_ld_helpers[] = {
     [MO_UB]   = helper_ret_ldub_mmu,
     [MO_LEUW] = helper_le_lduw_mmu,
     [MO_LEUL] = helper_le_ldul_mmu,
@@ -1016,7 +1016,7 @@ static void * const qemu_ld_helpers[16] = {
  *                                     uintxx_t val, TCGMemOpIdx oi,
  *                                     uintptr_t ra)
  */
-static void * const qemu_st_helpers[16] = {
+static void * const qemu_st_helpers[] = {
     [MO_UB]   = helper_ret_stb_mmu,
     [MO_LEUW] = helper_le_stw_mmu,
     [MO_LEUL] = helper_le_stl_mmu,
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index ffa0d40..c685785 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1083,7 +1083,7 @@ static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     int mmu_idx, uintptr_t ra)
  */
-static void * const qemu_ld_helpers[16] = {
+static void * const qemu_ld_helpers[] = {
     [MO_UB]   = helper_ret_ldub_mmu,
     [MO_SB]   = helper_ret_ldsb_mmu,
 
@@ -1103,7 +1103,7 @@ static void * const qemu_ld_helpers[16] = {
 /* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
  *                                     uintxx_t val, int mmu_idx, uintptr_t ra)
  */
-static void * const qemu_st_helpers[16] = {
+static void * const qemu_st_helpers[] = {
     [MO_UB]   = helper_ret_stb_mmu,
     [MO_LEUW] = helper_le_stw_mmu,
     [MO_LEUL] = helper_le_stl_mmu,
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index d00bd12..cd9de4d 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1257,7 +1257,7 @@ static void tcg_out_nopn(TCGContext *s, int n)
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     int mmu_idx, uintptr_t ra)
  */
-static void * const qemu_ld_helpers[16] = {
+static void * const qemu_ld_helpers[] = {
     [MO_UB]   = helper_ret_ldub_mmu,
     [MO_LEUW] = helper_le_lduw_mmu,
     [MO_LEUL] = helper_le_ldul_mmu,
@@ -1270,7 +1270,7 @@ static void * const qemu_ld_helpers[16] = {
 /* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
  *                                     uintxx_t val, int mmu_idx, uintptr_t ra)
  */
-static void * const qemu_st_helpers[16] = {
+static void * const qemu_st_helpers[] = {
     [MO_UB]   = helper_ret_stb_mmu,
     [MO_LEUW] = helper_le_stw_mmu,
     [MO_LEUL] = helper_le_stl_mmu,
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 5b2fe98..f9c02c9 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1101,7 +1101,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
 }
 
 #if defined(CONFIG_SOFTMMU)
-static void * const qemu_ld_helpers[16] = {
+static void * const qemu_ld_helpers[] = {
     [MO_UB]   = helper_ret_ldub_mmu,
     [MO_SB]   = helper_ret_ldsb_mmu,
     [MO_LEUW] = helper_le_lduw_mmu,
@@ -1118,7 +1118,7 @@ static void * const qemu_ld_helpers[16] = {
 #endif
 };
 
-static void * const qemu_st_helpers[16] = {
+static void * const qemu_st_helpers[] = {
     [MO_UB]   = helper_ret_stb_mmu,
     [MO_LEUW] = helper_le_stw_mmu,
     [MO_LEUL] = helper_le_stl_mmu,
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index a3262cf..b3fde1e 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1383,7 +1383,7 @@ static const uint32_t qemu_exts_opc[4] = {
 /* helper signature: helper_ld_mmu(CPUState *env, target_ulong addr,
  *                                 int mmu_idx, uintptr_t ra)
  */
-static void * const qemu_ld_helpers[16] = {
+static void * const qemu_ld_helpers[] = {
     [MO_UB]   = helper_ret_ldub_mmu,
     [MO_LEUW] = helper_le_lduw_mmu,
     [MO_LEUL] = helper_le_ldul_mmu,
@@ -1396,7 +1396,7 @@ static void * const qemu_ld_helpers[16] = {
 /* helper signature: helper_st_mmu(CPUState *env, target_ulong addr,
  *                                 uintxx_t val, int mmu_idx, uintptr_t ra)
  */
-static void * const qemu_st_helpers[16] = {
+static void * const qemu_st_helpers[] = {
     [MO_UB]   = helper_ret_stb_mmu,
     [MO_LEUW] = helper_le_stw_mmu,
     [MO_LEUL] = helper_le_stl_mmu,
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 8d5d2bd..75c5e56 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -307,7 +307,7 @@ static const uint8_t tcg_cond_to_ltr_cond[] = {
 };
 
 #ifdef CONFIG_SOFTMMU
-static void * const qemu_ld_helpers[16] = {
+static void * const qemu_ld_helpers[] = {
     [MO_UB]   = helper_ret_ldub_mmu,
     [MO_SB]   = helper_ret_ldsb_mmu,
     [MO_LEUW] = helper_le_lduw_mmu,
@@ -322,7 +322,7 @@ static void * const qemu_ld_helpers[16] = {
     [MO_BEQ]  = helper_be_ldq_mmu,
 };
 
-static void * const qemu_st_helpers[16] = {
+static void * const qemu_st_helpers[] = {
     [MO_UB]   = helper_ret_stb_mmu,
     [MO_LEUW] = helper_le_stw_mmu,
     [MO_LEUL] = helper_le_stl_mmu,
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 700c434..6ccc949 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -844,12 +844,12 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
 }
 
 #ifdef CONFIG_SOFTMMU
-static tcg_insn_unit *qemu_ld_trampoline[16];
-static tcg_insn_unit *qemu_st_trampoline[16];
+static tcg_insn_unit *qemu_ld_trampoline[MO_ALL];
+static tcg_insn_unit *qemu_st_trampoline[MO_ALL];
 
 static void build_trampolines(TCGContext *s)
 {
-    static void * const qemu_ld_helpers[16] = {
+    static void * const qemu_ld_helpers[MO_ALL] = {
         [MO_UB]   = helper_ret_ldub_mmu,
         [MO_SB]   = helper_ret_ldsb_mmu,
         [MO_LEUW] = helper_le_lduw_mmu,
@@ -861,7 +861,7 @@ static void build_trampolines(TCGContext *s)
         [MO_BEUL] = helper_be_ldul_mmu,
         [MO_BEQ]  = helper_be_ldq_mmu,
     };
-    static void * const qemu_st_helpers[16] = {
+    static void * const qemu_st_helpers[MO_ALL] = {
         [MO_UB]   = helper_ret_stb_mmu,
         [MO_LEUW] = helper_le_stw_mmu,
         [MO_LEUL] = helper_le_stl_mmu,
@@ -874,7 +874,7 @@ static void build_trampolines(TCGContext *s)
     int i;
     TCGReg ra;
 
-    for (i = 0; i < 16; ++i) {
+    for (i = 0; i < MO_ALL; ++i) {
         if (qemu_ld_helpers[i] == NULL) {
             continue;
         }
@@ -902,7 +902,7 @@ static void build_trampolines(TCGContext *s)
         tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_O7, ra);
     }
 
-    for (i = 0; i < 16; ++i) {
+    for (i = 0; i < MO_ALL; ++i) {
         if (qemu_st_helpers[i] == NULL) {
             continue;
         }
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6e2fb35..0925fab 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2079,7 +2079,7 @@ typedef void (*gen_atomic_op_i64)(TCGv_i64, TCGv_env, TCGv, TCGv_i64);
 # define WITH_ATOMIC64(X)
 #endif
 
-static void * const table_cmpxchg[16] = {
+static void * const table_cmpxchg[] = {
     [MO_8] = gen_helper_atomic_cmpxchgb,
     [MO_16 | MO_LE] = gen_helper_atomic_cmpxchgw_le,
     [MO_16 | MO_BE] = gen_helper_atomic_cmpxchgw_be,
@@ -2297,7 +2297,7 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
 }
 
 #define GEN_ATOMIC_HELPER(NAME, OP, NEW)                                \
-static void * const table_##NAME[16] = {                                \
+static void * const table_##NAME[] = {                                  \
     [MO_8] = gen_helper_atomic_##NAME##b,                               \
     [MO_16 | MO_LE] = gen_helper_atomic_##NAME##w_le,                   \
     [MO_16 | MO_BE] = gen_helper_atomic_##NAME##w_be,                   \
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6f4d0e7..cb672f2 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -375,6 +375,7 @@ typedef enum TCGMemOp {
     MO_TEQ   = MO_TE | MO_Q,
 
     MO_SSIZE = MO_SIZE | MO_SIGN,
+    MO_ALL   = MO_SIZE | MO_SIGN | MO_BSWAP | MO_AMASK,
 } TCGMemOp;
 
 /**
-- 
2.1.4
