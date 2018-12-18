Received: from eggs.gnu.org ([2001:4830:134:3::10]:52979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92v-0001fe-Tk
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92r-0002rA-FJ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:01 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92q-0002Sl-Ow
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:56 -0500
Received: by mail-pg1-x544.google.com with SMTP id g189so7344221pgc.5
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:58 -0800
Message-Id: <20181218063911.2112-22-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 21/34] target/ppc: nand, nor,
 eqv are now generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/vmx-impl.inc.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 529ae0e5f5..329131d30b 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -277,34 +277,14 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
            16, 16);                                                     \
 }
 
-#define GEN_VXFORM_VN(name, vece, tcg_op, opc2, opc3)                   \
-static void glue(gen_, name)(DisasContext *ctx)                         \
-{                                                                       \
-    if (unlikely(!ctx->altivec_enabled)) {                              \
-        gen_exception(ctx, POWERPC_EXCP_VPU);                           \
-        return;                                                         \
-    }                                                                   \
-                                                                        \
-    tcg_op(vece,                                                        \
-           avr64_offset(rD(ctx->opcode), true),                         \
-           avr64_offset(rA(ctx->opcode), true),                         \
-           avr64_offset(rB(ctx->opcode), true),                         \
-           16, 16);                                                     \
-                                                                        \
-    tcg_gen_gvec_not(vece,                                              \
-                     avr64_offset(rD(ctx->opcode), true),               \
-                     avr64_offset(rD(ctx->opcode), true),               \
-                     16, 16);                                           \
-}
-
 /* Logical operations */
 GEN_VXFORM_V(vand, MO_64, tcg_gen_gvec_and, 2, 16);
 GEN_VXFORM_V(vandc, MO_64, tcg_gen_gvec_andc, 2, 17);
 GEN_VXFORM_V(vor, MO_64, tcg_gen_gvec_or, 2, 18);
 GEN_VXFORM_V(vxor, MO_64, tcg_gen_gvec_xor, 2, 19);
-GEN_VXFORM_VN(vnor, MO_64, tcg_gen_gvec_or, 2, 20);
-GEN_VXFORM_VN(veqv, MO_64, tcg_gen_gvec_xor, 2, 26);
-GEN_VXFORM_VN(vnand, MO_64, tcg_gen_gvec_and, 2, 22);
+GEN_VXFORM_V(vnor, MO_64, tcg_gen_gvec_nor, 2, 20);
+GEN_VXFORM_V(veqv, MO_64, tcg_gen_gvec_eqv, 2, 26);
+GEN_VXFORM_V(vnand, MO_64, tcg_gen_gvec_nand, 2, 22);
 GEN_VXFORM_V(vorc, MO_64, tcg_gen_gvec_orc, 2, 21);
 
 #define GEN_VXFORM(name, opc2, opc3)                                    \
-- 
2.17.2
