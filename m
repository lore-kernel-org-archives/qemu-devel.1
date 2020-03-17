Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A81CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A1C20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A1C20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFei-000786-AL
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFdJ-0005Ca-Mw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFdF-0001Op-Hj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:04:01 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEFdE-0000Nl-Lz; Tue, 17 Mar 2020 13:03:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07608282|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.794941-0.00014484-0.204914;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03307; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H1.uSSL_1584464627; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.uSSL_1584464627)
 by smtp.aliyun-inc.com(10.147.44.118);
 Wed, 18 Mar 2020 01:03:48 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 58/61] target/riscv: vector slide instructions
Date: Tue, 17 Mar 2020 23:06:50 +0800
Message-Id: <20200317150653.9008-59-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  17 ++++
 target/riscv/insn32.decode              |   7 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  17 ++++
 target/riscv/vector_helper.c            | 128 ++++++++++++++++++++++++
 4 files changed, 169 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 044538aef9..3b1612012c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1118,3 +1118,20 @@ DEF_HELPER_3(vmv_s_x_d, void, ptr, tl, env)
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
index 79f9b37b29..34ccad53a9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -72,6 +72,7 @@
 @r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
 @r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
+@r2rd    .......   ..... ..... ... ..... ....... %rs2 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
 @r_vm_0  ...... . ..... ..... ... ..... .......    &rmrr vm=0 %rs2 %rs1 %rd
@@ -565,6 +566,12 @@ vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
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
index 07033662c3..10482fd1d4 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2536,3 +2536,20 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
     }
     return false;
 }
+
+/* Vector Slide Instructions */
+static bool slideup_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
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
index 723e15a670..b0439ac3d1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4706,3 +4706,131 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env)            \
 GEN_VEXT_VFMV_S_F(vfmv_s_f_h, uint16_t, H2, clearh)
 GEN_VEXT_VFMV_S_F(vfmv_s_f_w, uint32_t, H4, clearl)
 GEN_VEXT_VFMV_S_F(vfmv_s_f_d, uint64_t, H8, clearq)
+
+/* Vector Slide Instructions */
+#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    target_ulong offset = s1, i;                                          \
+                                                                          \
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
+    for (i = offset; i < vl; i++) {                                       \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
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
+    target_ulong offset = s1, i, max;                                     \
+                                                                          \
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
+    if (offset >= vlmax) {                                                \
+        max = 0;                                                          \
+    } else {                                                              \
+        max = MIN(vl, vlmax - offset);                                    \
+    }                                                                     \
+    for (i = 0; i < max; ++i) {                                           \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + offset));          \
+    }                                                                     \
+    CLEAR_FN(vd, max, max * sizeof(ETYPE), vlmax * sizeof(ETYPE));        \
+}
+
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
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
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
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
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
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
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
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+/* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
-- 
2.23.0


