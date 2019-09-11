Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97837ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3269F21928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3269F21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wPM-0002xl-Oh
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wE8-0007q0-CL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDy-00089O-2R
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:40 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDw-0007qw-5g; Wed, 11 Sep 2019 02:35:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.275989-0.00415687-0.719854; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03300; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRQiS-_1568183703; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRQiS-_1568183703)
 by smtp.aliyun-inc.com(10.147.41.137);
 Wed, 11 Sep 2019 14:35:03 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:38 +0800
Message-Id: <1568183141-67641-15-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 14/17] RISC-V: add vector extension float
 instructions part2, sqrt/cmp/cvt/others
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
 target/riscv/helper.h                   |   40 +
 target/riscv/insn32.decode              |   40 +
 target/riscv/insn_trans/trans_rvv.inc.c |   54 +
 target/riscv/vector_helper.c            | 2962 +++++++++++++++++++++++++++++++
 4 files changed, 3096 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d2c8684..e2384eb 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -344,5 +344,45 @@ DEF_HELPER_5(vector_vfmsub_vf, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vfnmsub_vv, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vfnmsub_vf, void, env, i32, i32, i32, i32)
 
+DEF_HELPER_4(vector_vfsqrt_v, void, env, i32, i32, i32)
+DEF_HELPER_5(vector_vfmin_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmin_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmax_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmax_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfsgnj_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfsgnj_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfsgnjn_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfsgnjn_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfsgnjx_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfsgnjx_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmfeq_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmfeq_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmfne_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmfne_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmfle_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmfle_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmflt_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmflt_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmfgt_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmfge_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmford_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vmford_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmerge_vfm, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(vector_vfclass_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfcvt_xu_f_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfcvt_x_f_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfcvt_f_xu_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfcvt_f_x_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfwcvt_xu_f_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfwcvt_x_f_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfwcvt_f_xu_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfwcvt_f_x_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfwcvt_f_f_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfncvt_xu_f_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfncvt_x_f_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfncvt_f_xu_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfncvt_f_x_v, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vfncvt_f_f_v, void, env, i32, i32, i32)
+
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 31868ab..256d8ea 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -67,6 +67,7 @@
 @r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
 @r_nfvm  nf:3 ... vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
 @r2_nfvm nf:3 ... vm:1 ..... ..... ... ..... ....... %rs1 %rd
+@r2_vm   ...... vm:1 ..... ..... ... ..... ....... %rs2 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
 @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -483,6 +484,45 @@ vfmsub_vv       101010 . ..... ..... 001 ..... 1010111 @r_vm
 vfmsub_vf       101010 . ..... ..... 101 ..... 1010111 @r_vm
 vfnmsub_vv      101011 . ..... ..... 001 ..... 1010111 @r_vm
 vfnmsub_vf      101011 . ..... ..... 101 ..... 1010111 @r_vm
+vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
+vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
+vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
+vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
+vfmax_vf        000110 . ..... ..... 101 ..... 1010111 @r_vm
+vfsgnj_vv       001000 . ..... ..... 001 ..... 1010111 @r_vm
+vfsgnj_vf       001000 . ..... ..... 101 ..... 1010111 @r_vm
+vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
+vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
+vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
+vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
+vmfeq_vv        011000 . ..... ..... 001 ..... 1010111 @r_vm
+vmfeq_vf        011000 . ..... ..... 101 ..... 1010111 @r_vm
+vmfne_vv        011100 . ..... ..... 001 ..... 1010111 @r_vm
+vmfne_vf        011100 . ..... ..... 101 ..... 1010111 @r_vm
+vmflt_vv        011011 . ..... ..... 001 ..... 1010111 @r_vm
+vmflt_vf        011011 . ..... ..... 101 ..... 1010111 @r_vm
+vmfle_vv        011001 . ..... ..... 001 ..... 1010111 @r_vm
+vmfle_vf        011001 . ..... ..... 101 ..... 1010111 @r_vm
+vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
+vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
+vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
+vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
+vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
+vfmerge_vfm     010111 . ..... ..... 101 ..... 1010111 @r_vm
+vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
+vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
+vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
+vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
+vfwcvt_xu_f_v   100010 . ..... 01000 001 ..... 1010111 @r2_vm
+vfwcvt_x_f_v    100010 . ..... 01001 001 ..... 1010111 @r2_vm
+vfwcvt_f_xu_v   100010 . ..... 01010 001 ..... 1010111 @r2_vm
+vfwcvt_f_x_v    100010 . ..... 01011 001 ..... 1010111 @r2_vm
+vfwcvt_f_f_v    100010 . ..... 01100 001 ..... 1010111 @r2_vm
+vfncvt_xu_f_v   100010 . ..... 10000 001 ..... 1010111 @r2_vm
+vfncvt_x_f_v    100010 . ..... 10001 001 ..... 1010111 @r2_vm
+vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
+vfncvt_f_x_v    100010 . ..... 10011 001 ..... 1010111 @r2_vm
+vfncvt_f_f_v    100010 . ..... 10100 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index ff23bc2..e4d4576 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -92,6 +92,20 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
     return true;                                       \
 }
 
