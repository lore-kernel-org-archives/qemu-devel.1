Received: from eggs.gnu.org ([2001:4830:134:3::10]:41835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1coPb1-0005il-Ky
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1coPay-0001DT-DH
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:13:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:5238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1coPay-0001Cp-5H
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:13:12 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 16 Mar 2017 15:08:43 +0800
Message-Id: <1489648127-37282-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH kernel v8 0/4] Extend virtio-balloon for fast
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

Please read each patch commit log for details.

Changes:
v7->v8:
1) Use only one chunk format, instead of two.
2) re-write the virtio-balloon implementation patch.
3) commit changes
4) patch re-org

Liang Li (4):
  virtio-balloon: deflate via a page list
  virtio-balloon: VIRTIO_BALLOON_F_CHUNK_TRANSFER
  mm: add inerface to offer info about unused pages
  virtio-balloon: VIRTIO_BALLOON_F_HOST_REQ_VQ

 drivers/virtio/virtio_balloon.c     | 533 ++++++++++++++++++++++++++++++++----
 include/linux/mm.h                  |   3 +
 include/uapi/linux/virtio_balloon.h |  31 +++
 mm/page_alloc.c                     | 114 ++++++++
 4 files changed, 635 insertions(+), 46 deletions(-)

-- 
2.7.4
