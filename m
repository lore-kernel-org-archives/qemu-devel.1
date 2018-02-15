Received: from eggs.gnu.org ([2001:4830:134:3::10]:46490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1emP0m-0006PP-MN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1emP0j-0001a0-Fa
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:16:04 -0500
Received: from p3plsmtpa11-04.prod.phx3.secureserver.net
	([68.178.252.105]:52297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1emP0j-0001Yq-28
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:16:01 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Thu, 15 Feb 2018 14:15:55 -0500
Message-ID: <1542598.g35DF0Zjqa@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Qemu-devel] [RFC PATCH 02/02] handle case of delayed control
 transfer couple with leading branch being conditional. need to correctly
 take the new branch if conditional is untaken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This patch attempts to address a crash caused by a branch in a delay slot of 
antoher branch causing qemu to generate an unaligned exception due to loading 
the instruction at 2 (aka JUMP_PC).

This is RFC because I am not sure if I'm handling this correctly. The goal 
here is to have a delayed control transfer couple, which on sparc v8 is 
unpredictable, behave in a predictable way.

In my test case, I have a conditional branch followed by an unconditional 
branch. My desire was to have QEMU follow the first branch if the condition 
matched, otherwise follow the second branch if it did not.

If the instruction following a branch delay instruction causes npc to become 
DYNAMIC_PC I'm not really sure what will happen here, either.

Also translate.c has a function for SPARC64 called do_branch_reg() which I'm 
not sure if I need any special handling for in this case.

>From 113357ed067ec64348a51bf40f97c909f85f5d95 Mon Sep 17 00:00:00 2001
From: Steven Seeger <steven.seeger@flightsystems.net>
Date: Thu, 15 Feb 2018 13:47:42 -0500
Subject: [PATCH 2/2] handle case of delayed control transfer couple with
 leading branch being conditional. need to correctly take the new branch if
 conditional is untaken

Signed-off-by: Steven Seeger <steven.seeger@flightsystems.net>
---
 target/sparc/cpu.h       |  3 +-
 target/sparc/translate.c | 84 +++++++++++++++++++++++++++++++++++++++++
+------
 2 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 3eaffb354e..af56c49439 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -439,7 +439,8 @@ struct CPUSPARCState {
 
     target_ulong cond; /* conditional branch result (XXX: save it in a
                           temporary register when possible) */
-
+    target_ulong bcc_delayed; /* if 1, indicates the current instruction is
+                          executing in a delay slot of a conditional branch 
*/
     uint32_t psr;      /* processor state register */
     target_ulong fsr;      /* FPU state register */
     CPU_DoubleU fpr[TARGET_DPREGS];  /* floating point registers */
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4c2272003d..2223bff640 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "cpu.h"
 #include "disas/disas.h"
@@ -45,6 +46,7 @@ static TCGv_ptr cpu_regwptr;
 static TCGv cpu_cc_src, cpu_cc_src2, cpu_cc_dst;
 static TCGv_i32 cpu_cc_op;
 static TCGv_i32 cpu_psr;
+static TCGv_i32 bcc_delayed;
 static TCGv cpu_fsr, cpu_pc, cpu_npc;
 static TCGv cpu_regs[32];
 static TCGv cpu_y;
@@ -69,6 +71,7 @@ typedef struct DisasContext {
     target_ulong pc;    /* current Program Counter: integer or DYNAMIC_PC */
     target_ulong npc;   /* next PC: integer or DYNAMIC_PC or JUMP_PC */
     target_ulong jump_pc[2]; /* used when JUMP_PC pc value is used */
+    target_ulong bcc_delayed;
     int is_br;
     int mem_idx;
     bool fpu_enabled;
@@ -1007,6 +1010,8 @@ static void gen_branch_n(DisasContext *dc, target_ulong 
pc1)
         dc->jump_pc[0] = pc1;
         dc->jump_pc[1] = npc + 4;
         dc->npc = JUMP_PC;
+        tcg_gen_movi_tl(bcc_delayed, 1);
+        dc->bcc_delayed = 1;
     } else {
         TCGv t, z;
 
@@ -1438,16 +1443,37 @@ static inline void gen_cond_reg(TCGv r_dst, int cond, 
TCGv r_src)
 }
 #endif
 
-static void do_branch(DisasContext *dc, int32_t offset, uint32_t insn, int 
cc)
+/* returns 0 if new branch, or non-zero if branch is in delay slot
+ * of another branch */
+static int do_branch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
 {
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
     target_ulong target = dc->pc + offset;
 
+    assert(!(dc->npc & JUMP_PC) || ((dc->npc & JUMP_PC) && dc->bcc_delayed));
+
 #ifdef TARGET_SPARC64
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
     }
 #endif
+    if (dc->bcc_delayed) {
+        if (cond == 0x0) {
+            /* unconditional not taken */
+            /* already in delay slot, so do not take another delay */
+            dc->jump_pc[1] += 4;
+        } else if (cond == 0x8) {
+            /* unconditional taken */
+            dc->jump_pc[1] = target;
+        } else {
+            error_report("conditional branch in delay slot of conditional "
+                "branch at pc=0x" TARGET_FMT_lx, dc->pc);
+            goto handle_cc;
+        }
+
+        return -1;
+    }
+
     if (cond == 0x0) {
         /* unconditional not taken */
         if (a) {
@@ -1471,6 +1497,7 @@ static void do_branch(DisasContext *dc, int32_t offset, 
uint32_t insn, int cc)
             tcg_gen_mov_tl(cpu_pc, cpu_npc);
         }
     } else {
+        handle_cc:
         flush_cond(dc);
         gen_cond(cpu_cond, cc, cond, dc);
         if (a) {
@@ -1479,9 +1506,13 @@ static void do_branch(DisasContext *dc, int32_t offset, 
uint32_t insn, int cc)
             gen_branch_n(dc, target);
         }
     }
+
+    return 0;
 }
 
-static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int 
cc)
+/* returns 0 if new branch instruction, or non-zero if branch is in delay 
slot
+ * of another branch */
+static int do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int 
cc)
 {
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
     target_ulong target = dc->pc + offset;
@@ -1491,6 +1522,22 @@ static void do_fbranch(DisasContext *dc, int32_t 
offset, uint32_t insn, int cc)
         target &= 0xffffffffULL;
     }
 #endif
