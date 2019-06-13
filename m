Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F86C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9922147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EB3n0tHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9922147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUov-0003sV-TJ
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53762)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlI-00041N-0q
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlF-0003Jj-CM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbSlF-0001u4-2s
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so21458847wrw.13
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G+NyIHdm+2ansJRDNwYfzFl09GqHtSLyhidznXncrP4=;
 b=EB3n0tHSeM8OdTtRCrXDwLIA7a5NtocaQAGVRmCKhr4M5z3CEraFBqaCqVh0TJGjte
 AC4x7VSu8/IJBL3wNKnBxSGIneUx2OE9MvwEH5aonmgt973LWwPkjyJfFRv9FL/pNwUI
 hHckFN02VP+lHIiZo+TOPNADPPji5waAfaNkW9QEhB/YkGIpB/4UlhSbGmFYqMGeTjeC
 OXGhsihjUSnE5xuYrojaF5RozvXSKz8h7qi+uAWzqH/3Fyr/10fj5LymSdLlxW0d4ycN
 /pBZYLx+7uEu68FlIIXPw3YAyFWKlJnOsA48mtxBZClRv9vrYWTwQJB8dZx2vdTHNTC5
 nBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G+NyIHdm+2ansJRDNwYfzFl09GqHtSLyhidznXncrP4=;
 b=pV2X34/STUflasNRY4wcDZOlYkofzclNODavt+xIUbtZmo9cVN9EpSY3WDzlWD4Xtk
 PghxZQCMJ/jJtaroU6dBqot0IvP2qYDi0ZeAa7vTbUzS5FgYmWAkjCXMqM6Ut8jXeN8U
 bSnGxcN8OixSOOmfHPoup8D60fj5Y6eQp7IM2ZUUTY24B3GxmQO/N5B/EWc8BrLB2Ozg
 uXFL9ukM+gWevmXYEy8cjNQNqSmxgiq0Ang2agxnG5juIYcC77s64rn6La0h944+cqbj
 0HyvWbNcCfI+PLzzaV9QoDEMU+0f2WRoyT+BKO74tj61aplm28bN3g47Q96HOsyvUX0y
 yokQ==
X-Gm-Message-State: APjAAAVq8mCrZWM0OMoVcb7LNf2rgoeax2nwRvkO7iVbkrBWgwQvh1am
 E4Wagep3uWUXgi6FJRUAfemg3jU3CW4vNA==
X-Google-Smtp-Source: APXvYqz+APxGqi0dqRcvvDJLihGu9IJ7ca5IV1mDcd1rugZMQIUQ7VZhDjPjDrVyWlOSooO2BVTzGA==
X-Received: by 2002:a5d:6acd:: with SMTP id u13mr14515369wrw.154.1560443960508; 
 Thu, 13 Jun 2019 09:39:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f197sm358747wme.39.2019.06.13.09.39.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 09:39:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:39:06 +0100
Message-Id: <20190613163917.28589-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613163917.28589-1-peter.maydell@linaro.org>
References: <20190613163917.28589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 01/12] target/arm: Move vfp_expand_imm() to
 translate.[ch]
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to use vfp_expand_imm() in the AArch32 VFP decode;
move it from the a64-only header/source file to the
AArch32 one (which is always compiled even for AArch64).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.h     |  1 -
 target/arm/translate.h         |  7 +++++++
 target/arm/translate-a64.c     | 32 --------------------------------
 target/arm/translate-vfp.inc.c | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 9569bc5963d..9ab40872d85 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -39,7 +39,6 @@ void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v);
 TCGv_ptr get_fpstatus_ptr(bool);
 bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
                             unsigned int imms, unsigned int immr);
-uint64_t vfp_expand_imm(int size, uint8_t imm8);
 bool sve_access_check(DisasContext *s);
 
 /* We should have at some point before trying to access an FP register
diff --git a/target/arm/translate.h b/target/arm/translate.h
index dc06dce7675..bc1617809da 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -237,6 +237,13 @@ static inline void gen_ss_advance(DisasContext *s)
     }
 }
 
+/*
+ * Given a VFP floating point constant encoded into an 8 bit immediate in an
+ * instruction, expand it to the actual constant value of the specified
+ * size, as per the VFPExpandImm() pseudocode in the Arm ARM.
+ */
+uint64_t vfp_expand_imm(int size, uint8_t imm8);
+
 /* Vector operations shared between ARM and AArch64.  */
 extern const GVecGen3 mla_op[4];
 extern const GVecGen3 mls_op[4];
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ae739f65756..97f4164fbbc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6380,38 +6380,6 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* The imm8 encodes the sign bit, enough bits to represent an exponent in
- * the range 01....1xx to 10....0xx, and the most significant 4 bits of
- * the mantissa; see VFPExpandImm() in the v8 ARM ARM.
- */
-uint64_t vfp_expand_imm(int size, uint8_t imm8)
-{
-    uint64_t imm;
-
-    switch (size) {
-    case MO_64:
-        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
-            (extract32(imm8, 6, 1) ? 0x3fc0 : 0x4000) |
-            extract32(imm8, 0, 6);
-        imm <<= 48;
-        break;
-    case MO_32:
-        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
-            (extract32(imm8, 6, 1) ? 0x3e00 : 0x4000) |
-            (extract32(imm8, 0, 6) << 3);
-        imm <<= 16;
-        break;
-    case MO_16:
-        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
-            (extract32(imm8, 6, 1) ? 0x3000 : 0x4000) |
-            (extract32(imm8, 0, 6) << 6);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    return imm;
-}
-
 /* Floating point immediate
  *   31  30  29 28       24 23  22  21 20        13 12   10 9    5 4    0
  * +---+---+---+-----------+------+---+------------+-------+------+------+
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 709fc65374d..a66084f6e36 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -30,6 +30,39 @@
 #include "decode-vfp.inc.c"
 #include "decode-vfp-uncond.inc.c"
 
+/*
+ * The imm8 encodes the sign bit, enough bits to represent an exponent in
+ * the range 01....1xx to 10....0xx, and the most significant 4 bits of
+ * the mantissa; see VFPExpandImm() in the v8 ARM ARM.
+ */
+uint64_t vfp_expand_imm(int size, uint8_t imm8)
+{
+    uint64_t imm;
+
+    switch (size) {
+    case MO_64:
+        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
+            (extract32(imm8, 6, 1) ? 0x3fc0 : 0x4000) |
+            extract32(imm8, 0, 6);
+        imm <<= 48;
+        break;
+    case MO_32:
+        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
+            (extract32(imm8, 6, 1) ? 0x3e00 : 0x4000) |
+            (extract32(imm8, 0, 6) << 3);
+        imm <<= 16;
+        break;
+    case MO_16:
+        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
+            (extract32(imm8, 6, 1) ? 0x3000 : 0x4000) |
+            (extract32(imm8, 0, 6) << 6);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return imm;
+}
+
 /*
  * Return the offset of a 16-bit half of the specified VFP single-precision
  * register. If top is true, returns the top 16 bits; otherwise the bottom
-- 
2.20.1


