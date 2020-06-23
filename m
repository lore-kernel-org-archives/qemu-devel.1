Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E6CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07ECD2075D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07ECD2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnsj9-0000PZ-A9
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 19:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnsiW-0008MI-3o; Tue, 23 Jun 2020 19:52:40 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnsiT-0007Cf-QG; Tue, 23 Jun 2020 19:52:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1154582|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.0209329-0.00023831-0.978829;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03300; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.HrTZ.TK_1592956353; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HrTZ.TK_1592956353)
 by smtp.aliyun-inc.com(10.147.40.26); Wed, 24 Jun 2020 07:52:33 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v11 56/61] target/riscv: integer scalar move instruction
Date: Wed, 24 Jun 2020 05:59:15 +0800
Message-Id: <20200623215920.2594-57-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200623215920.2594-1-zhiwei_liu@c-sky.com>
References: <20200623215920.2594-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 17:32:41
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: richard.henderson@linaro.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 60 +++++++++++++++++++++++++
 target/riscv/internals.h                |  6 +++
 3 files changed, 67 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c4496cd010..e06c0ffc22 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -564,6 +564,7 @@ vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
+vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index cfbbd88dbf..b10b89daa9 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2649,3 +2649,63 @@ static bool trans_vext_x_v(DisasContext *s, arg_r *a)
     tcg_temp_free_i64(tmp);
     return true;
 }
+
+/* Integer Scalar Move Instruction */
+
+static void store_element(TCGv_i64 val, TCGv_ptr base,
+                          int ofs, int sew)
+{
+    switch (sew) {
+    case MO_8:
+        tcg_gen_st8_i64(val, base, ofs);
+        break;
+    case MO_16:
+        tcg_gen_st16_i64(val, base, ofs);
+        break;
+    case MO_32:
+        tcg_gen_st32_i64(val, base, ofs);
+        break;
+    case MO_64:
+        tcg_gen_st_i64(val, base, ofs);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+/*
+ * Store vreg[idx] = val.
+ * The index must be in range of VLMAX.
+ */
+static void vec_element_storei(DisasContext *s, int vreg,
+                               int idx, TCGv_i64 val)
+{
+    store_element(val, cpu_env, endian_ofs(s, vreg, idx), s->sew);
+}
+
+/* vmv.s.x vd, rs1 # vd[0] = rs1 */
+static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
+{
+    if (vext_check_isa_ill(s)) {
+        /* This instruction ignores LMUL and vector register groups */
+        int maxsz = s->vlen >> 3;
+        TCGv_i64 t1;
+        TCGLabel *over = gen_new_label();
+
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+        tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd), maxsz, maxsz, 0);
+        if (a->rs1 == 0) {
+            goto done;
+        }
+
+        t1 = tcg_temp_new_i64();
+        tcg_gen_extu_tl_i64(t1, cpu_gpr[a->rs1]);
+        vec_element_storei(s, a->rd, 0, t1);
+        tcg_temp_free_i64(t1);
+    done:
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f3cea478f7..37d33820ad 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -32,4 +32,10 @@ FIELD(VDATA, WD, 11, 1)
 target_ulong fclass_h(uint64_t frs1);
 target_ulong fclass_s(uint64_t frs1);
 target_ulong fclass_d(uint64_t frs1);
+
+#define SEW8  0
+#define SEW16 1
+#define SEW32 2
+#define SEW64 3
+
 #endif
-- 
2.23.0


