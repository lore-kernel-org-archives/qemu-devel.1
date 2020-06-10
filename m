Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA41C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3296220734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3296220734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizfU-0000oC-Ax
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jizSi-0007gE-39; Wed, 10 Jun 2020 08:04:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jizSg-0004N8-E4; Wed, 10 Jun 2020 08:04:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0817015|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.44655-0.0111531-0.542297;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16367; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=8; SR=0; TI=SMTPD_---.HkZiW-a_1591790640; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HkZiW-a_1591790640)
 by smtp.aliyun-inc.com(10.147.40.44); Wed, 10 Jun 2020 20:04:01 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v9 13/61] target/riscv: vector bitwise logical instructions
Date: Wed, 10 Jun 2020 19:37:00 +0800
Message-Id: <20200610113748.4754-14-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200610113748.4754-1-zhiwei_liu@c-sky.com>
References: <20200610113748.4754-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 07:37:52
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
 target/riscv/helper.h                   | 25 ++++++++++++
 target/riscv/insn32.decode              |  9 +++++
 target/riscv/insn_trans/trans_rvv.inc.c | 11 ++++++
 target/riscv/vector_helper.c            | 51 +++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 186d72a2aa..ea4a4a6054 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -376,3 +376,28 @@ DEF_HELPER_6(vmsbc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmsbc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmsbc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmsbc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vand_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vand_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vand_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vand_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 022c8ea18b..3ad6724632 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -311,6 +311,15 @@ vsbc_vvm        010010 1 ..... ..... 000 ..... 1010111 @r_vm_1
 vsbc_vxm        010010 1 ..... ..... 100 ..... 1010111 @r_vm_1
 vmsbc_vvm       010011 1 ..... ..... 000 ..... 1010111 @r_vm_1
 vmsbc_vxm       010011 1 ..... ..... 100 ..... 1010111 @r_vm_1
+vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
+vand_vx         001001 . ..... ..... 100 ..... 1010111 @r_vm
+vand_vi         001001 . ..... ..... 011 ..... 1010111 @r_vm
+vor_vv          001010 . ..... ..... 000 ..... 1010111 @r_vm
+vor_vx          001010 . ..... ..... 100 ..... 1010111 @r_vm
+vor_vi          001010 . ..... ..... 011 ..... 1010111 @r_vm
+vxor_vv         001011 . ..... ..... 000 ..... 1010111 @r_vm
+vxor_vx         001011 . ..... ..... 100 ..... 1010111 @r_vm
+vxor_vi         001011 . ..... ..... 011 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 6fe2f071e6..35c92986a6 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1362,3 +1362,14 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
 
 GEN_OPIVI_TRANS(vadc_vim, 0, vadc_vxm, opivx_vadc_check)
 GEN_OPIVI_TRANS(vmadc_vim, 0, vmadc_vxm, opivx_vmadc_check)
+
+/* Vector Bitwise Logical Instructions */
+GEN_OPIVV_GVEC_TRANS(vand_vv, and)
+GEN_OPIVV_GVEC_TRANS(vor_vv,  or)
+GEN_OPIVV_GVEC_TRANS(vxor_vv, xor)
+GEN_OPIVX_GVEC_TRANS(vand_vx, ands)
+GEN_OPIVX_GVEC_TRANS(vor_vx,  ors)
+GEN_OPIVX_GVEC_TRANS(vxor_vx, xors)
+GEN_OPIVI_GVEC_TRANS(vand_vi, 0, vand_vx, andi)
+GEN_OPIVI_GVEC_TRANS(vor_vi, 0, vor_vx,  ori)
+GEN_OPIVI_GVEC_TRANS(vxor_vi, 0, vxor_vx, xori)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ad746175bd..6c53dc5796 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1265,3 +1265,54 @@ GEN_VEXT_VMADC_VXM(vmsbc_vxm_b, uint8_t,  H1, DO_MSBC)
 GEN_VEXT_VMADC_VXM(vmsbc_vxm_h, uint16_t, H2, DO_MSBC)
 GEN_VEXT_VMADC_VXM(vmsbc_vxm_w, uint32_t, H4, DO_MSBC)
 GEN_VEXT_VMADC_VXM(vmsbc_vxm_d, uint64_t, H8, DO_MSBC)
+
+/* Vector Bitwise Logical Instructions */
+RVVCALL(OPIVV2, vand_vv_b, OP_SSS_B, H1, H1, H1, DO_AND)
+RVVCALL(OPIVV2, vand_vv_h, OP_SSS_H, H2, H2, H2, DO_AND)
+RVVCALL(OPIVV2, vand_vv_w, OP_SSS_W, H4, H4, H4, DO_AND)
+RVVCALL(OPIVV2, vand_vv_d, OP_SSS_D, H8, H8, H8, DO_AND)
+RVVCALL(OPIVV2, vor_vv_b, OP_SSS_B, H1, H1, H1, DO_OR)
+RVVCALL(OPIVV2, vor_vv_h, OP_SSS_H, H2, H2, H2, DO_OR)
+RVVCALL(OPIVV2, vor_vv_w, OP_SSS_W, H4, H4, H4, DO_OR)
+RVVCALL(OPIVV2, vor_vv_d, OP_SSS_D, H8, H8, H8, DO_OR)
+RVVCALL(OPIVV2, vxor_vv_b, OP_SSS_B, H1, H1, H1, DO_XOR)
+RVVCALL(OPIVV2, vxor_vv_h, OP_SSS_H, H2, H2, H2, DO_XOR)
+RVVCALL(OPIVV2, vxor_vv_w, OP_SSS_W, H4, H4, H4, DO_XOR)
+RVVCALL(OPIVV2, vxor_vv_d, OP_SSS_D, H8, H8, H8, DO_XOR)
+GEN_VEXT_VV(vand_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vand_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vand_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vand_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vor_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vor_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vor_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vor_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vxor_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vxor_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vxor_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vxor_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2, vand_vx_b, OP_SSS_B, H1, H1, DO_AND)
+RVVCALL(OPIVX2, vand_vx_h, OP_SSS_H, H2, H2, DO_AND)
+RVVCALL(OPIVX2, vand_vx_w, OP_SSS_W, H4, H4, DO_AND)
+RVVCALL(OPIVX2, vand_vx_d, OP_SSS_D, H8, H8, DO_AND)
+RVVCALL(OPIVX2, vor_vx_b, OP_SSS_B, H1, H1, DO_OR)
+RVVCALL(OPIVX2, vor_vx_h, OP_SSS_H, H2, H2, DO_OR)
+RVVCALL(OPIVX2, vor_vx_w, OP_SSS_W, H4, H4, DO_OR)
+RVVCALL(OPIVX2, vor_vx_d, OP_SSS_D, H8, H8, DO_OR)
+RVVCALL(OPIVX2, vxor_vx_b, OP_SSS_B, H1, H1, DO_XOR)
+RVVCALL(OPIVX2, vxor_vx_h, OP_SSS_H, H2, H2, DO_XOR)
+RVVCALL(OPIVX2, vxor_vx_w, OP_SSS_W, H4, H4, DO_XOR)
+RVVCALL(OPIVX2, vxor_vx_d, OP_SSS_D, H8, H8, DO_XOR)
+GEN_VEXT_VX(vand_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vand_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vand_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vand_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vor_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vor_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vor_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vor_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vxor_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vxor_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vxor_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vxor_vx_d, 8, 8, clearq)
-- 
2.23.0


