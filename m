Received: from eggs.gnu.org ([2001:4830:134:3::10]:43039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp8-0002RV-3P
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp5-0007he-6L
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1emjp5-0007h5-27
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9791D402291E
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:29:22 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 16 Feb 2018 18:29:08 +0100
Message-Id: <20180216172910.8549-4-maxime.coquelin@redhat.com>
In-Reply-To: <20180216172910.8549-1-maxime.coquelin@redhat.com>
References: <20180216172910.8549-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [RFC 3/5] vhost_net: send virtio device status update
 to the backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch adds ans uses a new function to send virtio device
status updates to the backend.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/net/vhost_net.c      | 10 ++++++++++
 hw/net/virtio-net.c     |  7 ++++++-
 include/net/vhost_net.h |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db63a3..75e2165163 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -450,6 +450,11 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
     return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
 }
 
+int vhost_net_set_virtio_status(struct vhost_net *net, uint8_t status)
+{
+    return vhost_dev_set_virtio_status(&net->dev, status);
+}
+
 #else
 uint64_t vhost_net_get_max_queues(VHostNetState *net)
 {
@@ -521,4 +526,9 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 {
     return 0;
 }
+
+int vhost_net_set_virtio_status(struct vhost_net *net, uint8_t status)
+{
+    return 0;
+}
 #endif
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 38674b08aa..06c431ea28 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -136,7 +136,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
 
     if ((virtio_net_started(n, status) && !nc->peer->link_down) ==
         !!n->vhost_started) {
-        return;
+        goto out;
     }
     if (!n->vhost_started) {
         int r, i;
@@ -175,11 +175,16 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
             error_report("unable to start vhost net: %d: "
                          "falling back on userspace virtio", -r);
             n->vhost_started = 0;
+
+            return;
         }
     } else {
         vhost_net_stop(vdev, n->nic->ncs, queues);
         n->vhost_started = 0;
     }
+
+out:
+    vhost_net_set_virtio_status(get_vhost_net(nc->peer), status);
 }
 
 static int virtio_net_set_vnet_endian_one(VirtIODevice *vdev,
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index afc1499eb9..bf083e2d2e 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -37,4 +37,6 @@ uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
 
+int vhost_net_set_virtio_status(struct vhost_net *net, uint8_t status);
+
 #endif
-- 
2.14.3
