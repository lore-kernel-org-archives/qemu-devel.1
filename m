Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDECC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7658320733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7658320733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j13k7-0004ei-N1
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 02:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j13iy-0002r8-1R
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j13iu-00059E-Tm
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:43:19 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j13it-0004fO-LZ; Mon, 10 Feb 2020 02:43:16 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.360181-0.0298022-0.610016;
 DS=CONTINUE|ham_system_inform|0.731082-0.000239082-0.268679;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16368; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GmNZEYU_1581320582; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GmNZEYU_1581320582)
 by smtp.aliyun-inc.com(10.147.41.158);
 Mon, 10 Feb 2020 15:43:06 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 5/5] target/riscv: add vector amo operations
Date: Mon, 10 Feb 2020 15:42:56 +0800
Message-Id: <20200210074256.11412-6-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200210074256.11412-1-zhiwei_liu@c-sky.com>
References: <20200210074256.11412-1-zhiwei_liu@c-sky.com>
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vector AMOs operate as if aq and rl bits were zero on each element
with regard to ordering relative to other instructions in the same hart.
Vector AMOs provide no ordering guarantee between element operations
in the same vector AMO instruction

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  57 +++++
 target/riscv/insn32-64.decode           |  11 +
 target/riscv/insn32.decode              |  13 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 167 ++++++++++++++
 target/riscv/vector_helper.c            | 292 ++++++++++++++++++++++++
 5 files changed, 540 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 893dfc0fb8..3624a20262 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -240,3 +240,60 @@ DEF_HELPER_5(vlhuff_v_w_mask, void, ptr, tl, ptr, env, i32)
 DEF_HELPER_5(vlhuff_v_d_mask, void, ptr, tl, ptr, env, i32)
 DEF_HELPER_5(vlwuff_v_w_mask, void, ptr, tl, ptr, env, i32)
 DEF_HELPER_5(vlwuff_v_d_mask, void, ptr, tl, ptr, env, i32)
+#ifdef TARGET_RISCV64
+DEF_HELPER_6(vamoswapw_v_d_a_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoswapd_v_d_a_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoaddw_v_d_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoaddd_v_d_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoxorw_v_d_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoxord_v_d_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoandw_v_d_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoandd_v_d_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoorw_v_d_a_mask,   void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoord_v_d_a_mask,   void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamominw_v_d_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomind_v_d_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxw_v_d_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxd_v_d_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamominuw_v_d_a_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamominud_v_d_a_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxuw_v_d_a_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxud_v_d_a_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoswapw_v_d_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoswapd_v_d_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoaddw_v_d_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoaddd_v_d_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoxorw_v_d_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoxord_v_d_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoandw_v_d_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoandd_v_d_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoorw_v_d_mask,   void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoord_v_d_mask,   void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamominw_v_d_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomind_v_d_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxw_v_d_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxd_v_d_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamominuw_v_d_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamominud_v_d_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxuw_v_d_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxud_v_d_mask, void, ptr, tl, ptr, ptr, env, i32)
+#endif
+DEF_HELPER_6(vamoswapw_v_w_a_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoaddw_v_w_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoxorw_v_w_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoandw_v_w_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoorw_v_w_a_mask,   void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamominw_v_w_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxw_v_w_a_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamominuw_v_w_a_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxuw_v_w_a_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoswapw_v_w_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoaddw_v_w_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoxorw_v_w_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoandw_v_w_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamoorw_v_w_mask,   void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamominw_v_w_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxw_v_w_mask,  void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamominuw_v_w_mask, void, ptr, tl, ptr, ptr, env, i32)
+DEF_HELPER_6(vamomaxuw_v_w_mask, void, ptr, tl, ptr, ptr, env, i32)
+
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
index 973ac63fda..077551dd13 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -43,6 +43,7 @@
 &u    imm rd
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
+&rwdvm     vm wd rd rs1 rs2
 &r2nfvm    vm rd rs1 nf
 &rnfvm     vm rd rs1 rs2 nf
 
@@ -64,6 +65,7 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
 @r2_nfvm nf:3 ... vm:1 ..... ..... ... ..... ....... &r2nfvm %rs1 %rd
 @r_nfvm  nf:3 ... vm:1 ..... ..... ... ..... ....... &rnfvm %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
