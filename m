Received: from eggs.gnu.org ([209.51.188.92]:49744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8v-0003NE-JO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-00054Q-8O
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:02 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:42951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ03-0004zU-Ar
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:00:59 -0500
Received: by mail-lf1-x142.google.com with SMTP id l10so5777253lfh.9
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:00:54 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:53 -0800
Message-Id: <20190214230000.24894-7-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 06/13] target/xtensa: add generic instruction
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
 target/xtensa/cpu.h       |  8 ++++++++
 target/xtensa/translate.c | 33 +++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index c59f79e56326..a3bab9c5a254 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -368,9 +368,17 @@ enum {
 
     XTENSA_OP_DIVIDE_BY_ZERO = 0x100,
 
+    /* Postprocessing flags */
     XTENSA_OP_CHECK_INTERRUPTS = 0x200,
     XTENSA_OP_EXIT_TB_M1 = 0x400,
     XTENSA_OP_EXIT_TB_0 = 0x800,
+    XTENSA_OP_SYNC_REGISTER_WINDOW = 0x1000,
+
+    XTENSA_OP_POSTPROCESS =
+        XTENSA_OP_CHECK_INTERRUPTS |
+        XTENSA_OP_EXIT_TB_M1 |
+        XTENSA_OP_EXIT_TB_0 |
+        XTENSA_OP_SYNC_REGISTER_WINDOW,
 
     XTENSA_OP_NAME_ARRAY = 0x8000,
 
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 616ed8f57972..149fcd37f9a1 100644
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
@@ -846,6 +852,19 @@ static inline unsigned xtensa_op0_insn_len(DisasContext *dc, uint8_t op0)
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
 struct opcode_arg_info {
     uint32_t resource;
     int index;
@@ -1210,6 +1229,8 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         }
     }
 
+    dc->op_flags = op_flags;
+
     for (slot = 0; slot < slots; ++slot) {
         struct slot_prop *pslot = ordered[slot];
         XtensaOpcodeOps *ops = pslot->ops;
@@ -1219,21 +1240,17 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
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
