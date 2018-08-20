Received: from eggs.gnu.org ([2001:4830:134:3::10]:44884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froy5-0000xb-Uj
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froky-0001ci-La
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:28 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51268 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1frokq-0001PY-LK
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:20 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 20 Aug 2018 20:16:20 +0200
Message-Id: <1534789014-8310-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v11 12/46] target/mips: Add emulation of
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
Cc: peter.maydell@linaro.org, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, dnikolic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of NOT16, AND16, XOR16, OR16 instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 569e58a..75f2b64 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16760,6 +16760,37 @@ static inline int decode_gpr_gpr4_zero(int r)
 }
 
 
+/* extraction utilities */
+
+#define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
+#define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
+#define NANOMIPS_EXTRACT_RS2(op) uMIPS_RS(op)
+#define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
+#define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
+#define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
+
+
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
@@ -16836,6 +16867,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     case NM_P16C:
         switch (ctx->opcode & 1) {
         case NM_POOL16C_0:
+            gen_pool16c_nanomips_insn(ctx);
             break;
         case NM_LWXS16:
             gen_ldxs(ctx, rt, rs, rd);
@@ -16910,6 +16942,12 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
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
