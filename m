Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4AF20719
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBoyAtyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4AF20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YVX-00053v-H3
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUf-0003nx-LE
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:19:01 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUe-0004sy-2B
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:19:01 -0400
Received: by mail-wm1-x341.google.com with SMTP id p14so14003603wmg.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 04:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BExTigTa/EjWPG8Q5yXKlYgwozNoOz78Qwl9+pJrCfg=;
 b=WBoyAtyOTh/OT8aDzwHkqSda7j0uFDgeCKhjxgTtlEpeZbxvLUsbLS4ctTHI5gwWTo
 NGuaQuFy5gowm1C0EtkhExKsGL2Hi0eAzkuJSMmr9coYxFZVxi5Kuk3HS3YUCUZtslBu
 zQZG/3G3myQeIsQygzVq/ShQNIIwBLBwF65Qwqk60lGGOEYkxXS8TTn0LJChDvdD/vSE
 /rr7N9a6L+maAxcG0qhvy49eVoGcKpS2pbNAI/mBpCOmQ1LzZ3q2uu5bdbdSB3v8icgl
 i2VnmzgUOtLK6Slh8beJSr7JRgIlHnnt6MKJNvwmXen1ujv6c29hdL/Z0/JRDCBSfz6d
 nRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BExTigTa/EjWPG8Q5yXKlYgwozNoOz78Qwl9+pJrCfg=;
 b=Kjb9TUgOJV69AH8UtjX9qNi4UFEmm8jtxjenWe8j0gkVAmRmLzUpat2MhEZyRaQhuM
 tWmhzS2fgDvhHKXBc2P1yP6lDZwotIMWdik+x/0hgGugf/AUeZAy35pVPFN2yAJzCKa+
 YLNRnwyuYQTFOFSXo7TPVfWwJrrtba/Qn/E5HXdoVKsa5v/ULJnF6LrDCVkAINjfPuVF
 j4YMI/SrYSGZAYqb9UI+YGSuoKdKAZ2X/5gmVfWo5IxdcwjUuJnU9WGZYOrL7vhxf8Wt
 wa/Mk4DeiZgi1AjAuNqFjz3j92AHmGZi5e7uWwuYFX47NwfliSnLaa7AFFktZyfFjAOv
 p5JQ==
X-Gm-Message-State: AOAM530Ncl1RRBXYfuNKMi07zGoW2CM09E3beDdqWBRcLmE9kyxcsoJ1
 C5f8kL9xN1y47hnBPq9pnRMrZg==
X-Google-Smtp-Source: ABdhPJwdzKRJrT6EXHah4M3p7pqZcuPOohzaHAlMoNEJmmbypDU7/OXg4O9NorJw/HU5WYnEwMaz5g==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr4470024wmc.152.1596453538475; 
 Mon, 03 Aug 2020 04:18:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g3sm28013170wrb.59.2020.08.03.04.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 04:18:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/7] target/arm: Tidy up disas_arm_insn()
Date: Mon,  3 Aug 2020 12:18:46 +0100
Message-Id: <20200803111849.13368-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803111849.13368-1-peter.maydell@linaro.org>
References: <20200803111849.13368-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

The only thing left in the "legacy decoder" is the handling
of disas_xscale_insn(), and we can simplify the code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b1be4cb9d60..639fe121a2e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8342,26 +8342,18 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         return;
     }
     /* fall back to legacy decoder */
-
-    switch ((insn >> 24) & 0xf) {
-    case 0xc:
-    case 0xd:
-    case 0xe:
-    {
-        /* First check for coprocessor space used for XScale/iwMMXt insns */
-        int cpnum = (insn >> 8) & 0xf;
-
-        if (arm_dc_feature(s, ARM_FEATURE_XSCALE) && (cpnum < 2)) {
+    /* TODO: convert xscale/iwmmxt decoder to decodetree ?? */
+    if (arm_dc_feature(s, ARM_FEATURE_XSCALE)) {
+        if (((insn & 0x0c000e00) == 0x0c000000)
+            && ((insn & 0x03000000) != 0x03000000)) {
+            /* Coprocessor insn, coprocessor 0 or 1 */
             disas_xscale_insn(s, insn);
-            break;
+            return;
         }
-        /* fall through */
-    }
-    default:
-    illegal_op:
-        unallocated_encoding(s);
-        break;
     }
+
+illegal_op:
+    unallocated_encoding(s);
 }
 
 static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
-- 
2.20.1


