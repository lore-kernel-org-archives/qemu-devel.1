Received: from eggs.gnu.org ([2001:4830:134:3::10]:60027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cHagn-0008R1-Il
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cHagk-00040p-Ek
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:23:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1cHagk-0003zU-9G
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:23:30 -0500
From: Wei Huang <wei@redhat.com>
Date: Thu, 15 Dec 2016 12:23:24 -0600
Message-Id: <1481826204-27036-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] virtio: avoid using guest_notifier_mask in
 vhost-user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, wei@redhat.com

Because guest mask notifier cannot be used in vhost-user mode, a boolean
flag "use_guest_notifier_mask" was added in commit 5669655aafd to disable
the use of guest mask notifier under virtio-pci. However this flag wasn't
checked in other virtio devices, such as virtio-mmio. In our tests, it
caused assertion error under "vhost-user + virtio-mmio". This patch
addresses this problem by adding a check before guest_notifier_mask is
called.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 hw/s390x/virtio-ccw.c   | 4 ++--
 hw/virtio/virtio-mmio.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index f5c1d98..0765068 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1098,7 +1098,7 @@ static int virtio_ccw_set_guest_notifier(VirtioCcwDevice *dev, int n,
          * We do not support individual masking for channel devices, so we
          * need to manually trigger any guest masking callbacks here.
          */
-        if (k->guest_notifier_mask) {
+        if (k->guest_notifier_mask && vdev->use_guest_notifier_mask) {
             k->guest_notifier_mask(vdev, n, false);
         }
         /* get lost events and re-inject */
@@ -1107,7 +1107,7 @@ static int virtio_ccw_set_guest_notifier(VirtioCcwDevice *dev, int n,
             event_notifier_set(notifier);
         }
     } else {
-        if (k->guest_notifier_mask) {
+        if (k->guest_notifier_mask && vdev->use_guest_notifier_mask) {
             k->guest_notifier_mask(vdev, n, true);
         }
         if (with_irqfd) {
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 17412cb..60654dc 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -402,7 +402,7 @@ static int virtio_mmio_set_guest_notifier(DeviceState *d, int n, bool assign,
         event_notifier_cleanup(notifier);
     }
 
-    if (vdc->guest_notifier_mask) {
+    if (vdc->guest_notifier_mask && vdev->use_guest_notifier_mask) {
         vdc->guest_notifier_mask(vdev, n, !assign);
     }
 
-- 
2.7.4
