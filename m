Received: from eggs.gnu.org ([2001:4830:134:3::10]:54900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKoo4-0000s7-QV
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKoo2-00077F-BS
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eKoo2-00076r-4g
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:54 -0500
Date: Fri, 1 Dec 2017 19:08:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1512148088-28733-6-git-send-email-mst@redhat.com>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512148088-28733-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] vhost: fix error check in
 vhost_verify_ring_mappings()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Greg Kurz <groug@kaod.org>

Since commit f1f9e6c5 "vhost: adapt vhost_verify_ring_mappings() to
virtio 1 ring layout", we check the mapping of each part (descriptor
table, available ring and used ring) of each virtqueue separately.

The checking of a part is done by the vhost_verify_ring_part_mapping()
function: it returns either 0 on success or a negative errno if the
part cannot be mapped at the same place.

Unfortunately, the vhost_verify_ring_mappings() function checks its
return value the other way round. It means that we either:
- only verify the descriptor table of the first virtqueue, and if it
  is valid we ignore all the other mappings
- or ignore all broken mappings until we reach a valid one

ie, we only raise an error if all mappings are broken, and we consider
all mappings are valid otherwise (false success), which is obviously
wrong.

This patch ensures that vhost_verify_ring_mappings() only returns
success if ALL mappings are okay.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 5404194..e4290ce 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -493,21 +493,21 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
         j = 0;
         r = vhost_verify_ring_part_mapping(dev, vq->desc, vq->desc_phys,
                                            vq->desc_size, start_addr, size);
-        if (!r) {
+        if (r) {
             break;
         }
 
         j++;
         r = vhost_verify_ring_part_mapping(dev, vq->avail, vq->avail_phys,
                                            vq->avail_size, start_addr, size);
-        if (!r) {
+        if (r) {
             break;
         }
 
         j++;
         r = vhost_verify_ring_part_mapping(dev, vq->used, vq->used_phys,
                                            vq->used_size, start_addr, size);
-        if (!r) {
+        if (r) {
             break;
         }
     }
-- 
MST
