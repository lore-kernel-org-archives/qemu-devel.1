Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AEFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BF02065C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvcHFkv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BF02065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDob-0008S0-4Q
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhDls-0003uz-Uk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:56:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55831
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhDlp-0007Tx-Dp
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591368992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XnVBIoQizwTkAs6WJnmgkcdxeXIxX54gLbsXkwplLeg=;
 b=ZvcHFkv054oHk2dXEQlfLK/MoiQ4yOE1TCDPvdq9KL3LkGTX6Xp6deajvpZcgQibTyEMiG
 RvZ3b4/eECYeieICqtD6Ckjzb1UWctjNs6CxgUPVNnQA3tfOg21mTfsUmhSjyEyf3dEX3b
 E8B4LEGZZbdGClp0tHJnVLEuVuK2iz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-sCfaJTa6MqqgOfLcmy_gNA-1; Fri, 05 Jun 2020 10:56:30 -0400
X-MC-Unique: sCfaJTa6MqqgOfLcmy_gNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81252107ACF5;
 Fri,  5 Jun 2020 14:56:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F387F60C1C;
 Fri,  5 Jun 2020 14:56:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D0D0C1138464; Fri,  5 Jun 2020 16:56:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/16] qdev: Make qdev_prop_set_drive() match the other helpers
Date: Fri,  5 Jun 2020 16:56:22 +0200
Message-Id: <20200605145625.2920920-14-armbru@redhat.com>
In-Reply-To: <20200605145625.2920920-1-armbru@redhat.com>
References: <20200605145625.2920920-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qdev_prop_set_drive() can fail.  None of the other qdev_prop_set_FOO()
can; they abort on error.

To clean up this inconsistency, rename qdev_prop_set_drive() to
qdev_prop_set_drive_err(), and create a qdev_prop_set_drive() that
aborts on error.

Coccinelle script to update callers:

    @ depends on !(file in "hw/core/qdev-properties-system.c")@
    expression dev, name, value;
    symbol error_abort;
    @@
    -    qdev_prop_set_drive(dev, name, value, &error_abort);
    +    qdev_prop_set_drive(dev, name, value);

    @@
    expression dev, name, value, errp;
    @@
    -    qdev_prop_set_drive(dev, name, value, errp);
    +    qdev_prop_set_drive_err(dev, name, value, errp);

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-properties.h        | 16 +++++++++++++---
 hw/arm/aspeed.c                     |  8 ++++----
 hw/arm/cubieboard.c                 |  2 +-
 hw/arm/exynos4210.c                 |  2 +-
 hw/arm/imx25_pdk.c                  |  2 +-
 hw/arm/mcimx6ul-evk.c               |  2 +-
 hw/arm/mcimx7d-sabre.c              |  2 +-
 hw/arm/msf2-som.c                   |  4 ++--
 hw/arm/nseries.c                    |  4 ++--
 hw/arm/orangepi.c                   |  2 +-
 hw/arm/raspi.c                      |  2 +-
 hw/arm/sabrelite.c                  |  6 +++---
 hw/arm/vexpress.c                   |  3 +--
 hw/arm/xilinx_zynq.c                |  7 ++++---
 hw/arm/xlnx-versal-virt.c           |  2 +-
 hw/arm/xlnx-zcu102.c                | 10 +++++-----
 hw/block/fdc.c                      |  6 +++---
 hw/block/nand.c                     |  2 +-
 hw/block/pflash_cfi01.c             |  6 +++---
 hw/block/pflash_cfi02.c             |  2 +-
 hw/core/qdev-properties-system.c    | 10 ++++++++--
 hw/ide/qdev.c                       |  4 ++--
 hw/m68k/q800.c                      |  3 +--
 hw/microblaze/petalogix_ml605_mmu.c |  5 +++--
 hw/ppc/pnv.c                        |  3 +--
 hw/ppc/spapr.c                      |  4 ++--
 hw/scsi/scsi-bus.c                  |  2 +-
 hw/sd/milkymist-memcard.c           |  2 +-
 hw/sd/pxa2xx_mmci.c                 |  2 +-
 hw/sd/sd.c                          |  2 +-
 hw/sd/ssi-sd.c                      |  3 ++-
 hw/xtensa/xtfpga.c                  |  3 +--
 32 files changed, 74 insertions(+), 59 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 566419f379..73fd918b03 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -230,8 +230,16 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
 
