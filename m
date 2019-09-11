Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE0DECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D142089F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D142089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wMW-0000NN-Ut
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDg-0007AW-79
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDW-0007pK-5M
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:12 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDU-0007lQ-E2; Wed, 11 Sep 2019 02:35:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.259867-0.00419391-0.735939; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03276; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRSzSU_1568183695; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRSzSU_1568183695)
 by smtp.aliyun-inc.com(10.147.41.178);
 Wed, 11 Sep 2019 14:34:55 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:32 +0800
Message-Id: <1568183141-67641-9-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 08/17] RISC-V: add vector extension integer
 instructions part1, add/sub/adc/sbc
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |   36 +
 target/riscv/insn32.decode              |   35 +
 target/riscv/insn_trans/trans_rvv.inc.c |   49 +
 target/riscv/vector_helper.c            | 2335 +++++++++++++++++++++++++++++++
 4 files changed, 2455 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c107925..31e20dc 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -121,6 +121,7 @@ DEF_HELPER_6(vector_vsuxb_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vsuxh_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vsuxw_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vsuxe_v, void, env, i32, i32, i32, i32, i32)
+
 DEF_HELPER_6(vector_vamoswapw_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vamoswapd_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vamoaddw_v, void, env, i32, i32, i32, i32, i32)
@@ -139,5 +140,40 @@ DEF_HELPER_6(vector_vamominuw_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vamominud_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vamomaxuw_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_6(vector_vamomaxud_v, void, env, i32, i32, i32, i32, i32)
+
+DEF_HELPER_4(vector_vadc_vvm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vadc_vxm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vadc_vim, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmadc_vvm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmadc_vxm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmadc_vim, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vsbc_vvm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vsbc_vxm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmsbc_vvm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmsbc_vxm, void, env, i32, i32, i32)
+DEF_HELPER_5(vector_vadd_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vadd_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vadd_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsub_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsub_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vrsub_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vrsub_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwaddu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwaddu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwadd_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwadd_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsubu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsubu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsub_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsub_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwaddu_wv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwaddu_wx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwadd_wv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwadd_wx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsubu_wv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsubu_wx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsub_wv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsub_wx, void, env, i32, i32, i32, i32)
+
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 48e7661..fc7e498 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -63,6 +63,7 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r_vm    ...... vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
 @r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
 @r_nfvm  nf:3 ... vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
 @r2_nfvm nf:3 ... vm:1 ..... ..... ... ..... ....... %rs1 %rd
@@ -280,5 +281,39 @@ vamomaxuw_v     11100 . . ..... ..... 110 ..... 0101111 @r_wdvm
 vamomaxud_v     11100 . . ..... ..... 111 ..... 0101111 @r_wdvm
 
 #*** new major opcode OP-V ***
+vadd_vv         000000 . ..... ..... 000 ..... 1010111 @r_vm
+vadd_vx         000000 . ..... ..... 100 ..... 1010111 @r_vm
+vadd_vi         000000 . ..... ..... 011 ..... 1010111 @r_vm
+vsub_vv         000010 . ..... ..... 000 ..... 1010111 @r_vm
+vsub_vx         000010 . ..... ..... 100 ..... 1010111 @r_vm
+vrsub_vx        000011 . ..... ..... 100 ..... 1010111 @r_vm
+vrsub_vi        000011 . ..... ..... 011 ..... 1010111 @r_vm
+vwaddu_vv       110000 . ..... ..... 010 ..... 1010111 @r_vm
+vwaddu_vx       110000 . ..... ..... 110 ..... 1010111 @r_vm
+vwadd_vv        110001 . ..... ..... 010 ..... 1010111 @r_vm
+vwadd_vx        110001 . ..... ..... 110 ..... 1010111 @r_vm
+vwsubu_vv       110010 . ..... ..... 010 ..... 1010111 @r_vm
+vwsubu_vx       110010 . ..... ..... 110 ..... 1010111 @r_vm
+vwsub_vv        110011 . ..... ..... 010 ..... 1010111 @r_vm
+vwsub_vx        110011 . ..... ..... 110 ..... 1010111 @r_vm
+vwaddu_wv       110100 . ..... ..... 010 ..... 1010111 @r_vm
+vwaddu_wx       110100 . ..... ..... 110 ..... 1010111 @r_vm
+vwadd_wv        110101 . ..... ..... 010 ..... 1010111 @r_vm
+vwadd_wx        110101 . ..... ..... 110 ..... 1010111 @r_vm
+vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
+vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
+vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
+vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
+vadc_vvm        010000 1 ..... ..... 000 ..... 1010111 @r
+vadc_vxm        010000 1 ..... ..... 100 ..... 1010111 @r
+vadc_vim        010000 1 ..... ..... 011 ..... 1010111 @r
+vmadc_vvm       010001 1 ..... ..... 000 ..... 1010111 @r
+vmadc_vxm       010001 1 ..... ..... 100 ..... 1010111 @r
+vmadc_vim       010001 1 ..... ..... 011 ..... 1010111 @r
+vsbc_vvm        010010 1 ..... ..... 000 ..... 1010111 @r
+vsbc_vxm        010010 1 ..... ..... 100 ..... 1010111 @r
+vmsbc_vvm       010011 1 ..... ..... 000 ..... 1010111 @r
+vmsbc_vxm       010011 1 ..... ..... 100 ..... 1010111 @r
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 7bda378..a1c1960 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -77,6 +77,21 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
     return true;                                       \
 }
 
