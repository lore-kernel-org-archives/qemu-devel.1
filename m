Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC0C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 01:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6692072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 01:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6692072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0xNQ-0000tw-5B
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 21:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1k0xMs-0000Uw-Nz
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 21:28:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4224 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1k0xMq-0001rF-0C
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 21:28:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7800DD89916A0183A49C;
 Thu, 30 Jul 2020 09:28:09 +0800 (CST)
Received: from localhost (10.174.149.56) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 09:28:02 +0800
From: Hogan Wang <hogan.wang@huawei.com>
To: <dgilbert@redhat.com>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jusual@redhat.com>
Subject: [PATCH 2/6] hw/pci-host: save/restore pci host config register for
 old ones
Date: Thu, 30 Jul 2020 09:27:57 +0800
Message-ID: <20200730012757.787-1-hogan.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729184251.GJ2795@work-vm>
References: <20200729184251.GJ2795@work-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.149.56]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=hogan.wang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 21:28:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: wangxinxin.wang@huawei.com, weidong.huang@huawei.com, hogan.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The i440fx and q35 machines integrate i440FX or MCH PCI device by default.
Refer to i440FX and ICH9-LPC spcifications, there are some reserved
configuration registers can used to save/restore PCIHostState.config_reg.
It's nasty but friendly to old ones.

Reproducer steps:
step 1. Make modifications to seabios and qemu for increase reproduction
efficiency, write 0xf0 to 0x402 port notify qemu to stop vcpu after
0x0cf8 port wrote i440 configure register. qemu stop vcpu when catch
0x402 port wrote 0xf0.

seabios:/src/hw/pci.c
@@ -52,6 +52,11 @@ void pci_config_writeb(u16 bdf, u32 addr, u8 val)
         writeb(mmconfig_addr(bdf, addr), val);
     } else {
         outl(ioconfig_cmd(bdf, addr), PORT_PCI_CMD);
+       if (bdf == 0 && addr == 0x72 && val == 0xa) {
+            dprintf(1, "stop vcpu\n");
+            outb(0xf0, 0x402); // notify qemu to stop vcpu
+            dprintf(1, "resume vcpu\n");
+        }
         outb(val, PORT_PCI_DATA + (addr & 3));
     }
 }

qemu:hw/char/debugcon.c
@@ -60,6 +61,9 @@ static void debugcon_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     printf(" [debugcon: write addr=0x%04" HWADDR_PRIx " val=0x%02" PRIx64 "]\n", addr, val);
 #endif

+    if (ch == 0xf0) {
+        vm_stop(RUN_STATE_PAUSED);
+    }
     /* XXX this blocks entire thread. Rewrite to use
      * qemu_chr_fe_write and background I/O callbacks */
     qemu_chr_fe_write_all(&s->chr, &ch, 1);

step 2. start vm1 by the following command line, and then vm stopped.
$ qemu-system-x86_64 -machine pc-i440fx-5.0,accel=kvm\
 -netdev tap,ifname=tap-test,id=hostnet0,vhost=on,downscript=no,script=no\
 -device virtio-net-pci,netdev=hostnet0,id=net0,bus=pci.0,addr=0x13,bootindex=3\
 -device cirrus-vga,id=video0,vgamem_mb=16,bus=pci.0,addr=0x2\
 -chardev file,id=seabios,path=/var/log/test.seabios,append=on\
 -device isa-debugcon,iobase=0x402,chardev=seabios\
 -monitor stdio

step 3. start vm2 to accept vm1 state.
$ qemu-system-x86_64 -machine pc-i440fx-5.0,accel=kvm\
 -netdev tap,ifname=tap-test1,id=hostnet0,vhost=on,downscript=no,script=no\
 -device virtio-net-pci,netdev=hostnet0,id=net0,bus=pci.0,addr=0x13,bootindex=3\
 -device cirrus-vga,id=video0,vgamem_mb=16,bus=pci.0,addr=0x2\
 -chardev file,id=seabios,path=/var/log/test.seabios,append=on\
 -device isa-debugcon,iobase=0x402,chardev=seabios\
 -monitor stdio \
 -incoming tcp:127.0.0.1:8000

step 4. execute the following qmp command in vm1 to migrate.
(qemu) migrate tcp:127.0.0.1:8000

step 5. execute the following qmp command in vm2 to resume vcpu.
(qemu) cont

Before this patch, we get KVM "emulation failure" error on vm2.
This patch fixes it.

