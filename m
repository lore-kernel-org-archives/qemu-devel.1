Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC08C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC54227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwFvLoel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC54227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZ25-0008PV-Dc
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY43-0007Yl-9U
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY41-000464-9E
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY40-00041i-Tr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id f129so1614180wmf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BMprzZ05gfG3DwfidaFtIVUxsm/A7BywNPdloh21sNo=;
 b=PwFvLoel5J33QGC9d8RQ1gD4hw05pLh8sL7Z5v8a1arj2hBV5x2bi5R+GNeuSg6S+4
 JviRmODY4ejnFyFtycfMvao0Bc3Y1MxoY3VKBkrmyaQu8C0581seGNRnFHjRTOTXChyC
 PFUsoKgwC+979erTB1IMGOY5hQLc1kKQos4n7infC4JiMu0dtk2wpQikYhTkELGYGXdj
 WReg6dStNlg5Z/dCLIu/u8D/Q0//RvxZZl5YYp/dOZ9TWVRjua4xqE2xOvYUC93HvB91
 eIBMKhddzERsnxNomSYNQaZY9AxDz6FUWZK91c6KhDUMYG7vQOxQ39jK4u2ZYeN0Ifb8
 OZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BMprzZ05gfG3DwfidaFtIVUxsm/A7BywNPdloh21sNo=;
 b=Q/Tjg3giGTTfwxPWk1BqzGRo3irGcH2iM4TUKOvgNvXxb2axAPC6Dh3mh3dkNdnYeM
 w6zxwQXvFRbt44LsD16yz6DJePrwouz09r8RF21KidMrzyM8A5V3EqYv5z/SEalPLGNo
 YFyezEJ6x2S6UDK3dNkMxZ1TfVV+GcuTKrYt5q8diLlD/QGIoBAKrA3iIZlvtgEb3CMj
 g+jnVdea7VBs95bHDMHDE7zQI/RUyZu0jm+mTaTvKG+GVeEAB84mvl1Wi2NRrQgrw167
 G245B4KfoMYVYk5pcrM9vl3UlALncpA+LqZ9uKx9Ixk84x62Chqm0L6/hGDl0BKLkaU2
 r93g==
X-Gm-Message-State: APjAAAViETaAQtcsMucHnAlJNGKFIHkfPi8UmzKYnP/EROG24K6Puf+P
 exnc4EzElWqxHlIWtp+/M5cZuzBt
X-Google-Smtp-Source: APXvYqyV2UzYHZkFX688M5P5cNPdG5G8+JycZfBliQw0UjfEXSwgAFxUwBQL6XHTc7yUboiIaY44oQ==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr2963563wmk.15.1576670663622; 
 Wed, 18 Dec 2019 04:04:23 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 81/87] hw/pci-host/i440fx: Extract the IGD passthrough host
 bridge device
Date: Wed, 18 Dec 2019 13:02:47 +0100
Message-Id: <1576670573-48048-82-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

We can use a i440FX without the IGD passthrough host bridge.
Extract it into a new file, 'hw/pci-host/xen_igd_pt.c'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191209095002.32194-6-philmd@redhat.com>
Acked-by: Paul Durrant <paul@xen.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS               |   1 +
 hw/pci-host/Makefile.objs |   1 +
 hw/pci-host/i440fx.c      |  84 --------------------------------
 hw/pci-host/xen_igd_pt.c  | 120 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 84 deletions(-)
 create mode 100644 hw/pci-host/xen_igd_pt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 740401b..0c36106 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -420,6 +420,7 @@ F: hw/block/dataplane/xen*
 F: hw/xen/
 F: hw/xenpv/
 F: hw/i386/xen/
+F: hw/pci-host/xen_igd_pt.c
 F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/sysemu/xen-mapcache.h
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index efd752b..fa6d155 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -14,6 +14,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
 common-obj-$(CONFIG_PCI_SABRE) += sabre.o
 common-obj-$(CONFIG_FULONG) += bonito.o
 common-obj-$(CONFIG_PCI_I440FX) += i440fx.o
+common-obj-$(CONFIG_PCI_I440FX) += xen_igd_pt.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) += gpex.o
 common-obj-$(CONFIG_PCI_EXPRESS_XILINX) += xilinx-pcie.o
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 4141385..bae7b42 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -368,89 +368,6 @@ static const TypeInfo i440fx_info = {
     },
 };
 