+    if (dc->bcc_delayed) {
+        if (cond == 0x0) {
+            /* unconditional not taken */
+            /* already in delay slot, so do not take another delay */
+            dc->jump_pc[1] += 4;
+        } else if (cond == 0x8) {
+            /* unconditional taken */
+            dc->jump_pc[1] = target;
+        } else {
+            error_report("conditional branch in delay slot of conditional"
+                "branch at pc=0x" TARGET_FMT_lx, dc->pc);
+            goto handle_cc;
+        }
+        return -1;
+    }
+
     if (cond == 0x0) {
         /* unconditional not taken */
         if (a) {
@@ -1514,6 +1561,7 @@ static void do_fbranch(DisasContext *dc, int32_t offset, 
uint32_t insn, int cc)
             tcg_gen_mov_tl(cpu_pc, cpu_npc);
         }
     } else {
+        handle_cc:
         flush_cond(dc);
         gen_fcond(cpu_cond, cc, cond);
         if (a) {
@@ -1522,6 +1570,8 @@ static void do_fbranch(DisasContext *dc, int32_t offset, 
uint32_t insn, int cc)
             gen_branch_n(dc, target);
         }
     }
+
+    return 0;
 }
 
 #ifdef TARGET_SPARC64
@@ -3179,18 +3229,21 @@ static void disas_sparc_insn(DisasContext * dc, 
unsigned int insn)
 #ifdef TARGET_SPARC64
             case 0x1:           /* V9 BPcc */
                 {
-                    int cc;
+                    int cc, ret;
 
                     target = GET_FIELD_SP(insn, 0, 18);
                     target = sign_extend(target, 19);
                     target <<= 2;
                     cc = GET_FIELD_SP(insn, 20, 21);
                     if (cc == 0)
-                        do_branch(dc, target, insn, 0);
+                        ret = do_branch(dc, target, insn, 0);
                     else if (cc == 2)
-                        do_branch(dc, target, insn, 1);
+                        ret = do_branch(dc, target, insn, 1);
                     else
                         goto illegal_insn;
+                    if (ret) {
+                        break;
+                    }
                     goto jmp_insn;
                 }
             case 0x3:           /* V9 BPr */
