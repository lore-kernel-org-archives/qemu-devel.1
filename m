Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F9EC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FF320752
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FF320752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFEn-0008IV-7w
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEEyL-00046v-BI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEEyK-0002qd-1m
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:21:41 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:51107)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEEyJ-0002WC-38; Tue, 17 Mar 2020 12:21:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1364813|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.0106247-0.000108178-0.989267;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03305; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H1.4VU3_1584462092; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.4VU3_1584462092) by smtp.aliyun-inc.com(10.147.40.7);
 Wed, 18 Mar 2020 00:21:32 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 37/61] target/riscv: vector floating-point min/max
 instructions
Date: Tue, 17 Mar 2020 23:06:29 +0800
Message-Id: <20200317150653.9008-38-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   | 13 ++++++++++++
 target/riscv/insn32.decode              |  4 ++++
 target/riscv/insn_trans/trans_rvv.inc.c |  6 ++++++
 target/riscv/vector_helper.c            | 27 +++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a5d3a5a832..47d91933de 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -917,3 +917,16 @@ DEF_HELPER_6(vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vfmin_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmin_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmin_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmax_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmax_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmax_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmin_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmin_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmin_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmax_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmax_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmax_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4ea71eaf39..5ec5595e2c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -490,6 +490,10 @@ vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
 vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
 vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
 vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
+vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
+vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
+vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
+vfmax_vf        000110 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index bea126c07b..0c00d44e21 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1986,3 +1986,9 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
     return false;                                                  \
 }
 GEN_OPFV_TRANS(vfsqrt_v, opfv_check)
+
+/* Vector Floating-Point MIN/MAX Instructions */
+GEN_OPFVV_TRANS(vfmin_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfmax_vv, opfvv_check)
+GEN_OPFVF_TRANS(vfmin_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfmax_vf, opfvf_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 342ba0c196..f80b522c47 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3768,3 +3768,30 @@ RVVCALL(OPFVV1, vfsqrt_v_d, OP_UU_D, H8, H8, float64_sqrt)
 GEN_VEXT_V_ENV(vfsqrt_v_h, 2, 2, clearh)
 GEN_VEXT_V_ENV(vfsqrt_v_w, 4, 4, clearl)
 GEN_VEXT_V_ENV(vfsqrt_v_d, 8, 8, clearq)
+
+/* Vector Floating-Point MIN/MAX Instructions */
+RVVCALL(OPFVV2, vfmin_vv_h, OP_UUU_H, H2, H2, H2, float16_minnum)
+RVVCALL(OPFVV2, vfmin_vv_w, OP_UUU_W, H4, H4, H4, float32_minnum)
+RVVCALL(OPFVV2, vfmin_vv_d, OP_UUU_D, H8, H8, H8, float64_minnum)
+GEN_VEXT_VV_ENV(vfmin_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmin_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmin_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfmin_vf_h, OP_UUU_H, H2, H2, float16_minnum)
+RVVCALL(OPFVF2, vfmin_vf_w, OP_UUU_W, H4, H4, float32_minnum)
+RVVCALL(OPFVF2, vfmin_vf_d, OP_UUU_D, H8, H8, float64_minnum)
+GEN_VEXT_VF(vfmin_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmin_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmin_vf_d, 8, 8, clearq)
+
+RVVCALL(OPFVV2, vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_maxnum)
+RVVCALL(OPFVV2, vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_maxnum)
+RVVCALL(OPFVV2, vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_maxnum)
+GEN_VEXT_VV_ENV(vfmax_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmax_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmax_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfmax_vf_h, OP_UUU_H, H2, H2, float16_maxnum)
+RVVCALL(OPFVF2, vfmax_vf_w, OP_UUU_W, H4, H4, float32_maxnum)
+RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
+GEN_VEXT_VF(vfmax_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmax_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmax_vf_d, 8, 8, clearq)
-- 
2.23.0


