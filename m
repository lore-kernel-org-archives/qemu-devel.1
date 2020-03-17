Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B21FC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F07820735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F07820735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFCo-0003Oc-57
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEF0N-0008OW-JD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEF0L-0007k7-4Y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:23:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEF0K-0006kl-5u; Tue, 17 Mar 2020 12:23:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07459419|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.0246713-0.00010672-0.975222;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03300; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H1.4XYF_1584462212; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.4XYF_1584462212) by smtp.aliyun-inc.com(10.147.40.7);
 Wed, 18 Mar 2020 00:23:33 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 38/61] target/riscv: vector floating-point sign-injection
 instructions
Date: Tue, 17 Mar 2020 23:06:30 +0800
Message-Id: <20200317150653.9008-39-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   | 19 +++++++
 target/riscv/insn32.decode              |  6 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  8 +++
 target/riscv/vector_helper.c            | 76 +++++++++++++++++++++++++
 4 files changed, 109 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 47d91933de..44aefdf752 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -930,3 +930,22 @@ DEF_HELPER_6(vfmin_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmax_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmax_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmax_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vfsgnj_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnj_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnj_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnj_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnj_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnj_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 5ec5595e2c..ce2f497ed2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -494,6 +494,12 @@ vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
 vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
 vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
 vfmax_vf        000110 . ..... ..... 101 ..... 1010111 @r_vm
+vfsgnj_vv       001000 . ..... ..... 001 ..... 1010111 @r_vm
+vfsgnj_vf       001000 . ..... ..... 101 ..... 1010111 @r_vm
+vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
+vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
+vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
+vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 0c00d44e21..866957fd24 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1992,3 +1992,11 @@ GEN_OPFVV_TRANS(vfmin_vv, opfvv_check)
 GEN_OPFVV_TRANS(vfmax_vv, opfvv_check)
 GEN_OPFVF_TRANS(vfmin_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfmax_vf, opfvf_check)
+
+/* Vector Floating-Point Sign-Injection Instructions */
+GEN_OPFVV_TRANS(vfsgnj_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfsgnjn_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfsgnjx_vv, opfvv_check)
+GEN_OPFVF_TRANS(vfsgnj_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfsgnjn_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfsgnjx_vf, opfvf_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f80b522c47..4beff0e54c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3795,3 +3795,79 @@ RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
 GEN_VEXT_VF(vfmax_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfmax_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfmax_vf_d, 8, 8, clearq)
+
+/* Vector Floating-Point Sign-Injection Instructions */
+static uint16_t fsgnj16(uint16_t a, uint16_t b, float_status *s)
+{
+    return deposit64(b, 0, 15, a);
+}
+static uint32_t fsgnj32(uint32_t a, uint32_t b, float_status *s)
+{
+    return deposit64(b, 0, 31, a);
+}
+static uint64_t fsgnj64(uint64_t a, uint64_t b, float_status *s)
+{
+    return deposit64(b, 0, 63, a);
+}
+RVVCALL(OPFVV2, vfsgnj_vv_h, OP_UUU_H, H2, H2, H2, fsgnj16)
+RVVCALL(OPFVV2, vfsgnj_vv_w, OP_UUU_W, H4, H4, H4, fsgnj32)
+RVVCALL(OPFVV2, vfsgnj_vv_d, OP_UUU_D, H8, H8, H8, fsgnj64)
+GEN_VEXT_VV_ENV(vfsgnj_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfsgnj_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfsgnj_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfsgnj_vf_h, OP_UUU_H, H2, H2, fsgnj16)
+RVVCALL(OPFVF2, vfsgnj_vf_w, OP_UUU_W, H4, H4, fsgnj32)
+RVVCALL(OPFVF2, vfsgnj_vf_d, OP_UUU_D, H8, H8, fsgnj64)
+GEN_VEXT_VF(vfsgnj_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfsgnj_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfsgnj_vf_d, 8, 8, clearq)
+
+static uint16_t fsgnjn16(uint16_t a, uint16_t b, float_status *s)
+{
+    return deposit64(~b, 0, 15, a);
+}
+static uint32_t fsgnjn32(uint32_t a, uint32_t b, float_status *s)
+{
+    return deposit64(~b, 0, 31, a);
+}
+static uint64_t fsgnjn64(uint64_t a, uint64_t b, float_status *s)
+{
+    return deposit64(~b, 0, 63, a);
+}
+RVVCALL(OPFVV2, vfsgnjn_vv_h, OP_UUU_H, H2, H2, H2, fsgnjn16)
+RVVCALL(OPFVV2, vfsgnjn_vv_w, OP_UUU_W, H4, H4, H4, fsgnjn32)
+RVVCALL(OPFVV2, vfsgnjn_vv_d, OP_UUU_D, H8, H8, H8, fsgnjn64)
+GEN_VEXT_VV_ENV(vfsgnjn_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfsgnjn_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfsgnjn_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfsgnjn_vf_h, OP_UUU_H, H2, H2, fsgnjn16)
+RVVCALL(OPFVF2, vfsgnjn_vf_w, OP_UUU_W, H4, H4, fsgnjn32)
+RVVCALL(OPFVF2, vfsgnjn_vf_d, OP_UUU_D, H8, H8, fsgnjn64)
+GEN_VEXT_VF(vfsgnjn_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfsgnjn_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfsgnjn_vf_d, 8, 8, clearq)
+
+static uint16_t fsgnjx16(uint16_t a, uint16_t b, float_status *s)
+{
+    return deposit64(b ^ a, 0, 15, a);
+}
+static uint32_t fsgnjx32(uint32_t a, uint32_t b, float_status *s)
+{
+    return deposit64(b ^ a, 0, 31, a);
+}
+static uint64_t fsgnjx64(uint64_t a, uint64_t b, float_status *s)
+{
+    return deposit64(b ^ a, 0, 63, a);
+}
+RVVCALL(OPFVV2, vfsgnjx_vv_h, OP_UUU_H, H2, H2, H2, fsgnjx16)
+RVVCALL(OPFVV2, vfsgnjx_vv_w, OP_UUU_W, H4, H4, H4, fsgnjx32)
+RVVCALL(OPFVV2, vfsgnjx_vv_d, OP_UUU_D, H8, H8, H8, fsgnjx64)
+GEN_VEXT_VV_ENV(vfsgnjx_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfsgnjx_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfsgnjx_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfsgnjx_vf_h, OP_UUU_H, H2, H2, fsgnjx16)
+RVVCALL(OPFVF2, vfsgnjx_vf_w, OP_UUU_W, H4, H4, fsgnjx32)
+RVVCALL(OPFVF2, vfsgnjx_vf_d, OP_UUU_D, H8, H8, fsgnjx64)
+GEN_VEXT_VF(vfsgnjx_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfsgnjx_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfsgnjx_vf_d, 8, 8, clearq)
-- 
2.23.0


