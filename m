Received: from eggs.gnu.org ([2001:4830:134:3::10]:41935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHg-0004NR-1p
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHa-0007im-4w
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:04 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHZ-0007iZ-Uj
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:58 -0500
Received: by mail-wm0-x244.google.com with SMTP id i186so15519645wmi.4
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:26 +0100
Message-Id: <1518523252-49106-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/48] sdhci: simplify sdhci_get_fifolen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <20180208164818.7961-10-f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h |  4 +++-
 hw/sd/sdhci.c          | 20 +++++---------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 6455648..def1c7f 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -24,6 +24,8 @@
 #ifndef SDHCI_INTERNAL_H
 #define SDHCI_INTERNAL_H
 
+#include "hw/registerfields.h"
+
 /* R/W SDMA System Address register 0x0 */
 #define SDHC_SYSAD                     0x00
 
@@ -185,7 +187,7 @@
 #define SDHC_CAN_DO_ADMA2              0x00080000
 #define SDHC_CAN_DO_ADMA1              0x00100000
 #define SDHC_64_BIT_BUS_SUPPORT        (1 << 28)
-#define SDHC_CAPAB_BLOCKSIZE(x)        (((x) >> 16) & 0x3)
+FIELD(SDHC_CAPAB, MAXBLOCKLENGTH,     16, 2);
 
 /* HWInit Maximum Current Capabilities Register 0x0 */
 #define SDHC_MAXCURR                   0x48
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 491e624..f22ed91 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -58,6 +58,11 @@
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
1.8.3.1
