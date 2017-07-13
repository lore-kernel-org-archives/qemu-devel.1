Received: from eggs.gnu.org ([2001:4830:134:3::10]:47874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dVYnx-0007SZ-4M
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dVYns-0003RY-A5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dVYns-0003Qe-3S
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:44:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0CD07D0C6
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:44:49 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Thu, 13 Jul 2017 09:44:38 +0200
Message-Id: <ae882d766ec76c57a7babc2798f16a5a31d64358.1499931846.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH] virtion-net: Prefer is_power_of_2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com

We have a function that checks if given number is power of two.
We should prefer it instead of expanding the check on our own.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5630a9ec44..657d099c54 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1942,7 +1942,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
      */
     if (n->net_conf.rx_queue_size < VIRTIO_NET_RX_QUEUE_MIN_SIZE ||
         n->net_conf.rx_queue_size > VIRTQUEUE_MAX_SIZE ||
-        (n->net_conf.rx_queue_size & (n->net_conf.rx_queue_size - 1))) {
+        !is_power_of_2(n->net_conf.rx_queue_size)) {
         error_setg(errp, "Invalid rx_queue_size (= %" PRIu16 "), "
                    "must be a power of 2 between %d and %d.",
                    n->net_conf.rx_queue_size, VIRTIO_NET_RX_QUEUE_MIN_SIZE,
-- 
2.13.0
