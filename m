Received: from eggs.gnu.org ([2001:4830:134:3::10]:51942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5Ts-0002xQ-Eo
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5Tm-00080a-OT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:04 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:36486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5Tm-000808-GA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:40:58 -0400
Received: by mail-pf0-x231.google.com with SMTP id e199so1621667pfh.3
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:40:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:30 -0700
Message-Id: <20170907224051.21518-3-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 02/23] tcg: Rearrange ldst label tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Dispense with TCGBackendData, as it has never been used for more than
holding a single pointer.  Use a define in the cpu/tcg-target.h to
signal requirement for TCGLabelQemuLdst, so that we can drop the no-op
tcg-be-null.h stubs.  Rename tcg-be-ldst.h to tcg-ldst.inc.c.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/aarch64/tcg-target.h              |  4 ++++
 tcg/arm/tcg-target.h                  |  4 ++++
 tcg/i386/tcg-target.h                 |  4 ++++
 tcg/mips/tcg-target.h                 |  4 ++++
 tcg/ppc/tcg-target.h                  |  4 ++++
 tcg/s390/tcg-target.h                 |  4 ++++
 tcg/tcg-be-null.h                     | 44 -----------------------------------
 tcg/tcg.h                             |  6 +++--
 tcg/tci/tcg-target.h                  |  4 ++++
 tcg/aarch64/tcg-target.inc.c          |  3 ++-
 tcg/arm/tcg-target.inc.c              |  3 ++-
 tcg/i386/tcg-target.inc.c             |  4 ++--
 tcg/mips/tcg-target.inc.c             |  4 ++--
 tcg/ppc/tcg-target.inc.c              |  4 ++--
 tcg/s390/tcg-target.inc.c             |  4 ++--
 tcg/sparc/tcg-target.inc.c            |  2 --
 tcg/{tcg-be-ldst.h => tcg-ldst.inc.c} | 27 ++++-----------------
 tcg/tcg.c                             | 17 +++++++-------
 tcg/tci/tcg-target.inc.c              |  2 --
 19 files changed, 57 insertions(+), 91 deletions(-)
 delete mode 100644 tcg/tcg-be-null.h
 rename tcg/{tcg-be-ldst.h => tcg-ldst.inc.c} (85%)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 719861fe3e..1bdbd7058b 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -122,4 +122,8 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
+#ifdef CONFIG_SOFTMMU
+#define TCG_TARGET_NEED_LDST_LABELS
+#endif
+
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 7117ebf4fc..2e92cb3283 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -140,4 +140,8 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 /* not defined -- call should be eliminated at compile time */
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
+#ifdef CONFIG_SOFTMMU
+#define TCG_TARGET_NEED_LDST_LABELS
+#endif
+
 #endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 2fd28fa6a5..11ee7fadd1 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -186,4 +186,8 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
 
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
+#ifdef CONFIG_SOFTMMU
+#define TCG_TARGET_NEED_LDST_LABELS
+#endif
+
 #endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 928a762bd7..a8222476f0 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -211,4 +211,8 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
+#ifdef CONFIG_SOFTMMU
+#define TCG_TARGET_NEED_LDST_LABELS
+#endif
+
 #endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index aa44e715d8..3772cc6648 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -129,4 +129,8 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
+#ifdef CONFIG_SOFTMMU
+#define TCG_TARGET_NEED_LDST_LABELS
+#endif
+
 #endif
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 31a9eb4ac7..52010c30cb 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -155,4 +155,8 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
     /* no need to flush icache explicitly */
 }
 
+#ifdef CONFIG_SOFTMMU
+#define TCG_TARGET_NEED_LDST_LABELS
+#endif
+
 #endif
diff --git a/tcg/tcg-be-null.h b/tcg/tcg-be-null.h
deleted file mode 100644
index 5222fe29e2..0000000000
--- a/tcg/tcg-be-null.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * TCG Backend Data: No backend data
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-typedef struct TCGBackendData {
-    /* Empty */
-    char dummy;
-} TCGBackendData;
-
-
-/*
- * Initialize TB backend data at the beginning of the TB.
- */
-
-static inline void tcg_out_tb_init(TCGContext *s)
-{
-}
-
-/*
- * Generate TB finalization at the end of block
- */
-
-static inline bool tcg_out_tb_finalize(TCGContext *s)
-{
-    return true;
-}
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 46957d9bd7..b0e00e744e 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -712,8 +712,10 @@ struct TCGContext {
     CPUState *cpu;                      /* *_trans */
     TCGv_env tcg_env;                   /* *_exec  */
 
-    /* The TCGBackendData structure is private to tcg-target.inc.c.  */
-    struct TCGBackendData *be;
+    /* These structures are private to tcg-target.inc.c.  */
+#ifdef TCG_TARGET_NEED_LDST_LABELS
+    struct TCGLabelQemuLdst *ldst_labels;
+#endif
 
     TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 26140d78cb..5d692e1f4b 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -206,4 +206,8 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
     /* no need to flush icache explicitly */
 }
 
