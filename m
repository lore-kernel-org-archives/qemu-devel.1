Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AE8C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6C1205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="huyQllCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6C1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhEw-0003H2-Cr
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbE-00035w-7a
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgb9-0007BG-2z
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzgb3-00077e-JW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id 207so1423556wma.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KQdL/kzloDkSCwfovYEItXwL5tG8XpJZAfsOWmPlIqs=;
 b=huyQllCK751vn1d9MUUcuVOZmX/RXhnuqwPN7Tkw/QVBU2fJZz5zygYwOwP0vG/Ohq
 +ZpxAloWADLeVNKctYuT3vmKXn3NkkphTkjRxfmSO+E/RnymLBv/RxptJfoM5w3kZQ0q
 x5Z0y2EqIFRQQJ/opWzabxz8ceYizz8ohdfrjeazB2xl0jAMBK8YNvTspmhRYJyPiXwg
 grTsKKF+soPh9bjOEzqOCSsNuTKDNjUzemPx6wpGK3oLqC0alCsDpENqaOJ1E3eygug6
 qJ80/3canLdXQvacXroSyhi+PqsnhdkaPWz5ld4epKYP88GlaSewlHVIY12z4K0KY8XZ
 pALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KQdL/kzloDkSCwfovYEItXwL5tG8XpJZAfsOWmPlIqs=;
 b=EuZ5WiqeeVtUSdHq/IX5lml1yk7ZrVm5Cwe/OBFtg2mDdDy+QXYdJGWnhhnikK0rcB
 vMmD17t4hSqqoMy4X83oDEswQpQMeCdTfPvAAtNwzY17Gv0S1qU5CgHLFtId81p5Klz3
 MeuWZWH5kBLsix50TRubRlwwpVqM9st1Z3Ld/fW90dK3IcusS6JbFCHkKH6G96bdg6QY
 JW2bgfCOZOIBXx6M1KbOIJWCc9thTXLbnDsnPV8lIYDjorPaj6lwBusrPQHVIG0A+AaW
 LRn6oTMw7NuEiIr9M3kFcLIhT3F4gxNhPzQZAtSzklm5X9XtmvE04pa8h/dRZVJyFt5E
 6dpw==
X-Gm-Message-State: APjAAAVRO3n74VzR4On68pK2lFw8Ib5HbCf+KdYLbFTq04x+T2KOMkQi
 5SoxjGnpc0jAiXz7Gx6QWpk15w==
X-Google-Smtp-Source: APXvYqzjpxAyI6qvJKKlhyvhZgTOwQ+RovwXjdrSmxnjR7t7dooIPoiFpuEunv+gUuLfs7YiAga+FQ==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr20301895wma.53.1566217032229; 
 Mon, 19 Aug 2019 05:17:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d16sm21409001wrj.47.2019.08.19.05.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:17:10 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 192471FF8F;
 Mon, 19 Aug 2019 13:17:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 19 Aug 2019 13:16:59 +0100
Message-Id: <20190819121709.31597-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
References: <20190819121709.31597-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 02/12] fpu: convert
 float[16/32/64]_squash_denormal to new modern style
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This also allows us to remove the extractFloat16exp/frac helpers. We
avoid using the floatXX_pack_raw functions as they are slight overkill
for masking out all but the top bit of the number. The generated code
is almost exactly the same as makes no difference to the
pre-conversion code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2ba36ec3703..53855892b9f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -414,24 +414,6 @@ float64_gen2(float64 xa, float64 xb, float_status *s,
     return soft(ua.s, ub.s, s);
 }
 
