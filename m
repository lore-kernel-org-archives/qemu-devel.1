Received: from eggs.gnu.org ([2001:4830:134:3::10]:60597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@gmail.com>) id 1ds8Ru-0002sa-ST
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@gmail.com>) id 1ds8Ro-0000NU-Ri
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:15:30 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:37748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.dakinevich@gmail.com>)
	id 1ds8Ro-0000MI-KO
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:15:24 -0400
Received: by mail-lf0-x243.google.com with SMTP id q132so180538lfe.4
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:15:23 -0700 (PDT)
From: Jan Dakinevich <jan.dakinevich@gmail.com>
Date: Wed, 13 Sep 2017 17:16:43 +0300
Message-Id: <1505312203-6319-1-git-send-email-jan.dakinevich@gmail.com>
Subject: [Qemu-devel] [PATCH] virtio-9p: don't break device on marshaling
 fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Jan Dakinevich <jan.dakinevich@gmail.com>

Fix regression from commit 8d37de41cab145cbba250a8f1f1372b0a5cdf26f.

The situation when pdu_marshal returns an error should be considered
valid. At least `v9fs_do_readdir_with_stat' relies on that to place in
responce buffer as much data as can fit.

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
---
 hw/9pfs/virtio-9p-device.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 62650b0..c3e5935 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -146,16 +146,8 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
-    ssize_t ret;
 
-    ret = v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
-    if (ret < 0) {
-        VirtIODevice *vdev = VIRTIO_DEVICE(v);
-
-        virtio_error(vdev, "Failed to encode VirtFS reply type %d",
-                     pdu->id + 1);
-    }
-    return ret;
+    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
 }
 
 static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
@@ -164,15 +156,8 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
-    ssize_t ret;
 
-    ret = v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
-    if (ret < 0) {
-        VirtIODevice *vdev = VIRTIO_DEVICE(v);
-
-        virtio_error(vdev, "Failed to decode VirtFS request type %d", pdu->id);
-    }
-    return ret;
+    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
 }
 
 static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
-- 
2.1.4