+#define GEN_VECTOR_R2_VM(INSN) \
+static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
+{                                                      \
+    TCGv_i32 s2 = tcg_const_i32(a->rs2);               \
+    TCGv_i32 d  = tcg_const_i32(a->rd);                \
+    TCGv_i32 vm = tcg_const_i32(a->vm);                \
+    gen_helper_vector_##INSN(cpu_env, vm, s2, d);        \
+    tcg_temp_free_i32(s2);                             \
+    tcg_temp_free_i32(d);                              \
+    tcg_temp_free_i32(vm);                             \
+    return true;                                       \
+}
+
+
 #define GEN_VECTOR_R2_ZIMM(INSN) \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
 {                                                      \
@@ -373,5 +387,45 @@ GEN_VECTOR_R_VM(vfmsub_vf)
 GEN_VECTOR_R_VM(vfnmsub_vv)
 GEN_VECTOR_R_VM(vfnmsub_vf)
 
+GEN_VECTOR_R2_VM(vfsqrt_v)
+GEN_VECTOR_R_VM(vfmin_vv)
+GEN_VECTOR_R_VM(vfmin_vf)
+GEN_VECTOR_R_VM(vfmax_vv)
+GEN_VECTOR_R_VM(vfmax_vf)
+GEN_VECTOR_R_VM(vfsgnj_vv)
+GEN_VECTOR_R_VM(vfsgnj_vf)
+GEN_VECTOR_R_VM(vfsgnjn_vv)
+GEN_VECTOR_R_VM(vfsgnjn_vf)
+GEN_VECTOR_R_VM(vfsgnjx_vv)
+GEN_VECTOR_R_VM(vfsgnjx_vf)
+GEN_VECTOR_R_VM(vmfeq_vv)
+GEN_VECTOR_R_VM(vmfeq_vf)
+GEN_VECTOR_R_VM(vmfne_vv)
+GEN_VECTOR_R_VM(vmfne_vf)
+GEN_VECTOR_R_VM(vmfle_vv)
+GEN_VECTOR_R_VM(vmfle_vf)
+GEN_VECTOR_R_VM(vmflt_vv)
+GEN_VECTOR_R_VM(vmflt_vf)
+GEN_VECTOR_R_VM(vmfgt_vf)
+GEN_VECTOR_R_VM(vmfge_vf)
+GEN_VECTOR_R_VM(vmford_vv)
+GEN_VECTOR_R_VM(vmford_vf)
+GEN_VECTOR_R2_VM(vfclass_v)
+GEN_VECTOR_R_VM(vfmerge_vfm)
+GEN_VECTOR_R2_VM(vfcvt_xu_f_v)
+GEN_VECTOR_R2_VM(vfcvt_x_f_v)
+GEN_VECTOR_R2_VM(vfcvt_f_xu_v)
+GEN_VECTOR_R2_VM(vfcvt_f_x_v)
+GEN_VECTOR_R2_VM(vfwcvt_xu_f_v)
+GEN_VECTOR_R2_VM(vfwcvt_x_f_v)
+GEN_VECTOR_R2_VM(vfwcvt_f_xu_v)
+GEN_VECTOR_R2_VM(vfwcvt_f_x_v)
+GEN_VECTOR_R2_VM(vfwcvt_f_f_v)
+GEN_VECTOR_R2_VM(vfncvt_xu_f_v)
+GEN_VECTOR_R2_VM(vfncvt_x_f_v)
+GEN_VECTOR_R2_VM(vfncvt_f_xu_v)
+GEN_VECTOR_R2_VM(vfncvt_f_x_v)
+GEN_VECTOR_R2_VM(vfncvt_f_f_v)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e16543b..fd2ecb7 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -914,6 +914,25 @@ static inline int64_t avg_round_s64(CPURISCVState *env, int64_t a, int64_t b)
     return res;
 }
 
