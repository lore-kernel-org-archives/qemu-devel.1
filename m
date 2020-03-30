Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CDAC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51D2205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51D2205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwg0-0004pr-Nx
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIwf2-0003y7-0z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIwex-0006sm-Lh
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:49:11 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jIwew-0006iI-AK; Mon, 30 Mar 2020 11:49:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0779509-0.00812316-0.913926;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03293; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=11; RT=11; SR=0; TI=SMTPD_---.H7jjpX._1585583338; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H7jjpX._1585583338) by smtp.aliyun-inc.com(10.147.40.2);
 Mon, 30 Mar 2020 23:48:59 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v7 06/61] target/riscv: add vector stride load and store
 instructions
Date: Mon, 30 Mar 2020 23:35:38 +0800
Message-Id: <20200330153633.15298-7-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vector strided operations access the first memory element at the base address,
and then access subsequent elements at address increments given by the byte
offset contained in the x register specified by rs2.

Vector unit-stride operations access elements stored contiguously in memory
starting from the base effective address. It can been seen as a special
case of strided operations.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 105 ++++++
 target/riscv/insn32.decode              |  32 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 355 ++++++++++++++++++++
 target/riscv/internals.h                |   5 +
 target/riscv/translate.c                |   7 +
 target/riscv/vector_helper.c            | 410 ++++++++++++++++++++++++
 6 files changed, 914 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 3c28c7e407..87dfa90609 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -78,3 +78,108 @@ DEF_HELPER_1(tlb_flush, void, env)
 #endif
 /* Vector functions */
 DEF_HELPER_3(vsetvl, tl, env, tl, tl)
