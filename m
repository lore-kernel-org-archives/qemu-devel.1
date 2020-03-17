Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB33C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D71E20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D71E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFfE-0007T7-DU
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFbO-0001lE-Ud
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFbN-0005w1-Db
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:02:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEFbM-0004sZ-9B; Tue, 17 Mar 2020 13:02:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07453695|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_alarm|0.310816-0.00051888-0.688665; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03300; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=10; RT=10; SR=0;
 TI=SMTPD_---.H1.nHL6_1584464506; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.nHL6_1584464506)
 by smtp.aliyun-inc.com(10.147.42.241);
 Wed, 18 Mar 2020 01:01:47 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 57/61] target/riscv: floating-point scalar move instructions
Date: Tue, 17 Mar 2020 23:06:49 +0800
Message-Id: <20200317150653.9008-58-zhiwei_liu@c-sky.com>
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
---
 target/riscv/helper.h                   |  4 ++
 target/riscv/insn32.decode              |  2 +
 target/riscv/insn_trans/trans_rvv.inc.c | 72 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 15 ++++++
 4 files changed, 93 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 2e3bfdf1dc..044538aef9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1114,3 +1114,7 @@ DEF_HELPER_3(vmv_s_x_b, void, ptr, tl, env)
 DEF_HELPER_3(vmv_s_x_h, void, ptr, tl, env)
 DEF_HELPER_3(vmv_s_x_w, void, ptr, tl, env)
 DEF_HELPER_3(vmv_s_x_d, void, ptr, tl, env)
+
+DEF_HELPER_3(vfmv_s_f_h, void, ptr, i64, env)
+DEF_HELPER_3(vfmv_s_f_w, void, ptr, i64, env)
+DEF_HELPER_3(vfmv_s_f_d, void, ptr, i64, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0741a25540..79f9b37b29 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -563,6 +563,8 @@ viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
+vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
+vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 4cf4e54d12..07033662c3 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2464,3 +2464,75 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
     }
     return false;
 }
+
+/* Floating-Point Scalar Move Instructions */
+static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
+{
+    if (!s->vill && has_ext(s, RVF) &&
+        (s->mstatus_fs != 0) && (s->sew != 0)) {
+#ifdef HOST_WORDS_BIGENDIAN
+        int ofs = vreg_ofs(s, a->rs2) + ((7 >> s->sew) << s->sew);
+#else
+        int ofs = vreg_ofs(s, a->rs2);
+#endif
+        switch (s->sew) {
+        case MO_8:
+            tcg_gen_ld8u_i64(cpu_fpr[a->rd], cpu_env, ofs);
+            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
+                            0xffffffffffffff00ULL);
+            break;
+        case MO_16:
+            tcg_gen_ld16u_i64(cpu_fpr[a->rd], cpu_env, ofs);
+            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
+                            0xffffffffffff0000ULL);
+            break;
+        case MO_32:
+            tcg_gen_ld32u_i64(cpu_fpr[a->rd], cpu_env, ofs);
+            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
+                            0xffffffff00000000ULL);
+            break;
+        default:
+            if (has_ext(s, RVD)) {
+                tcg_gen_ld_i64(cpu_fpr[a->rd], cpu_env, ofs);
+            } else {
+                tcg_gen_ld32u_i64(cpu_fpr[a->rd], cpu_env, ofs);
+                tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
+                                0xffffffff00000000ULL);
+            }
+            break;
+        }
+        mark_fs_dirty(s);
+        return true;
+    }
+    return false;
+}
+
+typedef void gen_helper_vfmv_s_f(TCGv_ptr, TCGv_i64, TCGv_env);
+static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
+{
+    if (!s->vill && has_ext(s, RVF) && (s->sew != 0)) {
+        TCGv_ptr dest;
+        TCGv_i64 src1;
+        static gen_helper_vfmv_s_f * const fns[3] = {
+            gen_helper_vfmv_s_f_h,
+            gen_helper_vfmv_s_f_w,
+            gen_helper_vfmv_s_f_d
+        };
+
+        src1 = tcg_temp_new_i64();
+        dest = tcg_temp_new_ptr();
+        if (s->sew == MO_64 && !has_ext(s, RVD)) {
+            tcg_gen_ori_i64(src1, cpu_fpr[a->rs1], 0xffffffff00000000ULL);
+        } else {
+            tcg_gen_mov_i64(src1, cpu_fpr[a->rs1]);
+        }
+        tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+
+        fns[s->sew - 1](dest, src1, cpu_env);
+
+        tcg_temp_free_i64(src1);
+        tcg_temp_free_ptr(dest);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7f67a283c9..723e15a670 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4691,3 +4691,18 @@ GEN_VEXT_VMV_S_X(vmv_s_x_b, uint8_t, H1, clearb)
 GEN_VEXT_VMV_S_X(vmv_s_x_h, uint16_t, H2, clearh)
 GEN_VEXT_VMV_S_X(vmv_s_x_w, uint32_t, H4, clearl)
 GEN_VEXT_VMV_S_X(vmv_s_x_d, uint64_t, H8, clearq)
+
+/* Floating-Point Scalar Move Instructions */
+#define GEN_VEXT_VFMV_S_F(NAME, ETYPE, H, CLEAR_FN)                     \
+void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env)            \
+{                                                                       \
+    if (env->vl == 0) {                                                 \
+        return;                                                         \
+    }                                                                   \
+    *((ETYPE *)vd + H(0)) = s1;                                         \
+    CLEAR_FN(vd, 1, sizeof(ETYPE), env_archcpu(env)->cfg.vlen / 8);     \
+}
+
+GEN_VEXT_VFMV_S_F(vfmv_s_f_h, uint16_t, H2, clearh)
+GEN_VEXT_VFMV_S_F(vfmv_s_f_w, uint32_t, H4, clearl)
+GEN_VEXT_VFMV_S_F(vfmv_s_f_d, uint64_t, H8, clearq)
-- 
2.23.0


