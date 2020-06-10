Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A56DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A11207F9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLVLOX51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A11207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitSC-0005fl-I5
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMB-0004yv-EK
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:32:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30154
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitM8-0003oh-Ip
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgG50m3nTLeLMCd7sfe+20WbAmU/pd+auR/2Q6y6Z9E=;
 b=TLVLOX51fd7DZRaLs1LYi9BJsaxWYx9omwSs+Uzb21VrWgt+SUB3ZH645heiTHSgIm36pL
 XQjdTvMsIlKalwIbxiarGADpEoGLIRE99jvAgEk0czOsZk8VMgqdQG5CHFsPRzL7W5flQz
 j4cW+mvsLM2vad4seifgZ3iD1SiXFSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-SnU54ua1OT2BtGoXOIi93w-1; Wed, 10 Jun 2020 01:32:53 -0400
X-MC-Unique: SnU54ua1OT2BtGoXOIi93w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 939E28014D4
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 05:32:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1804718A56;
 Wed, 10 Jun 2020 05:32:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D074311384A9; Wed, 10 Jun 2020 07:32:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 10/58] qdev: Convert uses of qdev_create() manually
Date: Wed, 10 Jun 2020 07:31:59 +0200
Message-Id: <20200610053247.1583243-11-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Same transformation as in the previous commit.  Manual, because
convincing Coccinelle to transform these cases is somewhere between
not worthwhile and infeasible (at least for me).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/highbank.c                   | 26 +++++++++++++-------------
 hw/arm/sbsa-ref.c                   |  4 ++--
 hw/arm/virt.c                       |  4 ++--
 hw/block/xen-block.c                |  4 ++--
 hw/char/serial.c                    |  4 ++--
 hw/display/ati.c                    |  5 ++---
 hw/display/sm501.c                  |  5 ++---
 hw/display/xlnx_dp.c                |  5 +++--
 hw/i386/pc.c                        |  4 ++--
 hw/i386/pc_sysfw.c                  |  4 ++--
 hw/pci-bridge/pci_expander_bridge.c |  4 ++--
 hw/ppc/pnv.c                        |  4 ++--
 hw/riscv/virt.c                     |  4 ++--
 hw/s390x/s390-pci-bus.c             |  4 ++--
 hw/sparc/leon3.c                    |  8 ++++----
 hw/usb/bus.c                        |  8 ++++----
 16 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index ac9de9411e..1bed540011 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -311,20 +311,20 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
 
     switch (machine_id) {
     case CALXEDA_HIGHBANK:
-        dev = qdev_create(NULL, "l2x0");
-        qdev_init_nofail(dev);
+        dev = qdev_new("l2x0");
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, 0xfff12000);
 
-        dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
+        dev = qdev_new(TYPE_A9MPCORE_PRIV);
         break;
     case CALXEDA_MIDWAY:
-        dev = qdev_create(NULL, TYPE_A15MPCORE_PRIV);
+        dev = qdev_new(TYPE_A15MPCORE_PRIV);
         break;
     }
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     qdev_prop_set_uint32(dev, "num-irq", NIRQ_GIC);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
     for (n = 0; n < smp_cpus; n++) {
@@ -338,17 +338,17 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    dev = qdev_create(NULL, "sp804");
+    dev = qdev_new("sp804");
     qdev_prop_set_uint32(dev, "freq0", 150000000);
     qdev_prop_set_uint32(dev, "freq1", 150000000);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0xfff34000);
     sysbus_connect_irq(busdev, 0, pic[18]);
     pl011_create(0xfff36000, pic[20], serial_hd(0));
 
-    dev = qdev_create(NULL, TYPE_HIGHBANK_REGISTERS);
-    qdev_init_nofail(dev);
+    dev = qdev_new(TYPE_HIGHBANK_REGISTERS);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0xfff3c000);
 