+DEF_HELPER_5(vlb_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_6(vlsb_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsb_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsb_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsb_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsh_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsh_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsh_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsw_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsw_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlshu_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlshu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlshu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlswu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlswu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssh_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssh_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssh_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssw_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssw_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_d, void, ptr, ptr, tl, tl, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 53340bdbc4..ef521152c5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -25,6 +25,7 @@
 %sh10    20:10
 %csr    20:12
 %rm     12:3
+%nf     29:3                     !function=ex_plus_1
 
 # immediates:
 %imm_i    20:s12
@@ -43,6 +44,8 @@
 &u    imm rd
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
+&r2nfvm    vm rd rs1 nf
+&rnfvm     vm rd rs1 rs2 nf
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
@@ -62,6 +65,8 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
+@r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
 @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -210,5 +215,32 @@ fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
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
+# *** new major opcode OP-V ***
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 1007bb778c..e90f956c0f 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -15,6 +15,9 @@
  * You should have received a copy of the GNU General Public License along with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "internals.h"
 
 static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
 {
@@ -77,3 +80,355 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
     tcg_temp_free(dst);
     return true;
 }
+
+/* vector register offset from env */
+static uint32_t vreg_ofs(DisasContext *s, int reg)
+{
+    return offsetof(CPURISCVState, vreg) + reg * s->vlen / 8;
+}
+
+/* check functions */
+
+/*
+ * In cpu_get_tb_cpu_state(), set VILL if RVV was not present.
+ * So RVV is also be checked in this function.
+ */
+static bool vext_check_isa_ill(DisasContext *s)
+{
+    return !s->vill;
+}
+
+/*
+ * There are two rules check here.
+ *
+ * 1. Vector register numbers are multiples of LMUL. (Section 3.2)
+ *
+ * 2. For all widening instructions, the destination LMUL value must also be
+ *    a supported LMUL value. (Section 11.2）
+ */
+static bool vext_check_reg(DisasContext *s, uint32_t reg, bool widen)
+{
+    /*
+     * The destination vector register group results are arranged as if both
+     * SEW and LMUL were at twice their current settings. (Section 11.2).
+     */
+    int legal = widen ? 2 << s->lmul : 1 << s->lmul;
+
+    return !((s->lmul == 0x3 && widen) || (reg % legal));
+}
+
+/*
+ * There are two rules check here.
+ *
+ * 1. The destination vector register group for a masked vector instruction can
+ *    only overlap the source mask register (v0) when LMUL=1. (Section 5.3)
+ *
+ * 2. In widen instructions and some other insturctions, like vslideup.vx,
+ *    there is no need to check whether LMUL=1.
+ */
+static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm,
+    bool force)
+{
+    return (vm != 0 || vd != 0) || (!force && (s->lmul == 0));
+}
+
+/* The LMUL setting must be such that LMUL * NFIELDS <= 8. (Section 7.8) */
+static bool vext_check_nf(DisasContext *s, uint32_t nf)
+{
+    return (1 << s->lmul) * nf <= 8;
+}
+
+/* common translation macro */
+#define GEN_VEXT_TRANS(NAME, SEQ, ARGTYPE, OP, CHECK)      \
+static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE *a)\
+{                                                          \
+    if (CHECK(s, a)) {                                     \
+        return OP(s, a, SEQ);                              \
+    }                                                      \
+    return false;                                          \
+}
+
+/*
+ *** unit stride load and store
+ */
+typedef void gen_helper_ldst_us(TCGv_ptr, TCGv_ptr, TCGv,
+                                TCGv_env, TCGv_i32);
+
+static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
+                          gen_helper_ldst_us *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask;
+    TCGv base;
+    TCGv_i32 desc;
+
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+
+    /*
+     * As simd_desc supports at most 256 bytes, and in this implementation,
+     * the max vector group length is 2048 bytes. So split it into two parts.
+     *
+     * The first part is vlen in bytes, encoded in maxsz of simd_desc.
+     * The second part is lmul, encoded in data of simd_desc.
+     */
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    gen_get_gpr(base, rs1);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, base, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free(base);
+    tcg_temp_free_i32(desc);
+    gen_set_label(over);
+    return true;
+}
+
+static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_us *fn;
+    static gen_helper_ldst_us * const fns[2][7][4] = {
+        /* masked unit stride load */
+        { { gen_helper_vlb_v_b_mask,  gen_helper_vlb_v_h_mask,
+            gen_helper_vlb_v_w_mask,  gen_helper_vlb_v_d_mask },
+          { NULL,                     gen_helper_vlh_v_h_mask,
+            gen_helper_vlh_v_w_mask,  gen_helper_vlh_v_d_mask },
+          { NULL,                     NULL,
+            gen_helper_vlw_v_w_mask,  gen_helper_vlw_v_d_mask },
+          { gen_helper_vle_v_b_mask,  gen_helper_vle_v_h_mask,
+            gen_helper_vle_v_w_mask,  gen_helper_vle_v_d_mask },
+          { gen_helper_vlbu_v_b_mask, gen_helper_vlbu_v_h_mask,
+            gen_helper_vlbu_v_w_mask, gen_helper_vlbu_v_d_mask },
+          { NULL,                     gen_helper_vlhu_v_h_mask,
+            gen_helper_vlhu_v_w_mask, gen_helper_vlhu_v_d_mask },
+          { NULL,                     NULL,
+            gen_helper_vlwu_v_w_mask, gen_helper_vlwu_v_d_mask } },
+        /* unmasked unit stride load */
+        { { gen_helper_vlb_v_b,  gen_helper_vlb_v_h,
+            gen_helper_vlb_v_w,  gen_helper_vlb_v_d },
+          { NULL,                gen_helper_vlh_v_h,
+            gen_helper_vlh_v_w,  gen_helper_vlh_v_d },
+          { NULL,                NULL,
+            gen_helper_vlw_v_w,  gen_helper_vlw_v_d },
+          { gen_helper_vle_v_b,  gen_helper_vle_v_h,
+            gen_helper_vle_v_w,  gen_helper_vle_v_d },
+          { gen_helper_vlbu_v_b, gen_helper_vlbu_v_h,
+            gen_helper_vlbu_v_w, gen_helper_vlbu_v_d },
+          { NULL,                gen_helper_vlhu_v_h,
+            gen_helper_vlhu_v_w, gen_helper_vlhu_v_d },
+          { NULL,                NULL,
+            gen_helper_vlwu_v_w, gen_helper_vlwu_v_d } }
+    };
+
+    fn =  fns[a->vm][seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
+}
+
+static bool ld_us_check(DisasContext *s, arg_r2nfvm* a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vlb_v, 0, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vlh_v, 1, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vlw_v, 2, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vle_v, 3, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vlbu_v, 4, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vlhu_v, 5, r2nfvm, ld_us_op, ld_us_check)
+GEN_VEXT_TRANS(vlwu_v, 6, r2nfvm, ld_us_op, ld_us_check)
+
+static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_us *fn;
+    static gen_helper_ldst_us * const fns[2][4][4] = {
+        /* masked unit stride load and store */
+        { { gen_helper_vsb_v_b_mask,  gen_helper_vsb_v_h_mask,
+            gen_helper_vsb_v_w_mask,  gen_helper_vsb_v_d_mask },
+          { NULL,                     gen_helper_vsh_v_h_mask,
+            gen_helper_vsh_v_w_mask,  gen_helper_vsh_v_d_mask },
+          { NULL,                     NULL,
+            gen_helper_vsw_v_w_mask,  gen_helper_vsw_v_d_mask },
+          { gen_helper_vse_v_b_mask,  gen_helper_vse_v_h_mask,
+            gen_helper_vse_v_w_mask,  gen_helper_vse_v_d_mask } },
+        /* unmasked unit stride store */
+        { { gen_helper_vsb_v_b,  gen_helper_vsb_v_h,
+            gen_helper_vsb_v_w,  gen_helper_vsb_v_d },
+          { NULL,                gen_helper_vsh_v_h,
+            gen_helper_vsh_v_w,  gen_helper_vsh_v_d },
+          { NULL,                NULL,
+            gen_helper_vsw_v_w,  gen_helper_vsw_v_d },
+          { gen_helper_vse_v_b,  gen_helper_vse_v_h,
+            gen_helper_vse_v_w,  gen_helper_vse_v_d } }
+    };
+
+    fn =  fns[a->vm][seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
+}
+
+static bool st_us_check(DisasContext *s, arg_r2nfvm* a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vsb_v, 0, r2nfvm, st_us_op, st_us_check)
+GEN_VEXT_TRANS(vsh_v, 1, r2nfvm, st_us_op, st_us_check)
+GEN_VEXT_TRANS(vsw_v, 2, r2nfvm, st_us_op, st_us_check)
+GEN_VEXT_TRANS(vse_v, 3, r2nfvm, st_us_op, st_us_check)
+
+/*
+ *** stride load and store
+ */
+typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
+                                    TCGv, TCGv_env, TCGv_i32);
+
+static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
+                              uint32_t data, gen_helper_ldst_stride *fn,
+                              DisasContext *s)
+{
+    TCGv_ptr dest, mask;
+    TCGv base, stride;
+    TCGv_i32 desc;
+
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    stride = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    gen_get_gpr(base, rs1);
+    gen_get_gpr(stride, rs2);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, base, stride, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free(base);
+    tcg_temp_free(stride);
+    tcg_temp_free_i32(desc);
+    gen_set_label(over);
+    return true;
+}
+
+static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_stride *fn;
+    static gen_helper_ldst_stride * const fns[7][4] = {
+        { gen_helper_vlsb_v_b,  gen_helper_vlsb_v_h,
+          gen_helper_vlsb_v_w,  gen_helper_vlsb_v_d },
+        { NULL,                 gen_helper_vlsh_v_h,
+          gen_helper_vlsh_v_w,  gen_helper_vlsh_v_d },
+        { NULL,                 NULL,
+          gen_helper_vlsw_v_w,  gen_helper_vlsw_v_d },
+        { gen_helper_vlse_v_b,  gen_helper_vlse_v_h,
+          gen_helper_vlse_v_w,  gen_helper_vlse_v_d },
+        { gen_helper_vlsbu_v_b, gen_helper_vlsbu_v_h,
+          gen_helper_vlsbu_v_w, gen_helper_vlsbu_v_d },
+        { NULL,                 gen_helper_vlshu_v_h,
+          gen_helper_vlshu_v_w, gen_helper_vlshu_v_d },
+        { NULL,                 NULL,
+          gen_helper_vlswu_v_w, gen_helper_vlswu_v_d },
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool ld_stride_check(DisasContext *s, arg_rnfvm* a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vlsb_v, 0, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlsh_v, 1, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlsw_v, 2, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlse_v, 3, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlsbu_v, 4, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlshu_v, 5, rnfvm, ld_stride_op, ld_stride_check)
+GEN_VEXT_TRANS(vlswu_v, 6, rnfvm, ld_stride_op, ld_stride_check)
+
+static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_stride *fn;
+    static gen_helper_ldst_stride * const fns[4][4] = {
+        /* masked stride store */
+        { gen_helper_vssb_v_b,  gen_helper_vssb_v_h,
+          gen_helper_vssb_v_w,  gen_helper_vssb_v_d },
+        { NULL,                 gen_helper_vssh_v_h,
+          gen_helper_vssh_v_w,  gen_helper_vssh_v_d },
+        { NULL,                 NULL,
+          gen_helper_vssw_v_w,  gen_helper_vssw_v_d },
+        { gen_helper_vsse_v_b,  gen_helper_vsse_v_h,
+          gen_helper_vsse_v_w,  gen_helper_vsse_v_d }
+    };
+
+    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool st_stride_check(DisasContext *s, arg_rnfvm* a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vssb_v, 0, rnfvm, st_stride_op, st_stride_check)
+GEN_VEXT_TRANS(vssh_v, 1, rnfvm, st_stride_op, st_stride_check)
+GEN_VEXT_TRANS(vssw_v, 2, rnfvm, st_stride_op, st_stride_check)
+GEN_VEXT_TRANS(vsse_v, 3, rnfvm, st_stride_op, st_stride_check)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 0f75634b6c..04b0081f0c 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -21,4 +21,9 @@
 
 #include "hw/registerfields.h"
 
+/* share data between vector helpers and decode code */
+FIELD(VDATA, MLEN, 0, 8)
+FIELD(VDATA, VM, 8, 1)
+FIELD(VDATA, LMUL, 9, 2)
+FIELD(VDATA, NF, 11, 4)
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1fff7cefaa..c8ae562e4b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -61,6 +61,7 @@ typedef struct DisasContext {
     uint8_t lmul;
     uint8_t sew;
     uint16_t vlen;
+    uint16_t mlen;
     bool vl_eq_vlmax;
 } DisasContext;
 
@@ -548,6 +549,11 @@ static void decode_RV32_64C(DisasContext *ctx, uint16_t opcode)
     }
 }
 
