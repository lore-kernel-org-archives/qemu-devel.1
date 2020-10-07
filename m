Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B23BC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753E02087E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="vnuv3Non"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753E02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=me.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ04w-0005iT-EL
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 23:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1kQ04E-0005Dm-Um
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 23:24:38 -0400
Received: from mr85p00im-ztdg06011201.me.com ([17.58.23.181]:40618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1kQ04C-0001Gk-Jo
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 23:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1602041075; bh=RUSVo/LlfiKQ4shovhCJZboxE/aCKjsmZnWSqeO3ztw=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=vnuv3NonbQLSxOX6K6Aw46grrwZiyVCKq6EAcLiXYfGbeAlBQAKfNvHfvnzING3eK
 7tnMwMtVEbcqNZew3iPD+LrugCi2Q5qsjnN/PTfkfG0I8euNcE/9K9C59bR29NrVXB
 5brt0afU4nbBQAo0p6PmFdTusKcZ8lNnWdfl1zORkj7QNYGmvJpkJCO5U2Cw4KxMeg
 Ovgkf56Wm1ZlljW7TOVNwriCEbbUG7weqnQnKqAelAKqpV2UPMVL8ZgRA/qWhb8UvT
 XcU4q6nJNeCWOs4RG70SThDpTCDd3shqfAmMk1CgSsxTyzq1yBOcM6d34VtDdfd5HM
 b+uOd3Y53WugQ==
Received: from localhost.localdomain (c-67-180-181-196.hsd1.ca.comcast.net
 [67.180.181.196])
 by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id DF74E4004E7;
 Wed,  7 Oct 2020 03:24:34 +0000 (UTC)
From: Jason Thorpe <thorpej@me.com>
To: qemu-devel@nongnu.org
Cc: Jason Thorpe <thorpej@me.com>
Subject: [PATCH] Changes to support booting NetBSD/alpha
Date: Tue,  6 Oct 2020 20:24:17 -0700
Message-Id: <20201007032417.26044-1-thorpej@me.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-07_03:2020-10-06,
 2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2010070022
Received-SPF: pass client-ip=17.58.23.181; envelope-from=thorpej@me.com;
 helo=mr85p00im-ztdg06011201.me.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 23:24:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Along with the previous patch set for qemu-palcode, these changes
allow NetBSD/alpha to run in qemu-system-alpha.

- Allow a the minimum PCI device number to be passed to typhoon_init().
  Use this to specify a minimum PCI device number of 1 in the Clipper
  system emulation, since that's the lowest PCI device number with
  valid interrupt mappings on that system.
- Instead of passing just the CPU count in trap_arg2, also pass other
  configuration information.  Define the first config bit (bit 6) to
  reflect the "-nographic" option; PALcode will use this to initialize
  the Console Terminal Block to specify serial console.
- Attach a minimal i82378 SIO PCI node; some operating systems won't
  scan for ISA devices unless a PCI-ISA bridge is detected.  Real hardware
  would have had a Cypress or ALI bridge, but many Alpha models shipped
  with a i82378, and most operating sytems are not picky about the specific
  model.
- Modify the mc146818rtc emulation to ensure the timer is started as soon
  as the device is realized, and update the PF bit in REG_C even if it is
  not going to result in raising an interrupt, as the real hardware does.

Signed-off-by: Jason Thorpe <thorpej@me.com>
---
 hw/alpha/alpha_sys.h |   2 +-
 hw/alpha/dp264.c     |  16 ++++++-
 hw/alpha/typhoon.c   | 104 +++++++++++++++++++++++++++++++++++++++++--
 hw/rtc/mc146818rtc.c |   7 +++
 4 files changed, 123 insertions(+), 6 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index e2c02e2bbe..4835b3d5ee 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -11,7 +11,7 @@
 
 
 PCIBus *typhoon_init(MemoryRegion *, ISABus **, qemu_irq *, AlphaCPU *[4],
-                     pci_map_irq_fn);
+                     pci_map_irq_fn, uint8_t devfn_min);
 
 /* alpha_pci.c.  */
 extern const MemoryRegionOps alpha_pci_ignore_ops;
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 4d24518d1d..de59ae78cb 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -72,13 +72,25 @@ static void clipper_init(MachineState *machine)
         cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
     }
 
+    /* arg0 -> memory size
+       arg1 -> kernel entry point
+       arg2 -> config word
+
+       Config word: bits 0-5 -> ncpus
+		    bit  6   -> nographics option (for HWRPB CTB)
+
+       See init_hwrpb() in the PALcode.  */
+
     cpus[0]->env.trap_arg0 = ram_size;
     cpus[0]->env.trap_arg1 = 0;
     cpus[0]->env.trap_arg2 = smp_cpus;
+    if (!machine->enable_graphics)
+      cpus[0]->env.trap_arg2 |= (1 << 6);
 
-    /* Init the chipset.  */
+    /* Init the chipset.  Because we're using CLIPPER IRQ mappings,
+       the minimum PCI device IdSel is 1.  */
     pci_bus = typhoon_init(machine->ram, &isa_bus, &rtc_irq, cpus,
-                           clipper_pci_map_irq);
+                           clipper_pci_map_irq, PCI_DEVFN(1, 0));
 
     /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
     mc146818_rtc_init(isa_bus, 1900, rtc_irq);
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index a42b319812..cfe7fd5098 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -817,7 +817,8 @@ static void typhoon_alarm_timer(void *opaque)
 }
 
 PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rtc_irq,