@@ -363,18 +363,18 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
 
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], "xgmac");
-        dev = qdev_create(NULL, "xgmac");
+        dev = qdev_new("xgmac");
         qdev_set_nic_properties(dev, &nd_table[0]);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xfff50000);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[77]);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[78]);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 2, pic[79]);
 
         qemu_check_nic_model(&nd_table[1], "xgmac");
-        dev = qdev_create(NULL, "xgmac");
+        dev = qdev_new("xgmac");
         qdev_set_nic_properties(dev, &nd_table[1]);
-        qdev_init_nofail(dev);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xfff51000);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[80]);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[81]);
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index d68c5d87af..fe24567333 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -211,7 +211,7 @@ static PFlashCFI01 *sbsa_flash_create1(SBSAMachineState *sms,
      * Create a single flash device.  We use the same parameters as
      * the flash devices on the Versatile Express board.
      */
-    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", SBSA_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -243,7 +243,7 @@ static void sbsa_flash_map1(PFlashCFI01 *flash,
     assert(QEMU_IS_ALIGNED(size, SBSA_FLASH_SECTOR_SIZE));
     assert(size / SBSA_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / SBSA_FLASH_SECTOR_SIZE);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 154cd24731..ca151435ae 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -948,7 +948,7 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
      * Create a single flash device.  We use the same parameters as
      * the flash devices on the Versatile Express board.
      */
-    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -980,7 +980,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
     assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
     assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 570489d6d9..2827c90ac7 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -937,7 +937,7 @@ static void xen_block_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    xendev = XEN_DEVICE(qdev_create(BUS(xenbus), type));
+    xendev = XEN_DEVICE(qdev_new(type));
     blockdev = XEN_BLOCK_DEVICE(xendev);
 
     object_property_set_str(OBJECT(xendev), vdev, "vdev", &local_err);
@@ -965,7 +965,7 @@ static void xen_block_device_create(XenBackendInstance *backend,
     blockdev->iothread = iothread;
     blockdev->drive = drive;
 
-    object_property_set_bool(OBJECT(xendev), true, "realized", &local_err);
+    qdev_realize_and_unref(DEVICE(xendev), BUS(xenbus), &local_err);
     if (local_err) {
         error_propagate_prepend(errp, local_err,
                                 "realization of device %s failed: ",
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 7d74694587..a0cab38fb0 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1127,7 +1127,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
                          qemu_irq irq, int baudbase,
                          Chardev *chr, enum device_endian end)
 {
-    SerialMM *smm = SERIAL_MM(qdev_create(NULL, TYPE_SERIAL_MM));
+    SerialMM *smm = SERIAL_MM(qdev_new(TYPE_SERIAL_MM));
     MemoryRegion *mr;
 
     qdev_prop_set_uint8(DEVICE(smm), "regshift", regshift);
@@ -1135,7 +1135,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
     qdev_prop_set_chr(DEVICE(smm), "chardev", chr);
     qdev_set_legacy_instance_id(DEVICE(smm), base, 2);
     qdev_prop_set_uint8(DEVICE(smm), "endianness", end);
-    qdev_init_nofail(DEVICE(smm));
+    qdev_realize_and_unref(DEVICE(smm), NULL, &error_fatal);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, irq);
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(smm), 0);
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 1d9df92b96..7216f7e08f 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -933,10 +933,9 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     /* ddc, edid */
     I2CBus *i2cbus = i2c_init_bus(DEVICE(s), "ati-vga.ddc");
     bitbang_i2c_init(&s->bbi2c, i2cbus);
-    I2CSlave *i2cddc = I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC));
+    I2CSlave *i2cddc = I2C_SLAVE(qdev_new(TYPE_I2CDDC));
     i2c_set_slave_address(i2cddc, 0x50);
