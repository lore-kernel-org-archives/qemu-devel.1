Received: from eggs.gnu.org ([2001:4830:134:3::10]:47165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePldQ-0003iR-7r
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePldN-0003IR-4v
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:46:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2121 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ePldM-00039x-PI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:46:21 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 15 Dec 2017 16:45:55 +0800
Message-ID: <1513327555-17520-3-git-send-email-jianjay.zhou@huawei.com>
In-Reply-To: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
References: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/2] vhost: double check used memslots number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: weidong.huang@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, gary.liuzhe@huawei.com, dgilbert@redhat.com, imammedo@redhat.com

If the VM already has N(N>8) available memory slots for vhost user,
the VM will be crashed in vhost_user_set_mem_table if we try to
hotplug the first vhost user NIC.
This patch checks if memslots number exceeded or not after updating
vhost_user_used_memslots.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 hw/virtio/vhost.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 59a32e9..e45f5e2 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1234,6 +1234,18 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     event_notifier_cleanup(&vq->masked_notifier);
 }
 
+static bool vhost_dev_used_memslots_is_exceeded(struct vhost_dev *hdev)
+{
+    if (hdev->vhost_ops->vhost_get_used_memslots() >
+        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
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
@@ -1252,10 +1264,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    if (hdev->vhost_ops->vhost_get_used_memslots() >
-        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
-        error_report("vhost backend memory slots limit is less"
-                " than current number of present memory slots");
+    if (vhost_dev_used_memslots_is_exceeded(hdev)) {
         r = -1;
         goto fail;
     }
@@ -1341,6 +1350,16 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->memory_changed = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
+
+    if (vhost_dev_used_memslots_is_exceeded(hdev)) {
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
