Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B886C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52E72186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGbb/zIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52E72186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmZO-0007NJ-3e
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmC6-0001l9-3A
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:30:30 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmC4-000371-6w
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:30:29 -0400
Received: by mail-pj1-x1041.google.com with SMTP id d6so2079232pjs.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jobrbNLBuuJTm3LNrCw/eJDbp1CdHr71xDBzqApoIms=;
 b=GGbb/zIxMDVZVIfABInmzvbDEHE3W5AYmY7FVaHo90PpC9JhtoYKclIENfWJD7AbQx
 Zn73koa1k/7zoLCLym4HxWdZwT4j+vVWcW92evnX7s/Wv/JtxvNrLV5+tXZDgMw7FLyW
 FQwYYkWVg8HeEwApSC4Kdeats2jG35X8AjzCX0MXmsgftL5VRFDRoKUJUGVqrL/I0HWk
 +wb4YQY6DITxTVtcImuuG0hx0U5YOQIviu+C3OW+VPLiQdQ9ire3cp/+oPlI3zuFzp6S
 A5WbU5HSM/+nx7hNkS4I5MT8kxFVvF8WYBocCzHtRUco2jHb7ToSNS6e+R01jn4+ofBg
 CrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jobrbNLBuuJTm3LNrCw/eJDbp1CdHr71xDBzqApoIms=;
 b=tNqt0HDGcEEIWCBCfc2SzTW9azseFmP0XIPVgco7Kpq1cFL40fv3iLMWRplnPCtbBj
 nHfvdj5NgG8fqRbm4chCytOIwbdWNsBxJcO+TkMS9GIoT6TB8KiaIjXhb+ueJwZi9X4C
 8UYGZjqrviiTAVDZdeVUPsNRKQWvl+dUkF+KcIC/ie8HhoOhIjLAKLcXj8QNRvrZt4Tq
 NMGpkQjyKr35+Z/qJF8qyEZonjW7Ac2kkj4pDo4NyV1tQJlaCt7AWPxvXvn6gUkNxo9L
 8qep/tXlYUr9zxEO5m9P1OgVx64fQJuBfIkNRuRY9/vCBCXrCKAwXfxLaGojNpJoPi+L
 qk9w==
X-Gm-Message-State: AOAM533+UsWgPEjL7MM87Z7sfBBYoFDA4Viq1dbjGgb/iZkdqeKmgLxJ
 VNdcufIwfpeS5MPPwEmWkdxXFe60UCo=
X-Google-Smtp-Source: ABdhPJyUWkEhWafHonraq3a3qgY6FZwrCbWTlMSyZFC/UOSKPmPwlqeObuPXEaQQpF7bssqWRy+/5w==
X-Received: by 2002:a17:902:7b90:: with SMTP id
 w16mr2066573pll.339.1592454626425; 
 Wed, 17 Jun 2020 21:30:26 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i191sm1298861pfe.99.2020.06.17.21.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:30:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 050/100] target/arm: Generalize inl_qrdmlah_* helper
 functions
Date: Wed, 17 Jun 2020 21:25:54 -0700
Message-Id: <20200618042644.1685561-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unify add/sub helpers and add a parameter for rounding.
This will allow saturating non-rounding to reuse this code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vec_helper.c | 80 +++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 32b1aace3d..b0ae51f95f 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -37,19 +37,24 @@
 #endif
 
 /* Signed saturating rounding doubling multiply-accumulate high half, 16-bit */
-static int16_t inl_qrdmlah_s16(int16_t src1, int16_t src2,
-                               int16_t src3, uint32_t *sat)
+static int16_t do_sqrdmlah_h(int16_t src1, int16_t src2, int16_t src3,
+                             bool neg, bool round, uint32_t *sat)
 {
-    /* Simplify:
+    /*
+     * Simplify:
      * = ((a3 << 16) + ((e1 * e2) << 1) + (1 << 15)) >> 16
      * = ((a3 << 15) + (e1 * e2) + (1 << 14)) >> 15
      */
     int32_t ret = (int32_t)src1 * src2;
-    ret = ((int32_t)src3 << 15) + ret + (1 << 14);
+    if (neg) {
+        ret = -ret;
+    }
+    ret += ((int32_t)src3 << 15) + (round << 14);
     ret >>= 15;
+
     if (ret != (int16_t)ret) {
         *sat = 1;
-        ret = (ret < 0 ? -0x8000 : 0x7fff);
+        ret = (ret < 0 ? INT16_MIN : INT16_MAX);
     }
     return ret;
 }
@@ -58,8 +63,9 @@ uint32_t HELPER(neon_qrdmlah_s16)(CPUARMState *env, uint32_t src1,
                                   uint32_t src2, uint32_t src3)
 {
     uint32_t *sat = &env->vfp.qc[0];
-    uint16_t e1 = inl_qrdmlah_s16(src1, src2, src3, sat);
-    uint16_t e2 = inl_qrdmlah_s16(src1 >> 16, src2 >> 16, src3 >> 16, sat);
+    uint16_t e1 = do_sqrdmlah_h(src1, src2, src3, false, true, sat);
+    uint16_t e2 = do_sqrdmlah_h(src1 >> 16, src2 >> 16, src3 >> 16,
+                                false, true, sat);
     return deposit32(e1, 16, 16, e2);
 }
 
