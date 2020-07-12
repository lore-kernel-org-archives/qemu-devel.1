Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F44C433E3
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 23:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D702C20674
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 23:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D702C20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1julgE-0000LC-1Z
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 19:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1julfC-00072P-Cm
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 19:45:42 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1julf6-0007Fo-SS
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 19:45:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07634485|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_system_inform|0.0985976-0.002253-0.899149;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16378; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---.I0oni3i_1594597526; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I0oni3i_1594597526) by smtp.aliyun-inc.com(10.147.40.7);
 Mon, 13 Jul 2020 07:45:30 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 8/8] fpu/softfloat: define misc operation for bfloat16
Date: Mon, 13 Jul 2020 07:45:21 +0800
Message-Id: <20200712234521.3972-9-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 19:45:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org, wenmeng_zhang@c-sky.com,
 richard.henderson@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 fpu/softfloat-specialize.inc.c | 38 +++++++++++++++++++++++++++++++
 include/fpu/softfloat.h        | 41 ++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
index 6b778a7830..ff17f11f0c 100644
--- a/fpu/softfloat-specialize.inc.c
+++ b/fpu/softfloat-specialize.inc.c
@@ -259,6 +259,25 @@ bool float16_is_quiet_nan(float16 a_, float_status *status)
 #endif
 }
 
+/*----------------------------------------------------------------------------
+| Returns 1 if the brain floating point value `a' is a quiet
+| NaN; otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+int bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
+{
+#ifdef NO_SIGNALING_NANS
+    return bfloat16_is_any_nan(a_);
+#else
+    uint16_t a = bfloat16_val(a_);
+    if (snan_bit_is_one(status)) {
+        return (((a >> 6) & 0x1FF) == 0x1FE) && (a & 0x3F);
+    } else {
+        return ((a >> 6) & 0x1FF) == 0x1FF;
+    }
+#endif
+}
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is a signaling
 | NaN; otherwise returns 0.
@@ -278,6 +297,25 @@ bool float16_is_signaling_nan(float16 a_, float_status *status)
 #endif
 }
 
+/*----------------------------------------------------------------------------
+| Returns 1 if the brain floating point value `a' is a signaling
+| NaN; otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+int bfloat16_is_signaling_nan(bfloat16 a_, float_status *status)
+{
+#ifdef NO_SIGNALING_NANS
+    return 0;
+#else
+    uint16_t a = bfloat16_val(a_);
+    if (snan_bit_is_one(status)) {
+        return ((a >> 6) & 0x1FF) == 0x1FF;
+    } else {
+        return (((a >> 6) & 0x1FF) == 0x1FE) && (a & 0x3F);
+    }
+#endif
+}
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the single-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 6590850253..d2c3f5fbe0 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -372,6 +372,47 @@ static inline float16 float16_set_sign(float16 a, int sign)
 #define float16_three make_float16(0x4200)
 #define float16_infinity make_float16(0x7c00)
 
+static inline int bfloat16_is_any_nan(bfloat16 a)
+{
+    return ((bfloat16_val(a) & ~0x8000) > 0x7F80);
+}
+
+static inline int bfloat16_is_neg(bfloat16 a)
+{
+    return bfloat16_val(a) >> 15;
+}
+
+static inline int bfloat16_is_infinity(bfloat16 a)
+{
+    return (bfloat16_val(a) & 0x7fff) == 0x7F80;
+}
+
+static inline int bfloat16_is_zero(bfloat16 a)
+{
+    return (bfloat16_val(a) & 0x7fff) == 0;
+}
+
+static inline int bfloat16_is_zero_or_denormal(bfloat16 a)
+{
+    return (bfloat16_val(a) & 0x7F80) == 0;
+}
+
+static inline bfloat16 bfloat16_abs(bfloat16 a)
+{
+    /* Note that abs does *not* handle NaN specially, nor does
+     * it flush denormal inputs to zero.
+     */
+    return make_bfloat16(bfloat16_val(a) & 0x7fff);
+}
+
+static inline bfloat16 bfloat16_chs(bfloat16 a)
+{
+    /* Note that chs does *not* handle NaN specially, nor does
+     * it flush denormal inputs to zero.
+     */
+    return make_bfloat16(bfloat16_val(a) ^ 0x8000);
+}
+
 static inline bfloat16 bfloat16_set_sign(bfloat16 a, int sign)
 {
     return make_bfloat16((bfloat16_val(a) & 0x7fff) | (sign << 15));
-- 
2.23.0


