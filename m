Received: from eggs.gnu.org ([2001:4830:134:3::10]:47432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dOILF-0001p1-1b
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dOILA-00080I-Jz
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:45:17 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:55726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dOILA-0007zo-Dd
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:45:12 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 05A25107509
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 08:45:11 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 23 Jun 2017 08:45:07 +0200
Message-ID: <149820030753.7187.17749668632776032356.stgit@bahia.lan>
In-Reply-To: <149820029273.7187.14110849422638329192.stgit@bahia.lan>
References: <149820029273.7187.14110849422638329192.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 1/4] virtio-9p: record element after sanity
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>

If the guest sends a malformed request, we end up with a dangling pointer
in V9fsVirtioState. This doesn't seem to cause any bug, but let's remove
this side effect anyway.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/9pfs/virtio-9p-device.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 245abd8aaef1..3380bfc0c551 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -61,7 +61,6 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
         }
         QEMU_BUILD_BUG_ON(sizeof(out) != 7);
 
-        v->elems[pdu->idx] = elem;
         len = iov_to_buf(elem->out_sg, elem->out_num, 0,
                          &out, sizeof(out));
         if (len != sizeof(out)) {
@@ -70,6 +69,8 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
             goto out_free_req;
         }
 
+        v->elems[pdu->idx] = elem;
+
         pdu_submit(pdu, &out);
     }
 
