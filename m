Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DAEC38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5BE21744
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4z1kwQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5BE21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6M8Y-0005db-3e
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7c-00042V-8p
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7a-0005ka-Kx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:40 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7a-0005k1-F3
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:38 -0500
Received: by mail-pf1-x444.google.com with SMTP id j9so6066832pfa.8
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8VBDdJ2XXe8vgr+0Pu3Ei4ErsKpoLGqHBt+iFGkJN3g=;
 b=w4z1kwQPk/JnG8w6+Gzb05842L5NXu3+w8WpW7vUfNqbqCMHrdqbpeYCQcgMnHQSJL
 w/eeRExZx6WeEVRuZUOMNoy2nBfCkUbBkGSyUOlC2RU9EvebswVAAQJVFXESkXgl9jfp
 LhVZs8CDzaQsjN/Wsy00R9Mg5uWmsSstW3lgPWAkjG6aL97/KG+caAXy1Wgh8ghLjjOD
 NcKRIiddA5BmQxl7Qjg4Lr3sl0pEbFhGFFvNn+8t0tOUV7G2qu1P8uzs33Pm9sWwp7rl
 cOu58Qv+gdNwnx6DkWFcYrJaPgZTqM9LBfr8rjd39+dykYGt02PEjR3RjykOTVsOn/WB
 coaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8VBDdJ2XXe8vgr+0Pu3Ei4ErsKpoLGqHBt+iFGkJN3g=;
 b=Q91KNZNP7PgZi3K5MjgNIE9M4UU1IsuA7BdxevVHrgwX6cgL+Tr8s1FRUsmCaFdJJA
 kVXSCUuHdCJqkKxfWVzJIJiBLNpZKU9ptWwiaEeVVhmLumqnvr2wy34Q6y8BYYzAV7nj
 +iEW+WSHb+AGg/nr8QnZ6YiRCJZRRahD+O6u6fiAsY6FtfDn8CDn35Ceq8IA0TYkXx2p
 2nzTBdZO+qHVlzE74ki8VxcFg2CIMe4Z1dMcm/HIXRQRfrWWntaBu+T7q1oyDCTeQMHr
 Mdqc4mGxcIP2Em9GrSjZUIeYu+tiJXdkC8R+5DL72HK0CL9MN4RF1ZK3uITZN8oY6Ldp
 8PxQ==
X-Gm-Message-State: APjAAAVd3dIux1Qf75H4GWybHO/4lvptCT/JTYDfXUKPt/nNcO8iXQWD
 J1UFYhoQ+H60sg8YPG8gCz08XbjdpQo=
X-Google-Smtp-Source: APXvYqz1eBvHybCPueVJTAC+W/5x6Gv2IKC1OMU1dlYTAQrWqbYKshB6SjoBmELU187830899hKDfw==
X-Received: by 2002:a63:48f:: with SMTP id 137mr8382543pge.245.1582582957128; 
 Mon, 24 Feb 2020 14:22:37 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/17] target/arm: Rename isar_feature_aa32_fpdp_v2
Date: Mon, 24 Feb 2020 14:22:17 -0800
Message-Id: <20200224222232.13807-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The old name, isar_feature_aa32_fpdp, does not reflect
that the test includes VFPv2.  We will introduce another
feature tests for VFPv3.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  4 ++--
 target/arm/translate-vfp.inc.c | 40 +++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a128d48d40..1e6eac0cd2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3470,9 +3470,9 @@ static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
 }
 
-static inline bool isar_feature_aa32_fpdp(const ARMISARegisters *id)
+static inline bool isar_feature_aa32_fpdp_v2(const ARMISARegisters *id)
 {
-    /* Return true if CPU supports double precision floating point */
+    /* Return true if CPU supports double precision floating point, VFPv2 */
     return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
 }
 
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index ba46e2557a..e94876c30c 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -206,7 +206,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -339,7 +339,7 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -425,7 +425,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -488,7 +488,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1313,7 +1313,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1462,7 +1462,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1827,7 +1827,7 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -1926,7 +1926,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2070,7 +2070,7 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2143,7 +2143,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2209,7 +2209,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2269,7 +2269,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2330,7 +2330,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2389,7 +2389,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2417,7 +2417,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2445,7 +2445,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2499,7 +2499,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2539,7 +2539,7 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2632,7 +2632,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
@@ -2728,7 +2728,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
+    if (!dc_isar_feature(aa32_fpdp_v2, s)) {
         return false;
     }
 
-- 
2.20.1