+static target_ulong helper_fclass_h(uint64_t frs1)
+{
+    float16 f = frs1;
+    bool sign = float16_is_neg(f);
+
+    if (float16_is_infinity(f)) {
+        return sign ? 1 << 0 : 1 << 7;
+    } else if (float16_is_zero(f)) {
+        return sign ? 1 << 3 : 1 << 4;
+    } else if (float16_is_zero_or_denormal(f)) {
+        return sign ? 1 << 2 : 1 << 5;
+    } else if (float16_is_any_nan(f)) {
+        float_status s = { }; /* for snan_bit_is_one */
+        return float16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+    } else {
+        return sign ? 1 << 1 : 1 << 6;
+    }
+}
+
 static inline bool vector_vtype_ill(CPURISCVState *env)
 {
     if ((env->vfp.vtype >> (sizeof(target_ulong) - 1)) & 0x1) {
@@ -1017,6 +1036,32 @@ static bool  vector_lmul_check_reg(CPURISCVState *env, uint32_t lmul,
     return true;
 }
 
+/**
+ * deposit16:
+ * @value: initial value to insert bit field into
+ * @start: the lowest bit in the bit field (numbered from 0)
+ * @length: the length of the bit field
+ * @fieldval: the value to insert into the bit field
+ *
+ * Deposit @fieldval into the 16 bit @value at the bit field specified
+ * by the @start and @length parameters, and return the modified
+ * @value. Bits of @value outside the bit field are not modified.
+ * Bits of @fieldval above the least significant @length bits are
+ * ignored. The bit field must lie entirely within the 16 bit word.
+ * It is valid to request that all 16 bits are modified (ie @length
+ * 16 and @start 0).
+ *
+ * Returns: the modified @value.
+ */
+static  inline uint16_t deposit16(uint16_t value, int start, int length,
+        uint16_t fieldval)
+{
+    uint16_t mask;
+    assert(start >= 0 && length > 0 && length <= 16 - start);
+    mask = (~0U >> (16 - length)) << start;
+    return (value & ~mask) | ((fieldval << start) & mask);
+}
+
 static void vector_tail_amo(CPURISCVState *env, int vreg, int index, int width)
 {
     switch (width) {
@@ -1161,6 +1206,22 @@ static void vector_tail_fwiden(CPURISCVState *env, int vreg, int index,
     }
 }
 
+static void vector_tail_fnarrow(CPURISCVState *env, int vreg, int index,
+    int width)
+{
+    switch (width) {
+    case 16:
+        env->vfp.vreg[vreg].u16[index] = 0;
+        break;
+    case 32:
+        env->vfp.vreg[vreg].u32[index] = 0;
+        break;
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return;
+    }
+}
+
 static inline int vector_get_carry(CPURISCVState *env, int width, int lmul,
     int index)
 {
@@ -19758,4 +19819,2905 @@ void VECTOR_HELPER(vfnmsub_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
     return;
 }
 
+/* vfsqrt.v vd, vs2, vm # Vector-vector square root */
+void VECTOR_HELPER(vfsqrt_v)(CPURISCVState *env, uint32_t vm, uint32_t rs2,
+    uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_sqrt(
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_sqrt(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_sqrt(
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmin.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vfmin_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_minnum(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_minnum(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_minnum(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmin.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfmin_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_minnum(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_minnum(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_minnum(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    return;
+
+    env->vfp.vstart = 0;
+}
+
+/*vfmax.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vfmax_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_maxnum(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_maxnum(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_maxnum(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmax.vf vd, vs2, rs1, vm  # vector-scalar */
+void VECTOR_HELPER(vfmax_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_maxnum(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_maxnum(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_maxnum(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    return;
+
+    env->vfp.vstart = 0;
+}
+
+/* vfsgnj.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vfsgnj_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = deposit16(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    0,
+                                                    15,
+                                                    env->vfp.vreg[src2].f16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = deposit32(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    0,
+                                                    31,
+                                                    env->vfp.vreg[src2].f32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = deposit64(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    0,
+                                                    63,
+                                                    env->vfp.vreg[src2].f64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfsgnj.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfsgnj_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = deposit16(
+                                                    env->fpr[rs1],
+                                                    0,
+                                                    15,
+                                                    env->vfp.vreg[src2].f16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = deposit32(
+                                                    env->fpr[rs1],
+                                                    0,
+                                                    31,
+                                                    env->vfp.vreg[src2].f32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = deposit64(
+                                                    env->fpr[rs1],
+                                                    0,
+                                                    63,
+                                                    env->vfp.vreg[src2].f64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfsgnjn.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vfsgnjn_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = deposit16(
+                                                    ~env->vfp.vreg[src1].f16[j],
+                                                    0,
+                                                    15,
+                                                    env->vfp.vreg[src2].f16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = deposit32(
+                                                    ~env->vfp.vreg[src1].f32[j],
+                                                    0,
+                                                    31,
+                                                    env->vfp.vreg[src2].f32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = deposit64(
+                                                    ~env->vfp.vreg[src1].f64[j],
+                                                    0,
+                                                    63,
+                                                    env->vfp.vreg[src2].f64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+/* vfsgnjn.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfsgnjn_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = deposit16(
+                                                    ~env->fpr[rs1],
+                                                    0,
+                                                    15,
+                                                    env->vfp.vreg[src2].f16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = deposit32(
+                                                    ~env->fpr[rs1],
+                                                    0,
+                                                    31,
+                                                    env->vfp.vreg[src2].f32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = deposit64(
+                                                    ~env->fpr[rs1],
+                                                    0,
+                                                    63,
+                                                    env->vfp.vreg[src2].f64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfsgnjx.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vfsgnjx_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = deposit16(
+                                                    env->vfp.vreg[src1].f16[j] ^
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    0,
+                                                    15,
+                                                    env->vfp.vreg[src2].f16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = deposit32(
+                                                    env->vfp.vreg[src1].f32[j] ^
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    0,
+                                                    31,
+                                                    env->vfp.vreg[src2].f32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = deposit64(
+                                                    env->vfp.vreg[src1].f64[j] ^
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    0,
+                                                    63,
+                                                    env->vfp.vreg[src2].f64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    return;
+
+    env->vfp.vstart = 0;
+}
+
+/* vfsgnjx.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfsgnjx_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = deposit16(
+                                                    env->fpr[rs1] ^
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    0,
+                                                    15,
+                                                    env->vfp.vreg[src2].f16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = deposit32(
+                                                    env->fpr[rs1] ^
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    0,
+                                                    31,
+                                                    env->vfp.vreg[src2].f32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = deposit64(
+                                                    env->fpr[rs1] ^
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    0,
+                                                    63,
+                                                    env->vfp.vreg[src2].f64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+                env->vfp.vreg[dest].f16[j] = 0;
+            case 32:
+                env->vfp.vreg[dest].f32[j] = 0;
+            case 64:
+                env->vfp.vreg[dest].f64[j] = 0;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    return;
+
+    env->vfp.vstart = 0;
+}
+
+/* vfmerge.vfm vd, vs2, rs1, v0 # vd[i] = v0[i].LSB ? f[rs1] : vs2[i] */
+void VECTOR_HELPER(vfmerge_vfm)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    /* vfmv.v.f vd, rs1 # vd[i] = f[rs1]; */
+    if (vm && (rs2 != 0)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = env->fpr[rs1];
+                } else {
+                    env->vfp.vreg[dest].f16[j] = env->vfp.vreg[src2].f16[j];
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = env->fpr[rs1];
+                } else {
+                    env->vfp.vreg[dest].f32[j] = env->vfp.vreg[src2].f32[j];
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = env->fpr[rs1];
+                } else {
+                    env->vfp.vreg[dest].f64[j] = env->vfp.vreg[src2].f64[j];
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmfeq.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vmfeq_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src1, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    r = float16_compare_quiet(env->vfp.vreg[src1].f16[j],
+                                              env->vfp.vreg[src2].f16[j],
+                                              &env->fp_status);
+                    if (r == float_relation_equal) {
+                        result = 1;
+                    } else {
+                        result = 0;
+                    }
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float32_eq_quiet(env->vfp.vreg[src1].f32[j],
+                                              env->vfp.vreg[src2].f32[j],
+                                              &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float64_eq_quiet(env->vfp.vreg[src1].f64[j],
+                                              env->vfp.vreg[src2].f64[j],
+                                              &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmfeq.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vmfeq_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    r = float16_compare_quiet(env->fpr[rs1],
+                                              env->vfp.vreg[src2].f16[j],
+                                              &env->fp_status);
+                    if (r == float_relation_equal) {
+                        result = 1;
+                    } else {
+                        result = 0;
+                    }
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float32_eq_quiet(env->fpr[rs1],
+                                              env->vfp.vreg[src2].f32[j],
+                                              &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float64_eq_quiet(env->fpr[rs1],
+                                              env->vfp.vreg[src2].f64[j],
+                                              &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmfne.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vmfne_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src1, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    r = float16_compare_quiet(env->vfp.vreg[src1].f16[j],
+                                              env->vfp.vreg[src2].f16[j],
+                                              &env->fp_status);
+                    if (r != float_relation_equal) {
+                        result = 1;
+                    } else {
+                        result = 0;
+                    }
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float32_eq_quiet(env->vfp.vreg[src1].f32[j],
+                                              env->vfp.vreg[src2].f32[j],
+                                              &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, !result);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float64_eq_quiet(env->vfp.vreg[src1].f64[j],
+                                              env->vfp.vreg[src2].f64[j],
+                                              &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, !result);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmfne.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vmfne_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    r = float16_compare_quiet(env->fpr[rs1],
+                                              env->vfp.vreg[src2].f16[j],
+                                              &env->fp_status);
+                    if (r != float_relation_equal) {
+                        result = 1;
+                    } else {
+                        result = 0;
+                    }
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float32_eq_quiet(env->fpr[rs1],
+                                              env->vfp.vreg[src2].f32[j],
+                                              &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, !result);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float64_eq_quiet(env->fpr[rs1],
+                                              env->vfp.vreg[src2].f64[j],
+                                              &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, !result);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmflt.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vmflt_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src1, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    r = float16_compare(env->vfp.vreg[src2].f16[j],
+                                        env->vfp.vreg[src1].f16[j],
+                                        &env->fp_status);
+                    if (r == float_relation_less) {
+                        result = 1;
+                    } else {
+                        result = 0;
+                    }
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float32_lt(env->vfp.vreg[src2].f32[j],
+                                        env->vfp.vreg[src1].f32[j],
+                                        &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float64_lt(env->vfp.vreg[src2].f64[j],
+                                        env->vfp.vreg[src1].f64[j],
+                                        &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmflt.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vmflt_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    r = float16_compare(env->vfp.vreg[src2].f16[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    if (r == float_relation_less) {
+                        result = 1;
+                    } else {
+                        result = 0;
+                    }
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float32_lt(env->vfp.vreg[src2].f32[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float64_lt(env->vfp.vreg[src2].f64[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmfle.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vmfle_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src1, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    r = float16_compare(env->vfp.vreg[src2].f16[j],
+                                        env->vfp.vreg[src1].f16[j],
+                                        &env->fp_status);
+                    if ((r == float_relation_less) ||
+                        (r == float_relation_equal)) {
+                        result = 1;
+                    } else {
+                        result = 0;
+                    }
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float32_le(env->vfp.vreg[src2].f32[j],
+                                        env->vfp.vreg[src1].f32[j],
+                                        &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float64_le(env->vfp.vreg[src2].f64[j],
+                                        env->vfp.vreg[src1].f64[j],
+                                        &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmfle.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vmfle_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    r = float16_compare(env->vfp.vreg[src2].f16[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    if ((r == float_relation_less) ||
+                        (r == float_relation_equal)) {
+                        result = 1;
+                    } else {
+                        result = 0;
+                    }
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float32_le(env->vfp.vreg[src2].f32[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float64_le(env->vfp.vreg[src2].f64[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, result);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmfgt.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vmfgt_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            if (vector_elem_mask(env, vm, width, lmul, i)) {
+                switch (width) {
+                case 16:
+                    r = float16_compare(env->vfp.vreg[src2].f16[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    break;
+                case 32:
+                    r = float32_compare(env->vfp.vreg[src2].f32[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    break;
+                case 64:
+                    r = float64_compare(env->vfp.vreg[src2].f64[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    break;
+                default:
+                    riscv_raise_exception(env,
+                        RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    return;
+                }
+                if (r == float_relation_greater) {
+                    result = 1;
+                } else {
+                    result = 0;
+                }
+                vector_mask_result(env, rd, width, lmul, i, result);
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmfge.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vmfge_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            if (vector_elem_mask(env, vm, width, lmul, i)) {
+                switch (width) {
+                case 16:
+                    r = float16_compare(env->vfp.vreg[src2].f16[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    break;
+                case 32:
+                    r = float32_compare(env->vfp.vreg[src2].f32[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    break;
+                case 64:
+                    r = float64_compare(env->vfp.vreg[src2].f64[j],
+                                        env->fpr[rs1],
+                                        &env->fp_status);
+                    break;
+                default:
+                    riscv_raise_exception(env,
+                        RISCV_EXCP_ILLEGAL_INST, GETPC());
+                    return;
+                }
+                if ((r == float_relation_greater) ||
+                    (r == float_relation_equal)) {
+                    result = 1;
+                } else {
+                    result = 0;
+                }
+                vector_mask_result(env, rd, width, lmul, i, result);
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmford.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vmford_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src1, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    r = float16_compare_quiet(env->vfp.vreg[src1].f16[j],
+                                              env->vfp.vreg[src2].f16[j],
+                                              &env->fp_status);
+                    if (r == float_relation_unordered) {
+                        result = 1;
+                    } else {
+                        result = 0;
+                    }
+                    vector_mask_result(env, rd, width, lmul, i, !result);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float32_unordered_quiet(env->vfp.vreg[src1].f32[j],
+                                                     env->vfp.vreg[src2].f32[j],
+                                                     &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, !result);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float64_unordered_quiet(env->vfp.vreg[src1].f64[j],
+                                                     env->vfp.vreg[src2].f64[j],
+                                                     &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, !result);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmford.vf vd, vs2, rs1, vm # Vector-scalar */
+void VECTOR_HELPER(vmford_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, src2, result, r;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    r = float16_compare_quiet(env->vfp.vreg[src2].f16[j],
+                                              env->fpr[rs1],
+                                              &env->fp_status);
+                    if (r == float_relation_unordered) {
+                        result = 1;
+                    } else {
+                        result = 0;
+                    }
+                    vector_mask_result(env, rd, width, lmul, i, !result);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float32_unordered_quiet(env->vfp.vreg[src2].f32[j],
+                                                     env->fpr[rs1],
+                                                     &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, !result);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    result = float64_unordered_quiet(env->vfp.vreg[src2].f64[j],
+                                                     env->fpr[rs1],
+                                                     &env->fp_status);
+                    vector_mask_result(env, rd, width, lmul, i, !result);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            switch (width) {
+            case 16:
+            case 32:
+            case 64:
+                vector_mask_result(env, rd, width, lmul, i, 0);
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfclass.v vd, vs2, vm # Vector-vector */
+void VECTOR_HELPER(vfclass_v)(CPURISCVState *env, uint32_t vm, uint32_t rs2,
+    uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = helper_fclass_h(
+                                                    env->vfp.vreg[src2].f16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = helper_fclass_s(
+                                                    env->vfp.vreg[src2].f32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = helper_fclass_d(
+                                                    env->vfp.vreg[src2].f64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfcvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
+void VECTOR_HELPER(vfcvt_xu_f_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = float16_to_uint16(
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = float32_to_uint32(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = float64_to_uint64(
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfcvt.x.f.v vd, vs2, vm # Convert float to signed integer. */
+void VECTOR_HELPER(vfcvt_x_f_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = float16_to_int16(
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = float32_to_int32(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = float64_to_int64(
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to float. */
+void VECTOR_HELPER(vfcvt_f_xu_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = uint16_to_float16(
+                                                    env->vfp.vreg[src2].u16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = uint32_to_float32(
+                                                    env->vfp.vreg[src2].u32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = uint64_to_float64(
+                                                    env->vfp.vreg[src2].u64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfcvt.f.x.v vd, vs2, vm # Convert integer to float. */
+void VECTOR_HELPER(vfcvt_f_x_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = int16_to_float16(
+                                                    env->vfp.vreg[src2].s16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = int32_to_float32(
+                                                    env->vfp.vreg[src2].s32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = int64_to_float64(
+                                                    env->vfp.vreg[src2].s64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwcvt.xu.f.v vd, vs2, vm # Convert float to double-width unsigned integer.*/
+void VECTOR_HELPER(vfwcvt_xu_f_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (lmul > 4) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] = float16_to_uint32(
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] = float32_to_uint64(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+            }
+        } else {
+            vector_tail_fwiden(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwcvt.x.f.v vd, vs2, vm # Convert float to double-width signed integer. */
+void VECTOR_HELPER(vfwcvt_x_f_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (lmul > 4) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] = float16_to_int32(
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] = float32_to_int64(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to double-width float */
+void VECTOR_HELPER(vfwcvt_f_xu_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (lmul > 4) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = uint16_to_float32(
+                                                    env->vfp.vreg[src2].u16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = uint32_to_float64(
+                                                    env->vfp.vreg[src2].u32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwcvt.f.x.v vd, vs2, vm # Convert integer to double-width float. */
+void VECTOR_HELPER(vfwcvt_f_x_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (lmul > 4) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = int16_to_float32(
+                                                    env->vfp.vreg[src2].s16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = int32_to_float64(
+                                                    env->vfp.vreg[src2].s32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vfwcvt.f.f.v vd, vs2, vm #
+ * Convert single-width float to double-width float.
+ */
+void VECTOR_HELPER(vfwcvt_f_f_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (lmul > 4) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float16_to_float32(
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    true,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float32_to_float64(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
+void VECTOR_HELPER(vfncvt_xu_f_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (lmul > 4) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / width);
+        j = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] = float32_to_uint16(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] = float64_to_uint32(
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fnarrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfncvt.x.f.v vd, vs2, vm # Convert double-width float to signed integer. */
+void VECTOR_HELPER(vfncvt_x_f_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+     if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (lmul > 4) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / width);
+        j = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] = float32_to_int16(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] = float64_to_int32(
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fnarrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfncvt.f.xu.v vd, vs2, vm # Convert double-width unsigned integer to float */
+void VECTOR_HELPER(vfncvt_f_xu_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (lmul > 4) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / width);
+        j = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[k] = uint32_to_float16(
+                                                    env->vfp.vreg[src2].u32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = uint64_to_float32(
+                                                    env->vfp.vreg[src2].u64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fnarrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfncvt.f.x.v vd, vs2, vm # Convert double-width integer to float. */
+void VECTOR_HELPER(vfncvt_f_x_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (lmul > 4) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / width);
+        j = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[k] = int32_to_float16(
+                                                    env->vfp.vreg[src2].s32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = int64_to_float32(
+                                                    env->vfp.vreg[src2].s64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fnarrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfncvt.f.f.v vd, vs2, vm # Convert double float to single-width float. */
+void VECTOR_HELPER(vfncvt_f_f_v)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env) ||
+        vector_overlap_vm_common(lmul, vm, rd) ||
+        vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (lmul > 4) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / width);
+        j = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[k] = float32_to_float16(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    true,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float64_to_float32(
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fnarrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
 
-- 
2.7.4


