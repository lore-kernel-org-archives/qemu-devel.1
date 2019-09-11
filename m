Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539B8ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE52721928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE52721928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wPg-0003HO-Kx
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wE6-0007nD-8n
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDv-00088a-S5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDu-0007q7-7S; Wed, 11 Sep 2019 02:35:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.338074-0.00686125-0.655065; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01a16384; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRDwoS_1568183700; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRDwoS_1568183700)
 by smtp.aliyun-inc.com(10.147.40.200);
 Wed, 11 Sep 2019 14:35:01 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:37 +0800
Message-Id: <1568183141-67641-14-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 13/17] RISC-V: add vector extension float
 instruction part1, add/sub/mul/div
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |   37 +
 target/riscv/insn32.decode              |   37 +
 target/riscv/insn_trans/trans_rvv.inc.c |   37 +
 target/riscv/vector_helper.c            | 2645 +++++++++++++++++++++++++++++++
 4 files changed, 2756 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index ff6002e..d2c8684 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -307,5 +307,42 @@ DEF_HELPER_5(vector_vnclip_vv, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vnclip_vx, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vnclip_vi, void, env, i32, i32, i32, i32)
 
+DEF_HELPER_5(vector_vfadd_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfadd_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfsub_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfsub_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfrsub_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwadd_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwadd_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwadd_wv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwadd_wf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwsub_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwsub_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwsub_wv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwsub_wf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmul_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmul_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfdiv_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfdiv_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfrdiv_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwmul_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfwmul_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmacc_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmacc_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfnmacc_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfnmacc_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmsac_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmsac_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfnmsac_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfnmsac_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmadd_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmadd_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfnmadd_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfnmadd_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmsub_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfmsub_vf, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfnmsub_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vfnmsub_vf, void, env, i32, i32, i32, i32)
+
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index a82e53e..31868ab 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -447,5 +447,42 @@ vnclip_vv       101111 . ..... ..... 000 ..... 1010111 @r_vm
 vnclip_vx       101111 . ..... ..... 100 ..... 1010111 @r_vm
 vnclip_vi       101111 . ..... ..... 011 ..... 1010111 @r_vm
 
+vfadd_vv        000000 . ..... ..... 001 ..... 1010111 @r_vm
+vfadd_vf        000000 . ..... ..... 101 ..... 1010111 @r_vm
+vfsub_vv        000010 . ..... ..... 001 ..... 1010111 @r_vm
+vfsub_vf        000010 . ..... ..... 101 ..... 1010111 @r_vm
+vfrsub_vf       100111 . ..... ..... 101 ..... 1010111 @r_vm
+vfwadd_vv       110000 . ..... ..... 001 ..... 1010111 @r_vm
+vfwadd_vf       110000 . ..... ..... 101 ..... 1010111 @r_vm
+vfwadd_wv       110100 . ..... ..... 001 ..... 1010111 @r_vm
+vfwadd_wf       110100 . ..... ..... 101 ..... 1010111 @r_vm
+vfwsub_vv       110010 . ..... ..... 001 ..... 1010111 @r_vm
+vfwsub_vf       110010 . ..... ..... 101 ..... 1010111 @r_vm
+vfwsub_wv       110110 . ..... ..... 001 ..... 1010111 @r_vm
+vfwsub_wf       110110 . ..... ..... 101 ..... 1010111 @r_vm
+vfmul_vv        100100 . ..... ..... 001 ..... 1010111 @r_vm
+vfmul_vf        100100 . ..... ..... 101 ..... 1010111 @r_vm
+vfdiv_vv        100000 . ..... ..... 001 ..... 1010111 @r_vm
+vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
+vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
+vfwmul_vv       111000 . ..... ..... 001 ..... 1010111 @r_vm
+vfwmul_vf       111000 . ..... ..... 101 ..... 1010111 @r_vm
+vfmacc_vf       101100 . ..... ..... 101 ..... 1010111 @r_vm
+vfmacc_vv       101100 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmacc_vv      101101 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmacc_vf      101101 . ..... ..... 101 ..... 1010111 @r_vm
+vfmsac_vv       101110 . ..... ..... 001 ..... 1010111 @r_vm
+vfmsac_vf       101110 . ..... ..... 101 ..... 1010111 @r_vm
+vfnmsac_vv      101111 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmsac_vf      101111 . ..... ..... 101 ..... 1010111 @r_vm
+vfmadd_vv       101000 . ..... ..... 001 ..... 1010111 @r_vm
+vfmadd_vf       101000 . ..... ..... 101 ..... 1010111 @r_vm
+vfnmadd_vv      101001 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmadd_vf      101001 . ..... ..... 101 ..... 1010111 @r_vm
+vfmsub_vv       101010 . ..... ..... 001 ..... 1010111 @r_vm
+vfmsub_vf       101010 . ..... ..... 101 ..... 1010111 @r_vm
+vfnmsub_vv      101011 . ..... ..... 001 ..... 1010111 @r_vm
+vfnmsub_vf      101011 . ..... ..... 101 ..... 1010111 @r_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index d650e8c..ff23bc2 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -336,5 +336,42 @@ GEN_VECTOR_R_VM(vnclip_vv)
 GEN_VECTOR_R_VM(vnclip_vx)
 GEN_VECTOR_R_VM(vnclip_vi)
 