-/*----------------------------------------------------------------------------
-| Returns the fraction bits of the half-precision floating-point value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline uint32_t extractFloat16Frac(float16 a)
-{
-    return float16_val(a) & 0x3ff;
-}
-
-/*----------------------------------------------------------------------------
-| Returns the exponent bits of the half-precision floating-point value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline int extractFloat16Exp(float16 a)
-{
-    return (float16_val(a) >> 10) & 0x1f;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the single-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
@@ -3306,6 +3288,55 @@ float64 float64_silence_nan(float64 a, float_status *status)
     return float64_pack_raw(p);
 }
 
+
+/*----------------------------------------------------------------------------
+| If `a' is denormal and we are in flush-to-zero mode then set the
+| input-denormal exception and return zero. Otherwise just return the value.
+*----------------------------------------------------------------------------*/
+
+static bool parts_squash_denormal(FloatParts p, float_status *status)
+{
+    if (p.exp == 0 && p.frac != 0) {
+        float_raise(float_flag_input_denormal, status);
+        return true;
+    }
+
+    return false;
+}
+
+float16 float16_squash_input_denormal(float16 a, float_status *status)
+{
+    if (status->flush_inputs_to_zero) {
+        FloatParts p = float16_unpack_raw(a);
+        if (parts_squash_denormal(p, status)) {
+            return float16_set_sign(float16_zero, p.sign);
+        }
+    }
+    return a;
+}
+
+float32 float32_squash_input_denormal(float32 a, float_status *status)
+{
+    if (status->flush_inputs_to_zero) {
+        FloatParts p = float32_unpack_raw(a);
+        if (parts_squash_denormal(p, status)) {
+            return float32_set_sign(float32_zero, p.sign);
+        }
+    }
+    return a;
+}
+
+float64 float64_squash_input_denormal(float64 a, float_status *status)
+{
+    if (status->flush_inputs_to_zero) {
+        FloatParts p = float64_unpack_raw(a);
+        if (parts_squash_denormal(p, status)) {
+            return float64_set_sign(float64_zero, p.sign);
+        }
+    }
+    return a;
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -3482,21 +3513,6 @@ static int64_t roundAndPackUint64(flag zSign, uint64_t absZ0,
     return absZ0;
 }
 
-/*----------------------------------------------------------------------------
-| If `a' is denormal and we are in flush-to-zero mode then set the
-| input-denormal exception and return zero. Otherwise just return the value.
-*----------------------------------------------------------------------------*/
-float32 float32_squash_input_denormal(float32 a, float_status *status)
-{
-    if (status->flush_inputs_to_zero) {
-        if (extractFloat32Exp(a) == 0 && extractFloat32Frac(a) != 0) {
-            float_raise(float_flag_input_denormal, status);
-            return make_float32(float32_val(a) & 0x80000000);
-        }
-    }
-    return a;
-}
-
 /*----------------------------------------------------------------------------
 | Normalizes the subnormal single-precision floating-point value represented
 | by the denormalized significand `aSig'.  The normalized exponent and
@@ -3635,21 +3651,6 @@ static float32
 
 }
 
-/*----------------------------------------------------------------------------
-| If `a' is denormal and we are in flush-to-zero mode then set the
-| input-denormal exception and return zero. Otherwise just return the value.
-*----------------------------------------------------------------------------*/
-float64 float64_squash_input_denormal(float64 a, float_status *status)
-{
-    if (status->flush_inputs_to_zero) {
-        if (extractFloat64Exp(a) == 0 && extractFloat64Frac(a) != 0) {
-            float_raise(float_flag_input_denormal, status);
-            return make_float64(float64_val(a) & (1ULL << 63));
-        }
-    }
-    return a;
-}
-
 /*----------------------------------------------------------------------------
 | Normalizes the subnormal double-precision floating-point value represented
 | by the denormalized significand `aSig'.  The normalized exponent and
@@ -4981,21 +4982,6 @@ int float32_unordered_quiet(float32 a, float32 b, float_status *status)
     return 0;
 }
 
-/*----------------------------------------------------------------------------
-| If `a' is denormal and we are in flush-to-zero mode then set the
-| input-denormal exception and return zero. Otherwise just return the value.
-*----------------------------------------------------------------------------*/
-float16 float16_squash_input_denormal(float16 a, float_status *status)
-{
-    if (status->flush_inputs_to_zero) {
-        if (extractFloat16Exp(a) == 0 && extractFloat16Frac(a) != 0) {
-            float_raise(float_flag_input_denormal, status);
-            return make_float16(float16_val(a) & 0x8000);
-        }
-    }
-    return a;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the double-precision floating-point value
 | `a' to the extended double-precision floating-point format.  The conversion
-- 
2.20.1


