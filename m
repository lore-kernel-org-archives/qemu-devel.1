Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15BEC10F28
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975802083E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975802083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBDyE-0003Uk-RP
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBDgJ-0007Q3-Oa
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBDgG-0007zW-63
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:22:34 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBDgF-0007bS-Da; Mon, 09 Mar 2020 04:22:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1920636|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.208831-0.00023773-0.790931;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16384; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.GyTxIXp_1583742101; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GyTxIXp_1583742101)
 by smtp.aliyun-inc.com(10.147.41.137);
 Mon, 09 Mar 2020 16:22:03 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 41/60] target/riscv: vector floating-point/integer
 type-convert instructions
Date: Mon,  9 Mar 2020 16:20:23 +0800
Message-Id: <20200309082042.12967-42-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200309082042.12967-1-zhiwei_liu@c-sky.com>
References: <20200309082042.12967-1-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   | 13 ++++++++++
 target/riscv/insn32.decode              |  4 +++
 target/riscv/insn_trans/trans_rvv.inc.c |  6 +++++
 target/riscv/vector_helper.c            | 33 +++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c02b207b44..a34157e277 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -986,3 +986,16 @@ DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
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
index 41074f314a..6ca6f97323 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -509,6 +509,10 @@ vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
 vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
 vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
 vfmerge_vfm     010111 . ..... ..... 101 ..... 1010111 @r_vm
+vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
+vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
+vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
+vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 1ddaee6dab..a61c7fdf32 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1933,3 +1933,9 @@ static bool opfvf_vfmerge_check(DisasContext *s, arg_rmrr *a)
             (s->sew != 0));
 }
 GEN_OPFVF_TRANS(vfmerge_vfm, opfvf_vfmerge_check)
+
+/* Single-Width Floating-Point/Integer Type-Convert Instructions */
+GEN_OPFV_TRANS(vfcvt_xu_f_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_x_f_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_f_xu_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 00f8d9344f..d032745e94 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3942,3 +3942,36 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
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


