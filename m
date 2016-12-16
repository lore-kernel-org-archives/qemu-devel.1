Received: from eggs.gnu.org ([2001:4830:134:3::10]:39133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHztD-00047V-FC
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:18:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzt8-0007oW-Ec
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:18:03 -0500
Received: from mail.kernel.org ([198.145.29.136]:48990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzt8-0007nn-7p
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:58 -0500
Date: Fri, 16 Dec 2016 23:17:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1481922841-4324-10-git-send-email-mst@redhat.com>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481922841-4324-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 9/9] virtio: avoid using
 guest_notifier_mask in vhost-user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wei Huang <wei@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, stefanha@redhat.com

From: Wei Huang <wei@redhat.com>

Because guest mask notifier cannot be used in vhost-user mode, a boolean
flag "use_guest_notifier_mask" was added in commit 5669655aafd to disable
the use of guest mask notifier under virtio-pci. However this flag wasn't
checked in other virtio devices, such as virtio-mmio. In our tests, it
caused assertion error under "vhost-user + virtio-mmio". This patch
addresses this problem by adding a check before guest_notifier_mask is
called.

Signed-off-by: Wei Huang <wei@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
