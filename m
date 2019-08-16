Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED16AC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B921A2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uk7bgu0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B921A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycQX-0001UT-JK
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc76-0003b2-5T
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc74-0005oB-Ry
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc74-0005nP-Li
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id m125so4047500wmm.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iXcER1QiX/gthDXehyMfmgB8egDz7zaG/jAt+aS6K7o=;
 b=uk7bgu0rYAEQIy4sYZAD1TRsD/NdEmm5gTIMpBV3JGHCKi/BDybAHO07rASq1aDoW2
 hov769BM/YIOQ0J4av11ViS+6L04CtFZXJ6LaHL7ul8dMhrkfTXBXtBvENUrBzSfpLzH
 dG3sAQMvFC2l6hkCc4I0f6yvBruJl+lMpQZARZNO2A/14UzeuKOwr7EgYvTJDfzxHGn9
 fVObpd2HBuAW8dNP4+6BxtNpMGPc4YLzfqh33TwXqsdACGTJZHAzznecYSsNpWatmi30
 KFY6IMkveet8gfbK2siVkh73vnLvx2XRmrbgMUey0hzFOMkrcMXZy6Gk9l/O3pZKsD02
 jbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iXcER1QiX/gthDXehyMfmgB8egDz7zaG/jAt+aS6K7o=;
 b=lLf8d1shMhk3k1zUFKANPMNtW4FkPrZgrw0iPAWSPed2LE5NM2/KIb9/kSYVj12Kua
 lLIBn3/RGKXHKKofdfTnCoLLiERMec7qqxpeaCrqrEJCeZzQqV9ZcvskiSbWycHy/LGD
 Y09gxHSwws6Y88MlvqW6I++ZASOBLtKDJOKulcCCc3pabOBOVlvPfvizUzU3sOLW8MpX
 yIDI1OfF8aa8hPq2kz0TycVSp2p0rjfii17vrSQM19jdRFusL4id1BDum978VL6IyPyM
 5sFkVvINfyFkWmdpOYfHLYfTSgMhr0qpS3JZqytBdbywvQOeTwctvGcBzqWgg4iN/d3b
 MgUw==
X-Gm-Message-State: APjAAAWt/5oEr++H8HR6KSYyE32Uw7Kx7Vv3rik8UAh3876v2Ky+CXM3
 xFqgW64NCDfxIMSIPDu5iJfgScVQYVJe+w==
X-Google-Smtp-Source: APXvYqz5XQeNIMKbwIr44vq58RZ99TEO1t414G77y4Ftp5VFM+WDdaTXpU+r+4PQQF6wD9AacDMpBA==
X-Received: by 2002:a05:600c:144:: with SMTP id
 w4mr7825583wmm.94.1565961469493; 
 Fri, 16 Aug 2019 06:17:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:15 +0100
Message-Id: <20190816131719.28244-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 25/29] target/arm: Remove redundant shift tests
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The immediate shift generator functions already test for,
and eliminate, the case of a shift by zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190808202616.13782-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9c3323509e1..ebc7c67f025 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8811,8 +8811,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         shift = (insn >> 10) & 3;
                         /* ??? In many cases it's not necessary to do a
                            rotate, a shift is sufficient.  */
-                        if (shift != 0)
-                            tcg_gen_rotri_i32(tmp, tmp, shift * 8);
+                        tcg_gen_rotri_i32(tmp, tmp, shift * 8);
                         op1 = (insn >> 20) & 7;
                         switch (op1) {
                         case 0: gen_sxtb16(tmp);  break;
@@ -9889,8 +9888,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             shift = (insn >> 4) & 3;
             /* ??? In many cases it's not necessary to do a
                rotate, a shift is sufficient.  */
-            if (shift != 0)
-                tcg_gen_rotri_i32(tmp, tmp, shift * 8);
+            tcg_gen_rotri_i32(tmp, tmp, shift * 8);
             op = (insn >> 20) & 7;
             switch (op) {
             case 0: gen_sxth(tmp);   break;
@@ -10617,11 +10615,10 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     case 7:
                         goto illegal_op;
                     default: /* Saturate.  */
-                        if (shift) {
-                            if (op & 1)
-                                tcg_gen_sari_i32(tmp, tmp, shift);
-                            else
-                                tcg_gen_shli_i32(tmp, tmp, shift);
+                        if (op & 1) {
+                            tcg_gen_sari_i32(tmp, tmp, shift);
+                        } else {
+                            tcg_gen_shli_i32(tmp, tmp, shift);
                         }
                         tmp2 = tcg_const_i32(imm);
                         if (op & 4) {
@@ -10812,9 +10809,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     goto illegal_op;
                 }
                 tmp = load_reg(s, rm);
-                if (shift) {
-                    tcg_gen_shli_i32(tmp, tmp, shift);
-                }
+                tcg_gen_shli_i32(tmp, tmp, shift);
                 tcg_gen_add_i32(addr, addr, tmp);
                 tcg_temp_free_i32(tmp);
                 break;
-- 
2.20.1