-/* Set properties between creation and init.  */
-void *qdev_get_prop_ptr(DeviceState *dev, Property *prop);
+/*
+ * Set properties between creation and realization.
+ */
+void qdev_prop_set_drive_err(DeviceState *dev, const char *name,
+                         BlockBackend *value, Error **errp);
+
+/*
+ * Set properties between creation and realization.
+ * @value must be valid.  Each property may be set at most once.
+ */
 void qdev_prop_set_bit(DeviceState *dev, const char *name, bool value);
 void qdev_prop_set_uint8(DeviceState *dev, const char *name, uint8_t value);
 void qdev_prop_set_uint16(DeviceState *dev, const char *name, uint16_t value);
@@ -242,11 +250,13 @@ void qdev_prop_set_string(DeviceState *dev, const char *name, const char *value)
 void qdev_prop_set_chr(DeviceState *dev, const char *name, Chardev *value);
 void qdev_prop_set_netdev(DeviceState *dev, const char *name, NetClientState *value);
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
-                         BlockBackend *value, Error **errp);
+                         BlockBackend *value);
 void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
                            const uint8_t *value);
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 
+void *qdev_get_prop_ptr(DeviceState *dev, Property *prop);
+
 void qdev_prop_register_global(GlobalProperty *prop);
 const GlobalProperty *qdev_find_global_prop(DeviceState *dev,
                                             const char *name);
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ee346b27c8..5ffaf86b86 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -227,8 +227,8 @@ static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
 
         fl->flash = qdev_new(flashtype);
         if (dinfo) {
-            qdev_prop_set_drive(fl->flash, "drive", blk_by_legacy_dinfo(dinfo),
-                                errp);
+            qdev_prop_set_drive_err(fl->flash, "drive",
+                                    blk_by_legacy_dinfo(dinfo), errp);
         }
         qdev_realize_and_unref(fl->flash, BUS(s->spi), &error_fatal);
 
@@ -243,8 +243,8 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo)
 
         card = qdev_new(TYPE_SD_CARD);
         if (dinfo) {
-            qdev_prop_set_drive(card, "drive", blk_by_legacy_dinfo(dinfo),
-                                &error_fatal);
+            qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                    &error_fatal);
         }
         qdev_realize_and_unref(card,
                                qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index a96c860575..5cbd115c53 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -93,7 +93,7 @@ static void cubieboard_init(MachineState *machine)
 
     /* Plug in SD card */
     carddev = qdev_new(TYPE_SD_CARD);
-    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+    qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
     qdev_realize_and_unref(carddev, bus, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), AW_A10_SDRAM_BASE,
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index b888a5c9ab..fa639806ec 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -434,7 +434,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
         di = drive_get(IF_SD, 0, n);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         carddev = qdev_new(TYPE_SD_CARD);
-        qdev_prop_set_drive(carddev, "drive", blk, &error_abort);
+        qdev_prop_set_drive(carddev, "drive", blk);
         qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
                                &error_fatal);
     }
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index af8f7f969c..1c201d0d8e 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -130,7 +130,7 @@ static void imx25_pdk_init(MachineState *machine)
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->soc.esdhc[i]), "sd-bus");
         carddev = qdev_new(TYPE_SD_CARD);
-        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
 
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 3d1d2e3c04..2f845cedfc 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -55,7 +55,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
         carddev = qdev_new(TYPE_SD_CARD);
-        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
 
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 365f8183bc..e57d52b344 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -57,7 +57,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
         carddev = qdev_new(TYPE_SD_CARD);
-        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 355966c073..f9b61c36dd 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -86,8 +86,8 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     spi_flash = qdev_new("s25sl12801");
     qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 1);
     if (dinfo) {
-        qdev_prop_set_drive(spi_flash, "drive", blk_by_legacy_dinfo(dinfo),
-                                    &error_fatal);
+        qdev_prop_set_drive_err(spi_flash, "drive",
+                                blk_by_legacy_dinfo(dinfo), &error_fatal);
     }
     qdev_realize_and_unref(spi_flash, spi_bus, &error_fatal);
     cs_line = qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 02678dda2d..428a2a2c5a 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -182,8 +182,8 @@ static void n8x0_nand_setup(struct n800_s *s)
     qdev_prop_set_int32(s->nand, "shift", 1);
     dinfo = drive_get(IF_MTD, 0, 0);
     if (dinfo) {
-        qdev_prop_set_drive(s->nand, "drive", blk_by_legacy_dinfo(dinfo),
-                            &error_fatal);
+        qdev_prop_set_drive_err(s->nand, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
     }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s->nand), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(s->nand), 0,
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 678c93033e..843dcbbd62 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -95,7 +95,7 @@ static void orangepi_init(MachineState *machine)
 
     /* Plug in SD card */
     carddev = qdev_new(TYPE_SD_CARD);
