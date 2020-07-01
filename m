Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF1EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3CF2077D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3CF2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqevs-0002Al-OG
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqeuW-00011a-Np; Wed, 01 Jul 2020 11:44:32 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqeuS-0000Ov-8Y; Wed, 01 Jul 2020 11:44:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.656872-0.000448044-0.34268;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03310; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=8; SR=0; TI=SMTPD_---.HvvURjn_1593618255; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HvvURjn_1593618255)
 by smtp.aliyun-inc.com(10.147.40.233);
 Wed, 01 Jul 2020 23:44:15 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v12 09/61] target/riscv: add vector amo operations
Date: Wed,  1 Jul 2020 23:24:57 +0800
Message-Id: <20200701152549.1218-10-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200701152549.1218-1-zhiwei_liu@c-sky.com>
References: <20200701152549.1218-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 11:22:02
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: richard.henderson@linaro.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, Alistair Francis <alistair.francis@wdc.com>,
 palmer@dabbelt.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vector AMOs operate as if aq and rl bits were zero on each element
with regard to ordering relative to other instructions in the same hart.
Vector AMOs provide no ordering guarantee between element operations
in the same vector AMO instruction

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   |  29 +++++
 target/riscv/insn32-64.decode           |  11 ++
 target/riscv/insn32.decode              |  13 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 138 ++++++++++++++++++++++
 target/riscv/internals.h                |   1 +
 target/riscv/vector_helper.c            | 147 ++++++++++++++++++++++++
 6 files changed, 339 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 5c97bc446e..c5f43b5b64 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -246,3 +246,32 @@ DEF_HELPER_5(vlhuff_v_w, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vlhuff_v_d, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vlwuff_v_w, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vlwuff_v_d, void, ptr, ptr, tl, env, i32)
