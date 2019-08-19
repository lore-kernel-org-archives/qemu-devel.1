Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D92C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F5E205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsmkgQV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F5E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhIB-00071R-S2
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbG-000389-K2
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbE-0007ER-9S
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzgbE-00078B-1a
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id j16so8477483wrr.8
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k3UlDFsnQKhnBccuJpDIK9/bUicL4SPZmPjZKiFlMRI=;
 b=GsmkgQV9cB9i6VvsW3N6TAByakFsP5lq6ktrMwG8mEv8ZnSk8oIHGLhRF7txUwDuUL
 pN79IVGXIiPfaLrJi9+3ZjM57X6ib3uMCBjd5MjbUmlmlQGp4i79Ki8SVAavCNV2u5tl
 4FJYDUOGVnvH3QeRD6W7J8dP2wuitbLXEvFBN2kJJaEvqOSDzHkF3EL/1g2UK5HMwsCC
 yqn+PPUKSIyFR9Za79SIN/AmZzywTlJeh3dnTRMdE9lWQ7AqIkKuBVDrDLmc/+2o05XQ
 hBTjPH+jJW0x+rLGv5RFT8hqUqfjt4d5hfQ75aRs0JVA15gk/S18ACz0C8fWl37K3ESM
 vQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k3UlDFsnQKhnBccuJpDIK9/bUicL4SPZmPjZKiFlMRI=;
 b=KAx6QHWU2WN6EQInLUn1Z986RZl1gQVFkYPn/d8cmk7aVd9yam0I/rsEXwFam8H+Bv
 SqOr+6WYXrTZdFa2VC+W0+mwavaFkuCpkoIW+fXQrnJ3m0bt+Z/sV5Ik1HuM7XIgeAEV
 +uH9GciJMiEZX7eBC2/ru+gV+CaUUPbx3q6atKr2Tc9gA/7CcWEB/WzTiEl1aA4YMzEq
 m/Zfvgn7Oc84d0AHcpp4nZLo9zQGiP7n4C7zcFTXKnzOlxF82YMzvEmYR+4e/kOv2SOx
 gmm/Z8L8VH55fwwO34nkTkLmWEOQ1clumjELs7LBTVnZW/wlvBKm10l1ZIBEJPFZ56N4
 1K6Q==
X-Gm-Message-State: APjAAAWnNMBTmfMb463/JUDovDQ42q0VWqarsOuouFh2peJIEasHE45F
 uUAYPaFigLyfp74nufw8hN+si4MBo2E=
X-Google-Smtp-Source: APXvYqxzhAHYyWvQbDl2h1shN87Du3GS9odmK2Zf0OGGCy4VPQUxZuLNH070doak2fIM3lQ4YnBsHQ==
X-Received: by 2002:a5d:6392:: with SMTP id p18mr28364860wru.330.1566217033041; 
 Mon, 19 Aug 2019 05:17:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a19sm48058356wra.2.2019.08.19.05.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:17:11 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2DB101FF90;
 Mon, 19 Aug 2019 13:17:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 19 Aug 2019 13:17:00 +0100
Message-Id: <20190819121709.31597-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
References: <20190819121709.31597-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 03/12] fpu: use min/max values from stdint.h for
 integral overflow
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

