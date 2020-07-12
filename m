Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25041C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 23:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38CC20720
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 23:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38CC20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1julgA-0000CS-AU
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 19:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1julf9-00071U-L4
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 19:45:39 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1julf6-0007FR-SE
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 19:45:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1599363|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0812999-0.000950342-0.91775;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03302; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---.I0oni3i_1594597526; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I0oni3i_1594597526) by smtp.aliyun-inc.com(10.147.40.7);
 Mon, 13 Jul 2020 07:45:28 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 4/8] fpu/softfloat: add pack and unpack interfaces for
 bfloat16
Date: Mon, 13 Jul 2020 07:45:17 +0800
Message-Id: <20200712234521.3972-5-zhiwei_liu@c-sky.com>
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
 fpu/softfloat.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 1ef07d9160..54fc889446 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -584,6 +584,11 @@ static inline FloatParts float16_unpack_raw(float16 f)
     return unpack_raw(float16_params, f);
 }
 
+static inline FloatParts bfloat16_unpack_raw(bfloat16 f)
+{
+    return unpack_raw(bfloat16_params, f);
+}
+
 static inline FloatParts float32_unpack_raw(float32 f)
 {
     return unpack_raw(float32_params, f);
@@ -607,6 +612,11 @@ static inline float16 float16_pack_raw(FloatParts p)
     return make_float16(pack_raw(float16_params, p));
 }
 
+static inline bfloat16 bfloat16_pack_raw(FloatParts p)
+{
+    return make_bfloat16(pack_raw(bfloat16_params, p));
+}
+
 static inline float32 float32_pack_raw(FloatParts p)
 {
     return make_float32(pack_raw(float32_params, p));
@@ -824,6 +834,11 @@ static FloatParts float16_unpack_canonical(float16 f, float_status *s)
     return float16a_unpack_canonical(f, s, &float16_params);
 }
 
+static FloatParts bfloat16_unpack_canonical(bfloat16 f, float_status *s)
+{
+    return sf_canonicalize(bfloat16_unpack_raw(f), &bfloat16_params, s);
+}
+
 static float16 float16a_round_pack_canonical(FloatParts p, float_status *s,
                                              const FloatFmt *params)
 {
@@ -835,6 +850,11 @@ static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
     return float16a_round_pack_canonical(p, s, &float16_params);
 }
 
+static bfloat16 bfloat16_round_pack_canonical(FloatParts p, float_status *s)
+{
+    return float16a_round_pack_canonical(p, s, &bfloat16_params);
+}
+
 static FloatParts float32_unpack_canonical(float32 f, float_status *s)
 {
     return sf_canonicalize(float32_unpack_raw(f), &float32_params, s);
-- 
2.23.0


