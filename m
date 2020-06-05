Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7254C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960AE2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRSNE/zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960AE2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFaI-0006Nl-NZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXs-0001DG-T8
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXr-0001eA-N3
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id y20so2051309wmi.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MQ99dgcv+k3QKtrIejzQ8mBaNMmJv0ANYCt48DU3+4k=;
 b=bRSNE/zqNr92Jwwyu45oQAZFZzn/I+tqlUi8TinPXRCbMY84Cj1Ycq2C2JoySW1yfu
 WYU0oVemq1PxVIKNL3iqHNixZHozAy8aFh8YSF1RdLQImYBFqTz4/3T511c/GKo52PBM
 78bk8qr5zbb5rh9Z7Q+UiyCVTUMg8TMf+3RsVT03tSxc6ACZTEsMiTCFhpFm/t8BzepI
 uEaVo+Y+BrGtxzA+bpJjxnVh0sOsaurYk3R9pNIIlnH+//5NYo0s0d8Tk1JFwj2Wybhv
 WTkloK1daxk7Y1lwvjap+HhFRvaiTWWfHJ7GRyMaZ3prg2GPOc1Mm2WyTH84KFQgW4om
 XJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MQ99dgcv+k3QKtrIejzQ8mBaNMmJv0ANYCt48DU3+4k=;
 b=MPD1XczAA9DW4dGM60o3ALRfo7WFXd3mTN6ecsS0oZpX9bBZna7pc5MUmRjW4Tf6s0
 uJziZtH6lrSBZl7LDuoaFYdMmt8XPNSyxbdJa56UVFdgE8LZqnitiVQQy71dAV2JlKl8
 JArP6ajvtBXan8KYRkBdfz4DqxiM784p/kpZq9cMM0S/6iLISGrIdQW0RVPWz1xcYJwB
 ajzhcGLIos+bp2zvWSCbAM2yfUrrtimi8IPlJNxyjL/cG+M9re7+lg+Z3xWtk91dkF1p
 y9UjSjVOQqQDD/MrScXnlZQ9NUUaE/1sqQaFR41sl9bQ3DpP7Wc0jRCCN7UjJRHVQDQC
 5P/A==
X-Gm-Message-State: AOAM531TCKrmG8oXa3cJXPsD29UnCnPTwgVMD3IlPxvvaUD2Zut2z5Hq
 r7AZFXprV8kV2uIHd7/B66Ueh3P2k+esdA==
X-Google-Smtp-Source: ABdhPJxMY/ExT9V0XlLkthmjGprZrIuFDIXmGCZQi6o1zKWzQgPSGsH1x1XUwAF5KZNyqBbcZspzkw==
X-Received: by 2002:a1c:dfd7:: with SMTP id w206mr3507151wmg.130.1591375814042; 
 Fri, 05 Jun 2020 09:50:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/29] hw/arm/pxa2xx: Replace printf() call by qemu_log_mask()
Date: Fri,  5 Jun 2020 17:49:42 +0100
Message-Id: <20200605165007.12095-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Replace printf() calls by qemu_log_mask(), which is disabled
by default. This avoid flooding the terminal when fuzzing the
device.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200525114123.21317-3-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx.c | 66 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 336c9bad4ae..e649f8930cd 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -26,6 +26,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
+#include "qemu/log.h"
 
 static struct {
     hwaddr io_base;
@@ -112,7 +113,9 @@ static uint64_t pxa2xx_pm_read(void *opaque, hwaddr addr,
         return s->pm_regs[addr >> 2];
     default:
     fail:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -143,8 +146,9 @@ static void pxa2xx_pm_write(void *opaque, hwaddr addr,
             s->pm_regs[addr >> 2] = value;
             break;
         }
-
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
 }
@@ -185,7 +189,9 @@ static uint64_t pxa2xx_cm_read(void *opaque, hwaddr addr,
         return s->cm_regs[CCCR >> 2] | (3 << 28);
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -210,7 +216,9 @@ static void pxa2xx_cm_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
 }
@@ -415,7 +423,9 @@ static uint64_t pxa2xx_mm_read(void *opaque, hwaddr addr,
             return s->mm_regs[addr >> 2];
         /* fall through */
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -434,7 +444,9 @@ static void pxa2xx_mm_write(void *opaque, hwaddr addr,
         }
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
 }
@@ -641,7 +653,9 @@ static uint64_t pxa2xx_ssp_read(void *opaque, hwaddr addr,
     case SSACD:
         return s->ssacd;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -733,7 +747,9 @@ static void pxa2xx_ssp_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
 }
@@ -995,7 +1011,9 @@ static uint64_t pxa2xx_rtc_read(void *opaque, hwaddr addr,
         else
             return s->last_swcr;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -1101,7 +1119,9 @@ static void pxa2xx_rtc_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
     }
 }
 
@@ -1354,7 +1374,9 @@ static uint64_t pxa2xx_i2c_read(void *opaque, hwaddr addr,
             s->ibmr = 0;
         return s->ibmr;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -1427,7 +1449,9 @@ static void pxa2xx_i2c_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
     }
 }
 
@@ -1628,7 +1652,9 @@ static uint64_t pxa2xx_i2s_read(void *opaque, hwaddr addr,
         }
         return 0;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -1685,7 +1711,9 @@ static void pxa2xx_i2s_write(void *opaque, hwaddr addr,
         }
         break;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
     }
 }
 
@@ -1870,7 +1898,9 @@ static uint64_t pxa2xx_fir_read(void *opaque, hwaddr addr,
     case ICFOR:
         return s->rx_len;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -1922,7 +1952,9 @@ static void pxa2xx_fir_write(void *opaque, hwaddr addr,
     case ICFOR:
         break;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
     }
 }
 
-- 
2.20.1


