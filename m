Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63412C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8D220738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSIulD2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8D220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YY1-0000Rb-72
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUj-0003yT-Rp
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:19:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUi-0004tv-36
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:19:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id 3so15074186wmi.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rAgcA7IrGXsmYiY0CiUqcWe2vzUpbrPD30xAx0l2H2U=;
 b=JSIulD2qljKdNgpllREzYB2k/aKvmVbgV/Kpo50YetrD/MYDr9Q9dR/KLb99Zkotzq
 wvcTxnvypxdtXNP/M0mlJG2jeXwyhXg78f5+exeRaDxYMD9TfESVYRB10pkOrDzm4O+x
 y0VgVfkfpCXf8jAha0pr6oWkuPeHopGUObKoHPhj6gjUa0nN0EcfYrw+g7hV0EWr3p0W
 PL4wxsS/J7G6g9wS9OBDwlhJvCTy193FZk1vRVmMP+orCgRPxDSUIcEtJAG29AMKPixE
 pLJc087zuYnk1/X/qeeH3w16kyog6mCm0ZlTVhcHX2/b9tVwp0kLsIkXPadU9gSt5tCb
 y5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rAgcA7IrGXsmYiY0CiUqcWe2vzUpbrPD30xAx0l2H2U=;
 b=BTBo4Xu0GffBBUYgpKsW9mo5ciJ3/AgXaG8C5L6hnH4NcPrvWe4f1VzXs1+pQwr7xD
 z+XBDnudu++SD3ntLTKrNe7s/uM9uVrbuRFpHOwYUERL5+Jj6LZkjj6MNeoj6LzhcmL6
 3MFdgw/murjeoEo9mIKHZAHzd16uTxLwClVC6EgP653kw0mdvgsoAWY+Pms2cInTt0sp
 xQ+UcIi8YvKVsM5nKs3TpFZfX2ZZTm4c2FDwHGnIWqTxBuepUgSy1H/WXoW0m9EkTWWY
 kBPcPv1lT19tkWPa88khArGCLai8WMQWc04xFU/DmYFjxwC3KnDMjj0QtekI3lCWpsiX
 Iw7g==
X-Gm-Message-State: AOAM530V6gndu06OuEWA7Km95Broi6cGbldFe5FjWkfmOQuLVTHhhUbz
 tw+Ip4SvMW/NIAcx0VL9H/n9Npnl9e90Cw==
X-Google-Smtp-Source: ABdhPJziDo9auco+ziWBzXxAMhgs2Q1+3c9aSgFWWWqM3klSENNMdYjq3XJTtjT9SCZRxp/3zTI4vQ==
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr14913867wmf.47.1596453542606; 
 Mon, 03 Aug 2020 04:19:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g3sm28013170wrb.59.2020.08.03.04.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 04:19:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 7/7] target/arm: Remove ARCH macro
Date: Mon,  3 Aug 2020 12:18:49 +0100
Message-Id: <20200803111849.13368-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803111849.13368-1-peter.maydell@linaro.org>
References: <20200803111849.13368-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ARCH() macro was used a lot in the legacy decoder, but
there are now just two uses of it left. Since a macro which
expands out to a goto is liable to be confusing when reading
code, replace the last two uses with a simple open-coded
qeuivalent.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 59d6e43611a..37d4985d7e1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -49,8 +49,6 @@
 #define ENABLE_ARCH_7     arm_dc_feature(s, ARM_FEATURE_V7)
 #define ENABLE_ARCH_8     arm_dc_feature(s, ARM_FEATURE_V8)
 
-#define ARCH(x) do { if (!ENABLE_ARCH_##x) goto illegal_op; } while(0)
-
 #include "translate.h"
 
 #if defined(CONFIG_USER_ONLY)
@@ -7909,7 +7907,7 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
 {
     TCGv_i32 tmp;
 
-    /* For A32, ARCH(5) is checked near the start of the uncond block. */
+    /* For A32, ARM_FEATURE_V5 is checked near the start of the uncond block. */
     if (s->thumb && (a->imm & 2)) {
         return false;
     }
@@ -8275,7 +8273,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
          * choose to UNDEF. In ARMv5 and above the space is used
          * for miscellaneous unconditional instructions.
          */
-        ARCH(5);
+        if (!arm_dc_feature(s, ARM_FEATURE_V5)) {
+            unallocated_encoding(s);
+            return;
+        }
 
         /* Unconditional instructions.  */
         /* TODO: Perhaps merge these into one decodetree output file.  */
@@ -8400,7 +8401,10 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             goto illegal_op;
         }
     } else if ((insn & 0xf800e800) != 0xf000e800)  {
-        ARCH(6T2);
+        if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
+            unallocated_encoding(s);
+            return;
+        }
     }
 
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
-- 
2.20.1


