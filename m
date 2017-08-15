Received: from eggs.gnu.org ([2001:4830:134:3::10]:34183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhdHX-0005Ip-TF
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhdHV-0004J1-84
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:23 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:33136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dhdHV-0004IL-06
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:21 -0400
Received: by mail-pg0-x22d.google.com with SMTP id u5so7130791pgn.0
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 07:57:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 15 Aug 2017 07:57:13 -0700
Message-Id: <20170815145714.17635-3-richard.henderson@linaro.org>
In-Reply-To: <20170815145714.17635-1-richard.henderson@linaro.org>
References: <20170815145714.17635-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 for-2.10 2/3] target/arm: Correct load
 exclusive pair atomicity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alistair.francis@xilinx.com, edgar.iglesias@xilinx.com

We are not providing the required single-copy atomic semantics for
the 64-bit operation that is the 32-bit paired load.

At the same time, leave the entire 64-bit value in cpu_exclusive_val
and stop writing to cpu_exclusive_high.  This means that we do not
have to re-assemble the 64-bit quantity when it comes time to store.

At the same time, drop a redundant temporary and perform all loads
directly into the cpu_exclusive_* globals.

Tested-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 60 ++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 113e2e172b..eac545e4f2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1853,29 +1853,42 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
 static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
                                TCGv_i64 addr, int size, bool is_pair)
 {
-    TCGv_i64 tmp = tcg_temp_new_i64();
-    TCGMemOp memop = s->be_data + size;
+    int idx = get_mem_index(s);
+    TCGMemOp memop = s->be_data;
 
     g_assert(size <= 3);
-    tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s), memop);
-
     if (is_pair) {
-        TCGv_i64 addr2 = tcg_temp_new_i64();
-        TCGv_i64 hitmp = tcg_temp_new_i64();
-
         g_assert(size >= 2);
-        tcg_gen_addi_i64(addr2, addr, 1 << size);
-        tcg_gen_qemu_ld_i64(hitmp, addr2, get_mem_index(s), memop);
-        tcg_temp_free_i64(addr2);
-        tcg_gen_mov_i64(cpu_exclusive_high, hitmp);
-        tcg_gen_mov_i64(cpu_reg(s, rt2), hitmp);
-        tcg_temp_free_i64(hitmp);
-    }
+        if (size == 2) {
+            /* The pair must be single-copy atomic for the doubleword.  */
+            memop |= MO_64;
+            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
+            if (s->be_data == MO_LE) {
+                tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 0, 32);
+                tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 32, 32);
+            } else {
+                tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 32, 32);
+                tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 0, 32);
+            }
+        } else {
+            /* The pair must be single-copy atomic for *each* doubleword,
+               but not the entire quadword.  */
+            memop |= MO_64;
+            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
 
-    tcg_gen_mov_i64(cpu_exclusive_val, tmp);
-    tcg_gen_mov_i64(cpu_reg(s, rt), tmp);
+            TCGv_i64 addr2 = tcg_temp_new_i64();
+            tcg_gen_addi_i64(addr2, addr, 8);
+            tcg_gen_qemu_ld_i64(cpu_exclusive_high, addr2, idx, memop);
+            tcg_temp_free_i64(addr2);
 
-    tcg_temp_free_i64(tmp);
+            tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
+            tcg_gen_mov_i64(cpu_reg(s, rt2), cpu_exclusive_high);
+        }
+    } else {
+        memop |= size;
+        tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
+        tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
+    }
     tcg_gen_mov_i64(cpu_exclusive_addr, addr);
 }
 
@@ -1908,14 +1921,15 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
     tmp = tcg_temp_new_i64();
     if (is_pair) {
         if (size == 2) {
-            TCGv_i64 val = tcg_temp_new_i64();
-            tcg_gen_concat32_i64(tmp, cpu_reg(s, rt), cpu_reg(s, rt2));
-            tcg_gen_concat32_i64(val, cpu_exclusive_val, cpu_exclusive_high);
-            tcg_gen_atomic_cmpxchg_i64(tmp, addr, val, tmp,
+            if (s->be_data == MO_LE) {
+                tcg_gen_concat32_i64(tmp, cpu_reg(s, rt), cpu_reg(s, rt2));
+            } else {
+                tcg_gen_concat32_i64(tmp, cpu_reg(s, rt2), cpu_reg(s, rt));
+            }
+            tcg_gen_atomic_cmpxchg_i64(tmp, addr, cpu_exclusive_val, tmp,
                                        get_mem_index(s),
                                        MO_64 | MO_ALIGN | s->be_data);
-            tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, val);
-            tcg_temp_free_i64(val);
+            tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
         } else if (s->be_data == MO_LE) {
             gen_helper_paired_cmpxchg64_le(tmp, cpu_env, addr, cpu_reg(s, rt),
                                            cpu_reg(s, rt2));
-- 
2.13.4