+#ifdef CONFIG_SOFTMMU
+#define TCG_TARGET_NEED_LDST_LABELS
+#endif
+
 #endif /* TCG_TARGET_H */
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index a1e5dd2f03..c7c751bafc 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -10,7 +10,6 @@
  * See the COPYING file in the top-level directory for details.
  */
 
-#include "tcg-be-ldst.h"
 #include "qemu/bitops.h"
 
 /* We're going to re-use TCGType in setting of the SF bit, which controls
@@ -1070,6 +1069,8 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
 }
 
 #ifdef CONFIG_SOFTMMU
+#include "tcg-ldst.inc.c"
+
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     TCGMemOpIdx oi, uintptr_t ra)
  */
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 37efcf06af..81ea900852 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -23,7 +23,6 @@
  */
 
 #include "elf.h"
-#include "tcg-be-ldst.h"
 
 int arm_arch = __ARM_ARCH;
 
@@ -1060,6 +1059,8 @@ static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
 }
 
 #ifdef CONFIG_SOFTMMU
+#include "tcg-ldst.inc.c"
+
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     int mmu_idx, uintptr_t ra)
  */
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index e4b120a40c..1a1ad96906 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -22,8 +22,6 @@
  * THE SOFTWARE.
  */
 
-#include "tcg-be-ldst.h"
-
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #if TCG_TARGET_REG_BITS == 64
@@ -1214,6 +1212,8 @@ static void tcg_out_nopn(TCGContext *s, int n)
 }
 
 #if defined(CONFIG_SOFTMMU)
+#include "tcg-ldst.inc.c"
+
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     int mmu_idx, uintptr_t ra)
  */
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 04f8c839fe..750baadf37 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -24,8 +24,6 @@
  * THE SOFTWARE.
  */
 
-#include "tcg-be-ldst.h"
-
 #ifdef HOST_WORDS_BIGENDIAN
 # define MIPS_BE  1
 #else
@@ -1112,6 +1110,8 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
 }
 
 #if defined(CONFIG_SOFTMMU)
+#include "tcg-ldst.inc.c"
+
 static void * const qemu_ld_helpers[16] = {
     [MO_UB]   = helper_ret_ldub_mmu,
     [MO_SB]   = helper_ret_ldsb_mmu,
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 018c240f6d..d772faf7be 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -22,8 +22,6 @@
  * THE SOFTWARE.
  */
 
-#include "tcg-be-ldst.h"
-
 #if defined _CALL_DARWIN || defined __APPLE__
 #define TCG_TARGET_CALL_DARWIN
 #endif
@@ -1418,6 +1416,8 @@ static const uint32_t qemu_exts_opc[4] = {
 };
 
 #if defined (CONFIG_SOFTMMU)
+#include "tcg-ldst.inc.c"
+
 /* helper signature: helper_ld_mmu(CPUState *env, target_ulong addr,
  *                                 int mmu_idx, uintptr_t ra)
  */
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 38b9e791ee..ee0dff995a 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -24,8 +24,6 @@
  * THE SOFTWARE.
  */
 
-#include "tcg-be-ldst.h"
-
 /* We only support generating code for 64-bit mode.  */
 #if TCG_TARGET_REG_BITS != 64
 #error "unsupported code generation mode"
@@ -1458,6 +1456,8 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc, TCGReg data,
 }
 
 #if defined(CONFIG_SOFTMMU)
+#include "tcg-ldst.inc.c"
+
 /* We're expecting to use a 20-bit signed offset on the tlb memory ops.
    Using the offset of the second entry in the last tlb table ensures
    that we can index all of the elements of the first entry.  */
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 06cabbedf5..bb7f7e8906 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -22,8 +22,6 @@
  * THE SOFTWARE.
  */
 