@@ -259,6 +261,17 @@ vsuxh_v    ... 111 . ..... ..... 101 ..... 0100111 @r_nfvm
 vsuxw_v    ... 111 . ..... ..... 110 ..... 0100111 @r_nfvm
 vsuxe_v    ... 111 . ..... ..... 111 ..... 0100111 @r_nfvm
 
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
index 66caa16d18..f628e16346 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -751,3 +751,170 @@ GEN_VEXT_LDFF_TRANS(vleff_v, vext_ldff_trans, 3)
 GEN_VEXT_LDFF_TRANS(vlbuff_v, vext_ldff_trans, 4)
 GEN_VEXT_LDFF_TRANS(vlhuff_v, vext_ldff_trans, 5)
 GEN_VEXT_LDFF_TRANS(vlwuff_v, vext_ldff_trans, 6)
+
+/* vector atomic operation */
+typedef void gen_helper_vext_amo(TCGv_ptr, TCGv, TCGv_ptr, TCGv_ptr,
+        TCGv_env, TCGv_i32);
+
+static bool do_vext_amo_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
+        uint32_t data, gen_helper_vext_amo *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask, index;
+    TCGv base;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    index = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, maxsz_part1(s->maxsz), data));
+
+    gen_get_gpr(base, rs1);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(index, cpu_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, base, mask, index, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free_ptr(index);
+    tcg_temp_free(base);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool vext_amo_trans(DisasContext *s, arg_rwdvm *a, uint8_t seq)
+{
+    uint32_t data = s->mlen | (a->vm << 8) | (maxsz_part2(s->maxsz) << 9)
+        | (a->wd << 12);
+    gen_helper_vext_amo *fn;
+#ifdef TARGET_RISCV64
+    static gen_helper_vext_amo *const fns[2][18][2] = {
+        /* atomic operation */
+        { { gen_helper_vamoswapw_v_w_a_mask, gen_helper_vamoswapw_v_d_a_mask },
+          { gen_helper_vamoaddw_v_w_a_mask,  gen_helper_vamoaddw_v_d_a_mask },
+          { gen_helper_vamoxorw_v_w_a_mask,  gen_helper_vamoxorw_v_d_a_mask },
+          { gen_helper_vamoandw_v_w_a_mask,  gen_helper_vamoandw_v_d_a_mask },
+          { gen_helper_vamoorw_v_w_a_mask,   gen_helper_vamoorw_v_d_a_mask },
+          { gen_helper_vamominw_v_w_a_mask,  gen_helper_vamominw_v_d_a_mask },
+          { gen_helper_vamomaxw_v_w_a_mask,  gen_helper_vamomaxw_v_d_a_mask },
+          { gen_helper_vamominuw_v_w_a_mask, gen_helper_vamominuw_v_d_a_mask },
+          { gen_helper_vamomaxuw_v_w_a_mask, gen_helper_vamomaxuw_v_d_a_mask },
+          { NULL,                            gen_helper_vamoswapd_v_d_a_mask },
+          { NULL,                            gen_helper_vamoaddd_v_d_a_mask },
+          { NULL,                            gen_helper_vamoxord_v_d_a_mask },
+          { NULL,                            gen_helper_vamoandd_v_d_a_mask },
+          { NULL,                            gen_helper_vamoord_v_d_a_mask },
+          { NULL,                            gen_helper_vamomind_v_d_a_mask },
+          { NULL,                            gen_helper_vamomaxd_v_d_a_mask },
+          { NULL,                            gen_helper_vamominud_v_d_a_mask },
+          { NULL,                           gen_helper_vamomaxud_v_d_a_mask } },
+        /* no atomic operation */
+        { { gen_helper_vamoswapw_v_w_mask, gen_helper_vamoswapw_v_d_mask },
+          { gen_helper_vamoaddw_v_w_mask,  gen_helper_vamoaddw_v_d_mask },
+          { gen_helper_vamoxorw_v_w_mask,  gen_helper_vamoxorw_v_d_mask },
+          { gen_helper_vamoandw_v_w_mask,  gen_helper_vamoandw_v_d_mask },
+          { gen_helper_vamoorw_v_w_mask,   gen_helper_vamoorw_v_d_mask },
+          { gen_helper_vamominw_v_w_mask,  gen_helper_vamominw_v_d_mask },
+          { gen_helper_vamomaxw_v_w_mask,  gen_helper_vamomaxw_v_d_mask },
+          { gen_helper_vamominuw_v_w_mask, gen_helper_vamominuw_v_d_mask },
+          { gen_helper_vamomaxuw_v_w_mask, gen_helper_vamomaxuw_v_d_mask },
+          { NULL,                          gen_helper_vamoswapd_v_d_mask },
+          { NULL,                          gen_helper_vamoaddd_v_d_mask },
+          { NULL,                          gen_helper_vamoxord_v_d_mask },
+          { NULL,                          gen_helper_vamoandd_v_d_mask },
+          { NULL,                          gen_helper_vamoord_v_d_mask },
+          { NULL,                          gen_helper_vamomind_v_d_mask },
+          { NULL,                          gen_helper_vamomaxd_v_d_mask },
+          { NULL,                          gen_helper_vamominud_v_d_mask },
+          { NULL,                          gen_helper_vamomaxud_v_d_mask } }
+    };
+#else
+    static gen_helper_vext_amo *const fns[2][9][2] = {
+        /* atomic operation */
+        { { gen_helper_vamoswapw_v_w_a_mask, NULL },
+          { gen_helper_vamoaddw_v_w_a_mask,  NULL },
+          { gen_helper_vamoxorw_v_w_a_mask,  NULL },
+          { gen_helper_vamoandw_v_w_a_mask,  NULL },
+          { gen_helper_vamoorw_v_w_a_mask,   NULL },
+          { gen_helper_vamominw_v_w_a_mask,  NULL },
+          { gen_helper_vamomaxw_v_w_a_mask,  NULL },
+          { gen_helper_vamominuw_v_w_a_mask, NULL },
+          { gen_helper_vamomaxuw_v_w_a_mask, NULL } },
+        /* no atomic operation */
+        { { gen_helper_vamoswapw_v_w_mask, NULL },
+          { gen_helper_vamoaddw_v_w_mask,  NULL },
+          { gen_helper_vamoxorw_v_w_mask,  NULL },
+          { gen_helper_vamoandw_v_w_mask,  NULL },
+          { gen_helper_vamoorw_v_w_mask,   NULL },
+          { gen_helper_vamominw_v_w_mask,  NULL },
+          { gen_helper_vamomaxw_v_w_mask,  NULL },
+          { gen_helper_vamominuw_v_w_mask, NULL },
+          { gen_helper_vamomaxuw_v_w_mask, NULL } }
+    };
+#endif
+    if (s->sew < 2) {
+        return false;
+    }
+
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+#ifdef CONFIG_ATOMIC64
+        fn = fns[0][seq][s->sew - 2];
+#else
+        gen_helper_exit_atomic(cpu_env);
+        s->base.is_jmp = DISAS_NORETURN;
+        return true;
+#endif
+    } else {
+        fn = fns[1][seq][s->sew - 2];
+    }
+    if (fn == NULL) {
+        return false;
+    }
+
+    return do_vext_amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+#define GEN_VEXT_AMO_TRANS(NAME, DO_OP, SEQ)                              \
+static bool trans_##NAME(DisasContext *s, arg_rwdvm* a)                   \
+{                                                                         \
+    vchkctx.check_misa = RVV | RVA;                                       \
+    if (a->wd) {                                                          \
+        vchkctx.check_overlap_mask.need_check = true;                     \
+        vchkctx.check_overlap_mask.reg = a->rd;                           \
+        vchkctx.check_overlap_mask.vm = a->vm;                            \
+    }                                                                     \
+    vchkctx.check_reg[0].need_check = true;                               \
+    vchkctx.check_reg[0].reg = a->rd;                                     \
+    vchkctx.check_reg[0].widen = false;                                   \
+    vchkctx.check_reg[1].need_check = true;                               \
+    vchkctx.check_reg[1].reg = a->rs2;                                    \
+    vchkctx.check_reg[1].widen = false;                                   \
+                                                                          \
+    if (!vext_check(s)) {                                                 \
+        return false;                                                     \
+    }                                                                     \
+    return DO_OP(s, a, SEQ);                                              \
+}
+
+GEN_VEXT_AMO_TRANS(vamoswapw_v, vext_amo_trans, 0)
+GEN_VEXT_AMO_TRANS(vamoaddw_v, vext_amo_trans, 1)
+GEN_VEXT_AMO_TRANS(vamoxorw_v, vext_amo_trans, 2)
+GEN_VEXT_AMO_TRANS(vamoandw_v, vext_amo_trans, 3)
+GEN_VEXT_AMO_TRANS(vamoorw_v, vext_amo_trans, 4)
+GEN_VEXT_AMO_TRANS(vamominw_v, vext_amo_trans, 5)
+GEN_VEXT_AMO_TRANS(vamomaxw_v, vext_amo_trans, 6)
+GEN_VEXT_AMO_TRANS(vamominuw_v, vext_amo_trans, 7)
+GEN_VEXT_AMO_TRANS(vamomaxuw_v, vext_amo_trans, 8)
+#ifdef TARGET_RISCV64
+GEN_VEXT_AMO_TRANS(vamoswapd_v, vext_amo_trans, 9)
+GEN_VEXT_AMO_TRANS(vamoaddd_v, vext_amo_trans, 10)
+GEN_VEXT_AMO_TRANS(vamoxord_v, vext_amo_trans, 11)
+GEN_VEXT_AMO_TRANS(vamoandd_v, vext_amo_trans, 12)
+GEN_VEXT_AMO_TRANS(vamoord_v, vext_amo_trans,  13)
+GEN_VEXT_AMO_TRANS(vamomind_v, vext_amo_trans, 14)
+GEN_VEXT_AMO_TRANS(vamomaxd_v, vext_amo_trans, 15)
+GEN_VEXT_AMO_TRANS(vamominud_v, vext_amo_trans, 16)
+GEN_VEXT_AMO_TRANS(vamomaxud_v, vext_amo_trans, 17)
+#endif
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 941851ab28..d6f1585c40 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -102,6 +102,11 @@ static uint32_t vext_vm(uint32_t desc)
     return (simd_data(desc) >> 8) & 0x1;
 }
 
