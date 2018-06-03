Received: from eggs.gnu.org ([2001:4830:134:3::10]:59494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPGZi-0003rs-S2
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPGZh-0002v5-Px
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:08:46 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  2 Jun 2018 21:08:22 -0300
Message-Id: <20180603000827.30872-4-f4bug@amsat.org>
In-Reply-To: <20180603000827.30872-1-f4bug@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/8] sdcard: Add a 'spec_version' property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h |  4 ++++
 hw/sd/sd.c         | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 9bdb3c9285..49f22b0b89 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -54,6 +54,10 @@
 #define APP_CMD			(1 << 5)
 #define AKE_SEQ_ERROR		(1 << 3)
 
+enum SDPhySpecificationVersion {
+    SD_PHY_SPECv1_10_VERS     = 1,
+};
+
 typedef enum {
     SD_VOLTAGE_0_4V     = 400,  /* currently not supported */
     SD_VOLTAGE_1_8V     = 1800,
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 80e70dd93e..5ddd211114 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -91,6 +91,7 @@ struct SDState {
     uint8_t sd_status[64];
 
     /* Configurable properties */
+    uint8_t spec_version;
     BlockBackend *blk;
     bool spi;
 
@@ -2058,6 +2059,14 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
     sd->proto_name = sd->spi ? "SPI" : "SD";
 
+    switch (sd->spec_version) {
+    case SD_PHY_SPECv1_10_VERS:
+        break;
+    default:
+        error_setg(errp, "Invalid SD card Spec version: %u", sd->spec_version);
+        return;
+    }
+
     if (sd->blk && blk_is_read_only(sd->blk)) {
         error_setg(errp, "Cannot use read-only drive as SD card");
         return;
@@ -2074,6 +2083,8 @@ static void sd_realize(DeviceState *dev, Error **errp)
 }
 
 static Property sd_properties[] = {
+    DEFINE_PROP_UINT8("spec_version", SDState,
+                      spec_version, SD_PHY_SPECv1_10_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     /* We do not model the chip select pin, so allow the board to select
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
-- 
2.17.1
