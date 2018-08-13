Received: from eggs.gnu.org ([2001:4830:134:3::10]:59501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH39-0005QA-Nm
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH34-00075v-Md
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:39 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55766 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH34-00073W-CL
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:34 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:52:55 +0200
Message-Id: <1534182832-554-31-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 30/87] target/mips: Add emulation of
 nanoMIPS 16-bit logic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of NOT16, AND16, XOR16, OR16 instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 240e3fb..6feb093 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16691,6 +16691,27 @@ static inline int decode_gpr_gpr4_zero(int r)
 #define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
 
 
+static void gen_pool16c_nanomips_insn(DisasContext *ctx)
+{
+    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
+    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
+
+    switch (extract32(ctx->opcode, 2, 2)) {
+    case NM_NOT16:
+        gen_logic(ctx, OPC_NOR, rt, rs, 0);
+        break;
+    case NM_AND16:
+        gen_logic(ctx, OPC_AND, rt, rt, rs);
+        break;
+    case NM_XOR16:
+        gen_logic(ctx, OPC_XOR, rt, rt, rs);
+        break;
+    case NM_OR16:
+        gen_logic(ctx, OPC_OR, rt, rt, rs);
+        break;
+    }
+}
+
 static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t op;
@@ -16767,6 +16788,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     case NM_P16C:
         switch (ctx->opcode & 1) {
         case NM_POOL16C_0:
+            gen_pool16c_nanomips_insn(ctx);
             break;
         case NM_LWXS16:
             gen_ldxs(ctx, rt, rs, rd);
@@ -16841,6 +16863,12 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_ANDI16:
+        {
+            uint32_t u = extract32(ctx->opcode, 0, 4);
+            u = (u == 12) ? 0xff :
+                (u == 13) ? 0xffff : u;
+            gen_logic_imm(ctx, OPC_ANDI, rt, rs, u);
+        }
         break;
     case NM_P16_LB:
         offset = extract32(ctx->opcode, 0, 2);
-- 
2.7.4
