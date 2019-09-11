Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1560ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CD42081B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CD42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wJK-0004ll-TD
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDf-00078t-1E
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDU-0007nI-Ng
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:10 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDT-0007k0-2z; Wed, 11 Sep 2019 02:35:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.484801-0.00607782-0.509121; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01a16368; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRMC1k_1568183691; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRMC1k_1568183691)
 by smtp.aliyun-inc.com(10.147.41.199);
 Wed, 11 Sep 2019 14:34:52 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:29 +0800
Message-Id: <1568183141-67641-6-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 05/17] RISC-V: add vector extension load and
 store instructions
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
 target/riscv/insn32.decode              |   46 +
 target/riscv/insn_trans/trans_rvv.inc.c |   70 +
 target/riscv/vector_helper.c            | 2638 +++++++++++++++++++++++++++++++
 4 files changed, 2791 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 652f8c3..f77c392 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -77,5 +77,42 @@ DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 #endif
 /* Vector functions */
+DEF_HELPER_5(vector_vlb_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlh_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlw_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vle_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlbu_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlhu_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vlwu_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsb_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsh_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsw_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vse_v, void, env, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlsb_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlsh_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlsw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlse_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlsbu_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlshu_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlswu_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vssb_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vssh_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vssw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vsse_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlxb_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlxh_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlxw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlxe_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlxbu_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlxhu_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vlxwu_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vsxb_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vsxh_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vsxw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vsxe_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vsuxb_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vsuxh_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vsuxw_v, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vector_vsuxe_v, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 5dc009c..b8a3d8a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -25,6 +25,7 @@
 %sh10    20:10
 %csr    20:12
 %rm     12:3
+%nf     29:3
 
 # immediates:
 %imm_i    20:s12
@@ -62,6 +63,8 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r_nfvm  nf:3 ... vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
+@r2_nfvm nf:3 ... vm:1 ..... ..... ... ..... ....... %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
 @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -206,5 +209,48 @@ fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
 fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
 
 # *** RV32V Extension ***
+
+# *** Vector loads and stores are encoded within LOADFP/STORE-FP ***
+vlb_v      ... 100 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+vlh_v      ... 100 . 00000 ..... 101 ..... 0000111 @r2_nfvm
+vlw_v      ... 100 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
+vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
+vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
+vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
+vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
+vse_v      ... 000 . 00000 ..... 111 ..... 0100111 @r2_nfvm
+
+vlsb_v     ... 110 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlsh_v     ... 110 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlsw_v     ... 110 . ..... ..... 110 ..... 0000111 @r_nfvm
+vlse_v     ... 010 . ..... ..... 111 ..... 0000111 @r_nfvm
+vlsbu_v    ... 010 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlshu_v    ... 010 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlswu_v    ... 010 . ..... ..... 110 ..... 0000111 @r_nfvm
+vssb_v     ... 010 . ..... ..... 000 ..... 0100111 @r_nfvm
+vssh_v     ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
+vssw_v     ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
+vsse_v     ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
+
+vlxb_v     ... 111 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlxh_v     ... 111 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlxw_v     ... 111 . ..... ..... 110 ..... 0000111 @r_nfvm
+vlxe_v     ... 011 . ..... ..... 111 ..... 0000111 @r_nfvm
+vlxbu_v    ... 011 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlxhu_v    ... 011 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlxwu_v    ... 011 . ..... ..... 110 ..... 0000111 @r_nfvm
+vsxb_v     ... 011 . ..... ..... 000 ..... 0100111 @r_nfvm
+vsxh_v     ... 011 . ..... ..... 101 ..... 0100111 @r_nfvm
+vsxw_v     ... 011 . ..... ..... 110 ..... 0100111 @r_nfvm
+vsxe_v     ... 011 . ..... ..... 111 ..... 0100111 @r_nfvm
+vsuxb_v    ... 111 . ..... ..... 000 ..... 0100111 @r_nfvm
+vsuxh_v    ... 111 . ..... ..... 101 ..... 0100111 @r_nfvm
+vsuxw_v    ... 111 . ..... ..... 110 ..... 0100111 @r_nfvm
+vsuxe_v    ... 111 . ..... ..... 111 ..... 0100111 @r_nfvm
+
+#*** new major opcode OP-V ***
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 82e7ad6..16b1f90 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -16,6 +16,37 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#define GEN_VECTOR_R2_NFVM(INSN) \
+static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
+{                                                      \
+    TCGv_i32 s1 = tcg_const_i32(a->rs1);               \
+    TCGv_i32 d  = tcg_const_i32(a->rd);                \
+    TCGv_i32 nf  = tcg_const_i32(a->nf);               \
+    TCGv_i32 vm = tcg_const_i32(a->vm);                \
+    gen_helper_vector_##INSN(cpu_env, nf, vm, s1, d);    \
+    tcg_temp_free_i32(s1);                             \
+    tcg_temp_free_i32(d);                              \
+    tcg_temp_free_i32(nf);                             \
+    tcg_temp_free_i32(vm);                             \
+    return true;                                       \
+}
+#define GEN_VECTOR_R_NFVM(INSN) \
+static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
+{                                                      \
+    TCGv_i32 s1 = tcg_const_i32(a->rs1);               \
+    TCGv_i32 s2 = tcg_const_i32(a->rs2);               \
+    TCGv_i32 d  = tcg_const_i32(a->rd);                \
+    TCGv_i32 nf  = tcg_const_i32(a->nf);               \
+    TCGv_i32 vm = tcg_const_i32(a->vm);                \
+    gen_helper_vector_##INSN(cpu_env, nf, vm, s1, s2, d);\
+    tcg_temp_free_i32(s1);                             \
+    tcg_temp_free_i32(s2);                             \
+    tcg_temp_free_i32(d);                              \
+    tcg_temp_free_i32(nf);                             \
+    tcg_temp_free_i32(vm);                             \
+    return true;                                       \
+}
+
 #define GEN_VECTOR_R(INSN) \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
 {                                                      \
@@ -42,5 +73,44 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
     return true;                                       \
 }
 
+GEN_VECTOR_R2_NFVM(vlb_v)
+GEN_VECTOR_R2_NFVM(vlh_v)
+GEN_VECTOR_R2_NFVM(vlw_v)
+GEN_VECTOR_R2_NFVM(vle_v)
+GEN_VECTOR_R2_NFVM(vlbu_v)
+GEN_VECTOR_R2_NFVM(vlhu_v)
+GEN_VECTOR_R2_NFVM(vlwu_v)
+GEN_VECTOR_R2_NFVM(vsb_v)
+GEN_VECTOR_R2_NFVM(vsh_v)
+GEN_VECTOR_R2_NFVM(vsw_v)
+GEN_VECTOR_R2_NFVM(vse_v)
+
+GEN_VECTOR_R_NFVM(vlsb_v)
+GEN_VECTOR_R_NFVM(vlsh_v)
+GEN_VECTOR_R_NFVM(vlsw_v)
+GEN_VECTOR_R_NFVM(vlse_v)
+GEN_VECTOR_R_NFVM(vlsbu_v)
+GEN_VECTOR_R_NFVM(vlshu_v)
+GEN_VECTOR_R_NFVM(vlswu_v)
+GEN_VECTOR_R_NFVM(vssb_v)
+GEN_VECTOR_R_NFVM(vssh_v)
+GEN_VECTOR_R_NFVM(vssw_v)
+GEN_VECTOR_R_NFVM(vsse_v)
+GEN_VECTOR_R_NFVM(vlxb_v)
+GEN_VECTOR_R_NFVM(vlxh_v)
+GEN_VECTOR_R_NFVM(vlxw_v)
+GEN_VECTOR_R_NFVM(vlxe_v)
+GEN_VECTOR_R_NFVM(vlxbu_v)
+GEN_VECTOR_R_NFVM(vlxhu_v)
+GEN_VECTOR_R_NFVM(vlxwu_v)
+GEN_VECTOR_R_NFVM(vsxb_v)
+GEN_VECTOR_R_NFVM(vsxh_v)
+GEN_VECTOR_R_NFVM(vsxw_v)
+GEN_VECTOR_R_NFVM(vsxe_v)
+GEN_VECTOR_R_NFVM(vsuxb_v)
+GEN_VECTOR_R_NFVM(vsuxh_v)
+GEN_VECTOR_R_NFVM(vsuxw_v)
+GEN_VECTOR_R_NFVM(vsuxe_v)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b279e6f..62e4d2e 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -20,10 +20,60 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
 #include <math.h>
 
 #define VECTOR_HELPER(name) HELPER(glue(vector_, name))
 
+static int64_t sign_extend(int64_t a, int8_t width)
+{
+    return a << (64 - width) >> (64 - width);
+}
+
+static target_ulong vector_get_index(CPURISCVState *env, int rs1, int rs2,
+    int index, int mem, int width, int nf)
+{
+    target_ulong abs_off, base = env->gpr[rs1];
+    target_long offset;
+    switch (width) {
+    case 8:
+        offset = sign_extend(env->vfp.vreg[rs2].s8[index], 8) + nf * mem;
+        break;
+    case 16:
+        offset = sign_extend(env->vfp.vreg[rs2].s16[index], 16) + nf * mem;
+        break;
+    case 32:
+        offset = sign_extend(env->vfp.vreg[rs2].s32[index], 32) + nf * mem;
+        break;
+    case 64:
+        offset = env->vfp.vreg[rs2].s64[index] + nf * mem;
+        break;
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return 0;
+    }
+    if (offset < 0) {
+        abs_off = ~offset + 1;
+        if (base >= abs_off) {
+            return base - abs_off;
+        }
+    } else {
+        if ((target_ulong)((target_ulong)offset + base) >= base) {
+            return (target_ulong)offset + base;
+        }
+    }
+    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+    return 0;
+}
+
+static inline bool vector_vtype_ill(CPURISCVState *env)
+{
+    if ((env->vfp.vtype >> (sizeof(target_ulong) - 1)) & 0x1) {
+        return true;
+    }
+    return false;
+}
+
 static inline void vector_vtype_set_ill(CPURISCVState *env)
 {
     env->vfp.vtype = ((target_ulong)1) << (sizeof(target_ulong) - 1);
@@ -50,6 +100,76 @@ static inline int vector_get_vlmax(CPURISCVState *env)
     return vector_get_lmul(env) * VLEN / vector_get_width(env);
 }
 
+static inline int vector_elem_mask(CPURISCVState *env, uint32_t vm, int width,
+    int lmul, int index)
+{
+    int mlen = width / lmul;
+    int idx = (index * mlen) / 8;
+    int pos = (index * mlen) % 8;
+
+    return vm || ((env->vfp.vreg[0].u8[idx] >> pos) & 0x1);
+}
+
+static inline bool vector_overlap_vm_common(int lmul, int vm, int rd)
+{
+    if (lmul > 1 && vm == 0 && rd == 0) {
+        return true;
+    }
+    return false;
+}
+
+static bool  vector_lmul_check_reg(CPURISCVState *env, uint32_t lmul,
+        uint32_t reg, bool widen)
+{
+    int legal = widen ? (lmul * 2) : lmul;
+
+    if ((lmul != 1 && lmul != 2 && lmul != 4 && lmul != 8) ||
+        (lmul == 8 && widen)) {
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return false;
+    }
+
+    if (reg % legal != 0) {
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return false;
+    }
+    return true;
+}
+
+static void vector_tail_segment(CPURISCVState *env, int vreg, int index,
+    int width, int nf, int lmul)
+{
+    switch (width) {
+    case 8:
+        while (nf >= 0) {
+            env->vfp.vreg[vreg + nf * lmul].u8[index] = 0;
+            nf--;
+        }
+        break;
+    case 16:
+        while (nf >= 0) {
+            env->vfp.vreg[vreg + nf * lmul].u16[index] = 0;
+            nf--;
+        }
+        break;
+    case 32:
+        while (nf >= 0) {
+            env->vfp.vreg[vreg + nf * lmul].u32[index] = 0;
+            nf--;
+        }
+        break;
+    case 64:
+        while (nf >= 0) {
+            env->vfp.vreg[vreg + nf * lmul].u64[index] = 0;
+            nf--;
+        }
+        break;
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        return;
+    }
+}
+
 void VECTOR_HELPER(vsetvl)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,
     uint32_t rd)
 {
@@ -124,3 +244,2521 @@ void VECTOR_HELPER(vsetvli)(CPURISCVState *env, uint32_t rs1, uint32_t zimm,
     env->vfp.vstart = 0;
     return;
 }
+
+void VECTOR_HELPER(vlbu_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
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
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlb_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
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
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlsbu_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
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
+                        read = i * env->gpr[rs2] + k;
+                        env->vfp.vreg[dest + k * lmul].u8[j] =
+                            cpu_ldub_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k;
+                        env->vfp.vreg[dest + k * lmul].u16[j] =
+                            cpu_ldub_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k;
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_ldub_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k;
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_ldub_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlsb_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
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
+                        read = i * env->gpr[rs2] + k;
+                        env->vfp.vreg[dest + k * lmul].s8[j] =
+                            cpu_ldsb_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k;
+                        env->vfp.vreg[dest + k * lmul].s16[j] = sign_extend(
+                            cpu_ldsb_data(env, env->gpr[rs1] + read), 8);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k;
+                        env->vfp.vreg[dest + k * lmul].s32[j] = sign_extend(
+                            cpu_ldsb_data(env, env->gpr[rs1] + read), 8);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k;
+                        env->vfp.vreg[dest + k * lmul].s64[j] = sign_extend(
+                            cpu_ldsb_data(env, env->gpr[rs1] + read), 8);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlxbu_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        env->vfp.vreg[dest + k * lmul].u8[j] =
+                            cpu_ldub_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        env->vfp.vreg[dest + k * lmul].u16[j] =
+                            cpu_ldub_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_ldub_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_ldub_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlxb_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        env->vfp.vreg[dest + k * lmul].s8[j] =
+                            cpu_ldsb_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        env->vfp.vreg[dest + k * lmul].s16[j] = sign_extend(
+                            cpu_ldsb_data(env, addr), 8);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        env->vfp.vreg[dest + k * lmul].s32[j] = sign_extend(
+                            cpu_ldsb_data(env, addr), 8);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        env->vfp.vreg[dest + k * lmul].s64[j] = sign_extend(
+                            cpu_ldsb_data(env, addr), 8);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlhu_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
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
+
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
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlh_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
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
+
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
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlshu_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
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
+
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
+                        read = i * env->gpr[rs2] + k * 2;
+                        env->vfp.vreg[dest + k * lmul].u16[j] =
+                            cpu_lduw_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k * 2;
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_lduw_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k * 2;
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_lduw_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlsh_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
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
+                        read = i * env->gpr[rs2] + k * 2;
+                        env->vfp.vreg[dest + k * lmul].s16[j] =
+                            cpu_ldsw_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k * 2;
+                        env->vfp.vreg[dest + k * lmul].s32[j] = sign_extend(
+                            cpu_ldsw_data(env, env->gpr[rs1] + read), 16);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k * 2;
+                        env->vfp.vreg[dest + k * lmul].s64[j] = sign_extend(
+                            cpu_ldsw_data(env, env->gpr[rs1] + read), 16);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlxhu_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        env->vfp.vreg[dest + k * lmul].u16[j] =
+                            cpu_lduw_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_lduw_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_lduw_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlxh_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        env->vfp.vreg[dest + k * lmul].s16[j] =
+                            cpu_ldsw_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        env->vfp.vreg[dest + k * lmul].s32[j] = sign_extend(
+                            cpu_ldsw_data(env, addr), 16);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        env->vfp.vreg[dest + k * lmul].s64[j] = sign_extend(
+                            cpu_ldsw_data(env, addr), 16);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlw_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
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
+
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
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlwu_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
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
+
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
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlswu_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
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
+
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
+                        read = i * env->gpr[rs2] + k * 4;
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_ldl_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k * 4;
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_ldl_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlsw_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
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
+
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
+                        read = i * env->gpr[rs2] + k * 4;
+                        env->vfp.vreg[dest + k * lmul].s32[j] =
+                            cpu_ldl_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2] + k * 4;
+                        env->vfp.vreg[dest + k * lmul].s64[j] = sign_extend(
+                            cpu_ldl_data(env, env->gpr[rs1] + read), 32);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlxwu_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 4, width, k);
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_ldl_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 4, width, k);
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_ldl_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlxw_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 4, width, k);
+                        env->vfp.vreg[dest + k * lmul].s32[j] =
+                            cpu_ldl_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 4, width, k);
+                        env->vfp.vreg[dest + k * lmul].s64[j] = sign_extend(
+                            cpu_ldl_data(env, addr), 32);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vle_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
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
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlse_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
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
+                        read = i * env->gpr[rs2]  + k;
+                        env->vfp.vreg[dest + k * lmul].u8[j] =
+                            cpu_ldub_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2]  + k * 2;
+                        env->vfp.vreg[dest + k * lmul].u16[j] =
+                            cpu_lduw_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2]  + k * 4;
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_ldl_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        read = i * env->gpr[rs2]  + k * 8;
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_ldq_data(env, env->gpr[rs1] + read);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vlxe_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        env->vfp.vreg[dest + k * lmul].u8[j] =
+                            cpu_ldub_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        env->vfp.vreg[dest + k * lmul].u16[j] =
+                            cpu_lduw_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 4, width, k);
+                        env->vfp.vreg[dest + k * lmul].u32[j] =
+                            cpu_ldl_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 8, width, k);
+                        env->vfp.vreg[dest + k * lmul].u64[j] =
+                            cpu_ldq_data(env, addr);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_segment(env, dest, j, width, k, lmul);
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsb_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, wrote;
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
+
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
+                        wrote = i * (nf + 1) + k;
+                        cpu_stb_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s8[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * (nf + 1) + k;
+                        cpu_stb_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s16[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * (nf + 1) + k;
+                        cpu_stb_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * (nf + 1) + k;
+                        cpu_stb_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vssb_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, wrote;
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
+
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
+                        wrote = i * env->gpr[rs2] + k;
+                        cpu_stb_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s8[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * env->gpr[rs2] + k;
+                        cpu_stb_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s16[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * env->gpr[rs2] + k;
+                        cpu_stb_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * env->gpr[rs2] + k;
+                        cpu_stb_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsxb_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        cpu_stb_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s8[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        cpu_stb_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s16[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        cpu_stb_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        cpu_stb_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsuxb_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    return VECTOR_HELPER(vsxb_v)(env, nf, vm, rs1, rs2, rd);
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsh_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, wrote;
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
+
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
+                        wrote = (i * (nf + 1) + k) * 2;
+                        cpu_stw_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s16[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = (i * (nf + 1) + k) * 2;
+                        cpu_stw_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = (i * (nf + 1) + k) * 2;
+                        cpu_stw_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vssh_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, wrote;
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
+
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
+                        wrote = i * env->gpr[rs2] + k * 2;
+                        cpu_stw_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s16[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * env->gpr[rs2] + k * 2;
+                        cpu_stw_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * env->gpr[rs2] + k * 2;
+                        cpu_stw_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsxh_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        cpu_stw_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s16[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        cpu_stw_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        cpu_stw_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsuxh_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    return VECTOR_HELPER(vsxh_v)(env, nf, vm, rs1, rs2, rd);
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsw_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, wrote;
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
+                        wrote = (i * (nf + 1) + k) * 4;
+                        cpu_stl_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = (i * (nf + 1) + k) * 4;
+                        cpu_stl_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vssw_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, wrote;
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
+                        wrote = i * env->gpr[rs2] + k * 4;
+                        cpu_stl_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * env->gpr[rs2] + k * 4;
+                        cpu_stl_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsxw_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 4, width, k);
+                        cpu_stl_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 4, width, k);
+                        cpu_stl_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsuxw_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    return VECTOR_HELPER(vsxw_v)(env, nf, vm, rs1, rs2, rd);
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vse_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, wrote;
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
+
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
+                        wrote = i * (nf + 1) + k;
+                        cpu_stb_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s8[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = (i * (nf + 1) + k) * 2;
+                        cpu_stw_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s16[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = (i * (nf + 1) + k) * 4;
+                        cpu_stl_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = (i * (nf + 1) + k) * 8;
+                        cpu_stq_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsse_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, wrote;
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
+                        wrote = i * env->gpr[rs2] + k;
+                        cpu_stb_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s8[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * env->gpr[rs2] + k * 2;
+                        cpu_stw_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s16[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * env->gpr[rs2] + k * 4;
+                        cpu_stl_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        wrote = i * env->gpr[rs2] + k * 8;
+                        cpu_stq_data(env, env->gpr[rs1] + wrote,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsxe_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    int i, j, k, vl, vlmax, lmul, width, dest, src2;
+    target_ulong addr;
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
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = nf;
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
+                        cpu_stb_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s8[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 2, width, k);
+                        cpu_stw_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s16[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 4, width, k);
+                        cpu_stl_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s32[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    while (k >= 0) {
+                        addr = vector_get_index(env, rs1, src2, j, 8, width, k);
+                        cpu_stq_data(env, addr,
+                            env->vfp.vreg[dest + k * lmul].s64[j]);
+                        k--;
+                    }
+                    env->vfp.vstart++;
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        }
+    }
+    env->vfp.vstart = 0;
+}
+
+void VECTOR_HELPER(vsuxe_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
+    uint32_t rs1, uint32_t rs2, uint32_t rd)
+{
+    return VECTOR_HELPER(vsxe_v)(env, nf, vm, rs1, rs2, rd);
+    env->vfp.vstart = 0;
+}
+
-- 
2.7.4


