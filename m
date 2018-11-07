Received: from eggs.gnu.org ([2001:4830:134:3::10]:56653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTMr-0006uu-Rl
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTMo-0005Lv-Vs
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:19:57 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:18493)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKTMo-0005Kn-Nu
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:19:54 -0500
Date: Wed, 7 Nov 2018 20:19:34 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <0c57a01dc6463a5298037e1b211ea214c1ea245f.1541616663.git.noring@nocrew.org>
References: <cover.1541616663.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541616663.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v2 5/6] target/mips: Guard
 check_insn_opc_user_only with INSN_R5900 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 45ad70c097..c3ed4c21ce 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28285,7 +28285,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
          break;
     case OPC_LL: /* Load and stores */
         check_insn(ctx, ISA_MIPS2);
-        check_insn_opc_user_only(ctx, INSN_R5900);
+        if (ctx->insn_flags & INSN_R5900) {
+            check_insn_opc_user_only(ctx, INSN_R5900);
+        }
         /* Fallthrough */
     case OPC_LWL:
     case OPC_LWR:
@@ -28311,7 +28313,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     case OPC_SC:
         check_insn(ctx, ISA_MIPS2);
          check_insn_opc_removed(ctx, ISA_MIPS32R6);
-        check_insn_opc_user_only(ctx, INSN_R5900);
+        if (ctx->insn_flags & INSN_R5900) {
+            check_insn_opc_user_only(ctx, INSN_R5900);
+        }
          gen_st_cond(ctx, op, rt, rs, imm);
          break;
     case OPC_CACHE:
@@ -28579,7 +28583,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
 #if defined(TARGET_MIPS64)
     /* MIPS64 opcodes */
     case OPC_LLD:
-        check_insn_opc_user_only(ctx, INSN_R5900);
+        if (ctx->insn_flags & INSN_R5900) {
+            check_insn_opc_user_only(ctx, INSN_R5900);
+        }
         /* fall through */
     case OPC_LDL:
     case OPC_LDR:
@@ -28603,7 +28609,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     case OPC_SCD:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         check_insn(ctx, ISA_MIPS3);
-        check_insn_opc_user_only(ctx, INSN_R5900);
+        if (ctx->insn_flags & INSN_R5900) {
+            check_insn_opc_user_only(ctx, INSN_R5900);
+        }
         check_mips_64(ctx);
         gen_st_cond(ctx, op, rt, rs, imm);
         break;
-- 
2.18.1
