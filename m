Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B262CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4B12468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iO7pGM6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4B12468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ij2-0007Ui-L3
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifG-0007aB-72
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifE-0001v1-RY
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:02 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifE-0001uT-Kw
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:00 -0500
Received: by mail-wr1-x42d.google.com with SMTP id y17so3670815wrn.6
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jvv1988l+MhveUC13kevwwKHJA6IhCtxQBKlOzO9REg=;
 b=iO7pGM6vHbpoUcRx2yCWAvXtxsR4l+11Fh4bm0GhEjJDB7fO0MV35ukOqDlIAEWN+C
 tRgD1IGgp9gSek+qahQulVpuSLrAEuuituWPdz7BEOVoYxR5d+hd80Jwv7XLhdpKdQ76
 8nMLlKY5ieXl6m+16HZWL2Fu0ZYIr1JGHGpGD/mxPLsiEY3Ydhi2lBbqephqgCg9QW3j
 soVZsQp5WVO37vHmWQJupkYQ8laknHNyvUgftHK8TH+B0gk8WFEqu8EJYqypzF9xQpOd
 tQc/bgDGTeqOkwo7Sf/1TPH4v/CF7A2VWsgGxSHRK1/LLTVWCsJeI9mtFj8hoKPZJGbm
 ly8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jvv1988l+MhveUC13kevwwKHJA6IhCtxQBKlOzO9REg=;
 b=sxUKMUp+ZCD8G5+8svLoD8AWtzIH7iJBlR2b0vKC2qOS+zrj28nahHV9aqf83HEJ1u
 RatO4KMrsmrN2B0+oy8Y0JlrrV/P6T1YG/NiNxcFIVzCfrLREVVYqbLMkXDcxXSQqIwZ
 VTaJyMY1vDmJw6XVFB9zSqmQ0Cv2IHHW8ie+LkmlhpYNEneOi8C3c+k8N+AazP+MM4tQ
 HqCvyJanbfU5bYzMXDmOGtmJKXnPem2QwrSOOKFq28ZFfmVlhjZa4mh/rlQNcE4VyD0+
 BeD3XxwCwsOcpdZMlifrBrlEngR2V1r6+EuXcTVPW5h2rNKDkrBw8H4Vp8YCAI4+9CbY
 ULEA==
X-Gm-Message-State: APjAAAUn7fjpbYPICV/UbJHkIIIDcDz+aUDQl0xgKklpjRRt1QIaFiMI
 EFK+yj46hIH7p2kY+JCg93Bhb7iaXVqTiw==
X-Google-Smtp-Source: APXvYqzM7uROXKdlxY8Pczv1StD86gWuHdFMz4bPNrX3XcmXSJxMlUz7W2kypPrOKGx3Zx7ZbIQR3g==
X-Received: by 2002:adf:f012:: with SMTP id j18mr5550390wro.314.1582907939349; 
 Fri, 28 Feb 2020 08:38:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/33] target/arm: Replace ARM_FEATURE_VFP4 with
 isar_feature_aa32_simdfmac
Date: Fri, 28 Feb 2020 16:38:21 +0000
Message-Id: <20200228163840.23585-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

All remaining tests for VFP4 are for fused multiply-add insns.

Since the MVFR1 field is used for both VFP and NEON, move its adjustment
from the !has_neon block to the (!has_vfp && !has_neon) block.

Test for vfp of the appropraite width alongside the test for simdfmac
within translate-vfp.inc.c.  Within disas_neon_data_insn, we have
already tested for ARM_FEATURE_NEON.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200224222232.13807-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               | 12 ++++++++++++
 target/arm/cpu.c               |  6 +++++-
 target/arm/translate-vfp.inc.c | 22 ++++++++++++++++++----
 target/arm/translate.c         |  2 +-
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b94d2a5ace4..b29b0eddfc3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3514,6 +3514,18 @@ static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
 }
 
+/*
+ * Note that this ID register field covers both VFP and Neon FMAC,
+ * so should usually be tested in combination with some other
+ * check that confirms the presence of whichever of VFP or Neon is
+ * relevant, to avoid accidentally enabling a Neon feature on
+ * a VFP-no-Neon core or vice-versa.
+ */
+static inline bool isar_feature_aa32_simdfmac(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr1, MVFR1, SIMDFMAC) != 0;
+}
+
 static inline bool isar_feature_aa32_vsel(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 1;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5be4c258096..dc45865c7a7 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1512,7 +1512,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
         u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
         u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
-        u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
         cpu->isar.mvfr1 = u;
 
         u = cpu->isar.mvfr2;
@@ -1535,6 +1534,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         u = cpu->isar.mvfr0;
         u = FIELD_DP32(u, MVFR0, SIMDREG, 0);
         cpu->isar.mvfr0 = u;
+
+        /* Despite the name, this field covers both VFP and Neon */
+        u = cpu->isar.mvfr1;
+        u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
+        cpu->isar.mvfr1 = u;
     }
 
     if (arm_feature(env, ARM_FEATURE_M) && !cpu->has_dsp) {
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index f88a95438fc..03ba8d7aac0 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1803,11 +1803,18 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
 
     /*
      * Present in VFPv4 only.
+     * Note that we can't rely on the SIMDFMAC check alone, because
+     * in a Neon-no-VFP core that ID register field will be non-zero.
+     */
+    if (!dc_isar_feature(aa32_simdfmac, s) ||
+        !dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+    /*
      * In v7A, UNPREDICTABLE with non-zero vector length/stride; from
      * v8A, must UNDEF. We choose to UNDEF for both v7A and v8A.
      */
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP4) ||
-        (s->vec_len != 0 || s->vec_stride != 0)) {
+    if (s->vec_len != 0 || s->vec_stride != 0) {
         return false;
     }
 
@@ -1861,11 +1868,18 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
 
     /*
      * Present in VFPv4 only.
+     * Note that we can't rely on the SIMDFMAC check alone, because
+     * in a Neon-no-VFP core that ID register field will be non-zero.
+     */
+    if (!dc_isar_feature(aa32_simdfmac, s) ||
+        !dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+    /*
      * In v7A, UNPREDICTABLE with non-zero vector length/stride; from
      * v8A, must UNDEF. We choose to UNDEF for both v7A and v8A.
      */
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP4) ||
-        (s->vec_len != 0 || s->vec_stride != 0)) {
+    if (s->vec_len != 0 || s->vec_stride != 0) {
         return false;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 79880adaad2..0489e0cdaa6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5150,7 +5150,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             break;
         case NEON_3R_VFM_VQRDMLSH:
-            if (!arm_dc_feature(s, ARM_FEATURE_VFP4)) {
+            if (!dc_isar_feature(aa32_simdfmac, s)) {
                 return 1;
             }
             break;
-- 
2.20.1


