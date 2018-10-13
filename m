Received: from eggs.gnu.org ([2001:4830:134:3::10]:42936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHov-00075i-SE
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHor-000052-IH
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:57 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:9933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gBHor-0008WA-6T
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:53 -0400
Date: Sat, 13 Oct 2018 13:10:40 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <f1792f40bfa482c2d34c703fa5a83c535f3f65f8.1539428198.git.noring@nocrew.org>
References: <cover.1539428198.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1539428198.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 4/7] target/mips: R5900 DMULT[U], DDIV[U],
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
index 9d9be199e4..2d5c0a8173 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1887,6 +1887,21 @@ static inline void check_insn_opc_removed(DisasCon=
text *ctx, int flags)
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
+static inline void check_insn_opc_user_only(DisasContext *ctx, int flags=
)
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
@@ -22465,6 +22480,7 @@ static void decode_opc_special_legacy(CPUMIPSStat=
e *env, DisasContext *ctx)
     case OPC_DDIV:
     case OPC_DDIVU:
         check_insn(ctx, ISA_MIPS3);
+        check_insn_opc_user_only(ctx, INSN_R5900);
         check_mips_64(ctx);
         gen_muldiv(ctx, op1, 0, rs, rt);
         break;
@@ -24968,6 +24984,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
          break;
     case OPC_LL: /* Load and stores */
         check_insn(ctx, ISA_MIPS2);
+        check_insn_opc_user_only(ctx, INSN_R5900);
         /* Fallthrough */
     case OPC_LWL:
     case OPC_LWR:
@@ -24993,6 +25010,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
     case OPC_SC:
         check_insn(ctx, ISA_MIPS2);
          check_insn_opc_removed(ctx, ISA_MIPS32R6);
+        check_insn_opc_user_only(ctx, INSN_R5900);
          gen_st_cond(ctx, op, rt, rs, imm);
          break;
     case OPC_CACHE:
@@ -25259,9 +25277,11 @@ static void decode_opc(CPUMIPSState *env, DisasC=
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
@@ -25282,6 +25302,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
     case OPC_SCD:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         check_insn(ctx, ISA_MIPS3);
+        check_insn_opc_user_only(ctx, INSN_R5900);
         check_mips_64(ctx);
         gen_st_cond(ctx, op, rt, rs, imm);
         break;
--=20
2.16.4
