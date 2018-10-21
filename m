Received: from eggs.gnu.org ([2001:4830:134:3::10]:46555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFqM-0005XS-Lc
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFqJ-00050b-CA
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:40:42 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFqI-0004sF-4E
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:40:39 -0400
Date: Sun, 21 Oct 2018 17:40:18 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <ba849ca94a4233dc7098ecac3d458df327bd6de6.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 24/38] target/mips: R5900 DMULT[U], DDIV[U],
 LL[D] and SC[D] are user only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

The Linux kernel traps certain reserved instruction exceptions to
emulate the corresponding instructions. QEMU is the kernel in user
mode, so those traps are emulated by accepting the instructions.

This change adds the function check_insn_opc_user_only to signal a
reserved instruction exception for flagged CPUs in QEMU system mode.

The MIPS III instructions DMULT[U], DDIV[U], LL[D] and SC[D] are not
implemented in R5900 hardware. They are trapped and emulated by the
Linux kernel and, accordingly, therefore QEMU user only instructions.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/mips/translate.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3977c57a22..066119c3e1 100644
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
@@ -23643,6 +23658,7 @@ static void decode_opc_special_legacy(CPUMIPSStat=
e *env, DisasContext *ctx)
     case OPC_DDIV:
     case OPC_DDIVU:
         check_insn(ctx, ISA_MIPS3);
+        check_insn_opc_user_only(ctx, INSN_R5900);
         check_mips_64(ctx);
         gen_muldiv(ctx, op1, 0, rs, rt);
         break;
@@ -26398,6 +26414,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
          break;
     case OPC_LL: /* Load and stores */
         check_insn(ctx, ISA_MIPS2);
+        check_insn_opc_user_only(ctx, INSN_R5900);
         /* Fallthrough */
     case OPC_LWL:
     case OPC_LWR:
@@ -26423,6 +26440,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
     case OPC_SC:
         check_insn(ctx, ISA_MIPS2);
          check_insn_opc_removed(ctx, ISA_MIPS32R6);
+        check_insn_opc_user_only(ctx, INSN_R5900);
          gen_st_cond(ctx, op, rt, rs, imm);
          break;
     case OPC_CACHE:
@@ -26689,9 +26707,11 @@ static void decode_opc(CPUMIPSState *env, DisasC=
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
@@ -26712,6 +26732,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
     case OPC_SCD:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         check_insn(ctx, ISA_MIPS3);
+        check_insn_opc_user_only(ctx, INSN_R5900);
         check_mips_64(ctx);
         gen_st_cond(ctx, op, rt, rs, imm);
         break;
--=20
2.18.1
