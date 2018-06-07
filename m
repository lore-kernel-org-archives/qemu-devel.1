Received: from eggs.gnu.org ([2001:4830:134:3::10]:46046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzJS-00028a-QP
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzJR-0004Uh-LR
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:07:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  7 Jun 2018 15:06:39 -0300
Message-Id: <20180607180641.874-6-f4bug@amsat.org>
In-Reply-To: <20180607180641.874-1-f4bug@amsat.org>
References: <20180607180641.874-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/7] sdcard: Reflect when the Spec v3 is
 supported in the Config Register (SCR)
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/sd/sd.h | 1 +
 hw/sd/sd.c         | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 7c6ad3c8f1..b865aafc33 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -57,6 +57,7 @@
 enum SDPhySpecificationVersion {
     SD_PHY_SPECv1_10_VERS     = 1,
     SD_PHY_SPECv2_00_VERS     = 2,
+    SD_PHY_SPECv3_01_VERS     = 3,
 };
 
 typedef enum {
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3ec0f71f24..4e49a3827a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -316,11 +316,14 @@ static void sd_set_scr(SDState *sd)
     if (sd->spec_version == SD_PHY_SPECv1_10_VERS) {
         sd->scr[0] |= 1;        /* Spec Version 1.10 */
     } else {
-        sd->scr[0] |= 2;        /* Spec Version 2.00 */
+        sd->scr[0] |= 2;        /* Spec Version 2.00 or Version 3.0X */
     }
     sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
                  | 0b0101;      /* 1-bit or 4-bit width bus modes */
     sd->scr[2] = 0x00;          /* Extended Security is not supported. */
+    if (sd->spec_version >= SD_PHY_SPECv3_01_VERS) {
+        sd->scr[2] |= 1 << 7;   /* Spec Version 3.0X */
+    }
     sd->scr[3] = 0x00;
     /* reserved for manufacturer usage */
     sd->scr[4] = 0x00;
@@ -2068,7 +2071,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
     switch (sd->spec_version) {
     case SD_PHY_SPECv1_10_VERS
-     ... SD_PHY_SPECv2_00_VERS:
+     ... SD_PHY_SPECv3_01_VERS:
         break;
     default:
         error_setg(errp, "Invalid SD card Spec version: %u", sd->spec_version);
-- 
2.17.1
