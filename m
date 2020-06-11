Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6710BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128B82067B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTRWiC+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128B82067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTS5-0002tU-5w
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8p-0007pU-FO
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28341
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8m-00010H-M6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epMLqb2E81IffEMXdR4QTZHzWxK+yTE/lQmBwxDH894=;
 b=QTRWiC+FGSr+vFZIQ80Qz4RB0hWObgAF/ScVz52B1LKmE1wb1/QcRoL7HyVYpYpSd0fPC8
 mhEcvwPYIxS37PltKRgZ1bLXYlsCOIrbeOgJvsikNm95B5exbNQah7PbyUGdL4CIHAyBUE
 GIpfISXHUbEUncQHAKv177My8uIs2pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-iMD0dq6wPSa2HBAAqaQXHA-1; Thu, 11 Jun 2020 15:45:26 -0400
X-MC-Unique: iMD0dq6wPSa2HBAAqaQXHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC36C100A8EA;
 Thu, 11 Jun 2020 19:45:25 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4550B7E589;
 Thu, 11 Jun 2020 19:45:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 039/115] accel: Move Xen accelerator code under accel/xen/
Date: Thu, 11 Jun 2020 15:43:33 -0400
Message-Id: <20200611194449.31468-40-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This code is not related to hardware emulation.
Move it under accel/ with the other hypervisors.

Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200508100222.7112-1-philmd@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                |  2 ++
 accel/Makefile.objs                        |  1 +
 accel/xen/Makefile.objs                    |  1 +
 hw/xen/xen-common.c => accel/xen/xen-all.c |  8 +++++
 hw/acpi/piix4.c                            |  2 +-
 hw/i386/pc.c                               |  1 +
 hw/i386/pc_piix.c                          |  1 +
 hw/i386/pc_q35.c                           |  1 +
 hw/i386/xen/xen-hvm.c                      |  1 +
 hw/i386/xen/xen_platform.c                 |  1 +
 hw/isa/piix3.c                             |  1 +
 hw/pci/msix.c                              |  1 +
 hw/xen/Makefile.objs                       |  2 +-
 include/exec/ram_addr.h                    |  2 +-
 include/hw/xen/xen.h                       | 11 -------
 include/sysemu/xen.h                       | 38 ++++++++++++++++++++++
 migration/savevm.c                         |  2 +-
 softmmu/vl.c                               |  2 +-
 stubs/xen-hvm.c                            |  9 -----
 target/i386/cpu.c                          |  2 +-
 20 files changed, 63 insertions(+), 26 deletions(-)
 create mode 100644 accel/xen/Makefile.objs
 rename hw/xen/xen-common.c => accel/xen/xen-all.c (98%)
 create mode 100644 include/sysemu/xen.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3abe3faa4e..abe4d7ef8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -440,6 +440,7 @@ M: Paul Durrant <paul@xen.org>
 L: xen-devel@lists.xenproject.org
 S: Supported
 F: */xen*
