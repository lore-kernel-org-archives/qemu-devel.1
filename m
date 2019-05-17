Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB62C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48D32087B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48D32087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48249 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRcTH-0001LK-3q
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:00:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hRcRp-0000TA-24
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hRcRn-0003EO-OP
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hRcRn-0002x8-GU
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E52673092654
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 12:58:37 +0000 (UTC)
Received: from localhost (dhcp-192-241.str.redhat.com [10.33.192.241])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4012A5D6A9;
	Fri, 17 May 2019 12:58:35 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 14:58:18 +0200
Message-Id: <20190517125820.2885-3-jfreimann@redhat.com>
In-Reply-To: <20190517125820.2885-1-jfreimann@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 17 May 2019 12:58:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] qdev/qbus: Add hidden device support
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

This adds support for hiding a device to the qbus and qdev APIs.
qdev_device_add() is modified to check for a standby argument in the
option string. A DeviceListener callback should_be_hidden() is added. It
can be used by a standby device to inform qdev that this device should
not be added now. The standby device handler can store the device
options to plug the device in at a later point in time.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/core/qdev.c         | 19 +++++++++++++++++++
 hw/vfio/pci.c          |  1 +
 hw/vfio/pci.h          |  1 +
 include/hw/qdev-core.h |  9 +++++++++
 qdev-monitor.c         | 41 ++++++++++++++++++++++++++++++++++++++---
 vl.c                   |  6 ++++--
 6 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 98cdaa6bf7..d55fe00ae7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -211,6 +211,25 @@ void device_listener_unregister(DeviceListener *list=
ener)
     QTAILQ_REMOVE(&device_listeners, listener, link);
 }
=20
+bool qdev_should_hide_device(QemuOpts *opts, Error **errp)
+{
+    bool res =3D false;
+    bool match_found =3D false;
+
+    DeviceListener *listener;
+
+    QTAILQ_FOREACH(listener, &device_listeners, link) {
+       if (listener->should_be_hidden) {
+            listener->should_be_hidden(listener, opts, &match_found, &re=
s);
+        }
+
+        if (match_found) {
+            break;
+        }
+    }
+    return res;
+}
+
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version)
 {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8cecb53d5c..835249c61d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3215,6 +3215,7 @@ static Property vfio_pci_dev_properties[] =3D {
                             display, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
     DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
+    DEFINE_PROP_STRING("standby", VFIOPCIDevice, standby),
     DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
                        intx.mmap_timeout, 1100),
     DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index cfcd1a81b8..1a87f91889 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -135,6 +135,7 @@ typedef struct VFIOPCIDevice {
     PCIHostDeviceAddress host;
     EventNotifier err_notifier;
     EventNotifier req_notifier;
+    char *standby;
     int (*resetfn)(struct VFIOPCIDevice *);
     uint32_t vendor_id;
     uint32_t device_id;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5437395779..d54d3ae62a 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -158,6 +158,13 @@ struct DeviceState {
 struct DeviceListener {
     void (*realize)(DeviceListener *listener, DeviceState *dev);
     void (*unrealize)(DeviceListener *listener, DeviceState *dev);
+    /*
+     * This callback is called just upon init of the DeviceState
+     * and can be used by a standby device for informing qdev if this
+     * device should be hidden by checking the device opts
+     */
+    void (*should_be_hidden)(DeviceListener *listener, QemuOpts *device_=
opts,
+            bool *match_found, bool *res);
     QTAILQ_ENTRY(DeviceListener) link;
 };
=20
@@ -454,4 +461,6 @@ static inline bool qbus_is_hotpluggable(BusState *bus=
)
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
=20
+bool qdev_should_hide_device(QemuOpts *opts, Error **errp);
+
 #endif
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 9cce8b93c2..a81226529a 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -32,8 +32,10 @@
 #include "qemu/help_option.h"
 #include "qemu/option.h"
 #include "qemu/qemu-print.h"
+#include "qemu/option_int.h"
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
+#include "migration/migration.h"
=20
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -561,14 +563,45 @@ void qdev_set_id(DeviceState *dev, const char *id)
     }
 }
=20
+static int is_failover_device(void *opaque, const char *name, const char=
 *value,
+                        Error **errp)
+{
+    if (strcmp(name, "standby") =3D=3D 0) {
+        QemuOpts *opts =3D (QemuOpts *)opaque;
+
+        if (qdev_should_hide_device(opts, errp) && errp && !*errp) {
+            return 1;
+        } else if (errp && *errp) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static bool should_hide_device(QemuOpts *opts, Error **err)
+{
+    if (qemu_opt_foreach(opts, is_failover_device, opts, err) =3D=3D 0) =
{
+        return false;
+    }
+    return true;
+}
+
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 {
     DeviceClass *dc;
     const char *driver, *path;
-    DeviceState *dev;
+    DeviceState *dev =3D NULL;
     BusState *bus =3D NULL;
     Error *err =3D NULL;
=20
+    if (opts && should_hide_device(opts, &err)) {
+        if (err) {
+            goto err_del_dev;
+        }
+        return NULL;
+    }
+
     driver =3D qemu_opt_get(opts, "driver");
     if (!driver) {
         error_setg(errp, QERR_MISSING_PARAMETER, "driver");
@@ -640,8 +673,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error *=
*errp)
=20
 err_del_dev:
     error_propagate(errp, err);
-    object_unparent(OBJECT(dev));
-    object_unref(OBJECT(dev));
+    if (dev) {
+        object_unparent(OBJECT(dev));
+        object_unref(OBJECT(dev));
+    }
     return NULL;
 }
=20
diff --git a/vl.c b/vl.c
index b6709514c1..4b5b878275 100644
--- a/vl.c
+++ b/vl.c
@@ -2355,10 +2355,12 @@ static int device_init_func(void *opaque, QemuOpt=
s *opts, Error **errp)
     DeviceState *dev;
=20
     dev =3D qdev_device_add(opts, errp);
-    if (!dev) {
+    if (!dev && *errp) {
+        error_report_err(*errp);
         return -1;
+    } else if (dev) {
+        object_unref(OBJECT(dev));
     }
-    object_unref(OBJECT(dev));
     return 0;
 }
=20
--=20
2.21.0


