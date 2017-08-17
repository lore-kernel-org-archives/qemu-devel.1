Received: from eggs.gnu.org ([2001:4830:134:3::10]:48326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1diBdU-0007yQ-DG
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1diBdQ-0003jM-EZ
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:38:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:1602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1diBdQ-0003iP-5d
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:38:16 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 17 Aug 2017 11:26:51 +0800
Message-Id: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v14 0/5] Virtio-balloon Enhancement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

This patch series enhances the existing virtio-balloon with the following
new features:
1) fast ballooning: transfer ballooned pages between the guest and host in
chunks using sgs, instead of one by one; and
2) free_page_vq: a new virtqueue to report guest free pages to the host.

The second feature can be used to accelerate live migration of VMs. Here
are some details:

Live migration needs to transfer the VM's memory from the source machine
to the destination round by round. For the 1st round, all the VM's memory
is transferred. From the 2nd round, only the pieces of memory that were
written by the guest (after the 1st round) are transferred. One method
that is popularly used by the hypervisor to track which part of memory is
written is to write-protect all the guest memory.

The second feature  enables the optimization of the 1st round memory
transfer - the hypervisor can skip the transfer of guest free pages in the
1st round. It is not concerned that the memory pages are used after they
are given to the hypervisor as a hint of the free pages, because they will
be tracked by the hypervisor and transferred in the next round if they are
used and written.

Change Log:
v13->v14:
1) xbitmap: move the code from lib/radix-tree.c to lib/xbitmap.c.
2) xbitmap: consolidate the implementation of xb_bit_set/clear/test into
one xb_bit_ops.
3) xbitmap: add documents for the exported APIs.
4) mm: rewrite the function to walk through free page blocks.
5) virtio-balloon: when reporting a free page blcok to the device, if the
vq is full (less likey to happen in practice), just skip reporting this
block, instead of busywaiting till an entry gets released.
6) virtio-balloon: fail the probe function if adding the signal buf in
init_vqs fails.

v12->v13:
1) mm: use a callback function to handle the the free page blocks from the
report function. This avoids exposing the zone internal to a kernel module.
2) virtio-balloon: send balloon pages or a free page block using a single sg
each time. This has the benefits of simpler implementation with no new APIs.
3) virtio-balloon: the free_page_vq is used to report free pages only (no
multiple usages interleaving)
4) virtio-balloon: Balloon pages and free page blocks are sent via input sgs,
and the completion signal to the host is sent via an output sg.

v11->v12:
1) xbitmap: use the xbitmap from Matthew Wilcox to record ballooned pages.
2) virtio-ring: enable the driver to build up a desc chain using vring desc.
3) virtio-ring: Add locking to the existing START_USE() and END_USE() macro
to lock/unlock the vq when a vq operation starts/ends.
4) virtio-ring: add virtqueue_kick_sync() and virtqueue_kick_async()
5) virtio-balloon: describe chunks of ballooned pages and free pages blocks
directly using one or more chains of desc from the vq.

v10->v11:
1) virtio_balloon: use vring_desc to describe a chunk;
2) virtio_ring: support to add an indirect desc table to virtqueue;
3)  virtio_balloon: use cmdq to report guest memory statistics.

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

Matthew Wilcox (1):
  lib/xbitmap: Introduce xbitmap

Wei Wang (4):
  lib/xbitmap: add xb_find_next_bit() and xb_zero()
  virtio-balloon: VIRTIO_BALLOON_F_SG
  mm: support reporting free page blocks
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ

 drivers/virtio/virtio_balloon.c     | 324 +++++++++++++++++++++++++++++++-----
 include/linux/mm.h                  |   6 +
 include/linux/radix-tree.h          |   3 +
 include/linux/xbitmap.h             |  64 +++++++
 include/uapi/linux/virtio_balloon.h |   2 +
 lib/Makefile                        |   2 +-
 lib/radix-tree.c                    |  22 ++-
 lib/xbitmap.c                       | 215 ++++++++++++++++++++++++
 mm/page_alloc.c                     |  44 +++++
 9 files changed, 640 insertions(+), 42 deletions(-)
 create mode 100644 include/linux/xbitmap.h
 create mode 100644 lib/xbitmap.c

-- 
2.7.4
