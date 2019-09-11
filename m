Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA0EECDE28
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2617021A4C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2617021A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wLp-0007w4-OT
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDW-0006xh-VH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDT-0007mZ-Rc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDT-0007k2-5P; Wed, 11 Sep 2019 02:34:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.480035-0.00505187-0.514913; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01a16368; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRUTgl_1568183693; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRUTgl_1568183693)
 by smtp.aliyun-inc.com(10.147.42.22); Wed, 11 Sep 2019 14:34:53 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:30 +0800
Message-Id: <1568183141-67641-7-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 06/17] RISC-V: add vector extension
 fault-only-first implementation
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
 linux-user/riscv/cpu_loop.c             |   7 +
 target/riscv/cpu_helper.c               |   7 +
 target/riscv/helper.h                   |   7 +
 target/riscv/insn32.decode              |   7 +
 target/riscv/insn_trans/trans_rvv.inc.c |   7 +
 target/riscv/vector_helper.c            | 567 ++++++++++++++++++++++++++++++++
 6 files changed, 602 insertions(+)

diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 12aa3c0..d673fa5 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -41,6 +41,13 @@ void cpu_loop(CPURISCVState *env)
         sigcode = 0;
         sigaddr = 0;
 
+        if (env->foflag) {
+            if (env->vfp.vl != 0) {
+                env->foflag = false;
+                env->pc += 4;
+                continue;
+            }
+        }
         switch (trapnr) {
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e32b612..405caf6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -521,6 +521,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         [PRV_H] = RISCV_EXCP_H_ECALL,
         [PRV_M] = RISCV_EXCP_M_ECALL
     };
