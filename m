Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F83C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CB8208CA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnQyS2gW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CB8208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUe0-0002iB-VO
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53683)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlF-0003w4-F5
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlA-00033x-MP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbSl6-0002Af-Ej
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id d18so21500527wrs.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qQmS7fDlwcZP6vIBxbHDINfjc+89reFKqPWwOYK60Kw=;
 b=QnQyS2gW36bnd6wnT+pgY0HZvam4SnFDo8x+J+U42SyswUpYxC5kMsF21UMuvCCjj6
 YltiJgyuxWAOEI4oOA35JGtRo2UxTb7XWL3iazQgEpacyGkp1csmzew5cIPTHaQer+Na
 2r5X40QFKU9XqPu9E0WP5sOHJ4ZCgFgTIUGgsyoKh+emPMB2la2bC9roKu3hDRLOWz42
 CBUa1OE7r0A4jLGXByW5dlxnrm2iiQJ5NfWKgpG3AKVZLXKqjY1vEetKoH4x/wBPFNDd
 0uKaT4EQSKDCvMaRxsqUgTdwIpHk1osdZKVg5tgZEg5vmi7Nt33wgzmVr4OTG1fzRKPd
 i2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qQmS7fDlwcZP6vIBxbHDINfjc+89reFKqPWwOYK60Kw=;
 b=Lep0E6vldjO4Wm0c6Cr0L26bVqXV/xl8tPdx6L6C2YO7LhvWFYhMp1GlvSDGOANzYx
 tWrS5ohh/3BCglpMfxhbTcRPubSK5WPA+M1ZxW9P41QMUtfWHfPrwst4TIf/DS1k9ptN
 MuwHUHiHwB4AL0cQhYMJKG1CoCHJE737co+OXu0OHLv4VdiGJWzXdwrp0FBjv1hPg7rR
 XqK9ZABUxDmnnnJaPqe2U8JakaP/kZcK/D0nIEgqW7orUQ+a90jj5nJjxuXLtSVObLZL
 X3YrgHw9w0UBgSVwjw0Z53j1cbkNTqEZ4EsA2jhwWlyME73TzuQ6/TM0MBzAxCxCVXTv
 boNA==
X-Gm-Message-State: APjAAAWDuLVBbR4JXcUR+0cNbq0xEuH11MYM77K3rYXZsW0AyZ97PeB/
 oTnxtX94n52QulJu6dU5gjW5cg==
X-Google-Smtp-Source: APXvYqz6QwyNRKFwz4NtEUtYtS96gWZtYLjOPQBySR1Rr2Qn/QAPAemVdAN+WM2mX4I6GlkF6Uy3Vw==
X-Received: by 2002:adf:a509:: with SMTP id i9mr49822524wrb.269.1560443963612; 
 Thu, 13 Jun 2019 09:39:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f197sm358747wme.39.2019.06.13.09.39.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 09:39:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:39:09 +0100
Message-Id: <20190613163917.28589-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613163917.28589-1-peter.maydell@linaro.org>
References: <20190613163917.28589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 04/12] target/arm: Stop using cpu_F0s for
 NEON_2RM_VNEG_F
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch NEON_2RM_VABS_F away from using cpu_F0s.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a10fded1f39..a006ab498e7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1374,14 +1374,6 @@ static TCGv_ptr get_fpstatus_ptr(int neon)
     return statusptr;
 }
 
-static inline void gen_vfp_neg(int dp)
-{
-    if (dp)
-        gen_helper_vfp_negd(cpu_F0d, cpu_F0d);
-    else
-        gen_helper_vfp_negs(cpu_F0s, cpu_F0s);
-}
-
 #define VFP_GEN_ITOF(name) \
 static inline void gen_vfp_##name(int dp, int neon) \
 { \
@@ -4189,8 +4181,7 @@ static int neon_2rm_is_float_op(int op)
      * what we are asking here is "does the code for this case in
      * the Neon for-each-pass loop use cpu_F0s?".
      */
-    return (op == NEON_2RM_VNEG_F ||
-            (op >= NEON_2RM_VRINTN && op <= NEON_2RM_VRINTZ) ||
+    return ((op >= NEON_2RM_VRINTN && op <= NEON_2RM_VRINTZ) ||
             op == NEON_2RM_VRINTM ||
             (op >= NEON_2RM_VRINTP && op <= NEON_2RM_VCVTMS) ||
             op >= NEON_2RM_VRECPE_F);
@@ -6761,7 +6752,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             gen_helper_vfp_abss(tmp, tmp);
                             break;
                         case NEON_2RM_VNEG_F:
-                            gen_vfp_neg(0);
+                            gen_helper_vfp_negs(tmp, tmp);
                             break;
                         case NEON_2RM_VSWP:
                             tmp2 = neon_load_reg(rd, pass);
-- 
2.20.1


