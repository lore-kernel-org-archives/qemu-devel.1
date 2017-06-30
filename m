Received: from eggs.gnu.org ([2001:4830:134:3::10]:53044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsli@synology.com>) id 1dQueN-0008Cn-Ri
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsli@synology.com>) id 1dQueI-0007g1-Vn
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:03:51 -0400
Received: from synology.com ([59.124.61.242]:51867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsli@synology.com>) id 1dQueI-0007ev-IW
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:03:46 -0400
From: Jia-Shiun Li <jsli@synology.com>
Date: Fri, 30 Jun 2017 20:03:04 +0800
Message-Id: <1498824184-1249-1-git-send-email-jsli@synology.com>
Subject: [Qemu-devel] [PATCH v2] vhost: Fix use-after-free in vhost_log_put()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com
Cc: qemu-devel@nongnu.org, Jia-Shiun Li <jsli@synology.com>

In commit 9e0bc24f dev->log_size was reset to zero too early before
syncing vhost log. It causes syncing to be skipped.

Use local variable to keep its value before resetting.

Signed-off-by: Jia-Shiun Li <jsli@synology.com>
---

v1 -> v2:
 * Use local variable to keep value of dev->log_size.

---
 hw/virtio/vhost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6eddb09..c1c5714 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -371,6 +371,7 @@ static struct vhost_log *vhost_log_get(uint64_t size, bool share)
 static void vhost_log_put(struct vhost_dev *dev, bool sync)
 {
     struct vhost_log *log = dev->log;
+    uint64_t log_size = dev->log_size;
 
     if (!log) {
         return;
@@ -381,8 +382,8 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
     --log->refcnt;
     if (log->refcnt == 0) {
         /* Sync only the range covered by the old log */
-        if (dev->log_size && sync) {
-            vhost_log_sync_range(dev, 0, dev->log_size * VHOST_LOG_CHUNK - 1);
+        if (log_size && sync) {
+            vhost_log_sync_range(dev, 0, log_size * VHOST_LOG_CHUNK - 1);
         }
 
         if (vhost_log == log) {
-- 
2.7.4