Signed-off-by: Hogan Wang <hogan.wang@huawei.com>
---
 hw/pci-host/i440fx.c      | 46 +++++++++++++++++++++++++++++++++++++++
 hw/pci-host/q35.c         | 44 +++++++++++++++++++++++++++++++++++++
 hw/pci/pci_host.c         |  4 ++--
 include/hw/pci/pci_host.h |  2 +-
 4 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 8ed2417f0c..707e7e9dfb 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -64,6 +64,14 @@ typedef struct I440FXState {
  */
 #define I440FX_COREBOOT_RAM_SIZE 0x57
 
+/* Older I440FX machines (5.0 and older) do not support i440FX-pcihost state
+ * migration, use some reserved INTEL 82441 configuration registers to
+ * save/restore i440FX-pcihost config register. Refer to [INTEL 440FX PCISET
+ * 82441FX PCI AND MEMORY CONTROLLER (PMC) AND 82442FX DATA BUS ACCELERATOR
+ * (DBX) Table 1. PMC Configuration Space]
+ */
+#define I440FX_PCI_HOST_CONFIG_REG 0x94
+
 static void i440fx_update_memory_mappings(PCII440FXState *d)
 {
     int i;
@@ -98,15 +106,53 @@ static void i440fx_write_config(PCIDevice *dev,
 static int i440fx_post_load(void *opaque, int version_id)
 {
     PCII440FXState *d = opaque;
+    PCIDevice *dev;
+    PCIHostState *s = OBJECT_CHECK(PCIHostState,
+                                   object_resolve_path("/machine/i440fx", NULL),
+                                   TYPE_PCI_HOST_BRIDGE);
 
     i440fx_update_memory_mappings(d);
+
+    if (!s->config_reg_mig_enabled) {
+        dev = PCI_DEVICE(d);
+        s->config_reg = pci_get_long(&dev->config[I440FX_PCI_HOST_CONFIG_REG]);
+        pci_set_long(&dev->config[I440FX_PCI_HOST_CONFIG_REG], 0);
+    }
+    return 0;
+}
+
+static int i440fx_pre_save(void *opaque)
+{
+    PCIDevice *dev = opaque;
+    PCIHostState *s = OBJECT_CHECK(PCIHostState,
+                                   object_resolve_path("/machine/i440fx", NULL),
+                                   TYPE_PCI_HOST_BRIDGE);
+    if (!s->config_reg_mig_enabled) {
+        pci_set_long(&dev->config[I440FX_PCI_HOST_CONFIG_REG],
+                     s->config_reg);
+    }
+    return 0;
+}
+
+static int i440fx_post_save(void *opaque)
+{
+    PCIDevice *dev = opaque;
+    PCIHostState *s = OBJECT_CHECK(PCIHostState,
+                                   object_resolve_path("/machine/i440fx", NULL),
+                                   TYPE_PCI_HOST_BRIDGE);
+    if (!s->config_reg_mig_enabled) {
+        pci_set_long(&dev->config[I440FX_PCI_HOST_CONFIG_REG], 0);
+    }
     return 0;
 }
 
+
 static const VMStateDescription vmstate_i440fx = {
     .name = "I440FX",
     .version_id = 3,
     .minimum_version_id = 3,
+    .pre_save = i440fx_pre_save,
+    .post_save = i440fx_post_save,
     .post_load = i440fx_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCII440FXState),
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index b67cb9c29f..40c975948c 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -43,6 +43,14 @@
 
 #define Q35_PCI_HOST_HOLE64_SIZE_DEFAULT (1ULL << 35)
 
+/* Older Q35 machines (5.0 and older) do not support q35-pcihost state
+ * migration, use some reserved INTEL MCH configuration registers to
+ * save/restore q35-pcihost config register. Refer to [Intel 3 Series
+ * Chipset Family Datasheet Table 5-1. DRAM Controller Register Address
+ * Map (D0:F0)]
+ */
+#define Q35_PCI_HOST_CONFIG_REG 0x70
+
 static void q35_host_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
@@ -513,14 +521,50 @@ static void mch_update(MCHPCIState *mch)
 static int mch_post_load(void *opaque, int version_id)
 {
     MCHPCIState *mch = opaque;
+    PCIDevice *dev;
+    PCIHostState *s = OBJECT_CHECK(PCIHostState,
+                                   object_resolve_path("/machine/q35", NULL),
+                                   TYPE_PCI_HOST_BRIDGE);
     mch_update(mch);
+    if (!s->config_reg_mig_enabled) {
+        dev = PCI_DEVICE(mch);
+        s->config_reg = pci_get_long(&dev->config[Q35_PCI_HOST_CONFIG_REG]);
+        pci_set_long(&dev->config[Q35_PCI_HOST_CONFIG_REG], 0);
+    }
+    return 0;
+}
+
+static int mch_pre_save(void *opaque)
+{
+    PCIDevice *dev = opaque;
+    PCIHostState *s = OBJECT_CHECK(PCIHostState,
+                                   object_resolve_path("/machine/q35", NULL),
+                                   TYPE_PCI_HOST_BRIDGE);
+    if (!s->config_reg_mig_enabled) {
+        pci_set_long(&dev->config[Q35_PCI_HOST_CONFIG_REG], s->config_reg);
+    }
     return 0;
 }
 
+static int mch_post_save(void *opaque)
+{
+    PCIDevice *dev = opaque;
+    PCIHostState *s = OBJECT_CHECK(PCIHostState,
+                                   object_resolve_path("/machine/q35", NULL),
+                                   TYPE_PCI_HOST_BRIDGE);
+    if (!s->config_reg_mig_enabled) {
+        pci_set_long(&dev->config[Q35_PCI_HOST_CONFIG_REG], 0);
+    }
+    return 0;
+}
+
+
 static const VMStateDescription vmstate_mch = {
     .name = "mch",
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_save = mch_pre_save,
+    .post_save = mch_post_save,
     .post_load = mch_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, MCHPCIState),
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 8ca5fadcbd..c24daea84e 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -205,7 +205,7 @@ const MemoryRegionOps pci_host_data_be_ops = {
 static bool pci_host_needed(void *opaque)
 {
     PCIHostState *s = opaque;
-    return s->mig_enabled;
+    return s->config_reg_mig_enabled;
 }
 
 const VMStateDescription vmstate_pcihost = {
@@ -221,7 +221,7 @@ const VMStateDescription vmstate_pcihost = {
 
 static Property pci_host_properties_common[] = {
     DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
-                     mig_enabled, true),
+                     config_reg_mig_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index 6210a7e14d..23d6249979 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -45,7 +45,7 @@ struct PCIHostState {
     MemoryRegion data_mem;
     MemoryRegion mmcfg;
     uint32_t config_reg;
-    bool mig_enabled;
+    bool config_reg_mig_enabled;
     PCIBus *bus;
 
     QLIST_ENTRY(PCIHostState) next;
-- 
2.27.0



