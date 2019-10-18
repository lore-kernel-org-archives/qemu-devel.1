Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9FACA9EAC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1680C20854
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1680C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLYrL-0006y5-2c
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 16:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iLYla-0007mv-1k
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iLYlY-000618-TR
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iLYlY-00060w-LX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:22:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4BD38E3C7;
 Fri, 18 Oct 2019 20:22:27 +0000 (UTC)
Received: from localhost (ovpn-116-92.ams2.redhat.com [10.36.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 556405D70E;
 Fri, 18 Oct 2019 20:22:20 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] vfio: unplug failover primary device before migration
Date: Fri, 18 Oct 2019 22:20:40 +0200
Message-Id: <20191018202040.30349-12-jfreimann@redhat.com>
In-Reply-To: <20191018202040.30349-1-jfreimann@redhat.com>
References: <20191018202040.30349-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 18 Oct 2019 20:22:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As usual block all vfio-pci devices from being migrated, but make an
exception for failover primary devices. This is achieved by setting
unmigratable to 0 but also add a migration blocker for all vfio-pci
devices except failover primary devices. These will be unplugged before
migration happens by the migration handler of the corresponding
virtio-net standby device.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/vfio/pci.c | 31 +++++++++++++++++++++++++------
 hw/vfio/pci.h |  1 +
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 12fac39804..a15b83c6b6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -40,6 +40,9 @@
 #include "pci.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/blocker.h"
+#include "qemu/option.h"
+#include "qemu/option_int.h"
=20
 #define TYPE_VFIO_PCI "vfio-pci"
 #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
@@ -2712,12 +2715,26 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
     int i, ret;
     bool is_mdev;
=20
+    if (!pdev->net_failover_pair_id) {
+        error_setg(&vdev->migration_blocker,
+                "VFIO device doesn't support migration");
+        ret =3D migrate_add_blocker(vdev->migration_blocker, &err);
+        if (err) {
+            error_propagate(errp, err);
+            goto error;
+        }
+    } else {
+            pdev->qdev.allow_unplug_during_migration =3D true;
+    }
+
     if (!vdev->vbasedev.sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
               ~vdev->host.slot || ~vdev->host.function)) {
             error_setg(errp, "No provided host device");
             error_append_hint(errp, "Use -device vfio-pci,host=3DDDDD:BB=
:DD.F "
                               "or -device vfio-pci,sysfsdev=3DPATH_TO_DE=
VICE\n");
+            migrate_del_blocker(vdev->migration_blocker);
+            error_free(vdev->migration_blocker);
             return;
         }
         vdev->vbasedev.sysfsdev =3D
@@ -2729,6 +2746,8 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
     if (stat(vdev->vbasedev.sysfsdev, &st) < 0) {
         error_setg_errno(errp, errno, "no such host device");
         error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.sysfsdev);
+        migrate_del_blocker(vdev->migration_blocker);
+        error_free(vdev->migration_blocker);
         return;
     }
=20
@@ -3008,6 +3027,8 @@ out_teardown:
     vfio_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+    migrate_del_blocker(vdev->migration_blocker);
+    error_free(vdev->migration_blocker);
 }
=20
 static void vfio_instance_finalize(Object *obj)
@@ -3019,6 +3040,10 @@ static void vfio_instance_finalize(Object *obj)
     vfio_bars_finalize(vdev);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
+    if (vdev->migration_blocker) {
+        migrate_del_blocker(vdev->migration_blocker);
+        error_free(vdev->migration_blocker);
+    }
     /*
      * XXX Leaking igd_opregion is not an oversight, we can't remove the
      * fw_cfg entry therefore leaking this allocation seems like the saf=
est
@@ -3151,11 +3176,6 @@ static Property vfio_pci_dev_properties[] =3D {
     DEFINE_PROP_END_OF_LIST(),
 };
=20
-static const VMStateDescription vfio_pci_vmstate =3D {
-    .name =3D "vfio-pci",
-    .unmigratable =3D 1,
-};
-
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -3163,7 +3183,6 @@ static void vfio_pci_dev_class_init(ObjectClass *kl=
ass, void *data)
=20
     dc->reset =3D vfio_pci_reset;
     dc->props =3D vfio_pci_dev_properties;
-    dc->vmsd =3D &vfio_pci_vmstate;
     dc->desc =3D "VFIO-based PCI device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize =3D vfio_realize;
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 834a90d646..b329d50338 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -168,6 +168,7 @@ typedef struct VFIOPCIDevice {
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
     VFIODisplay *dpy;
+    Error *migration_blocker;
 } VFIOPCIDevice;
=20
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
--=20
2.21.0


