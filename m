Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C12BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C7820707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdRptSFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C7820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8TJ-00039s-Bs
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LT-0007cx-5S
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LQ-00043V-9M
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:29 -0400
Received: by mail-wr1-x435.google.com with SMTP id l11so20097140wru.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=p0X61Okm864TSGJKiLA/ZVrs/QLhGGy8X0m3f0p9S/o=;
 b=vdRptSFG1ccjWwuJ0FLHubTpMzSA8yi2iofd9f8IXGlT9eXD6Oa29LB2oQE/yeAYQF
 kLVpiVNczsd1tpDpKpurkh/lULnw/gYYedxNklWhnqYDVMmSwmLMZWNUUftKCgcR5gfy
 pUyxt1n76mx65Jp7wm/zIfs9PXVDh3YMAVLGNyYNXEUUGgUjiY0cwYO/jbMLJt7XE9X3
 StWAcSDW6DKGzo9lZfKIclb3boLWs1gGWIRDMbITY6+0hB8CSiAZJjtJAkxTIXS3xcYh
 Czcf+uZQwHurIfIXshFqjXtT1cWXYKD64HZ1lLlhlY9bT+grRFSxuz8jtQJJ3fmwCoVJ
 xY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p0X61Okm864TSGJKiLA/ZVrs/QLhGGy8X0m3f0p9S/o=;
 b=WGdBgibXcPhNPalV4rHNLOADfYwb6GRIEd97urSdh+hKhZkZR+2ujzx13S6wgQylsv
 Y7uy7J7vYJxwWsz4glhcY66KKbUSjpSzoVysS83Tzrb6KRy+938Is4TnyCAQR/692VpD
 LzMf+0eD+bwQABFV8T43U4gKkGszUmPH5+YjVuopC/5DMJoI/iE3QkHxWupoLx/JM50o
 MlbcjP6z8GIFkSpNWkRR4qCSZToSXqLKSAcDjf3O/HuW2A2fTn/znVHOeSkfFDlJhTs2
 IMXe2JAdC/QyLJfli17tNI7O6dJs8ykGnI+NwcO3dku3f0El8KeObRuPRKV2UrJvSgwl
 CUZA==
X-Gm-Message-State: AOAM531qtnrJ44XoBTiqoVJLAB1RXGNp0fnQwHZIwwn1UOvzE27ahIE1
 DfUuDi572phFqcAqgCIveWNRsnXb5/vaOg==
X-Google-Smtp-Source: ABdhPJzHf0KMqvi/HoeVI3fc+4Lgfa2T2m8ohEFinZZJNZ8+qjhG7ieJhG3aPPDiQVbEsoCClqJmTQ==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr2117033wru.407.1592301446581; 
 Tue, 16 Jun 2020 02:57:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/23] hw/misc/imx6ul_ccm: Implement non writable bits in CCM
 registers
Date: Tue, 16 Jun 2020 10:56:57 +0100
Message-Id: <20200616095702.25848-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jean-Christophe Dubois <jcd@tribudubois.net>

Some bits of the CCM registers are non writable.

This was left undone in the initial commit (all bits of registers were
writable).

This patch adds the required code to protect the non writable bits.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: 20200608133508.550046-1-jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/imx6ul_ccm.c | 76 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index a2fc1d0364a..5e0661dacf7 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -19,6 +19,62 @@
 
 #include "trace.h"
 
