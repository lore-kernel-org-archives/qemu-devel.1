Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B75BCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0235D222C7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGo03DYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0235D222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQ27-0006H3-Js
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 07:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iPQ0f-0004eu-Tc
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iPQ0e-0002Eh-7h
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:50:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39089
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iPQ0e-0002EM-46
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572349799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OI8mQHo6NpJ2TX7FUKcl4Coaz0cX7IW7/TlAD8b3TEo=;
 b=VGo03DYTlByBUcSgjfBVBgmMVZH6oVZcrp5JBLG8Y1l3FvwGfOiAmd6lRnxT0yjT10c4Gt
 iGpCasWJdPKEuyEwddkaRJt5Waqbi4hT1V/baIGT6IiotyZAtKLofiHirATE0NykvnOiyv
 kSPNDQzJkr64HG2JjkCSbxtewqUr61c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-6ZkR-M8rPl6aR14tf3oa7w-1; Tue, 29 Oct 2019 07:49:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35E101800D55;
 Tue, 29 Oct 2019 11:49:55 +0000 (UTC)
Received: from localhost (ovpn-116-231.ams2.redhat.com [10.36.116.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 653A45D6C3;
 Tue, 29 Oct 2019 11:49:24 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 01/11] qdev/qbus: add hidden device support
Date: Tue, 29 Oct 2019 12:48:55 +0100
Message-Id: <20191029114905.6856-2-jfreimann@redhat.com>
In-Reply-To: <20191029114905.6856-1-jfreimann@redhat.com>
References: <20191029114905.6856-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 6ZkR-M8rPl6aR14tf3oa7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 jasowang@redhat.com, quintela@redhat.com, dgilbert@redhat.com,
 armbru@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 pbonzini@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds support for hiding a device to the qbus and qdev APIs.  The
first user of this will be the virtio-net failover feature but the API
introduced with this patch could be used to implement other features as
well, for example hiding pci devices when a pci bus is powered off.

qdev_device_add() is modified to check for a failover_pair_id
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

A device is hidden when it has an "failover_pair_id" option, e.g.

 -device virtio-net-pci,...,failover=3Don,...
 -device vfio-pci,...,failover_pair_id=3Dnet1,...

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/core/qdev.c         | 24 ++++++++++++++++++++++++
 include/hw/qdev-core.h | 29 +++++++++++++++++++++++++++++
 qdev-monitor.c         | 41 +++++++++++++++++++++++++++++++++++++----
 vl.c                   |  6 ++++--
 4 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cbad6c1d55..3b8d43d0fd 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -212,6 +212,30 @@ void device_listener_unregister(DeviceListener *listen=
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
+            /*
+             * should_be_hidden_will return
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
index 148df9cacf..ffa08c670f 100644
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
+    if (strcmp(name, "failover_pair_id") =3D=3D 0) {
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
index 4a7d011661..171f11be39 100644
--- a/vl.c
+++ b/vl.c
@@ -2207,10 +2207,12 @@ static int device_init_func(void *opaque, QemuOpts =
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


