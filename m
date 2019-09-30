Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D53C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFBC224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOIK62qK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFBC224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2OP-0000Uk-MA
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Ay-0004gs-96
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Aw-0005dB-Ls
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:39826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2Aw-0005bS-Es
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id v4so6228740pff.6
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sTJW6UTbb1j2FRe7m1NuaoxYc6z6Y7/0xQA7i53LXsg=;
 b=aOIK62qK9c1M/UcPsUhTjYsCx5SYE+x0szwbGvFfj5EZUHkAAz0HvXO44qXEabSNQ8
 Em5sYdQDoscnsp0Fp9XOFh62tEuwGYJH5w6B/5q2L8T/T9K+azWVPVnV/n20b+G8EJZK
 jR2YlMvGWLhUL0mu83UOIsR1a4vVMkGiMzK/QfDQnIrSDwCtKQq/4yaLj0jEXIuCKLKB
 CoiC81z1CbSQWhANrpar0xxKLGaDRhAX/w+VMldDFmr4+40R0XRbfhYnxAcA2ZZ4RGcJ
 WgKi5hcx0lXRJomLh/uJ+65D7/NjpeogPx0zcr8hoSlkzUeBbR09e3dYOncqvKBqx2uS
 gJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sTJW6UTbb1j2FRe7m1NuaoxYc6z6Y7/0xQA7i53LXsg=;
 b=PvxrIwvI5LqnsqD9RZzN0A6vQY5I/VCGCSSNgWvVcj9+7TCbFnYlZCxhW/wbjffgvJ
 iMmxGGgTwpWi5d2EQRqyI3itxzgPHVqDibWN8AM8S20BBIBsAxSH2D/+e6Yi4OafebJT
 cgHAU1YUR4DvNNqQt77TpEp7VAGhAC2F95kROPP8pKFc2+o47/+TbCWVAD7njANjrgYs
 5R8m4pRGSjlfFdsc5Eq4sdSuRWZzQfnLo7Z7gMtSQH/OyEYO36xtHWZdAbvK1VKi4Rbq
 p4flRXhFBJVbfwsD3Sls6NZxVai1jq9dhIv3GKNYHjY3JynH83HZyk73kX1kui/kzkTT
 +qBw==
X-Gm-Message-State: APjAAAUAa7rrHBiqPLLO6z1fDowY6tqYaTLQcRmXcZ4KnMA/0AELei8z
 mO7N9nqti7EsuTqKjar7OWNdWZtSDZQ=
X-Google-Smtp-Source: APXvYqw6rY5S1kW2J1YHkSQgnjmsSWQl9G2v/BqZtX2ywB9YDIU4s6tRsAsRiLAJcG2IxX9tfUioFw==
X-Received: by 2002:a17:90a:ad48:: with SMTP id
 w8mr1170947pjv.43.1569874901125; 
 Mon, 30 Sep 2019 13:21:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 11/22] tcg/ppc: Add support for vector saturated
 add/subtract
Date: Mon, 30 Sep 2019 13:21:14 -0700
Message-Id: <20190930202125.21064-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index 13699f1b63..3ebbbfa77e 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -163,7 +163,7 @@ extern bool have_altivec;
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 6cfc78bb59..a1165209fc 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -471,12 +471,24 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
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
@@ -2844,6 +2856,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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
@@ -2945,6 +2961,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -2971,6 +2991,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -3277,6 +3309,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
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
2.17.1


