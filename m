Received: from eggs.gnu.org ([2001:4830:134:3::10]:46032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmp-0000Bj-K1
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmj-00089J-O4
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33371 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmj-00083Y-DH
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:17 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:33 +0200
Message-Id: <1540213077-15211-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 10/34] target/mips: Placeholder for R5900 SQ,
 handle user mode RDHWR
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

Add placeholder for SQ instruction, handle RDHWR.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3c6a2c9..19a8aba 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24420,6 +24420,53 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void gen_tx79_sq(DisasContext *ctx, int base, int rt, int offset)
+{
+    generate_exception_end(ctx, EXCP_RI);    /* TODO: TX79_SQ */
+}
+
+/*
+ * The TX79-specific instruction Store Quadword
+ *
+ * +--------+-------+-------+------------------------+
+ * | 011111 |  base |   rt  |           offset       | SQ
+ * +--------+-------+-------+------------------------+
+ *      6       5       5                 16
+ *
+ * has the same opcode as the Read Hardware Register instruction
+ *
+ * +--------+-------+-------+-------+-------+--------+
+ * | 011111 | 00000 |   rt  |   rd  | 00000 | 111011 | RDHWR
+ * +--------+-------+-------+-------+-------+--------+
+ *      6       5       5       5       5        6
+ *
+ * that is required, trapped and emulated by the Linux kernel. However, all
+ * RDHWR encodings yield address error exceptions on the TX79 since the SQ
+ * offset is odd. Therefore all valid SQ instructions can execute normally.
+ * In user mode, QEMU must verify the upper and lower 11 bits to distinguish
+ * between SQ and RDHWR, as the Linux kernel does.
+ */
+static void decode_tx79_sq(CPUMIPSState *env, DisasContext *ctx)
+{
+    int base = extract32(ctx->opcode, 21, 5);
+    int rt = extract32(ctx->opcode, 16, 5);
+    int offset = extract32(ctx->opcode, 0, 16);
+
+#ifdef CONFIG_USER_ONLY
+    uint32_t op1 = MASK_SPECIAL3(ctx->opcode);
+    uint32_t op2 = extract32(ctx->opcode, 6, 5);
+
+    if (base == 0 && op2 == 0 && op1 == OPC_RDHWR) {
+        int rd = extract32(ctx->opcode, 11, 5);
+
+        gen_rdhwr(ctx, rt, rd, 0);
+        return;
+    }
+#endif
+
+    gen_tx79_sq(ctx, base, rt, offset);
+}
+
 static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
@@ -25720,7 +25767,11 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         decode_opc_special2_legacy(env, ctx);
         break;
     case OPC_SPECIAL3:
-        decode_opc_special3(env, ctx);
+        if (ctx->insn_flags & INSN_R5900) {
+            decode_tx79_sq(env, ctx);    /* TX79_SQ */
+        } else {
+            decode_opc_special3(env, ctx);
+        }
         break;
     case OPC_REGIMM:
         op1 = MASK_REGIMM(ctx->opcode);
-- 
2.7.4
