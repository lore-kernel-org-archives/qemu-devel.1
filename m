Received: from eggs.gnu.org ([2001:4830:134:3::10]:36899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcD6-0001QA-Af
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcD5-0003v2-A6
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:36 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcD4-0003uY-O5
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:35 -0400
Received: by mail-wm0-x22d.google.com with SMTP id l1-v6so39330946wmb.2
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:34 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:45 +0200
Message-Id: <20180529105011.1914-13-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 12/38] target-microblaze: Remove pointer
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
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 2a4546ec3d..ee17334959 100644
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
         /* If any of the regs is r0, set t to the value of the other reg.  */
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
