Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3C1C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C241E2311A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUrhNarB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C241E2311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLKp4-0006Fm-Ux
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 02:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kLKjW-00008n-5D
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kLKjP-0001fi-ON
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600928870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J4uSRwmejHiEPkNlrqI1qIapmjK57nTqYkgqk4v/84Y=;
 b=eUrhNarBxku9EuzQKbRcoG7u2k+Mg1q2bi/imyHgK/MKaRkb003PA1St3SOdoI8feazAzO
 YQfRpG0o+dbRz90lX9/83hMdEM1gYW036dHFw5SEhmEvWK1b4S7eQs1d1d4DY7W47d9m3Z
 6EuAdaecNqIC5mGYql5O1D7TQk93o3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-I1jui1hZPI6pDAbctoQk-Q-1; Thu, 24 Sep 2020 02:27:47 -0400
X-MC-Unique: I1jui1hZPI6pDAbctoQk-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DD5381F030;
 Thu, 24 Sep 2020 06:27:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2D215C1DC;
 Thu, 24 Sep 2020 06:27:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id ED0119CAE; Thu, 24 Sep 2020 08:27:34 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/11] acpi: add acpi_dsdt_add_gpex
Date: Thu, 24 Sep 2020 08:27:25 +0200
Message-Id: <20200924062734.22978-3-kraxel@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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

Add helper function to generate dsdt aml code for the gpex pci host.
Largely copied from arm/virt.  Configuration is handled by passing
a config struct instead of looked up from memory map.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/pci-host/gpex.h |  11 +++
 hw/pci-host/gpex-acpi.c    | 179 +++++++++++++++++++++++++++++++++++++
 hw/pci-host/meson.build    |   1 +
 3 files changed, 191 insertions(+)
 create mode 100644 hw/pci-host/gpex-acpi.c

diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index 7abdb8b406e0..d52ea80d4e04 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -20,6 +20,7 @@
 #ifndef HW_GPEX_H
 #define HW_GPEX_H
 
+#include "exec/hwaddr.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
@@ -52,6 +53,16 @@ struct GPEXHost {
     int irq_num[GPEX_NUM_IRQS];
 };
 
+struct GPEXConfig {
+    MemMapEntry ecam;
+    MemMapEntry mmio32;
+    MemMapEntry mmio64;
+    MemMapEntry pio;
+    int         irq;
+};
+
 int gpex_set_irq_num(GPEXHost *s, int index, int gsi);
 
