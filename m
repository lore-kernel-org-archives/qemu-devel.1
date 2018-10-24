Received: from eggs.gnu.org ([2001:4830:134:3::10]:60158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQd-0005AU-5y
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQb-00021A-0g
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49957 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQY-0001s0-Pn
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:28 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:35 +0200
Message-Id: <1540388447-27062-22-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 21/33] target/mips: Make R5900 DMULT[U],
 DDIV[U], LL[D] and SC[D] user only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Fredrik Noring <noring@nocrew.org>

The Linux kernel traps certain reserved instruction exceptions to
emulate the corresponding instructions. QEMU plays the role of the
kernel in user mode, so those traps are emulated by accepting the
instructions.

This change adds the function check_insn_opc_user_only to signal a
reserved instruction exception for flagged CPUs in QEMU system mode.

The MIPS III instructions DMULT[U], DDIV[U], LL[D] and SC[D] are not
implemented in R5900 hardware. They are trapped and emulated by the
Linux kernel and, accordingly, therefore QEMU user only instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 551928d..6c50485 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2872,6 +2872,21 @@ static inline void check_insn_opc_removed(DisasCon=
text *ctx, uint64_t flags)
     }
 }
=20
+/*
+ * The Linux kernel traps certain reserved instruction exceptions to
+ * emulate the corresponding instructions. QEMU is the kernel in user
+ * mode, so those traps are emulated by accepting the instructions.
+ *
+ * A reserved instruction exception is generated for flagged CPUs if
+ * QEMU runs in system mode.
+ */
+static inline void check_insn_opc_user_only(DisasContext *ctx, uint64_t =
flags)
+{
+#ifndef CONFIG_USER_ONLY
+    check_insn_opc_removed(ctx, flags);
+#endif
+}
+
 /* This code generates a "reserved instruction" exception if the
    CPU does not support 64-bit paired-single (PS) floating point data ty=
pe */
 static inline void check_ps(DisasContext *ctx)
@@ -23595,6 +23610,7 @@ static void decode_opc_special_legacy(CPUMIPSStat=
e *env, DisasContext *ctx)
     case OPC_DDIV:
     case OPC_DDIVU:
         check_insn(ctx, ISA_MIPS3);
+        check_insn_opc_user_only(ctx, INSN_R5900);
         check_mips_64(ctx);
         gen_muldiv(ctx, op1, 0, rs, rt);
         break;
@@ -26350,6 +26366,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
          break;
     case OPC_LL: /* Load and stores */
         check_insn(ctx, ISA_MIPS2);
+        check_insn_opc_user_only(ctx, INSN_R5900);
         /* Fallthrough */
     case OPC_LWL:
     case OPC_LWR:
@@ -26375,6 +26392,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
     case OPC_SC:
         check_insn(ctx, ISA_MIPS2);
          check_insn_opc_removed(ctx, ISA_MIPS32R6);
+        check_insn_opc_user_only(ctx, INSN_R5900);
          gen_st_cond(ctx, op, rt, rs, imm);
          break;
     case OPC_CACHE:
@@ -26641,9 +26659,11 @@ static void decode_opc(CPUMIPSState *env, DisasC=
ontext *ctx)
=20
 #if defined(TARGET_MIPS64)
     /* MIPS64 opcodes */
+    case OPC_LLD:
+        check_insn_opc_user_only(ctx, INSN_R5900);
+        /* fall through */
     case OPC_LDL:
     case OPC_LDR:
-    case OPC_LLD:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         /* fall through */
     case OPC_LWU:
@@ -26664,6 +26684,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
     case OPC_SCD:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         check_insn(ctx, ISA_MIPS3);
+        check_insn_opc_user_only(ctx, INSN_R5900);
         check_mips_64(ctx);
         gen_st_cond(ctx, op, rt, rs, imm);
         break;
--=20
2.7.4
