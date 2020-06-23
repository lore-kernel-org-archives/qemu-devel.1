Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C572FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A034208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A034208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnsKN-0003eE-OG
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 19:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnsHG-0006wU-JQ; Tue, 23 Jun 2020 19:24:30 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnsHD-0004cN-RU; Tue, 23 Jun 2020 19:24:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.169839|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_regular_dialog|0.208831-0.00023773-0.790931;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03310; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=8; SR=0; TI=SMTPD_---.HrTA6vW_1592954662; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HrTA6vW_1592954662)
 by smtp.aliyun-inc.com(10.147.41.178);
 Wed, 24 Jun 2020 07:24:23 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v11 42/61] target/riscv: vector floating-point/integer
 type-convert instructions
Date: Wed, 24 Jun 2020 05:59:01 +0800
Message-Id: <20200623215920.2594-43-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200623215920.2594-1-zhiwei_liu@c-sky.com>
References: <20200623215920.2594-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 17:32:41
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 13 ++++++++++
 target/riscv/insn32.decode              |  4 +++
 target/riscv/insn_trans/trans_rvv.inc.c |  6 +++++
 target/riscv/vector_helper.c            | 33 +++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 2c3f0a4e0c..d01e739607 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1004,3 +1004,16 @@ DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmerge_vfm_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmerge_vfm_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmerge_vfm_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(vfcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_xu_f_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_x_f_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_xu_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_x_v_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 38e7445a16..913c3b099b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -517,6 +517,10 @@ vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
 vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
 vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
 vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
+vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
+vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
+vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
+vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b6872376ce..ed238edfa9 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2222,3 +2222,9 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
     }
     return false;
 }
+
+/* Single-Width Floating-Point/Integer Type-Convert Instructions */
+GEN_OPFV_TRANS(vfcvt_xu_f_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_x_f_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_f_xu_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 51c86a5acf..3e78c5e12a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4218,3 +4218,36 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
 GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2, clearh)
 GEN_VFMERGE_VF(vfmerge_vfm_w, int32_t, H4, clearl)
 GEN_VFMERGE_VF(vfmerge_vfm_d, int64_t, H8, clearq)
+
+/* Single-Width Floating-Point/Integer Type-Convert Instructions */
+/* vfcvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
+RVVCALL(OPFVV1, vfcvt_xu_f_v_h, OP_UU_H, H2, H2, float16_to_uint16)
+RVVCALL(OPFVV1, vfcvt_xu_f_v_w, OP_UU_W, H4, H4, float32_to_uint32)
+RVVCALL(OPFVV1, vfcvt_xu_f_v_d, OP_UU_D, H8, H8, float64_to_uint64)
+GEN_VEXT_V_ENV(vfcvt_xu_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_xu_f_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_xu_f_v_d, 8, 8, clearq)
+
+/* vfcvt.x.f.v vd, vs2, vm # Convert float to signed integer. */
+RVVCALL(OPFVV1, vfcvt_x_f_v_h, OP_UU_H, H2, H2, float16_to_int16)
+RVVCALL(OPFVV1, vfcvt_x_f_v_w, OP_UU_W, H4, H4, float32_to_int32)
+RVVCALL(OPFVV1, vfcvt_x_f_v_d, OP_UU_D, H8, H8, float64_to_int64)
+GEN_VEXT_V_ENV(vfcvt_x_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_x_f_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_x_f_v_d, 8, 8, clearq)
+
+/* vfcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to float. */
+RVVCALL(OPFVV1, vfcvt_f_xu_v_h, OP_UU_H, H2, H2, uint16_to_float16)
+RVVCALL(OPFVV1, vfcvt_f_xu_v_w, OP_UU_W, H4, H4, uint32_to_float32)
+RVVCALL(OPFVV1, vfcvt_f_xu_v_d, OP_UU_D, H8, H8, uint64_to_float64)
+GEN_VEXT_V_ENV(vfcvt_f_xu_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_f_xu_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_f_xu_v_d, 8, 8, clearq)
+
+/* vfcvt.f.x.v vd, vs2, vm # Convert integer to float. */
+RVVCALL(OPFVV1, vfcvt_f_x_v_h, OP_UU_H, H2, H2, int16_to_float16)
+RVVCALL(OPFVV1, vfcvt_f_x_v_w, OP_UU_W, H4, H4, int32_to_float32)
+RVVCALL(OPFVV1, vfcvt_f_x_v_d, OP_UU_D, H8, H8, int64_to_float64)
+GEN_VEXT_V_ENV(vfcvt_f_x_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_f_x_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_f_x_v_d, 8, 8, clearq)
-- 
2.23.0


