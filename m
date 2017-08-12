Received: from eggs.gnu.org ([2001:4830:134:3::10]:54464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dgZ84-0003CX-2W
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 12:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dgZ80-000173-2v
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 12:19:12 -0400
From: Richard Henderson <rth7680@gmail.com>
Date: Sat, 12 Aug 2017 09:19:03 -0700
Message-Id: <20170812161903.8622-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Avoid an extra temporary for
 store_exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Instead of copying addr to a local temp, reuse the value (which we
have just compared as equal) already saved in cpu_exclusive_addr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f3643ac8dc..f3a1b1cecc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1896,7 +1896,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
 }
 
 static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
-                                TCGv_i64 inaddr, int size, int is_pair)
+                                TCGv_i64 addr, int size, int is_pair)
 {
     /* if (env->exclusive_addr == addr && env->exclusive_val == [addr]
      *     && (!is_pair || env->exclusive_high == [addr + datasize])) {
@@ -1912,13 +1912,8 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
      */
     TCGLabel *fail_label = gen_new_label();
     TCGLabel *done_label = gen_new_label();
-    TCGv_i64 addr = tcg_temp_local_new_i64();
     TCGv_i64 tmp;
 
-    /* Copy input into a local temp so it is not trashed when the
-     * basic block ends at the branch insn.
-     */
-    tcg_gen_mov_i64(addr, inaddr);
     tcg_gen_brcond_i64(TCG_COND_NE, addr, cpu_exclusive_addr, fail_label);
 
     tmp = tcg_temp_new_i64();
@@ -1929,27 +1924,24 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
             } else {
                 tcg_gen_concat32_i64(tmp, cpu_reg(s, rt2), cpu_reg(s, rt));
             }
-            tcg_gen_atomic_cmpxchg_i64(tmp, addr, cpu_exclusive_val, tmp,
+            tcg_gen_atomic_cmpxchg_i64(tmp, cpu_exclusive_addr,
+                                       cpu_exclusive_val, tmp,
                                        get_mem_index(s),
                                        MO_64 | MO_ALIGN | s->be_data);
             tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
         } else if (s->be_data == MO_LE) {
-            gen_helper_paired_cmpxchg64_le(tmp, cpu_env, addr, cpu_reg(s, rt),
-                                           cpu_reg(s, rt2));
+            gen_helper_paired_cmpxchg64_le(tmp, cpu_env, cpu_exclusive_addr,
+                                           cpu_reg(s, rt), cpu_reg(s, rt2));
         } else {
-            gen_helper_paired_cmpxchg64_be(tmp, cpu_env, addr, cpu_reg(s, rt),
-                                           cpu_reg(s, rt2));
+            gen_helper_paired_cmpxchg64_be(tmp, cpu_env, cpu_exclusive_addr,
+                                           cpu_reg(s, rt), cpu_reg(s, rt2));
         }
     } else {
-        TCGv_i64 val = cpu_reg(s, rt);
-        tcg_gen_atomic_cmpxchg_i64(tmp, addr, cpu_exclusive_val, val,
-                                   get_mem_index(s),
+        tcg_gen_atomic_cmpxchg_i64(tmp, cpu_exclusive_addr, cpu_exclusive_val,
+                                   cpu_reg(s, rt), get_mem_index(s),
                                    size | MO_ALIGN | s->be_data);
         tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
     }
-
-    tcg_temp_free_i64(addr);
-
     tcg_gen_mov_i64(cpu_reg(s, rd), tmp);
     tcg_temp_free_i64(tmp);
     tcg_gen_br(done_label);
-- 
2.13.4
