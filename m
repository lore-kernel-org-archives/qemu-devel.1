Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEA7C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83852086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dphg+eyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83852086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhFO-0003aF-KF
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbG-00038D-JB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbE-0007EB-2f
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzgb6-00077J-L7
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:19 -0400
Received: by mail-wr1-x42a.google.com with SMTP id c3so8493872wrd.7
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x7wHfawCjsVF1Gi5t5yCk6URAAid1imk9lHZgcaTxXU=;
 b=Dphg+eyp48GJg2nJCUQ4FgjBFs4pMDSr2w9yKHXJIyfMhDyJSSbXFtRbx9MXxAvsPf
 alVSPsdTPcmJghhKl8/bFjBNS3j0SxZOUyIhfrQQ3Ud+MiehFTZorQDTdlzuZY3ETZiA
 Zp8KzLqrlROQR4ETFcJ1pxeumRQJdrUneckg+RMDtV4V9hbB90CTQcvimn2/HUk5itxR
 MCy8iQ11all9dwtcDmCNdwJbfr20HKh2hHRckl95Sx3Z1XXXyTlTmXPq7SOiyeJxpZt/
 uQV3nfXjVcNqOZcjww5EDZPmAcW+BrDGHQXGcDA4YHIm9mLyddLsoJ7XqrcMnu7f6hsw
 0dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x7wHfawCjsVF1Gi5t5yCk6URAAid1imk9lHZgcaTxXU=;
 b=nRmbj1afP03A9xSgLaGk44AzqEhzWFEJ33qY3DyGoD+4NJvBLldj39BCVvVsFSAp8W
 JkgxMtHuGrPLV/Vi9GWIhBrNUrI7iBHR+rerUAGQ+deAs/9y/Rv7IVuCUPzeSTNSdnat
 V6hcul/srGdEfiUsQLrQ8herD0fPG+C3fMH9aUgAkStPb2LX3kMRufpcNgmxoHm1VUQD
 IcOVvatS81NJfAsWuZWI6TbwDCQQ3MKQMHSBHZYG4BOKXr5FgJviYLTeb4fDVK4NQrd3
 nrMo3YptKwlP3JIfJk74zIHcQsi8OrsBg6eQwnthYejvPjogIufKTuolsNbILNlUFcHA
 eafQ==
X-Gm-Message-State: APjAAAWcAauhbxEVCXOKQNCz3LlKir60/+XznSemXZw/aC2WW/IysAc1
 pH4suSBaXPvUIy0G/5bIUJHQ2w==
X-Google-Smtp-Source: APXvYqzpfnrMhOgqdbe7R0i8isZG9xWbPG4QKjznQ7/aHiKFZwKnYm6ph0xuoJy35LPMYtePO9CqKg==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr28155918wrs.88.1566217031406; 
 Mon, 19 Aug 2019 05:17:11 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h9sm12348347wrt.53.2019.08.19.05.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:17:10 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 04EE31FF8C;
 Mon, 19 Aug 2019 13:17:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 19 Aug 2019 13:16:58 +0100
Message-Id: <20190819121709.31597-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
References: <20190819121709.31597-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 01/12] fpu: replace LIT64 usage with UINT64_C
 for specialize constants
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a wrapper that does the right thing from stdint.h so lets use
it for our constants in softfloat-specialize.h

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 7b8895726c5..5ab2fa19415 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -196,11 +196,11 @@ floatx80 floatx80_default_nan(float_status *status)
     /* None of the targets that have snan_bit_is_one use floatx80.  */
     assert(!snan_bit_is_one(status));
 #if defined(TARGET_M68K)
-    r.low = LIT64(0xFFFFFFFFFFFFFFFF);
+    r.low = UINT64_C(0xFFFFFFFFFFFFFFFF);
     r.high = 0x7FFF;
 #else
     /* X86 */
-    r.low = LIT64(0xC000000000000000);
+    r.low = UINT64_C(0xC000000000000000);
     r.high = 0xFFFF;
 #endif
     return r;
@@ -212,9 +212,9 @@ floatx80 floatx80_default_nan(float_status *status)
 
 #define floatx80_infinity_high 0x7FFF
 #if defined(TARGET_M68K)
