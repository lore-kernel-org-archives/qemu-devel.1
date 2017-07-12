Received: from eggs.gnu.org ([2001:4830:134:3::10]:41640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVCCM-0001Cy-As
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVCCJ-00027K-8K
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:36:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVCCJ-00025o-1r
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:36:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1083B4E4CB
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:36:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 12 Jul 2017 15:36:18 +0800
Message-Id: <1499844982-5738-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] VT-d: some enhancements on iotlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

v2:
- rebase to master
- removed all "info iommu" patches for now
  (is it bad to introduce new HMP commands without QMP? I thought not,
   but in case I missed anything, please kindly let me know...)

Patch 1: fixes a very rare PT path issue on iova value. It didn't
break anything since it's merely not touched (only if when IOMMU
enabled, then set one device to PT), but still better fix it.

Patch 2: introduce "x-iotlb-size" to tune iotlb size, or to turn it
off (e.g., when we want to measure how iotlb affects one payload).

Patch 3: some refine on iotlb entry.

Patch 4: implemented MRU list algorithm for iotlb.

Please review. Thanks,

Peter Xu (4):
  intel_iommu: fix VTD_PAGE_MASK
  intel_iommu: let iotlb size tunable
  intel_iommu: use access_flags for iotlb
  intel_iommu: implement mru list for iotlb

 hw/i386/intel_iommu.c          | 103 +++++++++++++++++++++++++----------------
 hw/i386/intel_iommu_internal.h |  11 +----
 hw/i386/trace-events           |   1 -
 include/hw/i386/intel_iommu.h  |  10 ++--
 4 files changed, 71 insertions(+), 54 deletions(-)

-- 
2.7.4
