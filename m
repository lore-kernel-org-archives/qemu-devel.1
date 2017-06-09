Received: from eggs.gnu.org ([2001:4830:134:3::10]:50659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dJHTL-0001fH-FV
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dJHTI-0001hq-DW
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:48:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:35795)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dJHTI-0001he-5I
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:48:52 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  9 Jun 2017 18:41:35 +0800
Message-Id: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v11 0/6] Virtio-balloon Enhancement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com

This patch series enhances the existing virtio-balloon with the following new
features:
1) fast ballooning: transfer ballooned pages between the guest and host in
chunks, instead of one by one; and
2) cmdq: a new virtqueue to send commands between the device and driver.
Currently, it supports commands to report memory stats (replace the old statq
mechanism) and report guest unused pages.

Liang Li (1):
  virtio-balloon: deflate via a page list

Wei Wang (5):
  virtio-balloon: coding format cleanup
  virtio-balloon: VIRTIO_BALLOON_F_PAGE_CHUNKS
  mm: function to offer a page block on the free list
  mm: export symbol of next_zone and first_online_pgdat
  virtio-balloon: VIRTIO_BALLOON_F_CMD_VQ

 drivers/virtio/virtio_balloon.c     | 781 ++++++++++++++++++++++++++++++++----
 drivers/virtio/virtio_ring.c        | 120 +++++-
 include/linux/mm.h                  |   5 +
 include/linux/virtio.h              |   7 +
 include/uapi/linux/virtio_balloon.h |  14 +
 include/uapi/linux/virtio_ring.h    |   3 +
 mm/mmzone.c                         |   2 +
 mm/page_alloc.c                     |  91 +++++
 8 files changed, 950 insertions(+), 73 deletions(-)

-- 
2.7.4
