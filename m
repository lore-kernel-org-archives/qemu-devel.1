Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93A1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7826F206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTZYU8Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7826F206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgufq-0007hv-OF
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguec-00066l-9y
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:31:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49837
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgueZ-0007ul-MZ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591295505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RGxMHpNptqdaZvQXjdJ5yya4fFnMAb6wlgy+j3rPvGE=;
 b=jTZYU8KjOvoNLFtNxs2AzfVkVbNJxBbLkp35AjLLi6k1xU1TXU69vqvaDPeab9MVAvaMaz
 vWH8ikthtNV9SwmCT9Ptf+e5E5aWV+dOuhR9MxnRZqdJ3KEbl4exuuLB9/A5v4lZFqG0lU
 AbSk+naOzxnKDpl8OML/qARHvQQhFO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-FOLFJSiyO46eC_hXxdEdRQ-1; Thu, 04 Jun 2020 14:31:43 -0400
X-MC-Unique: FOLFJSiyO46eC_hXxdEdRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 352C1DC0A;
 Thu,  4 Jun 2020 18:31:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B90B4108A0;
 Thu,  4 Jun 2020 18:31:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5] xen: fix build without pci passthrough
Date: Thu,  4 Jun 2020 14:31:41 -0400
Message-Id: <20200604183141.32044-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 12:22:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anthony PERARD <anthony.perard@citrix.com>

Xen PCI passthrough support may not be available and thus the global
variable "has_igd_gfx_passthru" might be compiled out. Common code
should not access it in that case.

Unfortunately, we can't use CONFIG_XEN_PCI_PASSTHROUGH directly in
xen-common.c so this patch instead move access to the
has_igd_gfx_passthru variable via function and those functions are
also implemented as stubs. The stubs will be used when QEMU is built
without passthrough support.

Now, when one will want to enable igd-passthru via the -machine
property, they will get an error message if QEMU is built without
passthrough support.

Fixes: 46472d82322d0 ('xen: convert "-machine igd-passthru" to an accelerator property')
Reported-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20200603160442.3151170-1-anthony.perard@citrix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/xen/xen-all.c  |  4 ++--
 hw/Makefile.objs     |  2 +-
 hw/i386/pc_piix.c    |  2 +-
 hw/xen/Makefile.objs |  3 ++-
 hw/xen/xen_pt.c      | 12 +++++++++++-
 hw/xen/xen_pt.h      |  6 ++++--
 hw/xen/xen_pt_stub.c | 22 ++++++++++++++++++++++
 7 files changed, 43 insertions(+), 8 deletions(-)
 create mode 100644 hw/xen/xen_pt_stub.c

diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index f3edc65ec9..0c24d4b191 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -137,12 +137,12 @@ static void xen_change_state_handler(void *opaque, int running,
 
 static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
 {
-    return has_igd_gfx_passthru;
+    return xen_igd_gfx_pt_enabled();
 }
 
 static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
 {
-    has_igd_gfx_passthru = value;
+    xen_igd_gfx_pt_set(value, errp);
 }
 
 static void xen_setup_post(MachineState *ms, AccelState *accel)
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 660e2b4373..4cbe5e4e57 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,7 @@ devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
-devices-dirs-y += xen/
+devices-dirs-$(CONFIG_XEN) += xen/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += semihosting/
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index eea964e72b..054d3aa9f7 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -377,7 +377,7 @@ static void pc_init_isa(MachineState *machine)
 #ifdef CONFIG_XEN
 static void pc_xen_hvm_init_pci(MachineState *machine)
 {
-    const char *pci_type = has_igd_gfx_passthru ?
+    const char *pci_type = xen_igd_gfx_pt_enabled() ?
                 TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
 
     pc_init1(machine,
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index 340b2c5096..3fc715e595 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -1,6 +1,7 @@
 # xen backend driver support
-common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-bus.o xen-bus-helper.o xen-backend.o
+common-obj-y += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-bus.o xen-bus-helper.o xen-backend.o
 
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt_load_rom.o
+obj-$(call $(lnot, $(CONFIG_XEN_PCI_PASSTHROUGH))) += xen_pt_stub.o
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 81d5ad8da7..ab84443d5e 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -65,7 +65,17 @@
 #include "qemu/range.h"
 #include "exec/address-spaces.h"
 
-bool has_igd_gfx_passthru;
+static bool has_igd_gfx_passthru;
+
+bool xen_igd_gfx_pt_enabled(void)
+{
+    return has_igd_gfx_passthru;
+}
+
+void xen_igd_gfx_pt_set(bool value, Error **errp)
+{
+    has_igd_gfx_passthru = value;
+}
 
 #define XEN_PT_NR_IRQS (256)
 static uint8_t xen_pt_mapped_machine_irq[XEN_PT_NR_IRQS] = {0};
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 179775db7b..6e9cec95f3 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -5,6 +5,9 @@
 #include "hw/pci/pci.h"
 #include "xen-host-pci-device.h"
 
+bool xen_igd_gfx_pt_enabled(void);
+void xen_igd_gfx_pt_set(bool value, Error **errp);
+
 void xen_pt_log(const PCIDevice *d, const char *f, ...) GCC_FMT_ATTR(2, 3);
 
 #define XEN_PT_ERR(d, _f, _a...) xen_pt_log(d, "%s: Error: "_f, __func__, ##_a)
@@ -322,10 +325,9 @@ extern void *pci_assign_dev_load_option_rom(PCIDevice *dev,
                                             unsigned int domain,
                                             unsigned int bus, unsigned int slot,
                                             unsigned int function);
-extern bool has_igd_gfx_passthru;
 static inline bool is_igd_vga_passthrough(XenHostPCIDevice *dev)
 {
-    return (has_igd_gfx_passthru
+    return (xen_igd_gfx_pt_enabled()
             && ((dev->class_code >> 0x8) == PCI_CLASS_DISPLAY_VGA));
 }
 int xen_pt_register_vga_regions(XenHostPCIDevice *dev);
diff --git a/hw/xen/xen_pt_stub.c b/hw/xen/xen_pt_stub.c
new file mode 100644
index 0000000000..2d8cac8d54
--- /dev/null
+++ b/hw/xen/xen_pt_stub.c
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2020       Citrix Systems UK Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/xen/xen_pt.h"
+#include "qapi/error.h"
+
+bool xen_igd_gfx_pt_enabled(void)
+{
+    return false;
+}
+
+void xen_igd_gfx_pt_set(bool value, Error **errp)
+{
+    if (value) {
+        error_setg(errp, "Xen PCI passthrough support not built in");
+    }
+}
-- 
2.26.2