-#include "tcg-be-null.h"
-
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "%g0",
diff --git a/tcg/tcg-be-ldst.h b/tcg/tcg-ldst.inc.c
similarity index 85%
rename from tcg/tcg-be-ldst.h
rename to tcg/tcg-ldst.inc.c
index 17777aec5a..0e14cf4357 100644
--- a/tcg/tcg-be-ldst.h
+++ b/tcg/tcg-ldst.inc.c
@@ -20,8 +20,6 @@
  * THE SOFTWARE.
  */
 
-#ifdef CONFIG_SOFTMMU
-
 typedef struct TCGLabelQemuLdst {
     bool is_ld;             /* qemu_ld: true, qemu_st: false */
     TCGMemOpIdx oi;
@@ -35,19 +33,6 @@ typedef struct TCGLabelQemuLdst {
     struct TCGLabelQemuLdst *next;
 } TCGLabelQemuLdst;
 
-typedef struct TCGBackendData {
-    TCGLabelQemuLdst *labels;
-} TCGBackendData;
-
-
-/*
- * Initialize TB backend data at the beginning of the TB.
- */
-
-static inline void tcg_out_tb_init(TCGContext *s)
-{
-    s->be->labels = NULL;
-}
 
 /*
  * Generate TB finalization at the end of block
@@ -56,12 +41,12 @@ static inline void tcg_out_tb_init(TCGContext *s)
 static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
 static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
 
-static bool tcg_out_tb_finalize(TCGContext *s)
+static bool tcg_out_ldst_finalize(TCGContext *s)
 {
     TCGLabelQemuLdst *lb;
 
     /* qemu_ld/st slow paths */
-    for (lb = s->be->labels; lb != NULL; lb = lb->next) {
+    for (lb = s->ldst_labels; lb != NULL; lb = lb->next) {
         if (lb->is_ld) {
             tcg_out_qemu_ld_slow_path(s, lb);
         } else {
@@ -85,13 +70,9 @@ static bool tcg_out_tb_finalize(TCGContext *s)
 
 static inline TCGLabelQemuLdst *new_ldst_label(TCGContext *s)
 {
-    TCGBackendData *be = s->be;
     TCGLabelQemuLdst *l = tcg_malloc(sizeof(*l));
 
-    l->next = be->labels;
-    be->labels = l;
+    l->next = s->ldst_labels;
+    s->ldst_labels = l;
     return l;
 }
-#else
-#include "tcg-be-null.h"
-#endif /* CONFIG_SOFTMMU */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 35598296c5..dd74eabb0a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -112,10 +112,9 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 static void tcg_out_call(TCGContext *s, tcg_insn_unit *target);
 static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct);
-static void tcg_out_tb_init(TCGContext *s);
-static bool tcg_out_tb_finalize(TCGContext *s);
-
-
+#ifdef TCG_TARGET_NEED_LDST_LABELS
+static bool tcg_out_ldst_finalize(TCGContext *s);
+#endif
 
 static TCGRegSet tcg_target_available_regs[2];
 static TCGRegSet tcg_target_call_clobber_regs;
@@ -470,8 +469,6 @@ void tcg_func_start(TCGContext *s)
     s->gen_op_buf[0].prev = 0;
     s->gen_next_op_idx = 1;
     s->gen_next_parm_idx = 0;
-
-    s->be = tcg_malloc(sizeof(TCGBackendData));
 }
 
 static inline int temp_idx(TCGContext *s, TCGTemp *ts)
@@ -2619,7 +2616,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     s->code_buf = tb->tc_ptr;
     s->code_ptr = tb->tc_ptr;
 
-    tcg_out_tb_init(s);
+#ifdef TCG_TARGET_NEED_LDST_LABELS
+    s->ldst_labels = NULL;
+#endif
 
     num_insns = -1;
     for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
@@ -2694,9 +2693,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     s->gen_insn_end_off[num_insns] = tcg_current_code_size(s);
 
     /* Generate TB finalization at the end of block */
-    if (!tcg_out_tb_finalize(s)) {
+#ifdef TCG_TARGET_NEED_LDST_LABELS
+    if (!tcg_out_ldst_finalize(s)) {
         return -1;
     }
+#endif
 
     /* flush instruction cache */
     flush_icache_range((uintptr_t)s->code_buf, (uintptr_t)s->code_ptr);
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index b6a15569f8..94461b2baf 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -22,8 +22,6 @@
  * THE SOFTWARE.
  */
 
-#include "tcg-be-null.h"
-
 /* TODO list:
  * - See TODO comments in code.
  */
-- 
2.13.5
