Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F198C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3529B206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3529B206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQM4-0007UZ-CT
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQJS-0008Uv-9Q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQJQ-0007sj-WB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:03:58 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42233)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCQJQ-0007Xf-FP; Thu, 12 Mar 2020 12:03:56 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2037875|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.0210286-5.86582e-05-0.978913;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03303; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-PP7tk_1584029025; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-PP7tk_1584029025)
 by smtp.aliyun-inc.com(10.147.42.16); Fri, 13 Mar 2020 00:03:45 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 32/60] target/riscv: vector widening floating-point multiply
Date: Thu, 12 Mar 2020 22:58:32 +0800
Message-Id: <20200312145900.2054-33-zhiwei_liu@c-sky.com>
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  5 +++++
 target/riscv/insn32.decode              |  2 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  4 ++++
 target/riscv/vector_helper.c            | 22 ++++++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a2d7ed19a8..3ec2dcadd4 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -834,3 +834,8 @@ DEF_HELPER_6(vfdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vfwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 050b2fd467..e0ee8f5a7c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -456,6 +456,8 @@ vfmul_vf        100100 . ..... ..... 101 ..... 1010111 @r_vm
 vfdiv_vv        100000 . ..... ..... 001 ..... 1010111 @r_vm
 vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
 vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
+vfwmul_vv       111000 . ..... ..... 001 ..... 1010111 @r_vm
+vfwmul_vf       111000 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 8dcbff6c64..b4d3797685 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1802,3 +1802,7 @@ GEN_OPFVV_TRANS(vfdiv_vv, opfvv_check)
 GEN_OPFVF_TRANS(vfmul_vf,  opfvf_check)
 GEN_OPFVF_TRANS(vfdiv_vf,  opfvf_check)
 GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
+
+/* Vector Widening Floating-Point Multiply */
+GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bd7ee4de18..8bb6ac158f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3154,3 +3154,25 @@ RVVCALL(OPFVF2, vfrdiv_vf_d, OP_UUU_D, H8, H8, float64_rdiv)
 GEN_VEXT_VF(vfrdiv_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfrdiv_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfrdiv_vf_d, 8, 8, clearq)
+
+/* Vector Widening Floating-Point Multiply */
+static uint32_t vfwmul16(uint16_t a, uint16_t b, float_status *s)
+{
+    return float32_mul(float16_to_float32(a, true, s),
+            float16_to_float32(b, true, s), s);
+}
+
+static uint64_t vfwmul32(uint32_t a, uint32_t b, float_status *s)
+{
+    return float64_mul(float32_to_float64(a, s),
+            float32_to_float64(b, s), s);
+
+}
+RVVCALL(OPFVV2, vfwmul_vv_h, WOP_UUU_H, H4, H2, H2, vfwmul16)
+RVVCALL(OPFVV2, vfwmul_vv_w, WOP_UUU_W, H8, H4, H4, vfwmul32)
+GEN_VEXT_VV_ENV(vfwmul_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwmul_vv_w, 4, 8, clearq)
+RVVCALL(OPFVF2, vfwmul_vf_h, WOP_UUU_H, H4, H2, vfwmul16)
+RVVCALL(OPFVF2, vfwmul_vf_w, WOP_UUU_W, H8, H4, vfwmul32)
+GEN_VEXT_VF(vfwmul_vf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwmul_vf_w, 4, 8, clearq)
-- 
2.23.0


