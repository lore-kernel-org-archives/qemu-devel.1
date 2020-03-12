Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D61DC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5162067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5162067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRRS-0004IC-66
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCR6E-0007c8-3D
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCR6C-0002DX-DE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:54:22 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:32969)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCR6B-00027p-Fo; Thu, 12 Mar 2020 12:54:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07608268|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.659644-0.000124388-0.340232;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03299; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-QXzh9_1584032049; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-QXzh9_1584032049)
 by smtp.aliyun-inc.com(10.147.43.95); Fri, 13 Mar 2020 00:54:10 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 57/60] target/riscv: vector slide instructions
Date: Thu, 12 Mar 2020 22:58:57 +0800
Message-Id: <20200312145900.2054-58-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  17 +++
 target/riscv/insn32.decode              |   7 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  17 +++
 target/riscv/vector_helper.c            | 136 ++++++++++++++++++++++++
 4 files changed, 177 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 7a689a5c07..e86df5b9e4 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1120,3 +1120,20 @@ DEF_HELPER_3(vfmv_s_f_b, void, ptr, i64, env)
 DEF_HELPER_3(vfmv_s_f_h, void, ptr, i64, env)
 DEF_HELPER_3(vfmv_s_f_w, void, ptr, i64, env)
 DEF_HELPER_3(vfmv_s_f_d, void, ptr, i64, env)
+
+DEF_HELPER_6(vslideup_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslideup_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslideup_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslideup_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslidedown_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslidedown_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslidedown_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslidedown_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index bfdce0979c..e6ade9c68e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -72,6 +72,7 @@
 @r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
 @r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
+@r2rd    .......   ..... ..... ... ..... ....... %rs2 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
@@ -559,6 +560,12 @@ vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
 vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
+vslideup_vx     001110 . ..... ..... 100 ..... 1010111 @r_vm
+vslideup_vi     001110 . ..... ..... 011 ..... 1010111 @r_vm
+vslide1up_vx    001110 . ..... ..... 110 ..... 1010111 @r_vm
+vslidedown_vx   001111 . ..... ..... 100 ..... 1010111 @r_vm
+vslidedown_vi   001111 . ..... ..... 011 ..... 1010111 @r_vm
+vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 99cd45b0aa..ef5960ba39 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2316,3 +2316,20 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
     }
     return false;
 }
+
+/* Vector Slide Instructions */
+static bool slideup_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (a->rd != a->rs2));
+}
+GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
+GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
+GEN_OPIVI_TRANS(vslideup_vi, 1, vslideup_vx, slideup_check)
+
+GEN_OPIVX_TRANS(vslidedown_vx, opivx_check)
+GEN_OPIVX_TRANS(vslide1down_vx, opivx_check)
+GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 3235c3fbe1..2219fdd6c5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4511,3 +4511,139 @@ uint64_t HELPER(vfmv_f_s_d)(void *vs2, CPURISCVState *env)
         return deposit64(*((uint64_t *)vs2), 32, 32, 0xffffffff);
     }
 }
+
+/* Vector Slide Instructions */
+/*
+ * the spec doesn't specify the behavior when offset is lager than vl,
+ * just truncate the offset to vl here.
+ */
+#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t offset = s1, i;                                              \
+                                                                          \
+    if (offset > vl) {                                                    \
+        offset = vl;                                                      \
+    }                                                                     \
+    for (i = 0; i < vl; i++) {                                            \
+        if (((i < offset)) || (!vm && !vext_elem_mask(v0, mlen, i))) {    \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
+    }                                                                     \
+    if (i == 0) {                                                         \
+        return;                                                           \
+    }                                                                     \
+    for (; i < vlmax; i++) {                                              \
+        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
+    }                                                                     \
+}
+/* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_d, uint64_t, H8, clearq)
+
+#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t offset = s1, i;                                              \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        if (i + offset < vlmax) {                                         \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + offset));      \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = 0;                                    \
+        }                                                                 \
+    }                                                                     \
+    if (i == 0) {                                                         \
+        return;                                                           \
+    }                                                                     \
+    for (; i < vlmax; i++) {                                              \
+        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
+    }                                                                     \
+}
+/* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_d, uint64_t, H8, clearq)
+
+#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H, CLEAR_FN)                   \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t i;                                                           \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        if (i == 0) {                                                     \
+            *((ETYPE *)vd + H(i)) = s1;                                   \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
+        }                                                                 \
+    }                                                                     \
+    if (i == 0) {                                                         \
+        return;                                                           \
+    }                                                                     \
+    for (; i < vlmax; i++) {                                              \
+        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
+    }                                                                     \
+}
+/* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_d, uint64_t, H8, clearq)
+
+#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H, CLEAR_FN)                 \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t i;                                                           \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        if (i == vl - 1) {                                                \
+            *((ETYPE *)vd + H(i)) = s1;                                   \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));           \
+        }                                                                 \
+    }                                                                     \
+    if (i == 0) {                                                         \
+        return;                                                           \
+    }                                                                     \
+    for (; i < vlmax; i++) {                                              \
+        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
+    }                                                                     \
+}
+/* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
-- 
2.23.0


