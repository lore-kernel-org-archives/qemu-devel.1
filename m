Received: from eggs.gnu.org ([2001:4830:134:3::10]:37256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDj-0001zN-5B
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDe-0004Lb-So
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:15 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDe-0004L4-MT
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:10 -0400
Received: by mail-wm0-x234.google.com with SMTP id v131-v6so20051229wma.1
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:51:10 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:50:07 +0200
Message-Id: <20180529105011.1914-35-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 34/38] target-microblaze: Remove argument b
 in eval_cc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Remove argument b in eval_cc() as it is always set to zero.
No functional change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 092e182c2f..d870cb7c43 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1143,7 +1143,7 @@ static void dec_store(DisasContext *dc)
 }
 
 static inline void eval_cc(DisasContext *dc, unsigned int cc,
-                           TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+                           TCGv_i32 d, TCGv_i32 a)
 {
     static const int mb_to_tcg_cc[] = {
         [CC_EQ] = TCG_COND_EQ,
@@ -1161,7 +1161,7 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
     case CC_LE:
     case CC_GE:
     case CC_GT:
-        tcg_gen_setcond_i32(mb_to_tcg_cc[cc], d, a, b);
+        tcg_gen_setcondi_i32(mb_to_tcg_cc[cc], d, a, 0);
         break;
     default:
         cpu_abort(CPU(dc->cpu), "Unknown condition code %x.\n", cc);
@@ -1207,7 +1207,7 @@ static void dec_bcc(DisasContext *dc)
         tcg_gen_movi_i32(env_btarget, dc->pc);
         tcg_gen_add_i32(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
     }
-    eval_cc(dc, cc, env_btaken, cpu_R[dc->ra], tcg_const_i32(0));
+    eval_cc(dc, cc, env_btaken, cpu_R[dc->ra]);
 }
 
 static void dec_br(DisasContext *dc)
-- 
2.14.1
