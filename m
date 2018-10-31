Received: from eggs.gnu.org ([2001:4830:134:3::10]:37237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHqRR-0004eF-2R
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHqRO-0002v0-5u
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:21:48 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 31 Oct 2018 14:20:10 +0100
Message-Id: <20181031132029.4887-17-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 16/35] target/riscv: Convert RV priv insns
 to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de, Alistair.Francis@wdc.com
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
v2 -> v3:
    - illegal instruction call replaced with return false
    - dropped insn argument of trans_foo functions

target/riscv/insn32.decode                    |  15 +++
.../riscv/insn_trans/trans_privileged.inc.c   | 108 ++++++++++++++++++
 target/riscv/translate.c                      |  49 +-------
 3 files changed, 124 insertions(+), 48 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_privileged.inc.c

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b933c349a4..379a5d5438 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -57,6 +57,21 @@
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 
+@sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
+@sfence_vm  ....... ..... .....   ... ..... ....... %rs1
+
+
+# *** Privileged Instructions ***
+ecall      000000000000     00000 000 00000 1110011
+ebreak     000000000001     00000 000 00000 1110011
+uret       0000000    00010 00000 000 00000 1110011
+sret       0001000    00010 00000 000 00000 1110011
+hret       0010000    00010 00000 000 00000 1110011
+mret       0011000    00010 00000 000 00000 1110011
+wfi        0001000    00101 00000 000 00000 1110011
+sfence_vma 0001001    ..... ..... 000 00000 1110011 @sfence_vma
+sfence_vm  0001000    00100 ..... 000 00000 1110011 @sfence_vm
+
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
 auipc    ....................       ..... 0010111 @u
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
new file mode 100644
index 0000000000..7a4f0c7846
--- /dev/null
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -0,0 +1,108 @@
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
+static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
+{
+    /* always generates U-level ECALL, fixed in do_interrupt handler */
+    generate_exception(ctx, RISCV_EXCP_U_ECALL);
+    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
+static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
+{
+    generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
+    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
+static bool trans_uret(DisasContext *ctx, arg_uret *a)
+{
+    return false;
+}
+
+static bool trans_sret(DisasContext *ctx, arg_sret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
+    CPURISCVState *env = current_cpu->env_ptr;
+    if (riscv_has_ext(env, RVS)) {
+        gen_helper_sret(cpu_pc, cpu_env, cpu_pc);
+        tcg_gen_exit_tb(NULL, 0); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+    } else {
+        return false;
+    }
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hret(DisasContext *ctx, arg_hret *a)
+{
+    return false;
+}
+
+static bool trans_mret(DisasContext *ctx, arg_mret *a)
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
+static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
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
+static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_tlb_flush(cpu_env);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_tlb_flush(cpu_env);
+    return true;
+#else
+    return false;
+#endif
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8e91fa8284..885e48881c 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -690,22 +690,8 @@ static void gen_set_rm(DisasContext *ctx, int rm)
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
@@ -720,46 +706,12 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
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
@@ -1056,6 +1008,7 @@ bool decode_insn32(DisasContext *ctx, uint32_t insn);
 #include "insn_trans/trans_rva.inc.c"
 #include "insn_trans/trans_rvf.inc.c"
 #include "insn_trans/trans_rvd.inc.c"
+#include "insn_trans/trans_privileged.inc.c"
 
 static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
 {
-- 
2.19.1