+void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg);
+
 #endif /* HW_GPEX_H */
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
new file mode 100644
index 000000000000..6fb951a0c19f
--- /dev/null
+++ b/hw/pci-host/gpex-acpi.c
@@ -0,0 +1,179 @@
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/pci-host/gpex.h"
+
+void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
+{
+    int nr_pcie_buses = cfg->ecam.size / PCIE_MMCFG_SIZE_MIN;
+    Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
+    int i, slot_no;
+
+    Aml *dev = aml_device("%s", "PCI0");
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
+    aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
+    aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
+    aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
+    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+    /* Declare the PCI Routing Table. */
+    Aml *rt_pkg = aml_varpackage(PCI_SLOT_MAX * PCI_NUM_PINS);
+    for (slot_no = 0; slot_no < PCI_SLOT_MAX; slot_no++) {
+        for (i = 0; i < PCI_NUM_PINS; i++) {
+            int gsi = (i + slot_no) % PCI_NUM_PINS;
+            Aml *pkg = aml_package(4);
+            aml_append(pkg, aml_int((slot_no << 16) | 0xFFFF));
+            aml_append(pkg, aml_int(i));
+            aml_append(pkg, aml_name("GSI%d", gsi));
+            aml_append(pkg, aml_int(0));
+            aml_append(rt_pkg, pkg);
+        }
+    }
+    aml_append(dev, aml_name_decl("_PRT", rt_pkg));
+
+    /* Create GSI link device */
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        uint32_t irqs = cfg->irq + i;
+        Aml *dev_gsi = aml_device("GSI%d", i);
+        aml_append(dev_gsi, aml_name_decl("_HID", aml_string("PNP0C0F")));
+        aml_append(dev_gsi, aml_name_decl("_UID", aml_int(i)));
+        crs = aml_resource_template();
+        aml_append(crs,
+                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                                 AML_EXCLUSIVE, &irqs, 1));
+        aml_append(dev_gsi, aml_name_decl("_PRS", crs));
+        crs = aml_resource_template();
+        aml_append(crs,
+                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                                 AML_EXCLUSIVE, &irqs, 1));
+        aml_append(dev_gsi, aml_name_decl("_CRS", crs));
+        method = aml_method("_SRS", 1, AML_NOTSERIALIZED);
+        aml_append(dev_gsi, method);
+        aml_append(dev, dev_gsi);
+    }
+
+    method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_int(cfg->ecam.base)));
+    aml_append(dev, method);
+
+    method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
+    Aml *rbuf = aml_resource_template();
+    aml_append(rbuf,
+        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
+                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
+                            nr_pcie_buses));
+    if (cfg->mmio32.size) {
+        aml_append(rbuf,
+                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                    AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
+                                    cfg->mmio32.base,
+                                    cfg->mmio32.base + cfg->mmio32.size - 1,
+                                    0x0000,
+                                    cfg->mmio32.size));
+    }
+    if (cfg->pio.size) {
+        aml_append(rbuf,
+                   aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
+                                AML_ENTIRE_RANGE, 0x0000, 0x0000,
+                                cfg->pio.size - 1,
+                                cfg->pio.base,
+                                cfg->pio.size));
+    }
+    if (cfg->mmio64.size) {
+        aml_append(rbuf,
+                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                    AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
+                                    cfg->mmio64.base,
+                                    cfg->mmio64.base + cfg->mmio64.size - 1,
+                                    0x0000,
+                                    cfg->mmio64.size));
+    }
+    aml_append(method, aml_return(rbuf));
+    aml_append(dev, method);
+
+    /* Declare an _OSC (OS Control Handoff) method */
+    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
+    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
+    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
+    aml_append(method,
+        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
+
+    /* PCI Firmware Specification 3.0
+     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
+     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
+     * identified by the Universal Unique IDentifier (UUID)
+     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
+     */
+    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
+    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
+    aml_append(ifctx,
+        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
+    aml_append(ifctx,
+        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
+    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
+    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
+
+    /*
+     * Allow OS control for all 5 features:
+     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
+     */
+    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
+                              aml_name("CTRL")));
+
+    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
+    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
+                              aml_name("CDW1")));
+    aml_append(ifctx, ifctx1);
+
+    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
+    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
+                              aml_name("CDW1")));
+    aml_append(ifctx, ifctx1);
+
+    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
+    aml_append(ifctx, aml_return(aml_arg(3)));
+    aml_append(method, ifctx);
+
+    elsectx = aml_else();
+    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
+                               aml_name("CDW1")));
+    aml_append(elsectx, aml_return(aml_arg(3)));
+    aml_append(method, elsectx);
+    aml_append(dev, method);
+
+    method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
+
+    /* PCI Firmware Specification 3.0
+     * 4.6.1. _DSM for PCI Express Slot Information
+     * The UUID in _DSM in this context is
+     * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
+     */
+    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
+    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
+    ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
+    uint8_t byte_list[1] = {1};
+    buf = aml_buffer(1, byte_list);
+    aml_append(ifctx1, aml_return(buf));
+    aml_append(ifctx, ifctx1);
+    aml_append(method, ifctx);
+
+    byte_list[0] = 0;
+    buf = aml_buffer(1, byte_list);
+    aml_append(method, aml_return(buf));
+    aml_append(dev, method);
+
+    Aml *dev_res0 = aml_device("%s", "RES0");
+    aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
+    crs = aml_resource_template();
+    aml_append(crs,
+        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
+                         cfg->ecam.base,
+                         cfg->ecam.base + cfg->ecam.size - 1,
+                         0x0000,
+                         cfg->ecam.size));
+    aml_append(dev_res0, aml_name_decl("_CRS", crs));
+    aml_append(dev, dev_res0);
+    aml_append(scope, dev);
+}
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index cd52f6ff1cb6..e6d1b896848c 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -3,6 +3,7 @@ pci_ss.add(when: 'CONFIG_PAM', if_true: files('pam.c'))
 pci_ss.add(when: 'CONFIG_PCI_BONITO', if_true: files('bonito.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_DESIGNWARE', if_true: files('designware.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('gpex.c'))
+pci_ss.add(when: 'CONFIG_ACPI', if_true: files('gpex-acpi.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_Q35', if_true: files('q35.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_XILINX', if_true: files('xilinx-pcie.c'))
 pci_ss.add(when: 'CONFIG_PCI_I440FX', if_true: files('i440fx.c'))
-- 
2.27.0


