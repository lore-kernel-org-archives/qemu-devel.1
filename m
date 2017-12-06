Received: from eggs.gnu.org ([2001:4830:134:3::10]:50790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMawR-00067i-HZ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMawO-0001do-Cf
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:44:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMawO-0001cy-4Y
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:44:52 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6EiRdt083959
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 09:44:48 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ephdt5hgr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 09:44:47 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:44:45 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 15:44:37 +0100
In-Reply-To: <20171206144438.28908-1-pasic@linux.vnet.ibm.com>
References: <20171206144438.28908-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171206144438.28908-2-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/2] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

The default css 0xfe is currently restricted to virtual subchannel
devices. The hope when the decision was made was, that non-virtual
subchannel devices will come around when guest can exploit multiple
channel subsystems. Since the guests generally don't do, the pain
of the partitioned (cssid) namespace outweighs the gain.

Let us remove the corresponding restrictions (virtual devices
can be put only in 0xfe and non-virtual devices in any css except
the 0xfe -- while s390-squash-mcss then remaps everything to cssid 0).

At the same time, change our schema for generating css bus ids to put
both virtual and non-virtual devices into the default css (spilling over
into other css images, if needed). The intention is to deprecate
s390-squash-mcss. With this change devices without a specified devno
won't end up hidden to guests not supporting multiple channel subsystems,
unless this can not be avoided (default css full).

Let us also advertise the changes to the management software (so it can
tell are cssids unrestricted or restricted).

The adverse effect of getting rid of the restriction on migration should
not be too severe.  Vfio-ccw devices are not live-migratable yet, and for
virtual devices using the extra freedom would only make sense with the
aforementioned guest support in place.

