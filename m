Received: from eggs.gnu.org ([2001:4830:134:3::10]:35181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cmLDW-0006fX-FS
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 09:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cmLDT-000695-Pi
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 09:08:26 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:28012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cmLDT-00067p-Iq
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 09:08:23 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OML0056NR9TDA60@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 10 Mar 2017 14:08:17 +0000 (GMT)
Date: Fri, 10 Mar 2017 17:08:14 +0300
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <20170310140806.GA11225@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
References: <CGME20170310140816eucas1p2bd85d3759739d64bb184ce0fbd74f90d@eucas1p2.samsung.com>
Subject: [Qemu-devel] Dual userfaultfd behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>

Hi, David, Andrea and Mike

The problem I want to discuss it's 1G hugepage based VM and post copy live
migration.

I would like to know your opinion on following approach of avoiding such
problem:
Once we have mmap'ed area through 1G hugetlbfs, remap physical pages
with /dev/mem. It will be 2 types of vmas mapped to the same PFN.
Register userfaultfd for newly obtained virtual
addresses, it could reduce granularity of pages and reduce downtime per
one 1G page. So registering userfaultfd for 2Mb, when the real hugepage
was 1G, I think, could help.

Current postcopy implementation in QEMU allows to make live migration
from 1G based hugepage VM to 2Mb based hugepages VM (sanity checks prevent
it).

Also I checked, it's possible to remap through /dev/mem and get PFN
based vmas, register userfaultfd (with allowance in vma_can_userfault)
and finally make UFFDIO_COPY with allowing PFN based vmas in __mcopy_atomic.

But there are a lot of drawback of such approach:
First of all it's /dev/mem interface. Need to provide full access
(kernel w/o CONFIG_STRICT_DEVMEM) and need to disable PAT.
The second drawback, maybe I just didn't find possibility to remap
hugepages again, but mmap of /dev/mem character driver maps 4Kb pages.
I don't know how THP could help here, but madvise with MADV_HUGEPAGE
didn't. So 4Kb is not exactly what needed, due to overhead of
encapsulation summary downtime is worse than in other cases.
It would be great to have interface to obtain new virtual address based
on existing PFN, but for hugepages.

Honestly, I can't find another use case for this feature.


-- 

BR
Alexey