-/* IGD Passthrough Host Bridge. */
-typedef struct {
-    uint8_t offset;
-    uint8_t len;
-} IGDHostInfo;
-
-/* Here we just expose minimal host bridge offset subset. */
-static const IGDHostInfo igd_host_bridge_infos[] = {
-    {PCI_REVISION_ID,         2},
-    {PCI_SUBSYSTEM_VENDOR_ID, 2},
-    {PCI_SUBSYSTEM_ID,        2},
-    {0x50,                    2}, /* SNB: processor graphics control register */
-    {0x52,                    2}, /* processor graphics control register */
-    {0xa4,                    4}, /* SNB: graphics base of stolen memory */
-    {0xa8,                    4}, /* SNB: base of GTT stolen memory */
-};
-
-static void host_pci_config_read(int pos, int len, uint32_t *val, Error **errp)
-{
-    int rc, config_fd;
-    /* Access real host bridge. */
-    char *path = g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.%d/%s",
-                                 0, 0, 0, 0, "config");
-
-    config_fd = open(path, O_RDWR);
-    if (config_fd < 0) {
-        error_setg_errno(errp, errno, "Failed to open: %s", path);
-        goto out;
-    }
-
-    if (lseek(config_fd, pos, SEEK_SET) != pos) {
-        error_setg_errno(errp, errno, "Failed to seek: %s", path);
-        goto out_close_fd;
-    }
-
-    do {
-        rc = read(config_fd, (uint8_t *)val, len);
-    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
-    if (rc != len) {
-        error_setg_errno(errp, errno, "Failed to read: %s", path);
-    }
-
-out_close_fd:
-    close(config_fd);
-out:
-    g_free(path);
-}
-
-static void igd_pt_i440fx_realize(PCIDevice *pci_dev, Error **errp)
-{
-    uint32_t val = 0;
-    size_t i;
-    int pos, len;
-    Error *local_err = NULL;
-
-    for (i = 0; i < ARRAY_SIZE(igd_host_bridge_infos); i++) {
-        pos = igd_host_bridge_infos[i].offset;
-        len = igd_host_bridge_infos[i].len;
-        host_pci_config_read(pos, len, &val, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-        pci_default_write_config(pci_dev, pos, val, len);
-    }
-}
-
-static void igd_passthrough_i440fx_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->realize = igd_pt_i440fx_realize;
-    dc->desc = "IGD Passthrough Host bridge";
-}
-
-static const TypeInfo igd_passthrough_i440fx_info = {
-    .name          = TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE,
-    .parent        = TYPE_I440FX_PCI_DEVICE,
-    .instance_size = sizeof(PCII440FXState),
-    .class_init    = igd_passthrough_i440fx_class_init,
-};
-
 static const char *i440fx_pcihost_root_bus_path(PCIHostState *host_bridge,
                                                 PCIBus *rootbus)
 {
@@ -495,7 +412,6 @@ static const TypeInfo i440fx_pcihost_info = {
 static void i440fx_register_types(void)
 {
     type_register_static(&i440fx_info);
-    type_register_static(&igd_passthrough_i440fx_info);
     type_register_static(&i440fx_pcihost_info);
 }
 
diff --git a/hw/pci-host/xen_igd_pt.c b/hw/pci-host/xen_igd_pt.c
new file mode 100644
index 0000000..efcc934
--- /dev/null
+++ b/hw/pci-host/xen_igd_pt.c
@@ -0,0 +1,120 @@
+/*
+ * QEMU Intel IGD Passthrough Host Bridge Emulation
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci-host/i440fx.h"
+#include "qapi/error.h"
+
+typedef struct {
+    uint8_t offset;
+    uint8_t len;
+} IGDHostInfo;
+
+/* Here we just expose minimal host bridge offset subset. */
+static const IGDHostInfo igd_host_bridge_infos[] = {
+    {PCI_REVISION_ID,         2},
+    {PCI_SUBSYSTEM_VENDOR_ID, 2},
+    {PCI_SUBSYSTEM_ID,        2},
+    {0x50,                    2}, /* SNB: processor graphics control register */
+    {0x52,                    2}, /* processor graphics control register */
+    {0xa4,                    4}, /* SNB: graphics base of stolen memory */
+    {0xa8,                    4}, /* SNB: base of GTT stolen memory */
+};
+
+static void host_pci_config_read(int pos, int len, uint32_t *val, Error **errp)
+{
+    int rc, config_fd;
+    /* Access real host bridge. */
+    char *path = g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.%d/%s",
+                                 0, 0, 0, 0, "config");
+
+    config_fd = open(path, O_RDWR);
+    if (config_fd < 0) {
+        error_setg_errno(errp, errno, "Failed to open: %s", path);
+        goto out;
+    }
+
+    if (lseek(config_fd, pos, SEEK_SET) != pos) {
+        error_setg_errno(errp, errno, "Failed to seek: %s", path);
+        goto out_close_fd;
+    }
+
+    do {
+        rc = read(config_fd, (uint8_t *)val, len);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+    if (rc != len) {
+        error_setg_errno(errp, errno, "Failed to read: %s", path);
+    }
+
+ out_close_fd:
+    close(config_fd);
+ out:
+    g_free(path);
+}
+
+static void igd_pt_i440fx_realize(PCIDevice *pci_dev, Error **errp)
+{
+    uint32_t val = 0;
+    size_t i;
+    int pos, len;
+    Error *local_err = NULL;
+
+    for (i = 0; i < ARRAY_SIZE(igd_host_bridge_infos); i++) {
+        pos = igd_host_bridge_infos[i].offset;
+        len = igd_host_bridge_infos[i].len;
+        host_pci_config_read(pos, len, &val, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+        pci_default_write_config(pci_dev, pos, val, len);
+    }
+}
+
+static void igd_passthrough_i440fx_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = igd_pt_i440fx_realize;
+    dc->desc = "IGD Passthrough Host bridge";
+}
+
+static const TypeInfo igd_passthrough_i440fx_info = {
+    .name          = TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE,
+    .parent        = TYPE_I440FX_PCI_DEVICE,
+    .instance_size = sizeof(PCII440FXState),
+    .class_init    = igd_passthrough_i440fx_class_init,
+};
+
+static void igd_pt_i440fx_register_types(void)
+{
+    type_register_static(&igd_passthrough_i440fx_info);
+}
+
+type_init(igd_pt_i440fx_register_types)
-- 
1.8.3.1



