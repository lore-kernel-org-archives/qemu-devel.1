Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439E7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC1B207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC1B207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlC33-0004W4-9S
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlC1j-0001wr-Rf; Tue, 16 Jun 2020 09:53:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:36199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlC1h-0002PI-4f; Tue, 16 Jun 2020 09:53:23 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 38D74748DE0;
 Tue, 16 Jun 2020 15:53:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B2B85748DCB; Tue, 16 Jun 2020 15:53:17 +0200 (CEST)
Message-Id: <ef4d9dc2e9241f8bd29b727e8fa32c4768718c9a.1592315226.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592315226.git.balaton@eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 02/11] mac_newworld: Allow loading binary ROM image
Date: Tue, 16 Jun 2020 15:47:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fall back to load binary ROM image if loading ELF fails. This also
moves PROM_BASE and PROM_SIZE defines to board as these are matching
the ROM size and address on this board.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Notes:
    Unlike mac_oldworld where the openbios-ppc image loads at end of ROM
    region here we only check size and assume ELF image is loaded from
    PROM_BASE, Checking the load addr here is tricky because this board is
    also be compiled both 64 and 32 bit and load_elf seems to always
    return 64 bit value so handling that could become a mess. If this is a
    problem then it's a preexisting one so should be fixed in a separate
    patch. This one just allows loading ROM binary too otherwise
    preserving previous behaviour.

 hw/ppc/mac.h          |  2 --
 hw/ppc/mac_newworld.c | 22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 6af87d1fa0..a0d9e47031 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -38,10 +38,8 @@
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
 
-#define BIOS_SIZE        (1 * MiB)
 #define NVRAM_SIZE        0x2000
 #define PROM_FILENAME    "openbios-ppc"
-#define PROM_ADDR         0xfff00000
 
 #define KERNEL_LOAD_ADDR 0x01000000
 #define KERNEL_GAP       0x00100000
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 5f3a028e6a..eec62d1e90 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -82,6 +82,8 @@
 
 #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
 
+#define PROM_BASE 0xfff00000
+#define PROM_SIZE (1 * MiB)
 
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
@@ -100,7 +102,7 @@ static void ppc_core99_reset(void *opaque)
 
     cpu_reset(CPU(cpu));
     /* 970 CPUs want to get their initial IP as part of their boot protocol */
-    cpu->env.nip = PROM_ADDR + 0x100;
+    cpu->env.nip = PROM_BASE + 0x100;
 }
 
 /* PowerPC Mac99 hardware initialisation */
@@ -153,25 +155,29 @@ static void ppc_core99_init(MachineState *machine)
     /* allocate RAM */
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
-    /* allocate and load BIOS */
-    memory_region_init_rom(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
+    /* allocate and load firmware ROM */
+    memory_region_init_rom(bios, NULL, "ppc_core99.bios", PROM_SIZE,
                            &error_fatal);
+    memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
 
-    if (bios_name == NULL)
+    if (!bios_name) {
         bios_name = PROM_FILENAME;
+    }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    memory_region_add_subregion(get_system_memory(), PROM_ADDR, bios);
-
-    /* Load OpenBIOS (ELF) */
     if (filename) {
+        /* Load OpenBIOS (ELF) */
         bios_size = load_elf(filename, NULL, NULL, NULL, NULL,
                              NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
 
+        if (bios_size <= 0) {
+            /* or load binary ROM image */
+            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
+        }
         g_free(filename);
     } else {
         bios_size = -1;
     }
-    if (bios_size < 0 || bios_size > BIOS_SIZE) {
+    if (bios_size < 0 || bios_size > PROM_SIZE) {
         error_report("could not load PowerPC bios '%s'", bios_name);
         exit(1);
     }
-- 
2.21.3


