Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B012DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743062053B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743062053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67TP-0004BC-KF
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1k67Rj-0001tO-OZ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:14:43 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1k67Re-0007d6-JE
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:14:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06436702|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.111529-0.000666944-0.887804;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07440; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---.IGxBKGW_1597302868; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.IGxBKGW_1597302868)
 by smtp.aliyun-inc.com(10.147.41.143);
 Thu, 13 Aug 2020 15:14:29 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] fpu/softfloat: Define convert operations for bfloat16
Date: Thu, 13 Aug 2020 15:14:20 +0800
Message-Id: <20200813071421.2509-3-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200813071421.2509-1-zhiwei_liu@c-sky.com>
References: <20200813071421.2509-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:14:30
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
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>, aurelien@aurel32.net,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c         | 223 ++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h |  48 +++++++++
 2 files changed, 271 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d4205f92d5..afb121135d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2014,6 +2014,34 @@ float32 float64_to_float32(float64 a, float_status *s)
     return float32_round_pack_canonical(pr, s);
 }
 
+float32 bfloat16_to_float32(bfloat16 a, float_status *s)
+{
+    FloatParts p = bfloat16_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &float32_params, s);
+    return float32_round_pack_canonical(pr, s);
+}
+
+float64 bfloat16_to_float64(bfloat16 a, float_status *s)
+{
+    FloatParts p = bfloat16_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &float64_params, s);
+    return float64_round_pack_canonical(pr, s);
+}
+
+bfloat16 float32_to_bfloat16(float32 a, float_status *s)
+{
+    FloatParts p = float32_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &bfloat16_params, s);
+    return bfloat16_round_pack_canonical(pr, s);
+}
+
+bfloat16 float64_to_bfloat16(float64 a, float_status *s)
+{
+    FloatParts p = float64_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &bfloat16_params, s);
+    return bfloat16_round_pack_canonical(pr, s);
+}
+
 /*
  * Rounds the floating-point value `a' to an integer, and returns the
  * result as a floating-point value. The operation is performed
@@ -2143,6 +2171,18 @@ float64 float64_round_to_int(float64 a, float_status *s)
     return float64_round_pack_canonical(pr, s);
 }
 
+/*
+ * Rounds the bfloat16 value `a' to an integer, and returns the
+ * result as a bfloat16 value.
+ */
+
+bfloat16 bfloat16_round_to_int(bfloat16 a, float_status *s)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, s);
+    FloatParts pr = round_to_int(pa, s->float_rounding_mode, 0, s);
+    return bfloat16_round_pack_canonical(pr, s);
+}
+
 /*
  * Returns the result of converting the floating-point value `a' to
  * the two's complement integer format. The conversion is performed
@@ -2353,6 +2393,62 @@ int64_t float64_to_int64_round_to_zero(float64 a, float_status *s)
     return float64_to_int64_scalbn(a, float_round_to_zero, 0, s);
 }
 
+/*
+ * Returns the result of converting the floating-point value `a' to
+ * the two's complement integer format.
+ */
+
+int16_t bfloat16_to_int16_scalbn(bfloat16 a, int rmode, int scale,
+                                 float_status *s)
+{
+    return round_to_int_and_pack(bfloat16_unpack_canonical(a, s),
+                                 rmode, scale, INT16_MIN, INT16_MAX, s);
+}
+
+int32_t bfloat16_to_int32_scalbn(bfloat16 a, int rmode, int scale,
+                                 float_status *s)
+{
+    return round_to_int_and_pack(bfloat16_unpack_canonical(a, s),
+                                 rmode, scale, INT32_MIN, INT32_MAX, s);
+}
+
+int64_t bfloat16_to_int64_scalbn(bfloat16 a, int rmode, int scale,
+                                 float_status *s)
+{
+    return round_to_int_and_pack(bfloat16_unpack_canonical(a, s),
+                                 rmode, scale, INT64_MIN, INT64_MAX, s);
+}
+
+int16_t bfloat16_to_int16(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int32_t bfloat16_to_int32(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int64_t bfloat16_to_int64(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int16_t bfloat16_to_int16_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int16_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int32_t bfloat16_to_int32_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int32_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int64_t bfloat16_to_int64_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int64_scalbn(a, float_round_to_zero, 0, s);
+}
+
 /*
  *  Returns the result of converting the floating-point value `a' to
  *  the unsigned integer format. The conversion is performed according
@@ -2566,6 +2662,62 @@ uint64_t float64_to_uint64_round_to_zero(float64 a, float_status *s)
     return float64_to_uint64_scalbn(a, float_round_to_zero, 0, s);
 }
 
+/*
+ *  Returns the result of converting the bfloat16 value `a' to
+ *  the unsigned integer format.
+ */
+
+uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, int rmode, int scale,
+                                   float_status *s)
+{
+    return round_to_uint_and_pack(bfloat16_unpack_canonical(a, s),
+                                  rmode, scale, UINT16_MAX, s);
+}
+
+uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, int rmode, int scale,
+                                   float_status *s)
+{
+    return round_to_uint_and_pack(bfloat16_unpack_canonical(a, s),
+                                  rmode, scale, UINT32_MAX, s);
+}
+
+uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, int rmode, int scale,
+                                   float_status *s)
+{
+    return round_to_uint_and_pack(bfloat16_unpack_canonical(a, s),
+                                  rmode, scale, UINT64_MAX, s);
+}
+
+uint16_t bfloat16_to_uint16(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint32_t bfloat16_to_uint32(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint32_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint64_t bfloat16_to_uint64(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint16_t bfloat16_to_uint16_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint16_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint32_t bfloat16_to_uint32_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint32_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint64_t bfloat16_to_uint64_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint64_scalbn(a, float_round_to_zero, 0, s);
+}
+
 /*
  * Integer to float conversions
  *
@@ -2692,6 +2844,41 @@ float64 int16_to_float64(int16_t a, float_status *status)
     return int64_to_float64_scalbn(a, 0, status);
 }
 
+/*
+ * Returns the result of converting the two's complement integer `a'
+ * to the bfloat16 format.
+ */
+
+bfloat16 int64_to_bfloat16_scalbn(int64_t a, int scale, float_status *status)
+{
+    FloatParts pa = int_to_float(a, scale, status);
+    return bfloat16_round_pack_canonical(pa, status);
+}
+
+bfloat16 int32_to_bfloat16_scalbn(int32_t a, int scale, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, scale, status);
+}
+
+bfloat16 int16_to_bfloat16_scalbn(int16_t a, int scale, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, scale, status);
+}
+
+bfloat16 int64_to_bfloat16(int64_t a, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, 0, status);
+}
+
+bfloat16 int32_to_bfloat16(int32_t a, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, 0, status);
+}
+
+bfloat16 int16_to_bfloat16(int16_t a, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, 0, status);
+}
 
 /*
  * Unsigned Integer to float conversions
@@ -2817,6 +3004,42 @@ float64 uint16_to_float64(uint16_t a, float_status *status)
     return uint64_to_float64_scalbn(a, 0, status);
 }
 
+/*
+ * Returns the result of converting the unsigned integer `a' to the
+ * bfloat16 format.
+ */
+
+bfloat16 uint64_to_bfloat16_scalbn(uint64_t a, int scale, float_status *status)
+{
+    FloatParts pa = uint_to_float(a, scale, status);
+    return bfloat16_round_pack_canonical(pa, status);
+}
+
+bfloat16 uint32_to_bfloat16_scalbn(uint32_t a, int scale, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, scale, status);
+}
+
+bfloat16 uint16_to_bfloat16_scalbn(uint16_t a, int scale, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, scale, status);
+}
+
+bfloat16 uint64_to_bfloat16(uint64_t a, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, 0, status);
+}
+
+bfloat16 uint32_to_bfloat16(uint32_t a, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, 0, status);
+}
+
+bfloat16 uint16_to_bfloat16(uint16_t a, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, 0, status);
+}
+
 /* Float Min/Max */
 /* min() and max() functions. These can't be implemented as
  * 'compare and pick one input' because that would mishandle
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 198f954e4d..4f72665b02 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -270,6 +270,54 @@ bfloat16 bfloat16_silence_nan(bfloat16, float_status *status);
 bfloat16 bfloat16_default_nan(float_status *status);
 bfloat16 bfloat16_squash_input_denormal(bfloat16 a, float_status *status);
 
+/*----------------------------------------------------------------------------
+| Software bfloat16 conversion routines.
+*----------------------------------------------------------------------------*/
+
+bfloat16 bfloat16_round_to_int(bfloat16, float_status *status);
+bfloat16 float32_to_bfloat16(float32, float_status *status);
+float32 bfloat16_to_float32(bfloat16, float_status *status);
+bfloat16 float64_to_bfloat16(float64 a, float_status *status);
+float64 bfloat16_to_float64(bfloat16 a, float_status *status);
+
+int16_t bfloat16_to_int16_scalbn(bfloat16, int, int, float_status *status);
+int32_t bfloat16_to_int32_scalbn(bfloat16, int, int, float_status *status);
+int64_t bfloat16_to_int64_scalbn(bfloat16, int, int, float_status *status);
+
+int16_t bfloat16_to_int16(bfloat16, float_status *status);
+int32_t bfloat16_to_int32(bfloat16, float_status *status);
+int64_t bfloat16_to_int64(bfloat16, float_status *status);
+
+int16_t bfloat16_to_int16_round_to_zero(bfloat16, float_status *status);
+int32_t bfloat16_to_int32_round_to_zero(bfloat16, float_status *status);
+int64_t bfloat16_to_int64_round_to_zero(bfloat16, float_status *status);
+
+uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, int, int, float_status *status);
+uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, int, int, float_status *status);
+uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, int, int, float_status *status);
+
+uint16_t bfloat16_to_uint16(bfloat16 a, float_status *status);
+uint32_t bfloat16_to_uint32(bfloat16 a, float_status *status);
+uint64_t bfloat16_to_uint64(bfloat16 a, float_status *status);
+
+uint16_t bfloat16_to_uint16_round_to_zero(bfloat16 a, float_status *status);
+uint32_t bfloat16_to_uint32_round_to_zero(bfloat16 a, float_status *status);
+uint64_t bfloat16_to_uint64_round_to_zero(bfloat16 a, float_status *status);
+
+bfloat16 int16_to_bfloat16_scalbn(int16_t a, int, float_status *status);
+bfloat16 int32_to_bfloat16_scalbn(int32_t a, int, float_status *status);
+bfloat16 int64_to_bfloat16_scalbn(int64_t a, int, float_status *status);
+bfloat16 uint16_to_bfloat16_scalbn(uint16_t a, int, float_status *status);
+bfloat16 uint32_to_bfloat16_scalbn(uint32_t a, int, float_status *status);
+bfloat16 uint64_to_bfloat16_scalbn(uint64_t a, int, float_status *status);
+
+bfloat16 int16_to_bfloat16(int16_t a, float_status *status);
+bfloat16 int32_to_bfloat16(int32_t a, float_status *status);
+bfloat16 int64_to_bfloat16(int64_t a, float_status *status);
+bfloat16 uint16_to_bfloat16(uint16_t a, float_status *status);
+bfloat16 uint32_to_bfloat16(uint32_t a, float_status *status);
+bfloat16 uint64_to_bfloat16(uint64_t a, float_status *status);
+
 static inline bool float16_is_any_nan(float16 a)
 {
     return ((float16_val(a) & ~0x8000) > 0x7c00);
-- 
2.23.0


