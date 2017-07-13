Received: from eggs.gnu.org ([2001:4830:134:3::10]:40238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbtT-0005iF-SV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbtO-0001ED-6S
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVbtO-0001CT-17
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:46 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Jul 2017 13:02:29 +0200
Message-Id: <20170713110237.6712-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/8] virtio: enhance virtio_error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

Output like "Virtqueue size exceeded" is not much useful in identifying the
culprit. This series beefs up virtio_error to print the virtio device name
and id, and introduces virtqueue_error which additionally includes the index
of the virtqueue where the error occured.

Patches 1 to 3 lay the groundwork, patches 4 to 8 convert virtio devices to
use virtqueue_error instead of virtio_error.

v1->v2:
* Modified virtio_error and added virtqueue_error (Stefan)
* Now also printing device id (Stefan)
* Went over all virtio_error call sites and converted them to virtqueue_error
  as appropriate; added virtio device maintainers to cc

Ladi Prosek (8):
  qemu-error: introduce error_report_nolf
  virtio: enhance virtio_error messages
  virtio: introduce virtqueue_error
  virtio-9p: use virtqueue_error for errors with queue context
  virtio-blk: use virtqueue_error for errors with queue context
  virtio-net: use virtqueue_error for errors with queue context
  virtio-scsi: use virtqueue_error for errors with queue context
  virtio-crypto: use virtqueue_error for errors with queue context

 hw/9pfs/virtio-9p-device.c  |  37 ++++++--------
 hw/block/virtio-blk.c       |   6 +--
 hw/net/virtio-net.c         |  24 ++++-----
 hw/scsi/virtio-scsi.c       |   2 +-
 hw/virtio/virtio-crypto.c   |  56 ++++++++++-----------
 hw/virtio/virtio.c          | 116 ++++++++++++++++++++++++++++++--------------
 include/hw/virtio/virtio.h  |   1 +
 include/qemu/error-report.h |   3 +-
 util/qemu-error.c           |  32 +++++++++---
 9 files changed, 169 insertions(+), 108 deletions(-)

-- 
2.9.3