+#ifdef TARGET_RISCV64
+DEF_HELPER_6(vamoswapw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoswapd_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddd_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxorw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxord_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandd_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoorw_v_d,   void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoord_v_d,   void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomind_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxd_v_d,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominuw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominud_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxuw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxud_v_d, void, ptr, ptr, tl, ptr, env, i32)
+#endif
+DEF_HELPER_6(vamoswapw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxorw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoorw_v_w,   void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32-64.decode b/target/riscv/insn32-64.decode
index 380bf791bc..86153d93fa 100644
--- a/target/riscv/insn32-64.decode
+++ b/target/riscv/insn32-64.decode
@@ -57,6 +57,17 @@ amomax_d   10100 . . ..... ..... 011 ..... 0101111 @atom_st
 amominu_d  11000 . . ..... ..... 011 ..... 0101111 @atom_st
 amomaxu_d  11100 . . ..... ..... 011 ..... 0101111 @atom_st
 
+#*** Vector AMO operations (in addition to Zvamo) ***
+vamoswapd_v     00001 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoaddd_v      00000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoxord_v      00100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoandd_v      01100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoord_v       01000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamomind_v      10000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamomaxd_v      10100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamominud_v     11000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamomaxud_v     11100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+
 # *** RV64F Standard Extension (in addition to RV32F) ***
 fcvt_l_s   1100000  00010 ..... ... ..... 1010011 @r2_rm
 fcvt_lu_s  1100000  00011 ..... ... ..... 1010011 @r2_rm
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 7146aec22a..625914c85f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -44,6 +44,7 @@
 &u    imm rd
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
+&rwdvm     vm wd rd rs1 rs2
 &r2nfvm    vm rd rs1 nf
 &rnfvm     vm rd rs1 rs2 nf
 
@@ -67,6 +68,7 @@
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
+@r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
 @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -263,6 +265,17 @@ vsxh_v     ... -11 . ..... ..... 101 ..... 0100111 @r_nfvm
 vsxw_v     ... -11 . ..... ..... 110 ..... 0100111 @r_nfvm
 vsxe_v     ... -11 . ..... ..... 111 ..... 0100111 @r_nfvm
 
+#*** Vector AMO operations are encoded under the standard AMO major opcode ***
+vamoswapw_v     00001 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoaddw_v      00000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoxorw_v      00100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoandw_v      01100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoorw_v       01000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamominw_v      10000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamomaxw_v      10100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamominuw_v     11000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamomaxuw_v     11100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+
 # *** new major opcode OP-V ***
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 5e2fbb7078..768e95c8c4 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -634,3 +634,141 @@ GEN_VEXT_TRANS(vleff_v, 3, r2nfvm, ldff_op, ld_us_check)
 GEN_VEXT_TRANS(vlbuff_v, 4, r2nfvm, ldff_op, ld_us_check)
 GEN_VEXT_TRANS(vlhuff_v, 5, r2nfvm, ldff_op, ld_us_check)
 GEN_VEXT_TRANS(vlwuff_v, 6, r2nfvm, ldff_op, ld_us_check)
+
+/*
+ *** vector atomic operation
+ */
+typedef void gen_helper_amo(TCGv_ptr, TCGv_ptr, TCGv, TCGv_ptr,
+                            TCGv_env, TCGv_i32);
+
+static bool amo_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
+                      uint32_t data, gen_helper_amo *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask, index;
+    TCGv base;
+    TCGv_i32 desc;
+
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
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
+    gen_set_label(over);
+    return true;
+}
+
+static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_amo *fn;
+    static gen_helper_amo *const fnsw[9] = {
+        /* no atomic operation */
+        gen_helper_vamoswapw_v_w,
+        gen_helper_vamoaddw_v_w,
+        gen_helper_vamoxorw_v_w,
+        gen_helper_vamoandw_v_w,
+        gen_helper_vamoorw_v_w,
+        gen_helper_vamominw_v_w,
+        gen_helper_vamomaxw_v_w,
+        gen_helper_vamominuw_v_w,
+        gen_helper_vamomaxuw_v_w
+    };
+#ifdef TARGET_RISCV64
+    static gen_helper_amo *const fnsd[18] = {
+        gen_helper_vamoswapw_v_d,
+        gen_helper_vamoaddw_v_d,
+        gen_helper_vamoxorw_v_d,
+        gen_helper_vamoandw_v_d,
+        gen_helper_vamoorw_v_d,
+        gen_helper_vamominw_v_d,
+        gen_helper_vamomaxw_v_d,
+        gen_helper_vamominuw_v_d,
+        gen_helper_vamomaxuw_v_d,
+        gen_helper_vamoswapd_v_d,
+        gen_helper_vamoaddd_v_d,
+        gen_helper_vamoxord_v_d,
+        gen_helper_vamoandd_v_d,
+        gen_helper_vamoord_v_d,
+        gen_helper_vamomind_v_d,
+        gen_helper_vamomaxd_v_d,
+        gen_helper_vamominud_v_d,
+        gen_helper_vamomaxud_v_d
+    };
+#endif
+
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+        gen_helper_exit_atomic(cpu_env);
+        s->base.is_jmp = DISAS_NORETURN;
+        return true;
+    } else {
+        if (s->sew == 3) {
+#ifdef TARGET_RISCV64
+            fn = fnsd[seq];
+#else
+            /* Check done in amo_check(). */
+            g_assert_not_reached();
+#endif
+        } else {
+            fn = fnsw[seq];
+        }
+    }
+
+    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, WD, a->wd);
+    return amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+/*
+ * There are two rules check here.
+ *
+ * 1. SEW must be at least as wide as the AMO memory element size.
+ *
+ * 2. If SEW is greater than XLEN, an illegal instruction exception is raised.
+ */
+static bool amo_check(DisasContext *s, arg_rwdvm* a)
+{
+    return (!s->vill && has_ext(s, RVA) &&
+            (!a->wd || vext_check_overlap_mask(s, a->rd, a->vm, false)) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            ((1 << s->sew) <= sizeof(target_ulong)) &&
+            ((1 << s->sew) >= 4));
+}
+
+GEN_VEXT_TRANS(vamoswapw_v, 0, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoaddw_v, 1, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoxorw_v, 2, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoandw_v, 3, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoorw_v, 4, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominw_v, 5, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxw_v, 6, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominuw_v, 7, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxuw_v, 8, rwdvm, amo_op, amo_check)
+#ifdef TARGET_RISCV64
+GEN_VEXT_TRANS(vamoswapd_v, 9, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoaddd_v, 10, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoxord_v, 11, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoandd_v, 12, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoord_v, 13, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomind_v, 14, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxd_v, 15, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominud_v, 16, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
+#endif
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 3253e73474..e59e8b30ad 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -26,4 +26,5 @@ FIELD(VDATA, MLEN, 0, 8)
 FIELD(VDATA, VM, 8, 1)
 FIELD(VDATA, LMUL, 9, 2)
 FIELD(VDATA, NF, 11, 4)
+FIELD(VDATA, WD, 11, 1)
 #endif
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cbe87265a1..7c3b2bfd12 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -95,6 +95,11 @@ static inline uint32_t vext_lmul(uint32_t desc)
     return FIELD_EX32(simd_data(desc), VDATA, LMUL);
 }
 
