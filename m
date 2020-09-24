Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28DFC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF19621D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpPCSY12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF19621D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLKlC-0001su-06
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 02:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kLKjT-0008WV-5O
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kLKjP-0001fN-Gd
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600928869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ib36JYmFLiIwnNEOQb/Im3BQLWOLXUGlFCDFWRqXeZ8=;
 b=KpPCSY12Qhn0EJiM/cCJaN4wBOUs5dbYMhtsDfLmZ50l3arM8QgmC74DR9XPDJOVNW5dCp
 tCE4l/daGk9OViMTAD3hckBLFICGR4W9A9HNWtZPEhUE5oS4UxFGDZHtbYRnQJBrYfMGCJ
 3sxQsEEid2D1Ckpew+rlYFKd/Sxon5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-dq7GsCrfMICsmH25JdLYiw-1; Thu, 24 Sep 2020 02:27:47 -0400
X-MC-Unique: dq7GsCrfMICsmH25JdLYiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47281100746B;
 Thu, 24 Sep 2020 06:27:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91B3B5C269;
 Thu, 24 Sep 2020 06:27:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1C0D31FCF6; Thu, 24 Sep 2020 08:27:35 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/11] microvm: add pcie support
Date: Thu, 24 Sep 2020 08:27:28 +0200
Message-Id: <20200924062734.22978-6-kraxel@redhat.com>
In-Reply-To: <20200924062734.22978-1-kraxel@redhat.com>
References: <20200924062734.22978-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Uses the existing gpex device which is also used as pcie host bridge on
arm/aarch64.  For now only a 32bit mmio window and no ioport support.

It is disabled by default, use "-machine microvm,pcie=on" to enable.
ACPI support must be enabled too because the bus is declared in the
DSDT table.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/microvm.h | 18 +++++++--
 hw/i386/acpi-microvm.c    | 12 ++++++
 hw/i386/microvm.c         | 84 +++++++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig           |  1 +
 4 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 0d61697c97f0..91b064575d55 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -25,6 +25,7 @@
 #include "hw/boards.h"
 #include "hw/i386/x86.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "hw/pci-host/gpex.h"
 #include "qom/object.h"
 
 /*
@@ -42,10 +43,10 @@
  *   9     |  acpi      | acpi (ged)
  *  10     |  pci lnk   |
  *  11     |  pci lnk   |
- *  12     |  ps2       |
- *  13     |  fpu       |
- *  14     |  ide 0     |
- *  15     |  ide 1     |
+ *  12     |  ps2       | pcie
+ *  13     |  fpu       | pcie
+ *  14     |  ide 0     | pcie
+ *  15     |  ide 1     | pcie
  *  16-23  |  pci gsi   | virtio
  */
 
@@ -59,10 +60,17 @@
 #define GED_MMIO_BASE_REGS    (GED_MMIO_BASE + 0x200)
 #define GED_MMIO_IRQ          9
 
+#define PCIE_MMIO_BASE        0xc0000000
+#define PCIE_MMIO_SIZE        0x20000000
+#define PCIE_ECAM_BASE        0xe0000000
+#define PCIE_ECAM_SIZE        0x10000000
+#define PCIE_IRQ_BASE         12
+
 /* Machine type options */
 #define MICROVM_MACHINE_PIT                 "pit"
 #define MICROVM_MACHINE_PIC                 "pic"
 #define MICROVM_MACHINE_RTC                 "rtc"
+#define MICROVM_MACHINE_PCIE                "pcie"
 #define MICROVM_MACHINE_ISA_SERIAL          "isa-serial"
 #define MICROVM_MACHINE_OPTION_ROMS         "x-option-roms"
 #define MICROVM_MACHINE_AUTO_KERNEL_CMDLINE "auto-kernel-cmdline"
@@ -80,6 +88,7 @@ struct MicrovmMachineState {
     OnOffAuto pic;
     OnOffAuto pit;
     OnOffAuto rtc;
+    OnOffAuto pcie;
     bool isa_serial;
     bool option_roms;
     bool auto_kernel_cmdline;
@@ -89,6 +98,7 @@ struct MicrovmMachineState {
     bool kernel_cmdline_fixed;
     Notifier machine_done;
     Notifier powerdown_req;
+    struct GPEXConfig gpex;
 };
 
 #define TYPE_MICROVM_MACHINE   MACHINE_TYPE_NAME("microvm")
diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index df39c5d3bd90..f16f2311955c 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -33,6 +33,8 @@
 #include "hw/boards.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/microvm.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie_host.h"
 #include "hw/virtio/virtio-mmio.h"
 
 #include "acpi-common.h"
@@ -87,6 +89,15 @@ static void acpi_dsdt_add_virtio(Aml *scope,
     }
 }
 
+static void acpi_dsdt_add_pci(Aml *scope, MicrovmMachineState *mms)
+{
+    if (mms->pcie != ON_OFF_AUTO_ON) {
+        return;
+    }
+
+    acpi_dsdt_add_gpex(scope, &mms->gpex);
+}
+
 static void
 build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
                    MicrovmMachineState *mms)
@@ -112,6 +123,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
                   GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
     acpi_dsdt_add_power_button(sb_scope);
     acpi_dsdt_add_virtio(sb_scope, mms);
