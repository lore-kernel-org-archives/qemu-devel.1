Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEB8C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294F72147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhvCEeiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294F72147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPCT-0005rR-Dg
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59017)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdL-00080U-9w
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdH-0004Kc-D9
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdF-00042O-A8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id v14so20515036wrr.4
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=i8xZRS9V37an5mkOlNCXHCAwIm1/t9dfCuxOwyhXLds=;
 b=WhvCEeiJ4qDz6f2XhTdPDI2rPJoTHYpB9dyq2Oh/x7IJ0U3QhYkcjKy0oPT8TLLkl2
 DrcOAc+tbhXYXG9minu1PjDp4furjVg9SGEH246qWjyZN8Z37XC9s/Czo6onn0hoU4Eb
 +KcqBBQgsK1i29/sEMYV+ICRoieIdUTpmjkk5ZKjzS4uKxJAinH74CO1VDSGy7zwInHU
 PxOCmeuZ9WQQcQl+C5WQYoBTiVEoa07uC7BN28h13ixSWLC83+pSldj23LnxILf6ye2l
 vDUQwqoR45xVuz3XKK2frk7uXltij66wRe2C7OKkeWzpNvkOiGw47Hp6HKFcFLcpIHRb
 gOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i8xZRS9V37an5mkOlNCXHCAwIm1/t9dfCuxOwyhXLds=;
 b=jpp+Klz9haFe9ofShXE5eqgINFM6pL0tW1sNjD42xQM3u7PlIjgUllK7bYaHMGAe/L
 K0cs+jT43f8MPNPH769YdxWU7KCzTndqWbuSrqydYnhrlzKBDk7oEpu8fhPdBvMV6cSt
 6pMeP7j4vaMpYygGaMKZAuQ5XWAaQCtbXJ/vcDFtpGM5Zbfgn7Wu1VIcIGLS+F/oZs8U
 oHBOBs0QAVRDuidSlxUYoZOa+QqwOJNDpiLxeCVXcT9TUpQh75ECCwcbM2uxEIqo9Kol
 1otKb1rSPPH2m6BC08gXFxJC+1R6R8eDmfeCftn6a8Bh2HChMkmtJ1NxKvuKfuudgK2b
 I5NA==
X-Gm-Message-State: APjAAAUfZh1JhaYLXkcXVyY1i460mLoXgWXllOOPIrTNMQ47hB8/2vQ1
 PFvzYX1BVQ47nCfIdVdxYUNCkGVKkT3y8A==
X-Google-Smtp-Source: APXvYqzpEKFe01zn/mPdO0Kr9yjyXW3x4edYVhL8X6YExI4dPxcAAizBR+29SkkEzl8mO8w1ac9rcQ==
X-Received: by 2002:adf:e301:: with SMTP id b1mr8052440wrj.304.1560428091209; 
 Thu, 13 Jun 2019 05:14:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:00 +0100
Message-Id: <20190613121433.5246-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 15/48] target/arm: Convert
 VCVTA/VCVTN/VCVTP/VCVTM to decodetree
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

Convert the VCVTA/VCVTN/VCVTP/VCVTM instructions to decodetree.
trans_VCVT() is temporarily left in translate.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 72 +++++++++++++++++-------------------
 target/arm/vfp-uncond.decode |  6 +++
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1da683820ab..d59fadc8fbe 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3340,12 +3340,31 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     return true;
 }
 
-static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
-                       int rounding)
+static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
 {
-    bool is_signed = extract32(insn, 7, 1);
-    TCGv_ptr fpst = get_fpstatus_ptr(0);
+    uint32_t rd, rm;
+    bool dp = a->dp;
+    TCGv_ptr fpst;
     TCGv_i32 tcg_rmode, tcg_shift;
+    int rounding = fp_decode_rm[a->rm];
+    bool is_signed = a->op;
+
+    if (!dc_isar_feature(aa32_vcvt_dr, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(0);
 
     tcg_shift = tcg_const_i32(0);
 
@@ -3355,10 +3374,6 @@ static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
     if (dp) {
         TCGv_i64 tcg_double, tcg_res;
         TCGv_i32 tcg_tmp;
-        /* Rd is encoded as a single precision register even when the source
-         * is double precision.
-         */
-        rd = ((rd << 1) & 0x1e) | ((rd >> 4) & 0x1);
         tcg_double = tcg_temp_new_i64();
         tcg_res = tcg_temp_new_i64();
         tcg_tmp = tcg_temp_new_i32();
@@ -3395,28 +3410,7 @@ static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
 
     tcg_temp_free_ptr(fpst);
 
-    return 0;
-}
-
-static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
-{
-    uint32_t rd, rm, dp = extract32(insn, 8, 1);
-
-    if (dp) {
-        VFP_DREG_D(rd, insn);
-        VFP_DREG_M(rm, insn);
-    } else {
-        rd = VFP_SREG_D(insn);
-        rm = VFP_SREG_M(insn);
-    }
-
-    if ((insn & 0x0fbc0e50) == 0x0ebc0a40 &&
-        dc_isar_feature(aa32_vcvt_dr, s)) {
-        /* VCVTA, VCVTN, VCVTP, VCVTM */
-        int rounding = fp_decode_rm[extract32(insn, 16, 2)];
-        return handle_vcvt(insn, rd, rm, dp, rounding);
-    }
-    return 1;
+    return true;
 }
 
 /*
@@ -3452,6 +3446,15 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
         }
     }
 
+    if (extract32(insn, 28, 4) == 0xf) {
+        /*
+         * Encodings with T=1 (Thumb) or unconditional (ARM): these
+         * were all handled by the decodetree decoder, so any insn
+         * patterns which get here must be UNDEF.
+         */
+        return 1;
+    }
+
     /*
      * FIXME: this access check should not take precedence over UNDEF
      * for invalid encodings; we will generate incorrect syndrome information
@@ -3468,15 +3471,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
         return 0;
     }
 
-    if (extract32(insn, 28, 4) == 0xf) {
-        /*
-         * Encodings with T=1 (Thumb) or unconditional (ARM):
-         * only used for the "miscellaneous VFP features" added in v8A
-         * and v7M (and gated on the MVFR2.FPMisc field).
-         */
-        return disas_vfp_misc_insn(s, insn);
-    }
-
     dp = ((insn & 0xf00) == 0xb00);
     switch ((insn >> 24) & 0xf) {
     case 0xe:
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 0aa83285de2..5af1f2ee664 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -55,3 +55,9 @@ VRINT       1111 1110 1.11 10 rm:2 .... 1010 01.0 .... \
             vm=%vm_sp vd=%vd_sp dp=0
 VRINT       1111 1110 1.11 10 rm:2 .... 1011 01.0 .... \
             vm=%vm_dp vd=%vd_dp dp=1
+
+# VCVT float to int with specified rounding mode; Vd is always single-precision
+VCVT        1111 1110 1.11 11 rm:2 .... 1010 op:1 1.0 .... \
+            vm=%vm_sp vd=%vd_sp dp=0
+VCVT        1111 1110 1.11 11 rm:2 .... 1011 op:1 1.0 .... \
+            vm=%vm_dp vd=%vd_sp dp=1
-- 
2.20.1


