Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D033C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FFC206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FFC206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkXOT-0000ll-91
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 14:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkXLS-0004Fo-Eh; Sun, 14 Jun 2020 14:27:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:52080)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkXLQ-0007gy-D4; Sun, 14 Jun 2020 14:27:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6C198748DDD;
 Sun, 14 Jun 2020 20:26:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C44E2748DDB; Sun, 14 Jun 2020 20:26:43 +0200 (CEST)
Message-Id: <b6cbd6aefffb0d60938ebc6ee442b2f3eb671b47.1592158400.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592158400.git.balaton@eik.bme.hu>
References: <cover.1592158400.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 9/9] mac_oldworld: Add SPD data to cover RAM
Date: Sun, 14 Jun 2020 20:13:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 14:26:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

OpenBIOS gets RAM size via fw_cfg but rhe original board firmware
detects RAM using SPD data so generate and add SDP eeproms to cover as
much RAM as possible to describe with SPD (this may be less than the
actual ram_size due to SDRAM size constraints).

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/mac_oldworld.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 53615af6b1..1f85859034 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -34,6 +34,7 @@
 #include "hw/input/adb.h"
 #include "sysemu/sysemu.h"
 #include "net/net.h"
+#include "hw/i2c/smbus_eeprom.h"
 #include "hw/isa/isa.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
@@ -137,6 +138,8 @@ static void ppc_heathrow_init(MachineState *machine)
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     void *fw_cfg;
     uint64_t tbfreq;
+    uint8_t *spd_data[3] = {};
+    I2CBus *i2c_bus;
 
     linux_boot = (kernel_filename != NULL);
 
@@ -156,8 +159,16 @@ static void ppc_heathrow_init(MachineState *machine)
                      "maximum 2047 MB", ram_size / MiB);
         exit(1);
     }
-
     memory_region_add_subregion(sysmem, 0, machine->ram);
+    for (i = 0; i < 3; i++) {
+        int size_left = ram_size - i * 512 * MiB;
+        if (size_left > 0) {
+            uint32_t s = size_left / MiB;
+            s = (s > 512 ? 512 : s);
+            s = 1U << (31 - clz32(s));
+            spd_data[i] = spd_data_generate(SDR, s * MiB);
+        }
+    }
 
     /* allocate and load firmware ROM */
     memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZE,
@@ -340,6 +351,12 @@ static void ppc_heathrow_init(MachineState *machine)
     macio_ide_init_drives(macio_ide, &hd[MAX_IDE_DEVS]);
 
     dev = DEVICE(object_resolve_path_component(OBJECT(macio), "cuda"));
+    i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
+    for (i = 0; i < 3; i++) {
+        if (spd_data[i]) {
+            smbus_eeprom_init_one(i2c_bus, 0x50 + i, spd_data[i]);
+        }
+    }
     adb_bus = qdev_get_child_bus(dev, "adb.0");
     dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
     qdev_init_nofail(dev);
-- 
2.21.3


