Received: from eggs.gnu.org ([2001:4830:134:3::10]:59026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnNbp-0001zf-LF
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnNbk-0000bz-Tp
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:53:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cnNbk-0000bZ-Nv
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:53:44 -0400
Date: Mon, 13 Mar 2017 10:53:39 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170313105338.GA2626@work-vm>
References: <CGME20170310140816eucas1p2bd85d3759739d64bb184ce0fbd74f90d@eucas1p2.samsung.com>
	<20170310140806.GA11225@aperevalov-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170310140806.GA11225@aperevalov-ubuntu>
Subject: Re: [Qemu-devel] Dual userfaultfd behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> Hi, David, Andrea and Mike

Hi Alexey,

> The problem I want to discuss it's 1G hugepage based VM and post copy live
> migration.
>=20
> I would like to know your opinion on following approach of avoiding such
> problem:
> Once we have mmap'ed area through 1G hugetlbfs, remap physical pages
> with /dev/mem. It will be 2 types of vmas mapped to the same PFN.
> Register userfaultfd for newly obtained virtual
> addresses, it could reduce granularity of pages and reduce downtime per
> one 1G page. So registering userfaultfd for 2Mb, when the real hugepage
> was 1G, I think, could help.
>=20
> Current postcopy implementation in QEMU allows to make live migration
> from 1G based hugepage VM to 2Mb based hugepages VM (sanity checks prevent
> it).
>=20
> Also I checked, it's possible to remap through /dev/mem and get PFN
> based vmas, register userfaultfd (with allowance in vma_can_userfault)
> and finally make UFFDIO_COPY with allowing PFN based vmas in __mcopy_atom=
ic.
>=20
> But there are a lot of drawback of such approach:
> First of all it's /dev/mem interface. Need to provide full access
> (kernel w/o CONFIG_STRICT_DEVMEM) and need to disable PAT.
> The second drawback, maybe I just didn't find possibility to remap
> hugepages again, but mmap of /dev/mem character driver maps 4Kb pages.
> I don't know how THP could help here, but madvise with MADV_HUGEPAGE
> didn't. So 4Kb is not exactly what needed, due to overhead of
> encapsulation summary downtime is worse than in other cases.
> It would be great to have interface to obtain new virtual address based
> on existing PFN, but for hugepages.

Yes, and I think as well on some architectures there can be cache problems
=66rom mapping the same page in two addresses unless we're careful.

I think to do this we'd basically need the kernel to set up something
similar to what you're saying, but without the mess of having to
go via /dev/mem.  Ideally it would all happen magically when I mark
a hugetlb page as userfault and start UFFDIO_COPYing in 4kb pages;
but I can imagine perhaps some more syscalls needed to tell it to do it.

I've no idea how hard that is to do though.

Dave

> Honestly, I can't find another use case for this feature.
>=20
>=20
> --=20
>=20
> BR
> Alexey
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
