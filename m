Received: from eggs.gnu.org ([2001:4830:134:3::10]:39146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVonf-0003zF-GI
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVone-0002yc-JI
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:15 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:41725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVone-0002xp-DW
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:14 -0400
Received: by mail-pf0-x234.google.com with SMTP id a11-v6so683565pff.8
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:28 -1000
Message-Id: <20180621015359.12018-5-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 04/35] target/arm: Implement SVE load and
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
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 52 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  9 +++++++
 2 files changed, 61 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b25fe96b77..83de87ee0e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3717,6 +3717,58 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
     return true;
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
+static bool trans_LD1RQ_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
+{
+    if (a->rm == 31) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        int msz = dtype_msz(a->dtype);
+        TCGv_i64 addr = new_tmp_a64(s);
+        tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), msz);
+        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
+        do_ldrq(s, a->rd, a->pg, addr, msz);
+    }
+    return true;
+}
+
+static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        TCGv_i64 addr = new_tmp_a64(s);
+        tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), a->imm * 16);
+        do_ldrq(s, a->rd, a->pg, addr, dtype_msz(a->dtype));
+    }
+    return true;
+}
+
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                       int msz, int esz, int nreg)
 {
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 6e159faaec..606c4f623c 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -715,6 +715,15 @@ LD_zprr         1010010 .. nreg:2 ..... 110 ... ..... .....     @rprr_load_msz
 # LD2B, LD2H, LD2W, LD2D; etc.
 LD_zpri         1010010 .. nreg:2 0.... 111 ... ..... .....     @rpri_load_msz
 
+# SVE load and broadcast quadword (scalar plus scalar)
+LD1RQ_zprr      1010010 .. 00 ..... 000 ... ..... ..... \
+                @rprr_load_msz nreg=0
+
+# SVE load and broadcast quadword (scalar plus immediate)
+# LD1RQB, LD1RQH, LD1RQS, LD1RQD
+LD1RQ_zpri      1010010 .. 00 0.... 001 ... ..... ..... \
+                @rpri_load_msz nreg=0
+
 ### SVE Memory Store Group
 
 # SVE contiguous store (scalar plus immediate)
-- 
2.17.1
