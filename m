Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045D4C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC87F214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC87F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADFz-0003MO-LH
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iADCY-00007Q-2j
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iADCR-0002Yt-Ez
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iADCR-0002Yg-7U
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 432CA10F2E86;
 Tue, 17 Sep 2019 13:07:18 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A10F619C70;
 Tue, 17 Sep 2019 13:07:15 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 09:07:07 -0400
Message-Id: <20190917130708.10281-2-imammedo@redhat.com>
In-Reply-To: <20190917130708.10281-1-imammedo@redhat.com>
References: <20190917130708.10281-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 17 Sep 2019 13:07:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] q35: implement 128K SMRAM at default
 SMBASE address
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
Cc: yingwen.chen@intel.com, devel@edk2.groups.io, phillip.goerl@oracle.com,
 alex.williamson@redhat.com, jiewen.yao@intel.com, jun.nakajima@intel.com,
 michael.d.kinney@intel.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 rfc@edk2.groups.io, lersek@redhat.com, joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use commit (2f295167e0 q35/mch: implement extended TSEG sizes) for
inspiration and (ab)use reserved register in config space at 0x9c
offset [*] to extend q35 pci-host with ability to use 128K at
0x30000 as SMRAM and hide it (like TSEG) from non-SMM context.

Usage:
  1: write 0xff in the register
  2: if the feature is supported, follow up read from the register
     should return 0x01. At this point RAM at 0x30000 is still
     available for SMI handler configuration from non-SMM context
  3: writing 0x02 in the register, locks SMBASE area, making its contents
     available only from SMM context. In non-SMM context, reads return
     0xff and writes are ignored. Further writes into the register are
     ignored until the system reset.

*) https://www.mail-archive.com/qemu-devel@nongnu.org/msg455991.html

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/pci-host/q35.h | 10 +++++
 hw/i386/pc.c              |  4 +-
 hw/pci-host/q35.c         | 80 +++++++++++++++++++++++++++++++++++----
 3 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index b3bcf2e632..976fbae599 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -32,6 +32,7 @@
 #include "hw/acpi/ich9.h"
 #include "hw/pci-host/pam.h"
 #include "hw/i386/intel_iommu.h"
+#include "qemu/units.h"
 
 #define TYPE_Q35_HOST_DEVICE "q35-pcihost"
 #define Q35_HOST_DEVICE(obj) \
