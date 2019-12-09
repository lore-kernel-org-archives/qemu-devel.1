Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7724C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13F92072D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wq/ID6ZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13F92072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieFkf-0005SP-R1
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieFgt-0000Fx-OJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieFgs-0000oK-05
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieFgr-0000oE-Ss
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575885053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vV4BdXxrJs33eazwg4k8OQaJDOeixo6CZUflsfdJpk=;
 b=Wq/ID6ZSCyg3uTZmpe+foqyoU0fnxKlfId2jc+CJePqKBt1PB/ElJYNF0rDscGtkZJP+5Y
 x/OI9Sfddc4gEOdi+D3UC8MfxGgy+VlgD5+PjgJEaRGw0ZF4H3s9W1NdyALMuVAfR+s8Vo
 xoX79Oq0LKQ6nQ5/TWeXlr9UZC6x/YI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-55SXMpbaMIG-zKzwsagGjA-1; Mon, 09 Dec 2019 04:50:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8729107ACC4;
 Mon,  9 Dec 2019 09:50:50 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-142.brq.redhat.com [10.40.205.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4BF319C5B;
 Mon,  9 Dec 2019 09:50:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v3 5/6] hw/pci-host/i440fx: Extract the IGD
 passthrough host bridge device
Date: Mon,  9 Dec 2019 10:50:01 +0100
Message-Id: <20191209095002.32194-6-philmd@redhat.com>
In-Reply-To: <20191209095002.32194-1-philmd@redhat.com>
References: <20191209095002.32194-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 55SXMpbaMIG-zKzwsagGjA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can use a i440FX without the IGD passthrough host bridge.
Extract it into a new file, 'hw/pci-host/igd_pt.c'.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3:
- Rename as 'xen_igd_pt.c' (Alex Williamson)
- Add an entry in MAINTAINERS::Xen
---
 hw/pci-host/i440fx.c      |  84 --------------------------
 hw/pci-host/xen_igd_pt.c  | 120 ++++++++++++++++++++++++++++++++++++++
 MAINTAINERS               |   1 +
 hw/pci-host/Makefile.objs |   1 +
 4 files changed, 122 insertions(+), 84 deletions(-)
 create mode 100644 hw/pci-host/xen_igd_pt.c

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 414138595b..bae7b42327 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -368,89 +368,6 @@ static const TypeInfo i440fx_info =3D {
     },
 };
