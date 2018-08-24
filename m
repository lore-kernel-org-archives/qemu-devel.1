Received: from eggs.gnu.org ([2001:4830:134:3::10]:43970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI57-0001Ku-5i
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI53-0007ms-FP
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:49:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:29927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI53-0007mI-67
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:49:13 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Fri, 24 Aug 2018 15:44:06 -0400
Message-Id: <b85772418fab59a68ce21a40522d743081505b34.1535133089.git.jancraig@amazon.com>
In-Reply-To: <cover.1535133088.git.jancraig@amazon.com>
References: <cover.1535133088.git.jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH 5/7] target/mips: Add MXU instruction D16MAC
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

Adds support for emulating the D16MAC instruction.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 target/mips/translate.c | 66 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 64fc6089bb..221076711d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -366,6 +366,7 @@ enum {
     OPC_DCLO     = 0x25 | OPC_SPECIAL2,
     /* MXU */
     OPC_MXU_D16MUL = 0x08 | OPC_SPECIAL2,
+    OPC_MXU_D16MAC = 0x0A | OPC_SPECIAL2,
     OPC_MXU_S8LDD  = 0x22 | OPC_SPECIAL2,
     OPC_MXU_S32I2M = 0x2F | OPC_SPECIAL2,
     OPC_MXU_S32M2I = 0x2E | OPC_SPECIAL2,
@@ -3806,6 +3807,17 @@ typedef union {
         uint32_t sel:2;
         uint32_t special2:6;
     } D16MUL;
+
+    struct {
+        uint32_t op:6;
+        uint32_t xra:4;
+        uint32_t xrb:4;
+        uint32_t xrc:4;
+        uint32_t xrd:4;
+        uint32_t optn2:2;
+        uint32_t aptn2:2;
+        uint32_t special2:6;
+    } D16MAC;
 } MXU_OPCODE;
 
 /* MXU Instructions */
@@ -3932,6 +3944,59 @@ static void gen_mxu(DisasContext *ctx, uint32_t opc)
         gen_store_mxu_gpr(t3, opcode->D16MUL.xra);
         gen_store_mxu_gpr(t2, opcode->D16MUL.xrd);
         break;
+
+    case OPC_MXU_D16MAC:
+        gen_load_mxu_gpr(t1, opcode->D16MAC.xrb);
+        tcg_gen_ext16s_tl(t0, t1);
+        tcg_gen_shri_tl(t1, t1, 16);
+        tcg_gen_ext16s_tl(t1, t1);
+        gen_load_mxu_gpr(t3, opcode->D16MAC.xrc);
+        tcg_gen_ext16s_tl(t2, t3);
+        tcg_gen_shri_tl(t3, t3, 16);
+        tcg_gen_ext16s_tl(t3, t3);
+
+        switch (opcode->D16MAC.optn2) {
+        case 0: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
+            tcg_gen_mul_tl(t3, t1, t3);
+            tcg_gen_mul_tl(t2, t0, t2);
+            break;
+        case 1: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
+            tcg_gen_mul_tl(t3, t0, t3);
+            tcg_gen_mul_tl(t2, t0, t2);
+            break;
+        case 2: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
+            tcg_gen_mul_tl(t3, t1, t3);
+            tcg_gen_mul_tl(t2, t1, t2);
+            break;
+        case 3: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
+            tcg_gen_mul_tl(t3, t0, t3);
+            tcg_gen_mul_tl(t2, t1, t2);
+            break;
+        }
+        gen_load_mxu_gpr(t0, opcode->D16MAC.xra);
+        gen_load_mxu_gpr(t1, opcode->D16MAC.xrd);
+
+        switch (opcode->D16MAC.aptn2) {
+        case 0:
+            tcg_gen_add_tl(t3, t0, t3);
+            tcg_gen_add_tl(t2, t1, t2);
+            break;
+        case 1:
+            tcg_gen_add_tl(t3, t0, t3);
+            tcg_gen_sub_tl(t2, t1, t2);
+            break;
+        case 2:
+            tcg_gen_sub_tl(t3, t0, t3);
+            tcg_gen_add_tl(t2, t1, t2);
+            break;
+        case 3:
+            tcg_gen_sub_tl(t3, t0, t3);
+            tcg_gen_sub_tl(t2, t1, t2);
+            break;
+        }
+        gen_store_mxu_gpr(t3, opcode->D16MAC.xra);
+        gen_store_mxu_gpr(t2, opcode->D16MAC.xrd);
+        break;
     }
 
     tcg_temp_free(t0);
@@ -18028,6 +18093,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MXU_S32M2I:
     case OPC_MXU_S8LDD:
     case OPC_MXU_D16MUL:
+    case OPC_MXU_D16MAC:
         gen_mxu(ctx, op1);
         break;
 
-- 
2.18.0
