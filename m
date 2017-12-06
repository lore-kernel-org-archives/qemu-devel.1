Received: from eggs.gnu.org ([2001:4830:134:3::10]:49988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCj-00010S-IB
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCg-00012c-DC
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50864
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCg-000120-5x
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE3v1015536
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:57 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epn0ac1tw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:57 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:56 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:43 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-51-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 50/55] vhost: fix error check in
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
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, "Michael S . Tsirkin" <mst@redhat.com>

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
(cherry picked from commit 2fe45ec3bffbd3a26f2ed39f60bab0ca5217d8f6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/vhost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 76f6e1fcaa..fd6f4a878b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -492,21 +492,21 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
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
2.11.0
