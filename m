Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357D1CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43F92084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCVnNoUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43F92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNC4Y-0004wp-0U
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNBze-0002v9-90
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNBzb-0005te-LG
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37896
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNBzS-0005mp-Ge
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571819253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1mXYBWjlIW+rCQl00usBp8V13DJOB43c4Zk4huMvtw=;
 b=QCVnNoUw6dzHUOPdtjk1i16wr6sYGmxH0YPogxLfxGBRNI/RSW1XfiKZLOKBFCC4qOzVVk
 2t9AuRN6tLtPc9+rJ+AuS90gX6lrXpo0wRAJBIIok+i9EQGVPgnwgvc/ACqH4PxsvginS2
 bDq/ep9ad+v8e5ibFpUg8D6NMhGh8VA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-ofTJ5aN6Ormn2l3eygDQRw-1; Wed, 23 Oct 2019 04:27:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 922221800E01;
 Wed, 23 Oct 2019 08:27:29 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9E2B60628;
 Wed, 23 Oct 2019 08:27:21 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/11] qdev/qbus: add hidden device support
Date: Wed, 23 Oct 2019 10:27:01 +0200
Message-Id: <20191023082711.16694-2-jfreimann@redhat.com>
In-Reply-To: <20191023082711.16694-1-jfreimann@redhat.com>
References: <20191023082711.16694-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ofTJ5aN6Ormn2l3eygDQRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/core/qdev.c         | 23 +++++++++++++++++++++++
 include/hw/qdev-core.h | 29 +++++++++++++++++++++++++++++
 qdev-monitor.c         | 41 +++++++++++++++++++++++++++++++++++++----
 vl.c                   |  6 ++++--
 4 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cbad6c1d55..f786650446 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -212,6 +212,29 @@ void device_listener_unregister(DeviceListener *listen=
er)
     QTAILQ_REMOVE(&device_listeners, listener, link);
 }
=20
+bool qdev_should_hide_device(QemuOpts *opts)
+{
+    int rc =3D -1;
+    DeviceListener *listener;
+
+    QTAILQ_FOREACH(listener, &device_listeners, link) {
+       if (listener->should_be_hidden) {
+            /* should_be_hidden_will return
+             *  1 if device matches opts and it should be hidden
+             *  0 if device matches opts and should not be hidden
+             *  -1 if device doesn't match opts
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
index aa123f88cb..710981af36 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -78,6 +78,19 @@ typedef void (*BusUnrealize)(BusState *bus, Error **errp=
);
  * respective parent types.
  *   </para>
  * </note>
+ *
+ * # Hiding a device #
+ * To hide a device, a DeviceListener function should_be_hidden() needs to
+ * be registered.
+ * It can be used to defer adding a device and therefore hide it from the
+ * guest. The handler registering to this DeviceListener can save the QOpt=
s
+ * passed to it for re-using it later and must return that it wants the de=
vice
+ * to be/remain hidden or not. When the handler function decides the devic=
e
+ * shall not be hidden it will be added in qdev_device_add() and
+ * realized as any other device. Otherwise qdev_device_add() will return e=
arly
+ * without adding the device. The guest will not see a "hidden" device
+ * until it was marked don't hide and qdev_device_add called again.
+ *
  */
 typedef struct DeviceClass {
     /*< private >*/
@@ -154,6 +167,12 @@ struct DeviceState {
 struct DeviceListener {
     void (*realize)(DeviceListener *listener, DeviceState *dev);
     void (*unrealize)(DeviceListener *listener, DeviceState *dev);
+    /*
+     * This callback is called upon init of the DeviceState and allows to
+     * inform qdev that a device should be hidden, depending on the device
+     * opts, for example, to hide a standby device.
+     */
+    int (*should_be_hidden)(DeviceListener *listener, QemuOpts *device_opt=
s);
     QTAILQ_ENTRY(DeviceListener) link;
 };
=20
@@ -451,4 +470,14 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
=20
+/**
+ * @qdev_should_hide_device:
+ * @opts: QemuOpts as passed on cmdline.
+ *
+ * Check if a device should be added.
+ * When a device is added via qdev_device_add() this will be called,
+ * and return if the device should be added now or not.
+ */
+bool qdev_should_hide_device(QemuOpts *opts);
+
 #endif
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 148df9cacf..676a759fb4 100644
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
@@ -562,13 +564,36 @@ void qdev_set_id(DeviceState *dev, const char *id)
     }
 }
=20
+static int is_failover_device(void *opaque, const char *name, const char *=
value,
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
+    if (qemu_opt_foreach(opts, is_failover_device, opts, NULL) =3D=3D 0) {
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
+    bool hide;
=20
     driver =3D qemu_opt_get(opts, "driver");
     if (!driver) {
@@ -602,11 +627,17 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **=
errp)
             return NULL;
         }
     }
-    if (qdev_hotplug && bus && !qbus_is_hotpluggable(bus)) {
+    hide =3D should_hide_device(opts);
+
+    if ((hide || qdev_hotplug) && bus && !qbus_is_hotpluggable(bus)) {
         error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
         return NULL;
     }
=20
+    if (hide) {
+        return NULL;
+    }
+
     if (!migration_is_idle()) {
         error_setg(errp, "device_add not allowed while migrating");
         return NULL;
@@ -648,8 +679,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **e=
rrp)
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
@@ -2204,10 +2204,12 @@ static int device_init_func(void *opaque, QemuOpts =
*opts, Error **errp)
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


