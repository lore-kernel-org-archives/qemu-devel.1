Received: from eggs.gnu.org ([2001:4830:134:3::10]:33289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fCEuP-0000AG-9b
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fCEuL-0000qe-BX
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:44:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fCEuL-0000qJ-69
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:44:13 -0400
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
	<2492f7d8-ed63-6f1c-773f-baa223020022@redhat.com>
	<20180427062615.GY9036@xz-mi>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ab60c407-12c7-8872-1d7c-d4f933f12979@redhat.com>
Date: Sat, 28 Apr 2018 09:43:54 +0800
MIME-Version: 1.0
In-Reply-To: <20180427062615.GY9036@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, David Gibson <david@gibson.dropbear.id.au>



On 2018=E5=B9=B404=E6=9C=8827=E6=97=A5 14:26, Peter Xu wrote:
> On Fri, Apr 27, 2018 at 01:13:02PM +0800, Jason Wang wrote:
>>
>> On 2018=E5=B9=B404=E6=9C=8825=E6=97=A5 12:51, Peter Xu wrote:
>>> Add a per-iommu big lock to protect IOMMU status.  Currently the only
>>> thing to be protected is the IOTLB cache, since that can be accessed
>>> even without BQL, e.g., in IO dataplane.
>>>
>>> Note that device page tables should not need any protection.  The saf=
ety
>>> of that should be provided by guest OS.  E.g., when a page entry is
>>> freed, the guest OS should be responsible to make sure that no device
>>> will be using that page any more.
>>>
>>> Reported-by: Fam Zheng<famz@redhat.com>
>>> Signed-off-by: Peter Xu<peterx@redhat.com>
>>> ---
>>>    include/hw/i386/intel_iommu.h |  8 ++++++++
>>>    hw/i386/intel_iommu.c         | 31 +++++++++++++++++++++++++++++--
>>>    2 files changed, 37 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_io=
mmu.h
>>> index 220697253f..1a8ba8e415 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -262,6 +262,14 @@ struct IntelIOMMUState {
>>>        uint8_t w1cmask[DMAR_REG_SIZE]; /* RW1C(Write 1 to Clear) byte=
s */
>>>        uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read retur=
ns 0) */
>>>        uint32_t version;
>>> +    /*
>>> +     * Protects IOMMU states in general.  Normally we don't need to
>>> +     * take this lock when we are with BQL held.  However we have co=
de
>>> +     * paths that may run even without BQL.  In those cases, we need
>>> +     * to take the lock when we have access to IOMMU state
>>> +     * informations, e.g., the IOTLB.
>>> +     */
>>> +    QemuMutex iommu_lock;
>> Some questions:
>>
>> 1) Do we need to protect context cache too?
> IMHO the context cache entry should work even without lock.  That's a
> bit trickly since we have two cases that this cache will be updated:
>
>    (1) first translation of the address space of a device
>    (2) invalidation of context entries
>
> For (2) IMHO we don't need to worry about since guest OS should be
> controlling that part, say, device should not be doing any translation
> (DMA operations) when the context entry is invalidated.
>
> For (1) the worst case is that the context entry cache be updated
> multiple times with the same value by multiple threads.  IMHO that'll
> be fine too.
>
> But yes for sure we can protect that too with the iommu lock.
>
>> 2) Can we just reuse qemu BQL here?
> I would prefer not.  As I mentioned, at least I have spent too much
> time on fighting BQL already.  I really hope we can start to use
> isolated locks when capable.  BQL is always the worst choice to me.

Just a thought, using BQL may greatly simplify the code actually=20
(consider we don't plan to remove BQL now).

>
>> 3) I think the issue is common to all other kinds of IOMMU, so can we =
simply
>> synchronize before calling ->translate() in memory.c. This seems a mor=
e
>> common solution.
> I suspect Power and s390 live well with that.  I think it mean at
> least these platforms won't have problem in concurrency.  I'm adding
> DavidG in loop in case there is further comment.  IMHO we should just
> make sure IOMMU code be thread safe, and we fix problem if there is.
>
> Thanks,
>

Yes, it needs some investigation, but we have other IOMMUs like AMD, and=20
we could have a flag to bypass BQL if IOMMU can synchronize by itself.

Thanks
