Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C95C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B77204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUTA9Iav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B77204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6LoP-0001rk-1M
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6Lh0-0006K1-7T
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:27:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6Lgu-0002wO-O8
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/5I76+c9AbTaWqM5TBnD1xMmAoU+eswzvNFJIPRJzk=;
 b=RUTA9IavW7WIZDsXdyVghM8y2l3XB0nanri32Lvbs2of2krqQ8gpu+71+X7Q37t1+v1yN4
 Hllb5j55QkcUaHkk4PMnvaQ3F6rDhkgExX7BaH+z5HmUZAUac5ilCLpZL8TgQg2PeAzrhn
 why7ND1O/w52sLyAm2nesZk+Yf3U/ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-76RfJPjjOkyYh1VBN4mS8g-1; Thu, 13 Aug 2020 18:27:18 -0400
X-MC-Unique: 76RfJPjjOkyYh1VBN4mS8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F438100CA88
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:27:17 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFA495C1A3;
 Thu, 13 Aug 2020 22:27:16 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/41] [automated] Use DECLARE_*CHECKER* when possible
 (--force mode)
Date: Thu, 13 Aug 2020 18:26:21 -0400
Message-Id: <20200813222625.243136-38-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 18:26:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Separate run of the script using the --force flag, for the cases
where the typedef wasn't found in the same header.

Generated using:

 $ ./scripts/codeconverter/converter.py --force -i \
   --pattern=TypeCheckMacro $(git grep -l '' -- '*.[ch]')

This is being done as a separate commit because it has more
potential to break the build because typedefs might be really
unavailable.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ide/ahci_internal.h              |  7 ++++---
 include/chardev/char.h              |  7 ++-----
 include/exec/memory.h               | 14 ++++----------
 include/hw/arm/omap.h               |  8 ++++----
 include/hw/boards.h                 |  8 ++------
 include/hw/i2c/i2c.h                |  3 ++-
 include/hw/i386/pc.h                |  8 ++------
 include/hw/intc/arm_gic.h           |  8 ++------
 include/hw/intc/arm_gicv3.h         |  7 ++-----
 include/hw/isa/isa.h                | 11 ++++-------
 include/hw/nvram/fw_cfg.h           |  9 ++++++---
 include/hw/pci/pci.h                | 13 ++++---------
 include/hw/pci/pci_bridge.h         |  3 ++-
 include/hw/pci/pci_host.h           |  8 ++------
 include/hw/pci/pcie_host.h          |  4 ++--
 include/hw/pci/pcie_port.h          |  6 ++++--
 include/hw/ppc/spapr.h              | 12 ++++--------
 include/hw/ppc/xics_spapr.h         |  3 ++-
 include/hw/qdev-core.h              | 10 ++++------
 include/hw/s390x/event-facility.h   | 10 ++--------
 include/hw/sysbus.h                 |  3 ++-
 include/hw/virtio/virtio-mmio.h     |  8 ++------
 include/hw/virtio/virtio.h          |  8 ++------
 include/hw/xen/xen-legacy-backend.h |  4 ++--
 include/net/filter.h                |  8 ++------
 include/sysemu/kvm_int.h            |  4 ++--
 include/ui/console.h                |  8 ++------
 hw/arm/pxa2xx.c                     |  7 ++++---
 hw/char/virtio-serial-bus.c         |  4 ++--
 hw/core/irq.c                       |  3 ++-
 hw/display/vhost-user-gpu.c         |  4 ++--
 hw/display/vmware_vga.c             |  4 ++--
 hw/dma/i8257.c                      |  4 ++--
 hw/hyperv/vmbus.c                   |  3 ++-
 hw/ide/ahci-allwinner.c             |  4 ++--
 hw/input/pckbd.c                    |  3 ++-
 hw/intc/apic.c                      |  4 ++--
 hw/intc/arm_gic_kvm.c               |  8 ++------
 hw/intc/arm_gicv3_its_kvm.c         |  7 ++-----
 hw/intc/arm_gicv3_kvm.c             |  8 ++------
 hw/intc/etraxfs_pic.c               |  4 ++--
 hw/intc/loongson_liointc.c          |  4 ++--
 hw/intc/xilinx_intc.c               |  3 ++-
 hw/isa/piix3.c                      |  4 ++--
 hw/misc/auxbus.c                    |  3 ++-
 hw/net/rocker/rocker.c              |  4 ++--
 hw/net/xilinx_ethlite.c             |  4 ++--
 hw/pci-host/pnv_phb3.c              |  4 ++--
 hw/pci-host/pnv_phb4.c              |  4 ++--
 hw/pci-host/versatile.c             |  4 ++--
 hw/pcmcia/pxa2xx.c                  |  4 ++--
 hw/scsi/mptsas.c                    |  4 ++--
 hw/sd/allwinner-sdhost.c            |  4 ++--
 hw/sd/bcm2835_sdhost.c              |  4 ++--
 hw/sd/pxa2xx_mmci.c                 |  6 ++++--
 hw/sd/sdhci.c                       |  3 ++-
 hw/ssi/ssi.c                        |  3 ++-
 hw/timer/xilinx_timer.c             |  4 ++--
 hw/vfio/pci.c                       |  3 ++-
 59 files changed, 142 insertions(+), 196 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 8c1b86021b..9ac085dad2 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -333,8 +333,8 @@ struct AHCIPCIState {
     AHCIState ahci;
 };
 
-#define ICH_AHCI(obj) \
-    OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)
+DECLARE_INSTANCE_CHECKER(AHCIPCIState, ICH_AHCI,
+                         TYPE_ICH9_AHCI)
 
 extern const VMStateDescription vmstate_ahci;
 
@@ -395,6 +395,7 @@ void ahci_uninit(AHCIState *s);
 
 void ahci_reset(AHCIState *s);
 
-#define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBUS_AHCI)
+DECLARE_INSTANCE_CHECKER(SysbusAHCIState, SYSBUS_AHCI,
+                         TYPE_SYSBUS_AHCI)
 
 #endif /* HW_IDE_AHCI_INTERNAL_H */
diff --git a/include/chardev/char.h b/include/chardev/char.h
index d91d851b33..5874de57ea 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -227,11 +227,8 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
 #define TYPE_CHARDEV "chardev"
 typedef struct ChardevClass ChardevClass;