-    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+    qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
     qdev_realize_and_unref(carddev, bus, &error_fatal);
 
     /* SDRAM */
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 380978fc27..09bf02ec9c 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -298,7 +298,7 @@ static void raspi_machine_init(MachineState *machine)
         exit(1);
     }
     carddev = qdev_new(TYPE_SD_CARD);
-    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+    qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
     qdev_realize_and_unref(carddev, bus, &error_fatal);
 
     vcram_size = object_property_get_uint(OBJECT(&s->soc), "vcram-size",
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index a27e5baf60..91d8c43a7e 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -77,9 +77,9 @@ static void sabrelite_init(MachineState *machine)
 
                 flash_dev = qdev_new("sst25vf016b");
                 if (dinfo) {
-                    qdev_prop_set_drive(flash_dev, "drive",
-                                        blk_by_legacy_dinfo(dinfo),
-                                        &error_fatal);
+                    qdev_prop_set_drive_err(flash_dev, "drive",
+                                            blk_by_legacy_dinfo(dinfo),
+                                            &error_fatal);
                 }
                 qdev_realize_and_unref(flash_dev, BUS(spi_bus), &error_fatal);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 7ca5d523a4..725d024c91 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -517,8 +517,7 @@ static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
     DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
 
     if (di) {
-        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di),
-                            &error_abort);
+        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di));
     }
 
     qdev_prop_set_uint32(dev, "num-blocks",
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 4247c4dbd8..ed970273f3 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -159,8 +159,9 @@ static inline void zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
             DriveInfo *dinfo = drive_get_next(IF_MTD);
             flash_dev = qdev_new("n25q128");
             if (dinfo) {
-                qdev_prop_set_drive(flash_dev, "drive",
-                                    blk_by_legacy_dinfo(dinfo), &error_fatal);
+                qdev_prop_set_drive_err(flash_dev, "drive",
+                                        blk_by_legacy_dinfo(dinfo),
+                                        &error_fatal);
             }
             qdev_realize_and_unref(flash_dev, BUS(spi), &error_fatal);
 
@@ -290,7 +291,7 @@ static void zynq_init(MachineState *machine)
         di = drive_get_next(IF_SD);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
         carddev = qdev_new(TYPE_SD_CARD);
-        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
                                &error_fatal);
     }
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 5bcca7f95b..a3b1ce9c7c 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -465,7 +465,7 @@ static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
 
     card = qdev_new(TYPE_SD_CARD);
     object_property_add_child(OBJECT(sd), "card[*]", OBJECT(card));
-    qdev_prop_set_drive(card, "drive", blk, &error_fatal);
+    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
     qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sd), "sd-bus"),
                            &error_fatal);
 }
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index b920bcee94..77449759c6 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -143,7 +143,7 @@ static void xlnx_zcu102_init(MachineState *machine)
             exit(1);
         }
         carddev = qdev_new(TYPE_SD_CARD);
-        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
 
@@ -159,8 +159,8 @@ static void xlnx_zcu102_init(MachineState *machine)
 
         flash_dev = qdev_new("sst25wf080");
         if (dinfo) {
-            qdev_prop_set_drive(flash_dev, "drive", blk_by_legacy_dinfo(dinfo),
-                                &error_fatal);
+            qdev_prop_set_drive_err(flash_dev, "drive",
+                                    blk_by_legacy_dinfo(dinfo), &error_fatal);
         }
         qdev_realize_and_unref(flash_dev, spi_bus, &error_fatal);
 
