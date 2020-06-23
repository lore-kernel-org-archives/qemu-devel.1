Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B5AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 00:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2FE2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 00:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2FE2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnsrP-0007pj-JV
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 20:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnsqJ-00076D-SH; Tue, 23 Jun 2020 20:00:43 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnsqH-0005Op-Ir; Tue, 23 Jun 2020 20:00:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07797299|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.16566-4.44909e-05-0.834296;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03302; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.HrTlBzw_1592956836; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HrTlBzw_1592956836)
 by smtp.aliyun-inc.com(10.147.42.197);
 Wed, 24 Jun 2020 08:00:36 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v11 60/61] target/riscv: vector compress instruction
Date: Wed, 24 Jun 2020 05:59:19 +0800
Message-Id: <20200623215920.2594-61-zhiwei_liu@c-sky.com>
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
 wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   |  5 ++++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 32 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 26 ++++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index eca1ab541b..acc298219d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1145,3 +1145,8 @@ DEF_HELPER_6(vrgather_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vcompress_vm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vcompress_vm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vcompress_vm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vcompress_vm_d, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 80d5ff74a9..bdd8563067 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -577,6 +577,7 @@ vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
 vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
 vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
 vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
+vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c0b7745a63..dc333e6a91 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2854,3 +2854,35 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
     }
     return true;
 }
+
+/* Vector Compress Instruction */
+static bool vcompress_vm_check(DisasContext *s, arg_r *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs1, 1) &&
+            (a->rd != a->rs2));
+}
+
+static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
+{
+    if (vcompress_vm_check(s, a)) {
+        uint32_t data = 0;
+        static gen_helper_gvec_4_ptr * const fns[4] = {
+            gen_helper_vcompress_vm_b, gen_helper_vcompress_vm_h,
+            gen_helper_vcompress_vm_w, gen_helper_vcompress_vm_d,
+        };
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
+                           cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7ee87154c1..dea1a398dc 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4871,3 +4871,29 @@ GEN_VEXT_VRGATHER_VX(vrgather_vx_b, uint8_t, H1, clearb)
 GEN_VEXT_VRGATHER_VX(vrgather_vx_h, uint16_t, H2, clearh)
 GEN_VEXT_VRGATHER_VX(vrgather_vx_w, uint32_t, H4, clearl)
 GEN_VEXT_VRGATHER_VX(vrgather_vx_d, uint64_t, H8, clearq)
+
+/* Vector Compress Instruction */
+#define GEN_VEXT_VCOMPRESS_VM(NAME, ETYPE, H, CLEAR_FN)                   \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vl = env->vl;                                                \
+    uint32_t num = 0, i;                                                  \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vext_elem_mask(vs1, mlen, i)) {                              \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(num)) = *((ETYPE *)vs2 + H(i));                 \
+        num++;                                                            \
+    }                                                                     \
+    CLEAR_FN(vd, num, num * sizeof(ETYPE), vlmax * sizeof(ETYPE));        \
+}
+
+/* Compress into vd elements of vs2 where vs1 is enabled */
+GEN_VEXT_VCOMPRESS_VM(vcompress_vm_b, uint8_t, H1, clearb)
+GEN_VEXT_VCOMPRESS_VM(vcompress_vm_h, uint16_t, H2, clearh)
+GEN_VEXT_VCOMPRESS_VM(vcompress_vm_w, uint32_t, H4, clearl)
+GEN_VEXT_VCOMPRESS_VM(vcompress_vm_d, uint64_t, H8, clearq)
-- 
2.23.0


