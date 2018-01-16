Received: from eggs.gnu.org ([2001:4830:134:3::10]:46329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVQ9-0001rc-0n
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVQ8-0004Hw-80
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:53:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebVQ8-0004H9-1l
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:53:12 -0500
Date: Tue, 16 Jan 2018 19:53:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516121887-32738-34-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 33/34] vhost: fix memslot limit check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jay Zhou <jianjay.zhou@huawei.com>, Igor Mammedov <imammedo@redhat.com>

From: Jay Zhou <jianjay.zhou@huawei.com>

Since used_memslots will be updated to the actual value after
registering memory listener for the first time, move the
memslots limit checking to the right place.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ff949d9..e9e56c0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1332,13 +1332,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
-        error_report("vhost backend memory slots limit is less"
-                " than current number of present memory slots");
-        r = -1;
-        goto fail;
-    }
-
     r = hdev->vhost_ops->vhost_set_owner(hdev);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost_set_owner failed");
@@ -1420,6 +1413,18 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->memory_changed = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
+
+    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
+        error_report("vhost backend memory slots limit is less"
+                " than current number of present memory slots");
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
MST
