Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF0ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB94021928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB94021928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wTw-0008V6-J9
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wE2-0007im-V7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDy-00089a-E1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:34 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:51752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDx-0007rL-Ka; Wed, 11 Sep 2019 02:35:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.427709-0.00502295-0.567268; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03312; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRZlMV_1568183705; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRZlMV_1568183705)
 by smtp.aliyun-inc.com(10.147.42.135);
 Wed, 11 Sep 2019 14:35:05 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:40 +0800
Message-Id: <1568183141-67641-17-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 16/17] RISC-V: add vector extension mask
 instructions
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
 target/riscv/helper.h                   |  16 +
 target/riscv/insn32.decode              |  17 +
 target/riscv/insn_trans/trans_rvv.inc.c |  27 ++
 target/riscv/vector_helper.c            | 635 ++++++++++++++++++++++++++++++++
 4 files changed, 695 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d36bd00..337ac2e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -401,5 +401,21 @@ DEF_HELPER_5(vector_vwredsum_vs, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vfwredsum_vs, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vfwredosum_vs, void, env, i32, i32, i32, i32)
 
+DEF_HELPER_4(vector_vmandnot_mm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmand_mm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmor_mm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmxor_mm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmornot_mm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmnand_mm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmnor_mm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmxnor_mm, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmsbf_m, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmsof_m, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmsif_m, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_viota_m, void, env, i32, i32, i32)
+DEF_HELPER_3(vector_vid_v, void, env, i32, i32)
+DEF_HELPER_4(vector_vmpopc_m, void, env, i32, i32, i32)
+DEF_HELPER_4(vector_vmfirst_m, void, env, i32, i32, i32)
+
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 3f63bc1..1de776b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -68,6 +68,7 @@
 @r_nfvm  nf:3 ... vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
 @r2_nfvm nf:3 ... vm:1 ..... ..... ... ..... ....... %rs1 %rd
 @r2_vm   ...... vm:1 ..... ..... ... ..... ....... %rs2 %rd
+@r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
 @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -541,5 +542,21 @@ vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
 vfwredsum_vs    110001 . ..... ..... 001 ..... 1010111 @r_vm
 vfwredosum_vs   110011 . ..... ..... 001 ..... 1010111 @r_vm
 
+vmand_mm        011001 - ..... ..... 010 ..... 1010111 @r
+vmnand_mm       011101 - ..... ..... 010 ..... 1010111 @r
+vmandnot_mm     011000 - ..... ..... 010 ..... 1010111 @r
+vmor_mm         011010 - ..... ..... 010 ..... 1010111 @r
+vmxor_mm        011011 - ..... ..... 010 ..... 1010111 @r
+vmnor_mm        011110 - ..... ..... 010 ..... 1010111 @r
+vmornot_mm      011100 - ..... ..... 010 ..... 1010111 @r
+vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
+vmpopc_m        010100 . ..... ----- 010 ..... 1010111 @r2_vm
+vmfirst_m       010101 . ..... ----- 010 ..... 1010111 @r2_vm
+vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
+vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
+vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
+viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
+vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 9a3d31b..85e435a 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -77,6 +77,17 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
     return true;                                       \
 }
 
