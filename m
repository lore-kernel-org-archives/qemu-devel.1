Received: from eggs.gnu.org ([2001:4830:134:3::10]:56672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18N-0005KK-1l
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18J-0001HQ-So
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dX18J-0001GM-MX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:11:59 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 17 Jul 2017 10:11:43 +0200
Message-Id: <20170717081152.17153-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/9] virtio: enhance virtio_error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

Output like "Virtqueue size exceeded" is not much useful in identifying the
culprit. This series beefs up virtio_error to print the virtio device name
and id, and introduces virtqueue_error which additionally includes the index
of the virtqueue where the error occured.

Patches 1 to 3 lay the groundwork, patches 4 to 8 convert virtio devices to
use virtqueue_error instead of virtio_error. Patch 9 adds virtio_error and
virtqueue_error to the list of error funcs in checkpatch.pl.

v1->v2:
* Modified virtio_error and added virtqueue_error (Stefan)
* Now also printing device id (Stefan)
* Went over all virtio_error call sites and converted them to virtqueue_error
  as appropriate; added virtio device maintainers to cc

v2->v3:
* Removed patch 1 (Stefan, Markus)
* Split patch 3 into 2 (adds virtqueue_error) and 3 (makes virtio.c call it)
  (Cornelia)
* Added patch 9 to modify $qemu_error_funcs in checkpatch.pl (Greg)
* s/includes queue index/includes the queue index/ in patch 3-9 commit
  messages (Cornelia)
* Fixed virtio_get_device_id to return empty string instead of NULL if the
  device doesn't have an id (Stefan)
* Simplified the change in virtio-crypto.c to use vcrypto->ctrl_vq instead
  of propagating the vq pointer in function arguments (Cornelia, Gonglei)

Ladi Prosek (9):
  virtio: enhance virtio_error messages
  virtio: introduce virtqueue_error
  virtio: use virtqueue_error for errors with queue context
  virtio-9p: use virtqueue_error for errors with queue context
  virtio-blk: use virtqueue_error for errors with queue context
  virtio-net: use virtqueue_error for errors with queue context
  virtio-scsi: use virtqueue_error for errors with queue context
  virtio-crypto: use virtqueue_error for errors with queue context
  checkpatch: add virtio_error and virtqueue_error to error funcs

 hw/9pfs/virtio-9p-device.c |  37 ++++++--------
 hw/block/virtio-blk.c      |   6 +--
 hw/net/virtio-net.c        |  24 ++++-----
 hw/scsi/virtio-scsi.c      |   2 +-
 hw/virtio/virtio-crypto.c  |  49 ++++++++++---------
 hw/virtio/virtio.c         | 119 +++++++++++++++++++++++++++++++--------------
 include/hw/virtio/virtio.h |   1 +
 scripts/checkpatch.pl      |   4 +-
 8 files changed, 143 insertions(+), 99 deletions(-)

-- 
2.9.3
