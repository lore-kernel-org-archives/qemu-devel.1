Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BD3C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027E02395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDWv/GJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027E02395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLJi-00053c-Ow
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kLLFN-0000rf-Gc
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kLLFL-0005I2-6R
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600930850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HsZKWB1ml7V0h856im4DRe/N7mUj7BSaI1tUFfOCkQ=;
 b=VDWv/GJXmpkXnsqw1ODc3mrp0OklqrpttPPnzMQNvXZWt+fM0dBXyooAK8Z48qSJi6/XFq
 5JN8DWpHf6i5w1/hbAv6f0aiG8ak6sKgg5GsrLv9E939LPj9u05igQScfYJtm39pU6P6Q0
 j+eIqQCNCi+ya3uCLg7bCjwAncxvkO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-JCz1oyE3NkK_1l1L0KYr8g-1; Thu, 24 Sep 2020 03:00:48 -0400
X-MC-Unique: JCz1oyE3NkK_1l1L0KYr8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DD2410BBEC8;
 Thu, 24 Sep 2020 07:00:47 +0000 (UTC)
Received: from pc-72.home.com (unknown [10.40.194.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AC7273668;
 Thu, 24 Sep 2020 07:00:45 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 4/7] hw/acpi/ich9: Enable ACPI PCI hot-plug
Date: Thu, 24 Sep 2020 09:00:10 +0200
Message-Id: <20200924070013.165026-5-jusual@redhat.com>
In-Reply-To: <20200924070013.165026-1-jusual@redhat.com>
References: <20200924070013.165026-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jusual@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add acpi_pcihp to ich9_pm as part of
'acpi-pci-hotplug-with-bridge-support' option. Set default to false.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 hw/i386/acpi-build.h   |  1 +
 include/hw/acpi/ich9.h |  3 ++
 hw/acpi/ich9.c         | 67 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/pcihp.c        |  5 +++-
 hw/i386/acpi-build.c   |  2 +-
 5 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 4c5bfb3d0b..39f143830a 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -10,6 +10,7 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 #define ACPI_PCIHP_BNMR_BASE 0x10
 
 void acpi_setup(void);
+Object *acpi_get_i386_pci_host(void);
 
 Object *object_resolve_type_unambiguous(const char *typename);
 
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 4d19571ed7..833e62fefe 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -24,6 +24,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/cpu.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/acpi/tco.h"
@@ -55,6 +56,8 @@ typedef struct ICH9LPCPMRegs {
     AcpiCpuHotplug gpe_cpu;
     CPUHotplugState cpuhp_state;
 
+    bool use_acpi_hotplug_bridge;
+    AcpiPciHpState acpi_pci_hotplug;
     MemHotplugState acpi_memory_hotplug;
 
     uint8_t disable_s3;
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 6a19070cec..987f23e388 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -218,6 +218,26 @@ static const VMStateDescription vmstate_cpuhp_state = {
     }
 };
 
+static bool vmstate_test_use_pcihp(void *opaque)
+{
+    ICH9LPCPMRegs *s = opaque;
+
+    return s->use_acpi_hotplug_bridge;
+}
+
+static const VMStateDescription vmstate_pcihp_state = {
+    .name = "ich9_pm/pcihp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_test_use_pcihp,
+    .fields      = (VMStateField[]) {
+        VMSTATE_PCI_HOTPLUG(acpi_pci_hotplug,
+                            ICH9LPCPMRegs,
+                            NULL),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_ich9_pm = {
     .name = "ich9_pm",
     .version_id = 1,
@@ -239,6 +259,7 @@ const VMStateDescription vmstate_ich9_pm = {
         &vmstate_memhp_state,
         &vmstate_tco_io_state,
         &vmstate_cpuhp_state,
+        &vmstate_pcihp_state,
         NULL
     }
 };
@@ -260,6 +281,7 @@ static void pm_reset(void *opaque)
     }
     pm->smi_en_wmask = ~0;
 
+    acpi_pcihp_reset(&pm->acpi_pci_hotplug, true);
     acpi_update_sci(&pm->acpi_regs, pm->irq);
 }
 
@@ -298,6 +320,18 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
     pm->enable_tco = true;
     acpi_pm_tco_init(&pm->tco_regs, &pm->io);
 
+    if (pm->use_acpi_hotplug_bridge) {
+        acpi_pcihp_init(OBJECT(lpc_pci),
+                        &pm->acpi_pci_hotplug,
+                        pci_get_bus(lpc_pci),
+                        pci_address_space_io(lpc_pci),
+                        true,
+                        ACPI_PCIHP_ADDR_ICH9);
+
+        qbus_set_hotplug_handler(BUS(pci_get_bus(lpc_pci)),
+                                 OBJECT(lpc_pci));
+    }
+
     pm->irq = sci_irq;
     qemu_register_reset(pm_reset, pm);
     pm->powerdown_notifier.notify = pm_powerdown_req;
@@ -369,6 +403,20 @@ static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
     s->pm.enable_tco = value;
 }
 