-#define floatx80_infinity_low  LIT64(0x0000000000000000)
+#define floatx80_infinity_low  UINT64_C(0x0000000000000000)
 #else
-#define floatx80_infinity_low  LIT64(0x8000000000000000)
+#define floatx80_infinity_low  UINT64_C(0x8000000000000000)
 #endif
 
 const floatx80 floatx80_infinity
@@ -667,7 +667,7 @@ int float64_is_signaling_nan(float64 a_, float_status *status)
         return ((a << 1) >= 0xFFF0000000000000ULL);
     } else {
         return (((a >> 51) & 0xFFF) == 0xFFE)
-            && (a & LIT64(0x0007FFFFFFFFFFFF));
+            && (a & UINT64_C(0x0007FFFFFFFFFFFF));
     }
 #endif
 }
@@ -707,7 +707,7 @@ static float64 commonNaNToFloat64(commonNaNT a, float_status *status)
     if (mantissa) {
         return make_float64(
               (((uint64_t) a.sign) << 63)
-            | LIT64(0x7FF0000000000000)
+            | UINT64_C(0x7FF0000000000000)
             | (a.high >> 12));
     } else {
         return float64_default_nan(status);
@@ -790,7 +790,7 @@ int floatx80_is_quiet_nan(floatx80 a, float_status *status)
             && (a.low == aLow);
     } else {
         return ((a.high & 0x7FFF) == 0x7FFF)
-            && (LIT64(0x8000000000000000) <= ((uint64_t)(a.low << 1)));
+            && (UINT64_C(0x8000000000000000) <= ((uint64_t)(a.low << 1)));
     }
 #endif
 }
@@ -812,7 +812,7 @@ int floatx80_is_signaling_nan(floatx80 a, float_status *status)
     } else {
         uint64_t aLow;
 
-        aLow = a.low & ~LIT64(0x4000000000000000);
+        aLow = a.low & ~UINT64_C(0x4000000000000000);
         return ((a.high & 0x7FFF) == 0x7FFF)
             && (uint64_t)(aLow << 1)
             && (a.low == aLow);
@@ -829,7 +829,7 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 {
     /* None of the targets that have snan_bit_is_one use floatx80.  */
     assert(!snan_bit_is_one(status));
-    a.low |= LIT64(0xC000000000000000);
+    a.low |= UINT64_C(0xC000000000000000);
     return a;
 }
 
@@ -874,7 +874,7 @@ static floatx80 commonNaNToFloatx80(commonNaNT a, float_status *status)
     }
 
     if (a.high >> 1) {
-        z.low = LIT64(0x8000000000000000) | a.high >> 1;
+        z.low = UINT64_C(0x8000000000000000) | a.high >> 1;
         z.high = (((uint16_t)a.sign) << 15) | 0x7FFF;
     } else {
         z = floatx80_default_nan(status);
@@ -969,7 +969,7 @@ int float128_is_signaling_nan(float128 a, float_status *status)
             && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
     } else {
         return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
-            && (a.low || (a.high & LIT64(0x00007FFFFFFFFFFF)));
+            && (a.low || (a.high & UINT64_C(0x00007FFFFFFFFFFF)));
     }
 #endif
 }
@@ -987,7 +987,7 @@ float128 float128_silence_nan(float128 a, float_status *status)
     if (snan_bit_is_one(status)) {
         return float128_default_nan(status);
     } else {
-        a.high |= LIT64(0x0000800000000000);
+        a.high |= UINT64_C(0x0000800000000000);
         return a;
     }
 #endif
@@ -1025,7 +1025,7 @@ static float128 commonNaNToFloat128(commonNaNT a, float_status *status)
     }
 
     shift128Right(a.high, a.low, 16, &z.high, &z.low);
-    z.high |= (((uint64_t)a.sign) << 63) | LIT64(0x7FFF000000000000);
+    z.high |= (((uint64_t)a.sign) << 63) | UINT64_C(0x7FFF000000000000);
     return z;
 }
 
-- 
2.20.1


