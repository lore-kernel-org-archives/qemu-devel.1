Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC182C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15A32073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15A32073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyKK-00045B-RU
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIyCP-0007SI-Ig
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIyCO-0006ya-D7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:27:45 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jIyCO-0006rg-12; Mon, 30 Mar 2020 13:27:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07443529|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.022866-0.00137549-0.975759;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03267; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H7m6Dxa_1585589258; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H7m6Dxa_1585589258)
 by smtp.aliyun-inc.com(10.147.44.129);
 Tue, 31 Mar 2020 01:27:38 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v7 55/61] target/riscv: integer extract instruction
Date: Mon, 30 Mar 2020 23:36:27 +0800
Message-Id: <20200330153633.15298-56-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
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
 target/riscv/insn32.decode              |   1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 116 ++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1231628cb2..26dd0f1b1b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -561,6 +561,7 @@ vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 3dac7ae8e7..1bd4fa99ff 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2548,3 +2548,119 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
     }
     return false;
 }
+
+/*
+ *** Vector Permutation Instructions
+ */
+
+/* Integer Extract Instruction */
+
+static void load_element(TCGv_i64 dest, TCGv_ptr base,
+                         int ofs, int sew)
+{
+    switch (sew) {
+    case MO_8:
+        tcg_gen_ld8u_i64(dest, base, ofs);
+        break;
+    case MO_16:
+        tcg_gen_ld16u_i64(dest, base, ofs);
+        break;
+    case MO_32:
+        tcg_gen_ld32u_i64(dest, base, ofs);
+        break;
+    case MO_64:
+        tcg_gen_ld_i64(dest, base, ofs);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+/* offset of the idx element with base regsiter r */
+static uint32_t endian_ofs(DisasContext *s, int r, int idx)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+    return vreg_ofs(s, r) + ((idx ^ (7 >> s->sew)) << s->sew);
+#else
+    return vreg_ofs(s, r) + (idx << s->sew);
+#endif
+}
+
+/* adjust the index according to the endian */
+static void endian_adjust(TCGv_i32 ofs, int sew)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+    tcg_gen_xori_i32(ofs, ofs, 7 >> sew);
+#endif
+}
+
+/* Load idx >= VLMAX ? 0 : vreg[idx] */
+static void vec_element_loadx(DisasContext *s, TCGv_i64 dest,
+                              int vreg, TCGv idx, int vlmax)
+{
+    TCGv_i32 ofs = tcg_temp_new_i32();
+    TCGv_ptr base = tcg_temp_new_ptr();
+    TCGv_i64 t_idx = tcg_temp_new_i64();
+    TCGv_i64 t_vlmax, t_zero;
+
+    /*
+     * Mask the index to the length so that we do
+     * not produce an out-of-range load.
+     */
+    tcg_gen_trunc_tl_i32(ofs, idx);
+    tcg_gen_andi_i32(ofs, ofs, vlmax - 1);
+
+    /* Convert the index to an offset. */
+    endian_adjust(ofs, s->sew);
+    tcg_gen_shli_i32(ofs, ofs, s->sew);
+
+    /* Convert the index to a pointer. */
+    tcg_gen_ext_i32_ptr(base, ofs);
+    tcg_gen_add_ptr(base, base, cpu_env);
+
+    /* Perform the load. */
+    load_element(dest, base,
+                 vreg_ofs(s, vreg), s->sew);
+    tcg_temp_free_ptr(base);
+    tcg_temp_free_i32(ofs);
+
+    /* Flush out-of-range indexing to zero.  */
+    t_vlmax = tcg_const_i64(vlmax);
+    t_zero = tcg_const_i64(0);
+    tcg_gen_extu_tl_i64(t_idx, idx);
+
+    tcg_gen_movcond_i64(TCG_COND_LTU, dest, t_idx,
+                        t_vlmax, dest, t_zero);
+
+    tcg_temp_free_i64(t_vlmax);
+    tcg_temp_free_i64(t_zero);
+    tcg_temp_free_i64(t_idx);
+}
+
+static void vec_element_loadi(DisasContext *s, TCGv_i64 dest,
+                              int vreg, int idx)
+{
+    load_element(dest, cpu_env, endian_ofs(s, vreg, idx), s->sew);
+}
+
+static bool trans_vext_x_v(DisasContext *s, arg_r *a)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv dest = tcg_temp_new();
+
+    if (a->rs1 == 0) {
+        /* Special case vmv.x.s rd, vs2. */
+        vec_element_loadi(s, tmp, a->rs2, 0);
+    } else {
+        /* This instruction ignores LMUL and vector register groups */
+        int vlmax = s->vlen >> (3 + s->sew);
+        vec_element_loadx(s, tmp, a->rs2, cpu_gpr[a->rs1], vlmax);
+    }
+    tcg_gen_trunc_i64_tl(dest, tmp);
+    gen_set_gpr(a->rd, dest);
+
+    tcg_temp_free(dest);
+    tcg_temp_free_i64(tmp);
+    return true;
+}
-- 
2.23.0


