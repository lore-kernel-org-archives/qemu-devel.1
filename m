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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A921CC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B2120725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNEe1brx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B2120725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDOV-0008UQ-LM
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMF-0004Gf-Ak
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:51 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:37561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMD-0006Mb-LI
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:50 -0400
Received: by mail-pg1-x529.google.com with SMTP id d4so3695734pgk.4
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oTUGV9EdxWG0XIaI+PwiYQJxR5bdFhJD7IYG+Dbw5+c=;
 b=qNEe1brxejNi88gweuUx39xVsQn6ugPqV7kpScleCifAoJ4FB19EP1GrmMc50DwNcv
 AikDlOoi10rnKWaM/pFH3eXsBX2M8ZMF/mHV3TBo17XhToceX5Tso7nNdYnQOgCPemAS
 Fzcy1f/yeKaEymzlU2jKbEP0kfv0+MQVN9OiMbdkUNClmV2PJvc6lKhxMsRMzhvcGW6W
 HjS7LhmOIFuMNe0alNQNSPvIjGSMCb8A6ttRPVR91YJAJxGNi/FNyPDkKHv/6VNm4VQi
 hB6bJHybG/cT8J/g3Q5LiJ5De99uB9doPLe3l3rTn/2zp8HVI1MXWMWGisQr9M0jsp+K
 zTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oTUGV9EdxWG0XIaI+PwiYQJxR5bdFhJD7IYG+Dbw5+c=;
 b=XvdnSgTkfsvXGv2ExfItHtvTrNw1nWNW6yDkxkv0J7cubWhU5YGxU24O6kDISunm1C
 4txT5QEg+mDgd/HfH2/2qpYkOhLs17W+cgt3kBYbPPE2V8uA4wzIr7CndptjOdN/NrCq
 wyCKNI676AmBIZOxriYK8kTC73oMJP9BU3KIUJuDjB2RCjujgD19jQCaGW/J+aoCcr3Y
 fhg0YZV/ZMITxyuNJyuJNzNY/cQhCPYoYQUwTaXJbTkXY4j4aDPQdRhi4CpVktLFC2Bn
 3bQTTaOL3PugMvjXHAOhoD/1YsblxxnUMIMJTaJPZmDAr7MfWr1DNZYlMyQeisFKEx1S
 lR+g==
X-Gm-Message-State: AOAM532BQbyLbmVNBVznPGd3K0GwyGN9WPy/7rIuKKMzJh5KYbZos3r6
 2Zjh7uYRi2VtGQeo0P9eZyjxcxvW
X-Google-Smtp-Source: ABdhPJywYNu9GlWrynQfCs5zDuTN+9AtT54xfUo1Qh4ECzzu3lS9TsyvhCyfEfawVxVcc3GfPET4/A==
X-Received: by 2002:a65:6799:: with SMTP id e25mr64832887pgr.364.1594465667969; 
 Sat, 11 Jul 2020 04:07:47 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:47 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/22] softfloat: pass float_status pointer to pickNaN
Date: Sat, 11 Jul 2020 04:06:37 -0700
Message-Id: <20200711110655.20287-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x529.google.com
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
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass float_status structure pointer to the pickNaN so that
machine-specific settings are available to NaN selection code.
Add use_first_nan property to float_status and use it in Xtensa-specific
pickNaN.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Alex Bennée" <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 fpu/softfloat-specialize.inc.c  | 30 ++++++++++++++++++++++++------
 fpu/softfloat.c                 |  2 +-
 include/fpu/softfloat-helpers.h |  5 +++++
 include/fpu/softfloat-types.h   |  1 +
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
index 9d919ee2d993..f519beca1b74 100644
--- a/fpu/softfloat-specialize.inc.c
+++ b/fpu/softfloat-specialize.inc.c
@@ -379,7 +379,7 @@ static float32 commonNaNToFloat32(commonNaNT a, float_status *status)
 *----------------------------------------------------------------------------*/
 
 static int pickNaN(FloatClass a_cls, FloatClass b_cls,
-                   bool aIsLargerSignificand)
+                   bool aIsLargerSignificand, float_status *status)
 {
 #if defined(TARGET_ARM) || defined(TARGET_MIPS) || defined(TARGET_HPPA)
     /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take
@@ -412,7 +412,7 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     } else {
         return 1;
     }
-#elif defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
+#elif defined(TARGET_PPC) || defined(TARGET_M68K)
     /* PowerPC propagation rules:
      *  1. A if it sNaN or qNaN
      *  2. B if it sNaN or qNaN
@@ -437,6 +437,24 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     } else {
         return 1;
     }
+#elif defined(TARGET_XTENSA)
+    /*
+     * Xtensa has two NaN propagation modes.
+     * Which one is active is controlled by float_status::use_first_nan.
+     */
+    if (status->use_first_nan) {
+        if (is_nan(a_cls)) {
+            return 0;
+        } else {
+            return 1;
+        }
+    } else {
+        if (is_nan(b_cls)) {
+            return 1;
+        } else {
+            return 0;
+        }
+    }
 #else
     /* This implements x87 NaN propagation rules:
      * SNaN + QNaN => return the QNaN
@@ -624,7 +642,7 @@ static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
         aIsLargerSignificand = (av < bv) ? 1 : 0;
     }
 
-    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
         if (is_snan(b_cls)) {
             return float32_silence_nan(b, status);
         }
@@ -762,7 +780,7 @@ static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
         aIsLargerSignificand = (av < bv) ? 1 : 0;
     }
 
-    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
         if (is_snan(b_cls)) {
             return float64_silence_nan(b, status);
         }
@@ -926,7 +944,7 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
         aIsLargerSignificand = (a.high < b.high) ? 1 : 0;
     }
 
-    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
         if (is_snan(b_cls)) {
             return floatx80_silence_nan(b, status);
         }
@@ -1074,7 +1092,7 @@ static float128 propagateFloat128NaN(float128 a, float128 b,
         aIsLargerSignificand = (a.high < b.high) ? 1 : 0;
     }
 
-    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
         if (is_snan(b_cls)) {
             return float128_silence_nan(b, status);
         }
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5e9746c2876f..a89056a1816e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -881,7 +881,7 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
     } else {
         if (pickNaN(a.cls, b.cls,
                     a.frac > b.frac ||
-                    (a.frac == b.frac && a.sign < b.sign))) {
+                    (a.frac == b.frac && a.sign < b.sign), s)) {
             a = b;
         }
         if (is_snan(a.cls)) {
diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index e842f83a1285..2f0674fbddec 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -95,6 +95,11 @@ static inline void set_snan_bit_is_one(bool val, float_status *status)
     status->snan_bit_is_one = val;
 }
 
+static inline void set_use_first_nan(bool val, float_status *status)
+{
+    status->use_first_nan = val;
+}
+
 static inline void set_no_signaling_nans(bool val, float_status *status)
 {
     status->no_signaling_nans = val;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index d6f167c1b0c4..c7ddcab8caee 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -171,6 +171,7 @@ typedef struct float_status {
      * softfloat-specialize.inc.c)
      */
     bool snan_bit_is_one;
+    bool use_first_nan;
     bool no_signaling_nans;
 } float_status;
 
-- 
2.20.1


