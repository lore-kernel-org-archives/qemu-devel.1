Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8489C1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8F6206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXSyFC6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8F6206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG83w-0007Sg-Lm
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 17:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jG80K-0002sQ-SX
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jG80I-0002jB-5q
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:32 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jG80H-0002ie-8K; Sun, 22 Mar 2020 17:19:29 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ng8so5158246pjb.2;
 Sun, 22 Mar 2020 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aIlmyDfdth7SAn67SG8RyrbI+6hwH3DxUxITR9eGiI8=;
 b=kXSyFC6fv2PF+3Gh0Ab8xkerrmfB18WpsaxXdiVtlLWEbnm2YX87qOuiLXsNeeBphN
 ciMrP8vzIUmqIvTKf1zLvlVdHJoBfM3g5daH07NyL89iSrEldPIOlbHE7VjFxcnPGKRA
 hwPuWYQspdmx9XAR3j+oCh7coB2UILHCRB8/3Y//eXey4ykvXHmzpK9QFcW3uLQ/PdB6
 +ATL3X/ErjTpSpculKpSE0U3tvYtKp52p39rlMyzYIyqDYIWIShhNADk2OZa7ZK9XmXP
 mXxbvn2GAty/5DdBp46+pl07VvRMz4bnWo/dPD2QS8UxvsiOu/9rKoBthu9gcas6E+wU
 CbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aIlmyDfdth7SAn67SG8RyrbI+6hwH3DxUxITR9eGiI8=;
 b=Y0UAJb6yn+sx/EV5EFloxEA+Ohmc/1Zis4jXDLKQ816E02H2jTr4xe1Rhfadyz902V
 2b1a2dOCsgOlL7HISjPF5+9+kux1QTv8GMfdmtX56faxxElB32RSGO27KP0VenmQtlY6
 mKIB6gy2+/B0/VkrST+5yEryeDxdO9KpFueDP6YmFX1bfBQHJQRLr7dWCVb2QkLOixTI
 pA6gVaQ6F/i481SYrBk+sqKMEgyR23oPegnuKZWT2dt1CiRClGoyYCAQV08/wCRk/JTD
 U1DmaJaFAMZXUt9Xm+yyqxm0pxencx0LHY9bETtqXbQ3M5TwdLZk5NzQF7eqqp42ck4Y
 ExzA==
X-Gm-Message-State: ANhLgQ31WacjRl9Z2afqox0zQYWNxijNmSZURKc3yzLK5mlWbMmsgPmo
 Rjd7jgySSgD4NWxklrQkEvg=
X-Google-Smtp-Source: ADFU+vt3AYNJRYBF9GNXWstM9RtTR5nVukWS98dE4fUxfsIwoACm73qvkdUpOX0F3q6QtpMv+NbSFw==
X-Received: by 2002:a17:90b:11d6:: with SMTP id
 gv22mr22717760pjb.31.1584911968074; 
 Sun, 22 Mar 2020 14:19:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id o15sm4748075pjp.41.2020.03.22.14.19.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 22 Mar 2020 14:19:27 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/8] hw: Move i.MX watchdog driver to hw/watchdog
