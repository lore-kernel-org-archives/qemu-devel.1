Received: from eggs.gnu.org ([2001:4830:134:3::10]:45234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsli@synology.com>) id 1dOEzt-0003Of-L1
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 23:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsli@synology.com>) id 1dOEzq-0005de-Af
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 23:11:01 -0400
Received: from synology.com ([59.124.61.242]:58049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsli@synology.com>) id 1dOEzp-0004od-MG
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 23:10:58 -0400
From: Jia-Shiun Li <jsli@synology.com>
Date: Fri, 23 Jun 2017 11:09:57 +0800
Message-Id: <1498187397-127781-1-git-send-email-jsli@synology.com>
Subject: [Qemu-devel] [PATCH] vhost: Fix use-after-free in vhost_log_put()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, Jia-Shiun Li <jsli@synology.com>

In commit 9e0bc24f dev->log_size was reset to zero too early before
syncing vhost log. It causes syncing to be skipped.

Move it to clear dev->log* after use.

Signed-off-by: Jia-Shiun Li <jsli@synology.com>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6eddb09..c9ddf11 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -375,8 +375,6 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
     if (!log) {
         return;
     }
-    dev->log = NULL;
-    dev->log_size = 0;
 
     --log->refcnt;
     if (log->refcnt == 0) {
@@ -396,6 +394,8 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
 
         g_free(log);
     }
+    dev->log = NULL;
+    dev->log_size = 0;
 }
 
 static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
-- 
2.7.4
