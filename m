Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B2EC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B29C20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B29C20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFbA-0000zE-57
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFZR-0007Gr-AL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFZO-0007Nh-Bk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:00:00 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42131)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEFZN-0006uE-Ia; Tue, 17 Mar 2020 12:59:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07920329|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_alarm|0.58469-0.00050766-0.414802; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03311; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=10; RT=10; SR=0;
 TI=SMTPD_---.H1.rMX-_1584464386; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.rMX-_1584464386)
 by smtp.aliyun-inc.com(10.147.42.135);
 Wed, 18 Mar 2020 00:59:46 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 56/61] target/riscv: integer scalar move instruction
Date: Tue, 17 Mar 2020 23:06:48 +0800
Message-Id: <20200317150653.9008-57-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  5 +++++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 26 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 18 +++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 3d0e2e72bd..2e3bfdf1dc 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1109,3 +1109,8 @@ DEF_HELPER_4(vid_v_b, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vid_v_h, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vid_v_w, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vid_v_d, void, ptr, ptr, env, i32)
+
+DEF_HELPER_3(vmv_s_x_b, void, ptr, tl, env)
+DEF_HELPER_3(vmv_s_x_h, void, ptr, tl, env)
+DEF_HELPER_3(vmv_s_x_w, void, ptr, tl, env)
+DEF_HELPER_3(vmv_s_x_d, void, ptr, tl, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 26dd0f1b1b..0741a25540 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -562,6 +562,7 @@ vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
+vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 4d7bb6b54e..4cf4e54d12 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2438,3 +2438,29 @@ static bool trans_vext_x_v(DisasContext *s, arg_r *a)
     tcg_temp_free(dest);
     return true;
 }
+
+/* Integer Scalar Move Instruction */
+typedef void gen_helper_vmv_s_x(TCGv_ptr, TCGv, TCGv_env);
+static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
+{
+    if (vext_check_isa_ill(s)) {
+        TCGv_ptr dest;
+        TCGv src1;
+        static gen_helper_vmv_s_x * const fns[4] = {
+            gen_helper_vmv_s_x_b, gen_helper_vmv_s_x_h,
+            gen_helper_vmv_s_x_w, gen_helper_vmv_s_x_d
+        };
+
+        src1 = tcg_temp_new();
+        dest = tcg_temp_new_ptr();
+        gen_get_gpr(src1, a->rs1);
+        tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+
+        fns[s->sew](dest, src1, cpu_env);
+
+        tcg_temp_free(src1);
+        tcg_temp_free_ptr(dest);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 769894c5be..7f67a283c9 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4673,3 +4673,21 @@ GEN_VEXT_VID_V(vid_v_b, uint8_t, H1, clearb)
 GEN_VEXT_VID_V(vid_v_h, uint16_t, H2, clearh)
 GEN_VEXT_VID_V(vid_v_w, uint32_t, H4, clearl)
 GEN_VEXT_VID_V(vid_v_d, uint64_t, H8, clearq)
+
+/*
+ *** Vector Permutation Instructions
+ */
+/* Integer Scalar Move Instruction */
+#define GEN_VEXT_VMV_S_X(NAME, ETYPE, H, CLEAR_FN)                       \
+void HELPER(NAME)(void *vd, target_ulong s1, CPURISCVState *env)         \
+{                                                                        \
+    if (env->vl == 0) {                                                  \
+        return;                                                          \
+    }                                                                    \
+    *((ETYPE *)vd + H(0)) = s1;                                          \
+    CLEAR_FN(vd, 1, sizeof(ETYPE), env_archcpu(env)->cfg.vlen / 8);      \
+}
+GEN_VEXT_VMV_S_X(vmv_s_x_b, uint8_t, H1, clearb)
+GEN_VEXT_VMV_S_X(vmv_s_x_h, uint16_t, H2, clearh)
+GEN_VEXT_VMV_S_X(vmv_s_x_w, uint32_t, H4, clearl)
+GEN_VEXT_VMV_S_X(vmv_s_x_d, uint64_t, H8, clearq)
-- 
2.23.0


