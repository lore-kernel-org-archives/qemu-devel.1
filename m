Received: from eggs.gnu.org ([2001:4830:134:3::10]:49076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJv-0005vJ-8l
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJU-00066r-AQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:56:07 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:33887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJT-00064O-Mr
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:40 -0400
Received: by mail-pg0-x236.google.com with SMTP id g20-v6so16327066pgv.1
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:51 -0700
Message-Id: <20180509175458.15642-22-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 21/28] target/s390x: convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

The only non-trivial modification is the use of DISAS_TOO_MANY
in the same way is used by the generic translation loop.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c | 1267 +++++++++++++++++++-------------------
 1 file changed, 632 insertions(+), 635 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 44449f11ab..d08c109fe1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -42,6 +42,7 @@
 #include "exec/helper-gen.h"
 
 #include "trace-tcg.h"
+#include "exec/translator.h"
 #include "exec/log.h"
 
 
@@ -73,9 +74,6 @@ typedef struct {
     } u;
 } DisasCompare;
 
-/* is_jmp field values */
-#define DISAS_EXCP DISAS_TARGET_0
-
 #ifdef DEBUG_INLINE_BRANCHES
 static uint64_t inline_branch_hit[CC_OP_MAX];
 static uint64_t inline_branch_miss[CC_OP_MAX];