+#define GEN_VECTOR_R1_VM(INSN) \
+static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
+{                                                      \
+    TCGv_i32 d  = tcg_const_i32(a->rd);                \
+    TCGv_i32 vm = tcg_const_i32(a->vm);                \
+    gen_helper_vector_##INSN(cpu_env, vm, d);        \
+    tcg_temp_free_i32(d);                              \
+    tcg_temp_free_i32(vm);                             \
+    return true;                                       \
+}
+
 #define GEN_VECTOR_R_VM(INSN) \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
 {                                                      \
@@ -444,5 +455,21 @@ GEN_VECTOR_R_VM(vfredmax_vs)
 GEN_VECTOR_R_VM(vfwredsum_vs)
 GEN_VECTOR_R_VM(vfwredosum_vs)
 
+GEN_VECTOR_R(vmandnot_mm)
+GEN_VECTOR_R(vmand_mm)
+GEN_VECTOR_R(vmor_mm)
+GEN_VECTOR_R(vmxor_mm)
+GEN_VECTOR_R(vmornot_mm)
+GEN_VECTOR_R(vmnand_mm)
+GEN_VECTOR_R(vmnor_mm)
+GEN_VECTOR_R(vmxnor_mm)
+GEN_VECTOR_R2_VM(vmpopc_m)
+GEN_VECTOR_R2_VM(vmfirst_m)
+GEN_VECTOR_R2_VM(vmsbf_m)
+GEN_VECTOR_R2_VM(vmsof_m)
+GEN_VECTOR_R2_VM(vmsif_m)
+GEN_VECTOR_R2_VM(viota_m)
+GEN_VECTOR_R1_VM(vid_v)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 4a9083b..9e15df9 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1232,6 +1232,15 @@ static inline int vector_get_carry(CPURISCVState *env, int width, int lmul,
     return (env->vfp.vreg[0].u8[idx] >> pos) & 0x1;
 }
 
+static inline int vector_mask_reg(CPURISCVState *env, uint32_t reg, int width,
+    int lmul, int index)
+{
+    int mlen = width / lmul;
+    int idx = (index * mlen) / 8;
+    int pos = (index * mlen) % 8;
+    return (env->vfp.vreg[reg].u8[idx] >> pos) & 0x1;
+}
+
 static inline void vector_mask_result(CPURISCVState *env, uint32_t reg,
         int width, int lmul, int index, uint32_t result)
 {
@@ -23996,3 +24005,629 @@ void VECTOR_HELPER(vfwredosum_vs)(CPURISCVState *env, uint32_t vm,
     env->vfp.vstart = 0;
     return;
 }
+
+/* vmandnot.mm vd, vs2, vs1 # vd = vs2 & ~vs1 */
+void VECTOR_HELPER(vmandnot_mm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, i, vlmax;
+    uint32_t tmp;
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            tmp = ~vector_mask_reg(env, rs1, width, lmul, i) &
+                    vector_mask_reg(env, rs2, width, lmul, i);
+            vector_mask_result(env, rd, width, lmul, i, tmp);
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+
+    env->vfp.vstart = 0;
+    return;
+}
+/* vmand.mm vd, vs2, vs1 # vd = vs2 & vs1 */
+void VECTOR_HELPER(vmand_mm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, i, vlmax;
+    uint32_t tmp;
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            tmp = vector_mask_reg(env, rs1, width, lmul, i) &
+                    vector_mask_reg(env, rs2, width, lmul, i);
+            vector_mask_result(env, rd, width, lmul, i, tmp);
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+
+    env->vfp.vstart = 0;
+    return;
+}
+/* vmor.mm vd, vs2, vs1 # vd = vs2 | vs1 */
+void VECTOR_HELPER(vmor_mm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, i, vlmax;
+    uint32_t tmp;
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            tmp = vector_mask_reg(env, rs1, width, lmul, i) |
+                    vector_mask_reg(env, rs2, width, lmul, i);
+            vector_mask_result(env, rd, width, lmul, i, tmp & 0x1);
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+
+    env->vfp.vstart = 0;
+    return;
+}
+/* vmxor.mm vd, vs2, vs1 # vd = vs2 ^ vs1 */
+void VECTOR_HELPER(vmxor_mm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, i, vlmax;
+    uint32_t tmp;
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            tmp = vector_mask_reg(env, rs1, width, lmul, i) ^
+                    vector_mask_reg(env, rs2, width, lmul, i);
+            vector_mask_result(env, rd, width, lmul, i, tmp & 0x1);
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+
+    env->vfp.vstart = 0;
+    return;
+}
+/* vmornot.mm vd, vs2, vs1 # vd = vs2 | ~vs1 */
+void VECTOR_HELPER(vmornot_mm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, i, vlmax;
+    uint32_t tmp;
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            tmp = ~vector_mask_reg(env, rs1, width, lmul, i) |
+                    vector_mask_reg(env, rs2, width, lmul, i);
+            vector_mask_result(env, rd, width, lmul, i, tmp & 0x1);
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+
+    env->vfp.vstart = 0;
+    return;
+}
+/* vmnand.mm vd, vs2, vs1 # vd = ~(vs2 & vs1) */
+void VECTOR_HELPER(vmnand_mm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, i, vlmax;
+    uint32_t tmp;
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            tmp = vector_mask_reg(env, rs1, width, lmul, i) &
+                    vector_mask_reg(env, rs2, width, lmul, i);
+            vector_mask_result(env, rd, width, lmul, i, (~tmp & 0x1));
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+
+    env->vfp.vstart = 0;
+    return;
+}
+/* vmnor.mm vd, vs2, vs1 # vd = ~(vs2 | vs1) */
+void VECTOR_HELPER(vmnor_mm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, i, vlmax;
+    uint32_t tmp;
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            tmp = vector_mask_reg(env, rs1, width, lmul, i) |
+                    vector_mask_reg(env, rs2, width, lmul, i);
+            vector_mask_result(env, rd, width, lmul, i, ~tmp & 0x1);
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmxnor.mm vd, vs2, vs1 # vd = ~(vs2 ^ vs1) */
+void VECTOR_HELPER(vmxnor_mm)(CPURISCVState *env, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, i, vlmax;
+    uint32_t tmp;
+
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            tmp = vector_mask_reg(env, rs1, width, lmul, i) ^
+                    vector_mask_reg(env, rs2, width, lmul, i);
+            vector_mask_result(env, rd, width, lmul, i, ~tmp & 0x1);
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmpopc.m rd, vs2, v0.t # x[rd] = sum_i ( vs2[i].LSB && v0[i].LSB ) */
+void VECTOR_HELPER(vmpopc_m)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i;
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+    env->gpr[rd] = 0;
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < vl) {
+            if (vector_mask_reg(env, rs2, width, lmul, i) &&
+                vector_elem_mask(env, vm, width, lmul, i)) {
+                env->gpr[rd]++;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmfirst.m rd, vs2, vm */
+void VECTOR_HELPER(vmfirst_m)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i;
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < vl) {
+            if (vector_mask_reg(env, rs2, width, lmul, i) &&
+                vector_elem_mask(env, vm, width, lmul, i)) {
+                env->gpr[rd] = i;
+                break;
+            }
+        } else {
+            env->gpr[rd] = -1;
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmsbf.m vd, vs2, vm # set-before-first mask bit */
+void VECTOR_HELPER(vmsbf_m)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i;
+    bool first_mask_bit = false;
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < vl) {
+            if (vector_elem_mask(env, vm, width, lmul, i)) {
+                if (first_mask_bit) {
+                    vector_mask_result(env, rd, width, lmul, i, 0);
+                    continue;
+                }
+                if (!vector_mask_reg(env, rs2, width, lmul, i)) {
+                    vector_mask_result(env, rd, width, lmul, i, 1);
+                } else {
+                    first_mask_bit = true;
+                    vector_mask_result(env, rd, width, lmul, i, 0);
+                }
+            }
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmsif.m vd, vs2, vm # set-including-first mask bit */
+void VECTOR_HELPER(vmsif_m)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i;
+    bool first_mask_bit = false;
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < vl) {
+            if (vector_elem_mask(env, vm, width, lmul, i)) {
+                if (first_mask_bit) {
+                    vector_mask_result(env, rd, width, lmul, i, 0);
+                    continue;
+                }
+                if (!vector_mask_reg(env, rs2, width, lmul, i)) {
+                    vector_mask_result(env, rd, width, lmul, i, 1);
+                } else {
+                    first_mask_bit = true;
+                    vector_mask_result(env, rd, width, lmul, i, 1);
+                }
+            }
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vmsof.m vd, vs2, vm # set-only-first mask bit */
+void VECTOR_HELPER(vmsof_m)(CPURISCVState *env, uint32_t vm,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i;
+    bool first_mask_bit = false;
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        if (i < vl) {
+            if (vector_elem_mask(env, vm, width, lmul, i)) {
+                if (first_mask_bit) {
+                    vector_mask_result(env, rd, width, lmul, i, 0);
+                    continue;
+                }
+                if (!vector_mask_reg(env, rs2, width, lmul, i)) {
+                    vector_mask_result(env, rd, width, lmul, i, 0);
+                } else {
+                    first_mask_bit = true;
+                    vector_mask_result(env, rd, width, lmul, i, 1);
+                }
+            }
+        } else {
+            vector_mask_result(env, rd, width, lmul, i, 0);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* viota.m v4, v2, v0.t */
+void VECTOR_HELPER(viota_m)(CPURISCVState *env, uint32_t vm, uint32_t rs2,
+    uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest;
+    uint32_t sum = 0;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, lmul, rs2, 1)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (env->vfp.vstart != 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = sum;
+                    if (vector_mask_reg(env, rs2, width, lmul, i)) {
+                        sum++;
+                    }
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = sum;
+                    if (vector_mask_reg(env, rs2, width, lmul, i)) {
+                        sum++;
+                    }
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = sum;
+                    if (vector_mask_reg(env, rs2, width, lmul, i)) {
+                        sum++;
+                    }
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = sum;
+                    if (vector_mask_reg(env, rs2, width, lmul, i)) {
+                        sum++;
+                    }
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vid.v vd, vm # Write element ID to destination. */
+void VECTOR_HELPER(vid_v)(CPURISCVState *env, uint32_t vm, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest;
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rd, false);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = i;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = i;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = i;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = i;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
-- 
2.7.4