-    object_property_set_bool(OBJECT(i2cddc), true, "realized",
-                             &error_abort);
+    qdev_realize_and_unref(DEVICE(i2cddc), BUS(i2cbus), &error_abort);
 
     /* mmio register space */
     memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 7ff14fd474..3e62eca3de 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1831,10 +1831,9 @@ static void sm501_init(SM501State *s, DeviceState *dev,
     /* i2c */
     s->i2c_bus = i2c_init_bus(dev, "sm501.i2c");
     /* ddc */
-    I2CDDCState *ddc = I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2CDDC));
+    I2CDDCState *ddc = I2CDDC(qdev_new(TYPE_I2CDDC));
     i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
-    object_property_set_bool(OBJECT(ddc), true, "realized",
-                             &error_abort);
+    qdev_realize_and_unref(DEVICE(ddc), BUS(s->i2c_bus), &error_abort);
 
     /* mmio */
     memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_SIZE);
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 5210412e55..6e9793584a 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1252,7 +1252,7 @@ static void xlnx_dp_init(Object *obj)
     s->dpcd = DPCD(aux_create_slave(s->aux_bus, "dpcd"));
     object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
 
-    s->edid = I2CDDC(qdev_create(BUS(aux_get_i2c_bus(s->aux_bus)), "i2c-ddc"));
+    s->edid = I2CDDC(qdev_new("i2c-ddc"));
     i2c_set_slave_address(I2C_SLAVE(s->edid), 0x50);
     object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
 
@@ -1271,7 +1271,8 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     qdev_init_nofail(DEVICE(s->dpcd));
     aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
 
-    qdev_init_nofail(DEVICE(s->edid));
+    qdev_realize_and_unref(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
+                           &error_fatal);
 
     s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
     surface = qemu_console_surface(s->console);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f9d51479b1..b549d0bbfc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1204,7 +1204,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
      * when the HPET wants to take over. Thus we have to disable the latter.
      */
     if (!no_hpet && (!kvm_irqchip_in_kernel() || kvm_has_pit_state2())) {
-        hpet = qdev_try_create(NULL, TYPE_HPET);
+        hpet = qdev_try_new(TYPE_HPET);
         if (hpet) {
             /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
              * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
@@ -1215,7 +1215,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
             if (!compat) {
                 qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
             }
-            qdev_init_nofail(hpet);
+            qdev_realize_and_unref(hpet, NULL, &error_fatal);
             sysbus_mmio_map(SYS_BUS_DEVICE(hpet), 0, HPET_BASE);
 
             for (i = 0; i < GSI_NUM_PINS; i++) {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b8d8ef59eb..2e414d1934 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -85,7 +85,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
                                      const char *name,
                                      const char *alias_prop_name)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 1);
@@ -187,7 +187,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
         total_size += size;
         qdev_prop_set_uint32(DEVICE(system_flash), "num-blocks",
                              size / FLASH_SECTOR_SIZE);
-        qdev_init_nofail(DEVICE(system_flash));
+        qdev_realize_and_unref(DEVICE(system_flash), NULL, &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(system_flash), 0,
                         0x100000000ULL - total_size);
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 5da0d21061..3a395ab2f0 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -236,7 +236,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
         bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
     } else {
         bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
-        bds = qdev_create(BUS(bus), "pci-bridge");
+        bds = qdev_new("pci-bridge");
         bds->id = dev_name;
         qdev_prop_set_uint8(bds, PCI_BRIDGE_DEV_PROP_CHASSIS_NR, pxb->bus_nr);
         qdev_prop_set_bit(bds, PCI_BRIDGE_DEV_PROP_SHPC, false);
@@ -257,7 +257,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
 
     qdev_realize_and_unref(ds, NULL, &error_fatal);
     if (bds) {
-        qdev_init_nofail(bds);
+        qdev_realize_and_unref(bds, &bus->qbus, &error_fatal);
     }
 
     pci_word_test_and_set_mask(dev->config + PCI_STATUS,
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e3b6f0b884..8562af3fe0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -818,7 +818,7 @@ static void pnv_init(MachineState *machine)
     pnv->chips = g_new0(PnvChip *, pnv->num_chips);
     for (i = 0; i < pnv->num_chips; i++) {
         char chip_name[32];
-        Object *chip = OBJECT(qdev_create(NULL, chip_typename));
+        Object *chip = OBJECT(qdev_new(chip_typename));
 
         pnv->chips[i] = PNV_CHIP(chip);
 
@@ -850,7 +850,7 @@ static void pnv_init(MachineState *machine)
             object_property_set_link(chip, OBJECT(pnv), "xive-fabric",
                                      &error_abort);
         }
-        object_property_set_bool(chip, true, "realized", &error_fatal);
+        qdev_realize_and_unref(DEVICE(chip), NULL, &error_fatal);
     }
     g_free(chip_typename);
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index fa88e9118c..4970a085ca 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -80,7 +80,7 @@ static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
      * Create a single flash device.  We use the same parameters as
      * the flash devices on the ARM virt board.
      */
-    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -114,7 +114,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
     assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
     assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 7a4bfb7383..a13978bb37 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -824,7 +824,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
     Error *local_err = NULL;
     DeviceState *dev;
 
-    dev = qdev_try_create(BUS(s->bus), TYPE_S390_PCI_DEVICE);
+    dev = qdev_try_new(TYPE_S390_PCI_DEVICE);
     if (!dev) {
         error_setg(errp, "zPCI device could not be created");
         return NULL;
@@ -837,7 +837,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
                                 "zPCI device could not be created: ");
         return NULL;
     }