+static const uint32_t ccm_mask[CCM_MAX] = {
+    [CCM_CCR] = 0xf01fef80,
+    [CCM_CCDR] = 0xfffeffff,
+    [CCM_CSR] = 0xffffffff,
+    [CCM_CCSR] = 0xfffffef2,
+    [CCM_CACRR] = 0xfffffff8,
+    [CCM_CBCDR] = 0xc1f8e000,
+    [CCM_CBCMR] = 0xfc03cfff,
+    [CCM_CSCMR1] = 0x80700000,
+    [CCM_CSCMR2] = 0xe01ff003,
+    [CCM_CSCDR1] = 0xfe00c780,
+    [CCM_CS1CDR] = 0xfe00fe00,
+    [CCM_CS2CDR] = 0xf8007000,
+    [CCM_CDCDR] = 0xf00fffff,
+    [CCM_CHSCCDR] = 0xfffc01ff,
+    [CCM_CSCDR2] = 0xfe0001ff,
+    [CCM_CSCDR3] = 0xffffc1ff,
+    [CCM_CDHIPR] = 0xffffffff,
+    [CCM_CTOR] = 0x00000000,
+    [CCM_CLPCR] = 0xf39ff01c,
+    [CCM_CISR] = 0xfb85ffbe,
+    [CCM_CIMR] = 0xfb85ffbf,
+    [CCM_CCOSR] = 0xfe00fe00,
+    [CCM_CGPR] = 0xfffc3fea,
+    [CCM_CCGR0] = 0x00000000,
+    [CCM_CCGR1] = 0x00000000,
+    [CCM_CCGR2] = 0x00000000,
+    [CCM_CCGR3] = 0x00000000,
+    [CCM_CCGR4] = 0x00000000,
+    [CCM_CCGR5] = 0x00000000,
+    [CCM_CCGR6] = 0x00000000,
+    [CCM_CMEOR] = 0xafffff1f,
+};
+
+static const uint32_t analog_mask[CCM_ANALOG_MAX] = {
+    [CCM_ANALOG_PLL_ARM] = 0xfff60f80,
+    [CCM_ANALOG_PLL_USB1] = 0xfffe0fbc,
+    [CCM_ANALOG_PLL_USB2] = 0xfffe0fbc,
+    [CCM_ANALOG_PLL_SYS] = 0xfffa0ffe,
+    [CCM_ANALOG_PLL_SYS_SS] = 0x00000000,
+    [CCM_ANALOG_PLL_SYS_NUM] = 0xc0000000,
+    [CCM_ANALOG_PLL_SYS_DENOM] = 0xc0000000,
+    [CCM_ANALOG_PLL_AUDIO] = 0xffe20f80,
+    [CCM_ANALOG_PLL_AUDIO_NUM] = 0xc0000000,
+    [CCM_ANALOG_PLL_AUDIO_DENOM] = 0xc0000000,
+    [CCM_ANALOG_PLL_VIDEO] = 0xffe20f80,
+    [CCM_ANALOG_PLL_VIDEO_NUM] = 0xc0000000,
+    [CCM_ANALOG_PLL_VIDEO_DENOM] = 0xc0000000,
+    [CCM_ANALOG_PLL_ENET] = 0xffc20ff0,
+    [CCM_ANALOG_PFD_480] = 0x40404040,
+    [CCM_ANALOG_PFD_528] = 0x40404040,
+    [PMU_MISC0] = 0x01fe8306,
+    [PMU_MISC1] = 0x07fcede0,
+    [PMU_MISC2] = 0x005f5f5f,
+};
+
 static const char *imx6ul_ccm_reg_name(uint32_t reg)
 {
     static char unknown[20];
@@ -596,11 +652,8 @@ static void imx6ul_ccm_write(void *opaque, hwaddr offset, uint64_t value,
 
     trace_ccm_write_reg(imx6ul_ccm_reg_name(index), (uint32_t)value);
 
-    /*
-     * We will do a better implementation later. In particular some bits
-     * cannot be written to.
-     */
-    s->ccm[index] = (uint32_t)value;
+    s->ccm[index] = (s->ccm[index] & ccm_mask[index]) |
+                           ((uint32_t)value & ~ccm_mask[index]);
 }
 
 static uint64_t imx6ul_analog_read(void *opaque, hwaddr offset, unsigned size)
@@ -737,7 +790,7 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
          * the REG_NAME register. So we change the value of the
          * REG_NAME register, setting bits passed in the value.
          */
-        s->analog[index - 1] |= value;
+        s->analog[index - 1] |= (value & ~analog_mask[index - 1]);
         break;
     case CCM_ANALOG_PLL_ARM_CLR:
     case CCM_ANALOG_PLL_USB1_CLR:
@@ -762,7 +815,7 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
          * the REG_NAME register. So we change the value of the
          * REG_NAME register, unsetting bits passed in the value.
          */
-        s->analog[index - 2] &= ~value;
+        s->analog[index - 2] &= ~(value & ~analog_mask[index - 2]);
         break;
     case CCM_ANALOG_PLL_ARM_TOG:
     case CCM_ANALOG_PLL_USB1_TOG:
@@ -787,14 +840,11 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
          * the REG_NAME register. So we change the value of the
          * REG_NAME register, toggling bits passed in the value.
          */
-        s->analog[index - 3] ^= value;
+        s->analog[index - 3] ^= (value & ~analog_mask[index - 3]);
         break;
     default:
-        /*
-         * We will do a better implementation later. In particular some bits
-         * cannot be written to.
-         */
-        s->analog[index] = value;
+        s->analog[index] = (s->analog[index] & analog_mask[index]) |
+                           (value & ~analog_mask[index]);
         break;
     }
 }
-- 
2.20.1


