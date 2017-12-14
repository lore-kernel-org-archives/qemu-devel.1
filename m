Received: from eggs.gnu.org ([2001:4830:134:3::10]:36315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePWVO-0000Uz-NT
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePWVL-0001y5-DG
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:37:06 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2120 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ePWVL-0001vQ-1l
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:37:03 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 15 Dec 2017 00:36:32 +0800
Message-ID: <1513269392-23224-3-git-send-email-jianjay.zhou@huawei.com>
In-Reply-To: <1513269392-23224-1-git-send-email-jianjay.zhou@huawei.com>
References: <1513269392-23224-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] vhost: double check memslot number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: weidong.huang@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, gary.liuzhe@huawei.com

If the VM already has N(N>=8) available memory slots for vhost user,
the VM will be crashed in vhost_user_set_mem_table if we try to
hotplug the first vhost user NIC.
This patch checks if memslot number exceeded or not after updating
vhost_user_used_memslots.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 hw/virtio/vhost.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 0cf8a53..33aed1f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1243,13 +1243,31 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     event_notifier_cleanup(&vq->masked_notifier);
 }
 
+static bool vhost_dev_memslots_is_exceeded(struct vhost_dev *hdev)
+{
+    unsigned int n_memslots = 0;
+
+    if (hdev->vhost_ops->vhost_get_used_memslots) {
+        n_memslots = hdev->vhost_ops->vhost_get_used_memslots();
+    } else {
+        n_memslots = used_memslots;
+    }
+
+    if (n_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
+        error_report("vhost backend memory slots limit is less"
+                " than current number of present memory slots");
+        return true;
+    }
+
+    return false;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout)
 {
     uint64_t features;
     int i, r, n_initialized_vqs = 0;
     Error *local_err = NULL;
-    unsigned int n_memslots = 0;
 
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
@@ -1262,15 +1280,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    if (hdev->vhost_ops->vhost_get_used_memslots) {
-        n_memslots = hdev->vhost_ops->vhost_get_used_memslots();
-    } else {
-        n_memslots = used_memslots;
-    }
-
-    if (n_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
-        error_report("vhost backend memory slots limit is less"
-                " than current number of present memory slots");
+    if (vhost_dev_memslots_is_exceeded(hdev)) {
         r = -1;
         goto fail;
     }
@@ -1356,6 +1366,16 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->memory_changed = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
+
+    if (vhost_dev_memslots_is_exceeded(hdev)) {
+        r = -1;
+        if (busyloop_timeout) {
+            goto fail_busyloop;
+        } else {
+            goto fail;
+        }
+    }
+
     return 0;
 
 fail_busyloop:
-- 
1.8.3.1