@@ -3200,7 +3253,9 @@ static void disas_sparc_insn(DisasContext * dc, unsigned 
int insn)
                     target = sign_extend(target, 16);
                     target <<= 2;
                     cpu_src1 = get_src1(dc, insn);
-                    do_branch_reg(dc, target, insn, cpu_src1);
+                    if (do_branch_reg(dc, target, insn, cpu_src1)) {
+                        break;
+                    }
                     goto jmp_insn;
                 }
             case 0x5:           /* V9 FBPcc */
@@ -3212,7 +3267,9 @@ static void disas_sparc_insn(DisasContext * dc, unsigned 
int insn)
                     target = GET_FIELD_SP(insn, 0, 18);
                     target = sign_extend(target, 19);
                     target <<= 2;
-                    do_fbranch(dc, target, insn, cc);
+                    if (do_fbranch(dc, target, insn, cc)) {
+                        break;
+                    }
                     goto jmp_insn;
                 }
 #else
@@ -3226,7 +3283,9 @@ static void disas_sparc_insn(DisasContext * dc, unsigned 
int insn)
                     target = GET_FIELD(insn, 10, 31);
                     target = sign_extend(target, 22);
                     target <<= 2;
-                    do_branch(dc, target, insn, 0);
+                    if (do_branch(dc, target, insn, 0)) {
+                        break;
+                    }
                     goto jmp_insn;
                 }
             case 0x6:           /* FBN+x */
@@ -3237,7 +3296,9 @@ static void disas_sparc_insn(DisasContext * dc, unsigned 
int insn)
                     target = GET_FIELD(insn, 10, 31);
                     target = sign_extend(target, 22);
                     target <<= 2;
-                    do_fbranch(dc, target, insn, 0);
+                    if (do_fbranch(dc, target, insn, 0)) {
+                        break;
+                    }
                     goto jmp_insn;
                 }
             case 0x4:           /* SETHI */
@@ -5685,6 +5746,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned 
int insn)
         break;
     }
     /* default case for non jump instructions */
+    tcg_gen_movi_tl(bcc_delayed, 0);
+    dc->bcc_delayed = 0;
     if (dc->npc == DYNAMIC_PC) {
         dc->pc = DYNAMIC_PC;
         gen_op_next_insn();
@@ -5749,6 +5812,7 @@ void gen_intermediate_code(CPUState *cs, 
TranslationBlock * tb)
     unsigned int insn;
 
     memset(dc, 0, sizeof(DisasContext));
+    dc->bcc_delayed = env->bcc_delayed;
     dc->tb = tb;
     pc_start = tb->pc;
     dc->pc = pc_start;
@@ -5783,7 +5847,6 @@ void gen_intermediate_code(CPUState *cs, 
TranslationBlock * tb)
     gen_tb_start(tb);
     do {
         if (dc->npc & JUMP_PC) {
-            assert(dc->jump_pc[1] == dc->pc + 4);
             tcg_gen_insn_start(dc->pc, dc->jump_pc[0] | JUMP_PC);
         } else {
             tcg_gen_insn_start(dc->pc, dc->npc);
@@ -5886,6 +5949,7 @@ void sparc_tcg_init(void)
 #endif
         { &cpu_cc_op, offsetof(CPUSPARCState, cc_op), "cc_op" },
         { &cpu_psr, offsetof(CPUSPARCState, psr), "psr" },
+        { &bcc_delayed, offsetof(CPUSPARCState, bcc_delayed), "bcc_delayed" 
},
     };
 
     static const struct { TCGv *ptr; int off; const char *name; } rtl[] = {
-- 
2.13.6



Steven Seeger
Chief Technical Officer
Embedded Flight Systems, Inc.
304-550-8800 (cell)
