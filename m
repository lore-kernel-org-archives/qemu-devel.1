Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E94AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9A3207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Si18gHnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9A3207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3jO-00022K-VH
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f0-00019O-VZ
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ey-0003Up-RM
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsOFYlnZV2k2RAJQn3hv9+4xD2cCtJ++T2aifP04qWM=;
 b=Si18gHnJxYdMTReDO/U6//XTQlEUh4joZUlBj7xADo2Dzg24Rc7e7CUudXDe8sw03e2coG
 4Ob9DQe75a1n5+MG6uTyhzJdCuYhUDs/2P4k9o7McjX/YnNH5lgNp4ax7jysmCjxsi6jXN
 JGXJOCzU5505Anpt4xTRvn+k1AYu+R0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-XWN06GHnOBWFMVbX1bseNA-1; Tue, 19 May 2020 10:55:56 -0400
X-MC-Unique: XWN06GHnOBWFMVbX1bseNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45D368015CE
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:55:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B87BA1C953;
 Tue, 19 May 2020 14:55:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D116711358C5; Tue, 19 May 2020 16:55:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/55] qdev: Convert uses of qdev_create() manually
Date: Tue, 19 May 2020 16:55:05 +0200
Message-Id: <20200519145551.22836-10-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Same transformation as in the previous commit.  Manual, because
convincing Coccinelle to transform these cases is somewhere between
not worthwhile and infeasible (at least for me).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/highbank.c                   | 6 +++---
 hw/arm/sbsa-ref.c                   | 4 ++--
 hw/arm/virt.c                       | 4 ++--
 hw/block/xen-block.c                | 4 ++--
 hw/display/xlnx_dp.c                | 5 +++--
 hw/i386/pc.c                        | 4 ++--
 hw/i386/pc_sysfw.c                  | 4 ++--
 hw/pci-bridge/pci_expander_bridge.c | 4 ++--
 hw/ppc/pnv.c                        | 4 ++--
 hw/riscv/virt.c                     | 4 ++--
 hw/s390x/s390-pci-bus.c             | 4 ++--
 hw/sparc/leon3.c                    | 8 ++++----
 hw/usb/bus.c                        | 8 ++++----
 13 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 8858cf8641..1bed540011 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -316,15 +316,15 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
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
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f08320933a..6391daa23b 100644
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
     assert(size % SBSA_FLASH_SECTOR_SIZE == 0);
     assert(size / SBSA_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / SBSA_FLASH_SECTOR_SIZE);
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index be30d231f4..f691c6bde4 100644
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
     assert(size % VIRT_FLASH_SECTOR_SIZE == 0);
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
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index bdc229a51e..dd6aa172f3 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1250,7 +1250,7 @@ static void xlnx_dp_init(Object *obj)
     s->dpcd = DPCD(aux_create_slave(s->aux_bus, "dpcd"));
     object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
 
-    s->edid = I2CDDC(qdev_create(BUS(aux_get_i2c_bus(s->aux_bus)), "i2c-ddc"));
+    s->edid = I2CDDC(qdev_new("i2c-ddc"));
     i2c_set_slave_address(I2C_SLAVE(s->edid), 0x50);
     object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
 
@@ -1269,7 +1269,8 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
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
index 2abab3a27c..5d97b20980 100644
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
index 30a45e43d9..57dbf1e15a 100644
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
index 5dfb207eb3..ada503f5a3 100644
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
     assert(size % VIRT_FLASH_SECTOR_SIZE == 0);
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
2.21.1


