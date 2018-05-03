Received: from eggs.gnu.org ([2001:4830:134:3::10]:55115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAP0-0000w5-32
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOw-00053y-48
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:50 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:46727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAOv-00053S-Sb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:46 -0400
Received: by mail-lf0-x243.google.com with SMTP id v85-v6so24888137lfa.13
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:19:45 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:19:05 +0200
Message-Id: <20180503091922.28733-13-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-1-edgar.iglesias@gmail.com>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 12/29] target-microblaze: Remove pointer
 indirection for ld/st addresses
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

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index daed0b7e1f..5cc53eb035 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -848,7 +848,7 @@ static void dec_imm(DisasContext *dc)
     dc->clear_imm = 0;
 }
 
-static inline void compute_ldst_addr(DisasContext *dc, TCGv_i32 *t)
+static inline void compute_ldst_addr(DisasContext *dc, TCGv_i32 t)
 {
     bool extimm = dc->tb_flags & IMM_FLAG;
     /* Should be set to true if r1 is used by loadstores.  */
@@ -863,10 +863,10 @@ static inline void compute_ldst_addr(DisasContext *dc, TCGv_i32 *t)
     if (!dc->type_b) {
         /* If any of the regs is r0, return the value of the other reg.  */
         if (dc->ra == 0) {
-            tcg_gen_mov_i32(*t, cpu_R[dc->rb]);
+            tcg_gen_mov_i32(t, cpu_R[dc->rb]);
             return;
         } else if (dc->rb == 0) {
-            tcg_gen_mov_i32(*t, cpu_R[dc->ra]);
+            tcg_gen_mov_i32(t, cpu_R[dc->ra]);
             return;
         }
 
@@ -874,27 +874,27 @@ static inline void compute_ldst_addr(DisasContext *dc, TCGv_i32 *t)
             stackprot = true;
         }
 
-        tcg_gen_add_i32(*t, cpu_R[dc->ra], cpu_R[dc->rb]);
+        tcg_gen_add_i32(t, cpu_R[dc->ra], cpu_R[dc->rb]);
 
         if (stackprot) {
-            gen_helper_stackprot(cpu_env, *t);
+            gen_helper_stackprot(cpu_env, t);
         }
         return;
     }
     /* Immediate.  */
     if (!extimm) {
         if (dc->imm == 0) {
-            tcg_gen_mov_i32(*t, cpu_R[dc->ra]);
+            tcg_gen_mov_i32(t, cpu_R[dc->ra]);
             return;
         }
-        tcg_gen_movi_i32(*t, (int32_t)((int16_t)dc->imm));
-        tcg_gen_add_i32(*t, cpu_R[dc->ra], *t);
+        tcg_gen_movi_i32(t, (int32_t)((int16_t)dc->imm));
+        tcg_gen_add_i32(t, cpu_R[dc->ra], t);
     } else {
-        tcg_gen_add_i32(*t, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
+        tcg_gen_add_i32(t, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
     }
 
     if (stackprot) {
-        gen_helper_stackprot(cpu_env, *t);
+        gen_helper_stackprot(cpu_env, t);
     }
     return;
 }
@@ -929,7 +929,7 @@ static void dec_load(DisasContext *dc)
 
     t_sync_flags(dc);
     addr = tcg_temp_new_i32();
-    compute_ldst_addr(dc, &addr);
+    compute_ldst_addr(dc, addr);
 
     /*
      * When doing reverse accesses we need to do two things.
@@ -1041,7 +1041,7 @@ static void dec_store(DisasContext *dc)
     sync_jmpstate(dc);
     /* SWX needs a temp_local.  */
     addr = ex ? tcg_temp_local_new_i32() : tcg_temp_new_i32();
-    compute_ldst_addr(dc, &addr);
+    compute_ldst_addr(dc, addr);
 
     if (ex) { /* swx */
         TCGv_i32 tval;
-- 
2.14.1
