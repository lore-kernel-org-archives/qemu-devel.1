Received: from eggs.gnu.org ([2001:4830:134:3::10]:42558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hans-erik.floryd@rt-labs.com>) id 1fqHPA-0005sZ-HQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hans-erik.floryd@rt-labs.com>) id 1fqHP4-0008FB-Pc
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:29:32 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hans-erik.floryd@rt-labs.com>)
	id 1fqHOw-00088V-Lm
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:29:24 -0400
Received: by mail-lj1-x241.google.com with SMTP id y17-v6so3497255ljy.8
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 05:29:15 -0700 (PDT)
From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Date: Thu, 16 Aug 2018 14:29:00 +0200
Message-Id: <1534422540-18815-1-git-send-email-hans-erik.floryd@rt-labs.com>
Subject: [Qemu-devel] [PATCH] sdhci: add i.MX SD Stable Clock bit
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
 hw/sd/sdhci.c          | 7 +++++++
 2 files changed, 9 insertions(+)

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
index 8f58c31..cb82782 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1651,6 +1651,13 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
 
         break;
 
+    case SDHC_PRNSTS:
+       /* Add SDSTB (SD Clock Stable) bit to PRNSTS */
+       ret = sdhci_read(opaque, offset, size) & ~ESDHC_PRNSTS_SDSTB;
+       if (s->clkcon & SDHC_CLOCK_INT_STABLE)
+          ret |= ESDHC_PRNSTS_SDSTB;
+       break;
+
     case ESDHC_DLL_CTRL:
     case ESDHC_TUNE_CTRL_STATUS:
     case ESDHC_UNDOCUMENTED_REG27:
-- 
2.7.4