Remove some more use of LIT64 while making the meaning more clear. We
also avoid the need of casts as the results by definition fit into the
return type.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 53855892b9f..d2cdf4a4a3b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3384,7 +3384,7 @@ static int32_t roundAndPackInt32(flag zSign, uint64_t absZ, float_status *status
     if ( zSign ) z = - z;
     if ( ( absZ>>32 ) || ( z && ( ( z < 0 ) ^ zSign ) ) ) {
         float_raise(float_flag_invalid, status);
-        return zSign ? (int32_t) 0x80000000 : 0x7FFFFFFF;
+        return zSign ? INT32_MIN : INT32_MAX;
     }
     if (roundBits) {
         status->float_exception_flags |= float_flag_inexact;
@@ -3444,9 +3444,7 @@ static int64_t roundAndPackInt64(flag zSign, uint64_t absZ0, uint64_t absZ1,
     if ( z && ( ( z < 0 ) ^ zSign ) ) {
  overflow:
         float_raise(float_flag_invalid, status);
-        return
-              zSign ? (int64_t) LIT64( 0x8000000000000000 )
-            : LIT64( 0x7FFFFFFFFFFFFFFF );
+        return zSign ? INT64_MIN : INT64_MAX;
     }
     if (absZ1) {
         status->float_exception_flags |= float_flag_inexact;
@@ -3497,7 +3495,7 @@ static int64_t roundAndPackUint64(flag zSign, uint64_t absZ0,
         ++absZ0;
         if (absZ0 == 0) {
             float_raise(float_flag_invalid, status);
-            return LIT64(0xFFFFFFFFFFFFFFFF);
+            return UINT64_MAX;
         }
         absZ0 &= ~(((uint64_t)(absZ1<<1) == 0) & roundNearestEven);
     }
@@ -5518,9 +5516,9 @@ int64_t floatx80_to_int64(floatx80 a, float_status *status)
         if ( shiftCount ) {
             float_raise(float_flag_invalid, status);
             if (!aSign || floatx80_is_any_nan(a)) {
-                return LIT64( 0x7FFFFFFFFFFFFFFF );
+                return INT64_MAX;
             }
-            return (int64_t) LIT64( 0x8000000000000000 );
+            return INT64_MIN;
         }
         aSigExtra = 0;
     }
@@ -5561,10 +5559,10 @@ int64_t floatx80_to_int64_round_to_zero(floatx80 a, float_status *status)
         if ( ( a.high != 0xC03E ) || aSig ) {
             float_raise(float_flag_invalid, status);
             if ( ! aSign || ( ( aExp == 0x7FFF ) && aSig ) ) {
-                return LIT64( 0x7FFFFFFFFFFFFFFF );
+                return INT64_MAX;
             }
         }
-        return (int64_t) LIT64( 0x8000000000000000 );
+        return INT64_MIN;
     }
     else if ( aExp < 0x3FFF ) {
         if (aExp | aSig) {
@@ -6623,7 +6621,7 @@ int32_t float128_to_int32_round_to_zero(float128 a, float_status *status)
     if ( ( z < 0 ) ^ aSign ) {
  invalid:
         float_raise(float_flag_invalid, status);
-        return aSign ? (int32_t) 0x80000000 : 0x7FFFFFFF;
+        return aSign ? INT32_MIN : INT32_MAX;
     }
     if ( ( aSig0<<shiftCount ) != savedASig ) {
         status->float_exception_flags |= float_flag_inexact;
@@ -6662,9 +6660,9 @@ int64_t float128_to_int64(float128 a, float_status *status)
                       && ( aSig1 || ( aSig0 != LIT64( 0x0001000000000000 ) ) )
                     )
                ) {
-                return LIT64( 0x7FFFFFFFFFFFFFFF );
+                return INT64_MAX;
             }
-            return (int64_t) LIT64( 0x8000000000000000 );
+            return INT64_MIN;
         }
         shortShift128Left( aSig0, aSig1, - shiftCount, &aSig0, &aSig1 );
     }
@@ -6710,10 +6708,10 @@ int64_t float128_to_int64_round_to_zero(float128 a, float_status *status)
             else {
                 float_raise(float_flag_invalid, status);
                 if ( ! aSign || ( ( aExp == 0x7FFF ) && ( aSig0 | aSig1 ) ) ) {
-                    return LIT64( 0x7FFFFFFFFFFFFFFF );
+                    return INT64_MAX;
                 }
             }
-            return (int64_t) LIT64( 0x8000000000000000 );
+            return INT64_MIN;
         }
         z = ( aSig0<<shiftCount ) | ( aSig1>>( ( - shiftCount ) & 63 ) );
         if ( (uint64_t) ( aSig1<<shiftCount ) ) {
@@ -6764,19 +6762,19 @@ uint64_t float128_to_uint64(float128 a, float_status *status)
     if (aSign && (aExp > 0x3FFE)) {
         float_raise(float_flag_invalid, status);
         if (float128_is_any_nan(a)) {
-            return LIT64(0xFFFFFFFFFFFFFFFF);
+            return UINT64_MAX;
         } else {
             return 0;
         }
     }
     if (aExp) {
-        aSig0 |= LIT64(0x0001000000000000);
+        aSig0 |= UINT64_C(0x0001000000000000);
     }
     shiftCount = 0x402F - aExp;
     if (shiftCount <= 0) {
         if (0x403E < aExp) {
             float_raise(float_flag_invalid, status);
-            return LIT64(0xFFFFFFFFFFFFFFFF);
+            return UINT64_MAX;
         }
         shortShift128Left(aSig0, aSig1, -shiftCount, &aSig0, &aSig1);
     } else {
-- 
2.20.1


