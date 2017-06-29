Received: from eggs.gnu.org ([2001:4830:134:3::10]:55815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQUFu-0006HM-GB
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQUFt-0005x3-LU
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:50 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:34577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dQUFt-0005wv-GF
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:49 -0400
Received: by mail-yb0-x244.google.com with SMTP id b189so3583710yba.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 00:52:49 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 29 Jun 2017 03:52:43 -0400
Message-Id: <20170629075243.26984-4-bobby.prani@gmail.com>
In-Reply-To: <20170629075243.26984-1-bobby.prani@gmail.com>
References: <20170629075243.26984-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/3] tcg/aarch64: Enable indirect jump path
 using LDR (literal)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

This patch enables the indirect jump path using an LDR (literal)
instruction. It will be interesting to test and see which performs
better among the two paths.

CC: Richard Henderson <rth@twiddle.net>
CC: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 tcg/aarch64/tcg-target.inc.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index b7670ecc90..5381c31b45 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -269,6 +269,8 @@ typedef enum {
     I3207_BLR       = 0xd63f0000,
     I3207_RET       = 0xd65f0000,
 
+    /* Load literal for loading the address at pc-relative offset */
+    I3305_LDR       = 0x58000000,
     /* Load/store register.  Described here as 3.3.12, but the helper
        that emits them can transform to 3.3.10 or 3.3.13.  */
     I3312_STRB      = 0x38000000 | LDST_ST << 22 | MO_8 << 30,
@@ -389,6 +391,11 @@ static inline uint32_t tcg_in32(TCGContext *s)
 #define tcg_out_insn(S, FMT, OP, ...) \
     glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
 
+static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn, int imm19, TCGReg rt)
+{
+    tcg_out32(s, insn | (imm19 & 0x7ffff) << 5 | rt);
+}
+
 static void tcg_out_insn_3201(TCGContext *s, AArch64Insn insn, TCGType ext,
                               TCGReg rt, int imm19)
 {
@@ -864,6 +871,8 @@ static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
     }
 }
 
+#ifdef USE_DIRECT_JUMP
+
 void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
 {
     tcg_insn_unit *code_ptr = (tcg_insn_unit *)jmp_addr;
@@ -881,6 +890,8 @@ void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
     flush_icache_range(jmp_addr, jmp_addr + 8);
 }
 
+#endif
+
 static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
 {
     if (!l->has_value) {
@@ -1392,21 +1403,24 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_goto_tb:
-#ifndef USE_DIRECT_JUMP
-#error "USE_DIRECT_JUMP required for aarch64"
-#endif
-        /* consistency for USE_DIRECT_JUMP */
-        tcg_debug_assert(s->tb_jmp_insn_offset != NULL);
-        /* Ensure that ADRP+ADD are 8-byte aligned so that an atomic
-           write can be used to patch the target address. */
-        if ((uintptr_t)s->code_ptr & 7) {
-            tcg_out32(s, NOP);
+        if (s->tb_jmp_insn_offset != NULL) {
+            /* USE_DIRECT_JUMP */
+            /* Ensure that ADRP+ADD are 8-byte aligned so that an atomic
+               write can be used to patch the target address. */
+            if ((uintptr_t)s->code_ptr & 7) {
+                tcg_out32(s, NOP);
+            }
+            s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
+            /* actual branch destination will be patched by
+               aarch64_tb_set_jmp_target later, beware of retranslation */
+            tcg_out_insn(s, 3406, ADRP, TCG_REG_TMP, 0);
+            tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_TMP, TCG_REG_TMP, 0);
+        } else {
+            /* !USE_DIRECT_JUMP */
+            tcg_debug_assert(s->tb_jmp_target_addr != NULL);
+            intptr_t offset = tcg_pcrel_diff(s, (s->tb_jmp_target_addr + a0)) >> 2;
+            tcg_out_insn(s, 3305, LDR, offset, TCG_REG_TMP);
         }
-        s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
-        /* actual branch destination will be patched by
-           aarch64_tb_set_jmp_target later, beware of retranslation */
-        tcg_out_insn(s, 3406, ADRP, TCG_REG_TMP, 0);
-        tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_TMP, TCG_REG_TMP, 0);
         tcg_out_callr(s, TCG_REG_TMP);
         s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
         break;
-- 
2.13.0