+static int ex_plus_1(DisasContext *ctx, int nf)
+{
+    return nf + 1;
+}
+
 #define EX_SH(amount) \
     static int ex_shift_##amount(DisasContext *ctx, int imm) \
     {                                         \
@@ -784,6 +790,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
     ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
+    ctx->mlen = 1 << (ctx->sew  + 3 - ctx->lmul);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
 }
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8e2334b189..2027164b7c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -18,8 +18,11 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/memop.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "internals.h"
 #include <math.h>
 
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
@@ -51,3 +54,410 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     env->vstart = 0;
     return vl;
 }
+
+/*
+ * Note that vector data is stored in host-endian 64-bit chunks,
+ * so addressing units smaller than that needs a host-endian fixup.
+ */
+#ifdef HOST_WORDS_BIGENDIAN
+#define H1(x)   ((x) ^ 7)
+#define H1_2(x) ((x) ^ 6)
+#define H1_4(x) ((x) ^ 4)
+#define H2(x)   ((x) ^ 3)
+#define H4(x)   ((x) ^ 1)
+#define H8(x)   ((x))
+#else
+#define H1(x)   (x)
+#define H1_2(x) (x)
+#define H1_4(x) (x)
+#define H2(x)   (x)
+#define H4(x)   (x)
+#define H8(x)   (x)
+#endif
+
+static inline uint32_t vext_nf(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, NF);
+}
+
+static inline uint32_t vext_mlen(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, MLEN);
+}
+
+static inline uint32_t vext_vm(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, VM);
+}
+
+static inline uint32_t vext_lmul(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, LMUL);
+}
+
+/*
+ * Get vector group length in bytes. Its range is [64, 2048].
+ *
+ * As simd_desc support at most 256, the max vlen is 512 bits.
+ * So vlen in bytes is encoded as maxsz.
+ */
+static inline uint32_t vext_maxsz(uint32_t desc)
+{
+    return simd_maxsz(desc) << vext_lmul(desc);
+}
+
+/*
+ * This function checks watchpoint before real load operation.
+ *
+ * In softmmu mode, the TLB API probe_access is enough for watchpoint check.
+ * In user mode, there is no watchpoint support now.
+ *
+ * It will trigger an exception if there is no mapping in TLB
+ * and page table walk can't fill the TLB entry. Then the guest
+ * software can return here after process the exception or never return.
+ */
+static void probe_pages(CPURISCVState *env, target_ulong addr,
+                        target_ulong len, uintptr_t ra,
+                        MMUAccessType access_type)
+{
+    target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
+    target_ulong curlen = MIN(pagelen, len);
+
+    probe_access(env, addr, curlen, access_type,
+                 cpu_mmu_index(env, false), ra);
+    if (len > curlen) {
+        addr += curlen;
+        curlen = len - curlen;
+        probe_access(env, addr, curlen, access_type,
+                     cpu_mmu_index(env, false), ra);
+    }
+}
+
+#ifdef HOST_WORDS_BIGENDIAN
+static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
+{
+    /*
+     * Split the remaining range to two parts.
+     * The first part is in the last uint64_t unit.
+     * The second part start from the next uint64_t unit.
+     */
+    int part1 = 0, part2 = tot - cnt;
+    if (cnt % 8) {
+        part1 = 8 - (cnt % 8);
+        part2 = tot - cnt - part1;
+        memset(tail & ~(7ULL), 0, part1);
+        memset((tail + 8) & ~(7ULL), 0, part2);
+    } else {
+        memset(tail, 0, part2);
+    }
+}
+#else
+static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
+{
+    memset(tail, 0, tot - cnt);
+}
+#endif
+
+static void clearb(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int8_t *cur = ((int8_t *)vd + H1(idx));
+    vext_clear(cur, cnt, tot);
+}
+
+static void clearh(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int16_t *cur = ((int16_t *)vd + H2(idx));
+    vext_clear(cur, cnt, tot);
+}
+
+static void clearl(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int32_t *cur = ((int32_t *)vd + H4(idx));
+    vext_clear(cur, cnt, tot);
+}
+
+static void clearq(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int64_t *cur = (int64_t *)vd + idx;
+    vext_clear(cur, cnt, tot);
+}
+
+
+static inline int vext_elem_mask(void *v0, int mlen, int index)
+{
+    int idx = (index * mlen) / 64;
+    int pos = (index * mlen) % 64;
+    return (((uint64_t *)v0)[idx] >> pos) & 1;
+}
+
+/* elements operations for load and store */
+typedef void vext_ldst_elem_fn(CPURISCVState *env, target_ulong addr,
+                               uint32_t idx, void *vd, uintptr_t retaddr);
+typedef void clear_fn(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot);
+
+#define GEN_VEXT_LD_ELEM(NAME, MTYPE, ETYPE, H, LDSUF)     \
+static void NAME(CPURISCVState *env, abi_ptr addr,         \
+                 uint32_t idx, void *vd, uintptr_t retaddr)\
+{                                                          \
+    MTYPE data;                                            \
+    ETYPE *cur = ((ETYPE *)vd + H(idx));                   \
+    data = cpu_##LDSUF##_data_ra(env, addr, retaddr);      \
+    *cur = data;                                           \
+}                                                          \
+
+GEN_VEXT_LD_ELEM(ldb_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(ldb_h, int8_t,  int16_t, H2, ldsb)
+GEN_VEXT_LD_ELEM(ldb_w, int8_t,  int32_t, H4, ldsb)
+GEN_VEXT_LD_ELEM(ldb_d, int8_t,  int64_t, H8, ldsb)
+GEN_VEXT_LD_ELEM(ldh_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(ldh_w, int16_t, int32_t, H4, ldsw)
+GEN_VEXT_LD_ELEM(ldh_d, int16_t, int64_t, H8, ldsw)
+GEN_VEXT_LD_ELEM(ldw_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(ldw_d, int32_t, int64_t, H8, ldl)
+GEN_VEXT_LD_ELEM(lde_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(lde_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(lde_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(lde_d, int64_t, int64_t, H8, ldq)
+GEN_VEXT_LD_ELEM(ldbu_b, uint8_t,  uint8_t,  H1, ldub)
+GEN_VEXT_LD_ELEM(ldbu_h, uint8_t,  uint16_t, H2, ldub)
+GEN_VEXT_LD_ELEM(ldbu_w, uint8_t,  uint32_t, H4, ldub)
+GEN_VEXT_LD_ELEM(ldbu_d, uint8_t,  uint64_t, H8, ldub)
+GEN_VEXT_LD_ELEM(ldhu_h, uint16_t, uint16_t, H2, lduw)
+GEN_VEXT_LD_ELEM(ldhu_w, uint16_t, uint32_t, H4, lduw)
+GEN_VEXT_LD_ELEM(ldhu_d, uint16_t, uint64_t, H8, lduw)
+GEN_VEXT_LD_ELEM(ldwu_w, uint32_t, uint32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(ldwu_d, uint32_t, uint64_t, H8, ldl)
+
+#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)            \
+static void NAME(CPURISCVState *env, abi_ptr addr,         \
+                 uint32_t idx, void *vd, uintptr_t retaddr)\
+{                                                          \
+    ETYPE data = *((ETYPE *)vd + H(idx));                  \
+    cpu_##STSUF##_data_ra(env, addr, data, retaddr);       \
+}
+
+GEN_VEXT_ST_ELEM(stb_b, int8_t,  H1, stb)
+GEN_VEXT_ST_ELEM(stb_h, int16_t, H2, stb)
+GEN_VEXT_ST_ELEM(stb_w, int32_t, H4, stb)
+GEN_VEXT_ST_ELEM(stb_d, int64_t, H8, stb)
+GEN_VEXT_ST_ELEM(sth_h, int16_t, H2, stw)
+GEN_VEXT_ST_ELEM(sth_w, int32_t, H4, stw)
+GEN_VEXT_ST_ELEM(sth_d, int64_t, H8, stw)
+GEN_VEXT_ST_ELEM(stw_w, int32_t, H4, stl)
+GEN_VEXT_ST_ELEM(stw_d, int64_t, H8, stl)
+GEN_VEXT_ST_ELEM(ste_b, int8_t,  H1, stb)
+GEN_VEXT_ST_ELEM(ste_h, int16_t, H2, stw)
+GEN_VEXT_ST_ELEM(ste_w, int32_t, H4, stl)
+GEN_VEXT_ST_ELEM(ste_d, int64_t, H8, stq)
+
+/*
+ *** stride: access vector element from strided memory
+ */
+static void
+vext_ldst_stride(void *vd, void *v0, target_ulong base,
+                 target_ulong stride, CPURISCVState *env,
+                 uint32_t desc, uint32_t vm,
+                 vext_ldst_elem_fn *ldst_elem, clear_fn *clear_elem,
+                 uint32_t esz, uint32_t msz, uintptr_t ra,
+                 MMUAccessType access_type)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        probe_pages(env, base + stride * i, nf * msz, ra, access_type);
+    }
+    /* do real access */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            target_ulong addr = base + stride * i + k * msz;
+            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    if (clear_elem) {
+        for (k = 0; k < nf; k++) {
+            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+        }
+    }
+}
+
+#define GEN_VEXT_LD_STRIDE(NAME, MTYPE, ETYPE, LOAD_FN, CLEAR_FN)       \
+void HELPER(NAME)(void *vd, void * v0, target_ulong base,               \
+                  target_ulong stride, CPURISCVState *env,              \
+                  uint32_t desc)                                        \
+{                                                                       \
+    uint32_t vm = vext_vm(desc);                                        \
+    vext_ldst_stride(vd, v0, base, stride, env, desc, vm, LOAD_FN,      \
+                     CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE),            \
+                     GETPC(), MMU_DATA_LOAD);                           \
+}
+
+GEN_VEXT_LD_STRIDE(vlsb_v_b,  int8_t,   int8_t,   ldb_b,  clearb)
+GEN_VEXT_LD_STRIDE(vlsb_v_h,  int8_t,   int16_t,  ldb_h,  clearh)
+GEN_VEXT_LD_STRIDE(vlsb_v_w,  int8_t,   int32_t,  ldb_w,  clearl)
+GEN_VEXT_LD_STRIDE(vlsb_v_d,  int8_t,   int64_t,  ldb_d,  clearq)
+GEN_VEXT_LD_STRIDE(vlsh_v_h,  int16_t,  int16_t,  ldh_h,  clearh)
+GEN_VEXT_LD_STRIDE(vlsh_v_w,  int16_t,  int32_t,  ldh_w,  clearl)
+GEN_VEXT_LD_STRIDE(vlsh_v_d,  int16_t,  int64_t,  ldh_d,  clearq)
+GEN_VEXT_LD_STRIDE(vlsw_v_w,  int32_t,  int32_t,  ldw_w,  clearl)
+GEN_VEXT_LD_STRIDE(vlsw_v_d,  int32_t,  int64_t,  ldw_d,  clearq)
+GEN_VEXT_LD_STRIDE(vlse_v_b,  int8_t,   int8_t,   lde_b,  clearb)
+GEN_VEXT_LD_STRIDE(vlse_v_h,  int16_t,  int16_t,  lde_h,  clearh)
+GEN_VEXT_LD_STRIDE(vlse_v_w,  int32_t,  int32_t,  lde_w,  clearl)
+GEN_VEXT_LD_STRIDE(vlse_v_d,  int64_t,  int64_t,  lde_d,  clearq)
+GEN_VEXT_LD_STRIDE(vlsbu_v_b, uint8_t,  uint8_t,  ldbu_b, clearb)
+GEN_VEXT_LD_STRIDE(vlsbu_v_h, uint8_t,  uint16_t, ldbu_h, clearh)
+GEN_VEXT_LD_STRIDE(vlsbu_v_w, uint8_t,  uint32_t, ldbu_w, clearl)
+GEN_VEXT_LD_STRIDE(vlsbu_v_d, uint8_t,  uint64_t, ldbu_d, clearq)
+GEN_VEXT_LD_STRIDE(vlshu_v_h, uint16_t, uint16_t, ldhu_h, clearh)
+GEN_VEXT_LD_STRIDE(vlshu_v_w, uint16_t, uint32_t, ldhu_w, clearl)
+GEN_VEXT_LD_STRIDE(vlshu_v_d, uint16_t, uint64_t, ldhu_d, clearq)
+GEN_VEXT_LD_STRIDE(vlswu_v_w, uint32_t, uint32_t, ldwu_w, clearl)
+GEN_VEXT_LD_STRIDE(vlswu_v_d, uint32_t, uint64_t, ldwu_d, clearq)
+
+#define GEN_VEXT_ST_STRIDE(NAME, MTYPE, ETYPE, STORE_FN)                \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
+                  target_ulong stride, CPURISCVState *env,              \
+                  uint32_t desc)                                        \
+{                                                                       \
+    uint32_t vm = vext_vm(desc);                                        \
+    vext_ldst_stride(vd, v0, base, stride, env, desc, vm, STORE_FN,     \
+                     NULL, sizeof(ETYPE), sizeof(MTYPE),                \
+                     GETPC(), MMU_DATA_STORE);                          \
+}
+
+GEN_VEXT_ST_STRIDE(vssb_v_b, int8_t,  int8_t,  stb_b)
+GEN_VEXT_ST_STRIDE(vssb_v_h, int8_t,  int16_t, stb_h)
+GEN_VEXT_ST_STRIDE(vssb_v_w, int8_t,  int32_t, stb_w)
+GEN_VEXT_ST_STRIDE(vssb_v_d, int8_t,  int64_t, stb_d)
+GEN_VEXT_ST_STRIDE(vssh_v_h, int16_t, int16_t, sth_h)
+GEN_VEXT_ST_STRIDE(vssh_v_w, int16_t, int32_t, sth_w)
+GEN_VEXT_ST_STRIDE(vssh_v_d, int16_t, int64_t, sth_d)
+GEN_VEXT_ST_STRIDE(vssw_v_w, int32_t, int32_t, stw_w)
+GEN_VEXT_ST_STRIDE(vssw_v_d, int32_t, int64_t, stw_d)
+GEN_VEXT_ST_STRIDE(vsse_v_b, int8_t,  int8_t,  ste_b)
+GEN_VEXT_ST_STRIDE(vsse_v_h, int16_t, int16_t, ste_h)
+GEN_VEXT_ST_STRIDE(vsse_v_w, int32_t, int32_t, ste_w)
+GEN_VEXT_ST_STRIDE(vsse_v_d, int64_t, int64_t, ste_d)
+
+/*
+ *** unit-stride: access elements stored contiguously in memory
+ */
+
+/* unmasked unit-stride load and store operation*/
+static void
+vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
+             vext_ldst_elem_fn *ldst_elem, clear_fn *clear_elem,
+             uint32_t esz, uint32_t msz, uintptr_t ra,
+             MMUAccessType access_type)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    /* probe every access */
+    probe_pages(env, base, env->vl * nf * msz, ra, access_type);
+    /* load bytes from guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        while (k < nf) {
+            target_ulong addr = base + (i * nf + k) * msz;
+            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    if (clear_elem) {
+        for (k = 0; k < nf; k++) {
+            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+        }
+    }
+}
+
+/*
+ * masked unit-stride load and store operation will be a special case of stride,
+ * stride = NF * sizeof (MTYPE)
+ */
+
+#define GEN_VEXT_LD_US(NAME, MTYPE, ETYPE, LOAD_FN, CLEAR_FN)           \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,         \
+                         CPURISCVState *env, uint32_t desc)             \
+{                                                                       \
+    uint32_t stride = vext_nf(desc) * sizeof(MTYPE);                    \
+    vext_ldst_stride(vd, v0, base, stride, env, desc, false, LOAD_FN,   \
+                     CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE),            \
+                     GETPC(), MMU_DATA_LOAD);                           \
+}                                                                       \
+                                                                        \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
+                  CPURISCVState *env, uint32_t desc)                    \
+{                                                                       \
+    vext_ldst_us(vd, base, env, desc, LOAD_FN, CLEAR_FN,                \
+                 sizeof(ETYPE), sizeof(MTYPE), GETPC(), MMU_DATA_LOAD); \
+}
+
+GEN_VEXT_LD_US(vlb_v_b,  int8_t,   int8_t,   ldb_b,  clearb)
+GEN_VEXT_LD_US(vlb_v_h,  int8_t,   int16_t,  ldb_h,  clearh)
+GEN_VEXT_LD_US(vlb_v_w,  int8_t,   int32_t,  ldb_w,  clearl)
+GEN_VEXT_LD_US(vlb_v_d,  int8_t,   int64_t,  ldb_d,  clearq)
+GEN_VEXT_LD_US(vlh_v_h,  int16_t,  int16_t,  ldh_h,  clearh)
+GEN_VEXT_LD_US(vlh_v_w,  int16_t,  int32_t,  ldh_w,  clearl)
+GEN_VEXT_LD_US(vlh_v_d,  int16_t,  int64_t,  ldh_d,  clearq)
+GEN_VEXT_LD_US(vlw_v_w,  int32_t,  int32_t,  ldw_w,  clearl)
+GEN_VEXT_LD_US(vlw_v_d,  int32_t,  int64_t,  ldw_d,  clearq)
+GEN_VEXT_LD_US(vle_v_b,  int8_t,   int8_t,   lde_b,  clearb)
+GEN_VEXT_LD_US(vle_v_h,  int16_t,  int16_t,  lde_h,  clearh)
+GEN_VEXT_LD_US(vle_v_w,  int32_t,  int32_t,  lde_w,  clearl)
+GEN_VEXT_LD_US(vle_v_d,  int64_t,  int64_t,  lde_d,  clearq)
+GEN_VEXT_LD_US(vlbu_v_b, uint8_t,  uint8_t,  ldbu_b, clearb)
+GEN_VEXT_LD_US(vlbu_v_h, uint8_t,  uint16_t, ldbu_h, clearh)
+GEN_VEXT_LD_US(vlbu_v_w, uint8_t,  uint32_t, ldbu_w, clearl)
+GEN_VEXT_LD_US(vlbu_v_d, uint8_t,  uint64_t, ldbu_d, clearq)
+GEN_VEXT_LD_US(vlhu_v_h, uint16_t, uint16_t, ldhu_h, clearh)
+GEN_VEXT_LD_US(vlhu_v_w, uint16_t, uint32_t, ldhu_w, clearl)
+GEN_VEXT_LD_US(vlhu_v_d, uint16_t, uint64_t, ldhu_d, clearq)
+GEN_VEXT_LD_US(vlwu_v_w, uint32_t, uint32_t, ldwu_w, clearl)
+GEN_VEXT_LD_US(vlwu_v_d, uint32_t, uint64_t, ldwu_d, clearq)
+
+#define GEN_VEXT_ST_US(NAME, MTYPE, ETYPE, STORE_FN)                    \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,         \
+                         CPURISCVState *env, uint32_t desc)             \
+{                                                                       \
+    uint32_t stride = vext_nf(desc) * sizeof(MTYPE);                    \
+    vext_ldst_stride(vd, v0, base, stride, env, desc, false, STORE_FN,  \
+                     NULL, sizeof(ETYPE), sizeof(MTYPE),                \
+                     GETPC(), MMU_DATA_STORE);                          \
+}                                                                       \
+                                                                        \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
+                  CPURISCVState *env, uint32_t desc)                    \
+{                                                                       \
+    vext_ldst_us(vd, base, env, desc, STORE_FN, NULL,                   \
+                 sizeof(ETYPE), sizeof(MTYPE), GETPC(), MMU_DATA_STORE);\
+}
+
+GEN_VEXT_ST_US(vsb_v_b, int8_t,  int8_t , stb_b)
+GEN_VEXT_ST_US(vsb_v_h, int8_t,  int16_t, stb_h)
+GEN_VEXT_ST_US(vsb_v_w, int8_t,  int32_t, stb_w)
+GEN_VEXT_ST_US(vsb_v_d, int8_t,  int64_t, stb_d)
+GEN_VEXT_ST_US(vsh_v_h, int16_t, int16_t, sth_h)
+GEN_VEXT_ST_US(vsh_v_w, int16_t, int32_t, sth_w)
+GEN_VEXT_ST_US(vsh_v_d, int16_t, int64_t, sth_d)
+GEN_VEXT_ST_US(vsw_v_w, int32_t, int32_t, stw_w)
+GEN_VEXT_ST_US(vsw_v_d, int32_t, int64_t, stw_d)
+GEN_VEXT_ST_US(vse_v_b, int8_t,  int8_t , ste_b)
+GEN_VEXT_ST_US(vse_v_h, int16_t, int16_t, ste_h)
+GEN_VEXT_ST_US(vse_v_w, int32_t, int32_t, ste_w)
+GEN_VEXT_ST_US(vse_v_d, int64_t, int64_t, ste_d)
-- 
2.23.0