+static uint32_t vext_wd(uint32_t desc)
+{
+    return (simd_data(desc) >> 11) & 0x1;
+}
+
 /*
  * Get vector group length in bytes. Its range is [64, 2048].
  *
@@ -687,3 +692,145 @@ GEN_VEXT_LDFF(vlhuff_v_w, uint16_t, uint32_t, ldhu_w, clearl)
 GEN_VEXT_LDFF(vlhuff_v_d, uint16_t, uint64_t, ldhu_d, clearq)
 GEN_VEXT_LDFF(vlwuff_v_w, uint32_t, uint32_t, ldwu_w, clearl)
 GEN_VEXT_LDFF(vlwuff_v_d, uint32_t, uint64_t, ldwu_d, clearq)
+
+/*
+ *** Vector AMO Operations (Zvamo)
+ */
+typedef void vext_amo_noatomic_fn(void *vs3, target_ulong addr,
+                                  uint32_t wd, uint32_t idx, CPURISCVState *env,
+                                  uintptr_t retaddr);
+
+/* no atomic opreation for vector atomic insructions */
+#define DO_SWAP(N, M) (M)
+#define DO_AND(N, M)  (N & M)
+#define DO_XOR(N, M)  (N ^ M)
+#define DO_OR(N, M)   (N | M)
+#define DO_ADD(N, M)  (N + M)
+
+#define GEN_VEXT_AMO_NOATOMIC_OP(NAME, ESZ, MSZ, H, DO_OP, SUF) \
+static void                                                     \
+vext_##NAME##_noatomic_op(void *vs3, target_ulong addr,         \
+                          uint32_t wd, uint32_t idx,            \
+                          CPURISCVState *env, uintptr_t retaddr)\
+{                                                               \
+    typedef int##ESZ##_t ETYPE;                                 \
+    typedef int##MSZ##_t MTYPE;                                 \
+    typedef uint##MSZ##_t UMTYPE __attribute__((unused));       \
+    ETYPE *pe3 = (ETYPE *)vs3 + H(idx);                         \
+    MTYPE  a = cpu_ld##SUF##_data(env, addr), b = *pe3;         \
+                                                                \
+    cpu_st##SUF##_data(env, addr, DO_OP(a, b));                 \
+    if (wd) {                                                   \
+        *pe3 = a;                                               \
+    }                                                           \
+}
+
+/* Signed min/max */
+#define DO_MAX(N, M)  ((N) >= (M) ? (N) : (M))
+#define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
+
+/* Unsigned min/max */
+#define DO_MAXU(N, M) DO_MAX((UMTYPE)N, (UMTYPE)M)
+#define DO_MINU(N, M) DO_MIN((UMTYPE)N, (UMTYPE)M)
+
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapw_v_w, 32, 32, H4, DO_SWAP, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddw_v_w,  32, 32, H4, DO_ADD,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorw_v_w,  32, 32, H4, DO_XOR,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandw_v_w,  32, 32, H4, DO_AND,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorw_v_w,   32, 32, H4, DO_OR,   l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominw_v_w,  32, 32, H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxw_v_w,  32, 32, H4, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuw_v_w, 32, 32, H4, DO_MINU, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuw_v_w, 32, 32, H4, DO_MAXU, l)
+#ifdef TARGET_RISCV64
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapw_v_d, 64, 32, H8, DO_SWAP, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapd_v_d, 64, 64, H8, DO_SWAP, q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddw_v_d,  64, 32, H8, DO_ADD,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddd_v_d,  64, 64, H8, DO_ADD,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorw_v_d,  64, 32, H8, DO_XOR,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxord_v_d,  64, 64, H8, DO_XOR,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandw_v_d,  64, 32, H8, DO_AND,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandd_v_d,  64, 64, H8, DO_AND,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorw_v_d,   64, 32, H8, DO_OR,   l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoord_v_d,   64, 64, H8, DO_OR,   q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominw_v_d,  64, 32, H8, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomind_v_d,  64, 64, H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxw_v_d,  64, 32, H8, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxd_v_d,  64, 64, H8, DO_MAX,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuw_v_d, 64, 32, H8, DO_MINU, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominud_v_d, 64, 64, H8, DO_MINU, q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuw_v_d, 64, 32, H8, DO_MAXU, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxud_v_d, 64, 64, H8, DO_MAXU, q)
+#endif
+
+static inline void
+vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
+                  void *vs2, CPURISCVState *env, uint32_t desc,
+                  vext_get_index_addr get_index_addr,
+                  vext_amo_noatomic_fn *noatomic_op,
+                  clear_fn *clear_elem,
+                  uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i;
+    target_long addr;
+    uint32_t wd = vext_wd(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        probe_pages(env, get_index_addr(base, i, vs2), msz, ra, MMU_DATA_LOAD);
+        probe_pages(env, get_index_addr(base, i, vs2), msz, ra, MMU_DATA_STORE);
+    }
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        addr = get_index_addr(base, i, vs2);
+        noatomic_op(vs3, addr, wd, i, env, ra);
+    }
+    clear_elem(vs3, env->vl, env->vl * esz, vlmax * esz);
+}
+
+#define GEN_VEXT_AMO(NAME, MTYPE, ETYPE, INDEX_FN, CLEAR_FN)    \
+void HELPER(NAME)(void *vs3, void *v0, target_ulong base,       \
+                  void *vs2, CPURISCVState *env, uint32_t desc) \
+{                                                               \
+    vext_amo_noatomic(vs3, v0, base, vs2, env, desc,            \
+                      INDEX_FN, vext_##NAME##_noatomic_op,      \
+                      CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE),   \
+                      GETPC());                                 \
+}
+
+#ifdef TARGET_RISCV64
+GEN_VEXT_AMO(vamoswapw_v_d, int32_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamoswapd_v_d, int64_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamoaddw_v_d,  int32_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamoaddd_v_d,  int64_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamoxorw_v_d,  int32_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamoxord_v_d,  int64_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamoandw_v_d,  int32_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamoandd_v_d,  int64_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamoorw_v_d,   int32_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamoord_v_d,   int64_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamominw_v_d,  int32_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamomind_v_d,  int64_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamomaxw_v_d,  int32_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamomaxd_v_d,  int64_t,  int64_t,  idx_d, clearq)
+GEN_VEXT_AMO(vamominuw_v_d, uint32_t, uint64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamominud_v_d, uint64_t, uint64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamomaxuw_v_d, uint32_t, uint64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamomaxud_v_d, uint64_t, uint64_t, idx_d, clearq)
+#endif
+GEN_VEXT_AMO(vamoswapw_v_w, int32_t,  int32_t,  idx_w, clearl)
+GEN_VEXT_AMO(vamoaddw_v_w,  int32_t,  int32_t,  idx_w, clearl)
+GEN_VEXT_AMO(vamoxorw_v_w,  int32_t,  int32_t,  idx_w, clearl)
+GEN_VEXT_AMO(vamoandw_v_w,  int32_t,  int32_t,  idx_w, clearl)
+GEN_VEXT_AMO(vamoorw_v_w,   int32_t,  int32_t,  idx_w, clearl)
+GEN_VEXT_AMO(vamominw_v_w,  int32_t,  int32_t,  idx_w, clearl)
+GEN_VEXT_AMO(vamomaxw_v_w,  int32_t,  int32_t,  idx_w, clearl)
+GEN_VEXT_AMO(vamominuw_v_w, uint32_t, uint32_t, idx_w, clearl)
+GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
-- 
2.23.0


