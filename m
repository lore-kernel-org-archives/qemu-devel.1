Received: from eggs.gnu.org ([2001:4830:134:3::10]:47248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eKoBK-00061A-P2
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eKoBF-0005E3-Tb
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:28:53 -0500
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:55079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eKoBF-0005DJ-OC
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:28:49 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id B8663177365
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 22:40:12 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 30 Nov 2017 22:39:59 +0100
Message-ID: <151207799957.10789.15658210433260163179.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vhost: fix error check in
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org

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
---

The issue has been around since 2.8, so I don't think this fix is worth
an extra rc round. It can be shipped with 2.11.1.
---
 hw/virtio/vhost.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ddc42f0f93ed..6e7d45b01bc8 100644
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
