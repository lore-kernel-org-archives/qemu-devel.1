Received: from eggs.gnu.org ([2001:4830:134:3::10]:50703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlx-0003Dl-39
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlv-0004Qw-Ur
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlv-0004MB-NJ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlu-0003nA-O7
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:38 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:14 +0100
Message-Id: <20180608124517.29475-29-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/31] sdcard: Add a 'spec_version' property,
 default to Spec v2.00
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

As of this commit, the Spec v1 is not working, and all controllers
expect the cards to be conformant to Spec v2.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20180607180641.874-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/sd.h |  5 +++++
 hw/sd/sd.c         | 23 ++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 9bdb3c9285a..7c6ad3c8f14 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -54,6 +54,11 @@
 #define APP_CMD			(1 << 5)
 #define AKE_SEQ_ERROR		(1 << 3)
 
+enum SDPhySpecificationVersion {
+    SD_PHY_SPECv1_10_VERS     = 1,
+    SD_PHY_SPECv2_00_VERS     = 2,
+};
+
 typedef enum {
     SD_VOLTAGE_0_4V     = 400,  /* currently not supported */
     SD_VOLTAGE_1_8V     = 1800,
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 80e70dd93e2..1ae085de69a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1,9 +1,10 @@
 /*
  * SD Memory Card emulation as defined in the "SD Memory Card Physical
- * layer specification, Version 1.10."
+ * layer specification, Version 2.00."
  *
  * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
  * Copyright (c) 2007 CodeSourcery
+ * Copyright (c) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions
@@ -91,6 +92,7 @@ struct SDState {
     uint8_t sd_status[64];
 
     /* Configurable properties */
+    uint8_t spec_version;
     BlockBackend *blk;
     bool spi;
 
@@ -310,8 +312,12 @@ static void sd_ocr_powerup(void *opaque)
 
 static void sd_set_scr(SDState *sd)
 {
-    sd->scr[0] = (0 << 4)       /* SCR structure version 1.0 */
-                 | 1;           /* Spec Version 1.10 */
+    sd->scr[0] = 0 << 4;        /* SCR structure version 1.0 */
+    if (sd->spec_version == SD_PHY_SPECv1_10_VERS) {
+        sd->scr[0] |= 1;        /* Spec Version 1.10 */
+    } else {
+        sd->scr[0] |= 2;        /* Spec Version 2.00 */
+    }
     sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
                  | 0b0101;      /* 1-bit or 4-bit width bus modes */
     sd->scr[2] = 0x00;          /* Extended Security is not supported. */
@@ -2058,6 +2064,15 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
     sd->proto_name = sd->spi ? "SPI" : "SD";
 
+    switch (sd->spec_version) {
+    case SD_PHY_SPECv1_10_VERS
+     ... SD_PHY_SPECv2_00_VERS:
+        break;
+    default:
+        error_setg(errp, "Invalid SD card Spec version: %u", sd->spec_version);
+        return;
+    }
+
     if (sd->blk && blk_is_read_only(sd->blk)) {
         error_setg(errp, "Cannot use read-only drive as SD card");
         return;
@@ -2074,6 +2089,8 @@ static void sd_realize(DeviceState *dev, Error **errp)
 }
 
 static Property sd_properties[] = {
+    DEFINE_PROP_UINT8("spec_version", SDState,
+                      spec_version, SD_PHY_SPECv2_00_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     /* We do not model the chip select pin, so allow the board to select
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
-- 
2.17.1
