Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE0FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 13:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7452078E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 13:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7452078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk6Uh-0004bZ-SB
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 09:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jk6TG-0002Ul-Gq; Sat, 13 Jun 2020 09:45:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:47666)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jk6TD-0002Sz-Af; Sat, 13 Jun 2020 09:45:18 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9B605748DDC;
 Sat, 13 Jun 2020 15:45:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 35788748DDA; Sat, 13 Jun 2020 15:45:00 +0200 (CEST)
Message-Id: <c637ae5d399e5681bb4f21662c7240590e7182e1.1592055375.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592055375.git.balaton@eik.bme.hu>
References: <cover.1592055375.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 5/5] mac_oldworld: Map macio to expected address at reset
Date: Sat, 13 Jun 2020 15:36:15 +0200
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

Add a reset function that maps macio to the address expected by the
firmware of the board at startup.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/mac.h          | 12 ++++++++++++
 hw/ppc/mac_oldworld.c | 17 +++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 6af87d1fa0..35a5f21163 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -57,6 +57,18 @@
 #define OLDWORLD_IDE1_IRQ      0xe
 #define OLDWORLD_IDE1_DMA_IRQ  0x3
 
+/* g3beige machine */
+#define TYPE_HEATHROW_MACHINE MACHINE_TYPE_NAME("g3beige")
+#define HEATHROW_MACHINE(obj) OBJECT_CHECK(HeathrowMachineState, (obj), \
+                                           TYPE_HEATHROW_MACHINE)
+
+typedef struct HeathrowMachineState {
+    /*< private >*/
+    MachineState parent;
+
+    PCIDevice *macio_pci;
+} HeathrowMachineState;
+
 /* New World IRQs */
 #define NEWWORLD_CUDA_IRQ      0x19
 #define NEWWORLD_PMU_IRQ       0x19
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 9138752ccb..fa9527410d 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -73,6 +73,15 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
     return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
 }
 
+static void ppc_heathrow_reset(MachineState *machine)
+{
+    HeathrowMachineState *m = HEATHROW_MACHINE(machine);
+
+    qemu_devices_reset();
+    pci_default_write_config(m->macio_pci, PCI_COMMAND, PCI_COMMAND_MEMORY, 2);
+    pci_default_write_config(m->macio_pci, PCI_BASE_ADDRESS_0, 0xf3000000, 4);
+}
+
 static void ppc_heathrow_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -91,6 +100,7 @@ const MemoryRegionOps machine_id_reg_ops = {
 
 static void ppc_heathrow_init(MachineState *machine)
 {
+    HeathrowMachineState *hm = HEATHROW_MACHINE(machine);
     ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
@@ -298,7 +308,8 @@ static void ppc_heathrow_init(MachineState *machine)
     ide_drive_get(hd, ARRAY_SIZE(hd));
 
     /* MacIO */
-    macio = OLDWORLD_MACIO(pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO));
+    hm->macio_pci = pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO);
+    macio = OLDWORLD_MACIO(hm->macio_pci);
     dev = DEVICE(macio);
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
@@ -450,6 +461,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Heathrow based PowerMAC";
     mc->init = ppc_heathrow_init;
+    mc->reset = ppc_heathrow_reset;
     mc->block_default_type = IF_IDE;
     mc->max_cpus = MAX_CPUS;
 #ifndef TARGET_PPC64
@@ -466,9 +478,10 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo ppc_heathrow_machine_info = {
-    .name          = MACHINE_TYPE_NAME("g3beige"),
+    .name          = TYPE_HEATHROW_MACHINE,
     .parent        = TYPE_MACHINE,
     .class_init    = heathrow_class_init,
+    .instance_size = sizeof(HeathrowMachineState),
     .interfaces = (InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { }
-- 
2.21.3


