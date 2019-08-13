Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC25BC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748E0206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0xDx/S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748E0206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWIG-00080F-Oy
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFM-0002Gt-Vb
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFL-0000fe-Ni
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxWFL-0000eT-H7
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id 207so1397940wma.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PJTLOGYfOYJRlE+NNvZ7x6ubINqPg6f5ZRf9gomrPy8=;
 b=e0xDx/S+M8brLECdnB1pGQzGyowZzrKXfBiHHQMR/euElwOc3rAXwocxnoOf2MtGIl
 P/IXiYqyB7ou1CcgYtIVPfLof/BwfxnTWZBdIW/PpHiPe4o5VclQtpaPwqSval3dIDX7
 7VW7AzIX7pU+H9hgFVKOwHX6MGegdk7nxHW2CNImzwfCs7MZ5SbQv7UlTR3VL+qQqcJZ
 qp2+g+tVcyywKYnHYCd5zym6T1sjA+uPwuN0Z9YGmA/r5Iy9QKJNEIaLvbmo/yQbcGY/
 DwetfURFOs0Cw74owqWVRb3SgJvvh0dolNwYiwjBBmHU16+XihbApxxrNf/QTJ7A5EIE
 XXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PJTLOGYfOYJRlE+NNvZ7x6ubINqPg6f5ZRf9gomrPy8=;
 b=URV47GowgMJfAml0QI1n5CmhJ+k03W8BumsyxaCLXwIqGUT/gZumdj1RV/HlZS0qxS
 PLjfyTWqTaqUrYMIFB21ZM0AxfCPlGfWGRMVytATxAsHvDXFQe2d2KQ2XFWy8T1JG5DN
 4WHVkmk2huurD2LQ+FHVtytJzmITGl04WaheO1cTQe2J3PmtJFx1gLSQISDIxAnERMZq
 oyynQJvJYYvaP0B/SXAkc0Xo9Ouj1/A+066R0W1631xfAC3qkv4YLO3qWWO6r1UzDS2Y
 lfGdzC+yajBl4aW52IZTOeW0Z+9G6nczgH4nYHw5IYobdN+gar0iu44XAcAKddoG659R
 mEpQ==
X-Gm-Message-State: APjAAAVsGD84sLtRsBHsB1+NydVmFVX1VJueZttUI0kK7dTJGBsl5w8/
 DtnEaymZ5R8qCaoC4GrMxAk5yw==
X-Google-Smtp-Source: APXvYqw6t3Ci5VubDx2993pPUOgES3uKBlsnW5r44hT64j2wxxD8dWth5ADtGPzS2nMRPvY4Mt1XRw==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr2969690wmk.97.1565700590465; 
 Tue, 13 Aug 2019 05:49:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id i66sm1256285wmg.2.2019.08.13.05.49.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:49:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 427931FF91;
 Tue, 13 Aug 2019 13:49:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:49:37 +0100
Message-Id: <20190813124946.25322-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813124946.25322-1-alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v3 04/13] fpu: use min/max values from stdint.h
 for integral overflow
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove some more use of LIT64 while making the meaning more clear. We
also avoid the need of casts as the results by definition fit into the
return type.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9e57b7b5933..a1e1e9a8559 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
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


