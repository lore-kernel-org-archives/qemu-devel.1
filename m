Received: from eggs.gnu.org ([2001:4830:134:3::10]:43704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhSxM-0003fj-4q
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhSxJ-0004mu-3i
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:61814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fhSxI-0004mc-Qv
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:21 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Mon, 23 Jul 2018 12:59:54 +0800
Message-Id: <20180723045956.27521-2-tiwei.bie@intel.com>
In-Reply-To: <20180723045956.27521-1-tiwei.bie@intel.com>
References: <20180723045956.27521-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [RFC 1/3] vfio: split vfio_get_group() into small
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: tiwei.bie@intel.com

This patch splits vfio_get_group() into small functions.
It makes it easier to implement other vfio_get_group*()
functions in the future.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/vfio/common.c | 83 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 28 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fb396cf00a..52a05532cd 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1279,37 +1279,20 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 }
 
-VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
+static VFIOGroup *vfio_init_group(int groupfd, int groupid, AddressSpace *as,
+                                  Error **errp)
 {
     VFIOGroup *group;
-    char path[32];
     struct vfio_group_status status = { .argsz = sizeof(status) };
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        if (group->groupid == groupid) {
-            /* Found it.  Now is it already in the right context? */
-            if (group->container->space->as == as) {
-                return group;
-            } else {
-                error_setg(errp, "group %d used in multiple address spaces",
-                           group->groupid);
-                return NULL;
-            }
-        }
-    }
-
     group = g_malloc0(sizeof(*group));
 
-    snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open(path, O_RDWR);
-    if (group->fd < 0) {
-        error_setg_errno(errp, errno, "failed to open %s", path);
-        goto free_group_exit;
-    }
+    group->fd = groupfd;
+    group->groupid = groupid;
 
     if (ioctl(group->fd, VFIO_GROUP_GET_STATUS, &status)) {
         error_setg_errno(errp, errno, "failed to get group %d status", groupid);
-        goto close_fd_exit;
+        goto free_group_exit;
     }
 
     if (!(status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
@@ -1317,16 +1300,15 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
         error_append_hint(errp,
                           "Please ensure all devices within the iommu_group "
                           "are bound to their vfio bus driver.\n");
-        goto close_fd_exit;
+        goto free_group_exit;
     }
 
-    group->groupid = groupid;
     QLIST_INIT(&group->device_list);
 
     if (vfio_connect_container(group, as, errp)) {
         error_prepend(errp, "failed to setup container for group %d: ",
                       groupid);
-        goto close_fd_exit;
+        goto free_group_exit;
     }
 
     if (QLIST_EMPTY(&vfio_group_list)) {
@@ -1337,15 +1319,60 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
 
     return group;
 
-close_fd_exit:
-    close(group->fd);
-
 free_group_exit:
     g_free(group);
 
     return NULL;
 }
 
+static VFIOGroup *vfio_find_group(int groupid, AddressSpace *as,
+                                  Error **errp)
+{
+    VFIOGroup *group;
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        if (group->groupid == groupid) {
+            /* Found it.  Now is it already in the right context? */
+            if (group->container->space->as == as) {
+                return group;
+            } else {
+                error_setg(errp, "group %d used in multiple address spaces",
+                           group->groupid);
+                return NULL;
+            }
+        }
+    }
+
+    return NULL;
+}
+
+VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
+{
+    VFIOGroup *group;
+    char path[32];
+    int groupfd;
+
+    group = vfio_find_group(groupid, as, errp);
+    if (group) {
+        return group;
+    }
+
+    snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
+    groupfd = qemu_open(path, O_RDWR);
+    if (groupfd < 0) {
+        error_setg_errno(errp, errno, "failed to open %s", path);
+        return NULL;
+    }
+
+    group = vfio_init_group(groupfd, groupid, as, errp);
+    if (!group) {
+        close(groupfd);
+        return NULL;
+    }
+
+    return group;
+}
+
 void vfio_put_group(VFIOGroup *group)
 {
     if (!group || !QLIST_EMPTY(&group->device_list)) {
-- 
2.18.0