+    if (env->foflag) {
+        if (env->vfp.vl != 0) {
+            env->foflag = false;
+            env->pc += 4;
+            return;
+        }
+    }
 
     if (!async) {
         /* set tval to badaddr for traps with address information */
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f77c392..973342f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -84,6 +84,13 @@ DEF_HELPER_5(vector_vle_v, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vlbu_v, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vlhu_v, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vlwu_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlbff_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlhff_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlwff_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vleff_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlbuff_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlhuff_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlwuff_v, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vsb_v, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vsh_v, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vsw_v, void, env, i32, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b8a3d8a..b286997 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -218,6 +218,13 @@ vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
 vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
 vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
 vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+vlbff_v    ... 100 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+vlhff_v    ... 100 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+vlwff_v    ... 100 . 10000 ..... 110 ..... 0000111 @r2_nfvm
+vleff_v    ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
+vlbuff_v   ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+vlhuff_v   ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+vlwuff_v   ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
 vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
 vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
 vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 16b1f90..bd83885 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -80,6 +80,13 @@ GEN_VECTOR_R2_NFVM(vle_v)
 GEN_VECTOR_R2_NFVM(vlbu_v)
 GEN_VECTOR_R2_NFVM(vlhu_v)
 GEN_VECTOR_R2_NFVM(vlwu_v)
+GEN_VECTOR_R2_NFVM(vlbff_v)
+GEN_VECTOR_R2_NFVM(vlhff_v)
+GEN_VECTOR_R2_NFVM(vlwff_v)
+GEN_VECTOR_R2_NFVM(vleff_v)
+GEN_VECTOR_R2_NFVM(vlbuff_v)
+GEN_VECTOR_R2_NFVM(vlhuff_v)
+GEN_VECTOR_R2_NFVM(vlwuff_v)
 GEN_VECTOR_R2_NFVM(vsb_v)
 GEN_VECTOR_R2_NFVM(vsh_v)
 GEN_VECTOR_R2_NFVM(vsw_v)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 62e4d2e..0ac8c74 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2762,3 +2762,570 @@ void VECTOR_HELPER(vsuxe_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
     env->vfp.vstart = 0;
 }
 
+void VECTOR_HELPER(vlbuff_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, read;
+
+    vl = env->vfp.vl;
+
+    lmul   = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (lmul * (nf + 1) > 32) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    env->foflag = true;
+    env->vfp.vl = 0;
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * (nf + 1)  + k;
+                        env->vfp.vreg[dest + k * lmul].u8[j] =
+                            cpu_ldub_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * (nf + 1)  + k;
+                        env->vfp.vreg[dest + k * lmul].u16[j] =
+                            cpu_ldub_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * (nf + 1)  + k;
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_ldub_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * (nf + 1)  + k;
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_ldub_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->foflag = false;
+    env->vfp.vl = vl;
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlbff_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, read;
+
+    vl = env->vfp.vl;
+
+    lmul   = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (lmul * (nf + 1) > 32) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rd, false);
+    env->foflag = true;
+    env->vfp.vl = 0;
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * (nf + 1)  + k;
+                        env->vfp.vreg[dest + k * lmul].s8[j] =
+                            cpu_ldsb_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * (nf + 1)  + k;
+                        env->vfp.vreg[dest + k * lmul].s16[j] = sign_extend(
+                            cpu_ldsb_data(env, env->gpr[rs1] + read), 8);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * (nf + 1)  + k;
+                        env->vfp.vreg[dest + k * lmul].s32[j] = sign_extend(
+                            cpu_ldsb_data(env, env->gpr[rs1] + read), 8);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * (nf + 1)  + k;
+                        env->vfp.vreg[dest + k * lmul].s64[j] = sign_extend(
+                            cpu_ldsb_data(env, env->gpr[rs1] + read), 8);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->foflag = false;
+    env->vfp.vl = vl;
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlhuff_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, read;
+
+    vl = env->vfp.vl;
+
+    lmul   = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (lmul * (nf + 1) > 32) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rd, false);
+    env->foflag = true;
+    env->vfp.vl = 0;
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 2;
+                        env->vfp.vreg[dest + k * lmul].u16[j] =
+                            cpu_lduw_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 2;
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_lduw_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 2;
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_lduw_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->foflag = false;
+    env->vfp.vl = vl;
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlhff_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, read;
+
+    vl = env->vfp.vl;
+
+    lmul   = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (lmul * (nf + 1) > 32) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rd, false);
+    env->foflag = true;
+    env->vfp.vl = 0;
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 2;
+                        env->vfp.vreg[dest + k * lmul].s16[j] =
+                            cpu_ldsw_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 2;
+                        env->vfp.vreg[dest + k * lmul].s32[j] = sign_extend(
+                            cpu_ldsw_data(env, env->gpr[rs1] + read), 16);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 2;
+                        env->vfp.vreg[dest + k * lmul].s64[j] = sign_extend(
+                            cpu_ldsw_data(env, env->gpr[rs1] + read), 16);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vl = vl;
+    env->foflag = false;
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlwuff_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, read;
+
+    vl = env->vfp.vl;
+
+    lmul   = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (lmul * (nf + 1) > 32) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rd, false);
+    env->foflag = true;
+    env->vfp.vl = 0;
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 4;
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_ldl_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 4;
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_ldl_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->foflag = false;
+    env->vfp.vl = vl;
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlwff_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, read;
+
+    vl = env->vfp.vl;
+
+    lmul   = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (lmul * (nf + 1) > 32) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    vector_lmul_check_reg(env, lmul, rd, false);
+    env->foflag = true;
+    env->vfp.vl = 0;
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 4;
+                        env->vfp.vreg[dest + k * lmul].s32[j] =
+                            cpu_ldl_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 4;
+                        env->vfp.vreg[dest + k * lmul].s64[j] = sign_extend(
+                            cpu_ldl_data(env, env->gpr[rs1] + read), 32);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->foflag = false;
+    env->vfp.vl = vl;
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vleff_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, read;
+
+    vl = env->vfp.vl;
+    lmul   = vector_get_lmul(env);
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+    if (lmul * (nf + 1) > 32) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rd, false);
+    env->vfp.vl = 0;
+    env->foflag = true;
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * (nf + 1)  + k;
+                        env->vfp.vreg[dest + k * lmul].u8[j] =
+                            cpu_ldub_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 2;
+                        env->vfp.vreg[dest + k * lmul].u16[j] =
+                            cpu_lduw_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 4;
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_ldl_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = (i * (nf + 1)  + k) * 8;
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_ldq_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                env->vfp.vl++;
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->foflag = false;
+    env->vfp.vl = vl;
+    env->vfp.vstart = 0;
+}
-- 
2.7.4


