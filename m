Received: from eggs.gnu.org ([2001:4830:134:3::10]:37201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDe-0001u1-54
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDd-0004Kg-C5
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:10 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDd-0004K4-5i
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:09 -0400
Received: by mail-wr0-x230.google.com with SMTP id w3-v6so24680245wrl.12
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:51:08 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:50:06 +0200
Message-Id: <20180529105011.1914-34-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 33/38] target-microblaze: Use table based
 condition-codes conversion
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

Use a table based conversion to map condition-codes between
MicroBlaze ISA encoding and TCG.
No functional change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0d8ef77513..092e182c2f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1145,28 +1145,27 @@ static void dec_store(DisasContext *dc)
 static inline void eval_cc(DisasContext *dc, unsigned int cc,
                            TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
+    static const int mb_to_tcg_cc[] = {
+        [CC_EQ] = TCG_COND_EQ,
+        [CC_NE] = TCG_COND_NE,
+        [CC_LT] = TCG_COND_LT,
+        [CC_LE] = TCG_COND_LE,
+        [CC_GE] = TCG_COND_GE,
+        [CC_GT] = TCG_COND_GT,
+    };
+
     switch (cc) {
-        case CC_EQ:
-            tcg_gen_setcond_i32(TCG_COND_EQ, d, a, b);
-            break;
-        case CC_NE:
-            tcg_gen_setcond_i32(TCG_COND_NE, d, a, b);
-            break;
-        case CC_LT:
-            tcg_gen_setcond_i32(TCG_COND_LT, d, a, b);
-            break;
-        case CC_LE:
-            tcg_gen_setcond_i32(TCG_COND_LE, d, a, b);
-            break;
-        case CC_GE:
-            tcg_gen_setcond_i32(TCG_COND_GE, d, a, b);
-            break;
-        case CC_GT:
-            tcg_gen_setcond_i32(TCG_COND_GT, d, a, b);
-            break;
-        default:
-            cpu_abort(CPU(dc->cpu), "Unknown condition code %x.\n", cc);
-            break;
+    case CC_EQ:
+    case CC_NE:
+    case CC_LT:
+    case CC_LE:
+    case CC_GE:
+    case CC_GT:
+        tcg_gen_setcond_i32(mb_to_tcg_cc[cc], d, a, b);
+        break;
+    default:
+        cpu_abort(CPU(dc->cpu), "Unknown condition code %x.\n", cc);
+        break;
     }
 }
 
-- 
2.14.1
