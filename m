Received: from eggs.gnu.org ([2001:4830:134:3::10]:52179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafT-0003qP-6K
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafR-0001L6-V8
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dDafR-0001Kr-BV
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58B1012B9A
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:05:52 +0000 (UTC)
From: Vladislav Yasevich <vyasevic@redhat.com>
Date: Wed, 24 May 2017 14:05:21 -0400
Message-Id: <1495649128-10529-6-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
Subject: [Qemu-devel] [PATCH 05/12] virtio-net: Allow qemu_announce_self to
 trigger virtio announcements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com, Vladislav Yasevich <vyasevic@redhat.com>

Expose the virtio-net self annoucement capability and allow
qemu_announce_self() to call it.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 hw/net/virtio-net.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1c65825..4adafbd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -111,14 +111,38 @@ static bool virtio_net_started(VirtIONet *n, uint8_t status)
         (n->status & VIRTIO_NET_S_LINK_UP) && vdev->vm_running;
 }
 
+static void __virtio_net_announce(VirtIONet *net)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(net);
+
+    net->status |= VIRTIO_NET_S_ANNOUNCE;
+    virtio_notify_config(vdev);
+}
+
 static void virtio_net_announce_timer(void *opaque)
 {
     VirtIONet *n = opaque;
-    VirtIODevice *vdev = VIRTIO_DEVICE(n);
 
     n->announce_timer->round--;
-    n->status |= VIRTIO_NET_S_ANNOUNCE;
-    virtio_notify_config(vdev);
+    __virtio_net_announce(n);
+}
+
+static void virtio_net_announce(NetClientState *nc)
+{
+    VirtIONet *n = qemu_get_nic_opaque(nc);
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    /* Make sure the virtio migration announcement timer isn't running
+     * If it is, let it trigger announcement so that we do not cause
+     * confusion.
+     */
+    if (n->announce_timer->round)
+        return;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_GUEST_ANNOUNCE) &&
+        virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
+            __virtio_net_announce(n);
+    }
 }
 
 static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
@@ -1834,6 +1858,7 @@ static NetClientInfo net_virtio_info = {
     .receive = virtio_net_receive,
     .link_status_changed = virtio_net_set_link_status,
     .query_rx_filter = virtio_net_query_rxfilter,
+    .announce = virtio_net_announce,
 };
 
 static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int idx)
@@ -1941,6 +1966,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->status = VIRTIO_NET_S_LINK_UP;
     n->announce_timer = qemu_announce_timer_new(qemu_get_announce_params(),
                                                 QEMU_CLOCK_VIRTUAL);
+    n->announce_timer->round = 0;
     n->announce_timer->tm = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                           virtio_net_announce_timer, n);
 
-- 
2.7.4
