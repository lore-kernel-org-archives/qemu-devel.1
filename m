Received: from eggs.gnu.org ([2001:4830:134:3::10]:38417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQHhl-000348-OV
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQHhk-0003uh-7O
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:29 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cQHhk-0003uV-2D
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:28 -0500
Received: by mail-pf0-x241.google.com with SMTP id 127so23021165pfg.0
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 09:56:27 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  8 Jan 2017 09:56:16 -0800
Message-Id: <20170108175620.6605-8-rth@twiddle.net>
In-Reply-To: <20170108175620.6605-1-rth@twiddle.net>
References: <20170108175620.6605-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 07/11] tcg-mips: Adjust prologue for mips64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jin Guojie <jinguojie@loongson.cn>

From: Jin Guojie <jinguojie@loongson.cn>

Take stack frame parameters out from the function body.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
Message-Id: <1483592275-4496-8-git-send-email-jinguojie@loongson.cn>
---
 tcg/mips/tcg-target.inc.c | 54 ++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 5cc8df3..9e24662 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -734,16 +734,6 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
-static inline void tcg_out_addi(TCGContext *s, TCGReg reg, TCGArg val)
-{
-    if (val == (int16_t)val) {
-        tcg_out_opc_imm(s, OPC_ADDIU, reg, reg, val);
-    } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, val);
-        tcg_out_opc_reg(s, OPC_ADDU, reg, reg, TCG_TMP0);
-    }
-}
-
 static void tcg_out_addsub2(TCGContext *s, TCGReg rl, TCGReg rh, TCGReg al,
                             TCGReg ah, TCGArg bl, TCGArg bh, bool cbl,
                             bool cbh, bool is_sub)
@@ -2270,42 +2260,48 @@ static tcg_insn_unit *align_code_ptr(TCGContext *s)
     return s->code_ptr;
 }
 
+/* Stack frame parameters.  */
+#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
+#define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
+
+#define FRAME_SIZE ((TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE + SAVE_SIZE \
+                     + TCG_TARGET_STACK_ALIGN - 1) \
+                    & -TCG_TARGET_STACK_ALIGN)
+#define SAVE_OFS   (TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE)
+
+/* We're expecting to be able to use an immediate for frame allocation.  */
+QEMU_BUILD_BUG_ON(FRAME_SIZE > 0x7fff);
+
 /* Generate global QEMU prologue and epilogue code */
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
-    int i, frame_size;
+    int i;
 
-    /* reserve some stack space, also for TCG temps. */
-    frame_size = ARRAY_SIZE(tcg_target_callee_save_regs) * 4
-                 + TCG_STATIC_CALL_ARGS_SIZE
-                 + CPU_TEMP_BUF_NLONGS * sizeof(long);
-    frame_size = (frame_size + TCG_TARGET_STACK_ALIGN - 1) &
-                 ~(TCG_TARGET_STACK_ALIGN - 1);
-    tcg_set_frame(s, TCG_REG_SP, ARRAY_SIZE(tcg_target_callee_save_regs) * 4
-                  + TCG_STATIC_CALL_ARGS_SIZE,
-                  CPU_TEMP_BUF_NLONGS * sizeof(long));
+    tcg_set_frame(s, TCG_REG_SP, TCG_STATIC_CALL_ARGS_SIZE, TEMP_SIZE);
 
     /* TB prologue */
-    tcg_out_addi(s, TCG_REG_SP, -frame_size);
-    for(i = 0 ; i < ARRAY_SIZE(tcg_target_callee_save_regs) ; i++) {
-        tcg_out_st(s, TCG_TYPE_I32, tcg_target_callee_save_regs[i],
-                   TCG_REG_SP, TCG_STATIC_CALL_ARGS_SIZE + i * 4);
+    tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_SP, TCG_REG_SP, -FRAME_SIZE);
+    for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
+        tcg_out_st(s, TCG_TYPE_REG, tcg_target_callee_save_regs[i],
+                   TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
     /* Call generated code */
     tcg_out_opc_reg(s, OPC_JR, 0, tcg_target_call_iarg_regs[1], 0);
+    /* delay slot */
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
-    tb_ret_addr = s->code_ptr;
 
     /* TB epilogue */
-    for(i = 0 ; i < ARRAY_SIZE(tcg_target_callee_save_regs) ; i++) {
-        tcg_out_ld(s, TCG_TYPE_I32, tcg_target_callee_save_regs[i],
-                   TCG_REG_SP, TCG_STATIC_CALL_ARGS_SIZE + i * 4);
+    tb_ret_addr = s->code_ptr;
+    for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
+        tcg_out_ld(s, TCG_TYPE_REG, tcg_target_callee_save_regs[i],
+                   TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
     tcg_out_opc_reg(s, OPC_JR, 0, TCG_REG_RA, 0);
     /* delay slot */
-    tcg_out_addi(s, TCG_REG_SP, frame_size);
+    tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_SP, TCG_REG_SP, FRAME_SIZE);
 
     if (use_mips32r2_instructions) {
         return;
-- 
2.9.3
