Received: from eggs.gnu.org ([2001:4830:134:3::10]:37100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUH-0003sb-CH
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUF-0005ZB-7w
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUE-0005PL-VZ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUC-00039y-5N
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:36 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:32:00 +0100
Message-Id: <20180820103212.2810-14-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 13/25] sdhci: add i.MX SD Stable Clock bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>

Add the ESDHC PRSSTAT_SDSTB bit, using the value of SDHC_CLOCK_INT_STABLE.
Freescale recommends checking this bit when changing clock frequency.

Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Message-id: 1534507843-4251-1-git-send-email-hans-erik.floryd@rt-labs.com
[PMM: fixed indentation]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci-internal.h | 2 ++
 hw/sd/sdhci.c          | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 756ef3f3c2e..19665fd4013 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -302,4 +302,6 @@ extern const VMStateDescription sdhci_vmstate;
 #define ESDHC_CTRL_4BITBUS              (0x1 << 1)
 #define ESDHC_CTRL_8BITBUS              (0x2 << 1)
 
+#define ESDHC_PRNSTS_SDSTB              (1 << 3)
+
 #endif
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 8f58c31265a..81bbf032794 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1651,6 +1651,14 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
 
         break;
 
+    case SDHC_PRNSTS:
+        /* Add SDSTB (SD Clock Stable) bit to PRNSTS */
+        ret = sdhci_read(opaque, offset, size) & ~ESDHC_PRNSTS_SDSTB;
+        if (s->clkcon & SDHC_CLOCK_INT_STABLE) {
+            ret |= ESDHC_PRNSTS_SDSTB;
+        }
+        break;
+
     case ESDHC_DLL_CTRL:
     case ESDHC_TUNE_CTRL_STATUS:
     case ESDHC_UNDOCUMENTED_REG27:
-- 
2.18.0
