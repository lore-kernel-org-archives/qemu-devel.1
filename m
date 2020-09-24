Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C9C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99EF22145D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQI2BUod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EF22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLG1a-0006cm-GW
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0N-0004r8-Dv
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:03 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0L-0005hd-LS
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:03 -0400
Received: by mail-pj1-x1044.google.com with SMTP id jw11so697396pjb.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 18:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DTuyn50RwqtJUsMxHJmqO9znr03h7lV5LqctzDmaByI=;
 b=xQI2BUod19ya/B++dGru/GRtvSs88IP5q1gYYE9G+2T931ZT4dA6MhmISVErRfCw1p
 lZr0beeILt/Yt+GclMxigiMrTpt0gagWL4JsDwLj6d6jzY/86qyDib5Raj6733stDh6v
 apLQnb9QKl1G5EV2QZz78cxOajZhFtlbhD+E+BKnhO8avHwOGryWSqKtvLajE0hkMmgn
 RL2OgMAZQy0ksicd2fBwCwIu+n41zRzuWSxd/2KLrC/D2LvR92leV9P0lNYbrts5St/H
 d54tOTsiXnD0cUhKUBep5Ylof4zzH4FSh+TuuD6Kzv2JxtK/NCyAoO1WJraIF0X3RiIb
 WtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DTuyn50RwqtJUsMxHJmqO9znr03h7lV5LqctzDmaByI=;
 b=ope19jHOtvbuibLFwdWQozi6x/4T/QuejOidl7XZxf6qnZcSqT1LXxvXgIGq3K/tRi
 GtwfyaFG54fvtq9Pr9C6k3s5yBKlX2qPc7f3AvCbmgR6BYr1OTSFfI/EXoY7BqjFCQiw
 Jpdl8qLX4SBfB3BJZxQtGy2V0LiokoOCd22wafBrk1YH0tYqJzb3Njtzc/YuXQnNzFm6
 gp2wK1ikQQKRkcXYhmRoJ6SxcVpXpBi4xkX6Uwba4UFess/vUns+8/rdGMEBc225oB0d
 elsZcCppArIbBnT9ei9fG+qCqoC7EyMfE7/ckjyrckMHRq5Nvpg4spMHGqKFZnk3EQnE
 bWwQ==
X-Gm-Message-State: AOAM5336GtdSgib2HUYd7prJjh0YLdo5/fAVCklWY8u0160wsUUv6/pK
 MBN+igFGV0pGikbq/bxR5FlrB9PaDKG98A==
X-Google-Smtp-Source: ABdhPJwI8F5VmWnywQHLADZakL0nvz2OxDUf1+KM81fSU9G27FqNdOvYWVhSIqM0/Ted7gmxzbVupA==
X-Received: by 2002:a17:902:16b:b029:d2:565e:a70b with SMTP id
 98-20020a170902016bb02900d2565ea70bmr2407520plb.42.1600910699993; 
 Wed, 23 Sep 2020 18:24:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k27sm938432pgm.29.2020.09.23.18.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 18:24:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] softfloat: Add float_cmask and constants
Date: Wed, 23 Sep 2020 18:24:49 -0700
Message-Id: <20200924012453.659757-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924012453.659757-1-richard.henderson@linaro.org>
References: <20200924012453.659757-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Testing more than one class at a time is better done with masks.
This reduces the static branch count.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9db55d2b11..3e625c47cd 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -469,6 +469,20 @@ typedef enum __attribute__ ((__packed__)) {
     float_class_snan,
 } FloatClass;
 
+#define float_cmask(bit)  (1u << (bit))
+
+enum {
+    float_cmask_zero    = float_cmask(float_class_zero),
+    float_cmask_normal  = float_cmask(float_class_normal),
+    float_cmask_inf     = float_cmask(float_class_inf),
+    float_cmask_qnan    = float_cmask(float_class_qnan),
+    float_cmask_snan    = float_cmask(float_class_snan),
+
+    float_cmask_infzero = float_cmask_zero | float_cmask_inf,
+    float_cmask_anynan  = float_cmask_qnan | float_cmask_snan,
+};
+
+
 /* Simple helpers for checking if, or what kind of, NaN we have */
 static inline __attribute__((unused)) bool is_nan(FloatClass c)
 {
@@ -1335,24 +1349,27 @@ bfloat16 QEMU_FLATTEN bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
 static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
                                 int flags, float_status *s)
 {
-    bool inf_zero = ((1 << a.cls) | (1 << b.cls)) ==
-                    ((1 << float_class_inf) | (1 << float_class_zero));
-    bool p_sign;
+    bool inf_zero, p_sign;
     bool sign_flip = flags & float_muladd_negate_result;
     FloatClass p_class;
     uint64_t hi, lo;
     int p_exp;
+    int ab_mask, abc_mask;
+
+    ab_mask = float_cmask(a.cls) | float_cmask(b.cls);
+    abc_mask = float_cmask(c.cls) | ab_mask;
+    inf_zero = ab_mask == float_cmask_infzero;
 
     /* It is implementation-defined whether the cases of (0,inf,qnan)
      * and (inf,0,qnan) raise InvalidOperation or not (and what QNaN
      * they return if they do), so we have to hand this information
      * off to the target-specific pick-a-NaN routine.
      */
-    if (is_nan(a.cls) || is_nan(b.cls) || is_nan(c.cls)) {
+    if (unlikely(abc_mask & float_cmask_anynan)) {
         return pick_nan_muladd(a, b, c, inf_zero, s);
     }
 
-    if (inf_zero) {
+    if (unlikely(inf_zero)) {
         s->float_exception_flags |= float_flag_invalid;
         return parts_default_nan(s);
     }
@@ -1367,9 +1384,9 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
         p_sign ^= 1;
     }
 
-    if (a.cls == float_class_inf || b.cls == float_class_inf) {
+    if (ab_mask & float_cmask_inf) {
         p_class = float_class_inf;
-    } else if (a.cls == float_class_zero || b.cls == float_class_zero) {
+    } else if (ab_mask & float_cmask_zero) {
         p_class = float_class_zero;
     } else {
         p_class = float_class_normal;
-- 
2.25.1