-#define CHARDEV(obj) OBJECT_CHECK(Chardev, (obj), TYPE_CHARDEV)
-#define CHARDEV_CLASS(klass) \
-    OBJECT_CLASS_CHECK(ChardevClass, (klass), TYPE_CHARDEV)
-#define CHARDEV_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(ChardevClass, (obj), TYPE_CHARDEV)
+DECLARE_OBJ_CHECKERS(Chardev, ChardevClass,
+                     CHARDEV, TYPE_CHARDEV)
 
 #define TYPE_CHARDEV_NULL "chardev-null"
 #define TYPE_CHARDEV_MUX "chardev-mux"
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6be7072ac5..96e33f700f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -34,19 +34,13 @@
 #define MAX_PHYS_ADDR            (((hwaddr)1 << MAX_PHYS_ADDR_SPACE_BITS) - 1)
 
 #define TYPE_MEMORY_REGION "qemu:memory-region"
-#define MEMORY_REGION(obj) \
-        OBJECT_CHECK(MemoryRegion, (obj), TYPE_MEMORY_REGION)
+DECLARE_INSTANCE_CHECKER(MemoryRegion, MEMORY_REGION,
+                         TYPE_MEMORY_REGION)
 
 #define TYPE_IOMMU_MEMORY_REGION "qemu:iommu-memory-region"
 typedef struct IOMMUMemoryRegionClass IOMMUMemoryRegionClass;
-#define IOMMU_MEMORY_REGION(obj) \
-        OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_IOMMU_MEMORY_REGION)
-#define IOMMU_MEMORY_REGION_CLASS(klass) \
-        OBJECT_CLASS_CHECK(IOMMUMemoryRegionClass, (klass), \
-                         TYPE_IOMMU_MEMORY_REGION)
-#define IOMMU_MEMORY_REGION_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(IOMMUMemoryRegionClass, (obj), \
-                         TYPE_IOMMU_MEMORY_REGION)
+DECLARE_OBJ_CHECKERS(IOMMUMemoryRegion, IOMMUMemoryRegionClass,
+                     IOMMU_MEMORY_REGION, TYPE_IOMMU_MEMORY_REGION)
 
 extern bool global_dirty_log;
 
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 5eb51df8e9..0dbf1712f4 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -105,12 +105,12 @@ void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk);
 
 /* omap_gpio.c */
 #define TYPE_OMAP1_GPIO "omap-gpio"
-#define OMAP1_GPIO(obj)                                         \
-    OBJECT_CHECK(struct omap_gpif_s, (obj), TYPE_OMAP1_GPIO)
+DECLARE_INSTANCE_CHECKER(struct omap_gpif_s, OMAP1_GPIO,
+                         TYPE_OMAP1_GPIO)
 
 #define TYPE_OMAP2_GPIO "omap2-gpio"
-#define OMAP2_GPIO(obj)                                         \
-    OBJECT_CHECK(struct omap2_gpif_s, (obj), TYPE_OMAP2_GPIO)
+DECLARE_INSTANCE_CHECKER(struct omap2_gpif_s, OMAP2_GPIO,
+                         TYPE_OMAP2_GPIO)
 
 typedef struct omap_gpif_s omap_gpif;
 typedef struct omap2_gpif_s omap2_gpif;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 426ce5f625..df6c0fc5fc 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -21,12 +21,8 @@
 
 #define TYPE_MACHINE "machine"
 #undef MACHINE  /* BSD defines it and QEMU does not use it */
-#define MACHINE(obj) \
-    OBJECT_CHECK(MachineState, (obj), TYPE_MACHINE)
-#define MACHINE_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(MachineClass, (obj), TYPE_MACHINE)
-#define MACHINE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(MachineClass, (klass), TYPE_MACHINE)
+DECLARE_OBJ_CHECKERS(MachineState, MachineClass,
+                     MACHINE, TYPE_MACHINE)
 
 extern MachineState *current_machine;
 
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 164e86ee83..8afa74f42e 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -51,7 +51,8 @@ struct I2CSlave {
 };
 
 #define TYPE_I2C_BUS "i2c-bus"
