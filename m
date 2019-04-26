Received: from eggs.gnu.org ([209.51.188.92]:35861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1hJuCt-0001pU-AY
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1hJuCj-0007zh-4i
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:19:29 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri, 26 Apr 2019 14:18:15 +0800
Message-Id: <20190426061815.6384-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH] vhost-user: fix reconnection support for host
 notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: cunming.liang@intel.com, qemu-stable@nongnu.org

We need to destroy the host notifiers when cleaning up
the backend. Otherwise, some resources are not released
after the connection is closed, and it may prevent the
external backend from reopening them (e.g. VFIO files)
during restart.

Fixes: 44866521bd6e ("vhost-user: support registering external host notifiers")
Cc: qemu-stable@nongnu.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/virtio/vhost-user.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 553319c7ac..56656629c0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1454,10 +1454,24 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
 static int vhost_user_backend_cleanup(struct vhost_dev *dev)
 {
     struct vhost_user *u;
+    VhostUserState *user;
+    int i;
 
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
     u = dev->opaque;
+
+    if (dev->vq_index == 0) {
+        user = u->user;
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            if (user->notifier[i].addr) {
+                object_unparent(OBJECT(&user->notifier[i].mr));
+                munmap(user->notifier[i].addr, qemu_real_host_page_size);
+                user->notifier[i].addr = NULL;
+            }
+        }
+    }
+
     if (u->postcopy_notifier.notify) {
         postcopy_remove_notifier(&u->postcopy_notifier);
         u->postcopy_notifier.notify = NULL;
@@ -1881,6 +1895,8 @@ bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
         error_setg(errp, "Cannot initialize vhost-user state");
         return false;
     }
+
+    memset(user, 0, sizeof(*user));
     user->chr = chr;
     return true;
 }
-- 
2.17.1