=20
-/* IGD Passthrough Host Bridge. */
-typedef struct {
-    uint8_t offset;
-    uint8_t len;
-} IGDHostInfo;
-
-/* Here we just expose minimal host bridge offset subset. */
-static const IGDHostInfo igd_host_bridge_infos[] =3D {
-    {PCI_REVISION_ID,         2},
-    {PCI_SUBSYSTEM_VENDOR_ID, 2},
-    {PCI_SUBSYSTEM_ID,        2},
-    {0x50,                    2}, /* SNB: processor graphics control regis=
ter */
-    {0x52,                    2}, /* processor graphics control register *=
/
-    {0xa4,                    4}, /* SNB: graphics base of stolen memory *=
/
-    {0xa8,                    4}, /* SNB: base of GTT stolen memory */
-};
-
-static void host_pci_config_read(int pos, int len, uint32_t *val, Error **=
errp)
-{
-    int rc, config_fd;
-    /* Access real host bridge. */
-    char *path =3D g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.%d=
/%s",
-                                 0, 0, 0, 0, "config");
-
-    config_fd =3D open(path, O_RDWR);
-    if (config_fd < 0) {
-        error_setg_errno(errp, errno, "Failed to open: %s", path);
-        goto out;
-    }
-
-    if (lseek(config_fd, pos, SEEK_SET) !=3D pos) {
-        error_setg_errno(errp, errno, "Failed to seek: %s", path);
-        goto out_close_fd;
-    }
-
-    do {
-        rc =3D read(config_fd, (uint8_t *)val, len);
-    } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
-    if (rc !=3D len) {
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
-    uint32_t val =3D 0;
-    size_t i;
-    int pos, len;
-    Error *local_err =3D NULL;
-
-    for (i =3D 0; i < ARRAY_SIZE(igd_host_bridge_infos); i++) {
-        pos =3D igd_host_bridge_infos[i].offset;
-        len =3D igd_host_bridge_infos[i].len;
-        host_pci_config_read(pos, len, &val, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-        pci_default_write_config(pci_dev, pos, val, len);
-    }
-}
-
-static void igd_passthrough_i440fx_class_init(ObjectClass *klass, void *da=
ta)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
-
-    k->realize =3D igd_pt_i440fx_realize;
-    dc->desc =3D "IGD Passthrough Host bridge";
-}
-
-static const TypeInfo igd_passthrough_i440fx_info =3D {
-    .name          =3D TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE,
-    .parent        =3D TYPE_I440FX_PCI_DEVICE,
-    .instance_size =3D sizeof(PCII440FXState),
-    .class_init    =3D igd_passthrough_i440fx_class_init,
-};
-
 static const char *i440fx_pcihost_root_bus_path(PCIHostState *host_bridge,
                                                 PCIBus *rootbus)
 {
@@ -495,7 +412,6 @@ static const TypeInfo i440fx_pcihost_info =3D {
 static void i440fx_register_types(void)
 {
     type_register_static(&i440fx_info);
-    type_register_static(&igd_passthrough_i440fx_info);
     type_register_static(&i440fx_pcihost_info);
 }
=20
diff --git a/hw/pci-host/xen_igd_pt.c b/hw/pci-host/xen_igd_pt.c
new file mode 100644
index 0000000000..efcc9347ff
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
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
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
+static const IGDHostInfo igd_host_bridge_infos[] =3D {
+    {PCI_REVISION_ID,         2},
+    {PCI_SUBSYSTEM_VENDOR_ID, 2},
+    {PCI_SUBSYSTEM_ID,        2},
+    {0x50,                    2}, /* SNB: processor graphics control regis=
ter */
+    {0x52,                    2}, /* processor graphics control register *=
/
+    {0xa4,                    4}, /* SNB: graphics base of stolen memory *=
/
+    {0xa8,                    4}, /* SNB: base of GTT stolen memory */
+};
+
+static void host_pci_config_read(int pos, int len, uint32_t *val, Error **=
errp)
+{
+    int rc, config_fd;
+    /* Access real host bridge. */
+    char *path =3D g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.%d=
/%s",
+                                 0, 0, 0, 0, "config");
+
+    config_fd =3D open(path, O_RDWR);
+    if (config_fd < 0) {
+        error_setg_errno(errp, errno, "Failed to open: %s", path);
+        goto out;
+    }
+
+    if (lseek(config_fd, pos, SEEK_SET) !=3D pos) {
+        error_setg_errno(errp, errno, "Failed to seek: %s", path);
+        goto out_close_fd;
+    }
+
+    do {
+        rc =3D read(config_fd, (uint8_t *)val, len);
+    } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+    if (rc !=3D len) {
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
+    uint32_t val =3D 0;
+    size_t i;
+    int pos, len;
+    Error *local_err =3D NULL;
+
+    for (i =3D 0; i < ARRAY_SIZE(igd_host_bridge_infos); i++) {
+        pos =3D igd_host_bridge_infos[i].offset;
+        len =3D igd_host_bridge_infos[i].len;
+        host_pci_config_read(pos, len, &val, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+        pci_default_write_config(pci_dev, pos, val, len);
+    }
+}
+
+static void igd_passthrough_i440fx_class_init(ObjectClass *klass, void *da=
ta)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->realize =3D igd_pt_i440fx_realize;
+    dc->desc =3D "IGD Passthrough Host bridge";
+}
+
+static const TypeInfo igd_passthrough_i440fx_info =3D {
+    .name          =3D TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE,
+    .parent        =3D TYPE_I440FX_PCI_DEVICE,
+    .instance_size =3D sizeof(PCII440FXState),
+    .class_init    =3D igd_passthrough_i440fx_class_init,
+};
+
+static void igd_pt_i440fx_register_types(void)
+{
+    type_register_static(&igd_passthrough_i440fx_info);
+}
+
+type_init(igd_pt_i440fx_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e3e52d6..62bcf5e94e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -419,6 +419,7 @@ F: hw/block/dataplane/xen*
 F: hw/xen/
 F: hw/xenpv/
 F: hw/i386/xen/
+F: hw/pci-host/xen_igd_pt.c
 F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/sysemu/xen-mapcache.h
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index efd752b766..fa6d1556c0 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -14,6 +14,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
 common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
 common-obj-$(CONFIG_FULONG) +=3D bonito.o
 common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
+common-obj-$(CONFIG_PCI_I440FX) +=3D xen_igd_pt.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
 common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o
--=20
2.21.0


