Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE50EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B87B206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgjBV05Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B87B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPBGG-0000VA-R8
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jPBFZ-000838-J9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jPBFX-00043K-T0
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jPBFX-00042v-PY
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587069399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMa/5d3tGunme1aUOe1TbXlozhP9DjIscaSAWG74tqw=;
 b=OgjBV05YxsxohNOb/IgI4Q/OlZNwz12mnnPQJqPxChcRa7rYuCWKNmqiB7coAfuCAIiXPI
 h0nF21PTpuM4PzhOWRuyHqEHoCH//tLMbgXLWNA8ftJ8hnx9B5/Q2NGW5C2BThIrvezXcr
 ZJ2wNN5AIXKFEYjFWierL8lYvgyzONM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-Ho9U53NXNYqTsfC2X5ZzFA-1; Thu, 16 Apr 2020 16:36:37 -0400
X-MC-Unique: Ho9U53NXNYqTsfC2X5ZzFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32CEC8010F1;
 Thu, 16 Apr 2020 20:36:36 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EFB5A099C;
 Thu, 16 Apr 2020 20:36:34 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] device-core: use RCU for list of childs of a bus
Date: Thu, 16 Apr 2020 23:36:22 +0300
Message-Id: <20200416203624.32366-3-mlevitsk@redhat.com>
In-Reply-To: <20200416203624.32366-1-mlevitsk@redhat.com>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes the race between device emulation code that tries to find
a child device to dispatch the request to (e.g a scsi disk),
and hotplug of a new device to that bus.

Note that this doesn't convert all the readers of the list
but only these that might go over that list without BQL held.

This is a very small first step to make this code thread safe.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/core/bus.c                  | 43 ++++++++++++++++++++-----------
 hw/core/qdev.c                 | 46 +++++++++++++++++++++++-----------
 hw/scsi/scsi-bus.c             | 17 ++++++++++---
 hw/scsi/virtio-scsi.c          |  6 ++++-
 include/hw/qdev-core.h         |  3 +++
 include/hw/virtio/virtio-bus.h |  7 ++++--
 6 files changed, 87 insertions(+), 35 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 3dc0a825f0..cb7756ded1 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -49,12 +49,14 @@ int qbus_walk_children(BusState *bus,
         }
     }
=20
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        err =3D qdev_walk_children(kid->child,
-                                 pre_devfn, pre_busfn,
-                                 post_devfn, post_busfn, opaque);
-        if (err < 0) {
-            return err;
+    WITH_RCU_READ_LOCK_GUARD(){
+        QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
+            err =3D qdev_walk_children(kid->child,
+                                     pre_devfn, pre_busfn,
+                                     post_devfn, post_busfn, opaque);
+            if (err < 0) {
+                return err;
+            }
         }
     }
=20
@@ -90,9 +92,13 @@ static void bus_reset_child_foreach(Object *obj, Resetta=
bleChildCallback cb,
     BusState *bus =3D BUS(obj);
     BusChild *kid;
=20
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+    rcu_read_lock();
+
+    QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
         cb(OBJECT(kid->child), opaque, type);
     }
+
+    rcu_read_unlock();
 }
=20
 static void qbus_realize(BusState *bus, DeviceState *parent, const char *n=
ame)
@@ -138,10 +144,15 @@ static void bus_unparent(Object *obj)
     /* Only the main system bus has no parent, and that bus is never freed=
 */
     assert(bus->parent);
