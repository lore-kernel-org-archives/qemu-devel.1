Received: from eggs.gnu.org ([2001:4830:134:3::10]:36369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1duk7W-0006Zx-JH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1duk7T-0007Wl-Ie
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:53:14 -0400
Received: from 206-15-90-246.static.twtelecom.net ([206.15.90.246]:56921
	helo=mailrelay.nutanix.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1duk7T-0007SR-Cf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:53:11 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 20 Sep 2017 11:53:06 -0700
Message-Id: <1505933586-11296-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH] virtio/vhost: reset dev->log after syncing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Felipe Franciosi <felipe@nutanix.com>

vhost_log_put() is called to decomission the dirty log between qemu and
a vhost device when stopping the device. Such a call can happen from
migration_completion().

Present code sets dev->log_size to zero too early in vhost_log_put(),
causing the sync check to always return false. As a consequence, the
last pass on the dirty bitmap never happens at the end of migration.

If a vhost device was busy (writing to guest memory) until the last
moments before vhost_virtqueue_stop(), this error will result in guest
memory corruption (at least) following migrations.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 hw/virtio/vhost.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 5fd69f0..ddc42f0 100644
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
@@ -396,6 +394,9 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
 
         g_free(log);
     }
+
+    dev->log = NULL;
+    dev->log_size = 0;
 }
 
 static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
-- 
1.7.1
