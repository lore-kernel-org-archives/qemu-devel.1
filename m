Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BBFC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E1720663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E1720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQZz-0005x7-Q0
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQZ2-0003RB-2r
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQZ0-0003v8-Mq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:20:04 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCQZ0-0003qe-5Z; Thu, 12 Mar 2020 12:20:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1174319|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.278274-0.000810745-0.720915;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03303; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-PQAXU_1584029993; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-PQAXU_1584029993)
 by smtp.aliyun-inc.com(10.147.42.198);
 Fri, 13 Mar 2020 00:19:54 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 40/60] target/riscv: vector floating-point merge
 instructions
Date: Thu, 12 Mar 2020 22:58:40 +0800
Message-Id: <20200312145900.2054-41-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  4 ++++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 12 +++++++++++
 target/riscv/vector_helper.c            | 28 +++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 86f1498c06..c02b207b44 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -982,3 +982,7 @@ DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vfmerge_vfm_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmerge_vfm_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmerge_vfm_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 18b78ed82d..41074f314a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -508,6 +508,7 @@ vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
 vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
 vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
 vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
+vfmerge_vfm     010111 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 3971c3ebdb..1ddaee6dab 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1921,3 +1921,15 @@ GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
 
 /* Vector Floating-Point Classify Instruction */
 GEN_OPFV_TRANS(vfclass_v, opfv_check)
+
+/* Vector Floating-Point Merge Instruction */
+static bool opfvf_vfmerge_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            ((a->vm == 0) || (a->rs2 == 0)) &&
+            (s->sew != 0));
+}
+GEN_OPFVF_TRANS(vfmerge_vfm, opfvf_vfmerge_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e9f278643f..00f8d9344f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3914,3 +3914,31 @@ RVVCALL(OPFVV1, vfclass_v_d, OP_UU_D, H8, H8, fclass_d)
 GEN_VEXT_V_ENV(vfclass_v_h, 2, 2, clearh)
 GEN_VEXT_V_ENV(vfclass_v_w, 4, 4, clearl)
 GEN_VEXT_V_ENV(vfclass_v_d, 8, 8, clearq)
+
+/* Vector Floating-Point Merge Instruction */
+#define GEN_VFMERGE_VF(NAME, ETYPE, H, CLEAR_FN)          \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
+        void *vs2, CPURISCVState *env, uint32_t desc)     \
+{                                                         \
+    uint32_t mlen = vext_mlen(desc);                      \
+    uint32_t vm = vext_vm(desc);                          \
+    uint32_t vl = env->vl;                                \
+    uint32_t esz = sizeof(ETYPE);                         \
+    uint32_t vlmax = vext_maxsz(desc) / esz;              \
+    uint32_t i;                                           \
+                                                          \
+    for (i = 0; i < vl; i++) {                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
+            ETYPE s2 = *((ETYPE *)vs2 + H(i));            \
+            *((ETYPE *)vd + H1(i)) = s2;                  \
+        } else {                                          \
+            *((ETYPE *)vd + H(i)) = (ETYPE)s1;            \
+        }                                                 \
+    }                                                     \
+    if (i != 0) {                                         \
+        CLEAR_FN(vd, vl, vl * esz, vlmax * esz);          \
+    }                                                     \
+}
+GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2, clearh)
+GEN_VFMERGE_VF(vfmerge_vfm_w, int32_t, H4, clearl)
+GEN_VFMERGE_VF(vfmerge_vfm_d, int64_t, H8, clearq)
-- 
2.23.0