@@ -182,8 +182,8 @@ static void xlnx_zcu102_init(MachineState *machine)
 
         flash_dev = qdev_new("n25q512a11");
         if (dinfo) {
-            qdev_prop_set_drive(flash_dev, "drive", blk_by_legacy_dinfo(dinfo),
-                                &error_fatal);
+            qdev_prop_set_drive_err(flash_dev, "drive",
+                                    blk_by_legacy_dinfo(dinfo), &error_fatal);
         }
         qdev_realize_and_unref(flash_dev, spi_bus, &error_fatal);
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 4191d5b006..5bef0b7d2f 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2505,8 +2505,8 @@ static void fdctrl_init_drives(FloppyBus *bus, DriveInfo **fds)
             dev = qdev_new("floppy");
             qdev_prop_set_uint32(dev, "unit", i);
             qdev_prop_set_enum(dev, "drive-type", FLOPPY_DRIVE_TYPE_AUTO);
-            qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(fds[i]),
-                                &error_fatal);
+            qdev_prop_set_drive_err(dev, "drive", blk_by_legacy_dinfo(fds[i]),
+                                    &error_fatal);
             qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
         }
     }
@@ -2563,7 +2563,7 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
         blk_ref(blk);
         blk_detach_dev(blk, fdc_dev);
         fdctrl->qdev_for_drives[i].blk = NULL;
-        qdev_prop_set_drive(dev, "drive", blk, &local_err);
+        qdev_prop_set_drive_err(dev, "drive", blk, &local_err);
         blk_unref(blk);
 
         if (local_err) {
diff --git a/hw/block/nand.c b/hw/block/nand.c
index 7e25681d59..654e0cb5d1 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -648,7 +648,7 @@ DeviceState *nand_init(BlockBackend *blk, int manf_id, int chip_id)
     qdev_prop_set_uint8(dev, "manufacturer_id", manf_id);
     qdev_prop_set_uint8(dev, "chip_id", chip_id);
     if (blk) {
-        qdev_prop_set_drive(dev, "drive", blk, &error_fatal);
+        qdev_prop_set_drive_err(dev, "drive", blk, &error_fatal);
     }
 
     qdev_realize(dev, NULL, &error_fatal);
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 9f0c1d61ca..cddc3a5a0c 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -962,7 +962,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
     DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
 
     if (blk) {
-        qdev_prop_set_drive(dev, "drive", blk, &error_abort);
+        qdev_prop_set_drive(dev, "drive", blk);
     }
     assert(QEMU_IS_ALIGNED(size, sector_len));
     qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
@@ -1010,8 +1010,8 @@ void pflash_cfi01_legacy_drive(PFlashCFI01 *fl, DriveInfo *dinfo)
         error_report("clashes with -machine");
         exit(1);
     }
-    qdev_prop_set_drive(DEVICE(fl), "drive",
-                        blk_by_legacy_dinfo(dinfo), &error_fatal);
+    qdev_prop_set_drive_err(DEVICE(fl), "drive", blk_by_legacy_dinfo(dinfo),
+                            &error_fatal);
     loc_pop(&loc);
 }
 
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6eb66e7bb0..b40ce2335a 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -1001,7 +1001,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
     DeviceState *dev = qdev_new(TYPE_PFLASH_CFI02);
 
     if (blk) {
-        qdev_prop_set_drive(dev, "drive", blk, &error_abort);
+        qdev_prop_set_drive(dev, "drive", blk);
     }
     assert(QEMU_IS_ALIGNED(size, sector_len));
     qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 695ebfe8b9..7eb79e98fc 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -425,8 +425,8 @@ const PropertyInfo qdev_prop_audiodev = {
     .set = set_audiodev,
 };
 
-void qdev_prop_set_drive(DeviceState *dev, const char *name,
-                         BlockBackend *value, Error **errp)
+void qdev_prop_set_drive_err(DeviceState *dev, const char *name,
+                             BlockBackend *value, Error **errp)
 {
     const char *ref = "";
 
@@ -443,6 +443,12 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
     object_property_set_str(OBJECT(dev), ref, name, errp);
 }
 
