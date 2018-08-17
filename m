Received: from eggs.gnu.org ([2001:4830:134:3::10]:60883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hans-erik.floryd@rt-labs.com>) id 1fqdav-0006Wi-TG
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hans-erik.floryd@rt-labs.com>) id 1fqdas-00021x-JL
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:11:09 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:39508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hans-erik.floryd@rt-labs.com>)
	id 1fqdas-00020a-8e
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:11:06 -0400
Received: by mail-lj1-x233.google.com with SMTP id l15-v6so6180805lji.6
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 05:11:06 -0700 (PDT)
From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Date: Fri, 17 Aug 2018 14:10:43 +0200
Message-Id: <1534507843-4251-1-git-send-email-hans-erik.floryd@rt-labs.com>
Subject: [Qemu-devel] [PATCH v3] sdhci: add i.MX SD Stable Clock bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Add the ESDHC PRSSTAT_SDSTB bit, using the value of SDHC_CLOCK_INT_STABLE.
Freescale recommends checking this bit when changing clock frequency.

Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
---
 hw/sd/sdhci-internal.h | 2 ++
 hw/sd/sdhci.c          | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 756ef3f..19665fd 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -302,4 +302,6 @@ extern const VMStateDescription sdhci_vmstate;
 #define ESDHC_CTRL_4BITBUS              (0x1 << 1)
 #define ESDHC_CTRL_8BITBUS              (0x2 << 1)
 
+#define ESDHC_PRNSTS_SDSTB              (1 << 3)
+
 #endif
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 8f58c31..5201f3c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1651,6 +1651,14 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
 
         break;
 
+    case SDHC_PRNSTS:
+       /* Add SDSTB (SD Clock Stable) bit to PRNSTS */
+       ret = sdhci_read(opaque, offset, size) & ~ESDHC_PRNSTS_SDSTB;
+       if (s->clkcon & SDHC_CLOCK_INT_STABLE) {
+            ret |= ESDHC_PRNSTS_SDSTB;
+       }
+       break;
+
     case ESDHC_DLL_CTRL:
     case ESDHC_TUNE_CTRL_STATUS:
     case ESDHC_UNDOCUMENTED_REG27:
-- 
2.7.4