+F: accel/xen/*
 F: hw/9pfs/xen-9p*
 F: hw/char/xen_console.c
 F: hw/display/xenfb.c
@@ -453,6 +454,7 @@ F: hw/i386/xen/
 F: hw/pci-host/xen_igd_pt.c
 F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
+F: include/sysemu/xen.h
 F: include/sysemu/xen-mapcache.h
 
 Guest CPU Cores (HAXM)
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 17e5ac6061..ff72f0d030 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -2,4 +2,5 @@ common-obj-$(CONFIG_SOFTMMU) += accel.o
 obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest.o
 obj-$(CONFIG_KVM) += kvm/
 obj-$(CONFIG_TCG) += tcg/
+obj-$(CONFIG_XEN) += xen/
 obj-y += stubs/
diff --git a/accel/xen/Makefile.objs b/accel/xen/Makefile.objs
new file mode 100644
index 0000000000..7482cfb436
--- /dev/null
+++ b/accel/xen/Makefile.objs
@@ -0,0 +1 @@
+obj-y += xen-all.o
diff --git a/hw/xen/xen-common.c b/accel/xen/xen-all.c
similarity index 98%
rename from hw/xen/xen-common.c
rename to accel/xen/xen-all.c
index 70564cc952..f3edc65ec9 100644
--- a/hw/xen/xen-common.c
+++ b/accel/xen/xen-all.c
@@ -16,6 +16,7 @@
 #include "hw/xen/xen_pt.h"
 #include "chardev/char.h"
 #include "sysemu/accel.h"
+#include "sysemu/xen.h"
 #include "sysemu/runstate.h"
 #include "migration/misc.h"
 #include "migration/global_state.h"
@@ -31,6 +32,13 @@
     do { } while (0)
 #endif
 
+static bool xen_allowed;
+
+bool xen_enabled(void)
+{
+    return xen_allowed;
+}
+
 xc_interface *xen_xc;
 xenforeignmemory_handle *xen_fmem;
 xendevicemodel_handle *xen_dmod;
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 85c199b30d..e27f57195a 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -30,6 +30,7 @@
 #include "hw/acpi/acpi.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/xen.h"
 #include "qapi/error.h"
 #include "qemu/range.h"
 #include "exec/address-spaces.h"
@@ -41,7 +42,6 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
-#include "hw/xen/xen.h"
 #include "migration/vmstate.h"
 #include "hw/core/cpu.h"
 #include "trace.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b9961b1035..143ac1c354 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -57,6 +57,7 @@
 #include "sysemu/tcg.h"
 #include "sysemu/numa.h"
 #include "sysemu/kvm.h"
+#include "sysemu/xen.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2613d25bda..eea964e72b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -53,6 +53,7 @@
 #include "cpu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "sysemu/xen.h"
 #ifdef CONFIG_XEN
 #include <xen/hvm/hvm_info_table.h>
 #include "hw/xen/xen_pt.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 688d57ddf3..fa9ef449d1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -36,6 +36,7 @@
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/xen/xen.h"
 #include "sysemu/kvm.h"
+#include "sysemu/xen.h"
 #include "hw/kvm/clock.h"
 #include "hw/pci-host/q35.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 82ece6b9e7..041303a2fa 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -28,6 +28,7 @@
 #include "qemu/range.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/xen.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 0f7b05e5e1..a1492fdecd 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -33,6 +33,7 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
+#include "sysemu/xen.h"
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index fd1c78879f..1a5267e19f 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -28,6 +28,7 @@
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 29187898f2..2c7ead7667 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -19,6 +19,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
 #include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "qemu/range.h"
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index 84df60a928..340b2c5096 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -1,5 +1,5 @@
 # xen backend driver support
-common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o xen-bus.o xen-bus-helper.o xen-backend.o
+common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-bus.o xen-bus-helper.o xen-backend.o
 
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index b295f6a784..7b5c24e928 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -21,7 +21,7 @@
 
 #ifndef CONFIG_USER_ONLY
 #include "cpu.h"
-#include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 #include "sysemu/tcg.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 5ac1c6dc55..771dd447f2 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -20,13 +20,6 @@ extern uint32_t xen_domid;
 extern enum xen_mode xen_mode;
 extern bool xen_domid_restrict;
 
-extern bool xen_allowed;
-
-static inline bool xen_enabled(void)
-{
-    return xen_allowed;
-}
-
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
 void xen_piix3_set_irq(void *opaque, int irq_num, int level);
 void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len);
@@ -39,10 +32,6 @@ void xenstore_store_pv_console_info(int i, struct Chardev *chr);
 
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory);
 
-void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                   struct MemoryRegion *mr, Error **errp);
-void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
-
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
 #endif /* QEMU_HW_XEN_H */
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
new file mode 100644
index 0000000000..1ca292715e
--- /dev/null
+++ b/include/sysemu/xen.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU Xen support
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef SYSEMU_XEN_H
+#define SYSEMU_XEN_H
+
+#ifdef CONFIG_XEN
+
+bool xen_enabled(void);
+
+#ifndef CONFIG_USER_ONLY
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                   struct MemoryRegion *mr, Error **errp);
+#endif
+
+#else /* !CONFIG_XEN */
+
+#define xen_enabled() 0
+#ifndef CONFIG_USER_ONLY
+static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
+{
+    /* nothing */
+}
+static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                                 MemoryRegion *mr, Error **errp)
+{
+    g_assert_not_reached();
+}
+#endif
+
+#endif /* CONFIG_XEN */
+
+#endif
diff --git a/migration/savevm.c b/migration/savevm.c
index c00a6807d9..b979ea6e7f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -28,7 +28,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/boards.h"
-#include "hw/xen/xen.h"
 #include "net/net.h"
 #include "migration.h"
 #include "migration/snapshot.h"
@@ -59,6 +58,7 @@
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/xen.h"
 #include "qjson.h"
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 055472da66..f669c06ede 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -36,6 +36,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
+#include "sysemu/xen.h"
 
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -178,7 +179,6 @@ static NotifierList exit_notifiers =
 static NotifierList machine_init_done_notifiers =
     NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
 
-bool xen_allowed;
 uint32_t xen_domid;
 enum xen_mode xen_mode = XEN_EMULATE;
 bool xen_domid_restrict;
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index b7d53b5e2f..6954a5b696 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -35,11 +35,6 @@ int xen_is_pirq_msi(uint32_t msi_data)
     return 0;
 }
 
-void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
-                   Error **errp)
-{
-}
-
 qemu_irq *xen_interrupt_controller_init(void)
 {
     return NULL;
@@ -49,10 +44,6 @@ void xen_register_framebuffer(MemoryRegion *mr)
 {
 }
 
-void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
-{
-}
-
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 25a8f6b1ad..b5705cda86 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -29,6 +29,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/hvf.h"
 #include "sysemu/cpus.h"
+#include "sysemu/xen.h"
 #include "kvm_i386.h"
 #include "sev_i386.h"
 
@@ -54,7 +55,6 @@
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/address-spaces.h"
-#include "hw/xen/xen.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/boards.h"
 #endif
-- 
2.26.2