-    object_property_set_bool(OBJECT(dev), true, "realized", &local_err);
+    qdev_realize_and_unref(dev, BUS(s->bus), &local_err);
     if (local_err) {
         object_unparent(OBJECT(dev));
         error_propagate_prepend(errp, local_err,
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 52c0229574..b1d8f25dcc 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -213,15 +213,15 @@ static void leon3_generic_hw_init(MachineState *machine)
     reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
     qemu_register_reset(main_cpu_reset, reset_info);
 
-    ahb_pnp = GRLIB_AHB_PNP(qdev_create(NULL, TYPE_GRLIB_AHB_PNP));
-    object_property_set_bool(OBJECT(ahb_pnp), true, "realized", &error_fatal);
+    ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
+    qdev_realize_and_unref(DEVICE(ahb_pnp), NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
     grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
                             GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
                             GRLIB_CPU_AREA);
 
-    apb_pnp = GRLIB_APB_PNP(qdev_create(NULL, TYPE_GRLIB_APB_PNP));
-    object_property_set_bool(OBJECT(apb_pnp), true, "realized", &error_fatal);
+    apb_pnp = GRLIB_APB_PNP(qdev_new(TYPE_GRLIB_APB_PNP));
+    qdev_realize_and_unref(DEVICE(apb_pnp), NULL, &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
     grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
                             GRLIB_VENDOR_GAISLER, GRLIB_APBMST_DEV,
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index fa07df98a2..d28eff1b5c 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -326,21 +326,21 @@ static USBDevice *usb_try_create_simple(USBBus *bus, const char *name,
                                         Error **errp)
 {
     Error *err = NULL;
-    USBDevice *dev;
+    DeviceState *dev;
 
-    dev = USB_DEVICE(qdev_try_create(&bus->qbus, name));
+    dev = qdev_try_new(name);
     if (!dev) {
         error_setg(errp, "Failed to create USB device '%s'", name);
         return NULL;
     }
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
+    qdev_realize_and_unref(dev, &bus->qbus, &err);
     if (err) {
         error_propagate_prepend(errp, err,
                                 "Failed to initialize USB device '%s': ",
                                 name);
         return NULL;
     }
-    return dev;
+    return USB_DEVICE(dev);
 }
 
 USBDevice *usb_create_simple(USBBus *bus, const char *name)
-- 
2.26.2


