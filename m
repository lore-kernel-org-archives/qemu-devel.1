Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BB5C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A9523600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL0u1kao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A9523600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOS6-0006EX-K3
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUq-0003Le-Cg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUh-0006Dq-4I
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d7RPn/3ZahkSmBmiIune9UP+DrkZTWoN9Va0y+S87Hg=;
 b=OL0u1kao1AUCLMzNVMKM4arXnz2twTFEZYk4rTw6xDgLnddmSD47Gx7xcMj+VJJvGW8ym1
 /MODBKFoRWRE4OTvi8z55a4qrv9SoBILNc1x2p4+HEsdzuKIJ+I/wC9bpqinUv84kCPn+g
 I2Enrat8myOn5/IJaHLhpxJzg2f9DZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-C1FDytsyPlCIZ7yskSDojA-1; Thu, 24 Sep 2020 05:24:47 -0400
X-MC-Unique: C1FDytsyPlCIZ7yskSDojA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87B901868438
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 399B35C1C7;
 Thu, 24 Sep 2020 09:24:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 77/92] stubs: Split accelerator / hardware related stubs
Date: Thu, 24 Sep 2020 05:22:59 -0400
Message-Id: <20200924092314.1722645-78-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Move hardware stubs unrelated from the accelerator to xen-hw-stub.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908155530.249806-5-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS            |  1 +
 accel/stubs/xen-stub.c | 41 +----------------------------------
 stubs/meson.build      |  1 +
 stubs/xen-hw-stub.c    | 49 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 40 deletions(-)
 create mode 100644 stubs/xen-hw-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b01385484..40e6133022 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -480,6 +480,7 @@ F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/sysemu/xen.h
 F: include/sysemu/xen-mapcache.h
+F: stubs/xen-hw-stub.c
 
 Guest CPU Cores (HAXM)
 ---------------------
diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
index fa3dddbce5..7ba0b697f4 100644
--- a/accel/stubs/xen-stub.c
+++ b/accel/stubs/xen-stub.c
@@ -6,50 +6,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 #include "qapi/qapi-commands-misc.h"
 
 bool xen_allowed;
 
-void xenstore_store_pv_console_info(int i, Chardev *chr)
-{
-}
-
-int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
-{
-    return -1;
-}
-
-void xen_piix3_set_irq(void *opaque, int irq_num, int level)
-{
-}
-
-void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
-{
-}
-
-void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
-{
-}
-
-int xen_is_pirq_msi(uint32_t msi_data)
-{
-    return 0;
-}
-
-qemu_irq *xen_interrupt_controller_init(void)
-{
-    return NULL;
-}
-
-void xen_register_framebuffer(MemoryRegion *mr)
-{
-}
-
-void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
-{
-}
-
 void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 {
 }
diff --git a/stubs/meson.build b/stubs/meson.build
index e0b322bc28..5730f1d967 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -46,4 +46,5 @@ stub_ss.add(files('vm-stop.c'))
 stub_ss.add(files('win32-kbd-hook.c'))
 if have_system
   stub_ss.add(files('semihost.c'))
+  stub_ss.add(files('xen-hw-stub.c'))
 endif
diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
new file mode 100644
index 0000000000..d14efef49e
--- /dev/null
+++ b/stubs/xen-hw-stub.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2014       Citrix Systems UK Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/xen/xen.h"
+
+void xenstore_store_pv_console_info(int i, Chardev *chr)
+{
+}
+
+int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
+{
+    return -1;
+}
+
+void xen_piix3_set_irq(void *opaque, int irq_num, int level)
+{
+}
+
+void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
+{
+}
+
+void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
+{
+}
+
+int xen_is_pirq_msi(uint32_t msi_data)
+{
+    return 0;
+}
+
+qemu_irq *xen_interrupt_controller_init(void)
+{
+    return NULL;
+}
+
+void xen_register_framebuffer(MemoryRegion *mr)
+{
+}
+
+void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
+{
+}
-- 
2.26.2



