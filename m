Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB19C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA272067D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUyLnJCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA272067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDYb-0006FI-NI
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iYCdW-0003cy-Oj
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iYCdV-0001vW-4g
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:22:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iYCdT-0001u5-E0
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574443339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ffbV2BlO2cY+0qeZrPbZ/ijsUUk8eXq7GdXnQ5l0Wx8=;
 b=KUyLnJCE6KXodupMbAuEAFzOcKVxwHSnUezmyxJJLNcdF/Dvc5zC5TGUHvhs8O+J+xtjUP
 htMqTqKrtguG8a/pWQ4C1WxbFRDOK3SzdqIdDMrX1+Q0+wD6FTxiBrkCb44r6iCuHHbs9a
 V7Gq0AwtpgegOyvFmBKFc5V091stGxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-e62D11FINXSp98GMwSrfJg-1; Fri, 22 Nov 2019 12:22:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A20318C8B74;
 Fri, 22 Nov 2019 17:22:15 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-36.brq.redhat.com [10.40.204.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2456C6E71F;
 Fri, 22 Nov 2019 17:22:03 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.0] hw/pci-host: Add Kconfig selector for IGD PCIe
 pass-through
Date: Fri, 22 Nov 2019 18:22:01 +0100
Message-Id: <20191122172201.11456-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: e62D11FINXSp98GMwSrfJg-1
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a kconfig selector to allow builds without Intel
Integrated Graphics Device GPU PCIe passthrough.
We keep the default as enabled.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC because to be able to use the Kconfig-generated
"config-devices.h" header we have to move this device
out of $common-obj and build i440fx.o on a per-target
basis, which is not optimal...
---
 hw/pci-host/i440fx.c      | 9 ++++++++-
 hw/vfio/pci-quirks.c      | 6 ++++++
 hw/pci-host/Kconfig       | 5 +++++
 hw/pci-host/Makefile.objs | 2 +-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index f27131102d..41e93581f4 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -34,6 +34,7 @@
 #include "hw/pci-host/pam.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
+#include "config-devices.h"
=20
 /*
  * I440FX chipset data sheet.
@@ -386,6 +387,8 @@ static const TypeInfo i440fx_info =3D {
     },
 };
=20
+#ifdef CONFIG_INTEL_IGD_PASSTHROUGH
+
 /* IGD Passthrough Host Bridge. */
 typedef struct {
     uint8_t offset;
@@ -470,6 +473,8 @@ static const TypeInfo igd_passthrough_i440fx_info =3D {
     .class_init    =3D igd_passthrough_i440fx_class_init,
 };
=20
+#endif /* CONFIG_INTEL_IGD_PASSTHROUGH */
+
 static const char *i440fx_pcihost_root_bus_path(PCIHostState *host_bridge,
                                                 PCIBus *rootbus)
 {
@@ -514,8 +519,10 @@ static const TypeInfo i440fx_pcihost_info =3D {
 static void i440fx_register_types(void)
 {
     type_register_static(&i440fx_info);
-    type_register_static(&igd_passthrough_i440fx_info);
     type_register_static(&i440fx_pcihost_info);
+#ifdef CONFIG_INTEL_IGD_PASSTHROUGH
+    type_register_static(&igd_passthrough_i440fx_info);
+#endif /* CONFIG_INTEL_IGD_PASSTHROUGH */
 }
=20
 type_init(i440fx_register_types)
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 136f3a9ad6..858148fa39 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1166,6 +1166,8 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevi=
ce *vdev, int nr)
     trace_vfio_quirk_rtl8168_probe(vdev->vbasedev.name);
 }
=20
+#ifdef CONFIG_INTEL_IGD_PASSTHROUGH
+
 /*
  * Intel IGD support
  *
@@ -1811,6 +1813,8 @@ out:
     g_free(lpc);
 }
=20
+#endif /* CONFIG_INTEL_IGD_PASSTHROUGH */
+
 /*
  * Common quirk probe entry points.
  */
@@ -1860,7 +1864,9 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr=
)
     vfio_probe_nvidia_bar5_quirk(vdev, nr);
     vfio_probe_nvidia_bar0_quirk(vdev, nr);
     vfio_probe_rtl8168_bar2_quirk(vdev, nr);
+#ifdef CONFIG_INTEL_IGD_PASSTHROUGH
     vfio_probe_igd_bar4_quirk(vdev, nr);
+#endif /* CONFIG_INTEL_IGD_PASSTHROUGH */
 }
=20
 void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index b0aa8351c4..0b7539765a 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -1,6 +1,10 @@
 config PAM
     bool
=20
+config INTEL_IGD_PASSTHROUGH
+    default y
+    bool
+
 config PREP_PCI
     bool
     select PCI
@@ -32,6 +36,7 @@ config PCI_I440FX
     bool
     select PCI
     select PAM
+    imply INTEL_IGD_PASSTHROUGH
=20
 config PCI_EXPRESS_Q35
     bool
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index efd752b766..3c925192dd 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -13,7 +13,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
=20
 common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
 common-obj-$(CONFIG_FULONG) +=3D bonito.o
-common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
+obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
 common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o
--=20
2.21.0


