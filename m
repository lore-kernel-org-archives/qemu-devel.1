Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E162C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E942087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E942087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRcWL-0003cj-Ie
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:03:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hRcRq-0000Tx-5U
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hRcRo-0003GG-Vf
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hRcRo-0003Ez-PS
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29F503092654
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 12:58:52 +0000 (UTC)
Received: from localhost (dhcp-192-241.str.redhat.com [10.33.192.241])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 40B355C241;
	Fri, 17 May 2019 12:58:47 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 14:58:20 +0200
Message-Id: <20190517125820.2885-5-jfreimann@redhat.com>
In-Reply-To: <20190517125820.2885-1-jfreimann@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 17 May 2019 12:58:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] vfio/pci: unplug failover primary device
 before migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	mst@redhat.com, aadam@redhat.com, laine@redhat.com, ailan@redhat.com
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
 hw/vfio/pci.c | 24 +++++++++++++++++++++++-
 hw/vfio/pci.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 835249c61d..60cda7dbc9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -34,6 +34,9 @@
 #include "pci.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/blocker.h"
+#include "qemu/option.h"
+#include "qemu/option_int.h"
=20
 #define MSIX_CAP_LENGTH 12
=20
@@ -2803,6 +2806,12 @@ static void vfio_unregister_req_notifier(VFIOPCIDe=
vice *vdev)
     vdev->req_enabled =3D false;
 }
=20
+static int has_standby_arg(void *opaque, const char *name,
+                           const char *value, Error **errp)
+{
+    return strcmp(name, "standby") =3D=3D 0;
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
@@ -2816,6 +2825,19 @@ static void vfio_realize(PCIDevice *pdev, Error **=
errp)
     int i, ret;
     bool is_mdev;
=20
+    if (qemu_opt_foreach(pdev->qdev.opts, has_standby_arg,
+                         (void *) pdev->qdev.opts, &err) =3D=3D 0) {
+        error_setg(&vdev->migration_blocker,
+                "VFIO device doesn't support migration");
+        ret =3D migrate_add_blocker(vdev->migration_blocker, &err);
+        if (err) {
+            error_propagate(errp, err);
+            error_free(vdev->migration_blocker);
+        }
+    } else {
+        pdev->qdev.allow_unplug_during_migration =3D true;
+    }
+
     if (!vdev->vbasedev.sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
               ~vdev->host.slot || ~vdev->host.function)) {
@@ -3258,7 +3280,7 @@ static Property vfio_pci_dev_properties[] =3D {
=20
 static const VMStateDescription vfio_pci_vmstate =3D {
     .name =3D "vfio-pci",
-    .unmigratable =3D 1,
+    .unmigratable =3D 0,
 };
=20
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 1a87f91889..390ba2c767 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -170,6 +170,7 @@ typedef struct VFIOPCIDevice {
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
     VFIODisplay *dpy;
+    Error *migration_blocker;
 } VFIOPCIDevice;
=20
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
--=20
2.21.0


