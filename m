Received: from eggs.gnu.org ([2001:4830:134:3::10]:47229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLU-0002BV-7y
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLP-0007s5-U6
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:24 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:41417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzLP-0007qj-Gk
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:19 -0400
Received: by mail-pl0-x244.google.com with SMTP id w8-v6so8015549ply.8
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:58:19 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Jul 2018 22:57:43 +0900
Message-Id: <20180702135806.7087-3-shorne@gmail.com>
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
References: <20180702135806.7087-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/25] target/openrisc: Add print_insn_or1k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

Rather than emit disassembly while translating, reuse the
generated decoder to build a separate disassembler.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/Makefile.objs |   3 +-
 target/openrisc/cpu.c         |   6 ++
 target/openrisc/cpu.h         |   1 +
 target/openrisc/disas.c       | 170 ++++++++++++++++++++++++++++++++++
 target/openrisc/translate.c   | 114 -----------------------
 5 files changed, 179 insertions(+), 115 deletions(-)
 create mode 100644 target/openrisc/disas.c

diff --git a/target/openrisc/Makefile.objs b/target/openrisc/Makefile.objs
index 1b98a911ea..8b8a890c59 100644
--- a/target/openrisc/Makefile.objs
+++ b/target/openrisc/Makefile.objs
@@ -1,5 +1,5 @@
 obj-$(CONFIG_SOFTMMU) += machine.o
-obj-y += cpu.o exception.o interrupt.o mmu.o translate.o
+obj-y += cpu.o exception.o interrupt.o mmu.o translate.o disas.o
 obj-y += exception_helper.o fpu_helper.o \
          interrupt_helper.o mmu_helper.o sys_helper.o
 obj-y += gdbstub.o
@@ -12,3 +12,4 @@ target/openrisc/decode.inc.c: \
 	  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
 
 target/openrisc/translate.o: target/openrisc/decode.inc.c
+target/openrisc/disas.o: target/openrisc/decode.inc.c
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index a692a98ec0..fa8e342ff7 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -35,6 +35,11 @@ static bool openrisc_cpu_has_work(CPUState *cs)
                                     CPU_INTERRUPT_TIMER);
 }
 
+static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
+{
+    info->print_insn = print_insn_or1k;
+}
+
 /* CPUClass::reset() */
 static void openrisc_cpu_reset(CPUState *s)
 {
@@ -152,6 +157,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
 #endif
     cc->gdb_num_core_regs = 32 + 3;
     cc->tcg_initialize = openrisc_translate_init;
+    cc->disas_set_info = openrisc_disas_set_info;
 }
 
 /* Sort alphabetically by type name, except for "any". */
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 35cab65f11..c871d6bfe1 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -358,6 +358,7 @@ void openrisc_translate_init(void);
 int openrisc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
                                   int rw, int mmu_idx);
 int cpu_openrisc_signal_handler(int host_signum, void *pinfo, void *puc);
+int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 
 #define cpu_list cpu_openrisc_list
 #define cpu_signal_handler cpu_openrisc_signal_handler
diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
new file mode 100644
index 0000000000..8ee88ec125
--- /dev/null
+++ b/target/openrisc/disas.c
@@ -0,0 +1,170 @@
+/*
+ * OpenRISC disassembler
+ *
+ * Copyright (c) 2018 Richard Henderson <rth@twiddle.net>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "disas/bfd.h"
+#include "qemu/bitops.h"
+#include "cpu.h"
+
+typedef disassemble_info DisasContext;
+
+/* Include the auto-generated decoder.  */
+#include "decode.inc.c"
+
+#define output(mnemonic, format, ...) \
+    (info->fprintf_func(info->stream, "%-9s " format, \
+                        mnemonic, ##__VA_ARGS__))
+
+int print_insn_or1k(bfd_vma addr, disassemble_info *info)
+{
+    bfd_byte buffer[4];
+    uint32_t insn;
+    int status;
+
+    status = info->read_memory_func(addr, buffer, 4, info);
+    if (status != 0) {
+        info->memory_error_func(status, addr, info);
+        return -1;
+    }
+    insn = bfd_getb32(buffer);
+
+    if (!decode(info, insn)) {
+        output(".long", "%#08x", insn);
+    }
+    return 4;
+}
+
+#define INSN(opcode, format, ...) \
+static bool trans_l_##opcode(disassemble_info *info,    \
+    arg_l_##opcode * a, uint32_t insn)                  \
+{                                                       \
+    output("l." #opcode, format, ##__VA_ARGS__);        \
+    return true;                                        \
+}
+
+INSN(add,    "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(addc,   "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(sub,    "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(and,    "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(or,     "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(xor,    "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(sll,    "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(srl,    "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(sra,    "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(ror,    "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(exths,  "r%d, r%d", a->d, a->a)
+INSN(extbs,  "r%d, r%d", a->d, a->a)
+INSN(exthz,  "r%d, r%d", a->d, a->a)
+INSN(extbz,  "r%d, r%d", a->d, a->a)
+INSN(cmov,   "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(ff1,    "r%d, r%d", a->d, a->a)
+INSN(fl1,    "r%d, r%d", a->d, a->a)
+INSN(mul,    "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(mulu,   "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(div,    "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(divu,   "r%d, r%d, r%d", a->d, a->a, a->b)
+INSN(muld,   "r%d, r%d", a->a, a->b)
+INSN(muldu,  "r%d, r%d", a->a, a->b)
+INSN(j,      "%d", a->n)
+INSN(jal,    "%d", a->n)
+INSN(bf,     "%d", a->n)
+INSN(bnf,    "%d", a->n)
+INSN(jr,     "r%d", a->b)
+INSN(jalr,   "r%d", a->b)
+INSN(lwa,    "r%d, %d(r%d)", a->d, a->i, a->a)
+INSN(lwz,    "r%d, %d(r%d)", a->d, a->i, a->a)
+INSN(lws,    "r%d, %d(r%d)", a->d, a->i, a->a)
+INSN(lbz,    "r%d, %d(r%d)", a->d, a->i, a->a)
+INSN(lbs,    "r%d, %d(r%d)", a->d, a->i, a->a)
+INSN(lhz,    "r%d, %d(r%d)", a->d, a->i, a->a)
+INSN(lhs,    "r%d, %d(r%d)", a->d, a->i, a->a)
+INSN(swa,    "%d(r%d), r%d", a->i, a->a, a->b)
+INSN(sw,     "%d(r%d), r%d", a->i, a->a, a->b)
+INSN(sb,     "%d(r%d), r%d", a->i, a->a, a->b)
+INSN(sh,     "%d(r%d), r%d", a->i, a->a, a->b)
+INSN(nop,    "")
+INSN(addi,   "r%d, r%d, %d", a->d, a->a, a->i)
+INSN(addic,  "r%d, r%d, %d", a->d, a->a, a->i)
+INSN(muli,   "r%d, r%d, %d", a->d, a->a, a->i)
+INSN(maci,   "r%d, %d", a->a, a->i)
+INSN(andi,   "r%d, r%d, %d", a->d, a->a, a->k)
+INSN(ori,    "r%d, r%d, %d", a->d, a->a, a->k)
+INSN(xori,   "r%d, r%d, %d", a->d, a->a, a->i)
+INSN(mfspr,  "r%d, r%d, %d", a->d, a->a, a->k)
+INSN(mtspr,  "r%d, r%d, %d", a->a, a->b, a->k)
+INSN(mac,    "r%d, r%d", a->a, a->b)
+INSN(msb,    "r%d, r%d", a->a, a->b)
+INSN(macu,   "r%d, r%d", a->a, a->b)
+INSN(msbu,   "r%d, r%d", a->a, a->b)
+INSN(slli,   "r%d, r%d, %d", a->d, a->a, a->l)
+INSN(srli,   "r%d, r%d, %d", a->d, a->a, a->l)
+INSN(srai,   "r%d, r%d, %d", a->d, a->a, a->l)
+INSN(rori,   "r%d, r%d, %d", a->d, a->a, a->l)
+INSN(movhi,  "r%d, %d", a->d, a->k)
+INSN(macrc,  "r%d", a->d)
+INSN(sfeq,   "r%d, r%d", a->a, a->b)
+INSN(sfne,   "r%d, r%d", a->a, a->b)
+INSN(sfgtu,  "r%d, r%d", a->a, a->b)
+INSN(sfgeu,  "r%d, r%d", a->a, a->b)
+INSN(sfltu,  "r%d, r%d", a->a, a->b)
+INSN(sfleu,  "r%d, r%d", a->a, a->b)
+INSN(sfgts,  "r%d, r%d", a->a, a->b)
+INSN(sfges,  "r%d, r%d", a->a, a->b)
+INSN(sflts,  "r%d, r%d", a->a, a->b)
+INSN(sfles,  "r%d, r%d", a->a, a->b)
+INSN(sfeqi,  "r%d, %d", a->a, a->i)
+INSN(sfnei,  "r%d, %d", a->a, a->i)
+INSN(sfgtui, "r%d, %d", a->a, a->i)
+INSN(sfgeui, "r%d, %d", a->a, a->i)
+INSN(sfltui, "r%d, %d", a->a, a->i)
+INSN(sfleui, "r%d, %d", a->a, a->i)
+INSN(sfgtsi, "r%d, %d", a->a, a->i)
+INSN(sfgesi, "r%d, %d", a->a, a->i)
+INSN(sfltsi, "r%d, %d", a->a, a->i)
+INSN(sflesi, "r%d, %d", a->a, a->i)
+INSN(sys,    "%d", a->k)
+INSN(trap,   "%d", a->k)
+INSN(msync,  "")
+INSN(psync,  "")
+INSN(csync,  "")
+INSN(rfe,    "")
+
+#define FP_INSN(opcode, suffix, format, ...) \
+static bool trans_lf_##opcode##_##suffix(disassemble_info *info, \
+    arg_lf_##opcode##_##suffix * a, uint32_t insn)                \
+{                                                                \
+    output("lf." #opcode "." #suffix, format, ##__VA_ARGS__);    \
+    return true;                                                 \
+}
+
+FP_INSN(add, s,  "r%d, r%d, r%d", a->d, a->a, a->b)
+FP_INSN(sub, s,  "r%d, r%d, r%d", a->d, a->a, a->b)
+FP_INSN(mul, s,  "r%d, r%d, r%d", a->d, a->a, a->b)
+FP_INSN(div, s,  "r%d, r%d, r%d", a->d, a->a, a->b)
+FP_INSN(rem, s,  "r%d, r%d, r%d", a->d, a->a, a->b)
+FP_INSN(itof, s, "r%d, r%d", a->d, a->a)
+FP_INSN(ftoi, s, "r%d, r%d", a->d, a->a)
+FP_INSN(madd, s, "r%d, r%d, r%d", a->d, a->a, a->b)
+FP_INSN(sfeq, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sfne, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sfgt, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sfge, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sflt, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sfle, s, "r%d, r%d", a->a, a->b)
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index d69f8d0422..fbdc2058dc 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -36,10 +36,6 @@
 #include "trace-tcg.h"
 #include "exec/log.h"
 
-#define LOG_DIS(str, ...) \
-    qemu_log_mask(CPU_LOG_TB_IN_ASM, "%08x: " str, dc->base.pc_next,    \
-                  ## __VA_ARGS__)
-
 /* is_jmp field values */
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
@@ -457,7 +453,6 @@ static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
 
 static bool trans_l_add(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.add r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     gen_add(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -465,7 +460,6 @@ static bool trans_l_add(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_addc(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.addc r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     gen_addc(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -473,7 +467,6 @@ static bool trans_l_addc(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_sub(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.sub r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     gen_sub(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -481,7 +474,6 @@ static bool trans_l_sub(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_and(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.and r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     tcg_gen_and_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -489,7 +481,6 @@ static bool trans_l_and(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_or(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.or r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     tcg_gen_or_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -497,7 +488,6 @@ static bool trans_l_or(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_xor(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.xor r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     tcg_gen_xor_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -505,7 +495,6 @@ static bool trans_l_xor(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_sll(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.sll r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     tcg_gen_shl_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -513,7 +502,6 @@ static bool trans_l_sll(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_srl(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.srl r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     tcg_gen_shr_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -521,7 +509,6 @@ static bool trans_l_srl(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_sra(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.sra r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     tcg_gen_sar_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -529,7 +516,6 @@ static bool trans_l_sra(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_ror(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.ror r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     tcg_gen_rotr_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -537,7 +523,6 @@ static bool trans_l_ror(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_exths(DisasContext *dc, arg_da *a, uint32_t insn)
 {
-    LOG_DIS("l.exths r%d, r%d\n", a->d, a->a);
     check_r0_write(a->d);
     tcg_gen_ext16s_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
@@ -545,7 +530,6 @@ static bool trans_l_exths(DisasContext *dc, arg_da *a, uint32_t insn)
 
 static bool trans_l_extbs(DisasContext *dc, arg_da *a, uint32_t insn)
 {
-    LOG_DIS("l.extbs r%d, r%d\n", a->d, a->a);
     check_r0_write(a->d);
     tcg_gen_ext8s_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
@@ -553,7 +537,6 @@ static bool trans_l_extbs(DisasContext *dc, arg_da *a, uint32_t insn)
 
 static bool trans_l_exthz(DisasContext *dc, arg_da *a, uint32_t insn)
 {
-    LOG_DIS("l.exthz r%d, r%d\n", a->d, a->a);
     check_r0_write(a->d);
     tcg_gen_ext16u_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
@@ -561,7 +544,6 @@ static bool trans_l_exthz(DisasContext *dc, arg_da *a, uint32_t insn)
 
 static bool trans_l_extbz(DisasContext *dc, arg_da *a, uint32_t insn)
 {
-    LOG_DIS("l.extbz r%d, r%d\n", a->d, a->a);
     check_r0_write(a->d);
     tcg_gen_ext8u_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
@@ -570,7 +552,6 @@ static bool trans_l_extbz(DisasContext *dc, arg_da *a, uint32_t insn)
 static bool trans_l_cmov(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
     TCGv zero;
-    LOG_DIS("l.cmov r%d, r%d, r%d\n", a->d, a->a, a->b);
 
     check_r0_write(a->d);
     zero = tcg_const_tl(0);
@@ -582,8 +563,6 @@ static bool trans_l_cmov(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_ff1(DisasContext *dc, arg_da *a, uint32_t insn)
 {
-    LOG_DIS("l.ff1 r%d, r%d\n", a->d, a->a);
-
     check_r0_write(a->d);
     tcg_gen_ctzi_tl(cpu_R[a->d], cpu_R[a->a], -1);
     tcg_gen_addi_tl(cpu_R[a->d], cpu_R[a->d], 1);
@@ -592,8 +571,6 @@ static bool trans_l_ff1(DisasContext *dc, arg_da *a, uint32_t insn)
 
 static bool trans_l_fl1(DisasContext *dc, arg_da *a, uint32_t insn)
 {
-    LOG_DIS("l.fl1 r%d, r%d\n", a->d, a->a);
-
     check_r0_write(a->d);
     tcg_gen_clzi_tl(cpu_R[a->d], cpu_R[a->a], TARGET_LONG_BITS);
     tcg_gen_subfi_tl(cpu_R[a->d], TARGET_LONG_BITS, cpu_R[a->d]);
@@ -602,8 +579,6 @@ static bool trans_l_fl1(DisasContext *dc, arg_da *a, uint32_t insn)
 
 static bool trans_l_mul(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.mul r%d, r%d, r%d\n", a->d, a->a, a->b);
-
     check_r0_write(a->d);
     gen_mul(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -611,8 +586,6 @@ static bool trans_l_mul(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_mulu(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.mulu r%d, r%d, r%d\n", a->d, a->a, a->b);
-
     check_r0_write(a->d);
     gen_mulu(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -620,8 +593,6 @@ static bool trans_l_mulu(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_div(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.div r%d, r%d, r%d\n", a->d, a->a, a->b);
-
     check_r0_write(a->d);
     gen_div(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -629,8 +600,6 @@ static bool trans_l_div(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_divu(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("l.divu r%d, r%d, r%d\n", a->d, a->a, a->b);
-
     check_r0_write(a->d);
     gen_divu(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
@@ -638,14 +607,12 @@ static bool trans_l_divu(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_l_muld(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("l.muld r%d, r%d\n", a->a, a->b);
     gen_muld(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_muldu(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("l.muldu r%d, r%d\n", a->a, a->b);
     gen_muldu(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
@@ -654,7 +621,6 @@ static bool trans_l_j(DisasContext *dc, arg_l_j *a, uint32_t insn)
 {
     target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
 
-    LOG_DIS("l.j %d\n", a->n);
     tcg_gen_movi_tl(jmp_pc, tmp_pc);
     dc->delayed_branch = 2;
     return true;
@@ -665,7 +631,6 @@ static bool trans_l_jal(DisasContext *dc, arg_l_jal *a, uint32_t insn)
     target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
     target_ulong ret_pc = dc->base.pc_next + 8;
 
-    LOG_DIS("l.jal %d\n", a->n);
     tcg_gen_movi_tl(cpu_R[9], ret_pc);
     /* Optimize jal being used to load the PC for PIC.  */
     if (tmp_pc != ret_pc) {
@@ -692,21 +657,18 @@ static void do_bf(DisasContext *dc, arg_l_bf *a, TCGCond cond)
 
 static bool trans_l_bf(DisasContext *dc, arg_l_bf *a, uint32_t insn)
 {
-    LOG_DIS("l.bf %d\n", a->n);
     do_bf(dc, a, TCG_COND_NE);
     return true;
 }
 
 static bool trans_l_bnf(DisasContext *dc, arg_l_bf *a, uint32_t insn)
 {
-    LOG_DIS("l.bnf %d\n", a->n);
     do_bf(dc, a, TCG_COND_EQ);
     return true;
 }
 
 static bool trans_l_jr(DisasContext *dc, arg_l_jr *a, uint32_t insn)
 {
-    LOG_DIS("l.jr r%d\n", a->b);
     tcg_gen_mov_tl(jmp_pc, cpu_R[a->b]);
     dc->delayed_branch = 2;
     return true;
@@ -714,7 +676,6 @@ static bool trans_l_jr(DisasContext *dc, arg_l_jr *a, uint32_t insn)
 
 static bool trans_l_jalr(DisasContext *dc, arg_l_jalr *a, uint32_t insn)
 {
-    LOG_DIS("l.jalr r%d\n", a->b);
     tcg_gen_mov_tl(jmp_pc, cpu_R[a->b]);
     tcg_gen_movi_tl(cpu_R[9], dc->base.pc_next + 8);
     dc->delayed_branch = 2;
@@ -725,8 +686,6 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a, uint32_t insn)
 {
     TCGv ea;
 
-    LOG_DIS("l.lwa r%d, r%d, %d\n", a->d, a->a, a->i);
-
     check_r0_write(a->d);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R[a->a], a->i);
@@ -750,42 +709,36 @@ static void do_load(DisasContext *dc, arg_load *a, TCGMemOp mop)
 
 static bool trans_l_lwz(DisasContext *dc, arg_load *a, uint32_t insn)
 {
-    LOG_DIS("l.lwz r%d, r%d, %d\n", a->d, a->a, a->i);
     do_load(dc, a, MO_TEUL);
     return true;
 }
 
 static bool trans_l_lws(DisasContext *dc, arg_load *a, uint32_t insn)
 {
-    LOG_DIS("l.lws r%d, r%d, %d\n", a->d, a->a, a->i);
     do_load(dc, a, MO_TESL);
     return true;
 }
 
 static bool trans_l_lbz(DisasContext *dc, arg_load *a, uint32_t insn)
 {
-    LOG_DIS("l.lbz r%d, r%d, %d\n", a->d, a->a, a->i);
     do_load(dc, a, MO_UB);
     return true;
 }
 
 static bool trans_l_lbs(DisasContext *dc, arg_load *a, uint32_t insn)
 {
-    LOG_DIS("l.lbs r%d, r%d, %d\n", a->d, a->a, a->i);
     do_load(dc, a, MO_SB);
     return true;
 }
 
 static bool trans_l_lhz(DisasContext *dc, arg_load *a, uint32_t insn)
 {
-    LOG_DIS("l.lhz r%d, r%d, %d\n", a->d, a->a, a->i);
     do_load(dc, a, MO_TEUW);
     return true;
 }
 
 static bool trans_l_lhs(DisasContext *dc, arg_load *a, uint32_t insn)
 {
-    LOG_DIS("l.lhs r%d, r%d, %d\n", a->d, a->a, a->i);
     do_load(dc, a, MO_TESW);
     return true;
 }
@@ -795,8 +748,6 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a, uint32_t insn)
     TCGv ea, val;
     TCGLabel *lab_fail, *lab_done;
 
-    LOG_DIS("l.swa r%d, r%d, %d\n", a->a, a->b, a->i);
-
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R[a->a], a->i);
 
@@ -837,28 +788,24 @@ static void do_store(DisasContext *dc, arg_store *a, TCGMemOp mop)
 
 static bool trans_l_sw(DisasContext *dc, arg_store *a, uint32_t insn)
 {
-    LOG_DIS("l.sw r%d, r%d, %d\n", a->a, a->b, a->i);
     do_store(dc, a, MO_TEUL);
     return true;
 }
 
 static bool trans_l_sb(DisasContext *dc, arg_store *a, uint32_t insn)
 {
-    LOG_DIS("l.sb r%d, r%d, %d\n", a->a, a->b, a->i);
     do_store(dc, a, MO_UB);
     return true;
 }
 
 static bool trans_l_sh(DisasContext *dc, arg_store *a, uint32_t insn)
 {
-    LOG_DIS("l.sh r%d, r%d, %d\n", a->a, a->b, a->i);
     do_store(dc, a, MO_TEUW);
     return true;
 }
 
 static bool trans_l_nop(DisasContext *dc, arg_l_nop *a, uint32_t insn)
 {
-    LOG_DIS("l.nop %d\n", a->k);
     return true;
 }
 
@@ -866,7 +813,6 @@ static bool trans_l_addi(DisasContext *dc, arg_rri *a, uint32_t insn)
 {
     TCGv t0;
 
-    LOG_DIS("l.addi r%d, r%d, %d\n", a->d, a->a, a->i);
     check_r0_write(a->d);
     t0 = tcg_const_tl(a->i);
     gen_add(dc, cpu_R[a->d], cpu_R[a->a], t0);
@@ -878,7 +824,6 @@ static bool trans_l_addic(DisasContext *dc, arg_rri *a, uint32_t insn)
 {
     TCGv t0;
 
-    LOG_DIS("l.addic r%d, r%d, %d\n", a->d, a->a, a->i);
     check_r0_write(a->d);
     t0 = tcg_const_tl(a->i);
     gen_addc(dc, cpu_R[a->d], cpu_R[a->a], t0);
@@ -890,7 +835,6 @@ static bool trans_l_muli(DisasContext *dc, arg_rri *a, uint32_t insn)
 {
     TCGv t0;
 
-    LOG_DIS("l.muli r%d, r%d, %d\n", a->d, a->a, a->i);
     check_r0_write(a->d);
     t0 = tcg_const_tl(a->i);
     gen_mul(dc, cpu_R[a->d], cpu_R[a->a], t0);
@@ -902,7 +846,6 @@ static bool trans_l_maci(DisasContext *dc, arg_l_maci *a, uint32_t insn)
 {
     TCGv t0;
 
-    LOG_DIS("l.maci r%d, %d\n", a->a, a->i);
     t0 = tcg_const_tl(a->i);
     gen_mac(dc, cpu_R[a->a], t0);
     tcg_temp_free(t0);
@@ -911,7 +854,6 @@ static bool trans_l_maci(DisasContext *dc, arg_l_maci *a, uint32_t insn)
 
 static bool trans_l_andi(DisasContext *dc, arg_rrk *a, uint32_t insn)
 {
-    LOG_DIS("l.andi r%d, r%d, %d\n", a->d, a->a, a->k);
     check_r0_write(a->d);
     tcg_gen_andi_tl(cpu_R[a->d], cpu_R[a->a], a->k);
     return true;
@@ -919,7 +861,6 @@ static bool trans_l_andi(DisasContext *dc, arg_rrk *a, uint32_t insn)
 
 static bool trans_l_ori(DisasContext *dc, arg_rrk *a, uint32_t insn)
 {
-    LOG_DIS("l.ori r%d, r%d, %d\n", a->d, a->a, a->k);
     check_r0_write(a->d);
     tcg_gen_ori_tl(cpu_R[a->d], cpu_R[a->a], a->k);
     return true;
@@ -927,7 +868,6 @@ static bool trans_l_ori(DisasContext *dc, arg_rrk *a, uint32_t insn)
 
 static bool trans_l_xori(DisasContext *dc, arg_rri *a, uint32_t insn)
 {
-    LOG_DIS("l.xori r%d, r%d, %d\n", a->d, a->a, a->i);
     check_r0_write(a->d);
     tcg_gen_xori_tl(cpu_R[a->d], cpu_R[a->a], a->i);
     return true;
@@ -935,7 +875,6 @@ static bool trans_l_xori(DisasContext *dc, arg_rri *a, uint32_t insn)
 
 static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a, uint32_t insn)
 {
-    LOG_DIS("l.mfspr r%d, r%d, %d\n", a->d, a->a, a->k);
     check_r0_write(a->d);
 
 #ifdef CONFIG_USER_ONLY
@@ -954,8 +893,6 @@ static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a, uint32_t insn)
 
 static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
 {
-    LOG_DIS("l.mtspr r%d, r%d, %d\n", a->a, a->b, a->k);
-
 #ifdef CONFIG_USER_ONLY
     gen_illegal_exception(dc);
 #else
@@ -972,35 +909,30 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
 
 static bool trans_l_mac(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("l.mac r%d, r%d\n", a->a, a->b);
     gen_mac(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_msb(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("l.msb r%d, r%d\n", a->a, a->b);
     gen_msb(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_macu(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("l.mac r%d, r%d\n", a->a, a->b);
     gen_macu(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_msbu(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("l.msb r%d, r%d\n", a->a, a->b);
     gen_msbu(dc, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_slli(DisasContext *dc, arg_dal *a, uint32_t insn)
 {
-    LOG_DIS("l.slli r%d, r%d, %d\n", a->d, a->a, a->l);
     check_r0_write(a->d);
     tcg_gen_shli_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
@@ -1008,7 +940,6 @@ static bool trans_l_slli(DisasContext *dc, arg_dal *a, uint32_t insn)
 
 static bool trans_l_srli(DisasContext *dc, arg_dal *a, uint32_t insn)
 {
-    LOG_DIS("l.srli r%d, r%d, %d\n", a->d, a->a, a->l);
     check_r0_write(a->d);
     tcg_gen_shri_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
@@ -1016,7 +947,6 @@ static bool trans_l_srli(DisasContext *dc, arg_dal *a, uint32_t insn)
 
 static bool trans_l_srai(DisasContext *dc, arg_dal *a, uint32_t insn)
 {
-    LOG_DIS("l.srai r%d, r%d, %d\n", a->d, a->a, a->l);
     check_r0_write(a->d);
     tcg_gen_sari_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
@@ -1024,7 +954,6 @@ static bool trans_l_srai(DisasContext *dc, arg_dal *a, uint32_t insn)
 
 static bool trans_l_rori(DisasContext *dc, arg_dal *a, uint32_t insn)
 {
-    LOG_DIS("l.rori r%d, r%d, %d\n", a->d, a->a, a->l);
     check_r0_write(a->d);
     tcg_gen_rotri_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
@@ -1032,7 +961,6 @@ static bool trans_l_rori(DisasContext *dc, arg_dal *a, uint32_t insn)
 
 static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a, uint32_t insn)
 {
-    LOG_DIS("l.movhi r%d, %d\n", a->d, a->k);
     check_r0_write(a->d);
     tcg_gen_movi_tl(cpu_R[a->d], a->k << 16);
     return true;
@@ -1040,7 +968,6 @@ static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a, uint32_t insn)
 
 static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a, uint32_t insn)
 {
-    LOG_DIS("l.macrc r%d\n", a->d);
     check_r0_write(a->d);
     tcg_gen_trunc_i64_tl(cpu_R[a->d], cpu_mac);
     tcg_gen_movi_i64(cpu_mac, 0);
@@ -1049,147 +976,126 @@ static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a, uint32_t insn)
 
 static bool trans_l_sfeq(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    LOG_DIS("l.sfeq r%d, r%d\n", a->a, a->b);
     tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sfne(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    LOG_DIS("l.sfne r%d, r%d\n", a->a, a->b);
     tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sfgtu(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    LOG_DIS("l.sfgtu r%d, r%d\n", a->a, a->b);
     tcg_gen_setcond_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sfgeu(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    LOG_DIS("l.sfgeu r%d, r%d\n", a->a, a->b);
     tcg_gen_setcond_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sfltu(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    LOG_DIS("l.sfltu r%d, r%d\n", a->a, a->b);
     tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sfleu(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    LOG_DIS("l.sfleu r%d, r%d\n", a->a, a->b);
     tcg_gen_setcond_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sfgts(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    LOG_DIS("l.sfgts r%d, r%d\n", a->a, a->b);
     tcg_gen_setcond_tl(TCG_COND_GT, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sfges(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    LOG_DIS("l.sfges r%d, r%d\n", a->a, a->b);
     tcg_gen_setcond_tl(TCG_COND_GE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sflts(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    LOG_DIS("l.sflts r%d, r%d\n", a->a, a->b);
     tcg_gen_setcond_tl(TCG_COND_LT, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sfles(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    LOG_DIS("l.sfles r%d, r%d\n", a->a, a->b);
     tcg_gen_setcond_tl(TCG_COND_LE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sfeqi(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    LOG_DIS("l.sfeqi r%d, %d\n", a->a, a->i);
     tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_sfnei(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    LOG_DIS("l.sfnei r%d, %d\n", a->a, a->i);
     tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_sfgtui(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    LOG_DIS("l.sfgtui r%d, %d\n", a->a, a->i);
     tcg_gen_setcondi_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_sfgeui(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    LOG_DIS("l.sfgeui r%d, %d\n", a->a, a->i);
     tcg_gen_setcondi_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_sfltui(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    LOG_DIS("l.sfltui r%d, %d\n", a->a, a->i);
     tcg_gen_setcondi_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_sfleui(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    LOG_DIS("l.sfleui r%d, %d\n", a->a, a->i);
     tcg_gen_setcondi_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_sfgtsi(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    LOG_DIS("l.sfgtsi r%d, %d\n", a->a, a->i);
     tcg_gen_setcondi_tl(TCG_COND_GT, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_sfgesi(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    LOG_DIS("l.sfgesi r%d, %d\n", a->a, a->i);
     tcg_gen_setcondi_tl(TCG_COND_GE, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_sfltsi(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    LOG_DIS("l.sfltsi r%d, %d\n", a->a, a->i);
     tcg_gen_setcondi_tl(TCG_COND_LT, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_sflesi(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    LOG_DIS("l.sflesi r%d, %d\n", a->a, a->i);
     tcg_gen_setcondi_tl(TCG_COND_LE, cpu_sr_f, cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_sys(DisasContext *dc, arg_l_sys *a, uint32_t insn)
 {
-    LOG_DIS("l.sys %d\n", a->k);
     tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_SYSCALL);
     dc->base.is_jmp = DISAS_NORETURN;
@@ -1198,7 +1104,6 @@ static bool trans_l_sys(DisasContext *dc, arg_l_sys *a, uint32_t insn)
 
 static bool trans_l_trap(DisasContext *dc, arg_l_trap *a, uint32_t insn)
 {
-    LOG_DIS("l.trap %d\n", a->k);
     tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_TRAP);
     dc->base.is_jmp = DISAS_NORETURN;
@@ -1207,27 +1112,22 @@ static bool trans_l_trap(DisasContext *dc, arg_l_trap *a, uint32_t insn)
 
 static bool trans_l_msync(DisasContext *dc, arg_l_msync *a, uint32_t insn)
 {
-    LOG_DIS("l.msync\n");
     tcg_gen_mb(TCG_MO_ALL);
     return true;
 }
 
 static bool trans_l_psync(DisasContext *dc, arg_l_psync *a, uint32_t insn)
 {
-    LOG_DIS("l.psync\n");
     return true;
 }
 
 static bool trans_l_csync(DisasContext *dc, arg_l_csync *a, uint32_t insn)
 {
-    LOG_DIS("l.csync\n");
     return true;
 }
 
 static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a, uint32_t insn)
 {
-    LOG_DIS("l.rfe\n");
-
 #ifdef CONFIG_USER_ONLY
     gen_illegal_exception(dc);
 #else
@@ -1274,56 +1174,48 @@ static void do_fpcmp(DisasContext *dc, arg_ab *a,
 
 static bool trans_lf_add_s(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("lf.add.s r%d, r%d, r%d\n", a->d, a->a, a->b);
     do_fp3(dc, a, gen_helper_float_add_s);
     return true;
 }
 
 static bool trans_lf_sub_s(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("lf.sub.s r%d, r%d, r%d\n", a->d, a->a, a->b);
     do_fp3(dc, a, gen_helper_float_sub_s);
     return true;
 }
 
 static bool trans_lf_mul_s(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("lf.mul.s r%d, r%d, r%d\n", a->d, a->a, a->b);
     do_fp3(dc, a, gen_helper_float_mul_s);
     return true;
 }
 
 static bool trans_lf_div_s(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("lf.div.s r%d, r%d, r%d\n", a->d, a->a, a->b);
     do_fp3(dc, a, gen_helper_float_div_s);
     return true;
 }
 
 static bool trans_lf_rem_s(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("lf.rem.s r%d, r%d, r%d\n", a->d, a->a, a->b);
     do_fp3(dc, a, gen_helper_float_rem_s);
     return true;
 }
 
 static bool trans_lf_itof_s(DisasContext *dc, arg_da *a, uint32_t insn)
 {
-    LOG_DIS("lf.itof.s r%d, r%d\n", a->d, a->a);
     do_fp2(dc, a, gen_helper_itofs);
     return true;
 }
 
 static bool trans_lf_ftoi_s(DisasContext *dc, arg_da *a, uint32_t insn)
 {
-    LOG_DIS("lf.ftoi.s r%d, r%d\n", a->d, a->a);
     do_fp2(dc, a, gen_helper_ftois);
     return true;
 }
 
 static bool trans_lf_madd_s(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    LOG_DIS("lf.madd.s r%d, r%d, r%d\n", a->d, a->a, a->b);
     check_r0_write(a->d);
     gen_helper_float_madd_s(cpu_R[a->d], cpu_env, cpu_R[a->d],
                             cpu_R[a->a], cpu_R[a->b]);
@@ -1333,42 +1225,36 @@ static bool trans_lf_madd_s(DisasContext *dc, arg_dab *a, uint32_t insn)
 
 static bool trans_lf_sfeq_s(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("lf.sfeq.s r%d, r%d\n", a->a, a->b);
     do_fpcmp(dc, a, gen_helper_float_eq_s, false, false);
     return true;
 }
 
 static bool trans_lf_sfne_s(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("lf.sfne.s r%d, r%d\n", a->a, a->b);
     do_fpcmp(dc, a, gen_helper_float_eq_s, true, false);
     return true;
 }
 
 static bool trans_lf_sfgt_s(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("lf.sfgt.s r%d, r%d\n", a->a, a->b);
     do_fpcmp(dc, a, gen_helper_float_lt_s, false, true);
     return true;
 }
 
 static bool trans_lf_sfge_s(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("lf.sfge.s r%d, r%d\n", a->a, a->b);
     do_fpcmp(dc, a, gen_helper_float_le_s, false, true);
     return true;
 }
 
 static bool trans_lf_sflt_s(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("lf.sflt.s r%d, r%d\n", a->a, a->b);
     do_fpcmp(dc, a, gen_helper_float_lt_s, false, false);
     return true;
 }
 
 static bool trans_lf_sfle_s(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    LOG_DIS("lf.sfle.s r%d, r%d\n", a->a, a->b);
     do_fpcmp(dc, a, gen_helper_float_le_s, false, false);
     return true;
 }
-- 
2.17.0
