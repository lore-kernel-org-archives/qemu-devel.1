Received: from eggs.gnu.org ([2001:4830:134:3::10]:44826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e1r4S-0005SB-A0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e1r4O-0000OW-Dz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:43:28 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 10 Oct 2017 11:42:44 +0200
Message-Id: <20171010094247.10173-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] exec: further refine
 address_space_get_iotlb_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com, pbonzini@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>

This series is a rebase of the first two patches of Peter's series
improving address_space_get_iotlb_entry():
Message-Id: <1496404254-17429-1-git-send-email-peterx@redhat.com>

This third version sets initial page mask to ~0. In case of multiple iommus
chained on top of each other, the min page mask og the iommus is selected.
If no iommu, target's default page size is used (4K on x86_64).

This new revision also fixes an off-by-one error in memory notifier code,
spotted during code review, that could lead to the notifyee to receive
unexpected notifications for ranges it isn't registered to.

This series does not include Michael's suggestion to replace the use of page
masks by page length for IOTLB entries, to be able to support non power of
two page sizes. Idea is that it could be used for para-virtualized IOMMU
devices, but only para-virtualized device I'm aware of is the upcoming
virtio-iommu which also uses page masks. Moreover, these fixes are quite
urgent as they fix a regression which has a big impact on vhost performance.

As mentioned, the series is actually not only an improvement, but it fixes a
regression in the way IOTLB updates sent to the backends are generated.
The regression is introduced by patch:
a764040cc8 ("exec: abstract address_space_do_translate()")

Prior to patch a764040cc8, IOTLB entries sent to the backend were aligned on
the guest page boundaries (both addresses and size).
For example, with the guest using 2MB pages:
 * Backend sends IOTLB miss request for iova = 0x112378fb4
 * QEMU replies with an IOTLB update with iova = 0x112200000, size = 0x200000
 * Bakend insert above entry in its cache and compute the translation
In this case, if the backend needs later to translate 0x112378004, it will
result in a cache it and no need to send another IOTLB miss.

With patch a764040cc8, the addr of the IOTLB entry is the address requested
via the IOTLB miss, the size is computed to cover the remaining of the guest
page.
The same example gives:
 * Backend sends IOTLB miss request for iova = 0x112378fb4
 * QEMU replies with an IOTLB update with iova = 112378fb4, size = 0x8704c
 * Bakend insert above entry in its cache and compute the translation
In this case, if the backend needs later to translate 0x112378004, it will
result in another cache miss:
 * Backend sends IOTLB miss request for iova = 0x112378004
 * QEMU replies with an IOTLB update with iova = 0x112378004, size = 0x87FFC
 * Bakend insert above entry in its cache and compute the translation
It results in having much more IOTLB misses, and more importantly it pollutes
the device IOTLB cache by multiplying the number of entries that moreover
overlap.

Note that current Kernel & User backends implementation do not merge contiguous
and overlapping IOTLB entries at device IOTLB cache insertion.

This series fixes this regression, so that IOTLB updates are aligned on
guest's page boundaries.

Changes since v2:
=================
- Init page mask to ~0UL, and select the smallest mask in case of multiple
  iommu chained. If no iommu, use target's page mask. (Paolo)
- Add patch 3 to fix off-by-one error in notifier.

Changes since rebase:
=====================
- Fix page_mask initial value
- Apply Michael's on second patch

Maxime Coquelin (1):
  memory: fix off-by-one error in memory_region_notify_one()

Peter Xu (2):
  exec: add page_mask for flatview_do_translate
  exec: simplify address_space_get_iotlb_entry

 exec.c   | 80 +++++++++++++++++++++++++++++++++++++++++++---------------------
 memory.c |  2 +-
 2 files changed, 55 insertions(+), 27 deletions(-)

-- 
2.13.6
