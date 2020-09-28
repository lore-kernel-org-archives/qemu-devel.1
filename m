Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9476C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B592080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkLAwvsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B592080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqeP-0001lo-Fg
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqcj-0007bx-9B
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqch-0006GX-4h
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601289790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNZFrCz5ZArTtCiKuOH2KglawF5DJdogSZ+8yzCEEPI=;
 b=BkLAwvskWcg3DKMSPsafclm8TacsBPdPwX4LlQwzOFCHXEVYx394luPNGp4YZVEVfEKHOL
 mid7Z/60JZ2ZYe1d0ayIabw8OIkuv+UH3Fk8Ie1S5wwJrNyrPTe+VL/VDId3Zym7Ms1fN4
 3r06k2myrfMsgqpFhIDjgaPcCL232xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-KqPFQG6yOFiTKltZHmqBiQ-1; Mon, 28 Sep 2020 06:43:08 -0400
X-MC-Unique: KqPFQG6yOFiTKltZHmqBiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D60E1DDF8;
 Mon, 28 Sep 2020 10:43:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BFD95D9CA;
 Mon, 28 Sep 2020 10:42:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7393340830; Mon, 28 Sep 2020 12:42:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/12] arm: use acpi_dsdt_add_gpex
Date: Mon, 28 Sep 2020 12:42:47 +0200
Message-Id: <20200928104256.9241-4-kraxel@redhat.com>
In-Reply-To: <20200928104256.9241-1-kraxel@redhat.com>
References: <20200928104256.9241-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Fill gpex config struct from memory map, then call the new
acpi_dsdt_add_gpex helper function.  No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c | 175 ++-------------------------------------
 1 file changed, 9 insertions(+), 166 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6bff5e373872..9747a6458f0b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -44,6 +44,7 @@
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
+#include "hw/pci-host/gpex.h"
 #include "hw/arm/virt.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/platform-bus.h"
@@ -155,176 +156,18 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
                               uint32_t irq, bool use_highmem, bool highmem_ecam)
 {
     int ecam_id = VIRT_ECAM_ID(highmem_ecam);
-    Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
-    int i, slot_no;
-    hwaddr base_mmio = memmap[VIRT_PCIE_MMIO].base;
-    hwaddr size_mmio = memmap[VIRT_PCIE_MMIO].size;
-    hwaddr base_pio = memmap[VIRT_PCIE_PIO].base;
-    hwaddr size_pio = memmap[VIRT_PCIE_PIO].size;
-    hwaddr base_ecam = memmap[ecam_id].base;
-    hwaddr size_ecam = memmap[ecam_id].size;
-    int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
-
-    Aml *dev = aml_device("%s", "PCI0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
-    aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
-    aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
-    aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
-    aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
-    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
-
-    /* Declare the PCI Routing Table. */
-    Aml *rt_pkg = aml_varpackage(PCI_SLOT_MAX * PCI_NUM_PINS);
-    for (slot_no = 0; slot_no < PCI_SLOT_MAX; slot_no++) {
-        for (i = 0; i < PCI_NUM_PINS; i++) {
-            int gsi = (i + slot_no) % PCI_NUM_PINS;
-            Aml *pkg = aml_package(4);
-            aml_append(pkg, aml_int((slot_no << 16) | 0xFFFF));
-            aml_append(pkg, aml_int(i));
-            aml_append(pkg, aml_name("GSI%d", gsi));
-            aml_append(pkg, aml_int(0));
-            aml_append(rt_pkg, pkg);
-        }
-    }
-    aml_append(dev, aml_name_decl("_PRT", rt_pkg));
-
-    /* Create GSI link device */
-    for (i = 0; i < PCI_NUM_PINS; i++) {
-        uint32_t irqs =  irq + i;
-        Aml *dev_gsi = aml_device("GSI%d", i);
-        aml_append(dev_gsi, aml_name_decl("_HID", aml_string("PNP0C0F")));
-        aml_append(dev_gsi, aml_name_decl("_UID", aml_int(i)));
-        crs = aml_resource_template();
-        aml_append(crs,
-                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
-                                 AML_EXCLUSIVE, &irqs, 1));
-        aml_append(dev_gsi, aml_name_decl("_PRS", crs));
-        crs = aml_resource_template();
-        aml_append(crs,
-                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
-                                 AML_EXCLUSIVE, &irqs, 1));
-        aml_append(dev_gsi, aml_name_decl("_CRS", crs));
-        method = aml_method("_SRS", 1, AML_NOTSERIALIZED);
-        aml_append(dev_gsi, method);
-        aml_append(dev, dev_gsi);
-    }
-
-    method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_return(aml_int(base_ecam)));
-    aml_append(dev, method);
-
-    method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
-    Aml *rbuf = aml_resource_template();
-    aml_append(rbuf,
-        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
-                            nr_pcie_buses));
-    aml_append(rbuf,
-        aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base_mmio,
-                         base_mmio + size_mmio - 1, 0x0000, size_mmio));
-    aml_append(rbuf,
-        aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                     AML_ENTIRE_RANGE, 0x0000, 0x0000, size_pio - 1, base_pio,
-                     size_pio));
+    struct GPEXConfig cfg = {
+        .mmio32 = memmap[VIRT_PCIE_MMIO],
+        .pio    = memmap[VIRT_PCIE_PIO],
+        .ecam   = memmap[ecam_id],
+        .irq    = irq,
+    };
 
     if (use_highmem) {
-        hwaddr base_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].base;
-        hwaddr size_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].size;
-
-        aml_append(rbuf,
-            aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                             AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
-                             base_mmio_high,
-                             base_mmio_high + size_mmio_high - 1, 0x0000,
-                             size_mmio_high));
+        cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
     }
 
