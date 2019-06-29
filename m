Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971B7C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A1C2054F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNRgU9kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A1C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhDAk-0000g1-2j
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41295)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCyC-0007zT-3A
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy9-0003dn-Hg
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:39161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy8-0003Op-Rq
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id z23so11466177wma.4
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8c+pO+UN4brThvyUe6Pa/t2F5ed6fJQI77MaYEGpRZ0=;
 b=CNRgU9kre/OTimApBJc2zVIIlNSi8ukrwVVb2EgYgBXzaLG+039FmWDei7J60SrAmG
 X9XsAaS6uBdS1hRGKgZAUjfqhecyaYt6rIR5sOcJwyuGc5/k6yKsKP15ev5iboJC4d4h
 oHByA3zyDISlOCPHmEXtueNbl1ggV380DS4UhnvwakB9jjSk0ciIxwi/iqusbhmAKkmI
 OllpPfJID0cswW/Rk99eP9PS5alYauUhmft5+uSSYeYZDKHJijB7sf1vSPYo81NLnZTq
 ob+uKnIMBgDpnBB/uXPWVtubRDNlDHMYJRzqVSs5wdbbTo03t7ORyMLwEysuUblmAU95
 oddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8c+pO+UN4brThvyUe6Pa/t2F5ed6fJQI77MaYEGpRZ0=;
 b=izDOlkLSvw7a2Lno+isEDZxTPEV83QIrK/R17njzlHz3Io+bmVLRzvqgOtdqqWEF97
 H39qcq2duht6nnZjR8l7guzDJhc7prZjylIHxCvPGOoGudesfExhw4eGAzZcAFhMsLCh
 BDPYhGljhT1Ym2R5IKFDxIetIq4ze8dAjHDqpyFylVYvdSlo5SwUocJgzcG7+AF/g8j6
 v07zvT7FfiLptBSC6e9/7uq5zD7XrIFIecPYd+S4A57Ltg6R6G0rAqxU19d5GwMKRKbp
 tT1Qu565Fp80E1t2H3YWnFJwPh18//450Dhj3qyAC0z1JWloqxlnv3ulQkZ+Myv61NUE
 XBlA==
X-Gm-Message-State: APjAAAUOT4xn+8papelqLd440L5X0Qq6BhtrOIrF7YX/DAgJKj7VEesK
 JChxD/oUd2mvbtEn1GNKNYCGTRltosw/Yg==
X-Google-Smtp-Source: APXvYqybNxaQxgNh2d6mSx3wI+Uq9Xj5N9CtTfttpCP6PFWw6iUU/63FFpw6n3M1Zjy4uwotLSaY6w==
X-Received: by 2002:a1c:5602:: with SMTP id k2mr9114349wmb.173.1561813226233; 
 Sat, 29 Jun 2019 06:00:26 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:08 +0200
Message-Id: <20190629130017.2973-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PATCH v6 07/16] tcg/ppc: Add support for vector
 add/subtract
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

Add support for vector add/subtract using Altivec instructions:
VADDUBM, VADDUHM, VADDUWM, VSUBUBM, VSUBUHM, VSUBUWM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.inc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 9c5630dc8a..c31694cc78 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -474,6 +474,14 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 
+#define VADDUBM    VX4(0)
+#define VADDUHM    VX4(64)
+#define VADDUWM    VX4(128)
+
+#define VSUBUBM    VX4(1024)
+#define VSUBUHM    VX4(1088)
+#define VSUBUWM    VX4(1152)
+
 #define VMAXSB     VX4(258)
 #define VMAXSH     VX4(322)
 #define VMAXSW     VX4(386)
@@ -2833,6 +2841,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_andc_vec:
     case INDEX_op_not_vec:
         return 1;
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
@@ -2933,6 +2943,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            const TCGArg *args, const int *const_args)
 {
     static const uint32_t
+        add_op[4] = { VADDUBM, VADDUHM, VADDUWM, 0 },
+        sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, 0 },
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, 0 },
         gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, 0 },
         gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, 0 },
@@ -2956,6 +2968,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         return;
 
+    case INDEX_op_add_vec:
+        insn = add_op[vece];
+        break;
+    case INDEX_op_sub_vec:
+        insn = sub_op[vece];
+        break;
     case INDEX_op_smin_vec:
         insn = smin_op[vece];
         break;
@@ -3254,6 +3272,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return (TCG_TARGET_REG_BITS == 64 ? &S_S
                 : TARGET_LONG_BITS == 32 ? &S_S_S : &S_S_S_S);
 
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
-- 
2.17.1


