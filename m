Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB40CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F91B2082C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F91B2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLYln-0007at-Pz
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 16:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iLYkB-0005cX-1L
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iLYk9-0005bS-G4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:21:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iLYk9-0005aq-7n
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:21:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A55A30842A9;
 Fri, 18 Oct 2019 20:21:00 +0000 (UTC)
Received: from localhost (ovpn-116-92.ams2.redhat.com [10.36.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C16A5D70E;
 Fri, 18 Oct 2019 20:20:52 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/11] qdev/qbus: add hidden device support
Date: Fri, 18 Oct 2019 22:20:30 +0200
Message-Id: <20191018202040.30349-2-jfreimann@redhat.com>
In-Reply-To: <20191018202040.30349-1-jfreimann@redhat.com>
References: <20191018202040.30349-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 18 Oct 2019 20:21:00 +0000 (UTC)
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

This adds support for hiding a device to the qbus and qdev APIs.  The
first user of this will be the virtio-net failover feature but the API
introduced with this patch could be used to implement other features as
well, for example hiding pci devices when a pci bus is powered off.

qdev_device_add() is modified to check for a net_failover_pair_id
argument in the option string. A DeviceListener callback
should_be_hidden() is added. It can be used by a standby device to
inform qdev that this device should not be added now. The standby device
handler can store the device options to plug the device in at a later
point in time.

One reason for hiding the device is that we don't want to expose both
devices to the guest kernel until the respective virtio feature bit
VIRTIO_NET_F_STANDBY was negotiated and we know that the devices will be
handled correctly by the guest.

More information on the kernel feature this is using:
 https://www.kernel.org/doc/html/latest/networking/net_failover.html

An example where the primary device is a vfio-pci device and the standby
device is a virtio-net device:

A device is hidden when it has an "net_failover_pair_id" option, e.g.

 -device virtio-net-pci,...,failover=3Don,...
 -device vfio-pci,...,net_failover_pair_id=3Dnet1,...

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/core/qdev.c         | 23 +++++++++++++++++++++++
 include/hw/qdev-core.h |  8 ++++++++
 qdev-monitor.c         | 36 +++++++++++++++++++++++++++++++++---
 vl.c                   |  6 ++++--
 4 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cbad6c1d55..89c134ec53 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -212,6 +212,29 @@ void device_listener_unregister(DeviceListener *list=
ener)
     QTAILQ_REMOVE(&device_listeners, listener, link);
 }
=20
+bool qdev_should_hide_device(QemuOpts *opts)
+{
+    int rc;
+    DeviceListener *listener;
+
+    QTAILQ_FOREACH(listener, &device_listeners, link) {
+       if (listener->should_be_hidden) {
+            /* should_be_hidden_will return
+             *  1 if device matches opts and it should be hidden
+             *  0 if device matches opts and should not be hidden
+             *  -1 if device doesn't match ops
+             */
+            rc =3D listener->should_be_hidden(listener, opts);
+        }
+
+        if (rc > 0) {
+            break;
+        }
+    }
+
+    return rc > 0;
+}
+
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version)
 {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index aa123f88cb..28f594a47d 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -154,6 +154,12 @@ struct DeviceState {
 struct DeviceListener {
     void (*realize)(DeviceListener *listener, DeviceState *dev);
     void (*unrealize)(DeviceListener *listener, DeviceState *dev);
+    /*
+     * This callback is called upon init of the DeviceState and allows t=
o
+     * inform qdev that a device should be hidden, depending on the devi=
ce
+     * opts, for example, to hide a standby device.
+     */
+    int (*should_be_hidden)(DeviceListener *listener, QemuOpts *device_o=
pts);
     QTAILQ_ENTRY(DeviceListener) link;
 };
=20
@@ -451,4 +457,6 @@ static inline bool qbus_is_hotpluggable(BusState *bus=
)
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
=20
+bool qdev_should_hide_device(QemuOpts *opts);
+
 #endif
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 148df9cacf..508d85df87 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -32,9 +32,11 @@
 #include "qemu/help_option.h"
 #include "qemu/option.h"
 #include "qemu/qemu-print.h"
+#include "qemu/option_int.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "migration/misc.h"
+#include "migration/migration.h"
=20
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -562,14 +564,40 @@ void qdev_set_id(DeviceState *dev, const char *id)
     }
 }
=20
+static int is_failover_device(void *opaque, const char *name, const char=
 *value,
+                        Error **errp)
+{
+    if (strcmp(name, "net_failover_pair_id") =3D=3D 0) {
+        QemuOpts *opts =3D (QemuOpts *)opaque;
+
+        if (qdev_should_hide_device(opts)) {
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
+static bool should_hide_device(QemuOpts *opts)
+{
+    if (qemu_opt_foreach(opts, is_failover_device, opts, NULL) =3D=3D 0)=
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
+    if (opts && should_hide_device(opts)) {
+        return NULL;
+    }
+
     driver =3D qemu_opt_get(opts, "driver");
     if (!driver) {
         error_setg(errp, QERR_MISSING_PARAMETER, "driver");
@@ -648,8 +676,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error *=
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
index 4489cfb2bb..62c388cb49 100644
--- a/vl.c
+++ b/vl.c
@@ -2204,10 +2204,12 @@ static int device_init_func(void *opaque, QemuOpt=
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