Date: Sun, 22 Mar 2020 14:19:12 -0700
Message-Id: <20200322211919.11335-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322211919.11335-1-linux@roeck-us.net>
References: <20200322211919.11335-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In preparation for a full implementation, move i.MX watchdog driver
from hw/misc to hw/watchdog. While at it, add the watchdog files
to MAINTAINERS.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Instead of auto-selecting WDT_IMX2 if IMX is enabled, select it 
    explicitly for each emulation using it.
    In Makefile, fix CONFIG_WDT_IMX -> CONFIG_WDT_IMX2
    Added Philippe's Reviewed-by: tag

 MAINTAINERS                                         | 2 ++
 hw/arm/Kconfig                                      | 3 +++
 hw/misc/Makefile.objs                               | 1 -
 hw/watchdog/Kconfig                                 | 3 +++
 hw/watchdog/Makefile.objs                           | 1 +
 hw/{misc/imx2_wdt.c => watchdog/wdt_imx2.c}         | 2 +-
 include/hw/arm/fsl-imx6.h                           | 2 +-
 include/hw/arm/fsl-imx6ul.h                         | 2 +-
 include/hw/arm/fsl-imx7.h                           | 2 +-
 include/hw/{misc/imx2_wdt.h => watchdog/wdt_imx2.h} | 0
 10 files changed, 13 insertions(+), 5 deletions(-)
 rename hw/{misc/imx2_wdt.c => watchdog/wdt_imx2.c} (98%)
 rename include/hw/{misc/imx2_wdt.h => watchdog/wdt_imx2.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b46f3c6a8..1c36f36aad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -620,8 +620,10 @@ S: Odd Fixes
 F: hw/arm/fsl-imx25.c
 F: hw/arm/imx25_pdk.c
 F: hw/misc/imx25_ccm.c
+F: hw/watchdog/wdt_imx2.c
 F: include/hw/arm/fsl-imx25.h
 F: include/hw/misc/imx25_ccm.h
+F: include/hw/watchdog/wdt_imx2.h
 
 i.MX31 (kzm)
 M: Peter Chubb <peter.chubb@nicta.com.au>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 188419dc1e..adf401e827 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -374,6 +374,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_I2C
     select IMX_USBPHY
+    select WDT_IMX2
     select SDHCI
 
 config ASPEED_SOC
@@ -411,6 +412,7 @@ config FSL_IMX7
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
     select UNIMP
@@ -424,6 +426,7 @@ config FSL_IMX6UL
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select WDT_IMX2
     select SDHCI
     select UNIMP
 
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 68aae2eabb..b25181b711 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -44,7 +44,6 @@ common-obj-$(CONFIG_IMX) += imx6_ccm.o
 common-obj-$(CONFIG_IMX) += imx6ul_ccm.o
 obj-$(CONFIG_IMX) += imx6_src.o
 common-obj-$(CONFIG_IMX) += imx7_ccm.o
-common-obj-$(CONFIG_IMX) += imx2_wdt.o
 common-obj-$(CONFIG_IMX) += imx7_snvs.o
 common-obj-$(CONFIG_IMX) += imx7_gpr.o
 common-obj-$(CONFIG_IMX) += imx_rngc.o
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 2118d897c9..293209b291 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -14,3 +14,6 @@ config WDT_IB700
 
 config WDT_DIAG288
     bool
+
+config WDT_IMX2
+    bool
diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
index 3f536d1cad..631b711d86 100644
--- a/hw/watchdog/Makefile.objs
+++ b/hw/watchdog/Makefile.objs
@@ -4,3 +4,4 @@ common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
 common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
 common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
 common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
+common-obj-$(CONFIG_WDT_IMX2) += wdt_imx2.o
diff --git a/hw/misc/imx2_wdt.c b/hw/watchdog/wdt_imx2.c
similarity index 98%
rename from hw/misc/imx2_wdt.c
rename to hw/watchdog/wdt_imx2.c
index 2aedfe803a..ad1ef02e9e 100644
--- a/hw/misc/imx2_wdt.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "sysemu/watchdog.h"
 
-#include "hw/misc/imx2_wdt.h"
+#include "hw/watchdog/wdt_imx2.h"
 
 #define IMX2_WDT_WCR_WDA    BIT(5)      /* -> External Reset WDOG_B */
 #define IMX2_WDT_WCR_SRS    BIT(4)      /* -> Software Reset Signal */
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 973bcb72f7..1ebd751324 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -21,7 +21,7 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/misc/imx6_ccm.h"
 #include "hw/misc/imx6_src.h"
-#include "hw/misc/imx2_wdt.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "hw/char/imx_serial.h"
 #include "hw/timer/imx_gpt.h"
 #include "hw/timer/imx_epit.h"
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 1a0bab8daa..37c89cc5f9 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -24,7 +24,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx7_gpr.h"
 #include "hw/intc/imx_gpcv2.h"
-#include "hw/misc/imx2_wdt.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/char/imx_serial.h"
 #include "hw/timer/imx_gpt.h"
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 706aef2e7e..3a0041c4c2 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -26,7 +26,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx7_gpr.h"
 #include "hw/misc/imx6_src.h"
-#include "hw/misc/imx2_wdt.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/char/imx_serial.h"
 #include "hw/timer/imx_gpt.h"
diff --git a/include/hw/misc/imx2_wdt.h b/include/hw/watchdog/wdt_imx2.h
similarity index 100%
rename from include/hw/misc/imx2_wdt.h
rename to include/hw/watchdog/wdt_imx2.h
-- 
2.17.1


