Received: from eggs.gnu.org ([2001:4830:134:3::10]:40093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cybEW-0008UL-Bx
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cybES-0008IG-GA
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:40:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:11319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cybES-0008Hg-7m
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:40:04 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 13 Apr 2017 17:35:03 +0800
Message-Id: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v9 0/5] Extend virtio-balloon for fast
 (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com

This patch series implements two optimizations:
1) transfer pages in chuncks between the guest and host;
2) transfer the guest unused pages to the host so that they
can be skipped to migrate in live migration.

Changes:
v8->v9:
1) Split the two new features, VIRTIO_BALLOON_F_BALLOON_CHUNKS and
VIRTIO_BALLOON_F_MISC_VQ, which were mixed together in the previous
implementation;
2) Simpler function to get the free page block.

v7->v8:
1) Use only one chunk format, instead of two.
2) re-write the virtio-balloon implementation patch.
3) commit changes
4) patch re-org

Liang Li (1):
  virtio-balloon: deflate via a page list

Wei Wang (4):
  virtio-balloon: VIRTIO_BALLOON_F_BALLOON_CHUNKS
  mm: function to offer a page block on the free list
  mm: export symbol of next_zone and first_online_pgdat
  virtio-balloon: VIRTIO_BALLOON_F_MISC_VQ

 drivers/virtio/virtio_balloon.c     | 615 +++++++++++++++++++++++++++++++++---
 include/linux/mm.h                  |   3 +
 include/uapi/linux/virtio_balloon.h |  21 ++
 mm/mmzone.c                         |   2 +
 mm/page_alloc.c                     |  87 +++++
 5 files changed, 678 insertions(+), 50 deletions(-)

-- 
2.7.4
