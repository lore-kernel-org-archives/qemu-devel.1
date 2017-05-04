Received: from eggs.gnu.org ([2001:4830:134:3::10]:59929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d6CYD-0005DA-M6
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d6CYA-0006fr-KF
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:55:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:31482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d6CYA-0006f9-B4
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:55:50 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu,  4 May 2017 16:50:09 +0800
Message-Id: <1493887815-6070-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v10 0/6] Extend virtio-balloon for fast
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

This patch series implements the follow two things:
1) Optimization of balloon page transfer: instead of transferring balloon pages
to host one by one, the new mechanism transfers them in chunks.
2) A mechanism to report info of guest unused pages: the pages have been unused
at some time between when host sent command and when guest reported them.  Host
uses that by tracking memory changes and then discarding changes made to the
pages that it gets from guest before it sent the command.

Changes:
v9->v10:
1) mm: put report_unused_page_block() under CONFIG_VIRTIO_BALLOON;
2) virtio-balloon: add virtballoon_validate();
3) virtio-balloon: msg format change;
4) virtio-balloon: move miscq handling to a task on system_freezable_wq;
5) virtio-balloon: code cleanup.

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

Wei Wang (5):
  virtio-balloon: coding format cleanup
  virtio-balloon: VIRTIO_BALLOON_F_PAGE_CHUNKS
  mm: function to offer a page block on the free list
  mm: export symbol of next_zone and first_online_pgdat
  virtio-balloon: VIRTIO_BALLOON_F_MISC_VQ

 drivers/virtio/virtio_balloon.c     | 696 +++++++++++++++++++++++++++++++++---
 include/linux/mm.h                  |   5 +
 include/uapi/linux/virtio_balloon.h |  26 ++
 mm/mmzone.c                         |   2 +
 mm/page_alloc.c                     |  91 +++++
 5 files changed, 761 insertions(+), 59 deletions(-)

-- 
2.7.4
