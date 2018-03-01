Received: from eggs.gnu.org ([2001:4830:134:3::10]:49224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLL-0006HY-0C
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLH-0000y5-Et
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erRLH-0000xe-BB
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:03 -0500
Date: Thu, 1 Mar 2018 18:46:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519922735-29054-7-git-send-email-mst@redhat.com>
References: <1519922735-29054-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519922735-29054-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 06/13] vhost: fix memslot limit check
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
index 4a44e6e..4a583a3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1106,13 +1106,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
@@ -1192,6 +1185,18 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->started = false;
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
