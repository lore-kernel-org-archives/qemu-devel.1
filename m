Received: from eggs.gnu.org ([209.51.188.92]:34937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gxCHG-0000TB-SW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gxCF7-0007mh-QN
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gxCF7-0006eW-Cs
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:01 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Feb 2019 22:55:14 +0800
Message-Id: <1550847320-25110-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
References: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 07/13] virtio-net: Allow qemu_announce_self to
 trigger virtio announcements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vladislav Yasevich <vyasevic@redhat.com>, Jason Wang <jasowang@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Expose the virtio-net self announcement capability and allow
qemu_announce_self() to call it.

These announces are caused by something external (i.e. the
announce-self command); they won't trigger if the migration
counter is triggering announces at the same time.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/trace-events |  1 +
 hw/net/virtio-net.c | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/hw/net/trace-events b/hw/net/trace-events
index b237d90..3a86004 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -361,6 +361,7 @@ sunhme_rx_desc(uint32_t addr, int offset, uint32_t status, int len, int cr, int
 sunhme_rx_xsum_calc(uint16_t xsum) "calculated incoming xsum as 0x%x"
 
 # hw/net/virtio-net.c
+virtio_net_announce_notify(void) ""
 virtio_net_announce_timer(int round) "%d"
 virtio_net_handle_announce(int round) "%d"
 virtio_net_post_load_device(void)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b50f86d..ed0fa97 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -162,15 +162,42 @@ static bool virtio_net_started(VirtIONet *n, uint8_t status)
         (n->status & VIRTIO_NET_S_LINK_UP) && vdev->vm_running;
 }
 
+static void virtio_net_announce_notify(VirtIONet *net)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(net);
+    trace_virtio_net_announce_notify();
+
+    net->status |= VIRTIO_NET_S_ANNOUNCE;
+    virtio_notify_config(vdev);
+}
+
 static void virtio_net_announce_timer(void *opaque)
 {
     VirtIONet *n = opaque;
-    VirtIODevice *vdev = VIRTIO_DEVICE(n);
     trace_virtio_net_announce_timer(n->announce_timer.round);
 
     n->announce_timer.round--;
-    n->status |= VIRTIO_NET_S_ANNOUNCE;
-    virtio_notify_config(vdev);
+    virtio_net_announce_notify(n);
+}
+
+static void virtio_net_announce(NetClientState *nc)
+{
+    VirtIONet *n = qemu_get_nic_opaque(nc);
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    /*
+     * Make sure the virtio migration announcement timer isn't running
+     * If it is, let it trigger announcement so that we do not cause
+     * confusion.
+     */
+    if (n->announce_timer.round) {
+        return;
+    }
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_GUEST_ANNOUNCE) &&
+        virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
+            virtio_net_announce_notify(n);
+    }
 }
 
 static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
@@ -2568,6 +2595,7 @@ static NetClientInfo net_virtio_info = {
     .receive = virtio_net_receive,
     .link_status_changed = virtio_net_set_link_status,
     .query_rx_filter = virtio_net_query_rxfilter,
+    .announce = virtio_net_announce,
 };
 
 static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int idx)
@@ -2709,6 +2737,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     qemu_announce_timer_reset(&n->announce_timer, migrate_announce_params(),
                               QEMU_CLOCK_VIRTUAL,
                               virtio_net_announce_timer, n);
+    n->announce_timer.round = 0;
 
     if (n->netclient_type) {
         /*
-- 
2.5.0
