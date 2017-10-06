Received: from eggs.gnu.org ([2001:4830:134:3::10]:60263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e0R5W-0002VW-11
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e0R5T-0000th-Du
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:46:42 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri,  6 Oct 2017 13:46:22 +0200
Message-Id: <20171006114624.10771-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] exec: further refine
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

This second revision of the rebase fixes the page_mask initial value,
that was mistakenly set to its complement. This bug could only be seen
when guest kernel doesn't enable iommu support, otherwise this initial
value is overwritten.

It is actually not only an improvement, but fixes a regression in the way
IOTLB updates sent to the backends are generated.
The regression is introduced by patch:
a764040cc8 ("exec: abstract address_space_do_translate()")

Prior to this patch IOTLB entries sent to the backend were aligned on the
guest page boundaries (both addresses and size).
For example, with the guest using 2MB pages:
 * Backend sends IOTLB miss request for iova = 0x112378fb4
 * QEMU replies with an IOTLB update with iova = 0x112200000, size = 0x200000
 * Bakend insert above entry in its cache and compute the translation
In this case, if the backend needs later to translate 0x112378004, it will
result in a cache it and no need to send another IOTLB miss.

With this patch, the addr of the IOTLB entry will be the address requested
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

Changes since rebase:
=====================
- Fix page_mask initial value
- Apply Michael's on second patch

Peter Xu (2):
  exec: add page_mask for flatview_do_translate
  exec: simplify address_space_get_iotlb_entry

 exec.c | 75 +++++++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 26 deletions(-)

-- 
2.13.6
