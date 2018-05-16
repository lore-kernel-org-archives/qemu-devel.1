Received: from eggs.gnu.org ([2001:4830:134:3::10]:53463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Wl-0002rW-Hk
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Wk-0000gF-RA
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:51:55 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1Wk-0000fr-Kx
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:51:54 -0400
Received: by mail-wr0-x241.google.com with SMTP id 94-v6so2762889wrf.5
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:51:54 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:11 +0200
Message-Id: <20180516185146.30708-4-edgar.iglesias@gmail.com>
In-Reply-To: <20180516185146.30708-1-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 03/38] target-microblaze: compute_ldst_addr:
 Use bool instead of int
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

Use bool instead of int to represent flags.
No functional change.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 413e683aec..46595e6336 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -845,13 +845,13 @@ static void dec_imm(DisasContext *dc)
 
 static inline TCGv *compute_ldst_addr(DisasContext *dc, TCGv *t)
 {
-    unsigned int extimm = dc->tb_flags & IMM_FLAG;
-    /* Should be set to one if r1 is used by loadstores.  */
-    int stackprot = 0;
+    bool extimm = dc->tb_flags & IMM_FLAG;
+    /* Should be set to true if r1 is used by loadstores.  */
+    bool stackprot = false;
 
     /* All load/stores use ra.  */
     if (dc->ra == 1 && dc->cpu->cfg.stackprot) {
-        stackprot = 1;
+        stackprot = true;
     }
 
     /* Treat the common cases first.  */
@@ -864,7 +864,7 @@ static inline TCGv *compute_ldst_addr(DisasContext *dc, TCGv *t)
         }
 
         if (dc->rb == 1 && dc->cpu->cfg.stackprot) {
-            stackprot = 1;
+            stackprot = true;
         }
 
         *t = tcg_temp_new();
-- 
2.14.1
