Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A737C2D0EB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0423E2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0423E2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyLq-00078C-4p
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIyEN-0002WB-1y
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIyEL-0003Ch-Tr
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:29:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jIyEL-000305-EB; Mon, 30 Mar 2020 13:29:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1479593|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.0304012-0.000415615-0.969183;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16370; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H7m.UWc_1585589378; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H7m.UWc_1585589378)
 by smtp.aliyun-inc.com(10.147.41.199);
 Tue, 31 Mar 2020 01:29:39 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v7 56/61] target/riscv: integer scalar move instruction
Date: Mon, 30 Mar 2020 23:36:28 +0800
Message-Id: <20200330153633.15298-57-zhiwei_liu@c-sky.com>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 60 +++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 26dd0f1b1b..0741a25540 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -562,6 +562,7 @@ vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
+vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 1bd4fa99ff..61c46e4c1c 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2664,3 +2664,63 @@ static bool trans_vext_x_v(DisasContext *s, arg_r *a)
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
+        tcg_gen_gvec_dup64i(vreg_ofs(s, a->rd), maxsz, maxsz, 0);
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
-- 
2.23.0