=20
-    while ((kid =3D QTAILQ_FIRST(&bus->children)) !=3D NULL) {
+    rcu_read_lock();
+
+    while ((kid =3D QTAILQ_FIRST_RCU(&bus->children)) !=3D NULL) {
         DeviceState *dev =3D kid->child;
         object_unparent(OBJECT(dev));
     }
+
+    rcu_read_unlock();
+
     QLIST_REMOVE(bus, sibling);
     bus->parent->num_child_bus--;
     bus->parent =3D NULL;
@@ -185,14 +196,18 @@ static void bus_set_realized(Object *obj, bool value,=
 Error **errp)
=20
         /* TODO: recursive realization */
     } else if (!value && bus->realized) {
-        QTAILQ_FOREACH(kid, &bus->children, sibling) {
-            DeviceState *dev =3D kid->child;
-            object_property_set_bool(OBJECT(dev), false, "realized",
-                                     &local_err);
-            if (local_err !=3D NULL) {
-                break;
+
+        WITH_RCU_READ_LOCK_GUARD(){
+            QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
+                DeviceState *dev =3D kid->child;
+                object_property_set_bool(OBJECT(dev), false, "realized",
+                                         &local_err);
+                if (local_err !=3D NULL) {
+                    break;
+                }
             }
         }
+
         if (bc->unrealize && local_err =3D=3D NULL) {
             bc->unrealize(bus, &local_err);
         }
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 85f062def7..f0c87e582e 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -50,26 +50,37 @@ const VMStateDescription *qdev_get_vmsd(DeviceState *de=
v)
     return dc->vmsd;
 }
=20
+static void bus_free_bus_child(BusChild *kid)
+{
+    object_unref(OBJECT(kid->child));
+    g_free(kid);
+}
+
 static void bus_remove_child(BusState *bus, DeviceState *child)
 {
     BusChild *kid;
=20
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+    rcu_read_lock();
+
+    QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
         if (kid->child =3D=3D child) {
             char name[32];
=20
             snprintf(name, sizeof(name), "child[%d]", kid->index);
-            QTAILQ_REMOVE(&bus->children, kid, sibling);
+            QTAILQ_REMOVE_RCU(&bus->children, kid, sibling);
=20
             bus->num_children--;
=20
             /* This gives back ownership of kid->child back to us.  */
             object_property_del(OBJECT(bus), name, NULL);
-            object_unref(OBJECT(kid->child));
-            g_free(kid);
-            return;
+
+            /* free the bus kid, when it is safe to do so*/
+            call_rcu(kid, bus_free_bus_child, rcu);
+            break;
         }
     }
+
+    rcu_read_unlock();
 }
=20
 static void bus_add_child(BusState *bus, DeviceState *child)
@@ -82,7 +93,9 @@ static void bus_add_child(BusState *bus, DeviceState *chi=
ld)
     kid->child =3D child;
     object_ref(OBJECT(kid->child));
=20
-    QTAILQ_INSERT_HEAD(&bus->children, kid, sibling);
+    rcu_read_lock();
+    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
+    rcu_read_unlock();
=20
     /* This transfers ownership of kid->child to the property.  */
     snprintf(name, sizeof(name), "child[%d]", kid->index);
@@ -681,20 +694,23 @@ DeviceState *qdev_find_recursive(BusState *bus, const=
 char *id)
     DeviceState *ret;
     BusState *child;
=20
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        DeviceState *dev =3D kid->child;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
+            DeviceState *dev =3D kid->child;
=20
-        if (dev->id && strcmp(dev->id, id) =3D=3D 0) {
-            return dev;
-        }
+            if (dev->id && strcmp(dev->id, id) =3D=3D 0) {
+                return dev;
+            }
=20
-        QLIST_FOREACH(child, &dev->child_bus, sibling) {
-            ret =3D qdev_find_recursive(child, id);
-            if (ret) {
-                return ret;
+            QLIST_FOREACH(child, &dev->child_bus, sibling) {
+                ret =3D qdev_find_recursive(child, id);
+                if (ret) {
+                    return ret;
+                }
             }
         }
     }
+
     return NULL;
 }
=20
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 7bbc37acec..2bf6d005f3 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -412,7 +412,10 @@ static bool scsi_target_emulate_report_luns(SCSITarget=
Req *r)
     id =3D r->req.dev->id;
     found_lun0 =3D false;
     n =3D 0;