@@ -73,35 +79,18 @@ void HELPER(gvec_qrdmlah_s16)(void *vd, void *vn, void *vm,
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 2; ++i) {
-        d[i] = inl_qrdmlah_s16(n[i], m[i], d[i], vq);
+        d[i] = do_sqrdmlah_h(n[i], m[i], d[i], false, true, vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-/* Signed saturating rounding doubling multiply-subtract high half, 16-bit */
-static int16_t inl_qrdmlsh_s16(int16_t src1, int16_t src2,
-                               int16_t src3, uint32_t *sat)
-{
-    /* Similarly, using subtraction:
-     * = ((a3 << 16) - ((e1 * e2) << 1) + (1 << 15)) >> 16
-     * = ((a3 << 15) - (e1 * e2) + (1 << 14)) >> 15
-     */
-    int32_t ret = (int32_t)src1 * src2;
-    ret = ((int32_t)src3 << 15) - ret + (1 << 14);
-    ret >>= 15;
-    if (ret != (int16_t)ret) {
-        *sat = 1;
-        ret = (ret < 0 ? -0x8000 : 0x7fff);
-    }
-    return ret;
-}
-
 uint32_t HELPER(neon_qrdmlsh_s16)(CPUARMState *env, uint32_t src1,
                                   uint32_t src2, uint32_t src3)
 {
     uint32_t *sat = &env->vfp.qc[0];
-    uint16_t e1 = inl_qrdmlsh_s16(src1, src2, src3, sat);
-    uint16_t e2 = inl_qrdmlsh_s16(src1 >> 16, src2 >> 16, src3 >> 16, sat);
+    uint16_t e1 = do_sqrdmlah_h(src1, src2, src3, true, true, sat);
+    uint16_t e2 = do_sqrdmlah_h(src1 >> 16, src2 >> 16, src3 >> 16,
+                                true, true, sat);
     return deposit32(e1, 16, 16, e2);
 }
 
@@ -115,19 +104,23 @@ void HELPER(gvec_qrdmlsh_s16)(void *vd, void *vn, void *vm,
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 2; ++i) {
-        d[i] = inl_qrdmlsh_s16(n[i], m[i], d[i], vq);
+        d[i] = do_sqrdmlah_h(n[i], m[i], d[i], true, true, vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
 /* Signed saturating rounding doubling multiply-accumulate high half, 32-bit */
-static int32_t inl_qrdmlah_s32(int32_t src1, int32_t src2,
-                               int32_t src3, uint32_t *sat)
+static int32_t do_sqrdmlah_s(int32_t src1, int32_t src2, int32_t src3,
+                             bool neg, bool round, uint32_t *sat)
 {
     /* Simplify similarly to int_qrdmlah_s16 above.  */
     int64_t ret = (int64_t)src1 * src2;
-    ret = ((int64_t)src3 << 31) + ret + (1 << 30);
+    if (neg) {
+        ret = -ret;
+    }
+    ret = ((int64_t)src3 << 31) + (round << 30);
     ret >>= 31;
+
     if (ret != (int32_t)ret) {
         *sat = 1;
         ret = (ret < 0 ? INT32_MIN : INT32_MAX);
@@ -139,7 +132,7 @@ uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, int32_t src1,
                                   int32_t src2, int32_t src3)
 {
     uint32_t *sat = &env->vfp.qc[0];
-    return inl_qrdmlah_s32(src1, src2, src3, sat);
+    return do_sqrdmlah_s(src1, src2, src3, false, true, sat);
 }
 
 void HELPER(gvec_qrdmlah_s32)(void *vd, void *vn, void *vm,
@@ -152,31 +145,16 @@ void HELPER(gvec_qrdmlah_s32)(void *vd, void *vn, void *vm,
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        d[i] = inl_qrdmlah_s32(n[i], m[i], d[i], vq);
+        d[i] = do_sqrdmlah_s(n[i], m[i], d[i], false, true, vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-/* Signed saturating rounding doubling multiply-subtract high half, 32-bit */
-static int32_t inl_qrdmlsh_s32(int32_t src1, int32_t src2,
-                               int32_t src3, uint32_t *sat)
-{
-    /* Simplify similarly to int_qrdmlsh_s16 above.  */
-    int64_t ret = (int64_t)src1 * src2;
-    ret = ((int64_t)src3 << 31) - ret + (1 << 30);
-    ret >>= 31;
-    if (ret != (int32_t)ret) {
-        *sat = 1;
-        ret = (ret < 0 ? INT32_MIN : INT32_MAX);
-    }
-    return ret;
-}
-
 uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, int32_t src1,
                                   int32_t src2, int32_t src3)
 {
     uint32_t *sat = &env->vfp.qc[0];
-    return inl_qrdmlsh_s32(src1, src2, src3, sat);
+    return do_sqrdmlah_s(src1, src2, src3, true, true, sat);
 }
 
 void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
@@ -189,7 +167,7 @@ void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        d[i] = inl_qrdmlsh_s32(n[i], m[i], d[i], vq);
+        d[i] = do_sqrdmlah_s(n[i], m[i], d[i], true, true, vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
-- 
2.25.1


