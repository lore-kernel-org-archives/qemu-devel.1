Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C6C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B5520725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJAPdJe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B5520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDNH-00064r-Iw
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMF-0004Gb-8D
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:51 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:36750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMD-0006MY-4j
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id t6so141452plo.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zfKLf5iWiRbsJuozXPD0s5y3leKtPfxTJtfPGHPtONE=;
 b=hJAPdJe+DoxoZCJQX96uaK3vHPgZsKEPAa01hUZwY5hlpf7B9i5zACiSHDXHwTxEtL
 jMNP2l2o9dtB2vkvvPVd0J1N7a8aJzBvQ6mnsPdiMN4so1vbOu9J79g7xYi4gpHeaamI
 U3bTHNptQGxvZlEn7CFEr2iOGqWz5rKYql7UZYq4Ym9vpQSL1d1bHAhbrftiAob0r6CE
 SmMFvxOGaXbiTfcIRXCm7O7NTKjEo82ocPkf8KDNt+MWn6ZjP5c50oKKTgbou26lP89q
 7mfJ9egElbftlG88YlbxrSGZdUeGGTQc7ciMLVZE6rAgYwg2OX/gIN6jyT/E9tj8XzIT
 pPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zfKLf5iWiRbsJuozXPD0s5y3leKtPfxTJtfPGHPtONE=;
 b=Ryy5gOhvsFhX/lAyrjTQe0/lxpgi9CocvjHKYRMagwN9bboE2Hp6i3xMkxa4YMRLe+
 flr/8TFOWkThR5vjB8Zab5pThk1hw+yTyIm+h1dAkyQShFqSQCFEDC0HMgm4zcKNQ9/j
 1yKBGyH69+DPZxWo3onBYPbvp9MQcA5X+lefV9fLcx6j9OmYeAMMSghmSPNVaHaWpgAP
 uWQeWB273JCm+0tX/5ijOq5646jsVvu6eopVVGTSAJnRXdjTwMNZ1S0BpOZ6U3WERS7W
 90PjfV2litNOXAIwI69BW/N7g1UPARGz6+lrLv8h1ExCwAz4LtV23xDdPpreawKmxQ5L
 0xiA==
X-Gm-Message-State: AOAM532ceTO3n1bxmLNxKLNhsVUgSk8s3CesFPSh2vky+olrv2wXzHfN
 oaebKRIqztNdRUMAldM4hc1lcJZT
X-Google-Smtp-Source: ABdhPJwSnPwwjiADYZbeZhcMV/XpgMUmRec79qY4/kSBWXGOtWMb8kp1oyfXNcNzaniz716Z6ELAMA==
X-Received: by 2002:a17:902:b114:: with SMTP id
 q20mr38474177plr.266.1594465667081; 
 Sat, 11 Jul 2020 04:07:47 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:46 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/22] softfloat: make NO_SIGNALING_NANS runtime property
Date: Sat, 11 Jul 2020 04:06:36 -0700
Message-Id: <20200711110655.20287-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

target/xtensa, the only user of NO_SIGNALING_NANS macro has FPU
implementations with and without the corresponding property. With
NO_SIGNALING_NANS being a macro they cannot be a part of the same QEMU
executable.
Replace macro with new property in float_status to allow cores with
different FPU implementations coexist.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Alex Bennée" <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- use inline function for no_signaling_nans property to allow for
  constant folding on architectures that have this property fixed.

 fpu/softfloat-specialize.inc.c  | 229 ++++++++++++++++----------------
 include/fpu/softfloat-helpers.h |   5 +
 include/fpu/softfloat-types.h   |   7 +-
 3 files changed, 128 insertions(+), 113 deletions(-)

diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
index 44f5b661f831..9d919ee2d993 100644
--- a/fpu/softfloat-specialize.inc.c
+++ b/fpu/softfloat-specialize.inc.c
@@ -79,12 +79,18 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
-/* Define for architectures which deviate from IEEE in not supporting
+/*
+ * Define whether architecture deviates from IEEE in not supporting
  * signaling NaNs (so all NaNs are treated as quiet).
  */
