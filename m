Received: from eggs.gnu.org ([2001:4830:134:3::10]:44086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6TP-0008Mz-7B
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6TO-0005R4-BM
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:23 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:41349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6TO-0005Qn-32
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:22 -0400
Received: by mail-lf0-x241.google.com with SMTP id o123-v6so47032100lfe.8
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:32:21 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:33 +0200
Message-Id: <20180508173152.29327-18-edgar.iglesias@gmail.com>
In-Reply-To: <20180508173152.29327-1-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 17/36] target-microblaze: dec_msr: Use bool
 and extract32
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

Use bool and extract32 to represent the to, clr and
clrset flags.

No functional change.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4290fb2eaf..0593aff692 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -458,17 +458,20 @@ static void dec_msr(DisasContext *dc)
 {
     CPUState *cs = CPU(dc->cpu);
     TCGv_i32 t0, t1;
-    unsigned int sr, to, rn;
+    unsigned int sr, rn;
+    bool to, clrset;
 
-    sr = dc->imm & ((1 << 14) - 1);
-    to = dc->imm & (1 << 14);
+    sr = extract32(dc->imm, 0, 14);
+    to = extract32(dc->imm, 14, 1);
+    clrset = extract32(dc->imm, 15, 1) == 0;
     dc->type_b = 1;
-    if (to)
+    if (to) {
         dc->cpustate_changed = 1;
+    }
 
     /* msrclr and msrset.  */
-    if (!(dc->imm & (1 << 15))) {
-        unsigned int clr = dc->ir & (1 << 16);
+    if (clrset) {
+        bool clr = extract32(dc->ir, 16, 1);
 
         LOG_DIS("msr%s r%d imm=%x\n", clr ? "clr" : "set",
                 dc->rd, dc->imm);
-- 
2.14.1