+GEN_VECTOR_R_VM(vfadd_vv)
+GEN_VECTOR_R_VM(vfadd_vf)
+GEN_VECTOR_R_VM(vfsub_vv)
+GEN_VECTOR_R_VM(vfsub_vf)
+GEN_VECTOR_R_VM(vfrsub_vf)
+GEN_VECTOR_R_VM(vfwadd_vv)
+GEN_VECTOR_R_VM(vfwadd_vf)
+GEN_VECTOR_R_VM(vfwadd_wv)
+GEN_VECTOR_R_VM(vfwadd_wf)
+GEN_VECTOR_R_VM(vfwsub_wv)
+GEN_VECTOR_R_VM(vfwsub_wf)
+GEN_VECTOR_R_VM(vfwsub_vv)
+GEN_VECTOR_R_VM(vfwsub_vf)
+GEN_VECTOR_R_VM(vfmul_vv)
+GEN_VECTOR_R_VM(vfmul_vf)
+GEN_VECTOR_R_VM(vfdiv_vv)
+GEN_VECTOR_R_VM(vfdiv_vf)
+GEN_VECTOR_R_VM(vfrdiv_vf)
+GEN_VECTOR_R_VM(vfwmul_vv)
+GEN_VECTOR_R_VM(vfwmul_vf)
+GEN_VECTOR_R_VM(vfmacc_vv)
+GEN_VECTOR_R_VM(vfmacc_vf)
+GEN_VECTOR_R_VM(vfnmacc_vv)
+GEN_VECTOR_R_VM(vfnmacc_vf)
+GEN_VECTOR_R_VM(vfmsac_vv)
+GEN_VECTOR_R_VM(vfmsac_vf)
+GEN_VECTOR_R_VM(vfnmsac_vv)
+GEN_VECTOR_R_VM(vfnmsac_vf)
+GEN_VECTOR_R_VM(vfmadd_vv)
+GEN_VECTOR_R_VM(vfmadd_vf)
+GEN_VECTOR_R_VM(vfnmadd_vv)
+GEN_VECTOR_R_VM(vfnmadd_vf)
+GEN_VECTOR_R_VM(vfmsub_vv)
+GEN_VECTOR_R_VM(vfmsub_vf)
+GEN_VECTOR_R_VM(vfnmsub_vv)
+GEN_VECTOR_R_VM(vfnmsub_vf)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2292fa5..e16543b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -21,6 +21,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
+#include "fpu/softfloat.h"
 #include <math.h>
 
 #define VECTOR_HELPER(name) HELPER(glue(vector_, name))
@@ -1125,6 +1126,41 @@ static void vector_tail_narrow(CPURISCVState *env, int vreg, int index,
     }
 }
 
