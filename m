Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5102C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A43221EB
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZILbjUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A43221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUXj-0001uX-JY
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 12:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kHUTP-0002WN-Vy
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 12:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kHUTN-0001PS-QN
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 12:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600013004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94QPVLjwe1t4l2fwJemLaiw6W4T3PPvSQSBnRNEvSaY=;
 b=gZILbjUMsJ1/xXufCRrQ3wy0jNu4mR6J3INO5fIM/jFlzYyETHOGPFxu03DUGKtAhDPCxK
 IiMTzHJi8XSE0Dc31WGQs3oO8y9evAqPW0XiWPuUXpq6PyRWfOCWMpoFfakRoD50QSRQgS
 BF5x94lE0OM5aJeRTTGReUfHHdsqfgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-Zv3IbnF-OwqSyXcsZs9NEQ-1; Sun, 13 Sep 2020 12:03:22 -0400
X-MC-Unique: Zv3IbnF-OwqSyXcsZs9NEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DCEA1DE0E;
 Sun, 13 Sep 2020 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EF1719C4F;
 Sun, 13 Sep 2020 16:03:19 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/9] device-core: use RCU for list of childs of a bus
Date: Sun, 13 Sep 2020 19:02:54 +0300
Message-Id: <20200913160259.32145-5-mlevitsk@redhat.com>
In-Reply-To: <20200913160259.32145-1-mlevitsk@redhat.com>
References: <20200913160259.32145-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 12:03:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Maxim Levitsky <mlevitsk@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/core/bus.c          | 28 ++++++++++++++++++----------
 hw/core/qdev.c         | 37 +++++++++++++++++++++++--------------
 hw/scsi/scsi-bus.c     | 17 ++++++++++++++---
 hw/scsi/virtio-scsi.c  |  6 +++++-
 include/hw/qdev-core.h |  9 +++++++++
 5 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 6b987b6946..385eb3ad5a 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -49,12 +49,14 @@ int qbus_walk_children(BusState *bus,
         }
     }
 
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        err = qdev_walk_children(kid->child,
-                                 pre_devfn, pre_busfn,
-                                 post_devfn, post_busfn, opaque);
-        if (err < 0) {
-            return err;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
+            err = qdev_walk_children(kid->child,
+                                     pre_devfn, pre_busfn,
+                                     post_devfn, post_busfn, opaque);
+            if (err < 0) {
+                return err;
+            }
         }
     }
 
@@ -90,9 +92,13 @@ static void bus_reset_child_foreach(Object *obj, ResettableChildCallback cb,
     BusState *bus = BUS(obj);
     BusChild *kid;
 
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+    rcu_read_lock();
+
+    QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
         cb(OBJECT(kid->child), opaque, type);
     }
+
+    rcu_read_unlock();
 }
 
 static void qbus_init(BusState *bus, DeviceState *parent, const char *name)
@@ -194,9 +200,11 @@ static void bus_set_realized(Object *obj, bool value, Error **errp)
 
         /* TODO: recursive realization */
     } else if (!value && bus->realized) {
-        QTAILQ_FOREACH(kid, &bus->children, sibling) {
-            DeviceState *dev = kid->child;
-            qdev_unrealize(dev);
+        WITH_RCU_READ_LOCK_GUARD() {
+            QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
+                DeviceState *dev = kid->child;
+                qdev_unrealize(dev);
+            }
         }
         if (bc->unrealize) {
             bc->unrealize(bus);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 96772a15bd..28e5fff5ed 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -51,6 +51,12 @@ const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
     return dc->vmsd;
 }
 
+static void bus_free_bus_child(BusChild *kid)
+{
+    object_unref(OBJECT(kid->child));
+    g_free(kid);
+}
+
 static void bus_remove_child(BusState *bus, DeviceState *child)
 {
     BusChild *kid;
@@ -60,15 +66,16 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
             char name[32];
 
             snprintf(name, sizeof(name), "child[%d]", kid->index);
-            QTAILQ_REMOVE(&bus->children, kid, sibling);
+            QTAILQ_REMOVE_RCU(&bus->children, kid, sibling);
 
             bus->num_children--;
 
             /* This gives back ownership of kid->child back to us.  */
             object_property_del(OBJECT(bus), name);
-            object_unref(OBJECT(kid->child));
-            g_free(kid);
-            return;
+
+            /* free the bus kid, when it is safe to do so*/
+            call_rcu(kid, bus_free_bus_child, rcu);
+            break;
         }
     }
 }
