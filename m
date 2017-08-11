Received: from eggs.gnu.org ([2001:4830:134:3::10]:45178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dgEaN-0000Cz-MB
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dgEaM-0007UI-D5
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:23:03 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 11 Aug 2017 11:19:24 -0700
Message-ID: <2fbcf76e4ff63d8527edd3662342948276e2cd37.1502474835.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1502474835.git.alistair.francis@xilinx.com>
References: <cover.1502474835.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 3/3] target/arm: Correct exclusive store
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, qemu-arm@nongnu.org

The exclusive store operation should return 0 if the operation updates
memory and 1 if it doesn't. This means that storing tmp in the rd
register is incorrect.

This patch updates the succesful opertion to store 0 into the rd
register instead of tmp. It also adds a branch to fail if the memory
isn't updated.

In order to add a branch for the pair case when size equals 2 we first
need to apply the same memory operation on the exclusive value in order
for the comparison to work.

There is still no value checks added if we are doing a 64-bit store with
pairs.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
This was caught with an internal fuzzy tester. These patches fix the
Xilinx 2.10-rc2 tree. I tested with the fuzzy tester (single CPU) and
Linux boot (4 CPUs) on the Xilinx tree. I don't have a good test case to
run on mainline at the moment, but I'm working on getting one. Also
linux-user is fully untested.

All tests were with MTTCG enabled.

 target/arm/translate-a64.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 245175e2f1..ea7c61bc6f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1894,10 +1894,11 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
      * }
      * env->exclusive_addr = -1;
      */
+    TCGMemOp memop = size | MO_ALIGN | s->be_data;
     TCGLabel *fail_label = gen_new_label();
     TCGLabel *done_label = gen_new_label();
     TCGv_i64 addr = tcg_temp_local_new_i64();
-    TCGv_i64 tmp;
+    TCGv_i64 tmp, val;
 
     /* Copy input into a local temp so it is not trashed when the
      * basic block ends at the branch insn.
@@ -1907,15 +1908,15 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
 
     tmp = tcg_temp_new_i64();
     if (is_pair) {
+        val = tcg_temp_new_i64();
         if (size == 2) {
-            TCGv_i64 val = tcg_temp_new_i64();
             tcg_gen_concat32_i64(tmp, cpu_reg(s, rt), cpu_reg(s, rt2));
             tcg_gen_concat32_i64(val, cpu_exclusive_val, cpu_exclusive_high);
             tcg_gen_atomic_cmpxchg_i64(tmp, addr, val, tmp,
                                        get_mem_index(s),
-                                       size | MO_ALIGN | s->be_data);
-            tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, val);
-            tcg_temp_free_i64(val);
+                                       memop);
+            tcg_gen_ext_i64(val, val, memop);
+            tcg_gen_brcond_i64(TCG_COND_NE, tmp, val, fail_label);
         } else if (s->be_data == MO_LE) {
             gen_helper_paired_cmpxchg64_le(tmp, cpu_env, addr, cpu_reg(s, rt),
                                            cpu_reg(s, rt2));
@@ -1924,22 +1925,23 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
                                            cpu_reg(s, rt2));
         }
     } else {
-        TCGv_i64 val = cpu_reg(s, rt);
+        val = cpu_reg(s, rt);
         tcg_gen_atomic_cmpxchg_i64(tmp, addr, cpu_exclusive_val, val,
                                    get_mem_index(s),
-                                   size | MO_ALIGN | s->be_data);
-        tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
+                                   memop);
+        tcg_gen_brcond_i64(TCG_COND_NE, tmp, cpu_exclusive_val, fail_label);
     }
 
     tcg_temp_free_i64(addr);
 
-    tcg_gen_mov_i64(cpu_reg(s, rd), tmp);
-    tcg_temp_free_i64(tmp);
+    tcg_gen_movi_i64(cpu_reg(s, rd), 0);
     tcg_gen_br(done_label);
 
     gen_set_label(fail_label);
     tcg_gen_movi_i64(cpu_reg(s, rd), 1);
     gen_set_label(done_label);
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i64(val);
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
 }
 
-- 
2.11.0
