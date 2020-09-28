Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA5C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA5F2074B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf7cxwpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA5F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqnP-00035E-1c
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqcn-0007jm-7P
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqci-0006Gz-0Y
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601289791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOmOzasiX1AyRYvXi8YHtKHHvSVfxuBUqGuKAwlbbss=;
 b=Rf7cxwpwOHpMOlt8EcokXjQljYpsaHDGWJrY771BjWXCeZW4IcPRp64Lw82o0du9YU8un/
 kyWCmggmP9RcEZrkolMQQwmkiz7kwcQcRXhKVk10Bh7fNeAN3TY9ksSfl74m0wRmqTmwyC
 WVkPKAPhSCITYro0Oiti+1qDFiKDabU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-3aYBBZX7NlqAdAMNjsp4Lw-1; Mon, 28 Sep 2020 06:43:09 -0400
X-MC-Unique: 3aYBBZX7NlqAdAMNjsp4Lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB29B81CB02;
 Mon, 28 Sep 2020 10:43:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5739210013BD;
 Mon, 28 Sep 2020 10:43:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8B55140840; Mon, 28 Sep 2020 12:42:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/12] microvm: add pcie support
Date: Mon, 28 Sep 2020 12:42:49 +0200
Message-Id: <20200928104256.9241-6-kraxel@redhat.com>
In-Reply-To: <20200928104256.9241-1-kraxel@redhat.com>
References: <20200928104256.9241-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
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