-#define I2C_BUS(obj) OBJECT_CHECK(I2CBus, (obj), TYPE_I2C_BUS)
+DECLARE_INSTANCE_CHECKER(I2CBus, I2C_BUS,
+                         TYPE_I2C_BUS)
 
 typedef struct I2CNode I2CNode;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 7c90730a0a..31503345d7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -123,12 +123,8 @@ struct PCMachineClass {
 typedef struct PCMachineClass PCMachineClass;
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
-#define PC_MACHINE(obj) \
-    OBJECT_CHECK(PCMachineState, (obj), TYPE_PC_MACHINE)
-#define PC_MACHINE_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(PCMachineClass, (obj), TYPE_PC_MACHINE)
-#define PC_MACHINE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(PCMachineClass, (klass), TYPE_PC_MACHINE)
+DECLARE_OBJ_CHECKERS(PCMachineState, PCMachineClass,
+                     PC_MACHINE, TYPE_PC_MACHINE)
 
 /* ioapic.c */
 
diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index 704ef2b751..d1c1d9a906 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -74,12 +74,8 @@
 
 #define TYPE_ARM_GIC "arm_gic"
 typedef struct ARMGICClass ARMGICClass;
-#define ARM_GIC(obj) \
-     OBJECT_CHECK(GICState, (obj), TYPE_ARM_GIC)
-#define ARM_GIC_CLASS(klass) \
-     OBJECT_CLASS_CHECK(ARMGICClass, (klass), TYPE_ARM_GIC)
-#define ARM_GIC_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(ARMGICClass, (obj), TYPE_ARM_GIC)
+DECLARE_OBJ_CHECKERS(GICState, ARMGICClass,
+                     ARM_GIC, TYPE_ARM_GIC)
 
 struct ARMGICClass {
     /*< private >*/
diff --git a/include/hw/intc/arm_gicv3.h b/include/hw/intc/arm_gicv3.h
index 58e9131a33..d0c59ea5c4 100644
--- a/include/hw/intc/arm_gicv3.h
+++ b/include/hw/intc/arm_gicv3.h
@@ -17,11 +17,8 @@
 
 #define TYPE_ARM_GICV3 "arm-gicv3"
 typedef struct ARMGICv3Class ARMGICv3Class;
-#define ARM_GICV3(obj) OBJECT_CHECK(GICv3State, (obj), TYPE_ARM_GICV3)
-#define ARM_GICV3_CLASS(klass) \
-     OBJECT_CLASS_CHECK(ARMGICv3Class, (klass), TYPE_ARM_GICV3)
-#define ARM_GICV3_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(ARMGICv3Class, (obj), TYPE_ARM_GICV3)
+DECLARE_OBJ_CHECKERS(GICv3State, ARMGICv3Class,
+                     ARM_GICV3, TYPE_ARM_GICV3)
 
 struct ARMGICv3Class {
     /*< private >*/
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 491e67de99..ddb6a2d168 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -12,15 +12,12 @@
 
 #define TYPE_ISA_DEVICE "isa-device"
 typedef struct ISADeviceClass ISADeviceClass;
-#define ISA_DEVICE(obj) \
-     OBJECT_CHECK(ISADevice, (obj), TYPE_ISA_DEVICE)
-#define ISA_DEVICE_CLASS(klass) \
-     OBJECT_CLASS_CHECK(ISADeviceClass, (klass), TYPE_ISA_DEVICE)
-#define ISA_DEVICE_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(ISADeviceClass, (obj), TYPE_ISA_DEVICE)
+DECLARE_OBJ_CHECKERS(ISADevice, ISADeviceClass,
+                     ISA_DEVICE, TYPE_ISA_DEVICE)
 
 #define TYPE_ISA_BUS "ISA"
-#define ISA_BUS(obj) OBJECT_CHECK(ISABus, (obj), TYPE_ISA_BUS)
+DECLARE_INSTANCE_CHECKER(ISABus, ISA_BUS,
+                         TYPE_ISA_BUS)
 
 #define TYPE_APPLE_SMC "isa-applesmc"
 #define APPLESMC_MAX_DATA_LENGTH       32
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index f101ff7bab..f85393400c 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -12,9 +12,12 @@
 #define TYPE_FW_CFG_MEM "fw_cfg_mem"
 #define TYPE_FW_CFG_DATA_GENERATOR_INTERFACE "fw_cfg-data-generator"
 
-#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
-#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
-#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
+DECLARE_INSTANCE_CHECKER(FWCfgState, FW_CFG,
+                         TYPE_FW_CFG)
+DECLARE_INSTANCE_CHECKER(FWCfgIoState, FW_CFG_IO,
+                         TYPE_FW_CFG_IO)
+DECLARE_INSTANCE_CHECKER(FWCfgMemState, FW_CFG_MEM,
+                         TYPE_FW_CFG_MEM)
 
 typedef struct FWCfgDataGeneratorClass FWCfgDataGeneratorClass;
 DECLARE_CLASS_CHECKERS(FWCfgDataGeneratorClass, FW_CFG_DATA_GENERATOR,
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index be9e298dba..c13ae1f858 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -197,12 +197,8 @@ enum {
 
 #define TYPE_PCI_DEVICE "pci-device"
 typedef struct PCIDeviceClass PCIDeviceClass;
-#define PCI_DEVICE(obj) \
-     OBJECT_CHECK(PCIDevice, (obj), TYPE_PCI_DEVICE)
-#define PCI_DEVICE_CLASS(klass) \
-     OBJECT_CLASS_CHECK(PCIDeviceClass, (klass), TYPE_PCI_DEVICE)
-#define PCI_DEVICE_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(PCIDeviceClass, (obj), TYPE_PCI_DEVICE)
+DECLARE_OBJ_CHECKERS(PCIDevice, PCIDeviceClass,
+                     PCI_DEVICE, TYPE_PCI_DEVICE)
 
 /* Implemented by devices that can be plugged on PCI Express buses */
 #define INTERFACE_PCIE_DEVICE "pci-express-device"
@@ -399,9 +395,8 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
 
 #define TYPE_PCI_BUS "PCI"
 typedef struct PCIBusClass PCIBusClass;
-#define PCI_BUS(obj) OBJECT_CHECK(PCIBus, (obj), TYPE_PCI_BUS)
-#define PCI_BUS_CLASS(klass) OBJECT_CLASS_CHECK(PCIBusClass, (klass), TYPE_PCI_BUS)
-#define PCI_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(PCIBusClass, (obj), TYPE_PCI_BUS)
+DECLARE_OBJ_CHECKERS(PCIBus, PCIBusClass,
+                     PCI_BUS, TYPE_PCI_BUS)
 #define TYPE_PCIE_BUS "PCIE"
 
 bool pci_bus_is_express(PCIBus *bus);
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index b46d37faa8..7ab145955a 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -51,7 +51,8 @@ struct PCIBridgeWindows {
 };
 
 #define TYPE_PCI_BRIDGE "base-pci-bridge"
-#define PCI_BRIDGE(obj) OBJECT_CHECK(PCIBridge, (obj), TYPE_PCI_BRIDGE)
+DECLARE_INSTANCE_CHECKER(PCIBridge, PCI_BRIDGE,
+                         TYPE_PCI_BRIDGE)
 
 struct PCIBridge {
     /*< private >*/
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index 51ea53908f..d1fc1c3604 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -33,12 +33,8 @@
 
 #define TYPE_PCI_HOST_BRIDGE "pci-host-bridge"
 typedef struct PCIHostBridgeClass PCIHostBridgeClass;
-#define PCI_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(PCIHostState, (obj), TYPE_PCI_HOST_BRIDGE)
-#define PCI_HOST_BRIDGE_CLASS(klass) \
-     OBJECT_CLASS_CHECK(PCIHostBridgeClass, (klass), TYPE_PCI_HOST_BRIDGE)
-#define PCI_HOST_BRIDGE_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(PCIHostBridgeClass, (obj), TYPE_PCI_HOST_BRIDGE)
+DECLARE_OBJ_CHECKERS(PCIHostState, PCIHostBridgeClass,
+                     PCI_HOST_BRIDGE, TYPE_PCI_HOST_BRIDGE)
 
 struct PCIHostState {
     SysBusDevice busdev;
diff --git a/include/hw/pci/pcie_host.h b/include/hw/pci/pcie_host.h
index c7d2ae5bf4..f512646c0c 100644
--- a/include/hw/pci/pcie_host.h
+++ b/include/hw/pci/pcie_host.h
@@ -26,8 +26,8 @@
 #include "qom/object.h"
 
 #define TYPE_PCIE_HOST_BRIDGE "pcie-host-bridge"
-#define PCIE_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(PCIExpressHost, (obj), TYPE_PCIE_HOST_BRIDGE)
+DECLARE_INSTANCE_CHECKER(PCIExpressHost, PCIE_HOST_BRIDGE,
+                         TYPE_PCIE_HOST_BRIDGE)
 
 #define PCIE_HOST_MCFG_BASE "MCFG"
 #define PCIE_HOST_MCFG_SIZE "mcfg_size"
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 00ab398cb9..2463c07fa7 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -26,7 +26,8 @@
 #include "qom/object.h"
 
 #define TYPE_PCIE_PORT "pcie-port"
-#define PCIE_PORT(obj) OBJECT_CHECK(PCIEPort, (obj), TYPE_PCIE_PORT)
+DECLARE_INSTANCE_CHECKER(PCIEPort, PCIE_PORT,
+                         TYPE_PCIE_PORT)
 
 struct PCIEPort {
     /*< private >*/
@@ -40,7 +41,8 @@ struct PCIEPort {
 void pcie_port_init_reg(PCIDevice *d);
 
 #define TYPE_PCIE_SLOT "pcie-slot"
-#define PCIE_SLOT(obj) OBJECT_CHECK(PCIESlot, (obj), TYPE_PCIE_SLOT)
+DECLARE_INSTANCE_CHECKER(PCIESlot, PCIE_SLOT,
+                         TYPE_PCIE_SLOT)
 
 struct PCIESlot {
     /*< private >*/
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3b20755999..389b81ea62 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -42,12 +42,8 @@ typedef struct SpaprDimmState SpaprDimmState;
 typedef struct SpaprMachineClass SpaprMachineClass;
 
 #define TYPE_SPAPR_MACHINE      "spapr-machine"
-#define SPAPR_MACHINE(obj) \
-    OBJECT_CHECK(SpaprMachineState, (obj), TYPE_SPAPR_MACHINE)
-#define SPAPR_MACHINE_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(SpaprMachineClass, obj, TYPE_SPAPR_MACHINE)
-#define SPAPR_MACHINE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(SpaprMachineClass, klass, TYPE_SPAPR_MACHINE)
+DECLARE_OBJ_CHECKERS(SpaprMachineState, SpaprMachineClass,
+                     SPAPR_MACHINE, TYPE_SPAPR_MACHINE)
 
 typedef enum {
     SPAPR_RESIZE_HPT_DEFAULT = 0,
@@ -777,8 +773,8 @@ DECLARE_INSTANCE_CHECKER(SpaprTceTable, SPAPR_TCE_TABLE,
                          TYPE_SPAPR_TCE_TABLE)
 
 #define TYPE_SPAPR_IOMMU_MEMORY_REGION "spapr-iommu-memory-region"
-#define SPAPR_IOMMU_MEMORY_REGION(obj) \
-        OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_SPAPR_IOMMU_MEMORY_REGION)
+DECLARE_INSTANCE_CHECKER(IOMMUMemoryRegion, SPAPR_IOMMU_MEMORY_REGION,
+                         TYPE_SPAPR_IOMMU_MEMORY_REGION)
 
 struct SpaprTceTable {
     DeviceState parent;
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 09e428de4e..ee3c525b33 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -31,7 +31,8 @@
 #include "qom/object.h"
 
 #define TYPE_ICS_SPAPR "ics-spapr"
-#define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
+DECLARE_INSTANCE_CHECKER(ICSState, ICS_SPAPR,
+                         TYPE_ICS_SPAPR)
 
 int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_servers,
                      Error **errp);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 479377f37b..e025ba9653 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -13,9 +13,8 @@ enum {
 
 #define TYPE_DEVICE "device"
 typedef struct DeviceClass DeviceClass;
-#define DEVICE(obj) OBJECT_CHECK(DeviceState, (obj), TYPE_DEVICE)
-#define DEVICE_CLASS(klass) OBJECT_CLASS_CHECK(DeviceClass, (klass), TYPE_DEVICE)
-#define DEVICE_GET_CLASS(obj) OBJECT_GET_CLASS(DeviceClass, (obj), TYPE_DEVICE)
+DECLARE_OBJ_CHECKERS(DeviceState, DeviceClass,
+                     DEVICE, TYPE_DEVICE)
 
 typedef enum DeviceCategory {
     DEVICE_CATEGORY_BRIDGE,
@@ -204,9 +203,8 @@ struct DeviceListener {
 };
 
 #define TYPE_BUS "bus"
-#define BUS(obj) OBJECT_CHECK(BusState, (obj), TYPE_BUS)
-#define BUS_CLASS(klass) OBJECT_CLASS_CHECK(BusClass, (klass), TYPE_BUS)
-#define BUS_GET_CLASS(obj) OBJECT_GET_CLASS(BusClass, (obj), TYPE_BUS)
+DECLARE_OBJ_CHECKERS(BusState, BusClass,
+                     BUS, TYPE_BUS)
 
 struct BusClass {
     ObjectClass parent_class;
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index 8fded9e599..034cd73d37 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -195,14 +195,8 @@ struct SCLPEventClass {
 
 #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
 typedef struct SCLPEventFacilityClass SCLPEventFacilityClass;
-#define EVENT_FACILITY(obj) \
-     OBJECT_CHECK(SCLPEventFacility, (obj), TYPE_SCLP_EVENT_FACILITY)
-#define EVENT_FACILITY_CLASS(klass) \
-     OBJECT_CLASS_CHECK(SCLPEventFacilityClass, (klass), \
-                        TYPE_SCLP_EVENT_FACILITY)
-#define EVENT_FACILITY_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(SCLPEventFacilityClass, (obj), \
-                      TYPE_SCLP_EVENT_FACILITY)
+DECLARE_OBJ_CHECKERS(SCLPEventFacility, SCLPEventFacilityClass,
+                     EVENT_FACILITY, TYPE_SCLP_EVENT_FACILITY)
 
 struct SCLPEventFacilityClass {
     SysBusDeviceClass parent_class;
diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 459d5df041..77e21bba18 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -11,7 +11,8 @@
 #define QDEV_MAX_PIO 32
 
 #define TYPE_SYSTEM_BUS "System"
-#define SYSTEM_BUS(obj) OBJECT_CHECK(BusState, (obj), TYPE_SYSTEM_BUS)
+DECLARE_INSTANCE_CHECKER(BusState, SYSTEM_BUS,
+                         TYPE_SYSTEM_BUS)
 
 typedef struct SysBusDevice SysBusDevice;
 
diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
index dca651fd14..aaaba1117d 100644
--- a/include/hw/virtio/virtio-mmio.h
+++ b/include/hw/virtio/virtio-mmio.h
@@ -28,12 +28,8 @@
 /* QOM macros */
 /* virtio-mmio-bus */
 #define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
-#define VIRTIO_MMIO_BUS(obj) \
-        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
-#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
-#define VIRTIO_MMIO_BUS_CLASS(klass) \
-        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS)
+DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,
+                     VIRTIO_MMIO_BUS, TYPE_VIRTIO_MMIO_BUS)
 
 /* virtio-mmio */
 #define TYPE_VIRTIO_MMIO "virtio-mmio"
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 261d087de8..807280451b 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -69,12 +69,8 @@ typedef struct VirtQueueElement
 
 #define TYPE_VIRTIO_DEVICE "virtio-device"
 typedef struct VirtioDeviceClass VirtioDeviceClass;
-#define VIRTIO_DEVICE_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(VirtioDeviceClass, obj, TYPE_VIRTIO_DEVICE)
-#define VIRTIO_DEVICE_CLASS(klass) \
-        OBJECT_CLASS_CHECK(VirtioDeviceClass, klass, TYPE_VIRTIO_DEVICE)
-#define VIRTIO_DEVICE(obj) \
-        OBJECT_CHECK(VirtIODevice, (obj), TYPE_VIRTIO_DEVICE)
+DECLARE_OBJ_CHECKERS(VirtIODevice, VirtioDeviceClass,
+                     VIRTIO_DEVICE, TYPE_VIRTIO_DEVICE)
 
 enum virtio_device_endian {
     VIRTIO_DEVICE_ENDIAN_UNKNOWN,
diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index ebef2bf4e4..746bd38b6e 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -10,8 +10,8 @@
 #define TYPE_XENSYSBUS "xen-sysbus"
 #define TYPE_XENBACKEND "xen-backend"
 
-#define XENBACKEND_DEVICE(obj) \
-    OBJECT_CHECK(XenLegacyDevice, (obj), TYPE_XENBACKEND)
+DECLARE_INSTANCE_CHECKER(XenLegacyDevice, XENBACKEND_DEVICE,
+                         TYPE_XENBACKEND)
 
 /* variables */
 extern struct xs_handle *xenstore;
diff --git a/include/net/filter.h b/include/net/filter.h
index 0d4f011bc0..e7e593128a 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -16,12 +16,8 @@
 
 #define TYPE_NETFILTER "netfilter"
 typedef struct NetFilterClass NetFilterClass;
-#define NETFILTER(obj) \
-    OBJECT_CHECK(NetFilterState, (obj), TYPE_NETFILTER)
-#define NETFILTER_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(NetFilterClass, (obj), TYPE_NETFILTER)
-#define NETFILTER_CLASS(klass) \
-    OBJECT_CLASS_CHECK(NetFilterClass, (klass), TYPE_NETFILTER)
+DECLARE_OBJ_CHECKERS(NetFilterState, NetFilterClass,
+                     NETFILTER, TYPE_NETFILTER)
 
 typedef void (FilterSetup) (NetFilterState *nf, Error **errp);
 typedef void (FilterCleanup) (NetFilterState *nf);
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index bb2dcfb97b..c1b2b2e52c 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -36,8 +36,8 @@ typedef struct KVMMemoryListener {
 
 #define TYPE_KVM_ACCEL ACCEL_CLASS_NAME("kvm")
 
-#define KVM_STATE(obj) \
-    OBJECT_CHECK(KVMState, (obj), TYPE_KVM_ACCEL)
+DECLARE_INSTANCE_CHECKER(KVMState, KVM_STATE,
+                         TYPE_KVM_ACCEL)
 
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
                                   AddressSpace *as, int as_id);
diff --git a/include/ui/console.h b/include/ui/console.h
index 2a74a27d50..8602203523 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -107,12 +107,8 @@ void kbd_put_keysym(int keysym);
 
 #define TYPE_QEMU_CONSOLE "qemu-console"
 typedef struct QemuConsoleClass QemuConsoleClass;
-#define QEMU_CONSOLE(obj) \
-    OBJECT_CHECK(QemuConsole, (obj), TYPE_QEMU_CONSOLE)
-#define QEMU_CONSOLE_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(QemuConsoleClass, (obj), TYPE_QEMU_CONSOLE)
-#define QEMU_CONSOLE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(QemuConsoleClass, (klass), TYPE_QEMU_CONSOLE)
+DECLARE_OBJ_CHECKERS(QemuConsole, QemuConsoleClass,
+                     QEMU_CONSOLE, TYPE_QEMU_CONSOLE)
 
 
 struct QemuConsoleClass {
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 1e01bfeaea..6153ebb657 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1256,8 +1256,8 @@ struct PXA2xxI2CSlaveState {
 };
 
 #define TYPE_PXA2XX_I2C "pxa2xx_i2c"
-#define PXA2XX_I2C(obj) \
-    OBJECT_CHECK(PXA2xxI2CState, (obj), TYPE_PXA2XX_I2C)
+DECLARE_INSTANCE_CHECKER(PXA2xxI2CState, PXA2XX_I2C,
+                         TYPE_PXA2XX_I2C)
 
 struct PXA2xxI2CState {
     /*< private >*/
@@ -1794,7 +1794,8 @@ static PXA2xxI2SState *pxa2xx_i2s_init(MemoryRegion *sysmem,
 
 /* PXA Fast Infra-red Communications Port */
 #define TYPE_PXA2XX_FIR "pxa2xx-fir"
-#define PXA2XX_FIR(obj) OBJECT_CHECK(PXA2xxFIrState, (obj), TYPE_PXA2XX_FIR)
+DECLARE_INSTANCE_CHECKER(PXA2xxFIrState, PXA2XX_FIR,
+                         TYPE_PXA2XX_FIR)
 
 struct PXA2xxFIrState {
     /*< private >*/
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 2d7fe3d973..bcf3c58f17 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -845,8 +845,8 @@ static Property virtser_props[] = {
 };
 
 #define TYPE_VIRTIO_SERIAL_BUS "virtio-serial-bus"
-#define VIRTIO_SERIAL_BUS(obj) \
-      OBJECT_CHECK(VirtIOSerialBus, (obj), TYPE_VIRTIO_SERIAL_BUS)
+DECLARE_INSTANCE_CHECKER(VirtIOSerialBus, VIRTIO_SERIAL_BUS,
+                         TYPE_VIRTIO_SERIAL_BUS)
 
 static void virtser_bus_class_init(ObjectClass *klass, void *data)
 {
diff --git a/hw/core/irq.c b/hw/core/irq.c
index 8aebc22cb2..d8532dee22 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -26,7 +26,8 @@
 #include "hw/irq.h"
 #include "qom/object.h"
 
-#define IRQ(obj) OBJECT_CHECK(struct IRQState, (obj), TYPE_IRQ)
+DECLARE_INSTANCE_CHECKER(struct IRQState, IRQ,
+                         TYPE_IRQ)
 
 struct IRQState {
     Object parent_obj;
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index fbfdc1886e..148eb534c5 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -18,8 +18,8 @@
 #include "migration/blocker.h"
 #include "qom/object.h"
 
-#define VHOST_USER_GPU(obj)                                    \
-    OBJECT_CHECK(VhostUserGPU, (obj), TYPE_VHOST_USER_GPU)
+DECLARE_INSTANCE_CHECKER(VhostUserGPU, VHOST_USER_GPU,
+                         TYPE_VHOST_USER_GPU)
 
 typedef enum VhostUserGpuRequest {
     VHOST_USER_GPU_NONE = 0,
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index ac6d6b2b68..aa7b890ffb 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -86,8 +86,8 @@ struct vmsvga_state_s {
 
 #define TYPE_VMWARE_SVGA "vmware-svga"
 
-#define VMWARE_SVGA(obj) \
-    OBJECT_CHECK(struct pci_vmsvga_state_s, (obj), TYPE_VMWARE_SVGA)
+DECLARE_INSTANCE_CHECKER(struct pci_vmsvga_state_s, VMWARE_SVGA,
+                         TYPE_VMWARE_SVGA)
 
 struct pci_vmsvga_state_s {
     /*< private >*/
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 8e1adc0fb3..c5415ed20e 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -34,8 +34,8 @@
 #include "trace.h"
 #include "qom/object.h"
 
-#define I8257(obj) \
-    OBJECT_CHECK(I8257State, (obj), TYPE_I8257)
+DECLARE_INSTANCE_CHECKER(I8257State, I8257,
+                         TYPE_I8257)
 
 /* #define DEBUG_DMA */
 
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index f91fc15483..e3aeb27c15 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -22,7 +22,8 @@
 #include "qom/object.h"
 
 #define TYPE_VMBUS "vmbus"
-#define VMBUS(obj) OBJECT_CHECK(VMBus, (obj), TYPE_VMBUS)
+DECLARE_INSTANCE_CHECKER(VMBus, VMBUS,
+                         TYPE_VMBUS)
 
 enum {
     VMGPADL_INIT,
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index ebb31f89c6..9e82bf376b 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -26,8 +26,8 @@
 #include "trace.h"
 #include "qom/object.h"
 
-#define ALLWINNER_AHCI(obj) \
-        OBJECT_CHECK(AllwinnerAHCIState, (obj), TYPE_ALLWINNER_AHCI)
+DECLARE_INSTANCE_CHECKER(AllwinnerAHCIState, ALLWINNER_AHCI,
+                         TYPE_ALLWINNER_AHCI)
 
 #define ALLWINNER_AHCI_BISTAFR    ((0xa0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
 #define ALLWINNER_AHCI_BISTCR     ((0xa4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 61af67503a..f6aa074fb6 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -482,7 +482,8 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
     qemu_register_reset(kbd_reset, s);
 }
 
-#define I8042(obj) OBJECT_CHECK(ISAKBDState, (obj), TYPE_I8042)
+DECLARE_INSTANCE_CHECKER(ISAKBDState, I8042,
+                         TYPE_I8042)
 
 struct ISAKBDState {
     ISADevice parent_obj;
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index afbb653497..cd360a2b38 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -40,8 +40,8 @@
 static APICCommonState *local_apics[MAX_APICS + 1];
 
 #define TYPE_APIC "apic"
-#define APIC(obj) \
-    OBJECT_CHECK(APICCommonState, (obj), TYPE_APIC)
+DECLARE_INSTANCE_CHECKER(APICCommonState, APIC,
+                         TYPE_APIC)
 
 static void apic_set_irq(APICCommonState *s, int vector_num, int trigger_mode);
 static void apic_update_irq(APICCommonState *s);
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 8bc90aa65d..f2fcd36e4d 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -33,12 +33,8 @@
 
 #define TYPE_KVM_ARM_GIC "kvm-arm-gic"
 typedef struct KVMARMGICClass KVMARMGICClass;
-#define KVM_ARM_GIC(obj) \
-     OBJECT_CHECK(GICState, (obj), TYPE_KVM_ARM_GIC)
-#define KVM_ARM_GIC_CLASS(klass) \
-     OBJECT_CLASS_CHECK(KVMARMGICClass, (klass), TYPE_KVM_ARM_GIC)
-#define KVM_ARM_GIC_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(KVMARMGICClass, (obj), TYPE_KVM_ARM_GIC)
+DECLARE_OBJ_CHECKERS(GICState, KVMARMGICClass,
+                     KVM_ARM_GIC, TYPE_KVM_ARM_GIC)
 
 struct KVMARMGICClass {
     ARMGICCommonClass parent_class;
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 198be30cf5..74b9b24514 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -31,11 +31,8 @@
 
 #define TYPE_KVM_ARM_ITS "arm-its-kvm"
 typedef struct KVMARMITSClass KVMARMITSClass;
-#define KVM_ARM_ITS(obj) OBJECT_CHECK(GICv3ITSState, (obj), TYPE_KVM_ARM_ITS)
-#define KVM_ARM_ITS_CLASS(klass) \
-     OBJECT_CLASS_CHECK(KVMARMITSClass, (klass), TYPE_KVM_ARM_ITS)
-#define KVM_ARM_ITS_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(KVMARMITSClass, (obj), TYPE_KVM_ARM_ITS)
+DECLARE_OBJ_CHECKERS(GICv3ITSState, KVMARMITSClass,
+                     KVM_ARM_ITS, TYPE_KVM_ARM_ITS)
 
 struct KVMARMITSClass {
     GICv3ITSCommonClass parent_class;
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 87092795e6..3468db9790 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -43,12 +43,8 @@
 
 #define TYPE_KVM_ARM_GICV3 "kvm-arm-gicv3"
 typedef struct KVMARMGICv3Class KVMARMGICv3Class;
-#define KVM_ARM_GICV3(obj) \
-     OBJECT_CHECK(GICv3State, (obj), TYPE_KVM_ARM_GICV3)
-#define KVM_ARM_GICV3_CLASS(klass) \
-     OBJECT_CLASS_CHECK(KVMARMGICv3Class, (klass), TYPE_KVM_ARM_GICV3)
-#define KVM_ARM_GICV3_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(KVMARMGICv3Class, (obj), TYPE_KVM_ARM_GICV3)
+DECLARE_OBJ_CHECKERS(GICv3State, KVMARMGICv3Class,
+                     KVM_ARM_GICV3, TYPE_KVM_ARM_GICV3)
 
 #define   KVM_DEV_ARM_VGIC_SYSREG(op0, op1, crn, crm, op2)         \
                              (ARM64_SYS_REG_SHIFT_MASK(op0, OP0) | \
diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
index 0dae5ec090..8ac0c5cb9b 100644
--- a/hw/intc/etraxfs_pic.c
+++ b/hw/intc/etraxfs_pic.c
@@ -39,8 +39,8 @@
 #define R_MAX       5
 
 #define TYPE_ETRAX_FS_PIC "etraxfs,pic"
-#define ETRAX_FS_PIC(obj) \
-    OBJECT_CHECK(struct etrax_pic, (obj), TYPE_ETRAX_FS_PIC)
+DECLARE_INSTANCE_CHECKER(struct etrax_pic, ETRAX_FS_PIC,
+                         TYPE_ETRAX_FS_PIC)
 
 struct etrax_pic
 {
diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
index 81b2672cd3..6d0807faf0 100644
--- a/hw/intc/loongson_liointc.c
+++ b/hw/intc/loongson_liointc.c
@@ -44,8 +44,8 @@
 #define R_END                   0x64
 
 #define TYPE_LOONGSON_LIOINTC "loongson.liointc"
-#define LOONGSON_LIOINTC(obj) \
-        OBJECT_CHECK(struct loongson_liointc, (obj), TYPE_LOONGSON_LIOINTC)
+DECLARE_INSTANCE_CHECKER(struct loongson_liointc, LOONGSON_LIOINTC,
+                         TYPE_LOONGSON_LIOINTC)
 
 struct loongson_liointc {
     SysBusDevice parent_obj;
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 66ce18955e..a7e6ff2913 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -42,7 +42,8 @@
 #define R_MAX       8
 
 #define TYPE_XILINX_INTC "xlnx.xps-intc"
-#define XILINX_INTC(obj) OBJECT_CHECK(struct xlx_pic, (obj), TYPE_XILINX_INTC)
+DECLARE_INSTANCE_CHECKER(struct xlx_pic, XILINX_INTC,
+                         TYPE_XILINX_INTC)
 
 struct xlx_pic
 {
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 6ee14a4682..dcf836a14e 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -38,8 +38,8 @@
 #define XEN_PIIX_NUM_PIRQS      128ULL
 
 #define TYPE_PIIX3_PCI_DEVICE "pci-piix3"
-#define PIIX3_PCI_DEVICE(obj) \
-    OBJECT_CHECK(PIIX3State, (obj), TYPE_PIIX3_PCI_DEVICE)
+DECLARE_INSTANCE_CHECKER(PIIX3State, PIIX3_PCI_DEVICE,
+                         TYPE_PIIX3_PCI_DEVICE)
 
 #define TYPE_PIIX3_DEVICE "PIIX3"
 #define TYPE_PIIX3_XEN_DEVICE "PIIX3-xen"
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index e96f565ba1..2011fb11ca 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -47,7 +47,8 @@
 } while (0)
 
 #define TYPE_AUXTOI2C "aux-to-i2c-bridge"
-#define AUXTOI2C(obj) OBJECT_CHECK(AUXTOI2CState, (obj), TYPE_AUXTOI2C)
+DECLARE_INSTANCE_CHECKER(AUXTOI2CState, AUXTOI2C,
+                         TYPE_AUXTOI2C)
 
 static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent);
 static inline I2CBus *aux_bridge_get_i2c_bus(AUXTOI2CState *bridge);
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index e064ca4048..76de6d027f 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -76,8 +76,8 @@ struct rocker {
 
 #define TYPE_ROCKER "rocker"
 
-#define ROCKER(obj) \
-    OBJECT_CHECK(Rocker, (obj), TYPE_ROCKER)
+DECLARE_INSTANCE_CHECKER(Rocker, ROCKER,
+                         TYPE_ROCKER)
 
 static QLIST_HEAD(, rocker) rockers;
 
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index bc43adf985..8496759376 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -53,8 +53,8 @@
 #define CTRL_S     0x1
 
 #define TYPE_XILINX_ETHLITE "xlnx.xps-ethernetlite"
-#define XILINX_ETHLITE(obj) \
-    OBJECT_CHECK(struct xlx_ethlite, (obj), TYPE_XILINX_ETHLITE)
+DECLARE_INSTANCE_CHECKER(struct xlx_ethlite, XILINX_ETHLITE,
+                         TYPE_XILINX_ETHLITE)
 
 struct xlx_ethlite
 {
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 2cc429ba7b..cf789103a4 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -878,8 +878,8 @@ static IOMMUTLBEntry pnv_phb3_translate_iommu(IOMMUMemoryRegion *iommu,
 }
 
 #define TYPE_PNV_PHB3_IOMMU_MEMORY_REGION "pnv-phb3-iommu-memory-region"
-#define PNV_PHB3_IOMMU_MEMORY_REGION(obj) \
-    OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_PNV_PHB3_IOMMU_MEMORY_REGION)
+DECLARE_INSTANCE_CHECKER(IOMMUMemoryRegion, PNV_PHB3_IOMMU_MEMORY_REGION,
+                         TYPE_PNV_PHB3_IOMMU_MEMORY_REGION)
 
 static void pnv_phb3_iommu_memory_region_class_init(ObjectClass *klass,
                                                     void *data)
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 0802d4d64b..a3990a7b0e 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1043,8 +1043,8 @@ static IOMMUTLBEntry pnv_phb4_translate_iommu(IOMMUMemoryRegion *iommu,
 }
 
 #define TYPE_PNV_PHB4_IOMMU_MEMORY_REGION "pnv-phb4-iommu-memory-region"
-#define PNV_PHB4_IOMMU_MEMORY_REGION(obj) \
-    OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_PNV_PHB4_IOMMU_MEMORY_REGION)
+DECLARE_INSTANCE_CHECKER(IOMMUMemoryRegion, PNV_PHB4_IOMMU_MEMORY_REGION,
+                         TYPE_PNV_PHB4_IOMMU_MEMORY_REGION)
 
 static void pnv_phb4_iommu_memory_region_class_init(ObjectClass *klass,
                                                     void *data)
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 2af7ce83eb..5eeff10164 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -162,8 +162,8 @@ DECLARE_INSTANCE_CHECKER(PCIVPBState, PCI_VPB,
                          TYPE_VERSATILE_PCI)
 
 #define TYPE_VERSATILE_PCI_HOST "versatile_pci_host"
-#define PCI_VPB_HOST(obj) \
-    OBJECT_CHECK(PCIDevice, (obj), TYPE_VERSATILE_PCI_HOST)
+DECLARE_INSTANCE_CHECKER(PCIDevice, PCI_VPB_HOST,
+                         TYPE_VERSATILE_PCI_HOST)
 
 typedef enum {
     PCI_IMAP0 = 0x0,
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 0afead5d9f..e40b22996f 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -20,8 +20,8 @@
 #include "qom/object.h"
 
 #define TYPE_PXA2XX_PCMCIA "pxa2xx-pcmcia"
-#define PXA2XX_PCMCIA(obj) \
-    OBJECT_CHECK(PXA2xxPCMCIAState, obj, TYPE_PXA2XX_PCMCIA)
+DECLARE_INSTANCE_CHECKER(PXA2xxPCMCIAState, PXA2XX_PCMCIA,
+                         TYPE_PXA2XX_PCMCIA)
 
 struct PXA2xxPCMCIAState {
     SysBusDevice parent_obj;
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 447444cfdf..1d6842b01b 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -45,8 +45,8 @@
 
 #define TYPE_MPTSAS1068 "mptsas1068"
 
-#define MPT_SAS(obj) \
-    OBJECT_CHECK(MPTSASState, (obj), TYPE_MPTSAS1068)
+DECLARE_INSTANCE_CHECKER(MPTSASState, MPT_SAS,
+                         TYPE_MPTSAS1068)
 
 #define MPTSAS1068_PRODUCT_ID                  \
     (MPI_FW_HEADER_PID_FAMILY_1068_SAS |       \
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index 3036f0e830..0189c3ec56 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -29,8 +29,8 @@
 #include "qom/object.h"
 
 #define TYPE_AW_SDHOST_BUS "allwinner-sdhost-bus"
-#define AW_SDHOST_BUS(obj) \
-    OBJECT_CHECK(SDBus, (obj), TYPE_AW_SDHOST_BUS)
+DECLARE_INSTANCE_CHECKER(SDBus, AW_SDHOST_BUS,
+                         TYPE_AW_SDHOST_BUS)
 
 /* SD Host register offsets */
 enum {
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 36255bc30b..5e5a9db6de 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -22,8 +22,8 @@
 #include "qom/object.h"
 
 #define TYPE_BCM2835_SDHOST_BUS "bcm2835-sdhost-bus"
-#define BCM2835_SDHOST_BUS(obj) \
-    OBJECT_CHECK(SDBus, (obj), TYPE_BCM2835_SDHOST_BUS)
+DECLARE_INSTANCE_CHECKER(SDBus, BCM2835_SDHOST_BUS,
+                         TYPE_BCM2835_SDHOST_BUS)
 
 #define SDCMD  0x00 /* Command to SD card              - 16 R/W */
 #define SDARG  0x04 /* Argument to SD card             - 32 R/W */
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 5c853b1f4f..0807a23732 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -24,10 +24,12 @@
 #include "qom/object.h"
 
 #define TYPE_PXA2XX_MMCI "pxa2xx-mmci"
-#define PXA2XX_MMCI(obj) OBJECT_CHECK(PXA2xxMMCIState, (obj), TYPE_PXA2XX_MMCI)
+DECLARE_INSTANCE_CHECKER(PXA2xxMMCIState, PXA2XX_MMCI,
+                         TYPE_PXA2XX_MMCI)
 
 #define TYPE_PXA2XX_MMCI_BUS "pxa2xx-mmci-bus"
-#define PXA2XX_MMCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_PXA2XX_MMCI_BUS)
+DECLARE_INSTANCE_CHECKER(SDBus, PXA2XX_MMCI_BUS,
+                         TYPE_PXA2XX_MMCI_BUS)
 
 struct PXA2xxMMCIState {
     SysBusDevice parent_obj;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 54c4200369..ca4060e057 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -40,7 +40,8 @@
 #include "qom/object.h"
 
 #define TYPE_SDHCI_BUS "sdhci-bus"
-#define SDHCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_SDHCI_BUS)
+DECLARE_INSTANCE_CHECKER(SDBus, SDHCI_BUS,
+                         TYPE_SDHCI_BUS)
 
 #define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
 
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index d9b6da316b..e6eac3c3a4 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -24,7 +24,8 @@ struct SSIBus {
 };
 
 #define TYPE_SSI_BUS "SSI"
-#define SSI_BUS(obj) OBJECT_CHECK(SSIBus, (obj), TYPE_SSI_BUS)
+DECLARE_INSTANCE_CHECKER(SSIBus, SSI_BUS,
+                         TYPE_SSI_BUS)
 
 static const TypeInfo ssi_bus_info = {
     .name = TYPE_SSI_BUS,
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index bd36d906a2..0cfb2301e0 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -62,8 +62,8 @@ struct xlx_timer
 };
 
 #define TYPE_XILINX_TIMER "xlnx.xps-timer"
-#define XILINX_TIMER(obj) \
-    OBJECT_CHECK(struct timerblock, (obj), TYPE_XILINX_TIMER)
+DECLARE_INSTANCE_CHECKER(struct timerblock, XILINX_TIMER,
+                         TYPE_XILINX_TIMER)
 
 struct timerblock
 {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 22072dd7d5..f1c7bb3227 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -44,7 +44,8 @@
 #include "qom/object.h"
 
 #define TYPE_VFIO_PCI "vfio-pci"
-#define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
+DECLARE_INSTANCE_CHECKER(VFIOPCIDevice, PCI_VFIO,
+                         TYPE_VFIO_PCI)
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
-- 
2.26.2


