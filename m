Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E028AC43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B9D208C3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B9D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45802 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf5yP-0003Oj-Ts
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 13:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hf5wM-0001dB-Q2
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hf5wL-0004Iu-GF
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:06 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41125 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hf5wL-0004H9-4A
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:05 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 779C61A1DC5;
 Sun, 23 Jun 2019 19:05:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4DA051A1DB6;
 Sun, 23 Jun 2019 19:05:45 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sun, 23 Jun 2019 19:04:41 +0200
Message-Id: <1561309489-16146-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v5 08/16] tcg/ppc: Add support for vector
 saturated add/subtract
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
Cc: richard.henderson@linaro.org,
 "David Gibson --cc=amarkovic @ wavecomp . com"
 <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Add support for vector saturated add/subtract using Altivec
instructions:
VADDSBS, VADDSHS, VADDSWS, VADDUBS, VADDUHS, VADDUWS, and
VSUBSBS, VSUBSHS, VSUBSWS, VSUBUBS, VSUBUHS, VSUBUWS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.inc.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index a86ed57..368c250 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -155,7 +155,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index e254fa4..108882f 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -474,12 +474,24 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 
+#define VADDSBS    VX4(768)
+#define VADDUBS    VX4(512)
 #define VADDUBM    VX4(0)
+#define VADDSHS    VX4(832)
+#define VADDUHS    VX4(576)
 #define VADDUHM    VX4(64)
+#define VADDSWS    VX4(896)
+#define VADDUWS    VX4(640)
 #define VADDUWM    VX4(128)
 
+#define VSUBSBS    VX4(1792)
+#define VSUBUBS    VX4(1536)
 #define VSUBUBM    VX4(1024)
+#define VSUBSHS    VX4(1856)
+#define VSUBUHS    VX4(1600)
 #define VSUBUHM    VX4(1088)
+#define VSUBSWS    VX4(1920)
+#define VSUBUWS    VX4(1664)
 #define VSUBUWM    VX4(1152)
 
 #define VMAXSB     VX4(258)
@@ -2845,6 +2857,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
         return vece <= MO_32;
     case INDEX_op_cmp_vec:
         return vece <= MO_32 ? -1 : 0;
@@ -2947,6 +2963,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, 0 },
         gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, 0 },
         gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, 0 },
+        ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
+        usadd_op[4] = { VADDUBS, VADDUHS, VADDUWS, 0 },
+        sssub_op[4] = { VSUBSBS, VSUBSHS, VSUBSWS, 0 },
+        ussub_op[4] = { VSUBUBS, VSUBUHS, VSUBUWS, 0 },
         umin_op[4] = { VMINUB, VMINUH, VMINUW, 0 },
         smin_op[4] = { VMINSB, VMINSH, VMINSW, 0 },
         umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, 0 },
@@ -2973,6 +2993,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sub_vec:
         insn = sub_op[vece];
         break;
+    case INDEX_op_ssadd_vec:
+        insn = ssadd_op[vece];
+        break;
+    case INDEX_op_sssub_vec:
+        insn = sssub_op[vece];
+        break;
+    case INDEX_op_usadd_vec:
+        insn = usadd_op[vece];
+        break;
+    case INDEX_op_ussub_vec:
+        insn = ussub_op[vece];
+        break;
     case INDEX_op_smin_vec:
         insn = smin_op[vece];
         break;
@@ -3279,6 +3311,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_andc_vec:
     case INDEX_op_orc_vec:
     case INDEX_op_cmp_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
-- 
2.7.4


