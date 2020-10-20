Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFC0C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71C422283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btpGwBpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71C422283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmWS-00067P-NL
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 03:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUmON-0005F8-KV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUmOL-0001tp-Az
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603180148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0HcxF6DkQIHO8S9Lxfmthgp/aQVPS9T4z3+rB7R/+8=;
 b=btpGwBppAlSVQ3ibsiGfzojYzxGvLuNZc1+pmTjrdmRCRjfANV/5Kp0keyrZj0Q9snCUVv
 XKPV+lv4sbBHcnw4r8zPHYUFxAsGRQlVdask3Fu8BcYIqJeh0p5oxGOKsNZuqG4Nw/0MGi
 fxyGt8fqg65dUnysIXgrWXQqOpV/Xy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-mEU4VB82Ngu0AGVcogKP2A-1; Tue, 20 Oct 2020 03:49:06 -0400
X-MC-Unique: mEU4VB82Ngu0AGVcogKP2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96BF68049D5;
 Tue, 20 Oct 2020 07:49:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF5F527CCA;
 Tue, 20 Oct 2020 07:48:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 70DE99D74; Tue, 20 Oct 2020 09:48:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/10] microvm: add usb support
Date: Tue, 20 Oct 2020 09:48:39 +0200
Message-Id: <20201020074844.5304-6-kraxel@redhat.com>
In-Reply-To: <20201020074844.5304-1-kraxel@redhat.com>
References: <20201020074844.5304-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wire up "usb=on" machine option, when enabled add
a sysbus xhci controller with 8 ports.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/microvm.h |  5 ++++-
 hw/i386/acpi-microvm.c    |  9 +++++++++
 hw/i386/microvm.c         | 13 +++++++++++++
 hw/i386/Kconfig           |  1 +
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 91b064575d55..0fc216007777 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -41,7 +41,7 @@
  *   7     |  parallel  |
  *   8     |  rtc       | rtc (rtc=on)
  *   9     |  acpi      | acpi (ged)
- *  10     |  pci lnk   |
+ *  10     |  pci lnk   | xhci (usb=on)
  *  11     |  pci lnk   |
  *  12     |  ps2       | pcie
  *  13     |  fpu       | pcie
@@ -60,6 +60,9 @@
 #define GED_MMIO_BASE_REGS    (GED_MMIO_BASE + 0x200)
 #define GED_MMIO_IRQ          9
 
+#define MICROVM_XHCI_BASE     0xfe900000
+#define MICROVM_XHCI_IRQ      10
+
 #define PCIE_MMIO_BASE        0xc0000000
 #define PCIE_MMIO_SIZE        0x20000000
 #define PCIE_ECAM_BASE        0xe0000000
diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index f16f2311955c..7e8a6894ba26 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -35,6 +35,7 @@
 #include "hw/i386/microvm.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
+#include "hw/usb/xhci.h"
 #include "hw/virtio/virtio-mmio.h"
 
 #include "acpi-common.h"
@@ -89,6 +90,13 @@ static void acpi_dsdt_add_virtio(Aml *scope,
     }
 }
 
+static void acpi_dsdt_add_xhci(Aml *scope, MicrovmMachineState *mms)
+{
+    if (machine_usb(MACHINE(mms))) {
+        xhci_sysbus_build_aml(scope, MICROVM_XHCI_BASE, MICROVM_XHCI_IRQ);
+    }
+}
+
 static void acpi_dsdt_add_pci(Aml *scope, MicrovmMachineState *mms)
 {
     if (mms->pcie != ON_OFF_AUTO_ON) {
@@ -123,6 +131,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
                   GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
     acpi_dsdt_add_power_button(sb_scope);
     acpi_dsdt_add_virtio(sb_scope, mms);
+    acpi_dsdt_add_xhci(sb_scope, mms);
     acpi_dsdt_add_pci(sb_scope, mms);
     aml_append(dsdt, sb_scope);
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 68a7f424acf9..6672cfa254ee 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -47,6 +47,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/usb/xhci.h"
 
 #include "cpu.h"
 #include "elf.h"
@@ -197,6 +198,18 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         x86ms->acpi_dev = HOTPLUG_HANDLER(dev);
     }
 
+    if (x86_machine_is_acpi_enabled(x86ms) && machine_usb(MACHINE(mms))) {
+        DeviceState *dev = qdev_new(TYPE_XHCI_SYSBUS);
+        qdev_prop_set_uint32(dev, "intrs", 1);
+        qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);
+        qdev_prop_set_uint32(dev, "p2", 8);
+        qdev_prop_set_uint32(dev, "p3", 8);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, MICROVM_XHCI_BASE);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           x86ms->gsi[MICROVM_XHCI_IRQ]);
+    }
+
     if (x86_machine_is_acpi_enabled(x86ms) && mms->pcie == ON_OFF_AUTO_ON) {
         /* use topmost 25% of the address space available */
         hwaddr phys_size = (hwaddr)1 << X86_CPU(first_cpu)->phys_bits;
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 32aa15533bd8..eea059ffef54 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -105,6 +105,7 @@ config MICROVM
     select VIRTIO_MMIO
     select ACPI_HW_REDUCED
     select PCI_EXPRESS_GENERIC_BRIDGE
+    select USB_XHCI_SYSBUS
 
 config X86_IOMMU
     bool
-- 
2.27.0