@@ -1091,26 +1089,24 @@ typedef struct {
 #define SPEC_r2_f128    16
 
 /* Return values from translate_one, indicating the state of the TB.  */
-typedef enum {
-    /* Continue the TB.  */
-    NO_EXIT,
-    /* We have emitted one or more goto_tb.  No fixup required.  */
-    EXIT_GOTO_TB,
-    /* We are not using a goto_tb (for whatever reason), but have updated
-       the PC (for whatever reason), so there's no need to do it again on
-       exiting the TB.  */
-    EXIT_PC_UPDATED,
-    /* We have updated the PC and CC values.  */
-    EXIT_PC_CC_UPDATED,
-    /* We are exiting the TB, but have neither emitted a goto_tb, nor
-       updated the PC for the next instruction to be executed.  */
-    EXIT_PC_STALE,
-    /* We are exiting the TB to the main loop.  */
-    EXIT_PC_STALE_NOCHAIN,
-    /* We are ending the TB with a noreturn function call, e.g. longjmp.
-       No following code will be executed.  */
-    EXIT_NORETURN,
-} ExitStatus;
+
+/* We are not using a goto_tb (for whatever reason), but have updated
+   the PC (for whatever reason), so there's no need to do it again on
+   exiting the TB.  */
+#define DISAS_PC_UPDATED        DISAS_TARGET_0
+
+/* We have emitted one or more goto_tb.  No fixup required.  */
+#define DISAS_GOTO_TB           DISAS_TARGET_1
+
+/* We have updated the PC and CC values.  */
+#define DISAS_PC_CC_UPDATED     DISAS_TARGET_2
+
+/* We are exiting the TB, but have neither emitted a goto_tb, nor
+   updated the PC for the next instruction to be executed.  */
+#define DISAS_PC_STALE          DISAS_TARGET_3
+
+/* We are exiting the TB to the main loop.  */
+#define DISAS_PC_STALE_NOCHAIN  DISAS_TARGET_4
 
 struct DisasInsn {
     unsigned opc:16;
@@ -1125,7 +1121,7 @@ struct DisasInsn {
     void (*help_prep)(DisasContext *, DisasFields *, DisasOps *);
     void (*help_wout)(DisasContext *, DisasFields *, DisasOps *);
     void (*help_cout)(DisasContext *, DisasOps *);
-    ExitStatus (*help_op)(DisasContext *, DisasOps *);
+    DisasJumpType (*help_op)(DisasContext *, DisasOps *);
 
     uint64_t data;
 };
@@ -1147,11 +1143,11 @@ static void help_l2_shift(DisasContext *s, DisasFields *f,
     }
 }
 
-static ExitStatus help_goto_direct(DisasContext *s, uint64_t dest)
+static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
 {
     if (dest == s->next_pc) {
         per_branch(s, true);
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
     if (use_goto_tb(s, dest)) {
         update_cc_op(s);
@@ -1159,31 +1155,31 @@ static ExitStatus help_goto_direct(DisasContext *s, uint64_t dest)
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(psw_addr, dest);
         tcg_gen_exit_tb((uintptr_t)s->tb);
-        return EXIT_GOTO_TB;
+        return DISAS_GOTO_TB;
     } else {
         tcg_gen_movi_i64(psw_addr, dest);
         per_branch(s, false);
-        return EXIT_PC_UPDATED;
+        return DISAS_PC_UPDATED;
     }
 }
 
-static ExitStatus help_branch(DisasContext *s, DisasCompare *c,
-                              bool is_imm, int imm, TCGv_i64 cdest)
+static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
+                                 bool is_imm, int imm, TCGv_i64 cdest)
 {
-    ExitStatus ret;
+    DisasJumpType ret;
     uint64_t dest = s->pc + 2 * imm;
     TCGLabel *lab;
 
     /* Take care of the special cases first.  */
     if (c->cond == TCG_COND_NEVER) {
-        ret = NO_EXIT;
+        ret = DISAS_NEXT;
         goto egress;
     }
     if (is_imm) {
         if (dest == s->next_pc) {
             /* Branch to next.  */
             per_branch(s, true);
-            ret = NO_EXIT;
+            ret = DISAS_NEXT;
             goto egress;
         }
         if (c->cond == TCG_COND_ALWAYS) {
@@ -1193,13 +1189,13 @@ static ExitStatus help_branch(DisasContext *s, DisasCompare *c,
     } else {
         if (!cdest) {
             /* E.g. bcr %r0 -> no branch.  */
-            ret = NO_EXIT;
+            ret = DISAS_NEXT;
             goto egress;
         }
         if (c->cond == TCG_COND_ALWAYS) {
             tcg_gen_mov_i64(psw_addr, cdest);
             per_branch(s, false);
-            ret = EXIT_PC_UPDATED;
+            ret = DISAS_PC_UPDATED;
             goto egress;
         }
     }
@@ -1228,7 +1224,7 @@ static ExitStatus help_branch(DisasContext *s, DisasCompare *c,
             tcg_gen_movi_i64(psw_addr, dest);
             tcg_gen_exit_tb((uintptr_t)s->tb + 1);
 
-            ret = EXIT_GOTO_TB;
+            ret = DISAS_GOTO_TB;
         } else {
             /* Fallthru can use goto_tb, but taken branch cannot.  */
             /* Store taken branch destination before the brcond.  This
@@ -1256,7 +1252,7 @@ static ExitStatus help_branch(DisasContext *s, DisasCompare *c,
                 tcg_gen_movi_i64(psw_addr, dest);
             }
             per_breaking_event(s);
-            ret = EXIT_PC_UPDATED;
+            ret = DISAS_PC_UPDATED;
         }
     } else {
         /* Fallthru cannot use goto_tb.  This by itself is vanishingly rare.
@@ -1290,7 +1286,7 @@ static ExitStatus help_branch(DisasContext *s, DisasCompare *c,
         }
         tcg_temp_free_i64(next);
 
-        ret = EXIT_PC_UPDATED;
+        ret = DISAS_PC_UPDATED;
     }
 
  egress:
@@ -1302,7 +1298,7 @@ static ExitStatus help_branch(DisasContext *s, DisasCompare *c,
 /* The operations.  These perform the bulk of the work for any insn,
    usually after the operands have been loaded and output initialized.  */
 
-static ExitStatus op_abs(DisasContext *s, DisasOps *o)
+static DisasJumpType op_abs(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 z, n;
     z = tcg_const_i64(0);
@@ -1311,35 +1307,35 @@ static ExitStatus op_abs(DisasContext *s, DisasOps *o)
     tcg_gen_movcond_i64(TCG_COND_LT, o->out, o->in2, z, n, o->in2);
     tcg_temp_free_i64(n);
     tcg_temp_free_i64(z);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_absf32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_absf32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_andi_i64(o->out, o->in2, 0x7fffffffull);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_absf64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_absf64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_andi_i64(o->out, o->in2, 0x7fffffffffffffffull);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_absf128(DisasContext *s, DisasOps *o)
+static DisasJumpType op_absf128(DisasContext *s, DisasOps *o)
 {
     tcg_gen_andi_i64(o->out, o->in1, 0x7fffffffffffffffull);
     tcg_gen_mov_i64(o->out2, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_add(DisasContext *s, DisasOps *o)
+static DisasJumpType op_add(DisasContext *s, DisasOps *o)
 {
     tcg_gen_add_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_addc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_addc(DisasContext *s, DisasOps *o)
 {
     DisasCompare cmp;
     TCGv_i64 carry;
@@ -1363,10 +1359,10 @@ static ExitStatus op_addc(DisasContext *s, DisasOps *o)
 
     tcg_gen_add_i64(o->out, o->out, carry);
     tcg_temp_free_i64(carry);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_asi(DisasContext *s, DisasOps *o)
+static DisasJumpType op_asi(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
 
@@ -1384,35 +1380,35 @@ static ExitStatus op_asi(DisasContext *s, DisasOps *o)
     if (!s390_has_feat(S390_FEAT_STFLE_45)) {
         tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_aeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_aeb(DisasContext *s, DisasOps *o)
 {
     gen_helper_aeb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_adb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_adb(DisasContext *s, DisasOps *o)
 {
     gen_helper_adb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_axb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_axb(DisasContext *s, DisasOps *o)
 {
     gen_helper_axb(o->out, cpu_env, o->out, o->out2, o->in1, o->in2);
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_and(DisasContext *s, DisasOps *o)
+static DisasJumpType op_and(DisasContext *s, DisasOps *o)
 {
     tcg_gen_and_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_andi(DisasContext *s, DisasOps *o)
+static DisasJumpType op_andi(DisasContext *s, DisasOps *o)
 {
     int shift = s->insn->data & 0xff;
     int size = s->insn->data >> 8;
@@ -1426,10 +1422,10 @@ static ExitStatus op_andi(DisasContext *s, DisasOps *o)
     /* Produce the CC from only the bits manipulated.  */
     tcg_gen_andi_i64(cc_dst, o->out, mask);
     set_cc_nz_u64(s, cc_dst);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ni(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ni(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
 
@@ -1447,28 +1443,28 @@ static ExitStatus op_ni(DisasContext *s, DisasOps *o)
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
         tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_bas(DisasContext *s, DisasOps *o)
+static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
 {
     tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->next_pc));
     if (o->in2) {
         tcg_gen_mov_i64(psw_addr, o->in2);
         per_branch(s, false);
-        return EXIT_PC_UPDATED;
+        return DISAS_PC_UPDATED;
     } else {
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 }
 
-static ExitStatus op_basi(DisasContext *s, DisasOps *o)
+static DisasJumpType op_basi(DisasContext *s, DisasOps *o)
 {
     tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->next_pc));
     return help_goto_direct(s, s->pc + 2 * get_field(s->fields, i2));
 }
 
-static ExitStatus op_bc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_bc(DisasContext *s, DisasOps *o)
 {
     int m1 = get_field(s->fields, m1);
     bool is_imm = have_field(s->fields, i2);
@@ -1487,14 +1483,14 @@ static ExitStatus op_bc(DisasContext *s, DisasOps *o)
             /* FIXME: perform checkpoint-synchronisation */
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
         }
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 
     disas_jcc(s, &c, m1);
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
 
-static ExitStatus op_bct32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_bct32(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     bool is_imm = have_field(s->fields, i2);
@@ -1518,7 +1514,7 @@ static ExitStatus op_bct32(DisasContext *s, DisasOps *o)
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
 
-static ExitStatus op_bcth(DisasContext *s, DisasOps *o)
+static DisasJumpType op_bcth(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int imm = get_field(s->fields, i2);
@@ -1542,7 +1538,7 @@ static ExitStatus op_bcth(DisasContext *s, DisasOps *o)
     return help_branch(s, &c, 1, imm, o->in2);
 }
 
-static ExitStatus op_bct64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_bct64(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     bool is_imm = have_field(s->fields, i2);
@@ -1561,7 +1557,7 @@ static ExitStatus op_bct64(DisasContext *s, DisasOps *o)
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
 
-static ExitStatus op_bx32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_bx32(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -1587,7 +1583,7 @@ static ExitStatus op_bx32(DisasContext *s, DisasOps *o)
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
 
-static ExitStatus op_bx64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_bx64(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -1613,7 +1609,7 @@ static ExitStatus op_bx64(DisasContext *s, DisasOps *o)
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
 
-static ExitStatus op_cj(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cj(DisasContext *s, DisasOps *o)
 {
     int imm, m3 = get_field(s->fields, m3);
     bool is_imm;
@@ -1639,186 +1635,186 @@ static ExitStatus op_cj(DisasContext *s, DisasOps *o)
     return help_branch(s, &c, is_imm, imm, o->out);
 }
 
-static ExitStatus op_ceb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ceb(DisasContext *s, DisasOps *o)
 {
     gen_helper_ceb(cc_op, cpu_env, o->in1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cdb(DisasContext *s, DisasOps *o)
 {
     gen_helper_cdb(cc_op, cpu_env, o->in1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cxb(DisasContext *s, DisasOps *o)
 {
     gen_helper_cxb(cc_op, cpu_env, o->out, o->out2, o->in1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cfeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cfeb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cfeb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f32(s, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cfdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cfdb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cfdb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f64(s, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cfxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cfxb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cfxb(o->out, cpu_env, o->in1, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cgeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cgeb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cgeb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f32(s, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cgdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cgdb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cgdb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f64(s, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cgxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cgxb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cgxb(o->out, cpu_env, o->in1, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clfeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clfeb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_clfeb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f32(s, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clfdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clfdb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_clfdb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f64(s, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clfxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clfxb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_clfxb(o->out, cpu_env, o->in1, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clgeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clgeb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_clgeb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f32(s, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clgdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clgdb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_clgdb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f64(s, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clgxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clgxb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_clgxb(o->out, cpu_env, o->in1, o->in2, m3);
     tcg_temp_free_i32(m3);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cegb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cegb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cegb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cdgb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cdgb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cdgb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cxgb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cxgb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cxgb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_celgb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_celgb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_celgb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cdlgb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cdlgb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cdlgb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cxlgb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cxlgb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_cxlgb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cksm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cksm(DisasContext *s, DisasOps *o)
 {
     int r2 = get_field(s->fields, r2);
     TCGv_i64 len = tcg_temp_new_i64();
@@ -1831,10 +1827,10 @@ static ExitStatus op_cksm(DisasContext *s, DisasOps *o)
     tcg_gen_sub_i64(regs[r2 + 1], regs[r2 + 1], len);
     tcg_temp_free_i64(len);
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
 {
     int l = get_field(s->fields, l1);
     TCGv_i32 vl;
@@ -1861,13 +1857,13 @@ static ExitStatus op_clc(DisasContext *s, DisasOps *o)
         gen_helper_clc(cc_op, cpu_env, vl, o->addr1, o->in2);
         tcg_temp_free_i32(vl);
         set_cc_static(s);
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
     gen_op_update2_cc_i64(s, CC_OP_LTUGTU_64, cc_src, cc_dst);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clcl(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clcl(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r2 = get_field(s->fields, r2);
@@ -1876,7 +1872,7 @@ static ExitStatus op_clcl(DisasContext *s, DisasOps *o)
     /* r1 and r2 must be even.  */
     if (r1 & 1 || r2 & 1) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
 
     t1 = tcg_const_i32(r1);
@@ -1885,10 +1881,10 @@ static ExitStatus op_clcl(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t1);
     tcg_temp_free_i32(t2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clcle(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clcle(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -1897,7 +1893,7 @@ static ExitStatus op_clcle(DisasContext *s, DisasOps *o)
     /* r1 and r3 must be even.  */
     if (r1 & 1 || r3 & 1) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
 
     t1 = tcg_const_i32(r1);
@@ -1906,10 +1902,10 @@ static ExitStatus op_clcle(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t1);
     tcg_temp_free_i32(t3);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clclu(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clclu(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -1918,7 +1914,7 @@ static ExitStatus op_clclu(DisasContext *s, DisasOps *o)
     /* r1 and r3 must be even.  */
     if (r1 & 1 || r3 & 1) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
 
     t1 = tcg_const_i32(r1);
@@ -1927,10 +1923,10 @@ static ExitStatus op_clclu(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t1);
     tcg_temp_free_i32(t3);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clm(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     TCGv_i32 t1 = tcg_temp_new_i32();
@@ -1939,28 +1935,28 @@ static ExitStatus op_clm(DisasContext *s, DisasOps *o)
     set_cc_static(s);
     tcg_temp_free_i32(t1);
     tcg_temp_free_i32(m3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_clst(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clst(DisasContext *s, DisasOps *o)
 {
     gen_helper_clst(o->in1, cpu_env, regs[0], o->in1, o->in2);
     set_cc_static(s);
     return_low128(o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cps(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cps(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t = tcg_temp_new_i64();
     tcg_gen_andi_i64(t, o->in1, 0x8000000000000000ull);
     tcg_gen_andi_i64(o->out, o->in2, 0x7fffffffffffffffull);
     tcg_gen_or_i64(o->out, o->out, t);
     tcg_temp_free_i64(t);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cs(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cs(DisasContext *s, DisasOps *o)
 {
     int d2 = get_field(s->fields, d2);
     int b2 = get_field(s->fields, b2);
@@ -1982,10 +1978,10 @@ static ExitStatus op_cs(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(cc);
     set_cc_static(s);
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cdsg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cdsg(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -2008,10 +2004,10 @@ static ExitStatus op_cdsg(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t_r3);
 
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_csst(DisasContext *s, DisasOps *o)
+static DisasJumpType op_csst(DisasContext *s, DisasOps *o)
 {
     int r3 = get_field(s->fields, r3);
     TCGv_i32 t_r3 = tcg_const_i32(r3);
@@ -2024,11 +2020,11 @@ static ExitStatus op_csst(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t_r3);
 
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_csp(DisasContext *s, DisasOps *o)
+static DisasJumpType op_csp(DisasContext *s, DisasOps *o)
 {
     TCGMemOp mop = s->insn->data;
     TCGv_i64 addr, old, cc;
@@ -2069,11 +2065,11 @@ static ExitStatus op_csp(DisasContext *s, DisasOps *o)
     gen_helper_purge(cpu_env);
     gen_set_label(lab);
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 #endif
 
-static ExitStatus op_cvd(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cvd(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i32 t2 = tcg_temp_new_i32();
@@ -2082,10 +2078,10 @@ static ExitStatus op_cvd(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t2);
     tcg_gen_qemu_st64(t1, o->in2, get_mem_index(s));
     tcg_temp_free_i64(t1);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ct(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ct(DisasContext *s, DisasOps *o)
 {
     int m3 = get_field(s->fields, m3);
     TCGLabel *lab = gen_new_label();
@@ -2101,10 +2097,10 @@ static ExitStatus op_ct(DisasContext *s, DisasOps *o)
     gen_trap(s);
 
     gen_set_label(lab);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_cuXX(DisasContext *s, DisasOps *o)
+static DisasJumpType op_cuXX(DisasContext *s, DisasOps *o)
 {
     int m3 = get_field(s->fields, m3);
     int r1 = get_field(s->fields, r1);
@@ -2114,7 +2110,7 @@ static ExitStatus op_cuXX(DisasContext *s, DisasOps *o)
     /* R1 and R2 must both be even.  */
     if ((r1 | r2) & 1) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
     if (!s390_has_feat(S390_FEAT_ETF3_ENH)) {
         m3 = 0;
@@ -2151,11 +2147,11 @@ static ExitStatus op_cuXX(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(tr2);
     tcg_temp_free_i32(chk);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_diag(DisasContext *s, DisasOps *o)
+static DisasJumpType op_diag(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
@@ -2167,78 +2163,78 @@ static ExitStatus op_diag(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(func_code);
     tcg_temp_free_i32(r3);
     tcg_temp_free_i32(r1);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 #endif
 
-static ExitStatus op_divs32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_divs32(DisasContext *s, DisasOps *o)
 {
     gen_helper_divs32(o->out2, cpu_env, o->in1, o->in2);
     return_low128(o->out);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_divu32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_divu32(DisasContext *s, DisasOps *o)
 {
     gen_helper_divu32(o->out2, cpu_env, o->in1, o->in2);
     return_low128(o->out);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_divs64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_divs64(DisasContext *s, DisasOps *o)
 {
     gen_helper_divs64(o->out2, cpu_env, o->in1, o->in2);
     return_low128(o->out);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_divu64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_divu64(DisasContext *s, DisasOps *o)
 {
     gen_helper_divu64(o->out2, cpu_env, o->out, o->out2, o->in2);
     return_low128(o->out);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_deb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_deb(DisasContext *s, DisasOps *o)
 {
     gen_helper_deb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ddb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ddb(DisasContext *s, DisasOps *o)
 {
     gen_helper_ddb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_dxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_dxb(DisasContext *s, DisasOps *o)
 {
     gen_helper_dxb(o->out, cpu_env, o->out, o->out2, o->in1, o->in2);
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ear(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ear(DisasContext *s, DisasOps *o)
 {
     int r2 = get_field(s->fields, r2);
     tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, aregs[r2]));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ecag(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ecag(DisasContext *s, DisasOps *o)
 {
     /* No cache information provided.  */
     tcg_gen_movi_i64(o->out, -1);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_efpc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_efpc(DisasContext *s, DisasOps *o)
 {
     tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, fpc));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_epsw(DisasContext *s, DisasOps *o)
+static DisasJumpType op_epsw(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r2 = get_field(s->fields, r2);
@@ -2253,10 +2249,10 @@ static ExitStatus op_epsw(DisasContext *s, DisasOps *o)
     }
 
     tcg_temp_free_i64(t);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ex(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ex(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     TCGv_i32 ilen;
@@ -2265,7 +2261,7 @@ static ExitStatus op_ex(DisasContext *s, DisasOps *o)
     /* Nested EXECUTE is not allowed.  */
     if (unlikely(s->ex_value)) {
         gen_program_exception(s, PGM_EXECUTE);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
 
     update_psw_addr(s);
@@ -2285,35 +2281,35 @@ static ExitStatus op_ex(DisasContext *s, DisasOps *o)
         tcg_temp_free_i64(v1);
     }
 
-    return EXIT_PC_CC_UPDATED;
+    return DISAS_PC_CC_UPDATED;
 }
 
-static ExitStatus op_fieb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_fieb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_fieb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_fidb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_fidb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_fidb(o->out, cpu_env, o->in2, m3);
     tcg_temp_free_i32(m3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_fixb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_fixb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     gen_helper_fixb(o->out, cpu_env, o->in1, o->in2, m3);
     return_low128(o->out2);
     tcg_temp_free_i32(m3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_flogr(DisasContext *s, DisasOps *o)
+static DisasJumpType op_flogr(DisasContext *s, DisasOps *o)
 {
     /* We'll use the original input for cc computation, since we get to
        compare that against 0, which ought to be better than comparing
@@ -2330,10 +2326,10 @@ static ExitStatus op_flogr(DisasContext *s, DisasOps *o)
     tcg_gen_movi_i64(o->out2, 0x8000000000000000ull);
     tcg_gen_shr_i64(o->out2, o->out2, o->out);
     tcg_gen_andc_i64(o->out2, cc_dst, o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_icm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_icm(DisasContext *s, DisasOps *o)
 {
     int m3 = get_field(s->fields, m3);
     int pos, len, base = s->insn->data;
@@ -2390,18 +2386,18 @@ static ExitStatus op_icm(DisasContext *s, DisasOps *o)
     tcg_gen_movi_i64(tmp, ccm);
     gen_op_update2_cc_i64(s, CC_OP_ICM, tmp, o->out);
     tcg_temp_free_i64(tmp);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_insi(DisasContext *s, DisasOps *o)
+static DisasJumpType op_insi(DisasContext *s, DisasOps *o)
 {
     int shift = s->insn->data & 0xff;
     int size = s->insn->data >> 8;
     tcg_gen_deposit_i64(o->out, o->in1, o->in2, shift, size);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ipm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ipm(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1;
 
@@ -2417,11 +2413,11 @@ static ExitStatus op_ipm(DisasContext *s, DisasOps *o)
     tcg_gen_shli_i64(t1, t1, 28);
     tcg_gen_or_i64(o->out, o->out, t1);
     tcg_temp_free_i64(t1);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_idte(DisasContext *s, DisasOps *o)
+static DisasJumpType op_idte(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m4;
 
@@ -2433,10 +2429,10 @@ static ExitStatus op_idte(DisasContext *s, DisasOps *o)
     }
     gen_helper_idte(cpu_env, o->in1, o->in2, m4);
     tcg_temp_free_i32(m4);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ipte(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ipte(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m4;
 
@@ -2448,18 +2444,18 @@ static ExitStatus op_ipte(DisasContext *s, DisasOps *o)
     }
     gen_helper_ipte(cpu_env, o->in1, o->in2, m4);
     tcg_temp_free_i32(m4);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_iske(DisasContext *s, DisasOps *o)
+static DisasJumpType op_iske(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_iske(o->out, cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 #endif
 
-static ExitStatus op_msa(DisasContext *s, DisasOps *o)
+static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
 {
     int r1 = have_field(s->fields, r1) ? get_field(s->fields, r1) : 0;
     int r2 = have_field(s->fields, r2) ? get_field(s->fields, r2) : 0;
@@ -2470,7 +2466,7 @@ static ExitStatus op_msa(DisasContext *s, DisasOps *o)
     case S390_FEAT_TYPE_KMCTR:
         if (r3 & 1 || !r3) {
             gen_program_exception(s, PGM_SPECIFICATION);
-            return EXIT_NORETURN;
+            return DISAS_NORETURN;
         }
         /* FALL THROUGH */
     case S390_FEAT_TYPE_PPNO:
@@ -2480,7 +2476,7 @@ static ExitStatus op_msa(DisasContext *s, DisasOps *o)
     case S390_FEAT_TYPE_KM:
         if (r1 & 1 || !r1) {
             gen_program_exception(s, PGM_SPECIFICATION);
-            return EXIT_NORETURN;
+            return DISAS_NORETURN;
         }
         /* FALL THROUGH */
     case S390_FEAT_TYPE_KMAC:
@@ -2488,7 +2484,7 @@ static ExitStatus op_msa(DisasContext *s, DisasOps *o)
     case S390_FEAT_TYPE_KLMD:
         if (r2 & 1 || !r2) {
             gen_program_exception(s, PGM_SPECIFICATION);
-            return EXIT_NORETURN;
+            return DISAS_NORETURN;
         }
         /* FALL THROUGH */
     case S390_FEAT_TYPE_PCKMO:
@@ -2508,31 +2504,31 @@ static ExitStatus op_msa(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t_r2);
     tcg_temp_free_i32(t_r3);
     tcg_temp_free_i32(type);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_keb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_keb(DisasContext *s, DisasOps *o)
 {
     gen_helper_keb(cc_op, cpu_env, o->in1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_kdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_kdb(DisasContext *s, DisasOps *o)
 {
     gen_helper_kdb(cc_op, cpu_env, o->in1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_kxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_kxb(DisasContext *s, DisasOps *o)
 {
     gen_helper_kxb(cc_op, cpu_env, o->out, o->out2, o->in1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_laa(DisasContext *s, DisasOps *o)
+static DisasJumpType op_laa(DisasContext *s, DisasOps *o)
 {
     /* The real output is indeed the original value in memory;
        recompute the addition for the computation of CC.  */
@@ -2540,10 +2536,10 @@ static ExitStatus op_laa(DisasContext *s, DisasOps *o)
                                  s->insn->data | MO_ALIGN);
     /* However, we need to recompute the addition for setting CC.  */
     tcg_gen_add_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lan(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lan(DisasContext *s, DisasOps *o)
 {
     /* The real output is indeed the original value in memory;
        recompute the addition for the computation of CC.  */
@@ -2551,10 +2547,10 @@ static ExitStatus op_lan(DisasContext *s, DisasOps *o)
                                  s->insn->data | MO_ALIGN);
     /* However, we need to recompute the operation for setting CC.  */
     tcg_gen_and_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lao(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lao(DisasContext *s, DisasOps *o)
 {
     /* The real output is indeed the original value in memory;
        recompute the addition for the computation of CC.  */
@@ -2562,10 +2558,10 @@ static ExitStatus op_lao(DisasContext *s, DisasOps *o)
                                 s->insn->data | MO_ALIGN);
     /* However, we need to recompute the operation for setting CC.  */
     tcg_gen_or_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lax(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lax(DisasContext *s, DisasOps *o)
 {
     /* The real output is indeed the original value in memory;
        recompute the addition for the computation of CC.  */
@@ -2573,96 +2569,96 @@ static ExitStatus op_lax(DisasContext *s, DisasOps *o)
                                  s->insn->data | MO_ALIGN);
     /* However, we need to recompute the operation for setting CC.  */
     tcg_gen_xor_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ldeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ldeb(DisasContext *s, DisasOps *o)
 {
     gen_helper_ldeb(o->out, cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ledb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ledb(DisasContext *s, DisasOps *o)
 {
     gen_helper_ledb(o->out, cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ldxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ldxb(DisasContext *s, DisasOps *o)
 {
     gen_helper_ldxb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lexb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lexb(DisasContext *s, DisasOps *o)
 {
     gen_helper_lexb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lxdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lxdb(DisasContext *s, DisasOps *o)
 {
     gen_helper_lxdb(o->out, cpu_env, o->in2);
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lxeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lxeb(DisasContext *s, DisasOps *o)
 {
     gen_helper_lxeb(o->out, cpu_env, o->in2);
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_llgt(DisasContext *s, DisasOps *o)
+static DisasJumpType op_llgt(DisasContext *s, DisasOps *o)
 {
     tcg_gen_andi_i64(o->out, o->in2, 0x7fffffff);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ld8s(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ld8s(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld8s(o->out, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ld8u(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ld8u(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld8u(o->out, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ld16s(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ld16s(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld16s(o->out, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ld16u(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ld16u(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld16u(o->out, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ld32s(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ld32s(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld32s(o->out, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ld32u(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ld32u(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld32u(o->out, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ld64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ld64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld64(o->out, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lat(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab = gen_new_label();
     store_reg32_i64(get_field(s->fields, r1), o->in2);
@@ -2670,10 +2666,10 @@ static ExitStatus op_lat(DisasContext *s, DisasOps *o)
     tcg_gen_brcondi_i64(TCG_COND_NE, o->in2, 0, lab);
     gen_trap(s);
     gen_set_label(lab);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lgat(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lgat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab = gen_new_label();
     tcg_gen_qemu_ld64(o->out, o->in2, get_mem_index(s));
@@ -2681,10 +2677,10 @@ static ExitStatus op_lgat(DisasContext *s, DisasOps *o)
     tcg_gen_brcondi_i64(TCG_COND_NE, o->out, 0, lab);
     gen_trap(s);
     gen_set_label(lab);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lfhat(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lfhat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab = gen_new_label();
     store_reg32h_i64(get_field(s->fields, r1), o->in2);
@@ -2692,10 +2688,10 @@ static ExitStatus op_lfhat(DisasContext *s, DisasOps *o)
     tcg_gen_brcondi_i64(TCG_COND_NE, o->in2, 0, lab);
     gen_trap(s);
     gen_set_label(lab);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_llgfat(DisasContext *s, DisasOps *o)
+static DisasJumpType op_llgfat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab = gen_new_label();
     tcg_gen_qemu_ld32u(o->out, o->in2, get_mem_index(s));
@@ -2703,10 +2699,10 @@ static ExitStatus op_llgfat(DisasContext *s, DisasOps *o)
     tcg_gen_brcondi_i64(TCG_COND_NE, o->out, 0, lab);
     gen_trap(s);
     gen_set_label(lab);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_llgtat(DisasContext *s, DisasOps *o)
+static DisasJumpType op_llgtat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab = gen_new_label();
     tcg_gen_andi_i64(o->out, o->in2, 0x7fffffff);
@@ -2714,10 +2710,10 @@ static ExitStatus op_llgtat(DisasContext *s, DisasOps *o)
     tcg_gen_brcondi_i64(TCG_COND_NE, o->out, 0, lab);
     gen_trap(s);
     gen_set_label(lab);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_loc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_loc(DisasContext *s, DisasOps *o)
 {
     DisasCompare c;
 
@@ -2744,11 +2740,11 @@ static ExitStatus op_loc(DisasContext *s, DisasOps *o)
         tcg_temp_free_i64(z);
     }
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_lctl(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lctl(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
@@ -2757,10 +2753,10 @@ static ExitStatus op_lctl(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
     /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
-    return EXIT_PC_STALE_NOCHAIN;
+    return DISAS_PC_STALE_NOCHAIN;
 }
 
-static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
@@ -2769,26 +2765,26 @@ static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
     /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
-    return EXIT_PC_STALE_NOCHAIN;
+    return DISAS_PC_STALE_NOCHAIN;
 }
 
-static ExitStatus op_lra(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_lra(o->out, cpu_env, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lpp(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lpp(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
 
     tcg_gen_st_i64(o->in2, cpu_env, offsetof(CPUS390XState, pp));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lpsw(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lpsw(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1, t2;
 
@@ -2805,10 +2801,10 @@ static ExitStatus op_lpsw(DisasContext *s, DisasOps *o)
     gen_helper_load_psw(cpu_env, t1, t2);
     tcg_temp_free_i64(t1);
     tcg_temp_free_i64(t2);
-    return EXIT_NORETURN;
+    return DISAS_NORETURN;
 }
 
-static ExitStatus op_lpswe(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lpswe(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1, t2;
 
@@ -2823,21 +2819,21 @@ static ExitStatus op_lpswe(DisasContext *s, DisasOps *o)
     gen_helper_load_psw(cpu_env, t1, t2);
     tcg_temp_free_i64(t1);
     tcg_temp_free_i64(t2);
-    return EXIT_NORETURN;
+    return DISAS_NORETURN;
 }
 #endif
 
-static ExitStatus op_lam(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lam(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     gen_helper_lam(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lm32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lm32(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -2849,7 +2845,7 @@ static ExitStatus op_lm32(DisasContext *s, DisasOps *o)
         tcg_gen_qemu_ld32u(t1, o->in2, get_mem_index(s));
         store_reg32_i64(r1, t1);
         tcg_temp_free(t1);
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 
     /* First load the values of the first and last registers to trigger
@@ -2865,7 +2861,7 @@ static ExitStatus op_lm32(DisasContext *s, DisasOps *o)
     if (((r1 + 1) & 15) == r3) {
         tcg_temp_free(t2);
         tcg_temp_free(t1);
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 
     /* Then load the remaining registers. Page fault can't occur. */
@@ -2880,10 +2876,10 @@ static ExitStatus op_lm32(DisasContext *s, DisasOps *o)
     tcg_temp_free(t2);
     tcg_temp_free(t1);
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lmh(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lmh(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -2895,7 +2891,7 @@ static ExitStatus op_lmh(DisasContext *s, DisasOps *o)
         tcg_gen_qemu_ld32u(t1, o->in2, get_mem_index(s));
         store_reg32h_i64(r1, t1);
         tcg_temp_free(t1);
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 
     /* First load the values of the first and last registers to trigger
@@ -2911,7 +2907,7 @@ static ExitStatus op_lmh(DisasContext *s, DisasOps *o)
     if (((r1 + 1) & 15) == r3) {
         tcg_temp_free(t2);
         tcg_temp_free(t1);
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 
     /* Then load the remaining registers. Page fault can't occur. */
@@ -2926,10 +2922,10 @@ static ExitStatus op_lmh(DisasContext *s, DisasOps *o)
     tcg_temp_free(t2);
     tcg_temp_free(t1);
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lm64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lm64(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -2938,7 +2934,7 @@ static ExitStatus op_lm64(DisasContext *s, DisasOps *o)
     /* Only one register to read. */
     if (unlikely(r1 == r3)) {
         tcg_gen_qemu_ld64(regs[r1], o->in2, get_mem_index(s));
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 
     /* First load the values of the first and last registers to trigger
@@ -2954,7 +2950,7 @@ static ExitStatus op_lm64(DisasContext *s, DisasOps *o)
     /* Only two registers to read. */
     if (((r1 + 1) & 15) == r3) {
         tcg_temp_free(t1);
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 
     /* Then load the remaining registers. Page fault can't occur. */
@@ -2967,10 +2963,10 @@ static ExitStatus op_lm64(DisasContext *s, DisasOps *o)
     }
     tcg_temp_free(t1);
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 a1, a2;
     TCGMemOp mop = s->insn->data;
@@ -2980,7 +2976,7 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
         update_psw_addr(s);
         update_cc_op(s);
         gen_exception(EXCP_ATOMIC);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
 
     /* In a serial context, perform the two loads ... */
@@ -2993,10 +2989,10 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
 
     /* ... and indicate that we performed them while interlocked.  */
     gen_op_movi_cc(s, 0);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lpq(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
 {
     if (tb_cflags(s->tb) & CF_PARALLEL) {
         gen_helper_lpq_parallel(o->out, cpu_env, o->in2);
@@ -3004,41 +3000,41 @@ static ExitStatus op_lpq(DisasContext *s, DisasOps *o)
         gen_helper_lpq(o->out, cpu_env, o->in2);
     }
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_lura(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lura(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_lura(o->out, cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_lurag(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lurag(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_lurag(o->out, cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 #endif
 
-static ExitStatus op_lzrb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_lzrb(DisasContext *s, DisasOps *o)
 {
     tcg_gen_andi_i64(o->out, o->in2, -256);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mov2(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mov2(DisasContext *s, DisasOps *o)
 {
     o->out = o->in2;
     o->g_out = o->g_in2;
     o->in2 = NULL;
     o->g_in2 = false;
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mov2e(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
 {
     int b2 = get_field(s->fields, b2);
     TCGv ar1 = tcg_temp_new_i64();
@@ -3070,10 +3066,10 @@ static ExitStatus op_mov2e(DisasContext *s, DisasOps *o)
     tcg_gen_st32_i64(ar1, cpu_env, offsetof(CPUS390XState, aregs[1]));
     tcg_temp_free_i64(ar1);
 
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_movx(DisasContext *s, DisasOps *o)
+static DisasJumpType op_movx(DisasContext *s, DisasOps *o)
 {
     o->out = o->in1;
     o->out2 = o->in2;
@@ -3082,26 +3078,26 @@ static ExitStatus op_movx(DisasContext *s, DisasOps *o)
     o->in1 = NULL;
     o->in2 = NULL;
     o->g_in1 = o->g_in2 = false;
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_mvc(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvcin(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvcin(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_mvcin(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvcl(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvcl(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r2 = get_field(s->fields, r2);
@@ -3110,7 +3106,7 @@ static ExitStatus op_mvcl(DisasContext *s, DisasOps *o)
     /* r1 and r2 must be even.  */
     if (r1 & 1 || r2 & 1) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
 
     t1 = tcg_const_i32(r1);
@@ -3119,10 +3115,10 @@ static ExitStatus op_mvcl(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t1);
     tcg_temp_free_i32(t2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvcle(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvcle(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -3131,7 +3127,7 @@ static ExitStatus op_mvcle(DisasContext *s, DisasOps *o)
     /* r1 and r3 must be even.  */
     if (r1 & 1 || r3 & 1) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
 
     t1 = tcg_const_i32(r1);
@@ -3140,10 +3136,10 @@ static ExitStatus op_mvcle(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t1);
     tcg_temp_free_i32(t3);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvclu(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvclu(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -3152,7 +3148,7 @@ static ExitStatus op_mvclu(DisasContext *s, DisasOps *o)
     /* r1 and r3 must be even.  */
     if (r1 & 1 || r3 & 1) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
 
     t1 = tcg_const_i32(r1);
@@ -3161,151 +3157,151 @@ static ExitStatus op_mvclu(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t1);
     tcg_temp_free_i32(t3);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvcos(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvcos(DisasContext *s, DisasOps *o)
 {
     int r3 = get_field(s->fields, r3);
     gen_helper_mvcos(cc_op, cpu_env, o->addr1, o->in2, regs[r3]);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_mvcp(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvcp(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, l1);
     check_privileged(s);
     gen_helper_mvcp(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvcs(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvcs(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, l1);
     check_privileged(s);
     gen_helper_mvcs(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 #endif
 
-static ExitStatus op_mvn(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvn(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_mvn(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvo(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvo(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_mvo(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvpg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvpg(DisasContext *s, DisasOps *o)
 {
     gen_helper_mvpg(cc_op, cpu_env, regs[0], o->in1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvst(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvst(DisasContext *s, DisasOps *o)
 {
     gen_helper_mvst(o->in1, cpu_env, regs[0], o->in1, o->in2);
     set_cc_static(s);
     return_low128(o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mvz(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mvz(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_mvz(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mul(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mul(DisasContext *s, DisasOps *o)
 {
     tcg_gen_mul_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mul128(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mul128(DisasContext *s, DisasOps *o)
 {
     tcg_gen_mulu2_i64(o->out2, o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_meeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_meeb(DisasContext *s, DisasOps *o)
 {
     gen_helper_meeb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mdeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mdeb(DisasContext *s, DisasOps *o)
 {
     gen_helper_mdeb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mdb(DisasContext *s, DisasOps *o)
 {
     gen_helper_mdb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mxb(DisasContext *s, DisasOps *o)
 {
     gen_helper_mxb(o->out, cpu_env, o->out, o->out2, o->in1, o->in2);
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mxdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mxdb(DisasContext *s, DisasOps *o)
 {
     gen_helper_mxdb(o->out, cpu_env, o->out, o->out2, o->in2);
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_maeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_maeb(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 r3 = load_freg32_i64(get_field(s->fields, r3));
     gen_helper_maeb(o->out, cpu_env, o->in1, o->in2, r3);
     tcg_temp_free_i64(r3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_madb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_madb(DisasContext *s, DisasOps *o)
 {
     int r3 = get_field(s->fields, r3);
     gen_helper_madb(o->out, cpu_env, o->in1, o->in2, fregs[r3]);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mseb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mseb(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 r3 = load_freg32_i64(get_field(s->fields, r3));
     gen_helper_mseb(o->out, cpu_env, o->in1, o->in2, r3);
     tcg_temp_free_i64(r3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_msdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_msdb(DisasContext *s, DisasOps *o)
 {
     int r3 = get_field(s->fields, r3);
     gen_helper_msdb(o->out, cpu_env, o->in1, o->in2, fregs[r3]);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_nabs(DisasContext *s, DisasOps *o)
+static DisasJumpType op_nabs(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 z, n;
     z = tcg_const_i64(0);
@@ -3314,78 +3310,78 @@ static ExitStatus op_nabs(DisasContext *s, DisasOps *o)
     tcg_gen_movcond_i64(TCG_COND_GE, o->out, o->in2, z, n, o->in2);
     tcg_temp_free_i64(n);
     tcg_temp_free_i64(z);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_nabsf32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_nabsf32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_ori_i64(o->out, o->in2, 0x80000000ull);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_nabsf64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_nabsf64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_ori_i64(o->out, o->in2, 0x8000000000000000ull);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_nabsf128(DisasContext *s, DisasOps *o)
+static DisasJumpType op_nabsf128(DisasContext *s, DisasOps *o)
 {
     tcg_gen_ori_i64(o->out, o->in1, 0x8000000000000000ull);
     tcg_gen_mov_i64(o->out2, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_nc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_nc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_nc(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_neg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_neg(DisasContext *s, DisasOps *o)
 {
     tcg_gen_neg_i64(o->out, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_negf32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_negf32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_xori_i64(o->out, o->in2, 0x80000000ull);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_negf64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_negf64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_xori_i64(o->out, o->in2, 0x8000000000000000ull);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_negf128(DisasContext *s, DisasOps *o)
+static DisasJumpType op_negf128(DisasContext *s, DisasOps *o)
 {
     tcg_gen_xori_i64(o->out, o->in1, 0x8000000000000000ull);
     tcg_gen_mov_i64(o->out2, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_oc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_oc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_oc(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_or(DisasContext *s, DisasOps *o)
+static DisasJumpType op_or(DisasContext *s, DisasOps *o)
 {
     tcg_gen_or_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ori(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ori(DisasContext *s, DisasOps *o)
 {
     int shift = s->insn->data & 0xff;
     int size = s->insn->data >> 8;
@@ -3398,10 +3394,10 @@ static ExitStatus op_ori(DisasContext *s, DisasOps *o)
     /* Produce the CC from only the bits manipulated.  */
     tcg_gen_andi_i64(cc_dst, o->out, mask);
     set_cc_nz_u64(s, cc_dst);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_oi(DisasContext *s, DisasOps *o)
+static DisasJumpType op_oi(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
 
@@ -3419,18 +3415,18 @@ static ExitStatus op_oi(DisasContext *s, DisasOps *o)
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
         tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_pack(DisasContext *s, DisasOps *o)
+static DisasJumpType op_pack(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_pack(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_pka(DisasContext *s, DisasOps *o)
+static DisasJumpType op_pka(DisasContext *s, DisasOps *o)
 {
     int l2 = get_field(s->fields, l2) + 1;
     TCGv_i32 l;
@@ -3438,15 +3434,15 @@ static ExitStatus op_pka(DisasContext *s, DisasOps *o)
     /* The length must not exceed 32 bytes.  */
     if (l2 > 32) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
     l = tcg_const_i32(l2);
     gen_helper_pka(cpu_env, o->addr1, o->in2, l);
     tcg_temp_free_i32(l);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_pku(DisasContext *s, DisasOps *o)
+static DisasJumpType op_pku(DisasContext *s, DisasOps *o)
 {
     int l2 = get_field(s->fields, l2) + 1;
     TCGv_i32 l;
@@ -3454,30 +3450,30 @@ static ExitStatus op_pku(DisasContext *s, DisasOps *o)
     /* The length must be even and should not exceed 64 bytes.  */
     if ((l2 & 1) || (l2 > 64)) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
     l = tcg_const_i32(l2);
     gen_helper_pku(cpu_env, o->addr1, o->in2, l);
     tcg_temp_free_i32(l);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_popcnt(DisasContext *s, DisasOps *o)
+static DisasJumpType op_popcnt(DisasContext *s, DisasOps *o)
 {
     gen_helper_popcnt(o->out, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_ptlb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ptlb(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_ptlb(cpu_env);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 #endif
 
-static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_risbg(DisasContext *s, DisasOps *o)
 {
     int i3 = get_field(s->fields, i3);
     int i4 = get_field(s->fields, i4);
@@ -3535,7 +3531,7 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
     /* In some cases we can implement this with extract.  */
     if (imask == 0 && pos == 0 && len > 0 && len <= rot) {
         tcg_gen_extract_i64(o->out, o->in2, 64 - rot, len);
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 
     /* In some cases we can implement this with deposit.  */
@@ -3564,10 +3560,10 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
         tcg_gen_andi_i64(o->out, o->out, imask);
         tcg_gen_or_i64(o->out, o->out, o->in2);
     }
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_rosbg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_rosbg(DisasContext *s, DisasOps *o)
 {
     int i3 = get_field(s->fields, i3);
     int i4 = get_field(s->fields, i4);
@@ -3617,28 +3613,28 @@ static ExitStatus op_rosbg(DisasContext *s, DisasOps *o)
     /* Set the CC.  */
     tcg_gen_andi_i64(cc_dst, o->out, mask);
     set_cc_nz_u64(s, cc_dst);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_rev16(DisasContext *s, DisasOps *o)
+static DisasJumpType op_rev16(DisasContext *s, DisasOps *o)
 {
     tcg_gen_bswap16_i64(o->out, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_rev32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_rev32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_bswap32_i64(o->out, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_rev64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_rev64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_bswap64_i64(o->out, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_rll32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_rll32(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 t1 = tcg_temp_new_i32();
     TCGv_i32 t2 = tcg_temp_new_i32();
@@ -3650,34 +3646,34 @@ static ExitStatus op_rll32(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t1);
     tcg_temp_free_i32(t2);
     tcg_temp_free_i32(to);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_rll64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_rll64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_rotl_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_rrbe(DisasContext *s, DisasOps *o)
+static DisasJumpType op_rrbe(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_rrbe(cc_op, cpu_env, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sacf(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sacf(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_sacf(cpu_env, o->in2);
     /* Addressing mode has changed, so end the block.  */
-    return EXIT_PC_STALE;
+    return DISAS_PC_STALE;
 }
 #endif
 
-static ExitStatus op_sam(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sam(DisasContext *s, DisasOps *o)
 {
     int sam = s->insn->data;
     TCGv_i64 tsam;
@@ -3700,7 +3696,7 @@ static ExitStatus op_sam(DisasContext *s, DisasOps *o)
        documents that Bad Things Happen two bytes before the end.  */
     if (s->pc & ~mask) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
     s->next_pc &= mask;
 
@@ -3709,64 +3705,64 @@ static ExitStatus op_sam(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tsam);
 
     /* Always exit the TB, since we (may have) changed execution mode.  */
-    return EXIT_PC_STALE;
+    return DISAS_PC_STALE;
 }
 
-static ExitStatus op_sar(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sar(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     tcg_gen_st32_i64(o->in2, cpu_env, offsetof(CPUS390XState, aregs[r1]));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_seb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_seb(DisasContext *s, DisasOps *o)
 {
     gen_helper_seb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sdb(DisasContext *s, DisasOps *o)
 {
     gen_helper_sdb(o->out, cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sxb(DisasContext *s, DisasOps *o)
 {
     gen_helper_sxb(o->out, cpu_env, o->out, o->out2, o->in1, o->in2);
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sqeb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sqeb(DisasContext *s, DisasOps *o)
 {
     gen_helper_sqeb(o->out, cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sqdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sqdb(DisasContext *s, DisasOps *o)
 {
     gen_helper_sqdb(o->out, cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sqxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sqxb(DisasContext *s, DisasOps *o)
 {
     gen_helper_sqxb(o->out, cpu_env, o->in1, o->in2);
     return_low128(o->out2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_servc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_servc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_servc(cc_op, cpu_env, o->in2, o->in1);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sigp(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sigp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
@@ -3775,11 +3771,11 @@ static ExitStatus op_sigp(DisasContext *s, DisasOps *o)
     set_cc_static(s);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 #endif
 
-static ExitStatus op_soc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_soc(DisasContext *s, DisasOps *o)
 {
     DisasCompare c;
     TCGv_i64 a, h;
@@ -3821,10 +3817,10 @@ static ExitStatus op_soc(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(a);
 
     gen_set_label(lab);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sla(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sla(DisasContext *s, DisasOps *o)
 {
     uint64_t sign = 1ull << s->insn->data;
     enum cc_op cco = s->insn->data == 31 ? CC_OP_SLA_32 : CC_OP_SLA_64;
@@ -3835,40 +3831,40 @@ static ExitStatus op_sla(DisasContext *s, DisasOps *o)
     tcg_gen_andi_i64(o->out, o->out, ~sign);
     tcg_gen_andi_i64(o->in1, o->in1, sign);
     tcg_gen_or_i64(o->out, o->out, o->in1);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sll(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sll(DisasContext *s, DisasOps *o)
 {
     tcg_gen_shl_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sra(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sra(DisasContext *s, DisasOps *o)
 {
     tcg_gen_sar_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_srl(DisasContext *s, DisasOps *o)
+static DisasJumpType op_srl(DisasContext *s, DisasOps *o)
 {
     tcg_gen_shr_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sfpc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sfpc(DisasContext *s, DisasOps *o)
 {
     gen_helper_sfpc(cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sfas(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sfas(DisasContext *s, DisasOps *o)
 {
     gen_helper_sfas(cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_srnm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_srnm(DisasContext *s, DisasOps *o)
 {
     int b2 = get_field(s->fields, b2);
     int d2 = get_field(s->fields, d2);
@@ -3905,10 +3901,10 @@ static ExitStatus op_srnm(DisasContext *s, DisasOps *o)
     /* Then install the new FPC to set the rounding mode in fpu_status.  */
     gen_helper_sfpc(cpu_env, t2);
     tcg_temp_free_i64(t2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_spm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_spm(DisasContext *s, DisasOps *o)
 {
     tcg_gen_extrl_i64_i32(cc_op, o->in1);
     tcg_gen_extract_i32(cc_op, cc_op, 28, 2);
@@ -3916,10 +3912,10 @@ static ExitStatus op_spm(DisasContext *s, DisasOps *o)
 
     tcg_gen_shri_i64(o->in1, o->in1, 24);
     tcg_gen_deposit_i64(psw_mask, psw_mask, o->in1, PSW_SHIFT_MASK_PM, 4);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ectg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ectg(DisasContext *s, DisasOps *o)
 {
     int b1 = get_field(s->fields, b1);
     int d1 = get_field(s->fields, d1);
@@ -3946,49 +3942,49 @@ static ExitStatus op_ectg(DisasContext *s, DisasOps *o)
     tcg_gen_mov_i64(regs[1], o->in2);
 
     tcg_temp_free_i64(tmp);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_spka(DisasContext *s, DisasOps *o)
+static DisasJumpType op_spka(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_shri_i64(o->in2, o->in2, 4);
     tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, PSW_SHIFT_KEY, 4);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sske(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sske(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_sske(cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ssm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ssm(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, 56, 8);
     /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
-    return EXIT_PC_STALE_NOCHAIN;
+    return DISAS_PC_STALE_NOCHAIN;
 }
 
-static ExitStatus op_stap(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stap(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stck(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stck(DisasContext *s, DisasOps *o)
 {
     gen_helper_stck(o->out, cpu_env);
     /* ??? We don't implement clock states.  */
     gen_op_movi_cc(s, 0);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stcke(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 c1 = tcg_temp_new_i64();
     TCGv_i64 c2 = tcg_temp_new_i64();
@@ -4012,31 +4008,31 @@ static ExitStatus op_stcke(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(todpr);
     /* ??? We don't implement clock states.  */
     gen_op_movi_cc(s, 0);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sckc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sckc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_sckc(cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sckpf(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sckpf(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_sckpf(cpu_env, regs[0]);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stckc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stckc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stckc(o->out, cpu_env);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stctg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stctg(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
@@ -4044,10 +4040,10 @@ static ExitStatus op_stctg(DisasContext *s, DisasOps *o)
     gen_helper_stctg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stctl(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stctl(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
@@ -4055,186 +4051,186 @@ static ExitStatus op_stctl(DisasContext *s, DisasOps *o)
     gen_helper_stctl(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stidp(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stidp(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_ld_i64(o->out, cpu_env, offsetof(CPUS390XState, cpuid));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_spt(DisasContext *s, DisasOps *o)
+static DisasJumpType op_spt(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_spt(cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stfl(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stfl(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stfl(cpu_env);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stpt(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stpt(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stpt(o->out, cpu_env);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stsi(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stsi(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stsi(cc_op, cpu_env, o->in2, regs[0], regs[1]);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_spx(DisasContext *s, DisasOps *o)
+static DisasJumpType op_spx(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_spx(cpu_env, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_xsch(DisasContext *s, DisasOps *o)
+static DisasJumpType op_xsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_xsch(cpu_env, regs[1]);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_csch(DisasContext *s, DisasOps *o)
+static DisasJumpType op_csch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_csch(cpu_env, regs[1]);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_hsch(DisasContext *s, DisasOps *o)
+static DisasJumpType op_hsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_hsch(cpu_env, regs[1]);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_msch(DisasContext *s, DisasOps *o)
+static DisasJumpType op_msch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_msch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_rchp(DisasContext *s, DisasOps *o)
+static DisasJumpType op_rchp(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_rchp(cpu_env, regs[1]);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_rsch(DisasContext *s, DisasOps *o)
+static DisasJumpType op_rsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_rsch(cpu_env, regs[1]);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sal(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sal(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_sal(cpu_env, regs[1]);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_schm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_schm(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_schm(cpu_env, regs[1], regs[2], o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_siga(DisasContext *s, DisasOps *o)
+static DisasJumpType op_siga(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     /* From KVM code: Not provided, set CC = 3 for subchannel not operational */
     gen_op_movi_cc(s, 3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stcps(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stcps(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     /* The instruction is suppressed if not provided. */
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ssch(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ssch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_ssch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stsch(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stsch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stcrw(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stcrw(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stcrw(cpu_env, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_tpi(DisasContext *s, DisasOps *o)
+static DisasJumpType op_tpi(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_tpi(cc_op, cpu_env, o->addr1);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_tsch(DisasContext *s, DisasOps *o)
+static DisasJumpType op_tsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_tsch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_chsc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_chsc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_chsc(cpu_env, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stpx(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stpx(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_ld_i64(o->out, cpu_env, offsetof(CPUS390XState, psa));
     tcg_gen_andi_i64(o->out, o->out, 0x7fffe000);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stnosm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
 {
     uint64_t i2 = get_field(s->fields, i2);
     TCGv_i64 t;
@@ -4257,66 +4253,66 @@ static ExitStatus op_stnosm(DisasContext *s, DisasOps *o)
     }
 
     /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
-    return EXIT_PC_STALE_NOCHAIN;
+    return DISAS_PC_STALE_NOCHAIN;
 }
 
-static ExitStatus op_stura(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stura(cpu_env, o->in2, o->in1);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sturg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sturg(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_sturg(cpu_env, o->in2, o->in1);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 #endif
 
-static ExitStatus op_stfle(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stfle(DisasContext *s, DisasOps *o)
 {
     gen_helper_stfle(cc_op, cpu_env, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_st8(DisasContext *s, DisasOps *o)
+static DisasJumpType op_st8(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st8(o->in1, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_st16(DisasContext *s, DisasOps *o)
+static DisasJumpType op_st16(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st16(o->in1, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_st32(DisasContext *s, DisasOps *o)
+static DisasJumpType op_st32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st32(o->in1, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_st64(DisasContext *s, DisasOps *o)
+static DisasJumpType op_st64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st64(o->in1, o->in2, get_mem_index(s));
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stam(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stam(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     gen_helper_stam(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stcm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stcm(DisasContext *s, DisasOps *o)
 {
     int m3 = get_field(s->fields, m3);
     int pos, base = s->insn->data;
@@ -4362,10 +4358,10 @@ static ExitStatus op_stcm(DisasContext *s, DisasOps *o)
         break;
     }
     tcg_temp_free_i64(tmp);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stm(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stm(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -4386,10 +4382,10 @@ static ExitStatus op_stm(DisasContext *s, DisasOps *o)
     }
 
     tcg_temp_free_i64(tsize);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stmh(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stmh(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, r1);
     int r3 = get_field(s->fields, r3);
@@ -4410,20 +4406,20 @@ static ExitStatus op_stmh(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(t);
     tcg_temp_free_i64(t4);
     tcg_temp_free_i64(t32);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stpq(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stpq(DisasContext *s, DisasOps *o)
 {
     if (tb_cflags(s->tb) & CF_PARALLEL) {
         gen_helper_stpq_parallel(cpu_env, o->in2, o->out2, o->out);
     } else {
         gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
     }
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_srst(DisasContext *s, DisasOps *o)
+static DisasJumpType op_srst(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
@@ -4433,10 +4429,10 @@ static ExitStatus op_srst(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_srstu(DisasContext *s, DisasOps *o)
+static DisasJumpType op_srstu(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
@@ -4446,16 +4442,16 @@ static ExitStatus op_srstu(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sub(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sub(DisasContext *s, DisasOps *o)
 {
     tcg_gen_sub_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_subb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_subb(DisasContext *s, DisasOps *o)
 {
     DisasCompare cmp;
     TCGv_i64 borrow;
@@ -4478,10 +4474,10 @@ static ExitStatus op_subb(DisasContext *s, DisasOps *o)
 
     tcg_gen_sub_i64(o->out, o->out, borrow);
     tcg_temp_free_i64(borrow);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_svc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_svc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 t;
 
@@ -4497,104 +4493,104 @@ static ExitStatus op_svc(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(t);
 
     gen_exception(EXCP_SVC);
-    return EXIT_NORETURN;
+    return DISAS_NORETURN;
 }
 
-static ExitStatus op_tam(DisasContext *s, DisasOps *o)
+static DisasJumpType op_tam(DisasContext *s, DisasOps *o)
 {
     int cc = 0;
 
     cc |= (s->tb->flags & FLAG_MASK_64) ? 2 : 0;
     cc |= (s->tb->flags & FLAG_MASK_32) ? 1 : 0;
     gen_op_movi_cc(s, cc);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_tceb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_tceb(DisasContext *s, DisasOps *o)
 {
     gen_helper_tceb(cc_op, cpu_env, o->in1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_tcdb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_tcdb(DisasContext *s, DisasOps *o)
 {
     gen_helper_tcdb(cc_op, cpu_env, o->in1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_tcxb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_tcxb(DisasContext *s, DisasOps *o)
 {
     gen_helper_tcxb(cc_op, cpu_env, o->out, o->out2, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
 
-static ExitStatus op_testblock(DisasContext *s, DisasOps *o)
+static DisasJumpType op_testblock(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_testblock(cc_op, cpu_env, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
+static DisasJumpType op_tprot(DisasContext *s, DisasOps *o)
 {
     gen_helper_tprot(cc_op, cpu_env, o->addr1, o->in2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #endif
 
-static ExitStatus op_tp(DisasContext *s, DisasOps *o)
+static DisasJumpType op_tp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l1 = tcg_const_i32(get_field(s->fields, l1) + 1);
     gen_helper_tp(cc_op, cpu_env, o->addr1, l1);
     tcg_temp_free_i32(l1);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_tr(DisasContext *s, DisasOps *o)
+static DisasJumpType op_tr(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_tr(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_tre(DisasContext *s, DisasOps *o)
+static DisasJumpType op_tre(DisasContext *s, DisasOps *o)
 {
     gen_helper_tre(o->out, cpu_env, o->out, o->out2, o->in2);
     return_low128(o->out2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_trt(DisasContext *s, DisasOps *o)
+static DisasJumpType op_trt(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_trt(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_trtr(DisasContext *s, DisasOps *o)
+static DisasJumpType op_trtr(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_trtr(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_trXX(DisasContext *s, DisasOps *o)
+static DisasJumpType op_trXX(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
@@ -4622,28 +4618,28 @@ static ExitStatus op_trXX(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(sizes);
     tcg_temp_free_i32(tst);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_ts(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ts(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 t1 = tcg_const_i32(0xff);
     tcg_gen_atomic_xchg_i32(t1, o->in2, t1, get_mem_index(s), MO_UB);
     tcg_gen_extract_i32(cc_op, t1, 7, 1);
     tcg_temp_free_i32(t1);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_unpk(DisasContext *s, DisasOps *o)
+static DisasJumpType op_unpk(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
     gen_helper_unpk(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_unpka(DisasContext *s, DisasOps *o)
+static DisasJumpType op_unpka(DisasContext *s, DisasOps *o)
 {
     int l1 = get_field(s->fields, l1) + 1;
     TCGv_i32 l;
@@ -4651,16 +4647,16 @@ static ExitStatus op_unpka(DisasContext *s, DisasOps *o)
     /* The length must not exceed 32 bytes.  */
     if (l1 > 32) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
     l = tcg_const_i32(l1);
     gen_helper_unpka(cc_op, cpu_env, o->addr1, l, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_unpku(DisasContext *s, DisasOps *o)
+static DisasJumpType op_unpku(DisasContext *s, DisasOps *o)
 {
     int l1 = get_field(s->fields, l1) + 1;
     TCGv_i32 l;
@@ -4668,17 +4664,17 @@ static ExitStatus op_unpku(DisasContext *s, DisasOps *o)
     /* The length must be even and should not exceed 64 bytes.  */
     if ((l1 & 1) || (l1 > 64)) {
         gen_program_exception(s, PGM_SPECIFICATION);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
     l = tcg_const_i32(l1);
     gen_helper_unpku(cc_op, cpu_env, o->addr1, l, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 
-static ExitStatus op_xc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_xc(DisasContext *s, DisasOps *o)
 {
     int d1 = get_field(s->fields, d1);
     int d2 = get_field(s->fields, d2);
@@ -4719,7 +4715,7 @@ static ExitStatus op_xc(DisasContext *s, DisasOps *o)
             tcg_gen_qemu_st8(o->in2, o->addr1, get_mem_index(s));
         }
         gen_op_movi_cc(s, 0);
-        return NO_EXIT;
+        return DISAS_NEXT;
     }
 
     /* But in general we'll defer to a helper.  */
@@ -4728,16 +4724,16 @@ static ExitStatus op_xc(DisasContext *s, DisasOps *o)
     gen_helper_xc(cc_op, cpu_env, t32, o->addr1, o->in2);
     tcg_temp_free_i32(t32);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_xor(DisasContext *s, DisasOps *o)
+static DisasJumpType op_xor(DisasContext *s, DisasOps *o)
 {
     tcg_gen_xor_i64(o->out, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_xori(DisasContext *s, DisasOps *o)
+static DisasJumpType op_xori(DisasContext *s, DisasOps *o)
 {
     int shift = s->insn->data & 0xff;
     int size = s->insn->data >> 8;
@@ -4750,10 +4746,10 @@ static ExitStatus op_xori(DisasContext *s, DisasOps *o)
     /* Produce the CC from only the bits manipulated.  */
     tcg_gen_andi_i64(cc_dst, o->out, mask);
     set_cc_nz_u64(s, cc_dst);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_xi(DisasContext *s, DisasOps *o)
+static DisasJumpType op_xi(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
 
@@ -4771,25 +4767,25 @@ static ExitStatus op_xi(DisasContext *s, DisasOps *o)
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
         tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_zero(DisasContext *s, DisasOps *o)
+static DisasJumpType op_zero(DisasContext *s, DisasOps *o)
 {
     o->out = tcg_const_i64(0);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_zero2(DisasContext *s, DisasOps *o)
+static DisasJumpType op_zero2(DisasContext *s, DisasOps *o)
 {
     o->out = tcg_const_i64(0);
     o->out2 = o->out;
     o->g_out2 = true;
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
-static ExitStatus op_clp(DisasContext *s, DisasOps *o)
+static DisasJumpType op_clp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
 
@@ -4797,10 +4793,10 @@ static ExitStatus op_clp(DisasContext *s, DisasOps *o)
     gen_helper_clp(cpu_env, r2);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_pcilg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_pcilg(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
@@ -4810,10 +4806,10 @@ static ExitStatus op_pcilg(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_pcistg(DisasContext *s, DisasOps *o)
+static DisasJumpType op_pcistg(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
@@ -4823,10 +4819,10 @@ static ExitStatus op_pcistg(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_stpcifc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_stpcifc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
@@ -4836,17 +4832,17 @@ static ExitStatus op_stpcifc(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_sic(DisasContext *s, DisasOps *o)
+static DisasJumpType op_sic(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_sic(cpu_env, o->in1, o->in2);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_rpcit(DisasContext *s, DisasOps *o)
+static DisasJumpType op_rpcit(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
@@ -4856,10 +4852,10 @@ static ExitStatus op_rpcit(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_pcistb(DisasContext *s, DisasOps *o)
+static DisasJumpType op_pcistb(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
@@ -4871,10 +4867,10 @@ static ExitStatus op_pcistb(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 
-static ExitStatus op_mpcifc(DisasContext *s, DisasOps *o)
+static DisasJumpType op_mpcifc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
@@ -4884,7 +4880,7 @@ static ExitStatus op_mpcifc(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
     set_cc_static(s);
-    return NO_EXIT;
+    return DISAS_NEXT;
 }
 #endif
 
@@ -6028,10 +6024,10 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
     return info;
 }
 
-static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
+static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 {
     const DisasInsn *insn;
-    ExitStatus ret = NO_EXIT;
+    DisasJumpType ret = DISAS_NEXT;
     DisasFields f;
     DisasOps o;
 
@@ -6043,7 +6039,7 @@ static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
         qemu_log_mask(LOG_UNIMP, "unimplemented opcode 0x%02x%02x\n",
                       f.op, f.op2);
         gen_illegal_opcode(s);
-        return EXIT_NORETURN;
+        return DISAS_NORETURN;
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -6090,7 +6086,7 @@ static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
         }
         if (excp) {
             gen_program_exception(s, excp);
-            return EXIT_NORETURN;
+            return DISAS_NORETURN;
         }
     }
 
@@ -6144,7 +6140,7 @@ static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
 #ifndef CONFIG_USER_ONLY
     if (s->tb->flags & FLAG_MASK_PER) {
         /* An exception might be triggered, save PSW if not already done.  */
-        if (ret == NO_EXIT || ret == EXIT_PC_STALE) {
+        if (ret == DISAS_NEXT || ret == DISAS_PC_STALE) {
             tcg_gen_movi_i64(psw_addr, s->next_pc);
         }
 
@@ -6165,7 +6161,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     target_ulong pc_start;
     uint64_t page_start;
     int num_insns, max_insns;
-    ExitStatus status;
+    DisasJumpType status;
     bool do_debug;
 
     pc_start = tb->pc;
@@ -6199,7 +6195,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         num_insns++;
 
         if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
-            status = EXIT_PC_STALE;
+            status = DISAS_PC_STALE;
             do_debug = true;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
@@ -6217,39 +6213,40 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
         /* If we reach a page boundary, are single stepping,
            or exhaust instruction count, stop generation.  */
-        if (status == NO_EXIT
+        if (status == DISAS_NEXT
             && (dc.pc - page_start >= TARGET_PAGE_SIZE
                 || tcg_op_buf_full()
                 || num_insns >= max_insns
                 || singlestep
                 || cs->singlestep_enabled
                 || dc.ex_value)) {
-            status = EXIT_PC_STALE;
+            status = DISAS_TOO_MANY;
         }
-    } while (status == NO_EXIT);
+    } while (status == DISAS_NEXT);
 
     if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
     switch (status) {
-    case EXIT_GOTO_TB:
-    case EXIT_NORETURN:
+    case DISAS_GOTO_TB:
+    case DISAS_NORETURN:
         break;
-    case EXIT_PC_STALE:
-    case EXIT_PC_STALE_NOCHAIN:
+    case DISAS_TOO_MANY:
+    case DISAS_PC_STALE:
+    case DISAS_PC_STALE_NOCHAIN:
         update_psw_addr(&dc);
         /* FALLTHRU */
-    case EXIT_PC_UPDATED:
+    case DISAS_PC_UPDATED:
         /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
            cc op type is in env */
         update_cc_op(&dc);
         /* FALLTHRU */
-    case EXIT_PC_CC_UPDATED:
+    case DISAS_PC_CC_UPDATED:
         /* Exit the TB, either by raising a debug exception or by return.  */
         if (do_debug) {
             gen_exception(EXCP_DEBUG);
-        } else if (use_exit_tb(&dc) || status == EXIT_PC_STALE_NOCHAIN) {
+        } else if (use_exit_tb(&dc) || status == DISAS_PC_STALE_NOCHAIN) {
             tcg_gen_exit_tb(0);
         } else {
             tcg_gen_lookup_and_goto_ptr();
-- 
2.17.0
