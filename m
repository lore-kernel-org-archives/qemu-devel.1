Received: from eggs.gnu.org ([2001:4830:134:3::10]:41890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpNc-0007pj-6W
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpNb-0003h6-BW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:00 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:42801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpNb-0003gy-6m
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:48:59 -0500
Received: by mail-qk0-x244.google.com with SMTP id f68so6420432qke.9
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:48:59 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Feb 2018 13:47:57 -0300
Message-Id: <20180208164818.7961-10-f4bug@amsat.org>
In-Reply-To: <20180208164818.7961-1-f4bug@amsat.org>
References: <20180208164818.7961-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 09/30] sdhci: simplify sdhci_get_fifolen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h |  4 +++-
 hw/sd/sdhci.c          | 20 +++++---------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index b7751c815f..577ca9da54 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -24,6 +24,8 @@
 #ifndef SDHCI_INTERNAL_H
 #define SDHCI_INTERNAL_H
 
+#include "hw/registerfields.h"
+
 /* R/W SDMA System Address register 0x0 */
 #define SDHC_SYSAD                     0x00
 
@@ -179,7 +181,7 @@
 #define SDHC_CAN_DO_ADMA2              0x00080000
 #define SDHC_CAN_DO_ADMA1              0x00100000
 #define SDHC_64_BIT_BUS_SUPPORT        (1 << 28)
-#define SDHC_CAPAB_BLOCKSIZE(x)        (((x) >> 16) & 0x3)
+FIELD(SDHC_CAPAB, MAXBLOCKLENGTH,     16, 2);
 
 /* HWInit Maximum Current Capabilities Register 0x0 */
 #define SDHC_MAXCURR                   0x48
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index da30b58723..b1bcaa6153 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -59,6 +59,11 @@
  */
 #define SDHC_CAPAB_REG_DEFAULT 0x057834b4
 
+static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
+{
+    return 1 << (9 + FIELD_EX32(s->capareg, SDHC_CAPAB, MAXBLOCKLENGTH));
+}
+
 static uint8_t sdhci_slotint(SDHCIState *s)
 {
     return (s->norintsts & s->norintsigen) || (s->errintsts & s->errintsigen) ||
@@ -1118,21 +1123,6 @@ static const MemoryRegionOps sdhci_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
-{
-    switch (SDHC_CAPAB_BLOCKSIZE(s->capareg)) {
-    case 0:
-        return 512;
-    case 1:
-        return 1024;
-    case 2:
-        return 2048;
-    default:
-        hw_error("SDHC: unsupported value for maximum block size\n");
-        return 0;
-    }
-}
-
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
     if (s->sd_spec_version != 2) {
-- 
2.16.1