-    aml_append(method, aml_return(rbuf));
-    aml_append(dev, method);
-
-    /* Declare an _OSC (OS Control Handoff) method */
-    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
-    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
-    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
-    aml_append(method,
-        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
-
-    /* PCI Firmware Specification 3.0
-     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
-     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
-     * identified by the Universal Unique IDentifier (UUID)
-     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
-     */
-    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
-    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
-    aml_append(ifctx,
-        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
-    aml_append(ifctx,
-        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
-    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
-    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
-
-    /*
-     * Allow OS control for all 5 features:
-     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
-     */
-    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
-                              aml_name("CTRL")));
-
-    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
-    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
-                              aml_name("CDW1")));
-    aml_append(ifctx, ifctx1);
-
-    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
-    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
-                              aml_name("CDW1")));
-    aml_append(ifctx, ifctx1);
-
-    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
-    aml_append(ifctx, aml_return(aml_arg(3)));
-    aml_append(method, ifctx);
-
-    elsectx = aml_else();
-    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
-                               aml_name("CDW1")));
-    aml_append(elsectx, aml_return(aml_arg(3)));
-    aml_append(method, elsectx);
-    aml_append(dev, method);
-
-    method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
-
-    /* PCI Firmware Specification 3.0
-     * 4.6.1. _DSM for PCI Express Slot Information
-     * The UUID in _DSM in this context is
-     * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
-     */
-    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
-    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
-    ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
-    uint8_t byte_list[1] = {1};
-    buf = aml_buffer(1, byte_list);
-    aml_append(ifctx1, aml_return(buf));
-    aml_append(ifctx, ifctx1);
-    aml_append(method, ifctx);
-
-    byte_list[0] = 0;
-    buf = aml_buffer(1, byte_list);
-    aml_append(method, aml_return(buf));
-    aml_append(dev, method);
-
-    Aml *dev_res0 = aml_device("%s", "RES0");
-    aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
-    crs = aml_resource_template();
-    aml_append(crs,
-        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base_ecam,
-                         base_ecam + size_ecam - 1, 0x0000, size_ecam));
-    aml_append(dev_res0, aml_name_decl("_CRS", crs));
-    aml_append(dev, dev_res0);
-    aml_append(scope, dev);
+    acpi_dsdt_add_gpex(scope, &cfg);
 }
 
 static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
-- 
2.27.0