@@ -54,6 +55,8 @@ typedef struct MCHPCIState {
     MemoryRegion smram_region, open_high_smram;
     MemoryRegion smram, low_smram, high_smram;
     MemoryRegion tseg_blackhole, tseg_window;
+    MemoryRegion smbase_blackhole, smbase_window;
+    bool has_smram_at_smbase;
     Range pci_hole;
     uint64_t below_4g_mem_size;
     uint64_t above_4g_mem_size;
@@ -97,6 +100,13 @@ typedef struct Q35PCIHost {
 #define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY  0xffff
 #define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX    0xfff
 
+#define MCH_HOST_BRIDGE_SMBASE_SIZE            (128 * KiB)
+#define MCH_HOST_BRIDGE_SMBASE_ADDR            0x30000
+#define MCH_HOST_BRIDGE_F_SMBASE               0x9c
+#define MCH_HOST_BRIDGE_F_SMBASE_QUERY         0xff
+#define MCH_HOST_BRIDGE_F_SMBASE_IN_RAM        0x01
+#define MCH_HOST_BRIDGE_F_SMBASE_LCK           0x02
+
 #define MCH_HOST_BRIDGE_PCIEXBAR               0x60    /* 64bit register */
 #define MCH_HOST_BRIDGE_PCIEXBAR_SIZE          8       /* 64bit register */
 #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bad866fe44..288d28358a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -119,7 +119,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
-GlobalProperty pc_compat_4_1[] = {};
+GlobalProperty pc_compat_4_1[] = {
+    { "mch", "smbase-smram", "off" },
+};
 const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 
 GlobalProperty pc_compat_4_0[] = {};
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 158d270b9f..c1bd9f78ae 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -275,20 +275,20 @@ static const TypeInfo q35_host_info = {
  * MCH D0:F0
  */
 
-static uint64_t tseg_blackhole_read(void *ptr, hwaddr reg, unsigned size)
+static uint64_t blackhole_read(void *ptr, hwaddr reg, unsigned size)
 {
     return 0xffffffff;
 }
 
-static void tseg_blackhole_write(void *opaque, hwaddr addr, uint64_t val,
-                                 unsigned width)
+static void blackhole_write(void *opaque, hwaddr addr, uint64_t val,
+                            unsigned width)
 {
     /* nothing */
 }
 
-static const MemoryRegionOps tseg_blackhole_ops = {
-    .read = tseg_blackhole_read,
-    .write = tseg_blackhole_write,
+static const MemoryRegionOps blackhole_ops = {
+    .read = blackhole_read,
+    .write = blackhole_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
@@ -430,6 +430,46 @@ static void mch_update_ext_tseg_mbytes(MCHPCIState *mch)
     }
 }
 
+static void mch_update_smbase_smram(MCHPCIState *mch)
+{
+    PCIDevice *pd = PCI_DEVICE(mch);
+    uint8_t *reg = pd->config + MCH_HOST_BRIDGE_F_SMBASE;
+    bool lck;
+
+    if (!mch->has_smram_at_smbase) {
+        return;
+    }
+
+    if (*reg == MCH_HOST_BRIDGE_F_SMBASE_QUERY) {
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =
+            MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        *reg = MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
+        return;
+    }
+
+    /*
+     * default/reset state, discard written value
+     * which will disable SMRAM balackhole at SMBASE
+     */
+    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
+        *reg = 0x00;
+    }
+
+    memory_region_transaction_begin();
+    if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
+        /* disable all writes */
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] &=
+            ~MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        *reg = MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        lck = true;
+    } else {
+        lck = false;
+    }
+    memory_region_set_enabled(&mch->smbase_blackhole, lck);
+    memory_region_set_enabled(&mch->smbase_window, lck);
+    memory_region_transaction_commit();
+}
+
 static void mch_write_config(PCIDevice *d,
                               uint32_t address, uint32_t val, int len)
 {
@@ -456,6 +496,10 @@ static void mch_write_config(PCIDevice *d,
                        MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
         mch_update_ext_tseg_mbytes(mch);
     }
+
+    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
+        mch_update_smbase_smram(mch);
+    }
 }
 
 static void mch_update(MCHPCIState *mch)
@@ -464,6 +508,7 @@ static void mch_update(MCHPCIState *mch)
     mch_update_pam(mch);
     mch_update_smram(mch);
     mch_update_ext_tseg_mbytes(mch);
+    mch_update_smbase_smram(mch);
 
     /*
      * pci hole goes from end-of-low-ram to io-apic.
@@ -514,6 +559,9 @@ static void mch_reset(DeviceState *qdev)
                      MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
     }
 
+    d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
+    d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
+
     mch_update(mch);
 }
 
@@ -563,7 +611,7 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_add_subregion(&mch->smram, 0xfeda0000, &mch->high_smram);
 
     memory_region_init_io(&mch->tseg_blackhole, OBJECT(mch),
-                          &tseg_blackhole_ops, NULL,
+                          &blackhole_ops, NULL,
                           "tseg-blackhole", 0);
     memory_region_set_enabled(&mch->tseg_blackhole, false);
     memory_region_add_subregion_overlap(mch->system_memory,
@@ -575,6 +623,23 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_set_enabled(&mch->tseg_window, false);
     memory_region_add_subregion(&mch->smram, mch->below_4g_mem_size,
                                 &mch->tseg_window);
+
+    memory_region_init_io(&mch->smbase_blackhole, OBJECT(mch), &blackhole_ops,
+                          NULL, "smbase-blackhole",
+                          MCH_HOST_BRIDGE_SMBASE_SIZE);
+    memory_region_set_enabled(&mch->smbase_blackhole, false);
+    memory_region_add_subregion_overlap(mch->system_memory,
+                                        MCH_HOST_BRIDGE_SMBASE_ADDR,
+                                        &mch->smbase_blackhole, 1);
+
+    memory_region_init_alias(&mch->smbase_window, OBJECT(mch),
+                             "smbase-window", mch->ram_memory,
+                             MCH_HOST_BRIDGE_SMBASE_ADDR,
+                             MCH_HOST_BRIDGE_SMBASE_SIZE);
+    memory_region_set_enabled(&mch->smbase_window, false);
+    memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
+                                &mch->smbase_window);
+
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&mch->smram), &error_abort);
 
@@ -601,6 +666,7 @@ uint64_t mch_mcfg_base(void)
 static Property mch_props[] = {
     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
                        16),
+    DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.18.1


