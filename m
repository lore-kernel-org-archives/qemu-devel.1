Received: from eggs.gnu.org ([2001:4830:134:3::10]:51269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPe-0004q8-1W
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPZ-0002w3-4E
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:03:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPmPY-0002vk-UL
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:03:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF8B97C830
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:03:51 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 27 Jun 2017 17:03:31 +0800
Message-Id: <1498554219-4942-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/8] VT-d: some enhancements on iotlb and tools
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

Patch 1: fixes a very rare PT path issue on iova value. It didn't
break anything since it's merely not touched (only if when IOMMU
enabled, then set one device to PT), but still better fix it.

Patch 2-5: added "info iommu" hmp command, and implemented for VT-d.
Meanwhile, added some statistics for iotlb.

Patch 6: introduce "x-iotlb-size" to tune iotlb size, or to turn it
off (e.g., when we want to measure how iotlb affects one payload).

Patch 7: some refine on iotlb entry.

Patch 8: implemented MRU list algorithm for iotlb.

For the last patch, it's logically making more sense than the old
algo, however the performance is merely the same as before (as far as
I tested with simple netperf payloads, in either streaming, rr,
reverse, etc.) since in most normal cases we cannot really let iotlb
overflow especially when size is 1024 by default, e.g., guest kernel
driver will release buffer when after used, and unstrict
intel_iommu=on parameter will also send periodic global iotlb flush
which will reset the whole cache. If anyone has suggestion on specific
workload, please shoot. Anyway, I'm posting this out for review to see
any possible comments/suggestions.

Thanks,

Peter Xu (8):
  intel_iommu: fix VTD_PAGE_MASK
  hmp: add info iommu
  intel_iommu: support "info iommu"
  intel_iommu: add iotlb/context cache statistics
  intel_iommu: hmp: allow "-c" for "info iommu"
  intel_iommu: let iotlb size tunable
  intel_iommu: use access_flags for iotlb
  intel_iommu: implement mru list for iotlb

 hmp-commands-info.hx           |  14 ++++
 hmp.c                          |   6 ++
 hmp.h                          |   1 +
 hw/i386/intel_iommu.c          | 169 +++++++++++++++++++++++++++++++----------
 hw/i386/intel_iommu_internal.h |  11 +--
 hw/i386/trace-events           |   1 -
 hw/i386/x86-iommu.c            |  17 +++++
 include/hw/i386/intel_iommu.h  |  20 ++++-
 include/hw/i386/x86-iommu.h    |   5 ++
 include/hw/iommu.h             |   9 +++
 stubs/Makefile.objs            |   1 +
 stubs/iommu.c                  |   9 +++
 12 files changed, 209 insertions(+), 54 deletions(-)
 create mode 100644 include/hw/iommu.h
 create mode 100644 stubs/iommu.c

-- 
2.7.4