+    acpi_dsdt_add_pci(sb_scope, mms);
     aml_append(dsdt, sb_scope);
 
     /* ACPI 5.0: Table 7-209 System State Package */
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 60d32722301f..273abe28c9c1 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -46,6 +46,7 @@
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/pci-host/gpex.h"
 
 #include "cpu.h"
 #include "elf.h"
@@ -101,6 +102,55 @@ static void microvm_gsi_handler(void *opaque, int n, int level)
     qemu_set_irq(s->ioapic_irq[n], level);
 }
 
+static void create_gpex(MicrovmMachineState *mms)
+{
+    X86MachineState *x86ms = X86_MACHINE(mms);
+    MemoryRegion *mmio32_alias;
+    MemoryRegion *mmio64_alias;
+    MemoryRegion *mmio_reg;
+    MemoryRegion *ecam_alias;
+    MemoryRegion *ecam_reg;
+    DeviceState *dev;
+    int i;
+
+    dev = qdev_new(TYPE_GPEX_HOST);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    /* Map only the first size_ecam bytes of ECAM space */
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
+                             ecam_reg, 0, mms->gpex.ecam.size);
+    memory_region_add_subregion(get_system_memory(),
+                                mms->gpex.ecam.base, ecam_alias);
+
+    /* Map the MMIO window into system address space so as to expose
+     * the section of PCI MMIO space which starts at the same base address
+     * (ie 1:1 mapping for that part of PCI MMIO space visible through
+     * the window).
+     */
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    if (mms->gpex.mmio32.size) {
+        mmio32_alias = g_new0(MemoryRegion, 1);
+        memory_region_init_alias(mmio32_alias, OBJECT(dev), "pcie-mmio32", mmio_reg,
+                                 mms->gpex.mmio32.base, mms->gpex.mmio32.size);
+        memory_region_add_subregion(get_system_memory(),
+                                    mms->gpex.mmio32.base, mmio32_alias);
+    }
+    if (mms->gpex.mmio64.size) {
+        mmio64_alias = g_new0(MemoryRegion, 1);
+        memory_region_init_alias(mmio64_alias, OBJECT(dev), "pcie-mmio64", mmio_reg,
+                                 mms->gpex.mmio64.base, mms->gpex.mmio64.size);
+        memory_region_add_subregion(get_system_memory(),
+                                    mms->gpex.mmio64.base, mmio64_alias);
+    }
+
+    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           x86ms->gsi[mms->gpex.irq + i]);
+    }
+}
+
 static void microvm_devices_init(MicrovmMachineState *mms)
 {
     X86MachineState *x86ms = X86_MACHINE(mms);
@@ -147,6 +197,15 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         x86ms->acpi_dev = HOTPLUG_HANDLER(dev);
     }
 
+    if (x86_machine_is_acpi_enabled(x86ms) && mms->pcie == ON_OFF_AUTO_ON) {
+        mms->gpex.mmio32.base = PCIE_MMIO_BASE;
+        mms->gpex.mmio32.size = PCIE_MMIO_SIZE;
+        mms->gpex.ecam.base   = PCIE_ECAM_BASE;
+        mms->gpex.ecam.size   = PCIE_ECAM_SIZE;
+        mms->gpex.irq         = PCIE_IRQ_BASE;
+        create_gpex(mms);
+    }
+
     if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
         qemu_irq *i8259;
 
@@ -446,6 +505,23 @@ static void microvm_machine_set_rtc(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &mms->rtc, errp);
 }
 
+static void microvm_machine_get_pcie(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    MicrovmMachineState *mms = MICROVM_MACHINE(obj);
+    OnOffAuto pcie = mms->pcie;
+
+    visit_type_OnOffAuto(v, name, &pcie, errp);
+}
+
+static void microvm_machine_set_pcie(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    MicrovmMachineState *mms = MICROVM_MACHINE(obj);
+
+    visit_type_OnOffAuto(v, name, &mms->pcie, errp);
+}
+
 static bool microvm_machine_get_isa_serial(Object *obj, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
@@ -521,6 +597,7 @@ static void microvm_machine_initfn(Object *obj)
     mms->pic = ON_OFF_AUTO_AUTO;
     mms->pit = ON_OFF_AUTO_AUTO;
     mms->rtc = ON_OFF_AUTO_AUTO;
+    mms->pcie = ON_OFF_AUTO_AUTO;
     mms->isa_serial = true;
     mms->option_roms = true;
     mms->auto_kernel_cmdline = true;
@@ -587,6 +664,13 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, MICROVM_MACHINE_RTC,
         "Enable MC146818 RTC");
 
+    object_class_property_add(oc, MICROVM_MACHINE_PCIE, "OnOffAuto",
+                              microvm_machine_get_pcie,
+                              microvm_machine_set_pcie,
+                              NULL, NULL);
+    object_class_property_set_description(oc, MICROVM_MACHINE_PCIE,
+        "Enable PCIe");
+
     object_class_property_add_bool(oc, MICROVM_MACHINE_ISA_SERIAL,
                                    microvm_machine_get_isa_serial,
                                    microvm_machine_set_isa_serial);
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d0bd8b537d55..32aa15533bd8 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -104,6 +104,7 @@ config MICROVM
     select MC146818RTC
     select VIRTIO_MMIO
     select ACPI_HW_REDUCED
+    select PCI_EXPRESS_GENERIC_BRIDGE
 
 config X86_IOMMU
     bool
-- 
2.27.0


