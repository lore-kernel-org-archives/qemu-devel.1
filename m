Received: from eggs.gnu.org ([2001:4830:134:3::10]:44295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6To-0000JA-Lh
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Tm-0005bx-J5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:48 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6Tm-0005bk-An
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:46 -0400
Received: by mail-lf0-x243.google.com with SMTP id r2-v6so10919858lff.4
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:32:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:49 +0200
Message-Id: <20180508173152.29327-34-edgar.iglesias@gmail.com>
In-Reply-To: <20180508173152.29327-1-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 33/36] target-microblaze: Remove argument b
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Remove argument b in eval_cc() as it is always set to zero.
No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 231a66e77d..77ef21a708 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1139,7 +1139,7 @@ static void dec_store(DisasContext *dc)
 }
 
 static inline void eval_cc(DisasContext *dc, unsigned int cc,
-                           TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+                           TCGv_i32 d, TCGv_i32 a)
 {
     static const int mb_to_tcg_cc[] = {
         [CC_EQ] = TCG_COND_EQ,
@@ -1157,7 +1157,7 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
     case CC_LE:
     case CC_GE:
     case CC_GT:
-        tcg_gen_setcond_i32(mb_to_tcg_cc[cc], d, a, b);
+        tcg_gen_setcondi_i32(mb_to_tcg_cc[cc], d, a, 0);
         break;
     default:
         cpu_abort(CPU(dc->cpu), "Unknown condition code %x.\n", cc);
@@ -1203,7 +1203,7 @@ static void dec_bcc(DisasContext *dc)
         tcg_gen_movi_i32(env_btarget, dc->pc);
         tcg_gen_add_i32(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
     }
-    eval_cc(dc, cc, env_btaken, cpu_R[dc->ra], tcg_const_i32(0));
+    eval_cc(dc, cc, env_btaken, cpu_R[dc->ra]);
 }
 
 static void dec_br(DisasContext *dc)
-- 
2.14.1
