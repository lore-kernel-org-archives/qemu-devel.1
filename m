Received: from eggs.gnu.org ([2001:4830:134:3::10]:43748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhSxa-0003lL-Hv
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhSxX-00050j-8q
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:45043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fhSxW-0004yY-V6
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:35 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Mon, 23 Jul 2018 12:59:55 +0800
Message-Id: <20180723045956.27521-3-tiwei.bie@intel.com>
In-Reply-To: <20180723045956.27521-1-tiwei.bie@intel.com>
References: <20180723045956.27521-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [RFC 2/3] vfio: support getting VFIOGroup from groupfd
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

This patch introduces an API to support getting
VFIOGroup from groupfd. This is useful when the
groupfd is opened and shared by another process
via UNIX socket.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/vfio/common.c              | 44 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 52a05532cd..4c19a33dd5 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1279,6 +1279,30 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 }
 
+static int vfio_groupfd_to_groupid(int groupfd)
+{
+    char *tmp, group_path[PATH_MAX], *group_name;
+    int groupid, len;
+
+    tmp = g_strdup_printf("/proc/self/fd/%d", groupfd);
+    len = readlink(tmp, group_path, sizeof(group_path));
+    g_free(tmp);
+
+    if (len <= 0 || len >= sizeof(group_path)) {
+        return -1;
+    }
+
+    group_path[len] = '\0';
+
+    group_name = g_path_get_basename(group_path);
+    if (sscanf(group_name, "%d", &groupid) != 1) {
+        groupid = -1;
+    }
+    g_free(group_name);
+
+    return groupid;
+}
+
 static VFIOGroup *vfio_init_group(int groupfd, int groupid, AddressSpace *as,
                                   Error **errp)
 {
@@ -1373,6 +1397,26 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     return group;
 }
 
+VFIOGroup *vfio_get_group_from_fd(int groupfd, AddressSpace *as, Error **errp)
+{
+    VFIOGroup *group;
+    int groupid;
+
+    groupid = vfio_groupfd_to_groupid(groupfd);
+    if (groupid < 0) {
+        error_setg(errp, "failed to get group id from group fd %d",
+                   groupfd);
+        return NULL;
+    }
+
+    group = vfio_find_group(groupid, as, errp);
+    if (group) {
+        return group;
+    }
+
+    return vfio_init_group(groupfd, groupid, as, errp);
+}
+
 void vfio_put_group(VFIOGroup *group)
 {
     if (!group || !QLIST_EMPTY(&group->device_list)) {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a9036929b2..9bb1068a36 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -170,6 +170,7 @@ void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
+VFIOGroup *vfio_get_group_from_fd(int groupfd, AddressSpace *as, Error **errp);
 void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
-- 
2.18.0
