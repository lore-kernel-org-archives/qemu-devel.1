Received: from eggs.gnu.org ([2001:4830:134:3::10]:55527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoL-0007Cg-EB
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoK-0001df-AZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dZgoK-0001cR-35
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoG-000090-94
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:06:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 18:06:16 +0100
Message-Id: <1500915978-29213-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500915978-29213-1-git-send-email-peter.maydell@linaro.org>
References: <1500915978-29213-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 2/4] fsl_imx*: Migrate ROM contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The fsl-imx* boards accidentally forgot to register the ROM memory
regions for migration.  This used to require a manual step of calling
vmstate_register_ram(), but following commits
1cfe48c1ce21..b08199c6fbea194 we can use memory_region_init_rom() to
have it do the migration for us.

This is a migration break, but the migration code currently does not
handle the case of having two RAM regions which were not registered
for migration, and so prior to this commit a migration load would
always fail with:
  "qemu-system-arm: Length mismatch: 0x4000 in != 0x18000: Invalid argument"

NB: migration appears at this point to be broken for this board
anyway -- it succeeds but the destination hangs; probably some
device in the system does not yet support migration.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1500309775-18361-1-git-send-email-peter.maydell@linaro.org
---
 hw/arm/fsl-imx25.c | 4 ++--
 hw/arm/fsl-imx31.c | 4 ++--
 hw/arm/fsl-imx6.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 8cff3c1..3b97ece 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -249,7 +249,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     }
 
     /* initialize 2 x 16 KB ROM */
-    memory_region_init_rom_nomigrate(&s->rom[0], NULL,
+    memory_region_init_rom(&s->rom[0], NULL,
                            "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -257,7 +257,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_ROM0_ADDR,
                                 &s->rom[0]);
-    memory_region_init_rom_nomigrate(&s->rom[1], NULL,
+    memory_region_init_rom(&s->rom[1], NULL,
                            "imx25.rom1", FSL_IMX25_ROM1_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 9027875..0f2ebe8 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -219,7 +219,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     }
 
     /* On a real system, the first 16k is a `secure boot rom' */
-    memory_region_init_rom_nomigrate(&s->secure_rom, NULL, "imx31.secure_rom",
+    memory_region_init_rom(&s->secure_rom, NULL, "imx31.secure_rom",
                            FSL_IMX31_SECURE_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -229,7 +229,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                 &s->secure_rom);
 
     /* There is also a 16k ROM */
-    memory_region_init_rom_nomigrate(&s->rom, NULL, "imx31.rom",
+    memory_region_init_rom(&s->rom, NULL, "imx31.rom",
                            FSL_IMX31_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 576c663..26fd214 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -399,7 +399,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                         FSL_IMX6_ENET_MAC_1588_IRQ));
 
     /* ROM memory */
-    memory_region_init_rom_nomigrate(&s->rom, NULL, "imx6.rom",
+    memory_region_init_rom(&s->rom, NULL, "imx6.rom",
                            FSL_IMX6_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -409,7 +409,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->rom);
 
     /* CAAM memory */
-    memory_region_init_rom_nomigrate(&s->caam, NULL, "imx6.caam",
+    memory_region_init_rom(&s->caam, NULL, "imx6.caam",
                            FSL_IMX6_CAAM_MEM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
-- 
2.7.4
