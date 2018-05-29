Received: from eggs.gnu.org ([2001:4830:134:3::10]:36951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDC-0001WB-Uh
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDB-0003zz-L4
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:42 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDA-0003yh-VF
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:41 -0400
Received: by mail-wm0-x243.google.com with SMTP id a67-v6so39049824wmf.3
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:40 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:49 +0200
Message-Id: <20180529105011.1914-17-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v1 16/38] target-microblaze: Break out
 trap_illegal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Break out trap_illegal() to handle illegal operation traps.
We now generally stop translation of the current insn if
it's not valid.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 75 ++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index ffdb36cf94..d63226db8f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -179,6 +179,20 @@ static void write_carryi(DisasContext *dc, bool carry)
     tcg_temp_free_i32(t0);
 }
 
+/*
+ * Returns true if the insn an illegal operation.
+ * If exceptions are enabled, an exception is raised.
+ */
+static bool trap_illegal(DisasContext *dc, bool cond)
+{
+    if (cond && (dc->tb_flags & MSR_EE_FLAG)
+        && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
+        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
+        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+    }
+    return cond;
+}
+
 /*
  * Returns true if the insn is illegal in userspace.
  * If exceptions are enabled, an exception is raised.
@@ -344,11 +358,8 @@ static void dec_pattern(DisasContext *dc)
 {
     unsigned int mode;
 
-    if ((dc->tb_flags & MSR_EE_FLAG)
-          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-          && !dc->cpu->cfg.use_pcmp_instr) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+    if (trap_illegal(dc, !dc->cpu->cfg.use_pcmp_instr)) {
+        return;
     }
 
     mode = dc->opcode & 3;
@@ -602,11 +613,7 @@ static void dec_mul(DisasContext *dc)
     TCGv_i32 tmp;
     unsigned int subcode;
 
-    if ((dc->tb_flags & MSR_EE_FLAG)
-         && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-         && !dc->cpu->cfg.use_hw_mul) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+    if (trap_illegal(dc, !dc->cpu->cfg.use_hw_mul)) {
         return;
     }
 
@@ -658,10 +665,8 @@ static void dec_div(DisasContext *dc)
     u = dc->imm & 2; 
     LOG_DIS("div\n");
 
-    if ((dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-          && !dc->cpu->cfg.use_div) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+    if (trap_illegal(dc, !dc->cpu->cfg.use_div)) {
+        return;
     }
 
     if (u)
@@ -680,11 +685,7 @@ static void dec_barrel(DisasContext *dc)
     unsigned int imm_w, imm_s;
     bool s, t, e = false, i = false;
 
-    if ((dc->tb_flags & MSR_EE_FLAG)
-          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-          && !dc->cpu->cfg.use_barrel) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+    if (trap_illegal(dc, !dc->cpu->cfg.use_barrel)) {
         return;
     }
 
@@ -798,11 +799,8 @@ static void dec_bit(DisasContext *dc)
             trap_userspace(dc, true);
             break;
         case 0xe0:
-            if ((dc->tb_flags & MSR_EE_FLAG)
-                && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-                && !dc->cpu->cfg.use_pcmp_instr) {
-                tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
-                t_gen_raise_exception(dc, EXCP_HW_EXCP);
+            if (trap_illegal(dc, !dc->cpu->cfg.use_pcmp_instr)) {
+                return;
             }
             if (dc->cpu->cfg.use_pcmp_instr) {
                 tcg_gen_clzi_i32(cpu_R[dc->rd], cpu_R[dc->ra], 32);
@@ -921,10 +919,7 @@ static void dec_load(DisasContext *dc)
         mop ^= MO_BSWAP;
     }
 
-    if (size > 4 && (dc->tb_flags & MSR_EE_FLAG)
-          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+    if (trap_illegal(dc, size > 4)) {
         return;
     }
 
@@ -1031,10 +1026,7 @@ static void dec_store(DisasContext *dc)
         mop ^= MO_BSWAP;
     }
 
-    if (size > 4 && (dc->tb_flags & MSR_EE_FLAG)
-          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+    if (trap_illegal(dc, size > 4)) {
         return;
     }
 
@@ -1368,11 +1360,7 @@ static void dec_fpu(DisasContext *dc)
 {
     unsigned int fpu_insn;
 
-    if ((dc->tb_flags & MSR_EE_FLAG)
-          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-          && !dc->cpu->cfg.use_fpu) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+    if (trap_illegal(dc, !dc->cpu->cfg.use_fpu)) {
         return;
     }
 
@@ -1471,10 +1459,7 @@ static void dec_fpu(DisasContext *dc)
 
 static void dec_null(DisasContext *dc)
 {
-    if ((dc->tb_flags & MSR_EE_FLAG)
-          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
-        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+    if (trap_illegal(dc, true)) {
         return;
     }
     qemu_log_mask(LOG_GUEST_ERROR, "unknown insn pc=%x opc=%x\n", dc->pc, dc->opcode);
@@ -1552,13 +1537,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
     if (dc->ir)
         dc->nr_nops = 0;
     else {
-        if ((dc->tb_flags & MSR_EE_FLAG)
-              && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-              && (dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK)) {
-            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
-            t_gen_raise_exception(dc, EXCP_HW_EXCP);
-            return;
-        }
+        trap_illegal(dc, dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK);
 
         LOG_DIS("nr_nops=%d\t", dc->nr_nops);
         dc->nr_nops++;
-- 
2.14.1
