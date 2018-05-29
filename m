Received: from eggs.gnu.org ([2001:4830:134:3::10]:36759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcCr-0001AW-IS
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcCq-0003lZ-Mb
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:21 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:33535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcCq-0003kn-HF
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:20 -0400
Received: by mail-wm0-x230.google.com with SMTP id x12-v6so47287717wmc.0
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:20 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:36 +0200
Message-Id: <20180529105011.1914-4-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 03/38] target-microblaze: compute_ldst_addr:
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
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

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
