Received: from eggs.gnu.org ([208.118.235.92]:59985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSsf-000139-VQ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSeF-0006qQ-56
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:30:34 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSeF-0006pP-04
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:30:31 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Thu, 30 Aug 2018 15:30:13 -0400
Message-Id: <20180830193019.20104-4-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-1-jancraig@amazon.com>
References: <20180830193019.20104-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v4 3/9] target/mips: Split mips instruction
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

Splits the instruction handling switch statement from the original
legacy code.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - NA
 v2
    - NA
 v3
    - NA
 v4
    - Initial patch

 target/mips/mips-defs.h |  1 +
 target/mips/translate.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index d239069975..5a409757f0 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -50,6 +50,7 @@
 #define   ASE_SMARTMIPS 0x00400000
 #define   ASE_MICROMIPS 0x00800000
 #define   ASE_MSA       0x01000000
+#define   ASE_MXU       0x02000000
 
 /* Chip specific instructions. */
 #define		INSN_LOONGSON2E  0x20000000
diff --git a/target/mips/translate.c b/target/mips/translate.c
index a598f45558..53d896ebf9 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17855,6 +17855,28 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_opc_special2_mxu(CPUMIPSState *env, DisasContext *ctx)
+{
+    int rs, rt, rd;
+    uint32_t op1;
+
+    rs = (ctx->opcode >> 21) & 0x1f;
+    rt = (ctx->opcode >> 16) & 0x1f;
+    rd = (ctx->opcode >> 11) & 0x1f;
+
+    op1 = MASK_SPECIAL2(ctx->opcode);
+
+    switch (op1) {
+    case OPC_MUL:
+        gen_arith(ctx, op1, rd, rs, rt);
+        break;
+    default:            /* Invalid */
+        MIPS_INVAL("special2_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd;
@@ -19836,7 +19858,11 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         decode_opc_special(env, ctx);
         break;
     case OPC_SPECIAL2:
-        decode_opc_special2_legacy(env, ctx);
+        if (ctx->insn_flags & ASE_MXU) {
+            decode_opc_special2_mxu(env, ctx);
+        } else {
+            decode_opc_special2_legacy(env, ctx);
+        }
         break;
     case OPC_SPECIAL3:
         decode_opc_special3(env, ctx);
-- 
2.18.0