+static uint32_t vext_wd(uint32_t desc)
+{
+    return (simd_data(desc) >> 12) & 0x1;
+}
+
 /*
  * Get vector group length [64, 2048] in bytes. Its range is [64, 2048].
  *
@@ -174,6 +179,21 @@ static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
     memset(tail, 0, tot - cnt);
 }
 #endif
+
+static void vext_clearl(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int32_t *cur = ((int32_t *)vd + H4(idx));
+    vext_clear(cur, cnt, tot);
+}
+
+#ifdef TARGET_RISCV64
+static void vext_clearq(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int64_t *cur = (int64_t *)vd + idx;
+    vext_clear(cur, cnt, tot);
+}
+#endif
+
 /* common structure for all vector instructions */
 struct vext_common_ctx {
     uint32_t vlmax;
@@ -1006,3 +1026,275 @@ GEN_VEXT_LDFF(vlhuff_v_w, uint16_t, uint32_t, MO_LEUW)
 GEN_VEXT_LDFF(vlhuff_v_d, uint16_t, uint64_t, MO_LEUW)
 GEN_VEXT_LDFF(vlwuff_v_w, uint32_t, uint32_t, MO_LEUL)
 GEN_VEXT_LDFF(vlwuff_v_d, uint32_t, uint64_t, MO_LEUL)
+
+/* Vector AMO Operations (Zvamo) */
+/* data structure and common functions for load and store */
+typedef void vext_amo_noatomic_fn(void *vs3, target_ulong addr,
+        uint32_t wd, uint32_t idx, CPURISCVState *env, uintptr_t retaddr);
+typedef void vext_amo_atomic_fn(void *vs3, target_ulong addr,
+        uint32_t wd, uint32_t idx, CPURISCVState *env);
+
+struct vext_amo_ctx {
+    struct vext_common_ctx vcc;
+    uint32_t wd;
+    target_ulong base;
+
+    vext_get_index_addr *get_index_addr;
+    vext_amo_atomic_fn *atomic_op;
+    vext_amo_noatomic_fn *noatomic_op;
+    vext_ld_clear_elem *clear_elem;
+};
+
+#ifdef TARGET_RISCV64
+GEN_VEXT_GET_INDEX_ADDR(vamoswapw_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamoswapd_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamoaddw_v_d,  int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamoaddd_v_d,  int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamoxorw_v_d,  int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamoxord_v_d,  int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamoandw_v_d,  int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamoandd_v_d,  int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamoorw_v_d,   int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamoord_v_d,   int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamominw_v_d,  int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamomind_v_d,  int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamomaxw_v_d,  int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamomaxd_v_d,  int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamominuw_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamominud_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamomaxuw_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vamomaxud_v_d, int64_t, H8)
+#endif
+GEN_VEXT_GET_INDEX_ADDR(vamoswapw_v_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vamoaddw_v_w,  int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vamoxorw_v_w,  int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vamoandw_v_w,  int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vamoorw_v_w,   int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vamominw_v_w,  int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vamomaxw_v_w,  int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vamominuw_v_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vamomaxuw_v_w, int32_t, H4)
+
+/* no atomic opreation for vector atomic insructions */
+#define DO_SWAP(N, M) (M)
+#define DO_AND(N, M)  (N & M)
+#define DO_XOR(N, M)  (N ^ M)
+#define DO_OR(N, M)   (N | M)
+#define DO_ADD(N, M)  (N + M)
+#define DO_MAX(N, M)  ((N) >= (M) ? (N) : (M))
+#define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
+
+#define GEN_VEXT_AMO_NOATOMIC_OP(NAME, ETYPE, MTYPE, H, DO_OP, SUF)      \
+static void vext_##NAME##_noatomic_op(void *vs3, target_ulong addr,      \
+        uint32_t wd, uint32_t idx, CPURISCVState *env, uintptr_t retaddr)\
+{                                                                        \
+    ETYPE ret;                                                           \
+    target_ulong tmp;                                                    \
+    int mmu_idx = cpu_mmu_index(env, false);                             \
+    tmp = cpu_ld##SUF##_mmuidx_ra(env, addr, mmu_idx, retaddr);          \
+    ret = DO_OP((ETYPE)(MTYPE)tmp, *((ETYPE *)vs3 + H(idx)));            \
+    cpu_st##SUF##_mmuidx_ra(env, addr, ret, mmu_idx, retaddr);           \
+    if (wd) {                                                            \
+        *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \
+    }                                                                    \
+}
+
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapw_v_w, int32_t,  int32_t, H4, DO_SWAP, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddw_v_w,  int32_t,  int32_t, H4, DO_ADD,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorw_v_w,  int32_t,  int32_t, H4, DO_XOR,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandw_v_w,  int32_t,  int32_t, H4, DO_AND,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorw_v_w,   int32_t,  int32_t, H4, DO_OR,   l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominw_v_w,  int32_t,  int32_t, H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxw_v_w,  int32_t,  int32_t, H4, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuw_v_w, uint32_t, int32_t, H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuw_v_w, uint32_t, int32_t, H4, DO_MAX,  l)
+#ifdef TARGET_RISCV64
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapw_v_d, int64_t,  int32_t, H8, DO_SWAP, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapd_v_d, int64_t,  int64_t, H8, DO_SWAP, q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddw_v_d,  int64_t,  int32_t, H8, DO_ADD,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddd_v_d,  int64_t,  int64_t, H8, DO_ADD,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorw_v_d,  int64_t,  int32_t, H8, DO_XOR,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxord_v_d,  int64_t,  int64_t, H8, DO_XOR,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandw_v_d,  int64_t,  int32_t, H8, DO_AND,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandd_v_d,  int64_t,  int64_t, H8, DO_AND,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorw_v_d,   int64_t,  int32_t, H8, DO_OR,   l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoord_v_d,   int64_t,  int64_t, H8, DO_OR,   q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominw_v_d,  int64_t,  int32_t, H8, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomind_v_d,  int64_t,  int64_t, H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxw_v_d,  int64_t,  int32_t, H8, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxd_v_d,  int64_t,  int64_t, H8, DO_MAX,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuw_v_d, uint64_t, int32_t, H8, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominud_v_d, uint64_t, int64_t, H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuw_v_d, uint64_t, int32_t, H8, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxud_v_d, uint64_t, int64_t, H8, DO_MAX,  q)
+#endif
+
+/* atomic opreation for vector atomic insructions */
+#ifndef CONFIG_USER_ONLY
+#define GEN_VEXT_ATOMIC_OP(NAME, ETYPE, MTYPE, MOFLAG, H, AMO)           \
+static void vext_##NAME##_atomic_op(void *vs3, target_ulong addr,        \
+        uint32_t wd, uint32_t idx, CPURISCVState *env)                   \
+{                                                                        \
+    target_ulong tmp;                                                    \
+    int mem_idx = cpu_mmu_index(env, false);                             \
+    tmp = helper_atomic_##AMO##_le(env, addr, *((ETYPE *)vs3 + H(idx)),  \
+            make_memop_idx(MO_ALIGN | MOFLAG, mem_idx));                 \
+    if (wd) {                                                            \
+        *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \
+    }                                                                    \
+}
+#else
+#define GEN_VEXT_ATOMIC_OP(NAME, ETYPE, MTYPE, MOFLAG, H, AMO)           \
+static void vext_##NAME##_atomic_op(void *vs3, target_ulong addr,        \
+        uint32_t wd, uint32_t idx, CPURISCVState *env)                   \
+{                                                                        \
+    target_ulong tmp;                                                    \
+    tmp = helper_atomic_##AMO##_le(env, addr, *((ETYPE *)vs3 + H(idx))); \
+    if (wd) {                                                            \
+        *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \
+    }                                                                    \
+}
+#endif
+
+GEN_VEXT_ATOMIC_OP(vamoswapw_v_w, int32_t,  int32_t,  MO_TESL, H4, xchgl)
+GEN_VEXT_ATOMIC_OP(vamoaddw_v_w,  int32_t,  int32_t,  MO_TESL, H4, fetch_addl)
+GEN_VEXT_ATOMIC_OP(vamoxorw_v_w,  int32_t,  int32_t,  MO_TESL, H4, fetch_xorl)
+GEN_VEXT_ATOMIC_OP(vamoandw_v_w,  int32_t,  int32_t,  MO_TESL, H4, fetch_andl)
+GEN_VEXT_ATOMIC_OP(vamoorw_v_w,   int32_t,  int32_t,  MO_TESL, H4, fetch_orl)
+GEN_VEXT_ATOMIC_OP(vamominw_v_w,  int32_t,  int32_t,  MO_TESL, H4, fetch_sminl)
+GEN_VEXT_ATOMIC_OP(vamomaxw_v_w,  int32_t,  int32_t,  MO_TESL, H4, fetch_smaxl)
+GEN_VEXT_ATOMIC_OP(vamominuw_v_w, uint32_t, int32_t,  MO_TEUL, H4, fetch_uminl)
+GEN_VEXT_ATOMIC_OP(vamomaxuw_v_w, uint32_t, int32_t,  MO_TEUL, H4, fetch_umaxl)
+#ifdef TARGET_RISCV64
+GEN_VEXT_ATOMIC_OP(vamoswapw_v_d, int64_t,  int32_t,  MO_TESL, H8, xchgl)
+GEN_VEXT_ATOMIC_OP(vamoswapd_v_d, int64_t,  int64_t,  MO_TEQ,  H8, xchgq)
+GEN_VEXT_ATOMIC_OP(vamoaddw_v_d,  int64_t,  int32_t,  MO_TESL, H8, fetch_addl)
+GEN_VEXT_ATOMIC_OP(vamoaddd_v_d,  int64_t,  int64_t,  MO_TEQ,  H8, fetch_addq)
+GEN_VEXT_ATOMIC_OP(vamoxorw_v_d,  int64_t,  int32_t,  MO_TESL, H8, fetch_xorl)
+GEN_VEXT_ATOMIC_OP(vamoxord_v_d,  int64_t,  int64_t,  MO_TEQ,  H8, fetch_xorq)
+GEN_VEXT_ATOMIC_OP(vamoandw_v_d,  int64_t,  int32_t,  MO_TESL, H8, fetch_andl)
+GEN_VEXT_ATOMIC_OP(vamoandd_v_d,  int64_t,  int64_t,  MO_TEQ,  H8, fetch_andq)
+GEN_VEXT_ATOMIC_OP(vamoorw_v_d,   int64_t,  int32_t,  MO_TESL, H8, fetch_orl)
+GEN_VEXT_ATOMIC_OP(vamoord_v_d,   int64_t,  int64_t,  MO_TEQ,  H8, fetch_orq)
+GEN_VEXT_ATOMIC_OP(vamominw_v_d,  int64_t,  int32_t,  MO_TESL, H8, fetch_sminl)
+GEN_VEXT_ATOMIC_OP(vamomind_v_d,  int64_t,  int64_t,  MO_TEQ,  H8, fetch_sminq)
+GEN_VEXT_ATOMIC_OP(vamomaxw_v_d,  int64_t,  int32_t,  MO_TESL, H8, fetch_smaxl)
+GEN_VEXT_ATOMIC_OP(vamomaxd_v_d,  int64_t,  int64_t,  MO_TEQ,  H8, fetch_smaxq)
+GEN_VEXT_ATOMIC_OP(vamominuw_v_d, uint64_t, int32_t,  MO_TEUL, H8, fetch_uminl)
+GEN_VEXT_ATOMIC_OP(vamominud_v_d, uint64_t, int64_t,  MO_TEQ,  H8, fetch_uminq)
+GEN_VEXT_ATOMIC_OP(vamomaxuw_v_d, uint64_t, int32_t,  MO_TEUL, H8, fetch_umaxl)
+GEN_VEXT_ATOMIC_OP(vamomaxud_v_d, uint64_t, int64_t,  MO_TEQ,  H8, fetch_umaxq)
+#endif
+
+static void vext_amo_atomic_mask(void *vs3, void *vs2, void *v0,
+        CPURISCVState *env, struct vext_amo_ctx *ctx, uintptr_t ra)
+{
+    uint32_t i;
+    target_long addr;
+    struct vext_common_ctx *s = &ctx->vcc;
+
+    for (i = 0; i < s->vl; i++) {
+        if (!s->vm && !vext_elem_mask(v0, s->mlen, i)) {
+            continue;
+        }
+        probe_read_access(env, ctx->get_index_addr(ctx->base, i, vs2),
+                s->msz, ra);
+        probe_write_access(env, ctx->get_index_addr(ctx->base, i, vs2),
+                s->msz, ra);
+    }
+    for (i = 0; i < env->vext.vl; i++) {
+        if (!s->vm && !vext_elem_mask(v0, s->mlen, i)) {
+            continue;
+        }
+        addr = ctx->get_index_addr(ctx->base, i, vs2);
+        ctx->atomic_op(vs3, addr, ctx->wd, i, env);
+    }
+    ctx->clear_elem(vs3, s->vl, s->vl * s->esz, s->vlmax * s->esz);
+}
+
+static void vext_amo_noatomic_mask(void *vs3, void *vs2, void *v0,
+        CPURISCVState *env, struct vext_amo_ctx *ctx, uintptr_t ra)
+{
+    uint32_t i;
+    target_long addr;
+    struct vext_common_ctx *s = &ctx->vcc;
+
+    for (i = 0; i < s->vl; i++) {
+        if (!s->vm && !vext_elem_mask(v0, s->mlen, i)) {
+            continue;
+        }
+        probe_read_access(env, ctx->get_index_addr(ctx->base, i, vs2),
+                s->msz, ra);
+        probe_write_access(env, ctx->get_index_addr(ctx->base, i, vs2),
+                s->msz, ra);
+    }
+    for (i = 0; i < s->vl; i++) {
+        if (!s->vm && !vext_elem_mask(v0, s->mlen, i)) {
+            continue;
+        }
+        addr = ctx->get_index_addr(ctx->base, i, vs2);
+        ctx->noatomic_op(vs3, addr, ctx->wd, i, env, ra);
+    }
+    ctx->clear_elem(vs3, s->vl, s->vl * s->esz, s->vlmax * s->esz);
+}
+
+#define GEN_VEXT_AMO(NAME, MTYPE, ETYPE, CLEAR_FN)                    \
+void HELPER(NAME##_a_mask)(void *vs3, target_ulong base, void *v0,    \
+        void *vs2, CPURISCVState *env, uint32_t desc)                 \
+{                                                                     \
+    static struct vext_amo_ctx ctx;                                   \
+    vext_common_ctx_init(&ctx.vcc, sizeof(ETYPE),                     \
+        sizeof(MTYPE), env->vext.vl, desc);                           \
+    ctx.wd = vext_wd(desc);                                           \
+    ctx.base = base;                                                  \
+    ctx.atomic_op = vext_##NAME##_atomic_op;                          \
+    ctx.get_index_addr = vext_##NAME##_get_addr;                      \
+    ctx.clear_elem = CLEAR_FN;                                        \
+                                                                      \
+    vext_amo_atomic_mask(vs3, vs2, v0, env, &ctx, GETPC());           \
+}                                                                     \
+                                                                      \
+void HELPER(NAME##_mask)(void *vs3, target_ulong base, void *v0,      \
+        void *vs2, CPURISCVState *env, uint32_t desc)                 \
+{                                                                     \
+    static struct vext_amo_ctx ctx;                                   \
+    vext_common_ctx_init(&ctx.vcc, sizeof(ETYPE),                     \
+        sizeof(MTYPE), env->vext.vl, desc);                           \
+    ctx.wd = vext_wd(desc);                                           \
+    ctx.base = base;                                                  \
+    ctx.noatomic_op = vext_##NAME##_noatomic_op;                      \
+    ctx.get_index_addr = vext_##NAME##_get_addr;                      \
+    ctx.clear_elem = CLEAR_FN;                                        \
+                                                                      \
+    vext_amo_noatomic_mask(vs3, vs2, v0, env, &ctx, GETPC());         \
+}
+
+#ifdef TARGET_RISCV64
+GEN_VEXT_AMO(vamoswapw_v_d, int32_t,  int64_t, vext_clearq)
+GEN_VEXT_AMO(vamoswapd_v_d, int64_t, int64_t, vext_clearq)
+GEN_VEXT_AMO(vamoaddw_v_d,  int32_t,  int64_t, vext_clearq)
+GEN_VEXT_AMO(vamoaddd_v_d,  int64_t, int64_t, vext_clearq)
+GEN_VEXT_AMO(vamoxorw_v_d,  int32_t,  int64_t, vext_clearq)
+GEN_VEXT_AMO(vamoxord_v_d,  int64_t, int64_t, vext_clearq)
+GEN_VEXT_AMO(vamoandw_v_d,  int32_t,  int64_t, vext_clearq)
+GEN_VEXT_AMO(vamoandd_v_d,  int64_t, int64_t, vext_clearq)
+GEN_VEXT_AMO(vamoorw_v_d,   int32_t,  int64_t, vext_clearq)
+GEN_VEXT_AMO(vamoord_v_d,   int64_t, int64_t, vext_clearq)
+GEN_VEXT_AMO(vamominw_v_d,  int32_t,  int64_t, vext_clearq)
+GEN_VEXT_AMO(vamomind_v_d,  int64_t, int64_t, vext_clearq)
+GEN_VEXT_AMO(vamomaxw_v_d,  int32_t,  int64_t, vext_clearq)
+GEN_VEXT_AMO(vamomaxd_v_d,  int64_t, int64_t, vext_clearq)
+GEN_VEXT_AMO(vamominuw_v_d, uint32_t,  uint64_t, vext_clearq)
+GEN_VEXT_AMO(vamominud_v_d, uint64_t, uint64_t, vext_clearq)
+GEN_VEXT_AMO(vamomaxuw_v_d, uint32_t, uint64_t, vext_clearq)
+GEN_VEXT_AMO(vamomaxud_v_d, uint64_t, uint64_t, vext_clearq)
+#endif
+GEN_VEXT_AMO(vamoswapw_v_w, int32_t, int32_t, vext_clearl)
+GEN_VEXT_AMO(vamoaddw_v_w,  int32_t, int32_t, vext_clearl)
+GEN_VEXT_AMO(vamoxorw_v_w,  int32_t, int32_t, vext_clearl)
+GEN_VEXT_AMO(vamoandw_v_w,  int32_t, int32_t, vext_clearl)
+GEN_VEXT_AMO(vamoorw_v_w,   int32_t, int32_t, vext_clearl)
+GEN_VEXT_AMO(vamominw_v_w,  int32_t, int32_t, vext_clearl)
+GEN_VEXT_AMO(vamomaxw_v_w,  int32_t, int32_t, vext_clearl)
+GEN_VEXT_AMO(vamominuw_v_w, uint32_t, uint32_t, vext_clearl)
+GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, vext_clearl)
-- 
2.23.0