+static inline bool no_signaling_nans(float_status *status)
+{
 #if defined(TARGET_XTENSA)
-#define NO_SIGNALING_NANS 1
+    return status->no_signaling_nans;
+#else
+    return false;
 #endif
+}
 
 /* Define how the architecture discriminates signaling NaNs.
  * This done with the most significant bit of the fraction.
@@ -111,12 +117,12 @@ static inline bool snan_bit_is_one(float_status *status)
 
 static bool parts_is_snan_frac(uint64_t frac, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return false;
-#else
-    bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
-    return msb == snan_bit_is_one(status);
-#endif
+    if (no_signaling_nans(status)) {
+        return false;
+    } else {
+        bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
+        return msb == snan_bit_is_one(status);
+    }
 }
 
 /*----------------------------------------------------------------------------
@@ -170,9 +176,8 @@ static FloatParts parts_default_nan(float_status *status)
 
 static FloatParts parts_silence_nan(FloatParts a, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    g_assert_not_reached();
-#elif defined(TARGET_HPPA)
+    g_assert(!no_signaling_nans(status));
+#if defined(TARGET_HPPA)
     a.frac &= ~(1ULL << (DECOMPOSED_BINARY_POINT - 1));
     a.frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 2);
 #else
@@ -247,16 +252,16 @@ typedef struct {
 
 bool float16_is_quiet_nan(float16 a_, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return float16_is_any_nan(a_);
-#else
-    uint16_t a = float16_val(a_);
-    if (snan_bit_is_one(status)) {
-        return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
+    if (no_signaling_nans(status)) {
+        return float16_is_any_nan(a_);
     } else {
-        return ((a & ~0x8000) >= 0x7C80);
+        uint16_t a = float16_val(a_);
+        if (snan_bit_is_one(status)) {
+            return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
+        } else {
+            return ((a & ~0x8000) >= 0x7C80);
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -266,16 +271,16 @@ bool float16_is_quiet_nan(float16 a_, float_status *status)
 
 bool float16_is_signaling_nan(float16 a_, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return 0;
-#else
-    uint16_t a = float16_val(a_);
-    if (snan_bit_is_one(status)) {
-        return ((a & ~0x8000) >= 0x7C80);
+    if (no_signaling_nans(status)) {
+        return 0;
     } else {
-        return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
+        uint16_t a = float16_val(a_);
+        if (snan_bit_is_one(status)) {
+            return ((a & ~0x8000) >= 0x7C80);
+        } else {
+            return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -285,16 +290,16 @@ bool float16_is_signaling_nan(float16 a_, float_status *status)
 
 bool float32_is_quiet_nan(float32 a_, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return float32_is_any_nan(a_);
-#else
-    uint32_t a = float32_val(a_);
-    if (snan_bit_is_one(status)) {
-        return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
+    if (no_signaling_nans(status)) {
+        return float32_is_any_nan(a_);
     } else {
-        return ((uint32_t)(a << 1) >= 0xFF800000);
+        uint32_t a = float32_val(a_);
+        if (snan_bit_is_one(status)) {
+            return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
+        } else {
+            return ((uint32_t)(a << 1) >= 0xFF800000);
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -304,16 +309,16 @@ bool float32_is_quiet_nan(float32 a_, float_status *status)
 
 bool float32_is_signaling_nan(float32 a_, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return 0;
-#else
-    uint32_t a = float32_val(a_);
-    if (snan_bit_is_one(status)) {
-        return ((uint32_t)(a << 1) >= 0xFF800000);
+    if (no_signaling_nans(status)) {
+        return 0;
     } else {
-        return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
+        uint32_t a = float32_val(a_);
+        if (snan_bit_is_one(status)) {
+            return ((uint32_t)(a << 1) >= 0xFF800000);
+        } else {
+            return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -639,17 +644,17 @@ static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
 
 bool float64_is_quiet_nan(float64 a_, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return float64_is_any_nan(a_);
-#else
-    uint64_t a = float64_val(a_);
-    if (snan_bit_is_one(status)) {
-        return (((a >> 51) & 0xFFF) == 0xFFE)
-            && (a & 0x0007FFFFFFFFFFFFULL);
+    if (no_signaling_nans(status)) {
+        return float64_is_any_nan(a_);
     } else {
-        return ((a << 1) >= 0xFFF0000000000000ULL);
+        uint64_t a = float64_val(a_);
+        if (snan_bit_is_one(status)) {
+            return (((a >> 51) & 0xFFF) == 0xFFE)
+                && (a & 0x0007FFFFFFFFFFFFULL);
+        } else {
+            return ((a << 1) >= 0xFFF0000000000000ULL);
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -659,17 +664,17 @@ bool float64_is_quiet_nan(float64 a_, float_status *status)
 
 bool float64_is_signaling_nan(float64 a_, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return 0;
-#else
-    uint64_t a = float64_val(a_);
-    if (snan_bit_is_one(status)) {
-        return ((a << 1) >= 0xFFF0000000000000ULL);
+    if (no_signaling_nans(status)) {
+        return 0;
     } else {
-        return (((a >> 51) & 0xFFF) == 0xFFE)
-            && (a & UINT64_C(0x0007FFFFFFFFFFFF));
+        uint64_t a = float64_val(a_);
+        if (snan_bit_is_one(status)) {
+            return ((a << 1) >= 0xFFF0000000000000ULL);
+        } else {
+            return (((a >> 51) & 0xFFF) == 0xFFE)
+                && (a & UINT64_C(0x0007FFFFFFFFFFFF));
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -778,21 +783,21 @@ static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
 
 int floatx80_is_quiet_nan(floatx80 a, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return floatx80_is_any_nan(a);
-#else
-    if (snan_bit_is_one(status)) {
-        uint64_t aLow;
-
-        aLow = a.low & ~0x4000000000000000ULL;
-        return ((a.high & 0x7FFF) == 0x7FFF)
-            && (aLow << 1)
-            && (a.low == aLow);
+    if (no_signaling_nans(status)) {
+        return floatx80_is_any_nan(a);
     } else {
-        return ((a.high & 0x7FFF) == 0x7FFF)
-            && (UINT64_C(0x8000000000000000) <= ((uint64_t)(a.low << 1)));
+        if (snan_bit_is_one(status)) {
+            uint64_t aLow;
+
+            aLow = a.low & ~0x4000000000000000ULL;
+            return ((a.high & 0x7FFF) == 0x7FFF)
+                && (aLow << 1)
+                && (a.low == aLow);
+        } else {
+            return ((a.high & 0x7FFF) == 0x7FFF)
+                && (UINT64_C(0x8000000000000000) <= ((uint64_t)(a.low << 1)));
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -803,21 +808,21 @@ int floatx80_is_quiet_nan(floatx80 a, float_status *status)
 
 int floatx80_is_signaling_nan(floatx80 a, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return 0;
-#else
-    if (snan_bit_is_one(status)) {
-        return ((a.high & 0x7FFF) == 0x7FFF)
-            && ((a.low << 1) >= 0x8000000000000000ULL);
+    if (no_signaling_nans(status)) {
+        return 0;
     } else {
-        uint64_t aLow;
+        if (snan_bit_is_one(status)) {
+            return ((a.high & 0x7FFF) == 0x7FFF)
+                && ((a.low << 1) >= 0x8000000000000000ULL);
+        } else {
+            uint64_t aLow;
 
-        aLow = a.low & ~UINT64_C(0x4000000000000000);
-        return ((a.high & 0x7FFF) == 0x7FFF)
-            && (uint64_t)(aLow << 1)
-            && (a.low == aLow);
+            aLow = a.low & ~UINT64_C(0x4000000000000000);
+            return ((a.high & 0x7FFF) == 0x7FFF)
+                && (uint64_t)(aLow << 1)
+                && (a.low == aLow);
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -941,17 +946,17 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
 
 bool float128_is_quiet_nan(float128 a, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return float128_is_any_nan(a);
-#else
-    if (snan_bit_is_one(status)) {
-        return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
-            && (a.low || (a.high & 0x00007FFFFFFFFFFFULL));
+    if (no_signaling_nans(status)) {
+        return float128_is_any_nan(a);
     } else {
-        return ((a.high << 1) >= 0xFFFF000000000000ULL)
-            && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
+        if (snan_bit_is_one(status)) {
+            return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
+                && (a.low || (a.high & 0x00007FFFFFFFFFFFULL));
+        } else {
+            return ((a.high << 1) >= 0xFFFF000000000000ULL)
+                && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -961,17 +966,17 @@ bool float128_is_quiet_nan(float128 a, float_status *status)
 
 bool float128_is_signaling_nan(float128 a, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    return 0;
-#else
-    if (snan_bit_is_one(status)) {
-        return ((a.high << 1) >= 0xFFFF000000000000ULL)
-            && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
+    if (no_signaling_nans(status)) {
+        return 0;
     } else {
-        return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
-            && (a.low || (a.high & UINT64_C(0x00007FFFFFFFFFFF)));
+        if (snan_bit_is_one(status)) {
+            return ((a.high << 1) >= 0xFFFF000000000000ULL)
+                && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
+        } else {
+            return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
+                && (a.low || (a.high & UINT64_C(0x00007FFFFFFFFFFF)));
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -981,16 +986,16 @@ bool float128_is_signaling_nan(float128 a, float_status *status)
 
 float128 float128_silence_nan(float128 a, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    g_assert_not_reached();
-#else
-    if (snan_bit_is_one(status)) {
-        return float128_default_nan(status);
+    if (no_signaling_nans(status)) {
+        g_assert_not_reached();
     } else {
-        a.high |= UINT64_C(0x0000800000000000);
-        return a;
+        if (snan_bit_is_one(status)) {
+            return float128_default_nan(status);
+        } else {
+            a.high |= UINT64_C(0x0000800000000000);
+            return a;
+        }
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 735ed6b653ee..e842f83a1285 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -95,6 +95,11 @@ static inline void set_snan_bit_is_one(bool val, float_status *status)
     status->snan_bit_is_one = val;
 }
 
+static inline void set_no_signaling_nans(bool val, float_status *status)
+{
+    status->no_signaling_nans = val;
+}
+
 static inline bool get_float_detect_tininess(float_status *status)
 {
     return status->tininess_before_rounding;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 7680193ebc1c..d6f167c1b0c4 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -165,8 +165,13 @@ typedef struct float_status {
     /* should denormalised inputs go to zero and set the input_denormal flag? */
     bool flush_inputs_to_zero;
     bool default_nan_mode;
-    /* not always used -- see snan_bit_is_one() in softfloat-specialize.h */
+    /*
+     * The flags below are not used on all specializations and may
+     * constant fold away (see snan_bit_is_one()/no_signalling_nans() in
+     * softfloat-specialize.inc.c)
+     */
     bool snan_bit_is_one;
+    bool no_signaling_nans;
 } float_status;
 
 #endif /* SOFTFLOAT_TYPES_H */
-- 
2.20.1


