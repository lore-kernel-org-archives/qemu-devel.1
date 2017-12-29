Received: from eggs.gnu.org ([2001:4830:134:3::10]:56924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyna-0003Ea-GF
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynZ-0006KZ-Nr
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:26 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:40754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynZ-0006KI-J4
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:25 -0500
Received: by mail-qk0-x244.google.com with SMTP id q14so40814104qke.7
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:50:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:49:03 -0300
Message-Id: <20171229174933.1781-13-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 12/42] sdhci: use FIELD_DP32() macro for the
 WRITE_PROTECT flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h | 6 ++++--
 hw/sd/sdhci.c          | 8 ++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index e941bc2386..df240ea046 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -24,6 +24,8 @@
 #ifndef SDHCI_INTERNAL_H
 #define SDHCI_INTERNAL_H
 
+#include "hw/registerfields.h"
+
 /* R/W SDMA System Address register 0x0 */
 #define SDHC_SYSAD                     0x00
 
@@ -77,8 +79,8 @@
 #define SDHC_SPACE_AVAILABLE           0x00000400
 #define SDHC_DATA_AVAILABLE            0x00000800
 #define SDHC_CARD_PRESENT              0x00010000
-#define SDHC_CARD_DETECT               0x00040000
-#define SDHC_WRITE_PROTECT             0x00080000
+FIELD(SDHC_PRNSTS, CARD_DETECT,        18, 1);
+FIELD(SDHC_PRNSTS, WRITE_PROTECT,      19, 1);
 #define TRANSFERRING_DATA(x)           \
     ((x) & (SDHC_DOING_READ | SDHC_DOING_WRITE))
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ce2ef0f318..b5ecbc9969 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -159,12 +159,8 @@ static void sdhci_set_readonly(DeviceState *dev, bool level)
 {
     SDHCIState *s = (SDHCIState *)dev;
 
-    if (level) {
-        s->prnsts &= ~SDHC_WRITE_PROTECT;
-    } else {
-        /* Write enabled */
-        s->prnsts |= SDHC_WRITE_PROTECT;
-    }
+    /* Write enabled */
+    s->prnsts = FIELD_DP32(s->prnsts, SDHC_PRNSTS, WRITE_PROTECT, level);
 }
 
 static void sdhci_reset(SDHCIState *s)
-- 
2.15.1
