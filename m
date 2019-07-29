Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D14C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F04F21773
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F04F21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs84A-0000aj-AK
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 12:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hs83S-00008r-Ca
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hs83R-0002HV-27
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hs83Q-0002Gk-Qe
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:59:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A65B830C133F
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 15:59:15 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-222.ams2.redhat.com
 [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B30E60BE5;
 Mon, 29 Jul 2019 15:59:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, berrange@redhat.com, cohuck@redhat.com,
 mst@redhat.com
Date: Mon, 29 Jul 2019 16:59:09 +0100
Message-Id: <20190729155909.22804-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 29 Jul 2019 15:59:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [for 4.1 PATCH] Revert "hw: report invalid
 disable-legacy|modern usage for virtio-1-only devs"
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This reverts commit f2784eed306449c3d04a71a05ed6463b8289aedf
since that accidentally removes the PCIe capabilities from virtio
devices because virtio_pci_dc_realize is called before the new 'mode'
flag is set.
I keep the expanded hw_compat entry because we've lost the ability to
do 'optional'.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/display/virtio-gpu-pci.c   |  4 +---
 hw/display/virtio-vga.c       |  4 +---
 hw/virtio/virtio-crypto-pci.c |  4 +---
 hw/virtio/virtio-input-pci.c  |  4 +---
 hw/virtio/virtio-pci.c        | 26 ++++++++++----------------
 hw/virtio/virtio-pci.h        | 31 ++++++-------------------------
 6 files changed, 20 insertions(+), 53 deletions(-)

diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index d6f01b4a98..e4c7eb6193 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -33,9 +33,7 @@ static void virtio_gpu_pci_base_realize(VirtIOPCIProxy =
*vpci_dev, Error **errp)
     Error *local_error =3D NULL;
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
-        return;
-    }
+    virtio_pci_force_virtio_1(vpci_dev);
     object_property_set_bool(OBJECT(vdev), true, "realized", &local_erro=
r);
=20
     if (local_error) {
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 416e7fec87..79a145e284 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -137,9 +137,7 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
=20
     /* init virtio bits */
     qdev_set_parent_bus(DEVICE(g), BUS(&vpci_dev->bus));
-    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
-        return;
-    }
+    virtio_pci_force_virtio_1(vpci_dev);
     object_property_set_bool(OBJECT(g), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.=
c
index c8a2317a10..91d4446080 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -53,9 +53,7 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
     }
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
-        return;
-    }
+    virtio_pci_force_virtio_1(vpci_dev);
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
     object_property_set_link(OBJECT(vcrypto),
                  OBJECT(vcrypto->vdev.conf.cryptodev), "cryptodev",
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index 1c40292abc..ad7774e93e 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -49,9 +49,7 @@ static void virtio_input_pci_realize(VirtIOPCIProxy *vp=
ci_dev, Error **errp)
     DeviceState *vdev =3D DEVICE(&vinput->vdev);
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
-        return;
-    }
+    virtio_pci_force_virtio_1(vpci_dev);
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
 }
=20
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ce928f2429..f6d2223e78 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1723,22 +1723,16 @@ static void virtio_pci_realize(PCIDevice *pci_dev=
, Error **errp)
                        /* PCI BAR regions must be powers of 2 */
                        pow2ceil(proxy->notify.offset + proxy->notify.siz=
e));
=20
-    if ((proxy->disable_legacy =3D=3D ON_OFF_AUTO_ON) ||
-        ((proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) && pcie_port)) =
{
-        if (proxy->disable_modern) {
-            error_setg(errp, "device cannot work as neither modern nor "
-                       "legacy mode is enabled");
-            error_append_hint(errp, "Set either disable-modern or "
-                              "disable-legacy to off\n");
-            return;
-        }
-        proxy->mode =3D VIRTIO_PCI_MODE_MODERN;
-    } else {
-        if (proxy->disable_modern) {
-            proxy->mode =3D VIRTIO_PCI_MODE_LEGACY;
-        } else {
-            proxy->mode =3D VIRTIO_PCI_MODE_TRANSITIONAL;
-        }
+    if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) {
+        proxy->disable_legacy =3D pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AU=
TO_OFF;
+    }
+
+    if (!virtio_pci_modern(proxy) && !virtio_pci_legacy(proxy)) {
+        error_setg(errp, "device cannot work as neither modern nor legac=
y mode"
+                   " is enabled");
+        error_append_hint(errp, "Set either disable-modern or disable-le=
gacy"
+                          " to off\n");
+        return;
     }
=20
     if (pcie_port && pci_is_express(pci_dev)) {
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 619d9098c1..292275acb1 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -15,7 +15,6 @@
 #ifndef QEMU_VIRTIO_PCI_H
 #define QEMU_VIRTIO_PCI_H
=20
-#include "qapi/error.h"
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-bus.h"
=20
@@ -119,12 +118,6 @@ typedef struct VirtIOPCIQueue {
   uint32_t used[2];
 } VirtIOPCIQueue;
=20
-typedef enum {
-    VIRTIO_PCI_MODE_LEGACY,
-    VIRTIO_PCI_MODE_TRANSITIONAL,
-    VIRTIO_PCI_MODE_MODERN,
-} VirtIOPCIMode;
-
 struct VirtIOPCIProxy {
     PCIDevice pci_dev;
     MemoryRegion bar;
@@ -149,7 +142,6 @@ struct VirtIOPCIProxy {
     bool disable_modern;
     bool ignore_backend_features;
     OnOffAuto disable_legacy;
-    VirtIOPCIMode mode;
     uint32_t class_code;
     uint32_t nvectors;
     uint32_t dfselect;
@@ -164,34 +156,23 @@ struct VirtIOPCIProxy {
=20
 static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)
 {
-    return proxy->mode !=3D VIRTIO_PCI_MODE_LEGACY;
+    return !proxy->disable_modern;
 }
=20
 static inline bool virtio_pci_legacy(VirtIOPCIProxy *proxy)
 {
-    return proxy->mode !=3D VIRTIO_PCI_MODE_MODERN;
+    return proxy->disable_legacy =3D=3D ON_OFF_AUTO_OFF;
 }
=20
-static inline bool virtio_pci_force_virtio_1(VirtIOPCIProxy *proxy,
-                                             Error **errp)
+static inline void virtio_pci_force_virtio_1(VirtIOPCIProxy *proxy)
 {
-    if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_OFF) {
-        error_setg(errp, "Unable to set disable-legacy=3Doff on a virtio=
-1.0 "
-                   "only device");
-        return false;
-    }
-    if (proxy->disable_modern =3D=3D true) {
-        error_setg(errp, "Unable to set disable-modern=3Don on a virtio-=
1.0 "
-                   "only device");
-        return false;
-    }
-    proxy->mode =3D VIRTIO_PCI_MODE_MODERN;
-    return true;
+    proxy->disable_modern =3D false;
+    proxy->disable_legacy =3D ON_OFF_AUTO_ON;
 }
=20
 static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
 {
-    proxy->mode =3D VIRTIO_PCI_MODE_LEGACY;
+    proxy->disable_modern =3D true;
 }
=20
 /*
--=20
2.21.0


