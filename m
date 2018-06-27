Received: from eggs.gnu.org ([2001:4830:134:3::10]:60349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29N-0004BP-RW
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29K-0000N7-VW
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:49 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29K-0000LW-H7
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:46 -0400
Received: by mail-pg0-x241.google.com with SMTP id i7-v6so366597pgp.2
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:33:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:03 -0700
Message-Id: <20180627043328.11531-11-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 10/35] target/arm: Implement SVE store
 vector/predicate register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v6: Fix shift of data in 6 byte store.
---
 target/arm/translate-sve.c | 103 +++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |   6 +++
 2 files changed, 109 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 954d6653d3..4116fe9904 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3762,6 +3762,89 @@ static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
     tcg_temp_free_i64(t0);
 }
 
+/* Similarly for stores.  */
+static void do_str(DisasContext *s, uint32_t vofs, uint32_t len,
+                   int rn, int imm)
+{
+    uint32_t len_align = QEMU_ALIGN_DOWN(len, 8);
+    uint32_t len_remain = len % 8;
+    uint32_t nparts = len / 8 + ctpop8(len_remain);
+    int midx = get_mem_index(s);
+    TCGv_i64 addr, t0;
+
+    addr = tcg_temp_new_i64();
+    t0 = tcg_temp_new_i64();
+
+    /* Note that unpredicated load/store of vector/predicate registers
+     * are defined as a stream of bytes, which equates to little-endian
+     * operations on larger quantities.  There is no nice way to force
+     * a little-endian store for aarch64_be-linux-user out of line.
+     *
+     * Attempt to keep code expansion to a minimum by limiting the
+     * amount of unrolling done.
+     */
+    if (nparts <= 4) {
+        int i;
+
+        for (i = 0; i < len_align; i += 8) {
+            tcg_gen_ld_i64(t0, cpu_env, vofs + i);
+            tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + i);
+            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEQ);
+        }
+    } else {
+        TCGLabel *loop = gen_new_label();
+        TCGv_ptr t2, i = tcg_const_local_ptr(0);
+
+        gen_set_label(loop);
+
+        t2 = tcg_temp_new_ptr();
+        tcg_gen_add_ptr(t2, cpu_env, i);
+        tcg_gen_ld_i64(t0, t2, vofs);
+
+        /* Minimize the number of local temps that must be re-read from
+         * the stack each iteration.  Instead, re-compute values other
+         * than the loop counter.
+         */
+        tcg_gen_addi_ptr(t2, i, imm);
+        tcg_gen_extu_ptr_i64(addr, t2);
+        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, rn));
+        tcg_temp_free_ptr(t2);
+
+        tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEQ);
+
+        tcg_gen_addi_ptr(i, i, 8);
+
+        tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
+        tcg_temp_free_ptr(i);
+    }
+
+    /* Predicate register stores can be any multiple of 2.  */
+    if (len_remain) {
+        tcg_gen_ld_i64(t0, cpu_env, vofs + len_align);
+        tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + len_align);
+
+        switch (len_remain) {
+        case 2:
+        case 4:
+        case 8:
+            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LE | ctz32(len_remain));
+            break;
+
+        case 6:
+            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUL);
+            tcg_gen_addi_i64(addr, addr, 4);
+            tcg_gen_shri_i64(t0, t0, 32);
+            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUW);
+            break;
+
+        default:
+            g_assert_not_reached();
+        }
+    }
+    tcg_temp_free_i64(addr);
+    tcg_temp_free_i64(t0);
+}
+
 static bool trans_LDR_zri(DisasContext *s, arg_rri *a, uint32_t insn)
 {
     if (sve_access_check(s)) {
@@ -3782,6 +3865,26 @@ static bool trans_LDR_pri(DisasContext *s, arg_rri *a, uint32_t insn)
     return true;
 }
 
+static bool trans_STR_zri(DisasContext *s, arg_rri *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        int size = vec_full_reg_size(s);
+        int off = vec_full_reg_offset(s, a->rd);
+        do_str(s, off, size, a->rn, a->imm * size);
+    }
+    return true;
+}
+
+static bool trans_STR_pri(DisasContext *s, arg_rri *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        int size = pred_full_reg_size(s);
+        int off = pred_full_reg_offset(s, a->rd);
+        do_str(s, off, size, a->rn, a->imm * size);
+    }
+    return true;
+}
+
 /*
  *** SVE Memory - Contiguous Load Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 765e7e479b..6a76010f51 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -793,6 +793,12 @@ LD1RQ_zpri      1010010 .. 00 0.... 001 ... ..... ..... \
 
 ### SVE Memory Store Group
 
+# SVE store predicate register
+STR_pri         1110010 11 0.     ..... 000 ... ..... 0 ....    @pd_rn_i9
+
+# SVE store vector register
+STR_zri         1110010 11 0.     ..... 010 ... ..... .....     @rd_rn_i9
+
 # SVE contiguous store (scalar plus immediate)
 # ST1B, ST1H, ST1W, ST1D; require msz <= esz
 ST_zpri         1110010 .. esz:2  0.... 111 ... ..... ..... \
-- 
2.17.1
