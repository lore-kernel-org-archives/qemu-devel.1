Received: from eggs.gnu.org ([2001:4830:134:3::10]:40639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AB-0001Mr-7I
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7A8-00024w-Oq
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:43 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:34790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7A8-00024Y-Jq
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:40 -0500
Received: by mail-pl0-x241.google.com with SMTP id bd10so3450169plb.1
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:02 -0800
Message-Id: <20180217182323.25885-47-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 46/67] target/arm: Implement SVE load and
 broadcast quadword
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  9 ++++++++
 2 files changed, 60 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index fda9a56fd5..7b21102b7e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3398,6 +3398,57 @@ static void trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
     trans_LD_zpri(s, a, insn);
 }
 
+static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
+{
+    static gen_helper_gvec_mem * const fns[4] = {
+        gen_helper_sve_ld1bb_r, gen_helper_sve_ld1hh_r,
+        gen_helper_sve_ld1ss_r, gen_helper_sve_ld1dd_r,
+    };
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr t_pg;
+    TCGv_i32 desc;
+
+    /* Load the first quadword using the normal predicated load helpers.  */
+    desc = tcg_const_i32(simd_desc(16, 16, zt));
+    t_pg = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
+    fns[msz](cpu_env, t_pg, addr, desc);
+
+    tcg_temp_free_ptr(t_pg);
+    tcg_temp_free_i32(desc);
+
+    /* Replicate that first quadword.  */
+    if (vsz > 16) {
+        unsigned dofs = vec_full_reg_offset(s, zt);
+        tcg_gen_gvec_dup_mem(4, dofs + 16, dofs, vsz - 16, vsz - 16);
+    }
+}
+
+static void trans_LD1RQ_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
+{
+    TCGv_i64 addr;
+    int msz = dtype_msz(a->dtype);
+
+    if (a->rm == 31) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    addr = new_tmp_a64(s);
+    tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), msz);
+    tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
+    do_ldrq(s, a->rd, a->pg, addr, msz);
+}
+
+static void trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
+{
+    TCGv_i64 addr = new_tmp_a64(s);
+
+    tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), a->imm * 16);
+    do_ldrq(s, a->rd, a->pg, addr, dtype_msz(a->dtype));
+}
+
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                       int msz, int esz, int nreg)
 {
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 41b8cd8746..6c906e25e9 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -723,6 +723,15 @@ LD_zprr		1010010 .. nreg:2 ..... 110 ... ..... .....	@rprr_load_msz
 # LD2B, LD2H, LD2W, LD2D; etc.
 LD_zpri		1010010 .. nreg:2 0.... 111 ... ..... .....	@rpri_load_msz
 
+# SVE load and broadcast quadword (scalar plus scalar)
+LD1RQ_zprr	1010010 .. 00 ..... 000 ... ..... ..... \
+		@rprr_load_msz nreg=0
+
+# SVE load and broadcast quadword (scalar plus immediate)
+# LD1RQB, LD1RQH, LD1RQS, LD1RQD
+LD1RQ_zpri	1010010 .. 00 0.... 001 ... ..... ..... \
+		@rpri_load_msz nreg=0
+
 ### SVE Memory Store Group
 
 # SVE contiguous store (scalar plus immediate)
-- 
2.14.3
