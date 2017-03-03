Received: from eggs.gnu.org ([2001:4830:134:3::10]:39160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cjg0q-0001S0-CD
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cjg0l-0006Qg-Fc
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:44:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:50436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cjg0l-0006Q0-5J
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:44:15 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  3 Mar 2017 13:40:25 +0800
Message-Id: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v7 kernel 0/5] Extend virtio-balloon for fast
 (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang324@gmail.com>

Take over this work from Liang.

This patch series implements two optimizations: 1) transfer pages in chuncks
between the guest and host; 1) transfer the guest unused pages to the host so
that they can be skipped to migrate in live migration.

Please check patch 0003 for more details about optimization 1).

For an idle guest with 8GB RAM, optimization 2) can help shorten the total live
migration time from 2Sec to about 500ms in 10Gbps network
environment. For a guest with quite a lot of page cache and little
unused pages, it's possible to let the guest drop its page cache before
live migration, this case can benefit from this new feature too.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Liang Li <liliang324@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>

Liang Li (5):
  virtio-balloon: rework deflate to add page to a list
  virtio-balloon: VIRTIO_BALLOON_F_CHUNK_TRANSFER
  virtio-balloon: implementation of VIRTIO_BALLOON_F_CHUNK_TRANSFER
  virtio-balloon: define flags and head for host request vq
  This patch contains two parts:

 drivers/virtio/virtio_balloon.c     | 510 ++++++++++++++++++++++++++++++++----
 include/linux/mm.h                  |   3 +
 include/uapi/linux/virtio_balloon.h |  34 +++
 mm/page_alloc.c                     | 120 +++++++++
 4 files changed, 620 insertions(+), 47 deletions(-)

-- 
2.7.4
