Received: from eggs.gnu.org ([2001:4830:134:3::10]:39005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cxcEF-0001Rp-41
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cxcEC-00008x-0E
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:31:47 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:38782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cxcEB-0008VV-Mb
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:31:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OO7004W3CKMLLA0@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Mon, 10 Apr 2017 17:31:34 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <559bdae4-4dd1-459e-502b-98b05face50e@samsung.com>
Date: Mon, 10 Apr 2017 19:31:32 +0300
MIME-version: 1.0
In-reply-to: <f768dcd7-a57b-03bf-b697-dd6cabac2574@oracle.com>
Content-type: text/plain; charset=windows-1252; format=flowed
Content-transfer-encoding: 7bit
References: <CGME20170310140816eucas1p2bd85d3759739d64bb184ce0fbd74f90d@eucas1p2.samsung.com>
	<20170310140806.GA11225@aperevalov-ubuntu>
	<20170313105338.GA2626@work-vm> <20170313214636.GK27056@redhat.com>
	<8d9cb1a5-3961-dde3-cf4c-f013f7c92620@samsung.com>
	<f768dcd7-a57b-03bf-b697-dd6cabac2574@oracle.com>
Subject: Re: [Qemu-devel] Dual userfaultfd behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Kravetz <mike.kravetz@oracle.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Hello,



On 03/18/2017 02:27 AM, Mike Kravetz wrote:
> On 03/15/2017 06:47 AM, Alexey Perevalov wrote:
>> Hi Andrea,
>>
>> thank you for so perfect design description,
>>
>> the main question who will do RFC patches,
>> you or Mike or if you not against I could try.
> Sorry for not replying sooner, I have been away from e-mail.
>
> I have some other projects which require attention before I could start
> any in depth work on this issue.
ok, if nobody started, let me to begin to code that.
I already implemented straightforward approach, but it
didn't take into account page migration.
>> On 03/14/2017 12:46 AM, Andrea Arcangeli wrote:
>>> I think what is needed is an extension to UFFDIO_COPY so that it will
>>> not fail if used with lower granularity than the hugetlbfs page
>>> size. Then a special feature flag should be set in the
>>> uffdio_api.features to tell userland it can use a lower granularity
>>> than the hugetlbfs page size.
>>>
>>> UFFDIO_COPY will still allocate a 1GB page, but it will copy only part
>>> of and then map only the copied part with a pte of 4k granularity (or
>>> 2MB granularity if the uffdio_copy.dst/len parameters allows for
>>> hugepmds). This way if there's a missing fault in the part that is not
>>> copied yet, it'll still trigger a page fault and we'll call
>>> handle_userfault from hugetlb_no_page, which will trigger a new
>>> UFFDIO_COPY and map another fragment of the 1GB page.
>>> The same code than should allow us to map a 2MB hugetlbfs page with 4k
>>> granularity in UFFDIO_COPY so then userland can choose if to do
>>> postcopy live migration on hugetlbfs with 2MB or 4kb granularity (on
>>> very slow network 4kb would be preferable for example for the latency).
>>>
>>> Mapping a 1GB page without a hugepud or mapping a 2MB page without a
>>> hugepmd breaks all sort of invariants into the hugetlbfs code, page
>>> migration wouldn't be able to cope with it either. Solving the fallout
>>> from such breakage is what is required to implement this basically.
> Agree!
>
> I was wondering if it might be easier or more straight forward to split
> the target vma.  You would then create a new vma of the copy page size
> to be used during the copy.  In this way the the mappings and page table
> entries remain as expected.
>
> Of course, you would still want to allocate a huge page of the original
> target vma size and map that as smaller page sizes are copied.  I don't
> think there is anything that does something similar today.
>
> When the copy is done (or aborted) we then create/convert a new vma for
> the huge page and merge it into the target vma(s).
>
> Not sure if that would be any easier.  It was just the first thing that
> popped into my head.
>


-- 
Best regards,
Alexey Perevalov