+void qdev_prop_set_drive(DeviceState *dev, const char *name,
+                         BlockBackend *value)
+{
+    qdev_prop_set_drive_err(dev, name, value, &error_abort);
+}
+
 void qdev_prop_set_chr(DeviceState *dev, const char *name,
                        Chardev *value)
 {
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index caa88526f5..784fafaaac 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -129,8 +129,8 @@ IDEDevice *ide_create_drive(IDEBus *bus, int unit, DriveInfo *drive)
 
     dev = qdev_new(drive->media_cd ? "ide-cd" : "ide-hd");
     qdev_prop_set_uint32(dev, "unit", unit);
-    qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(drive),
-                        &error_fatal);
+    qdev_prop_set_drive_err(dev, "drive", blk_by_legacy_dinfo(drive),
+                            &error_fatal);
     qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
     return DO_UPCAST(IDEDevice, qdev, dev);
 }
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 503ec54f5d..459d326af0 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -221,8 +221,7 @@ static void q800_init(MachineState *machine)
     via_dev = qdev_new(TYPE_MAC_VIA);
     dinfo = drive_get(IF_MTD, 0, 0);
     if (dinfo) {
-        qdev_prop_set_drive(via_dev, "drive", blk_by_legacy_dinfo(dinfo),
-                            &error_abort);
+        qdev_prop_set_drive(via_dev, "drive", blk_by_legacy_dinfo(dinfo));
     }
     sysbus = SYS_BUS_DEVICE(via_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 23420028f5..fff2c578ef 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -188,8 +188,9 @@ petalogix_ml605_init(MachineState *machine)
 
             dev = qdev_new("n25q128");
             if (dinfo) {
-                qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
-                                    &error_fatal);
+                qdev_prop_set_drive_err(dev, "drive",
+                                        blk_by_legacy_dinfo(dinfo),
+                                        &error_fatal);
             }
             qdev_realize_and_unref(dev, BUS(spi), &error_fatal);
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 80b4afd211..8bd03f3b10 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -730,8 +730,7 @@ static void pnv_init(MachineState *machine)
      */
     dev = qdev_new(TYPE_PNV_PNOR);
     if (pnor) {
-        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(pnor),
-                            &error_abort);
+        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(pnor));
     }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     pnv->pnor = PNV_PNOR(dev);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8d630baa5d..bd9345cdac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1716,8 +1716,8 @@ static void spapr_create_nvram(SpaprMachineState *spapr)
     DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
 
     if (dinfo) {
-        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
-                            &error_fatal);
+        qdev_prop_set_drive_err(dev, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
     }
 
     qdev_realize_and_unref(dev, &spapr->vio_bus->bus, &error_fatal);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1a7320c0af..27843bb04b 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -277,7 +277,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     if (serial && object_property_find(OBJECT(dev), "serial", NULL)) {
         qdev_prop_set_string(dev, "serial", serial);
     }
-    qdev_prop_set_drive(dev, "drive", blk, &err);
+    qdev_prop_set_drive_err(dev, "drive", blk, &err);
     if (err) {
         error_propagate(errp, err);
         object_unparent(OBJECT(dev));
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 4cfdf7b64c..1c23310715 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -279,7 +279,7 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     dinfo = drive_get_next(IF_SD);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     carddev = qdev_new(TYPE_SD_CARD);
-    qdev_prop_set_drive(carddev, "drive", blk, &err);
+    qdev_prop_set_drive_err(carddev, "drive", blk, &err);
     qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err);
     if (err) {
         error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 623be70b26..3407617afc 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -496,7 +496,7 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
 
     /* Create and plug in the sd card */
     carddev = qdev_new(TYPE_SD_CARD);
-    qdev_prop_set_drive(carddev, "drive", blk, &err);
+    qdev_prop_set_drive_err(carddev, "drive", blk, &err);
     if (err) {
         error_reportf_err(err, "failed to init SD card: ");
         return NULL;
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7070a116ea..97a9d32964 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -706,7 +706,7 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
 
     obj = object_new(TYPE_SD_CARD);
     dev = DEVICE(obj);
-    qdev_prop_set_drive(dev, "drive", blk, &err);
+    qdev_prop_set_drive_err(dev, "drive", blk, &err);
     if (err) {
         error_reportf_err(err, "sd_init failed: ");
         return NULL;
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index f98a6f3ae1..25cec2ddea 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -254,7 +254,8 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     dinfo = drive_get_next(IF_SD);
     carddev = qdev_new(TYPE_SD_CARD);
     if (dinfo) {
-        qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), &err);
+        qdev_prop_set_drive_err(carddev, "drive", blk_by_legacy_dinfo(dinfo),
+                                &err);
         if (err) {
             goto fail;
         }
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 5d0834c1d9..10de15855a 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -173,8 +173,7 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
     SysBusDevice *s;
     DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
 
-    qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
-                        &error_abort);
+    qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
     qdev_prop_set_uint32(dev, "num-blocks",
                          board->flash->size / board->flash->sector_size);
     qdev_prop_set_uint64(dev, "sector-length", board->flash->sector_size);
-- 
2.26.2


