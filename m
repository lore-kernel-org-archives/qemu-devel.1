Received: from eggs.gnu.org ([2001:4830:134:3::10]:48553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f4p4f-0002uU-DF
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 10:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f4p4a-0001I9-0e
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 10:44:12 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:40388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f4p4Z-0001HY-PR
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 10:44:07 -0400
Received: from player773.ha.ovh.net (unknown [10.109.108.60])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4E154AB895
	for <qemu-devel@nongnu.org>; Sat,  7 Apr 2018 16:44:06 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 07 Apr 2018 16:44:01 +0200
Message-ID: <152311224179.203086.10603697792860546407.stgit@bahia>
In-Reply-To: <152311221072.203086.16767398863033055271.stgit@bahia>
References: <152311221072.203086.16767398863033055271.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 2/2] vfio-ccw: introduce
 vfio_ccw_get_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

A recent patch fixed leaks of the dynamically allocated vcdev->vdev.name
field in vfio_ccw_realize(), but we now have three freeing sites for it.
This is unfortunate and seems to indicate something is wrong with its
life cycle.

The root issue is that vcdev->vdev.name is set before vfio_get_device()
is called, which theoretically prevents to call vfio_put_device() to
do the freeing. Well actually, we could call it anyway  because
vfio_put_base_device() is a nop if the device isn't attached, but this
would be confusing.

This patch hence moves all the logic of attaching the device, including
the "already attached" check, to a separate vfio_ccw_get_device() function,
counterpart of vfio_put_device(). While here, vfio_put_device() is renamed
to vfio_ccw_put_device() for consistency.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/vfio/ccw.c |   56 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index fe34b507699f..49ae986d288d 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -292,12 +292,44 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
     g_free(vcdev->io_region);
 }
 
-static void vfio_put_device(VFIOCCWDevice *vcdev)
+static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
 {
     g_free(vcdev->vdev.name);
     vfio_put_base_device(&vcdev->vdev);
 }
 
+static int vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
+                               Error **errp)
+{
+    char *name = g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
+                                 vcdev->cdev.hostid.ssid,
+                                 vcdev->cdev.hostid.devid);
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(vbasedev, &group->device_list, next) {
+        if (strcmp(vbasedev->name, name) == 0) {
+            error_setg(errp, "vfio: subchannel %s has already been attached",
+                       name);
+            goto out_err;
+        }
+    }
+
+    if (vfio_get_device(group, vcdev->cdev.mdevid, &vcdev->vdev, errp)) {
+        goto out_err;
+    }
+
+    vcdev->vdev.ops = &vfio_ccw_ops;
+    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
+    vcdev->vdev.name = name;
+    vcdev->vdev.dev = &vcdev->cdev.parent_obj.parent_obj;
+
+    return 0;
+
+out_err:
+    g_free(name);
+    return -1;
+}
+
 static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
 {
     char *tmp, group_path[PATH_MAX];
@@ -327,7 +359,6 @@ static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
 
 static void vfio_ccw_realize(DeviceState *dev, Error **errp)
 {
-    VFIODevice *vbasedev;
     VFIOGroup *group;
     CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
     S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
@@ -348,22 +379,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_group_err;
     }
 
-    vcdev->vdev.ops = &vfio_ccw_ops;
-    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
-    vcdev->vdev.name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
-                                       cdev->hostid.ssid, cdev->hostid.devid);
-    vcdev->vdev.dev = dev;
-    QLIST_FOREACH(vbasedev, &group->device_list, next) {
-        if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
-            error_setg(&err, "vfio: subchannel %s has already been attached",
-                       vcdev->vdev.name);
-            g_free(vcdev->vdev.name);
-            goto out_device_err;
-        }
-    }
-
-    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, &err)) {
-        g_free(vcdev->vdev.name);
+    if (vfio_ccw_get_device(group, vcdev, &err)) {
         goto out_device_err;
     }
 
@@ -382,7 +398,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
 out_notifier_err:
     vfio_ccw_put_region(vcdev);
 out_region_err:
-    vfio_put_device(vcdev);
+    vfio_ccw_put_device(vcdev);
 out_device_err:
     vfio_put_group(group);
 out_group_err:
@@ -403,7 +419,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
 
     vfio_ccw_unregister_io_notifier(vcdev);
     vfio_ccw_put_region(vcdev);
-    vfio_put_device(vcdev);
+    vfio_ccw_put_device(vcdev);
     vfio_put_group(group);
 
     if (cdc->unrealize) {