The auto-generated bus ids are affected by both changes. We hope to not
encounter any auto-generated bus ids in production as Libvirt is always
explicit about the bus id.  Since 8ed179c937 ("s390x/css: catch section
mismatch on load", 2017-05-18) the worst that can happen because the same
device ended up having a different bus id is a cleanly failed migration.
I find it hard to reason about the impact of changed auto-generated bus
ids on migration for command line users as I don't know which rules is
such an user supposed to follow.

Another pain-point is down- or upgrade of QEMU for command line users.
The old way and the new way of doing vfio-ccw are mutually incompatible.
Libvirt is only going to support the new way, so for libvirt users, the
possible problems at QEMU downgrade are the following. If a domain
contains virtual devices placed into a css different than 0xfe the domain
will refuse to start with a QEMU not having this patch. Putting devices
into a css different that 0xfe however won't make much sense in the near
future (guest support). Libvirt will refuse to do vfio-ccw with a QEMU
not having this patch. This is business as usual.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/s390x/3270-ccw.c        |  2 +-
 hw/s390x/css-bridge.c      | 11 +++++++++++
 hw/s390x/css.c             | 28 ++++------------------------
 hw/s390x/s390-ccw.c        |  2 +-
 hw/s390x/s390-virtio-ccw.c |  1 -
 hw/s390x/virtio-ccw.c      |  2 +-
 include/hw/s390x/css.h     | 12 ++++--------
 7 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 081e3ef6f4..3af13ea027 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -104,7 +104,7 @@ static void emulated_ccw_3270_realize(DeviceState *ds, Error **errp)
     SubchDev *sch;
     Error *err = NULL;
 
-    sch = css_create_sch(cdev->devno, true, cbus->squash_mcss, errp);
+    sch = css_create_sch(cdev->devno, cbus->squash_mcss, errp);
     if (!sch) {
         return;
     }
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index c4a9735d71..a91a237f37 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -123,6 +123,11 @@ static Property virtual_css_bridge_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static bool prop_get_true(Object *obj, Error **errp)
+{
+    return true;
+}
+
 static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
 {
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
@@ -131,6 +136,12 @@ static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
     hc->unplug = ccw_device_unplug;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->props = virtual_css_bridge_properties;
+    object_class_property_add_bool(klass, "cssid-unrestricted",
+                                   prop_get_true, NULL, NULL);
+    object_class_property_set_description(klass, "cssid-unrestricted",
+            "A css device can use any cssid, regardless whether virtual"
+            " or not (read only, always true)",
+            NULL);
 }
 
 static const TypeInfo virtual_css_bridge_info = {
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f6b5c807cd..cd26f32050 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2370,22 +2370,12 @@ const PropertyInfo css_devid_ro_propinfo = {
     .get = get_css_devid,
 };
 
-SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
-                         Error **errp)
+SubchDev *css_create_sch(CssDevId bus_id, bool squash_mcss, Error **errp)
 {
     uint16_t schid = 0;
     SubchDev *sch;
 
     if (bus_id.valid) {
-        if (is_virtual != (bus_id.cssid == VIRTUAL_CSSID)) {
-            error_setg(errp, "cssid %hhx not valid for %s devices",
-                       bus_id.cssid,
-                       (is_virtual ? "virtual" : "non-virtual"));
-            return NULL;
-        }
-    }
-
-    if (bus_id.valid) {
         if (squash_mcss) {
             bus_id.cssid = channel_subsys.default_cssid;
         } else if (!channel_subsys.css[bus_id.cssid]) {
@@ -2396,19 +2386,8 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
                                            bus_id.devid, &schid, errp)) {
             return NULL;
         }
-    } else if (squash_mcss || is_virtual) {
-        bus_id.cssid = channel_subsys.default_cssid;
-
-        if (!css_find_free_subch_and_devno(bus_id.cssid, &bus_id.ssid,
-                                           &bus_id.devid, &schid, errp)) {
-            return NULL;
-        }
     } else {
-        for (bus_id.cssid = 0; bus_id.cssid < MAX_CSSID; ++bus_id.cssid) {
-            if (bus_id.cssid == VIRTUAL_CSSID) {
-                continue;
-            }
-
+        for (bus_id.cssid = channel_subsys.default_cssid;;) {
             if (!channel_subsys.css[bus_id.cssid]) {
                 css_create_css_image(bus_id.cssid, false);
             }
@@ -2418,7 +2397,8 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
                                                 NULL)) {
                 break;
             }
-            if (bus_id.cssid == MAX_CSSID) {
+            bus_id.cssid = (bus_id.cssid + 1) % MAX_CSSID;
+            if (bus_id.cssid == channel_subsys.default_cssid) {
                 error_setg(errp, "Virtual channel subsystem is full!");
                 return NULL;
             }
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 0ef232ec27..4a9d4d2534 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -77,7 +77,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
         goto out_err_propagate;
     }
 
-    sch = css_create_sch(ccw_dev->devno, false, cbus->squash_mcss, &err);
+    sch = css_create_sch(ccw_dev->devno, cbus->squash_mcss, &err);
     if (!sch) {
         goto out_mdevid_free;
     }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 6a57f94197..4d65a50334 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -302,7 +302,6 @@ static void ccw_init(MachineState *machine)
     /*
      * Non mcss-e enabled guests only see the devices from the default
      * css, which is determined by the value of the squash_mcss property.
-     * Note: we must not squash non virtual devices to css 0xFE.
      */
     if (css_bus->squash_mcss) {
         ret = css_create_css_image(0, true);
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 184515ce94..3dd902a664 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -701,7 +701,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
     SubchDev *sch;
     Error *err = NULL;
 
-    sch = css_create_sch(ccw_dev->devno, true, cbus->squash_mcss, errp);
+    sch = css_create_sch(ccw_dev->devno, cbus->squash_mcss, errp);
     if (!sch) {
         return;
     }
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index ab6ebe66b5..53c270a216 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -272,12 +272,9 @@ extern const PropertyInfo css_devid_ro_propinfo;
  * default css image for it.
  * If @p bus_id is valid, and @p squash_mcss is false, verify that it is
  * not already in use, and find a free devno for it.
- * If @p bus_id is not valid, and if either @p squash_mcss or @p is_virtual
- * is true, find a free subchannel id and device number across all
- * subchannel sets from the default css image.
- * If @p bus_id is not valid, and if both @p squash_mcss and @p is_virtual
- * are false, find a non-full css image and find a free subchannel id and
- * device number across all subchannel sets from it.
+ * If @p bus_id is not valid find a free subchannel id and device number
+ * across all subchannel sets and all css images starting from the default
+ * css image.
  *
  * If either of the former actions succeed, allocate a subchannel structure,
  * initialise it with the bus id, subchannel id and device number, register
@@ -286,8 +283,7 @@ extern const PropertyInfo css_devid_ro_propinfo;
  * The caller becomes owner of the returned subchannel structure and
  * is responsible for unregistering and freeing it.
  */
-SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
-                         Error **errp);
+SubchDev *css_create_sch(CssDevId bus_id, bool squash_mcss, Error **errp);
 
 /** Turn on css migration */
 void css_register_vmstate(void);
-- 
2.13.5
