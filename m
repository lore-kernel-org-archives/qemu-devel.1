Received: from eggs.gnu.org ([2001:4830:134:3::10]:35160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76XS-00041Z-23
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76Oc-0007RC-Am
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76Oa-0007Nb-I5
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id u12-v6so15633251wrr.4
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 15:10:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 00:09:38 +0200
Message-Id: <20181001220942.2382-12-f4bug@amsat.org>
In-Reply-To: <20181001220942.2382-1-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/15] hw/sparc/sun4m: Replace 'empty_slot' by
 'unimplemented_device'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

The TYPE_EMPTY_SLOT and TYPE_UNIMPLEMENTED_DEVICE are identical devices,
however the later use more recent APIs and is more widely used.

Replace 'empty_slot' by 'unimplemented_device' to simplify devices code
maintenance.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 default-configs/sparc-softmmu.mak |  1 -
 hw/sparc/sun4m.c                  | 24 ++++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
index 12f97eeb20..7369b54467 100644
--- a/default-configs/sparc-softmmu.mak
+++ b/default-configs/sparc-softmmu.mak
@@ -8,7 +8,6 @@ CONFIG_ESCC=y
 CONFIG_M48T59=y
 CONFIG_PTIMER=y
 CONFIG_FDC=y
-CONFIG_EMPTY_SLOT=y
 CONFIG_PCNET_COMMON=y
 CONFIG_LANCE=y
 CONFIG_TCX=y
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 3c29b68e67..ca37acf7af 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -42,7 +42,7 @@
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
-#include "hw/empty_slot.h"
+#include "hw/misc/unimp.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "trace.h"
@@ -863,7 +863,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     ram_init(0, machine->ram_size, hwdef->max_mem);
     /* models without ECC don't trap when missing ram is accessed */
     if (!hwdef->ecc_base) {
-        empty_slot_init(machine->ram_size, hwdef->max_mem - machine->ram_size);
+        create_unimplemented_device("ecc", machine->ram_size,
+                                    hwdef->max_mem - machine->ram_size);
     }
 
     prom_init(hwdef->slavio_base, bios_name);
@@ -892,9 +893,10 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     if (hwdef->iommu_pad_base) {
         /* On the real hardware (SS-5, LX) the MMU is not padded, but aliased.
            Software shouldn't use aliased addresses, neither should it crash
-           when does. Using empty_slot instead of aliasing can help with
-           debugging such accesses */
-        empty_slot_init(hwdef->iommu_pad_base,hwdef->iommu_pad_len);
+           when does. Using the 'unimplemented device' instead of aliasing can
+           help with debugging such accesses */
+        create_unimplemented_device("iommu.alias", hwdef->iommu_pad_base,
+                                    hwdef->iommu_pad_len);
     }
 
     sparc32_dma_init(hwdef->dma_base,
@@ -944,12 +946,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     for (i = num_vsimms; i < MAX_VSIMMS; i++) {
         /* vsimm registers probed by OBP */
         if (hwdef->vsimm[i].reg_base) {
-            empty_slot_init(hwdef->vsimm[i].reg_base, 0x2000);
+            create_unimplemented_device("vsimm", hwdef->vsimm[i].reg_base,
+                                        0x2000);
         }
     }
 
     if (hwdef->sx_base) {
-        empty_slot_init(hwdef->sx_base, 0x2000);
+        create_unimplemented_device("sx", hwdef->sx_base, 0x2000);
     }
 
     nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
@@ -1012,14 +1015,15 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     if (hwdef->dbri_base) {
         /* ISDN chip with attached CS4215 audio codec */
         /* prom space */
-        empty_slot_init(hwdef->dbri_base+0x1000, 0x30);
+        create_unimplemented_device("dbri.prom", hwdef->dbri_base + 0x1000,
+                                    0x30);
         /* reg space */
-        empty_slot_init(hwdef->dbri_base+0x10000, 0x100);
+        create_unimplemented_device("dbri", hwdef->dbri_base + 0x10000, 0x100);
     }
 
     if (hwdef->bpp_base) {
         /* parallel port */
-        empty_slot_init(hwdef->bpp_base, 0x20);
+        create_unimplemented_device("bpp", hwdef->bpp_base, 0x20);
     }
 
     kernel_size = sun4m_load_kernel(machine->kernel_filename,
-- 
2.19.0