-                     AlphaCPU *cpus[4], pci_map_irq_fn sys_map_irq)
+                     AlphaCPU *cpus[4], pci_map_irq_fn sys_map_irq,
+                     uint8_t devfn_min)
 {
     MemoryRegion *addr_space = get_system_memory();
     DeviceState *dev;
@@ -887,7 +888,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rtc_irq,
     b = pci_register_root_bus(dev, "pci",
                               typhoon_set_irq, sys_map_irq, s,
                               &s->pchip.reg_mem, &s->pchip.reg_io,
-                              0, 64, TYPE_PCI_BUS);
+                              devfn_min, 64, TYPE_PCI_BUS);
     phb->bus = b;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -921,10 +922,21 @@ PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rtc_irq,
     /* Pchip1 PCI configuration, 0x802.FE00.0000, 16MB.  */
 
     /* Init the ISA bus.  */
-    /* ??? Technically there should be a cy82c693ub pci-isa bridge.  */
+    /* Init the PCI-ISA bridge.  Technically, this would have been
+       a cy82c693ub, but a i82378 SIO was also used on many Alpha
+       systems and is close enough.
+
+       ??? We are using a private, stripped down implementation of i82378
+       so that we can handle the way the ISA interrupts are wired up on
+       Tsunami-type systems.  We're leaving that (and the rest of the board
+       peripheral setup) untoucned; we merely need to instantiate the PCI
+       device node for the bridge, so that operating systems that expect
+       it to be there will see it.  */
     {
         qemu_irq *isa_irqs;
 
+        pci_create_simple(b, PCI_DEVFN(7, 0), "i82378-typhoon");
+
         *isa_bus = isa_bus_new(NULL, get_system_memory(), &s->pchip.reg_io,
                                &error_abort);
         isa_irqs = i8259_init(*isa_bus,
@@ -955,10 +967,96 @@ static const TypeInfo typhoon_iommu_memory_region_info = {
     .class_init = typhoon_iommu_memory_region_class_init,
 };
 
+/* The following was copied from hw/isa/i82378.c and modified to provide
+   only the minimal PCI device node.  */
+
+/*                            
+ * QEMU Intel i82378 emulation (PCI to ISA bridge) 
+ *                            
+ * Copyright (c) 2010-2011 Herv\xc3\xa9 Poussineau
+ *  
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *  
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *     
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */    
+
+#include "migration/vmstate.h"
+
+#define TYPE_I82378 "i82378-typhoon"
+#define I82378(obj) \
+    OBJECT_CHECK(I82378State, (obj), TYPE_I82378)
+
+typedef struct I82378State {
+    PCIDevice parent_obj;
+} I82378State;
+
+static const VMStateDescription vmstate_i82378 = {
+    .name = "pci-i82378-typhoon",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, I82378State), 
+        VMSTATE_END_OF_LIST()
+    },                        
+};                            
+
+static void i82378_realize(PCIDevice *pci, Error **errp)
+{
+    uint8_t *pci_conf;
+ 
+    pci_conf = pci->config;
+    pci_set_word(pci_conf + PCI_COMMAND,
+                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+    pci_set_word(pci_conf + PCI_STATUS,
+                 PCI_STATUS_DEVSEL_MEDIUM);
+ 
+    pci_config_set_interrupt_pin(pci_conf, 1); /* interrupt pin 0 */
+}
+
+static void i82378_init(Object *obj)
+{
+}      
+
+static void i82378_class_init(ObjectClass *klass, void *data)
+{   
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    k->realize = i82378_realize; 
+    k->vendor_id = PCI_VENDOR_ID_INTEL;
+    k->device_id = PCI_DEVICE_ID_INTEL_82378;
+    k->revision = 0x03;
+    k->class_id = PCI_CLASS_BRIDGE_ISA;
+    dc->vmsd = &vmstate_i82378;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+}                             
+
+static const TypeInfo i82378_typhoon_type_info = {
+    .name = TYPE_I82378,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(I82378State),
+    .instance_init = i82378_init,
+    .class_init = i82378_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },     
+    },
+};  
+
 static void typhoon_register_types(void)
 {
     type_register_static(&typhoon_pcihost_info);
     type_register_static(&typhoon_iommu_memory_region_info);
+    type_register_static(&i82378_typhoon_type_info);
 }
 
 type_init(typhoon_register_types)
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 7a38540cb9..596876cb43 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -155,9 +155,15 @@ static uint32_t rtc_periodic_clock_ticks(RTCState *s)
 {
     int period_code;
 
+#if 0
+    /*
+     * Real hardware sets the PF bit rergardless if it actually
+     * raises an interrupt.
+     */
     if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
         return 0;
      }
+#endif
 
     period_code = s->cmos_data[RTC_REG_A] & 0x0f;
 
@@ -944,6 +950,7 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     }
 
     s->periodic_timer = timer_new_ns(rtc_clock, rtc_periodic_timer, s);
+    periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), 0, true);
     s->update_timer = timer_new_ns(rtc_clock, rtc_update_timer, s);
     check_update_timer(s);
 
-- 
2.28.0


