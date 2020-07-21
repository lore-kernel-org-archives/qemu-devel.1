Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE7EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDE820792
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDE820792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsTv-0002D6-O3
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jxsTH-0001N7-T4; Tue, 21 Jul 2020 09:38:15 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jxsTE-00059G-Qn; Tue, 21 Jul 2020 09:38:15 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1212896|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.016521-4.43246e-05-0.983435; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01l10422; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.I5OAz9a_1595338677; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I5OAz9a_1595338677)
 by smtp.aliyun-inc.com(10.147.42.197);
 Tue, 21 Jul 2020 21:37:58 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 2/2] target/riscv: fix vector index load/store constraints
Date: Tue, 21 Jul 2020 21:37:42 +0800
Message-Id: <20200721133742.2298-2-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200721133742.2298-1-zhiwei_liu@c-sky.com>
References: <20200721133742.2298-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 09:37:59
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although not explicitly specified that the the destination
vector register groups cannot overlap the source vector register group,
it is still necessary.

And this constraint has been added to the v0.8 spec.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 7b4752b911..887c6b8883 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -513,13 +513,21 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
     return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
+/*
+ * For vector indexed segment loads, the destination vector register
+ * groups cannot overlap the source vector register group (specified by
+ * `vs2`), else an illegal instruction exception is raised.
+ */
 static bool ld_index_check(DisasContext *s, arg_rnfvm* a)
 {
     return (vext_check_isa_ill(s) &&
             vext_check_overlap_mask(s, a->rd, a->vm, false) &&
             vext_check_reg(s, a->rd, false) &&
             vext_check_reg(s, a->rs2, false) &&
-            vext_check_nf(s, a->nf));
+            vext_check_nf(s, a->nf) &&
+            ((a->nf == 1) ||
+             vext_check_overlap_group(a->rd, a->nf << s->lmul,
+                                      a->rs2, 1 << s->lmul)));
 }
 
 GEN_VEXT_TRANS(vlxb_v, 0, rnfvm, ld_index_op, ld_index_check)
-- 
2.23.0