@@ -83,7 +90,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
     kid->child = child;
     object_ref(OBJECT(kid->child));
 
-    QTAILQ_INSERT_HEAD(&bus->children, kid, sibling);
+    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
 
     /* This transfers ownership of kid->child to the property.  */
     snprintf(name, sizeof(name), "child[%d]", kid->index);
@@ -659,17 +666,19 @@ DeviceState *qdev_find_recursive(BusState *bus, const char *id)
     DeviceState *ret;
     BusState *child;
 
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        DeviceState *dev = kid->child;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
+            DeviceState *dev = kid->child;
 
-        if (dev->id && strcmp(dev->id, id) == 0) {
-            return dev;
-        }
+            if (dev->id && strcmp(dev->id, id) == 0) {
+                return dev;
+            }
 
-        QLIST_FOREACH(child, &dev->child_bus, sibling) {
-            ret = qdev_find_recursive(child, id);
-            if (ret) {
-                return ret;
+            QLIST_FOREACH(child, &dev->child_bus, sibling) {
+                ret = qdev_find_recursive(child, id);
+                if (ret) {
+                    return ret;
+                }
             }
         }
     }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f8adfbc2a5..92d412b65c 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -400,7 +400,10 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
     id = r->req.dev->id;
     found_lun0 = false;
     n = 0;
-    QTAILQ_FOREACH(kid, &r->req.bus->qbus.children, sibling) {
+
+    rcu_read_lock();
+
+    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
         DeviceState *qdev = kid->child;
         SCSIDevice *dev = SCSI_DEVICE(qdev);
 
@@ -421,7 +424,7 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
     memset(r->buf, 0, len);
     stl_be_p(&r->buf[0], n);
     i = found_lun0 ? 8 : 16;
-    QTAILQ_FOREACH(kid, &r->req.bus->qbus.children, sibling) {
+    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
         DeviceState *qdev = kid->child;
         SCSIDevice *dev = SCSI_DEVICE(qdev);
 
@@ -430,6 +433,9 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
             i += 8;
         }
     }
+
+    rcu_read_unlock();
+
     assert(i == n + 8);
     r->len = len;
     return true;
@@ -1572,12 +1578,15 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
     BusChild *kid;
     SCSIDevice *target_dev = NULL;
 
-    QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
+    rcu_read_lock();
+
+    QTAILQ_FOREACH_RCU(kid, &bus->qbus.children, sibling) {
         DeviceState *qdev = kid->child;
         SCSIDevice *dev = SCSI_DEVICE(qdev);
 
         if (dev->channel == channel && dev->id == id) {
             if (dev->lun == lun) {
+                rcu_read_unlock();
                 return dev;
             }
 
@@ -1591,6 +1600,8 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
             }
         }
     }
+
+    rcu_read_unlock();
     return target_dev;
 }
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3a71ea7097..971afbb217 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -367,12 +367,16 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
     case VIRTIO_SCSI_T_TMF_I_T_NEXUS_RESET:
         target = req->req.tmf.lun[1];
         s->resetting++;
-        QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
+
+        rcu_read_lock();
+        QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {
              d = SCSI_DEVICE(kid->child);
              if (d->channel == 0 && d->id == target) {
                 qdev_reset_all(&d->qdev);
              }
         }
+        rcu_read_unlock();
+
         s->resetting--;
         break;
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e025ba9653..7f91c8ead4 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -3,6 +3,8 @@
 
 #include "qemu/queue.h"
 #include "qemu/bitmap.h"
+#include "qemu/rcu.h"
+#include "qemu/rcu_queue.h"
 #include "qom/object.h"
 #include "hw/hotplug.h"
 #include "hw/resettable.h"
@@ -229,6 +231,7 @@ struct BusClass {
 };
 
 typedef struct BusChild {
+    struct rcu_head rcu;
     DeviceState *child;
     int index;
     QTAILQ_ENTRY(BusChild) sibling;
@@ -249,6 +252,12 @@ struct BusState {
     int max_index;
     bool realized;
     int num_children;
+
+    /*
+     * children is a RCU QTAILQ, thus readers must use RCU to access it,
+     * and writers must hold the big qemu lock
+     */
+
     QTAILQ_HEAD(, BusChild) children;
     QLIST_ENTRY(BusState) sibling;
     ResettableState reset;
-- 
2.26.2


