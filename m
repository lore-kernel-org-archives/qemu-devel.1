Received: from eggs.gnu.org ([2001:4830:134:3::10]:48177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQuNy-0008HJ-GM
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQuNx-0004vy-JW
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dQuNx-0004vn-Dm
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 30 Jun 2017 12:46:32 +0100
Message-Id: <20170630114635.9286-5-stefanha@redhat.com>
In-Reply-To: <20170630114635.9286-1-stefanha@redhat.com>
References: <20170630114635.9286-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] tests: fix virtio-scsi-test ISR dependence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Use the new used ring APIs instead of assuming ISR being set means the
request has completed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20170628184724.21378-4-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-scsi-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index eff71df..87a3b6e 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -121,7 +121,7 @@ static uint8_t virtio_scsi_do_command(QVirtIOSCSI *vs, const uint8_t *cdb,
     }
 
     qvirtqueue_kick(vs->dev, vq, free_head);
-    qvirtio_wait_queue_isr(vs->dev, vq, QVIRTIO_SCSI_TIMEOUT_US);
+    qvirtio_wait_used_elem(vs->dev, vq, free_head, QVIRTIO_SCSI_TIMEOUT_US);
 
     response = readb(resp_addr +
                      offsetof(struct virtio_scsi_cmd_resp, response));
-- 
2.9.4
