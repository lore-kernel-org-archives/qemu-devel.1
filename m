Received: from eggs.gnu.org ([2001:4830:134:3::10]:54900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOi-0000fi-04
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOh-0004xz-4q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:31 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:42889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAOg-0004xL-Se
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:31 -0400
Received: by mail-lf0-x241.google.com with SMTP id u21-v6so24909449lfu.9
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:19:30 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:18:56 +0200
Message-Id: <20180503091922.28733-4-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-1-edgar.iglesias@gmail.com>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 03/29] target-microblaze: compute_ldst_addr:
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Use bool instead of int to represent flags.
No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6fe679ca6d..9232b42a8a 100644
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
