Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50228C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF169207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF169207F7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTDWP-0002oJ-LE
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 20:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTDRV-0005il-1r; Thu, 15 Oct 2020 20:17:57 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:30047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTDRM-0006vi-NX; Thu, 15 Oct 2020 20:17:56 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6FA73747623;
 Fri, 16 Oct 2020 02:17:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E954574761D; Fri, 16 Oct 2020 02:17:35 +0200 (CEST)
Message-Id: <1789fdb8ceb8894720ea3082976a0a5a0f58f1ad.1602805637.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1602805637.git.balaton@eik.bme.hu>
References: <cover.1602805637.git.balaton@eik.bme.hu>
Subject: [PATCH v8 1/5] mac_oldworld: Allow loading binary ROM image
Date: Fri, 16 Oct 2020 01:47:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:17:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

The beige G3 Power Macintosh has a 4MB firmware ROM. Fix the size of
the rom region and fall back to loading a binary image with -bios if
loading ELF image failed. This allows testing emulation with a ROM
image from real hardware as well as using an ELF OpenBIOS image.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/mac_oldworld.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 05e46ee6fe..0a40769b3e 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -59,6 +59,8 @@
 #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
 
 #define GRACKLE_BASE 0xfec00000
+#define PROM_BASE 0xffc00000
+#define PROM_SIZE (4 * MiB)
 
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
@@ -100,6 +102,7 @@ static void ppc_heathrow_init(MachineState *machine)
     SysBusDevice *s;
     DeviceState *dev, *pic_dev;
     BusState *adb_bus;
+    uint64_t bios_addr;
     int bios_size;
     unsigned int smp_cpus = machine->smp.cpus;
     uint16_t ppc_boot_device;
@@ -128,24 +131,32 @@ static void ppc_heathrow_init(MachineState *machine)
 
     memory_region_add_subregion(sysmem, 0, machine->ram);
 
-    /* allocate and load BIOS */
-    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
+    /* allocate and load firmware ROM */
+    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZE,
                            &error_fatal);
+    memory_region_add_subregion(sysmem, PROM_BASE, bios);
 
-    if (bios_name == NULL)
+    if (!bios_name) {
         bios_name = PROM_FILENAME;
+    }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    memory_region_add_subregion(sysmem, PROM_ADDR, bios);
-
-    /* Load OpenBIOS (ELF) */
     if (filename) {
-        bios_size = load_elf(filename, NULL, 0, NULL, NULL, NULL, NULL, NULL,
-                             1, PPC_ELF_MACHINE, 0, 0);
+        /* Load OpenBIOS (ELF) */
+        bios_size = load_elf(filename, NULL, NULL, NULL, NULL, &bios_addr,
+                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
+        /* Unfortunately, load_elf sign-extends reading elf32 */
+        bios_addr = (target_ulong)bios_addr;
+
+        if (bios_size <= 0) {
+            /* or load binary ROM image */
+            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
+            bios_addr = PROM_BASE;
+        }
         g_free(filename);
     } else {
         bios_size = -1;
     }
-    if (bios_size < 0 || bios_size > BIOS_SIZE) {
+    if (bios_size < 0 || bios_addr - PROM_BASE + bios_size > PROM_SIZE) {
         error_report("could not load PowerPC bios '%s'", bios_name);
         exit(1);
     }
-- 
2.21.3


