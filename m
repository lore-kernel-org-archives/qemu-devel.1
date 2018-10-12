Received: from eggs.gnu.org ([2001:4830:134:3::10]:39852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hh-0001qo-Ow
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hd-0000FT-O0
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:33 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:42774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1Hc-0008W2-1M
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:28 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:33 +0200
Message-Id: <20181012173047.25420-15-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 14/28] target/riscv: Convert RV priv insns to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Cc: qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode                    |  13 ++
 .../riscv/insn_trans/trans_privileged.inc.c   | 111 ++++++++++++++++++
 target/riscv/translate.c                      |  49 +-------
 3 files changed, 125 insertions(+), 48 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_privileged.inc.c

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 5df550169b..7c71f8338b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -44,6 +44,8 @@
 
 # Formats 32:
 @noargs  ................................
+@sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
+@sfence_vm  ....... ..... .....   ... ..... ....... %rs1
 
 @r       .......   ..... ..... ... ..... .......                   %rs2 %rs1 %rd
 @i       ............    ..... ... ..... .......         imm=%imm_i     %rs1 %rd
@@ -65,6 +67,17 @@
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 
+# *** Privileged Instructions ***
+ecall      000000000000     00000 000 00000 1110011 @noargs
+ebreak     000000000001     00000 000 00000 1110011 @noargs
+uret       0000000    00010 00000 000 00000 1110011 @noargs
+sret       0001000    00010 00000 000 00000 1110011 @noargs
+hret       0010000    00010 00000 000 00000 1110011 @noargs
+mret       0011000    00010 00000 000 00000 1110011 @noargs
+wfi        0001000    00101 00000 000 00000 1110011 @noargs
+sfence_vma 0001001    ..... ..... 000 00000 1110011 @sfence_vma
+sfence_vm  0001000    00100 ..... 000 00000 1110011 @sfence_vm
+
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
 auipc    ....................       ..... 0010111 @u
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
new file mode 100644
index 0000000000..9534adb025
--- /dev/null
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -0,0 +1,111 @@
+/*
+ * RISC-V translation routines for the RISC-V privileged instructions.
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
+ *                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+static bool trans_ecall(DisasContext *ctx, arg_ecall *a, uint32_t insn)
+{
+    /* always generates U-level ECALL, fixed in do_interrupt handler */
+    generate_exception(ctx, RISCV_EXCP_U_ECALL);
+    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
+static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a, uint32_t insn)
+{
+    generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
+    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
+static bool trans_uret(DisasContext *ctx, arg_uret *a, uint32_t insn)
+{
+    gen_exception_illegal(ctx);
+    return true;
+}
+
+static bool trans_sret(DisasContext *ctx, arg_sret *a, uint32_t insn)
+{
+#ifndef CONFIG_USER_ONLY
+    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
+    CPURISCVState *env = current_cpu->env_ptr;
+    if (riscv_has_ext(env, RVS)) {
+        gen_helper_sret(cpu_pc, cpu_env, cpu_pc);
+        tcg_gen_exit_tb(NULL, 0); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+    } else {
+        gen_exception_illegal(ctx);
+    }
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hret(DisasContext *ctx, arg_hret *a, uint32_t insn)
+{
+    gen_exception_illegal(ctx);
+    return true;
+}
+
+static bool trans_mret(DisasContext *ctx, arg_mret *a, uint32_t insn)
+{
+#ifndef CONFIG_USER_ONLY
+    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
+    gen_helper_mret(cpu_pc, cpu_env, cpu_pc);
+    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_wfi(DisasContext *ctx, arg_wfi *a, uint32_t insn)
+{
+#ifndef CONFIG_USER_ONLY
+    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
+    gen_helper_wfi(cpu_env);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a,
+                             uint32_t insn)
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_tlb_flush(cpu_env);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a, uint32_t insn)
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_tlb_flush(cpu_env);
+    return true;
+#else
+    return false;
+#endif
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 85cabb70fb..49b1e9f8d7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -689,22 +689,8 @@ static void gen_set_rm(DisasContext *ctx, int rm)
 static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
                       int rd, int rs1, int csr)
 {
-    TCGv source1, dest;
-    source1 = tcg_temp_new();
-    dest = tcg_temp_new();
-    gen_get_gpr(source1, rs1);
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
 
-#ifndef CONFIG_USER_ONLY
-    /* Extract funct7 value and check whether it matches SFENCE.VMA */
-    if ((opc == OPC_RISC_ECALL) && ((csr >> 5) == 9)) {
-        /* sfence.vma */
-        /* TODO: handle ASID specific fences */
-        gen_helper_tlb_flush(cpu_env);
-        return;
-    }
-#endif
-
     switch (opc) {
     case OPC_RISC_ECALL:
         switch (csr) {
@@ -719,46 +705,12 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             tcg_gen_exit_tb(NULL, 0); /* no chaining */
             ctx->base.is_jmp = DISAS_NORETURN;
             break;
-#ifndef CONFIG_USER_ONLY
-        case 0x002: /* URET */
-            gen_exception_illegal(ctx);
-            break;
-        case 0x102: /* SRET */
-            if (riscv_has_ext(env, RVS)) {
-                gen_helper_sret(cpu_pc, cpu_env, cpu_pc);
-                tcg_gen_exit_tb(NULL, 0); /* no chaining */
-                ctx->base.is_jmp = DISAS_NORETURN;
-            } else {
-                gen_exception_illegal(ctx);
-            }
-            break;
-        case 0x202: /* HRET */
-            gen_exception_illegal(ctx);
-            break;
-        case 0x302: /* MRET */
-            gen_helper_mret(cpu_pc, cpu_env, cpu_pc);
-            tcg_gen_exit_tb(NULL, 0); /* no chaining */
-            ctx->base.is_jmp = DISAS_NORETURN;
-            break;
-        case 0x7b2: /* DRET */
-            gen_exception_illegal(ctx);
-            break;
-        case 0x105: /* WFI */
-            tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
-            gen_helper_wfi(cpu_env);
-            break;
-        case 0x104: /* SFENCE.VM */
-            gen_helper_tlb_flush(cpu_env);
-            break;
-#endif
         default:
             gen_exception_illegal(ctx);
             break;
         }
         break;
     }
-    tcg_temp_free(source1);
-    tcg_temp_free(dest);
 }
 
 static void decode_RV32_64C0(DisasContext *ctx)
@@ -1055,6 +1007,7 @@ bool decode_insn32(DisasContext *ctx, uint32_t insn);
 #include "insn_trans/trans_rva.inc.c"
 #include "insn_trans/trans_rvf.inc.c"
 #include "insn_trans/trans_rvd.inc.c"
+#include "insn_trans/trans_privileged.inc.c"
 
 static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
 {
-- 
2.19.1
