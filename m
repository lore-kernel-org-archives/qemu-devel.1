Received: from eggs.gnu.org ([2001:4830:134:3::10]:54042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Xc-0003gh-DD
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Xa-000133-Lz
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:48 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1Xa-00012g-GP
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:46 -0400
Received: by mail-wr0-x244.google.com with SMTP id 94-v6so2767240wrf.5
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:52:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:44 +0200
Message-Id: <20180516185146.30708-37-edgar.iglesias@gmail.com>
In-Reply-To: <20180516185146.30708-1-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 36/38] target-microblaze: Use
 tcg_gen_movcond in eval_cond_jmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Cleanup eval_cond_jmp to use tcg_gen_movcond_i64().
No functional change.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a846797d9c..78c2855ff0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1171,12 +1171,16 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
 
 static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i64 pc_false)
 {
-    TCGLabel *l1 = gen_new_label();
-    /* Conditional jmp.  */
-    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_false);
-    tcg_gen_brcondi_i32(TCG_COND_EQ, env_btaken, 0, l1);
-    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_true);
-    gen_set_label(l1);
+    TCGv_i64 tmp_btaken = tcg_temp_new_i64();
+    TCGv_i64 tmp_zero = tcg_const_i64(0);
+
+    tcg_gen_extu_i32_i64(tmp_btaken, env_btaken);
+    tcg_gen_movcond_i64(TCG_COND_NE, cpu_SR[SR_PC],
+                        tmp_btaken, tmp_zero,
+                        pc_true, pc_false);
+
+    tcg_temp_free_i64(tmp_btaken);
+    tcg_temp_free_i64(tmp_zero);
 }
 
 static void dec_bcc(DisasContext *dc)
-- 
2.14.1