+#define GEN_VECTOR_R_VM(INSN) \
+static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
+{                                                      \
+    TCGv_i32 s1 = tcg_const_i32(a->rs1);               \
+    TCGv_i32 s2 = tcg_const_i32(a->rs2);               \
+    TCGv_i32 d  = tcg_const_i32(a->rd);                \
+    TCGv_i32 vm = tcg_const_i32(a->vm);                \
+    gen_helper_vector_##INSN(cpu_env, vm, s1, s2, d);    \
+    tcg_temp_free_i32(s1);                             \
+    tcg_temp_free_i32(s2);                             \
+    tcg_temp_free_i32(d);                              \
+    tcg_temp_free_i32(vm);                             \
+    return true;                                       \
+}
+
 #define GEN_VECTOR_R2_ZIMM(INSN) \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
 {                                                      \
@@ -155,5 +170,39 @@ GEN_VECTOR_R_WDVM(vamominud_v)
 GEN_VECTOR_R_WDVM(vamomaxuw_v)
 GEN_VECTOR_R_WDVM(vamomaxud_v)
 
+GEN_VECTOR_R(vadc_vvm)
+GEN_VECTOR_R(vadc_vxm)
+GEN_VECTOR_R(vadc_vim)
+GEN_VECTOR_R(vmadc_vvm)
+GEN_VECTOR_R(vmadc_vxm)
+GEN_VECTOR_R(vmadc_vim)
+GEN_VECTOR_R(vsbc_vvm)
+GEN_VECTOR_R(vsbc_vxm)
+GEN_VECTOR_R(vmsbc_vvm)
+GEN_VECTOR_R(vmsbc_vxm)
+GEN_VECTOR_R_VM(vadd_vv)
+GEN_VECTOR_R_VM(vadd_vx)
+GEN_VECTOR_R_VM(vadd_vi)
+GEN_VECTOR_R_VM(vsub_vv)
+GEN_VECTOR_R_VM(vsub_vx)
+GEN_VECTOR_R_VM(vrsub_vx)
+GEN_VECTOR_R_VM(vrsub_vi)
+GEN_VECTOR_R_VM(vwaddu_vv)
+GEN_VECTOR_R_VM(vwaddu_vx)
+GEN_VECTOR_R_VM(vwadd_vv)
+GEN_VECTOR_R_VM(vwadd_vx)
+GEN_VECTOR_R_VM(vwsubu_vv)
+GEN_VECTOR_R_VM(vwsubu_vx)
+GEN_VECTOR_R_VM(vwsub_vv)
+GEN_VECTOR_R_VM(vwsub_vx)
+GEN_VECTOR_R_VM(vwaddu_wv)
+GEN_VECTOR_R_VM(vwaddu_wx)
+GEN_VECTOR_R_VM(vwadd_wv)
+GEN_VECTOR_R_VM(vwadd_wx)
+GEN_VECTOR_R_VM(vwsubu_wv)
+GEN_VECTOR_R_VM(vwsubu_wx)
+GEN_VECTOR_R_VM(vwsub_wv)
+GEN_VECTOR_R_VM(vwsub_wx)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 9ebf70d..95336c9 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -24,12 +24,21 @@
 #include <math.h>
 
 #define VECTOR_HELPER(name) HELPER(glue(vector_, name))
+#define SIGNBIT8    (1 << 7)
+#define SIGNBIT16   (1 << 15)
+#define SIGNBIT32   (1 << 31)
+#define SIGNBIT64   ((uint64_t)1 << 63)
 
 static int64_t sign_extend(int64_t a, int8_t width)
 {
     return a << (64 - width) >> (64 - width);
 }
 
+static int64_t extend_gpr(target_ulong reg)
+{
+    return sign_extend(reg, sizeof(target_ulong) * 8);
+}
+
 static target_ulong vector_get_index(CPURISCVState *env, int rs1, int rs2,
     int index, int mem, int width, int nf)
 {
@@ -118,6 +127,39 @@ static inline bool vector_overlap_vm_common(int lmul, int vm, int rd)
     return false;
 }
 
+static inline bool vector_overlap_vm_force(int vm, int rd)
+{
+    if (vm == 0 && rd == 0) {
+        return true;
+    }
+    return false;
+}
+
+static inline bool vector_overlap_carry(int lmul, int rd)
+{
+    if (lmul > 1 && rd == 0) {
+        return true;
+    }
+    return false;
+}
+
+static inline bool vector_overlap_dstgp_srcgp(int rd, int dlen, int rs,
+    int slen)
+{
+    if ((rd >= rs && rd < rs + slen) || (rs >= rd && rs < rd + dlen)) {
+        return true;
+    }
+    return false;
+}
+
+static inline void vector_get_layout(CPURISCVState *env, int width, int lmul,
+    int index, int *idx, int *pos)
+{
+    int mlen = width / lmul;
+    *idx = (index * mlen) / 8;
+    *pos = (index * mlen) % 8;
+}
+
 static bool  vector_lmul_check_reg(CPURISCVState *env, uint32_t lmul,
         uint32_t reg, bool widen)
 {
@@ -185,6 +227,173 @@ static void vector_tail_segment(CPURISCVState *env, int vreg, int index,
     }
 }
 
+static void vector_tail_common(CPURISCVState *env, int vreg, int index,
+    int width)
+{
+    switch (width) {
+    case 8:
+        env->vfp.vreg[vreg].u8[index] = 0;
+        break;
+    case 16:
+        env->vfp.vreg[vreg].u16[index] = 0;
+        break;
+    case 32:
+        env->vfp.vreg[vreg].u32[index] = 0;
+        break;
+    case 64:
+        env->vfp.vreg[vreg].u64[index] = 0;
+        break;
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return;
+    }
+}
+
+static void vector_tail_widen(CPURISCVState *env, int vreg, int index,
+    int width)
+{
+    switch (width) {
+    case 8:
+        env->vfp.vreg[vreg].u16[index] = 0;
+        break;
+    case 16:
+        env->vfp.vreg[vreg].u32[index] = 0;
+        break;
+    case 32:
+        env->vfp.vreg[vreg].u64[index] = 0;
+        break;
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return;
+    }
+}
+
+static inline int vector_get_carry(CPURISCVState *env, int width, int lmul,
+    int index)
+{
+    int mlen = width / lmul;
+    int idx = (index * mlen) / 8;
+    int pos = (index * mlen) % 8;
+
+    return (env->vfp.vreg[0].u8[idx] >> pos) & 0x1;
+}
+
+static inline void vector_mask_result(CPURISCVState *env, uint32_t reg,
+        int width, int lmul, int index, uint32_t result)
+{
+    int mlen = width / lmul;
+    int idx  = (index * mlen) / width;
+    int pos  = (index * mlen) % width;
+    uint64_t mask = ~((((uint64_t)1 << mlen) - 1) << pos);
+
+    switch (width) {
+    case 8:
+        env->vfp.vreg[reg].u8[idx] = (env->vfp.vreg[reg].u8[idx] & mask)
+                                                | (result << pos);
+    break;
+    case 16:
+        env->vfp.vreg[reg].u16[idx] = (env->vfp.vreg[reg].u16[idx] & mask)
+                                                | (result << pos);
+    break;
+    case 32:
+        env->vfp.vreg[reg].u32[idx] = (env->vfp.vreg[reg].u32[idx] & mask)
+                                                | (result << pos);
+    break;
+    case 64:
+        env->vfp.vreg[reg].u64[idx] = (env->vfp.vreg[reg].u64[idx] & mask)
+                                                | ((uint64_t)result << pos);
+    break;
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+    break;
+    }
+
+    return;
+}
+
+static inline uint64_t u64xu64_lh(uint64_t a, uint64_t b)
+{
+    uint64_t hi_64, carry;
+
+    /* first get the whole product in {hi_64, lo_64} */
+    uint64_t a_hi = a >> 32;
+    uint64_t a_lo = (uint32_t)a;
+    uint64_t b_hi = b >> 32;
+    uint64_t b_lo = (uint32_t)b;
+
+    /*
+     * a * b = (a_hi << 32 + a_lo) * (b_hi << 32 + b_lo)
+     *               = (a_hi * b_hi) << 64 + (a_hi * b_lo) << 32 +
+     *                 (a_lo * b_hi) << 32 + a_lo * b_lo
+     *               = {hi_64, lo_64}
+     * hi_64 = ((a_hi * b_lo) << 32 + (a_lo * b_hi) << 32 + (a_lo * b_lo)) >> 64
+     *       = (a_hi * b_lo) >> 32 + (a_lo * b_hi) >> 32 + carry
+     * carry = ((uint64_t)(uint32_t)(a_hi * b_lo) +
+     *           (uint64_t)(uint32_t)(a_lo * b_hi) + (a_lo * b_lo) >> 32) >> 32
+     */
+
+    carry =  ((uint64_t)(uint32_t)(a_hi * b_lo) +
+              (uint64_t)(uint32_t)(a_lo * b_hi) +
+              ((a_lo * b_lo) >> 32)) >> 32;
+
+    hi_64 = a_hi * b_hi +
+            ((a_hi * b_lo) >> 32) + ((a_lo * b_hi) >> 32) +
+            carry;
+
+    return hi_64;
+}
+
+static inline int64_t s64xu64_lh(int64_t a, uint64_t b)
+{
+    uint64_t abs_a = a;
+    uint64_t lo_64, hi_64;
+
+    if (a < 0) {
+        abs_a =  ~a + 1;
+    }
+    lo_64 = abs_a * b;
+    hi_64 = u64xu64_lh(abs_a, b);
+
+    if ((a ^ b) & SIGNBIT64) {
+        lo_64 = ~lo_64;
+        hi_64 = ~hi_64;
+        if (lo_64 == UINT64_MAX) {
+            lo_64 = 0;
+            hi_64 += 1;
+        } else {
+            lo_64 += 1;
+        }
+    }
+    return hi_64;
+}
+
+static inline int64_t s64xs64_lh(int64_t a, int64_t b)
+{
+    uint64_t abs_a = a, abs_b = b;
+    uint64_t lo_64, hi_64;
+
+    if (a < 0) {
+        abs_a =  ~a + 1;
+    }
+    if (b < 0) {
+        abs_b = ~b + 1;
+    }
+    lo_64 = abs_a * abs_b;
+    hi_64 = u64xu64_lh(abs_a, abs_b);
+
+    if ((a ^ b) & SIGNBIT64) {
+        lo_64 = ~lo_64;
+        hi_64 = ~hi_64;
+        if (lo_64 == UINT64_MAX) {
+            lo_64 = 0;
+            hi_64 += 1;
+        } else {
+            lo_64 += 1;
+        }
+    }
+    return hi_64;
+}
+
 void VECTOR_HELPER(vsetvl)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,
     uint32_t rd)
 {
@@ -4796,3 +5005,2129 @@ void VECTOR_HELPER(vamomaxud_v)(CPURISCVState *env, uint32_t wd, uint32_t vm,
     env->vfp.vstart = 0;
 }
 
+void VECTOR_HELPER(vadc_vvm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax, carry;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_carry(lmul, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src1].u8[j]
+                    + env->vfp.vreg[src2].u8[j] + carry;
+                break;
+            case 16:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src1].u16[j]
+                    + env->vfp.vreg[src2].u16[j] + carry;
+                break;
+            case 32:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src1].u32[j]
+                    + env->vfp.vreg[src2].u32[j] + carry;
+                break;
+            case 64:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src1].u64[j]
+                    + env->vfp.vreg[src2].u64[j] + carry;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vadc_vxm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax, carry;
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_carry(lmul, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u8[j] = env->gpr[rs1]
+                    + env->vfp.vreg[src2].u8[j] + carry;
+                break;
+            case 16:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u16[j] = env->gpr[rs1]
+                    + env->vfp.vreg[src2].u16[j] + carry;
+                break;
+            case 32:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u32[j] = env->gpr[rs1]
+                    + env->vfp.vreg[src2].u32[j] + carry;
+                break;
+            case 64:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u64[j] = (uint64_t)extend_gpr(env->gpr[rs1])
+                    + env->vfp.vreg[src2].u64[j] + carry;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vadc_vim)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax, carry;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_carry(lmul, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u8[j] = sign_extend(rs1, 5)
+                    + env->vfp.vreg[src2].u8[j] + carry;
+                break;
+            case 16:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u16[j] = sign_extend(rs1, 5)
+                    + env->vfp.vreg[src2].u16[j] + carry;
+                break;
+            case 32:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u32[j] = sign_extend(rs1, 5)
+                    + env->vfp.vreg[src2].u32[j] + carry;
+                break;
+            case 64:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u64[j] = sign_extend(rs1, 5)
+                    + env->vfp.vreg[src2].u64[j] + carry;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmadc_vvm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, vlmax, carry;
+    uint64_t tmp;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_dstgp_srcgp(rd, 1, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 1, rs2, lmul)
+        || (rd == 0)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = env->vfp.vreg[src1].u8[j]
+                    + env->vfp.vreg[src2].u8[j] + carry;
+                tmp   = tmp >> width;
+
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 16:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = env->vfp.vreg[src1].u16[j]
+                    + env->vfp.vreg[src2].u16[j] + carry;
+                tmp   = tmp >> width;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 32:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = (uint64_t)env->vfp.vreg[src1].u32[j]
+                    + (uint64_t)env->vfp.vreg[src2].u32[j] + carry;
+                tmp   = tmp >> width;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 64:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = env->vfp.vreg[src1].u64[j]
+                    + env->vfp.vreg[src2].u64[j] + carry;
+
+                if ((tmp < env->vfp.vreg[src1].u64[j] ||
+                        tmp < env->vfp.vreg[src2].u64[j])
+                    || (env->vfp.vreg[src1].u64[j] == UINT64_MAX &&
+                        env->vfp.vreg[src2].u64[j] == UINT64_MAX)) {
+                    tmp = 1;
+                } else {
+                    tmp = 0;
+                }
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmadc_vxm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax, carry;
+    uint64_t tmp, extend_rs1;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_dstgp_srcgp(rd, 1, rs2, lmul)
+        || (rd == 0)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = (uint8_t)env->gpr[rs1]
+                    + env->vfp.vreg[src2].u8[j] + carry;
+                tmp   = tmp >> width;
+
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 16:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = (uint16_t)env->gpr[rs1]
+                    + env->vfp.vreg[src2].u16[j] + carry;
+                tmp   = tmp >> width;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 32:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = (uint64_t)((uint32_t)env->gpr[rs1])
+                    + (uint64_t)env->vfp.vreg[src2].u32[j] + carry;
+                tmp   = tmp >> width;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 64:
+                carry = vector_get_carry(env, width, lmul, i);
+
+                extend_rs1 = (uint64_t)extend_gpr(env->gpr[rs1]);
+                tmp = extend_rs1 + env->vfp.vreg[src2].u64[j] + carry;
+                if ((tmp < extend_rs1) ||
+                    (carry && (env->vfp.vreg[src2].u64[j] == UINT64_MAX))) {
+                    tmp = 1;
+                } else {
+                    tmp = 0;
+                }
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vmadc_vim)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax, carry;
+    uint64_t tmp;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_dstgp_srcgp(rd, 1, rs2, lmul)
+        || (rd == 0)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = (uint8_t)sign_extend(rs1, 5)
+                    + env->vfp.vreg[src2].u8[j] + carry;
+                tmp   = tmp >> width;
+
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 16:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = (uint16_t)sign_extend(rs1, 5)
+                    + env->vfp.vreg[src2].u16[j] + carry;
+                tmp   = tmp >> width;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 32:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = (uint64_t)((uint32_t)sign_extend(rs1, 5))
+                    + (uint64_t)env->vfp.vreg[src2].u32[j] + carry;
+                tmp   = tmp >> width;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 64:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = (uint64_t)sign_extend(rs1, 5)
+                    + env->vfp.vreg[src2].u64[j] + carry;
+
+                if ((tmp < (uint64_t)sign_extend(rs1, 5) ||
+                        tmp < env->vfp.vreg[src2].u64[j])
+                    || ((uint64_t)sign_extend(rs1, 5) == UINT64_MAX &&
+                        env->vfp.vreg[src2].u64[j] == UINT64_MAX)) {
+                    tmp = 1;
+                } else {
+                    tmp = 0;
+                }
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsbc_vvm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax, carry;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_carry(lmul, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j]
+                    - env->vfp.vreg[src1].u8[j] - carry;
+                break;
+            case 16:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                    - env->vfp.vreg[src1].u16[j] - carry;
+                break;
+            case 32:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                    - env->vfp.vreg[src1].u32[j] - carry;
+                break;
+            case 64:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                    - env->vfp.vreg[src1].u64[j] - carry;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vsbc_vxm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax, carry;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_carry(lmul, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j]
+                    - env->gpr[rs1] - carry;
+                break;
+            case 16:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                    - env->gpr[rs1] - carry;
+                break;
+            case 32:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                    - env->gpr[rs1] - carry;
+                break;
+            case 64:
+                carry = vector_get_carry(env, width, lmul, i);
+                env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                    - (uint64_t)extend_gpr(env->gpr[rs1]) - carry;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsbc_vvm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, vlmax, carry;
+    uint64_t tmp;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_dstgp_srcgp(rd, 1, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 1, rs2, lmul)
+        || (rd == 0)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = env->vfp.vreg[src2].u8[j]
+                    - env->vfp.vreg[src1].u8[j] - carry;
+                tmp   = (tmp >> width) & 0x1;
+
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 16:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = env->vfp.vreg[src2].u16[j]
+                    - env->vfp.vreg[src1].u16[j] - carry;
+                tmp   = (tmp >> width) & 0x1;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 32:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = (uint64_t)env->vfp.vreg[src2].u32[j]
+                    - (uint64_t)env->vfp.vreg[src1].u32[j] - carry;
+                tmp   = (tmp >> width) & 0x1;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 64:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = env->vfp.vreg[src2].u64[j]
+                    - env->vfp.vreg[src1].u64[j] - carry;
+
+                if (((env->vfp.vreg[src1].u64[j] == UINT64_MAX) && carry) ||
+                    env->vfp.vreg[src2].u64[j] <
+                        (env->vfp.vreg[src1].u64[j] + carry)) {
+                    tmp = 1;
+                } else {
+                    tmp = 0;
+                }
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vmsbc_vxm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, vlmax, carry;
+    uint64_t tmp, extend_rs1;
+
+    vl    = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_dstgp_srcgp(rd, 1, rs2, lmul)
+        || (rd == 0)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j      = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = env->vfp.vreg[src2].u8[j]
+                    - (uint8_t)env->gpr[rs1] - carry;
+                tmp   = (tmp >> width) & 0x1;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 16:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = env->vfp.vreg[src2].u16[j]
+                    - (uint16_t)env->gpr[rs1] - carry;
+                tmp   = (tmp >> width) & 0x1;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 32:
+                carry = vector_get_carry(env, width, lmul, i);
+                tmp   = (uint64_t)env->vfp.vreg[src2].u32[j]
+                    - (uint64_t)((uint32_t)env->gpr[rs1]) - carry;
+                tmp   = (tmp >> width) & 0x1;
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+            case 64:
+                carry = vector_get_carry(env, width, lmul, i);
+
+                extend_rs1 = (uint64_t)extend_gpr(env->gpr[rs1]);
+                tmp = env->vfp.vreg[src2].u64[j] - extend_rs1 - carry;
+
+                if ((tmp > env->vfp.vreg[src2].u64[j]) ||
+                    ((extend_rs1 == UINT64_MAX) && carry)) {
+                    tmp = 1;
+                } else {
+                    tmp = 0;
+                }
+                vector_mask_result(env, rd, width, lmul, i, tmp);
+                break;
+
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            if (width <= 64) {
+                vector_mask_result(env, rd, width, lmul, i, 0);
+            } else {
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vadd_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src1].u8[j]
+                        + env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src1].u16[j]
+                        + env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src1].u32[j]
+                        + env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src1].u64[j]
+                        + env->vfp.vreg[src2].u64[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vadd_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = env->gpr[rs1]
+                        + env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->gpr[rs1]
+                        + env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->gpr[rs1]
+                        + env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] =
+                        (uint64_t)extend_gpr(env->gpr[rs1])
+                        + env->vfp.vreg[src2].u64[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vadd_vi)(CPURISCVState *env, uint32_t vm,  uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = sign_extend(rs1, 5)
+                        + env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = sign_extend(rs1, 5)
+                        + env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = sign_extend(rs1, 5)
+                        + env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = sign_extend(rs1, 5)
+                        + env->vfp.vreg[src2].s64[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsub_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j]
+                        - env->vfp.vreg[src1].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                        - env->vfp.vreg[src1].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                        - env->vfp.vreg[src1].u32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        - env->vfp.vreg[src1].u64[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vsub_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src2].u8[j]
+                        - env->gpr[rs1];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src2].u16[j]
+                        - env->gpr[rs1];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src2].u32[j]
+                        - env->gpr[rs1];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src2].u64[j]
+                        - (uint64_t)extend_gpr(env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vrsub_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = env->gpr[rs1]
+                        - env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = env->gpr[rs1]
+                        - env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = env->gpr[rs1]
+                        - env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] =
+                        (uint64_t)extend_gpr(env->gpr[rs1])
+                        - env->vfp.vreg[src2].u64[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vrsub_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl = env->vfp.vl;
+    lmul  = vector_get_lmul(env);
+    width   = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = sign_extend(rs1, 5)
+                        - env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = sign_extend(rs1, 5)
+                        - env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = sign_extend(rs1, 5)
+                        - env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = sign_extend(rs1, 5)
+                        - env->vfp.vreg[src2].s64[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwaddu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)
+        ) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] =
+                        (uint16_t)env->vfp.vreg[src1].u8[j] +
+                        (uint16_t)env->vfp.vreg[src2].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] =
+                        (uint32_t)env->vfp.vreg[src1].u16[j] +
+                        (uint32_t)env->vfp.vreg[src2].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] =
+                        (uint64_t)env->vfp.vreg[src1].u32[j] +
+                        (uint64_t)env->vfp.vreg[src2].u32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwaddu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)
+        ) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] =
+                        (uint16_t)env->vfp.vreg[src2].u8[j] +
+                        (uint16_t)((uint8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] =
+                        (uint32_t)env->vfp.vreg[src2].u16[j] +
+                        (uint32_t)((uint16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] =
+                        (uint64_t)env->vfp.vreg[src2].u32[j] +
+                        (uint64_t)((uint32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwadd_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)env->vfp.vreg[src1].s8[j] +
+                        (int16_t)env->vfp.vreg[src2].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)env->vfp.vreg[src1].s16[j] +
+                        (int32_t)env->vfp.vreg[src2].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)env->vfp.vreg[src1].s32[j] +
+                        (int64_t)env->vfp.vreg[src2].s32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwadd_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)((int8_t)env->vfp.vreg[src2].s8[j]) +
+                        (int16_t)((int8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)((int16_t)env->vfp.vreg[src2].s16[j]) +
+                        (int32_t)((int16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)((int32_t)env->vfp.vreg[src2].s32[j]) +
+                        (int64_t)((int32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwsubu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)
+        ) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] =
+                        (uint16_t)env->vfp.vreg[src2].u8[j] -
+                        (uint16_t)env->vfp.vreg[src1].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] =
+                        (uint32_t)env->vfp.vreg[src2].u16[j] -
+                        (uint32_t)env->vfp.vreg[src1].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] =
+                        (uint64_t)env->vfp.vreg[src2].u32[j] -
+                        (uint64_t)env->vfp.vreg[src1].u32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwsubu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)
+        ) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] =
+                        (uint16_t)env->vfp.vreg[src2].u8[j] -
+                        (uint16_t)((uint8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] =
+                        (uint32_t)env->vfp.vreg[src2].u16[j] -
+                        (uint32_t)((uint16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] =
+                        (uint64_t)env->vfp.vreg[src2].u32[j] -
+                        (uint64_t)((uint32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwsub_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)
+        ) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)env->vfp.vreg[src2].s8[j] -
+                        (int16_t)env->vfp.vreg[src1].s8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)env->vfp.vreg[src2].s16[j] -
+                        (int32_t)env->vfp.vreg[src1].s16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)env->vfp.vreg[src2].s32[j] -
+                        (int64_t)env->vfp.vreg[src1].s32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+void VECTOR_HELPER(vwsub_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)
+        ) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)((int8_t)env->vfp.vreg[src2].s8[j]) -
+                        (int16_t)((int8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)((int16_t)env->vfp.vreg[src2].s16[j]) -
+                        (int32_t)((int16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)((int32_t)env->vfp.vreg[src2].s32[j]) -
+                        (int64_t)((int32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwaddu_wv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] =
+                        (uint16_t)env->vfp.vreg[src1].u8[j] +
+                        (uint16_t)env->vfp.vreg[src2].u16[k];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] =
+                        (uint32_t)env->vfp.vreg[src1].u16[j] +
+                        (uint32_t)env->vfp.vreg[src2].u32[k];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] =
+                        (uint64_t)env->vfp.vreg[src1].u32[j] +
+                        (uint64_t)env->vfp.vreg[src2].u64[k];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwaddu_wx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] =
+                        (uint16_t)env->vfp.vreg[src2].u16[k] +
+                        (uint16_t)((uint8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] =
+                        (uint32_t)env->vfp.vreg[src2].u32[k] +
+                        (uint32_t)((uint16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] =
+                        (uint64_t)env->vfp.vreg[src2].u64[k] +
+                        (uint64_t)((uint32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwadd_wv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)((int8_t)env->vfp.vreg[src1].s8[j]) +
+                        (int16_t)env->vfp.vreg[src2].s16[k];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)((int16_t)env->vfp.vreg[src1].s16[j]) +
+                        (int32_t)env->vfp.vreg[src2].s32[k];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)((int32_t)env->vfp.vreg[src1].s32[j]) +
+                        (int64_t)env->vfp.vreg[src2].s64[k];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwadd_wx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)env->vfp.vreg[src2].s16[k] +
+                        (int16_t)((int8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)env->vfp.vreg[src2].s32[k] +
+                        (int32_t)((int16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)env->vfp.vreg[src2].s64[k] +
+                        (int64_t)((int32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwsubu_wv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] =
+                        (uint16_t)env->vfp.vreg[src2].u16[k] -
+                        (uint16_t)env->vfp.vreg[src1].u8[j];
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] =
+                        (uint32_t)env->vfp.vreg[src2].u32[k] -
+                        (uint32_t)env->vfp.vreg[src1].u16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] =
+                        (uint64_t)env->vfp.vreg[src2].u64[k] -
+                        (uint64_t)env->vfp.vreg[src1].u32[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwsubu_wx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] =
+                        (uint16_t)env->vfp.vreg[src2].u16[k] -
+                        (uint16_t)((uint8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] =
+                        (uint32_t)env->vfp.vreg[src2].u32[k] -
+                        (uint32_t)((uint16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] =
+                        (uint64_t)env->vfp.vreg[src2].u64[k] -
+                        (uint64_t)((uint32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwsub_wv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl;
+    uint32_t lmul, width, src1, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src1 = rs1 + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)env->vfp.vreg[src2].s16[k] -
+                        (int16_t)((int8_t)env->vfp.vreg[src1].s8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)env->vfp.vreg[src2].s32[k] -
+                        (int32_t)((int16_t)env->vfp.vreg[src1].s16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)env->vfp.vreg[src2].s64[k] -
+                        (int64_t)((int32_t)env->vfp.vreg[src1].s32[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vwsub_wx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int i, k, vl;
+    uint32_t lmul, width, src2, dest, vlmax;
+
+    vl    = env->vfp.vl;
+
+    lmul  = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        dest = rd + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] =
+                        (int16_t)env->vfp.vreg[src2].s16[k] -
+                        (int16_t)((int8_t)env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] =
+                        (int32_t)env->vfp.vreg[src2].s32[k] -
+                        (int32_t)((int16_t)env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] =
+                        (int64_t)env->vfp.vreg[src2].s64[k] -
+                        (int64_t)((int32_t)env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                break;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+}
-- 
2.7.4


