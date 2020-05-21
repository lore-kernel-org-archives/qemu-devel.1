Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E9FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83F6207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83F6207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbjaI-0007Qo-Vw
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 07:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jbjZY-0006cL-5A; Thu, 21 May 2020 07:41:12 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jbjZX-0000JL-3k; Thu, 21 May 2020 07:41:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1000067|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.0378942-0.000898105-0.961208;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03294; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.HbeihFt_1590061264; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HbeihFt_1590061264)
 by smtp.aliyun-inc.com(10.147.41.187);
 Thu, 21 May 2020 19:41:05 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v8 58/62] target/riscv: floating-point scalar move instructions
Date: Thu, 21 May 2020 17:44:09 +0800
Message-Id: <20200521094413.10425-59-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 05:19:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 wenmeng_zhang@c-sky.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/insn32.decode              |  2 +
 target/riscv/insn_trans/trans_rvv.inc.c | 54 +++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0741a25540..79f9b37b29 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -563,6 +563,8 @@ viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
+vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
+vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 27ae87e7b3..3fb559be0f 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2700,3 +2700,57 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
     }
     return false;
 }
+
+/* Floating-Point Scalar Move Instructions */
+static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
+{
+    if (!s->vill && has_ext(s, RVF) &&
+        (s->mstatus_fs != 0) && (s->sew != 0)) {
+        unsigned int ofs = (8 << s->sew);
+        unsigned int len = 64 - ofs;
+        TCGv_i64 t_nan;
+
+        vec_element_loadi(s, cpu_fpr[a->rd], a->rs2, 0);
+        /* NaN-box f[rd] as necessary for SEW */
+        if (len) {
+            t_nan = tcg_const_i64(UINT64_MAX);
+            tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
+                                t_nan, ofs, len);
+            tcg_temp_free_i64(t_nan);
+        }
+
+        mark_fs_dirty(s);
+        return true;
+    }
+    return false;
+}
+
+/* vfmv.s.f vd, rs1 # vd[0] = rs1 (vs2=0) */
+static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
+{
+    if (!s->vill && has_ext(s, RVF) && (s->sew != 0)) {
+        TCGv_i64 t1;
+        /* The instructions ignore LMUL and vector register group. */
+        uint32_t vlmax = s->vlen >> 3;
+
+        /* if vl == 0, skip vector register write back */
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+        /* zeroed all elements */
+        tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd), vlmax, vlmax, 0);
+
+        /* NaN-box f[rs1] as necessary for SEW */
+        t1 = tcg_temp_new_i64();
+        if (s->sew == MO_64 && !has_ext(s, RVD)) {
+            tcg_gen_ori_i64(t1, cpu_fpr[a->rs1], 0xffffffff00000000ULL);
+        } else {
+            tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+        }
+        vec_element_storei(s, a->rd, 0, t1);
+        tcg_temp_free_i64(t1);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
-- 
2.23.0


