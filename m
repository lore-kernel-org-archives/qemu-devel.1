Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6F5C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C0420674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C0420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCPXi-000487-31
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCPUo-0005sT-5L
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCPUl-0006Bu-PL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:11:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCPUk-00064m-Ou; Thu, 12 Mar 2020 11:11:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.146023-0.00653716-0.84744;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03268; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-NijjU_1584025878; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-NijjU_1584025878)
 by smtp.aliyun-inc.com(10.147.44.129);
 Thu, 12 Mar 2020 23:11:19 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 06/60] target/riscv: add vector index load and store
 instructions
Date: Thu, 12 Mar 2020 22:58:06 +0800
Message-Id: <20200312145900.2054-7-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: guoren@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vector indexed operations add the contents of each element of the
vector offset operand specified by vs2 to the base effective address
to give the effective address of each element.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  35 +++++++
 target/riscv/insn32.decode              |  13 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 124 ++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 117 ++++++++++++++++++++++
 4 files changed, 289 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 87dfa90609..f9b3da60ca 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -183,3 +183,38 @@ DEF_HELPER_6(vsse_v_b, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse_v_h, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse_v_w, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlxb_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxb_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxb_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxb_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxh_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxh_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxh_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxhu_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxhu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxhu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxwu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxwu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxh_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxh_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxh_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index ef521152c5..bc36df33b5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -241,6 +241,19 @@ vssh_v     ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
 vssw_v     ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
 vsse_v     ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
 
+vlxb_v     ... 111 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlxh_v     ... 111 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlxw_v     ... 111 . ..... ..... 110 ..... 0000111 @r_nfvm
+vlxe_v     ... 011 . ..... ..... 111 ..... 0000111 @r_nfvm
+vlxbu_v    ... 011 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlxhu_v    ... 011 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlxwu_v    ... 011 . ..... ..... 110 ..... 0000111 @r_nfvm
+# Vector ordered-indexed and unordered-indexed store insns.
+vsxb_v     ... -11 . ..... ..... 000 ..... 0100111 @r_nfvm
+vsxh_v     ... -11 . ..... ..... 101 ..... 0100111 @r_nfvm
+vsxw_v     ... -11 . ..... ..... 110 ..... 0100111 @r_nfvm
+vsxe_v     ... -11 . ..... ..... 111 ..... 0100111 @r_nfvm
+
 # *** new major opcode OP-V ***
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index d85f2aec68..5d1eeef323 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -407,3 +407,127 @@ GEN_VEXT_TRANS(vssb_v, 0, rnfvm, st_stride_op, st_stride_check)
 GEN_VEXT_TRANS(vssh_v, 1, rnfvm, st_stride_op, st_stride_check)
 GEN_VEXT_TRANS(vssw_v, 2, rnfvm, st_stride_op, st_stride_check)
 GEN_VEXT_TRANS(vsse_v, 3, rnfvm, st_stride_op, st_stride_check)
+
+/*
+ *** index load and store
+ */
+typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr, TCGv,
+        TCGv_ptr, TCGv_env, TCGv_i32);
+
+static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
+        uint32_t data, gen_helper_ldst_index *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask, index;
+    TCGv base;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    index = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    gen_get_gpr(base, rs1);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(index, cpu_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, base, index, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free_ptr(index);
+    tcg_temp_free(base);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_index *fn;
+    static gen_helper_ldst_index * const fns[7][4] = {
+        { gen_helper_vlxb_v_b,  gen_helper_vlxb_v_h,
+          gen_helper_vlxb_v_w,  gen_helper_vlxb_v_d },
+        { NULL,                 gen_helper_vlxh_v_h,
+          gen_helper_vlxh_v_w,  gen_helper_vlxh_v_d },
+        { NULL,                 NULL,
+          gen_helper_vlxw_v_w,  gen_helper_vlxw_v_d },
+        { gen_helper_vlxe_v_b,  gen_helper_vlxe_v_h,
+          gen_helper_vlxe_v_w,  gen_helper_vlxe_v_d },
+        { gen_helper_vlxbu_v_b, gen_helper_vlxbu_v_h,
+          gen_helper_vlxbu_v_w, gen_helper_vlxbu_v_d },
+        { NULL,                 gen_helper_vlxhu_v_h,
+          gen_helper_vlxhu_v_w, gen_helper_vlxhu_v_d },
+        { NULL,                 NULL,
+          gen_helper_vlxwu_v_w, gen_helper_vlxwu_v_d },
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool ld_index_check(DisasContext *s, arg_rnfvm* a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vlxb_v, 0, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxh_v, 1, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxw_v, 2, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxe_v, 3, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxbu_v, 4, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxhu_v, 5, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxwu_v, 6, rnfvm, ld_index_op, ld_index_check)
+
+static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_index *fn;
+    static gen_helper_ldst_index * const fns[4][4] = {
+        { gen_helper_vsxb_v_b,  gen_helper_vsxb_v_h,
+          gen_helper_vsxb_v_w,  gen_helper_vsxb_v_d },
+        { NULL,                 gen_helper_vsxh_v_h,
+          gen_helper_vsxh_v_w,  gen_helper_vsxh_v_d },
+        { NULL,                 NULL,
+          gen_helper_vsxw_v_w,  gen_helper_vsxw_v_d },
+        { gen_helper_vsxe_v_b,  gen_helper_vsxe_v_h,
+          gen_helper_vsxe_v_w,  gen_helper_vsxe_v_d }
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool st_index_check(DisasContext *s, arg_rnfvm* a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vsxb_v, 0, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxh_v, 1, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxw_v, 2, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxe_v, 3, rnfvm, st_index_op, st_index_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ebfabd2946..35cb9f09b4 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -457,3 +457,120 @@ GEN_VEXT_ST_US(vse_v_b, int8_t,  int8_t , ste_b)
 GEN_VEXT_ST_US(vse_v_h, int16_t, int16_t, ste_h)
 GEN_VEXT_ST_US(vse_v_w, int32_t, int32_t, ste_w)
 GEN_VEXT_ST_US(vse_v_d, int64_t, int64_t, ste_d)
+
+/*
+ *** index: access vector element from indexed memory
+ */
+typedef target_ulong (*vext_get_index_addr)(target_ulong base,
+        uint32_t idx, void *vs2);
+
+#define GEN_VEXT_GET_INDEX_ADDR(NAME, ETYPE, H)        \
+static target_ulong NAME(target_ulong base,            \
+        uint32_t idx, void *vs2)                       \
+{                                                      \
+    return (base + *((ETYPE *)vs2 + H(idx)));          \
+}
+
+GEN_VEXT_GET_INDEX_ADDR(idx_b, int8_t,  H1)
+GEN_VEXT_GET_INDEX_ADDR(idx_h, int16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(idx_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(idx_d, int64_t, H8)
+
+static inline void vext_ldst_index(void *vd, void *v0, target_ulong base,
+        void *vs2, CPURISCVState *env, uint32_t desc,
+        vext_get_index_addr get_index_addr,
+        vext_ldst_elem_fn ldst_elem,
+        vext_ld_clear_elem clear_elem,
+        uint32_t esz, uint32_t msz, uintptr_t ra,
+        MMUAccessType access_type)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    if (env->vl == 0) {
+        return;
+    }
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        probe_pages(env, get_index_addr(base, i, vs2), nf * msz, ra,
+                access_type);
+    }
+    /* load bytes from guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            abi_ptr addr = get_index_addr(base, i, vs2) + k * msz;
+            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    if (clear_elem) {
+        for (k = 0; k < nf; k++) {
+            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+        }
+    }
+}
+
+#define GEN_VEXT_LD_INDEX(NAME, MTYPE, ETYPE, INDEX_FN, LOAD_FN, CLEAR_FN) \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                   \
+        void *vs2, CPURISCVState *env, uint32_t desc)                      \
+{                                                                          \
+    vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,                \
+        LOAD_FN, CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE),                   \
+        GETPC(), MMU_DATA_LOAD);                                           \
+}
+GEN_VEXT_LD_INDEX(vlxb_v_b,  int8_t,   int8_t,   idx_b, ldb_b,  clearb)
+GEN_VEXT_LD_INDEX(vlxb_v_h,  int8_t,   int16_t,  idx_h, ldb_h,  clearh)
+GEN_VEXT_LD_INDEX(vlxb_v_w,  int8_t,   int32_t,  idx_w, ldb_w,  clearl)
+GEN_VEXT_LD_INDEX(vlxb_v_d,  int8_t,   int64_t,  idx_d, ldb_d,  clearq)
+GEN_VEXT_LD_INDEX(vlxh_v_h,  int16_t,  int16_t,  idx_h, ldh_h,  clearh)
+GEN_VEXT_LD_INDEX(vlxh_v_w,  int16_t,  int32_t,  idx_w, ldh_w,  clearl)
+GEN_VEXT_LD_INDEX(vlxh_v_d,  int16_t,  int64_t,  idx_d, ldh_d,  clearq)
+GEN_VEXT_LD_INDEX(vlxw_v_w,  int32_t,  int32_t,  idx_w, ldw_w,  clearl)
+GEN_VEXT_LD_INDEX(vlxw_v_d,  int32_t,  int64_t,  idx_d, ldw_d,  clearq)
+GEN_VEXT_LD_INDEX(vlxe_v_b,  int8_t,   int8_t,   idx_b, lde_b,  clearb)
+GEN_VEXT_LD_INDEX(vlxe_v_h,  int16_t,  int16_t,  idx_h, lde_h,  clearh)
+GEN_VEXT_LD_INDEX(vlxe_v_w,  int32_t,  int32_t,  idx_w, lde_w,  clearl)
+GEN_VEXT_LD_INDEX(vlxe_v_d,  int64_t,  int64_t,  idx_d, lde_d,  clearq)
+GEN_VEXT_LD_INDEX(vlxbu_v_b, uint8_t,  uint8_t,  idx_b, ldbu_b, clearb)
+GEN_VEXT_LD_INDEX(vlxbu_v_h, uint8_t,  uint16_t, idx_h, ldbu_h, clearh)
+GEN_VEXT_LD_INDEX(vlxbu_v_w, uint8_t,  uint32_t, idx_w, ldbu_w, clearl)
+GEN_VEXT_LD_INDEX(vlxbu_v_d, uint8_t,  uint64_t, idx_d, ldbu_d, clearq)
+GEN_VEXT_LD_INDEX(vlxhu_v_h, uint16_t, uint16_t, idx_h, ldhu_h, clearh)
+GEN_VEXT_LD_INDEX(vlxhu_v_w, uint16_t, uint32_t, idx_w, ldhu_w, clearl)
+GEN_VEXT_LD_INDEX(vlxhu_v_d, uint16_t, uint64_t, idx_d, ldhu_d, clearq)
+GEN_VEXT_LD_INDEX(vlxwu_v_w, uint32_t, uint32_t, idx_w, ldwu_w, clearl)
+GEN_VEXT_LD_INDEX(vlxwu_v_d, uint32_t, uint64_t, idx_d, ldwu_d, clearq)
+
+#define GEN_VEXT_ST_INDEX(NAME, MTYPE, ETYPE, INDEX_FN, STORE_FN)\
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
+        void *vs2, CPURISCVState *env, uint32_t desc)            \
+{                                                                \
+    vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,      \
+        STORE_FN, NULL, sizeof(ETYPE), sizeof(MTYPE),            \
+        GETPC(), MMU_DATA_STORE);                                \
+}
+
+GEN_VEXT_ST_INDEX(vsxb_v_b, int8_t,  int8_t,  idx_b, stb_b)
+GEN_VEXT_ST_INDEX(vsxb_v_h, int8_t,  int16_t, idx_h, stb_h)
+GEN_VEXT_ST_INDEX(vsxb_v_w, int8_t,  int32_t, idx_w, stb_w)
+GEN_VEXT_ST_INDEX(vsxb_v_d, int8_t,  int64_t, idx_d, stb_d)
+GEN_VEXT_ST_INDEX(vsxh_v_h, int16_t, int16_t, idx_h, sth_h)
+GEN_VEXT_ST_INDEX(vsxh_v_w, int16_t, int32_t, idx_w, sth_w)
+GEN_VEXT_ST_INDEX(vsxh_v_d, int16_t, int64_t, idx_d, sth_d)
+GEN_VEXT_ST_INDEX(vsxw_v_w, int32_t, int32_t, idx_w, stw_w)
+GEN_VEXT_ST_INDEX(vsxw_v_d, int32_t, int64_t, idx_d, stw_d)
+GEN_VEXT_ST_INDEX(vsxe_v_b, int8_t,  int8_t,  idx_b, ste_b)
+GEN_VEXT_ST_INDEX(vsxe_v_h, int16_t, int16_t, idx_h, ste_h)
+GEN_VEXT_ST_INDEX(vsxe_v_w, int32_t, int32_t, idx_w, ste_w)
+GEN_VEXT_ST_INDEX(vsxe_v_d, int64_t, int64_t, idx_d, ste_d)
-- 
2.23.0