-    QTAILQ_FOREACH(kid, &r->req.bus->qbus.children, sibling) {
+
+    rcu_read_lock();
+
+    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
         DeviceState *qdev =3D kid->child;
         SCSIDevice *dev =3D SCSI_DEVICE(qdev);
=20
@@ -433,7 +436,7 @@ static bool scsi_target_emulate_report_luns(SCSITargetR=
eq *r)
     memset(r->buf, 0, len);
     stl_be_p(&r->buf[0], n);
     i =3D found_lun0 ? 8 : 16;
-    QTAILQ_FOREACH(kid, &r->req.bus->qbus.children, sibling) {
+    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
         DeviceState *qdev =3D kid->child;
         SCSIDevice *dev =3D SCSI_DEVICE(qdev);
=20
@@ -442,6 +445,9 @@ static bool scsi_target_emulate_report_luns(SCSITargetR=
eq *r)
             i +=3D 8;
         }
     }
+
+    rcu_read_unlock();
+
     assert(i =3D=3D n + 8);
     r->len =3D len;
     return true;
@@ -1584,12 +1590,15 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int chan=
nel, int id, int lun)
     BusChild *kid;
     SCSIDevice *target_dev =3D NULL;
=20
-    QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
+    rcu_read_lock();
+
+    QTAILQ_FOREACH_RCU(kid, &bus->qbus.children, sibling) {
         DeviceState *qdev =3D kid->child;
         SCSIDevice *dev =3D SCSI_DEVICE(qdev);
=20
         if (dev->channel =3D=3D channel && dev->id =3D=3D id) {
             if (dev->lun =3D=3D lun) {
+                rcu_read_unlock();
                 return dev;
             }
=20
@@ -1603,6 +1612,8 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channe=
l, int id, int lun)
             }
         }
     }
+
+    rcu_read_unlock();
     return target_dev;
 }
=20
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 472bbd233b..b0f4a35f81 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -367,12 +367,16 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSC=
SIReq *req)
     case VIRTIO_SCSI_T_TMF_I_T_NEXUS_RESET:
         target =3D req->req.tmf.lun[1];
         s->resetting++;
-        QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
+
+        rcu_read_lock();
+        QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {
              d =3D SCSI_DEVICE(kid->child);
              if (d->channel =3D=3D 0 && d->id =3D=3D target) {
                 qdev_reset_all(&d->qdev);
              }
         }
+        rcu_read_unlock();
+
         s->resetting--;
         break;
=20
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 1405b8a990..196253978b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -3,6 +3,8 @@
=20
 #include "qemu/queue.h"
 #include "qemu/bitmap.h"
+#include "qemu/rcu.h"
+#include "qemu/rcu_queue.h"
 #include "qom/object.h"
 #include "hw/hotplug.h"
 #include "hw/resettable.h"
@@ -218,6 +220,7 @@ struct BusClass {
 };
=20
 typedef struct BusChild {
+    struct rcu_head rcu;
     DeviceState *child;
     int index;
     QTAILQ_ENTRY(BusChild) sibling;
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.=
h
index 38c9399cd4..58733f28e2 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -128,8 +128,11 @@ void virtio_bus_set_vdev_config(VirtioBusState *bus, u=
int8_t *config);
 static inline VirtIODevice *virtio_bus_get_device(VirtioBusState *bus)
 {
     BusState *qbus =3D &bus->parent_obj;
-    BusChild *kid =3D QTAILQ_FIRST(&qbus->children);
-    DeviceState *qdev =3D kid ? kid->child : NULL;
+    BusChild *kid;
+    DeviceState *qdev;
+
+    kid =3D QTAILQ_FIRST(&qbus->children);
+    qdev =3D kid ? kid->child : NULL;
=20
     /* This is used on the data path, the cast is guaranteed
      * to succeed by the qdev machinery.
--=20
2.17.2