+static bool ich9_pm_get_acpi_pci_hotplug(Object *obj, Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+
+    return s->pm.use_acpi_hotplug_bridge;
+}
+
+static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value,
+                                               Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+
+    s->pm.use_acpi_hotplug_bridge = value;
+}
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
@@ -377,6 +425,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     pm->disable_s3 = 0;
     pm->disable_s4 = 0;
     pm->s4_val = 2;
+    pm->use_acpi_hotplug_bridge = false;
 
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
@@ -400,6 +449,9 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
                              ich9_pm_get_enable_tco,
                              ich9_pm_set_enable_tco);
+    object_property_add_bool(obj, "acpi-pci-hotplug-with-bridge-support",
+                             ich9_pm_get_acpi_pci_hotplug,
+                             ich9_pm_set_acpi_pci_hotplug);
 }
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -407,6 +459,11 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_pre_plug_cb(hotplug_dev, dev, errp);
+        return;
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
         !lpc->pm.acpi_memory_hotplug.is_enabled)
         error_setg(errp,
@@ -432,6 +489,9 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
         } else {
             acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
         }
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_plug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
+                                  dev, errp);
     } else {
         error_setg(errp, "acpi: device plug request for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -452,6 +512,10 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                !lpc->pm.cpu_hotplug_legacy) {
         acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
                                    dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_unplug_request_cb(hotplug_dev,
+                                            &lpc->pm.acpi_pci_hotplug,
+                                            dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -469,6 +533,9 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !lpc->pm.cpu_hotplug_legacy) {
         acpi_cpu_unplug_cb(&lpc->pm.cpuhp_state, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_unplug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
+                                    dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index bb457bc279..8ab65502ce 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -30,6 +30,8 @@
 #include "hw/pci-host/i440fx.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_host.h"
+#include "hw/i386/acpi-build.h"
 #include "hw/acpi/acpi.h"
 #include "exec/address-spaces.h"
 #include "hw/pci/pci_bus.h"
@@ -88,6 +90,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
 static void acpi_set_pci_info(void)
 {
     static bool bsel_is_set;
+    Object *host = acpi_get_i386_pci_host();
     PCIBus *bus;
     unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
 
@@ -96,7 +99,7 @@ static void acpi_set_pci_info(void)
     }
     bsel_is_set = true;
 
-    bus = find_i440fx(); /* TODO: Q35 support */
+    bus = PCI_HOST_BRIDGE(host)->bus;
     if (bus) {
         /* Scan all PCI buses. Set property to enable acpi based hotplug. */
         pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b7811a8912..8787b6fb33 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -270,7 +270,7 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
  * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
  * On i386 arch we only have two pci hosts, so we can look only for them.
  */
-static Object *acpi_get_i386_pci_host(void)
+Object *acpi_get_i386_pci_host(void)
 {
     PCIHostState *host;
 
-- 
2.25.4