+static void vector_tail_fcommon(CPURISCVState *env, int vreg, int index,
+    int width)
+{
+    switch (width) {
+    case 16:
+        env->vfp.vreg[vreg].u16[index] = 0;
+        break;
+    case 32:
+        env->vfp.vreg[vreg].u32[index] = 0;
+        break;
+    case 64:
+        env->vfp.vreg[vreg].u64[index] = 0;
+        break;
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return;
+    }
+}
+
+static void vector_tail_fwiden(CPURISCVState *env, int vreg, int index,
+    int width)
+{
+    switch (width) {
+    case 16:
+        env->vfp.vreg[vreg].u32[index] = 0;
+        break;
+    case 32:
+        env->vfp.vreg[vreg].u64[index] = 0;
+        break;
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return;
+    }
+}
+
 static inline int vector_get_carry(CPURISCVState *env, int width, int lmul,
     int index)
 {
@@ -17114,3 +17150,2612 @@ void VECTOR_HELPER(vnclip_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
     env->vfp.vstart = 0;
     return;
 }
+
+/* vfadd.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vfadd_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_add(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_add(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_add(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfadd.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfadd_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_add(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_add(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_add(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfsub.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vfsub_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_sub(
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_sub(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_sub(
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfsub.vf vd, vs2, rs1, vm # Vector-scalar vd[i] = vs2[i] - f[rs1] */
+void VECTOR_HELPER(vfsub_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_sub(
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->fpr[rs1],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_sub(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->fpr[rs1],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_sub(
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->fpr[rs1],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfrsub.vf vd, vs2, rs1, vm # Scalar-vector vd[i] = f[rs1] - vs2[i] */
+void VECTOR_HELPER(vfrsub_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_sub(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_sub(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_sub(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwadd.vv vd, vs2, vs1, vm # vector-vector */
+void VECTOR_HELPER(vfwadd_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float32_add(
+                        float16_to_float32(env->vfp.vreg[src2].f16[j], true,
+                            &env->fp_status),
+                        float16_to_float32(env->vfp.vreg[src1].f16[j], true,
+                            &env->fp_status),
+                        &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float64_add(
+                         float32_to_float64(env->vfp.vreg[src2].f32[j],
+                            &env->fp_status),
+                         float32_to_float64(env->vfp.vreg[src1].f32[j],
+                            &env->fp_status),
+                         &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwadd.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfwadd_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float32_add(
+                        float16_to_float32(env->vfp.vreg[src2].f16[j], true,
+                            &env->fp_status),
+                        float16_to_float32(env->fpr[rs1], true,
+                            &env->fp_status),
+                        &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float64_add(
+                         float32_to_float64(env->vfp.vreg[src2].f32[j],
+                            &env->fp_status),
+                        float32_to_float64(env->fpr[rs1], &env->fp_status),
+                         &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwadd.wv vd, vs2, vs1, vm # vector-vector */
+void VECTOR_HELPER(vfwadd_wv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float32_add(
+                        env->vfp.vreg[src2].f32[k],
+                        float16_to_float32(env->vfp.vreg[src1].f16[j], true,
+                            &env->fp_status),
+                        &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float64_add(
+                         env->vfp.vreg[src2].f64[k],
+                         float32_to_float64(env->vfp.vreg[src1].f32[j],
+                            &env->fp_status),
+                         &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwadd.wf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfwadd_wf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float32_add(
+                        env->vfp.vreg[src2].f32[k],
+                        float16_to_float32(env->fpr[rs1], true,
+                            &env->fp_status),
+                        &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float64_add(
+                         env->vfp.vreg[src2].f64[k],
+                         float32_to_float64(env->fpr[rs1], &env->fp_status),
+                         &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwsub.vv vd, vs2, vs1, vm # vector-vector */
+void VECTOR_HELPER(vfwsub_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float32_sub(
+                        float16_to_float32(env->vfp.vreg[src2].f16[j], true,
+                            &env->fp_status),
+                        float16_to_float32(env->vfp.vreg[src1].f16[j], true,
+                            &env->fp_status),
+                        &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float64_sub(
+                         float32_to_float64(env->vfp.vreg[src2].f32[j],
+                            &env->fp_status),
+                         float32_to_float64(env->vfp.vreg[src1].f32[j],
+                            &env->fp_status),
+                         &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwsub.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfwsub_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float32_sub(
+                        float16_to_float32(env->vfp.vreg[src2].f16[j], true,
+                            &env->fp_status),
+                        float16_to_float32(env->fpr[rs1], true,
+                            &env->fp_status),
+                        &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float64_sub(
+                         float32_to_float64(env->vfp.vreg[src2].f32[j],
+                            &env->fp_status),
+                         float32_to_float64(env->fpr[rs1], &env->fp_status),
+                         &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwsub.wv vd, vs2, vs1, vm # vector-vector */
+void VECTOR_HELPER(vfwsub_wv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float32_sub(
+                        env->vfp.vreg[src2].f32[k],
+                        float16_to_float32(env->vfp.vreg[src1].f16[j], true,
+                            &env->fp_status),
+                        &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float64_sub(
+                         env->vfp.vreg[src2].f64[k],
+                         float32_to_float64(env->vfp.vreg[src1].f32[j],
+                            &env->fp_status),
+                         &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwsub.wf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfwsub_wf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float32_sub(
+                        env->vfp.vreg[src2].f32[k],
+                        float16_to_float32(env->fpr[rs1], true,
+                            &env->fp_status),
+                        &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float64_sub(
+                         env->vfp.vreg[src2].f64[k],
+                         float32_to_float64(env->fpr[rs1], &env->fp_status),
+                         &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmul.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vfmul_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_mul(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_mul(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_mul(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmul.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfmul_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_mul(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_mul(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_mul(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfdiv.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vfdiv_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_div(
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_div(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_div(
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfdiv.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfdiv_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_div(
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->fpr[rs1],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_div(
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->fpr[rs1],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_div(
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->fpr[rs1],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfrdiv.vf vd, vs2, rs1, vm # scalar-vector, vd[i] = f[rs1]/vs2[i] */
+void VECTOR_HELPER(vfrdiv_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_div(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_div(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_div(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfwmul.vv vd, vs2, vs1, vm # vector-vector */
+void VECTOR_HELPER(vfwmul_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float32_mul(
+                        float16_to_float32(env->vfp.vreg[src2].f16[j], true,
+                            &env->fp_status),
+                        float16_to_float32(env->vfp.vreg[src1].f16[j], true,
+                            &env->fp_status),
+                        &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float64_mul(
+                         float32_to_float64(env->vfp.vreg[src2].f32[j],
+                            &env->fp_status),
+                         float32_to_float64(env->vfp.vreg[src1].f32[j],
+                            &env->fp_status),
+                         &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    return;
+
+    env->vfp.vstart = 0;
+}
+
+/* vfwmul.vf vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vfwmul_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[k] = float32_mul(
+                        float16_to_float32(env->vfp.vreg[src2].f16[j], true,
+                            &env->fp_status),
+                        float16_to_float32(env->fpr[rs1], true,
+                            &env->fp_status),
+                        &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[k] = float64_mul(
+                         float32_to_float64(env->vfp.vreg[src2].f32[j],
+                            &env->fp_status),
+                         float32_to_float64(env->fpr[rs1], &env->fp_status),
+                         &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fwiden(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmacc.vv vd, vs1, vs2, vm # vd[i] = +(vs1[i] * vs2[i]) + vd[i] */
+void VECTOR_HELPER(vfmacc_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmacc.vf vd, rs1, vs2, vm # vd[i] = +(f[rs1] * vs2[i]) + vd[i] */
+void VECTOR_HELPER(vfmacc_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfnmacc.vv vd, vs1, vs2, vm # vd[i] = -(vs1[i] * vs2[i]) - vd[i] */
+void VECTOR_HELPER(vfnmacc_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfnmacc.vf vd, rs1, vs2, vm # vd[i] = -(f[rs1] * vs2[i]) - vd[i] */
+void VECTOR_HELPER(vfnmacc_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmsac.vv vd, vs1, vs2, vm # vd[i] = +(vs1[i] * vs2[i]) - vd[i] */
+void VECTOR_HELPER(vfmsac_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmsac.vf vd, rs1, vs2, vm # vd[i] = +(f[rs1] * vs2[i]) - vd[i] */
+void VECTOR_HELPER(vfmsac_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    return;
+
+    env->vfp.vstart = 0;
+}
+
+/* vfnmsac.vv vd, vs1, vs2, vm # vd[i] = -(vs1[i] * vs2[i]) + vd[i] */
+void VECTOR_HELPER(vfnmsac_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfnmsac.vf vd, rs1, vs2, vm # vd[i] = -(f[rs1] * vs2[i]) + vd[i] */
+void VECTOR_HELPER(vfnmsac_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmadd.vv vd, vs1, vs2, vm # vd[i] = +(vs1[i] * vd[i]) + vs2[i] */
+void VECTOR_HELPER(vfmadd_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmadd.vf vd, rs1, vs2, vm # vd[i] = +(f[rs1] * vd[i]) + vs2[i] */
+void VECTOR_HELPER(vfmadd_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    0,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+/* vfnmadd.vv vd, vs1, vs2, vm # vd[i] = -(vs1[i] * vd[i]) - vs2[i] */
+void VECTOR_HELPER(vfnmadd_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfnmadd.vf vd, rs1, vs2, vm # vd[i] = -(f[rs1] * vd[i]) - vs2[i] */
+void VECTOR_HELPER(vfnmadd_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    float_muladd_negate_c |
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmsub.vv vd, vs1, vs2, vm # vd[i] = +(vs1[i] * vd[i]) - vs2[i] */
+void VECTOR_HELPER(vfmsub_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vfmsub.vf vd, rs1, vs2, vm # vd[i] = +(f[rs1] * vd[i]) - vs2[i] */
+void VECTOR_HELPER(vfmsub_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    float_muladd_negate_c,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+/* vfnmsub.vv vd, vs1, vs2, vm # vd[i] = -(vs1[i] * vd[i]) + vs2[i] */
+void VECTOR_HELPER(vfnmsub_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->vfp.vreg[src1].f16[j],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->vfp.vreg[src1].f32[j],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->vfp.vreg[src1].f64[j],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    return;
+
+    env->vfp.vstart = 0;
+}
+
+/* vfnmsub.vf vd, rs1, vs2, vm # vd[i] = -(f[rs1] * vd[i]) + vs2[i] */
+void VECTOR_HELPER(vfnmsub_vf)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f16[j] = float16_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f16[j],
+                                                    env->vfp.vreg[src2].f16[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f32[j] = float32_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f32[j],
+                                                    env->vfp.vreg[src2].f32[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].f64[j] = float64_muladd(
+                                                    env->fpr[rs1],
+                                                    env->vfp.vreg[dest].f64[j],
+                                                    env->vfp.vreg[src2].f64[j],
+                                                    float_muladd_negate_product,
+                                                    &env->fp_status);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_fcommon(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+
-- 
2.7.4


