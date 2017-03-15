Received: from eggs.gnu.org ([2001:4830:134:3::10]:52385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1co9H6-0005pX-5z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1co9H1-00024V-9K
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:47:36 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:61710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1co9H0-000235-VM
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:47:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OMU00G9AZMZCP40@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:47:23 +0000 (GMT)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <8d9cb1a5-3961-dde3-cf4c-f013f7c92620@samsung.com>
Date: Wed, 15 Mar 2017 16:47:21 +0300
MIME-version: 1.0
In-reply-to: <20170313214636.GK27056@redhat.com>
Content-type: text/plain; charset=windows-1252; format=flowed
Content-transfer-encoding: 7bit
References: <CGME20170310140816eucas1p2bd85d3759739d64bb184ce0fbd74f90d@eucas1p2.samsung.com>
	<20170310140806.GA11225@aperevalov-ubuntu>
	<20170313105338.GA2626@work-vm> <20170313214636.GK27056@redhat.com>
Subject: Re: [Qemu-devel] Dual userfaultfd behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Mike Kravetz <mike.kravetz@oracle.com>

Hi Andrea,

thank you for so perfect design description,

the main question who will do RFC patches,
you or Mike or if you not against I could try.

On 03/14/2017 12:46 AM, Andrea Arcangeli wrote:
> Hello,
>
> On Mon, Mar 13, 2017 at 10:53:39AM +0000, Dr. David Alan Gilbert wrote:
>> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
>>> Hi, David, Andrea and Mike
>> Hi Alexey,
>>
>>> The problem I want to discuss it's 1G hugepage based VM and post copy live
>>> migration.
>>>
>>> I would like to know your opinion on following approach of avoiding such
>>> problem:
>>> Once we have mmap'ed area through 1G hugetlbfs, remap physical pages
>>> with /dev/mem. It will be 2 types of vmas mapped to the same PFN.
>>> Register userfaultfd for newly obtained virtual
>>> addresses, it could reduce granularity of pages and reduce downtime per
>>> one 1G page. So registering userfaultfd for 2Mb, when the real hugepage
>>> was 1G, I think, could help.
>>>
>>> Current postcopy implementation in QEMU allows to make live migration
>>> from 1G based hugepage VM to 2Mb based hugepages VM (sanity checks prevent
>>> it).
>>>
>>> Also I checked, it's possible to remap through /dev/mem and get PFN
>>> based vmas, register userfaultfd (with allowance in vma_can_userfault)
>>> and finally make UFFDIO_COPY with allowing PFN based vmas in __mcopy_atomic.
>>>
>>> But there are a lot of drawback of such approach:
>>> First of all it's /dev/mem interface. Need to provide full access
>>> (kernel w/o CONFIG_STRICT_DEVMEM) and need to disable PAT.
>>> The second drawback, maybe I just didn't find possibility to remap
>>> hugepages again, but mmap of /dev/mem character driver maps 4Kb pages.
>>> I don't know how THP could help here, but madvise with MADV_HUGEPAGE
>>> didn't. So 4Kb is not exactly what needed, due to overhead of
>>> encapsulation summary downtime is worse than in other cases.
>>> It would be great to have interface to obtain new virtual address based
>>> on existing PFN, but for hugepages.
>> Yes, and I think as well on some architectures there can be cache problems
>> from mapping the same page in two addresses unless we're careful.
>>
>> I think to do this we'd basically need the kernel to set up something
>> similar to what you're saying, but without the mess of having to
>> go via /dev/mem.  Ideally it would all happen magically when I mark
> /dev/mem is problematic also if the hugetlbfs page is being migrated
> for example (the virtual2physical mapping that may change and be
> directed to a different physical page with no notification to userland).
>
>> a hugetlb page as userfault and start UFFDIO_COPYing in 4kb pages;
>> but I can imagine perhaps some more syscalls needed to tell it to do it.
> I think what is needed is an extension to UFFDIO_COPY so that it will
> not fail if used with lower granularity than the hugetlbfs page
> size. Then a special feature flag should be set in the
> uffdio_api.features to tell userland it can use a lower granularity
> than the hugetlbfs page size.
>
> UFFDIO_COPY will still allocate a 1GB page, but it will copy only part
> of and then map only the copied part with a pte of 4k granularity (or
> 2MB granularity if the uffdio_copy.dst/len parameters allows for
> hugepmds). This way if there's a missing fault in the part that is not
> copied yet, it'll still trigger a page fault and we'll call
> handle_userfault from hugetlb_no_page, which will trigger a new
> UFFDIO_COPY and map another fragment of the 1GB page.
> The same code than should allow us to map a 2MB hugetlbfs page with 4k
> granularity in UFFDIO_COPY so then userland can choose if to do
> postcopy live migration on hugetlbfs with 2MB or 4kb granularity (on
> very slow network 4kb would be preferable for example for the latency).
>
> Mapping a 1GB page without a hugepud or mapping a 2MB page without a
> hugepmd breaks all sort of invariants into the hugetlbfs code, page
> migration wouldn't be able to cope with it either. Solving the fallout
> from such breakage is what is required to implement this basically.
>
> Ideally this could be a UFFDIO_COPY-only feature, simply every other
> part of hugetlbfs should be able to cope with whatever UFFDIO_COPY has
> generated in terms of pagetables mapping those hugepages.
>
> The only thing that will change from hugetlbfs point of view is that a
> pte or hugepmd could be mapping a 1GB page, that couldn't be the case
> before it.
>
> Once the entirety of the hugepage has been mapped or when the
> UFFDIO_UNREGISTER is called on the 1GB range, all those hugepmds
> and/or ptes should be dropped and the hugepud would then point
> directly to the 1GB page restoring the current behavior (which is
> required to get a 1GB large TLB and top performance, i.e. immediately
> after the live migration completed).
>
> This is very different concept than THP that in fact never requires to
> allocate hugepages. THP nowadays also allows to map a THP page using
> ptes, instead of hugepmds, just for a different reason (i.e. to allow
> split_huge_page to fail and be deferred, so get/put_page are
> simplified, while still guaranteeing that split_huge_page_pmd cannot
> fail). So we're already doing something like the above with THP but we
> only cover ptes vs hugepmd. The codebase however is different,
> hugetlbfs doesn't interact much with the main VM, so there's likely
> nothing to share with THP, but the concept of mapping an hugepage with
> ptes is somewhat similar.
>
> THP fundamentally always allows fallback, in the UFFDIO_COPY on
> hugetlbfs instead the idea would be to never allow fallback on the
> physical side, but to allow partial mapping so that the UFFDIO_COPY
> granularity can be reduced, despite the physical granularity remains
> native. This also means the collapse after live migration will be
> zerocopy: the collapse would be of the virtual kind for hugetlbfs
> (khugepaged as opposed has to copy the actual data because the
> physical pages were not huge to begin with, to allow the fallback).
>
> When UFFDIO_COPY is called again on the same 1GB range, it would need
> to notice that the pud is not null but is not huge (new case
> introduced), and then keep going in the pagetables lookup until it
> finds the copied range is not mapped, skip the 1GB allocation in such
> case and copy into the pre-existing 1GB page. If instead it finds the
> dst range is already mapped by a pte or a hugepmd, it'll instead
> return -EEXIST as usual.
>
> Thanks,
> Andrea
>
>
>


-- 
Best regards,
Alexey Perevalov
