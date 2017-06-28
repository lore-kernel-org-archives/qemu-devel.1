Received: from eggs.gnu.org ([2001:4830:134:3::10]:36536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQI0a-0004r6-NM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQI0Z-00017n-QJ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:48:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 28 Jun 2017 19:47:23 +0100
Message-Id: <20170628184724.21378-6-stefanha@redhat.com>
In-Reply-To: <20170628184724.21378-1-stefanha@redhat.com>
References: <20170628184724.21378-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] tests: fix virtio-net-test ISR dependence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Use the new used ring APIs instead of assuming ISR being set means the
request has completed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-net-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 8f94360..635b942 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -108,7 +108,7 @@ static void rx_test(QVirtioDevice *dev,
     ret = iov_send(socket, iov, 2, 0, sizeof(len) + sizeof(test));
     g_assert_cmpint(ret, ==, sizeof(test) + sizeof(len));
 
-    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_NET_TIMEOUT_US);
+    qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_NET_TIMEOUT_US);
     memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
     g_assert_cmpstr(buffer, ==, "TEST");
 
@@ -131,7 +131,7 @@ static void tx_test(QVirtioDevice *dev,
     free_head = qvirtqueue_add(vq, req_addr, 64, false, false);
     qvirtqueue_kick(dev, vq, free_head);
 
-    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_NET_TIMEOUT_US);
+    qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_NET_TIMEOUT_US);
     guest_free(alloc, req_addr);
 
     ret = qemu_recv(socket, &len, sizeof(len), 0);
@@ -182,7 +182,7 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     rsp = qmp("{ 'execute' : 'cont'}");
     QDECREF(rsp);
 
-    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_NET_TIMEOUT_US);
+    qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_NET_TIMEOUT_US);
     memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
     g_assert_cmpstr(buffer, ==, "TEST");
 
-- 
2.9.4
