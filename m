Received: from eggs.gnu.org ([209.51.188.92]:56187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gozhO-0002Cu-L0
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gozhN-0006vf-Qc
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:55:18 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gozhN-0006vN-Jp
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:55:17 -0500
Received: by mail-lf1-x141.google.com with SMTP id y11so958523lfj.4
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 15:55:17 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 30 Jan 2019 15:54:41 -0800
Message-Id: <20190130235442.2876-3-jcmvbkbc@gmail.com>
In-Reply-To: <20190130235442.2876-1-jcmvbkbc@gmail.com>
References: <20190130235442.2876-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] target/xtensa: add generic instruction
 post-processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Some opcodes may need additional actions at every exit from the
translated instruction or may need to amend TB exit slots available to
jumps generated for the instruction. Add gen_postprocess function and
call it from the gen_jump_slot and from the disas_xtensa_insn.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  4 ++++
 target/xtensa/translate.c | 33 +++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index b665bfc0068a..e1002c626954 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -368,9 +368,13 @@ enum {
 
     XTENSA_OP_DIVIDE_BY_ZERO = 0x100,
 
+    /* Postprocessing flags */
     XTENSA_OP_CHECK_INTERRUPTS = 0x200,
     XTENSA_OP_EXIT_TB_M1 = 0x400,
     XTENSA_OP_EXIT_TB_0 = 0x800,
+    XTENSA_OP_SYNC_REGISTER_WINDOW = 0x1000,
+
+    XTENSA_OP_POSTPROCESS = 0x1e00,
 };
 
 typedef struct XtensaOpcodeOps {
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index b3718d33eec8..f5f5bcfb179a 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -71,6 +71,7 @@ struct DisasContext {
 
     unsigned cpenable;
 
+    uint32_t op_flags;
     uint32_t *raw_arg;
     xtensa_insnbuf insnbuf;
     xtensa_insnbuf slotbuf;
@@ -363,6 +364,8 @@ static bool gen_check_cpenable(DisasContext *dc, uint32_t cp_mask)
     return true;
 }
 
+static int gen_postprocess(DisasContext *dc, int slot);
+
 static void gen_jump_slot(DisasContext *dc, TCGv dest, int slot)
 {
     tcg_gen_mov_i32(cpu_pc, dest);
@@ -372,6 +375,9 @@ static void gen_jump_slot(DisasContext *dc, TCGv dest, int slot)
     if (dc->base.singlestep_enabled) {
         gen_exception(dc, EXCP_DEBUG);
     } else {
+        if (dc->op_flags & XTENSA_OP_POSTPROCESS) {
+            slot = gen_postprocess(dc, slot);
+        }
         if (slot >= 0) {
             tcg_gen_goto_tb(slot);
             tcg_gen_exit_tb(dc->base.tb, slot);
@@ -855,6 +861,19 @@ static inline unsigned xtensa_op0_insn_len(DisasContext *dc, uint8_t op0)
     return xtensa_isa_length_from_chars(dc->config->isa, &op0);
 }
 
+static int gen_postprocess(DisasContext *dc, int slot)
+{
+    uint32_t op_flags = dc->op_flags;
+
+    if (op_flags & XTENSA_OP_CHECK_INTERRUPTS) {
+        gen_check_interrupts(dc);
+    }
+    if (op_flags & XTENSA_OP_EXIT_TB_M1) {
+        slot = -1;
+    }
+    return slot;
+}
+
 struct slot_prop {
     XtensaOpcodeOps *ops;
     uint32_t arg[MAX_OPCODE_ARGS];
@@ -1195,6 +1214,8 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         }
     }
 
+    dc->op_flags = op_flags;
+
     for (slot = 0; slot < slots; ++slot) {
         struct slot_prop *pslot = ordered[slot];
         XtensaOpcodeOps *ops = pslot->ops;
@@ -1204,21 +1225,17 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     }
 
     if (dc->base.is_jmp == DISAS_NEXT) {
-        if (op_flags & XTENSA_OP_CHECK_INTERRUPTS) {
-            gen_check_interrupts(dc);
-        }
-
+        gen_postprocess(dc, 0);
+        dc->op_flags = 0;
         if (op_flags & XTENSA_OP_EXIT_TB_M1) {
             /* Change in mmu index, memory mapping or tb->flags; exit tb */
             gen_jumpi_check_loop_end(dc, -1);
         } else if (op_flags & XTENSA_OP_EXIT_TB_0) {
             gen_jumpi_check_loop_end(dc, 0);
+        } else {
+            gen_check_loop_end(dc, 0);
         }
     }
-
-    if (dc->base.is_jmp == DISAS_NEXT) {
-        gen_check_loop_end(dc, 0);
-    }
     dc->pc = dc->base.pc_next;
 }
 
-- 
2.11.0
