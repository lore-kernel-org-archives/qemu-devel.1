Received: from eggs.gnu.org ([2001:4830:134:3::10]:33984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5v-0004Id-Gp
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5u-00075e-CJ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:31 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:25:02 +0200
Message-Id: <20180504072514.8450-4-cohuck@redhat.com>
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] vfio-ccw: introduce vfio_ccw_get_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Cornelia Huck <cohuck@redhat.com>

From: Greg Kurz <groug@kaod.org>

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
Message-Id: <152326891065.266543.9487977590811413472.stgit@bahia.lan>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 56 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index fe34b50769..e67392c5f9 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -292,12 +292,43 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
     g_free(vcdev->io_region);
 }
 
-static void vfio_put_device(VFIOCCWDevice *vcdev)
+static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
 {
     g_free(vcdev->vdev.name);
     vfio_put_base_device(&vcdev->vdev);
 }
 
+static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
+                                Error **errp)
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
+    return;
+
+out_err:
+    g_free(name);
+}
+
 static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
 {
     char *tmp, group_path[PATH_MAX];
@@ -327,7 +358,6 @@ static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
 
 static void vfio_ccw_realize(DeviceState *dev, Error **errp)
 {
-    VFIODevice *vbasedev;
     VFIOGroup *group;
     CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
     S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
@@ -348,22 +378,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
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
+    vfio_ccw_get_device(group, vcdev, &err);
+    if (err) {
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
-- 
2.14.3
