Received: from eggs.gnu.org ([2001:4830:134:3::10]:43853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cTlj8-0000HO-5y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cTlj4-0006yt-87
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:36:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cTlj3-0006xJ-Uz
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:36:14 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-15-git-send-email-peterx@redhat.com>
	<fad506bc-2398-fef9-b720-7720569ac0a6@redhat.com>
	<20170116091801.GL30108@pxdev.xzpeter.org>
	<0eedf780-16b2-ca5c-8eea-5d41e6837f23@redhat.com>
	<20170117144514.GO30108@pxdev.xzpeter.org>
	<99e185dc-e3c9-678f-7a69-fc006658d07f@redhat.com>
	<20170118081137.GS30108@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f89c8ad4-a95d-bf66-33c6-f151531c2174@redhat.com>
Date: Wed, 18 Jan 2017 16:36:05 +0800
MIME-Version: 1.0
In-Reply-To: <20170118081137.GS30108@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 14/14] intel_iommu: enable vfio
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8818=E6=97=A5 16:11, Peter Xu wrote:
> On Wed, Jan 18, 2017 at 11:10:53AM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B401=E6=9C=8817=E6=97=A5 22:45, Peter Xu wrote:
>>> On Mon, Jan 16, 2017 at 05:54:55PM +0800, Jason Wang wrote:
>>>> On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 17:18, Peter Xu wrote:
>>>>>>>   static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint1=
6_t domain_id,
>>>>>>>                                         hwaddr addr, uint8_t am)
>>>>>>>   {
>>>>>>> @@ -1222,6 +1251,7 @@ static void vtd_iotlb_page_invalidate(Intel=
IOMMUState *s, uint16_t domain_id,
>>>>>>>       info.addr =3D addr;
>>>>>>>       info.mask =3D ~((1 << am) - 1);
>>>>>>>       g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pa=
ge, &info);
>>>>>>> +    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
>>>>>> Is the case of GLOBAL or DSI flush missed, or we don't care it at =
all?
>>>>> IMHO we don't. For device assignment, since we are having CM=3D1 he=
re,
>>>>> we should have explicit page invalidations even if guest sends
>>>>> global/domain invalidations.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> -- peterx
>>>> Is this spec required?
>>> I think not. IMO the spec is very coarse grained on describing cache
>>> mode...
>>>
>>>> Btw, it looks to me that both DSI and GLOBAL are
>>>> indeed explicit flush.
>>> Actually when cache mode is on, it is unclear to me on how we should
>>> treat domain/global invalidations, at least from the spec (as
>>> mentioned earlier). My understanding is that they are not "explicit
>>> flushes", which IMHO should only mean page selective IOTLB
>>> invalidations.
>> Probably not, at least from the view of performance. DSI and global sh=
ould
>> be more efficient in some cases.
> I agree with you that DSI/GLOBAL flushes are more efficient in some
> way. But IMHO that does not mean these invalidations are "explicit
> invalidations", and I suspect whether cache mode has to coop with it.

Well, the spec does not forbid DSI/GLOBAL with CM and the driver codes=20
had used them for almost ten years. I can hardly believe it's wrong.

>
> But here I should add one more thing besides PSI - context entry
> invalidation should be one of "the explicit invalidations" as well,
> which we need to handle just like PSI when cache mode is on.
>
>>>> Just have a quick go through on driver codes and find this something
>>>> interesting in intel_iommu_flush_iotlb_psi():
>>>>
>>>> ...
>>>>      /*
>>>>       * Fallback to domain selective flush if no PSI support or the =
size is
>>>>       * too big.
>>>>       * PSI requires page size to be 2 ^ x, and the base address is =
naturally
>>>>       * aligned to the size
>>>>       */
>>>>      if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iomm=
u->cap))
>>>>          iommu->flush.flush_iotlb(iommu, did, 0, 0,
>>>>                          DMA_TLB_DSI_FLUSH);
>>>>      else
>>>>          iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
>>>>                          DMA_TLB_PSI_FLUSH);
>>>> ...
>>> I think this is interesting... and I doubt its correctness while with
>>> cache mode enabled.
>>>
>>> If so (sending domain invalidation instead of a big range of page
>>> invalidations), how should we capture which pages are unmapped in
>>> emulated IOMMU?
>> We don't need to track individual pages here, since all pages for a sp=
ecific
>> domain were unmapped I believe?
> IMHO this might not be the correct behavior.
>
> If we receive one domain specific invalidation, I agree that we should
> invalidate the IOTLB cache for all the devices inside the domain.
> However, when cache mode is on, we should be depending on the PSIs to
> unmap each page (unless we want to unmap the whole address space, in
> this case it's very possible that the guest is just unmapping a range,
> not the entire space). If we convert several PSIs into one big DSI,
> IMHO we will leave those pages mapped/unmapped while we should
> unmap/map them.

Confused, do you have an example for this? (I fail to understand why DSI=20
can't work, at least implementation can convert DSI to several PSIs=20
internally).

Thanks

>
>>>> It looks like DSI_FLUSH is possible even for CM on.
>>>>
>>>> And in flush_unmaps():
>>>>
>>>> ...
>>>>          /* In caching mode, global flushes turn emulation expensive=
 */
>>>>          if (!cap_caching_mode(iommu->cap))
>>>>              iommu->flush.flush_iotlb(iommu, 0, 0, 0,
>>>>                       DMA_TLB_GLOBAL_FLUSH);
>>>> ...
>>>>
>>>> If I understand the comments correctly, GLOBAL is ok for CM too (tho=
ugh the
>>>> code did not do it for performance reason).
>>> I think it should be okay to send global flush for CM, but not sure
>>> whether we should notify anything when we receive it. Hmm, anyway, I
>>> think I need some more reading to make sure I understand the whole
>>> thing correctly. :)
>>>
>>> For example, when I see this commit:
>>>
>>> commit 78d5f0f500e6ba8f6cfd0673475ff4d941d705a2
>>> Author: Nadav Amit <nadav.amit@gmail.com>
>>> Date:   Thu Apr 8 23:00:41 2010 +0300
>>>
>>>      intel-iommu: Avoid global flushes with caching mode.
>>>      While it may be efficient on real hardware, emulation of global
>>>      invalidations is very expensive as all shadow entries must be ex=
amined.
>>>      This patch changes the behaviour when caching mode is enabled (w=
hich is
>>>      the case when IOMMU emulation takes place). In this case, page s=
pecific
>>>      invalidation is used instead.
>>>
>>> Before I ask someone else besides qemu-devel, I am curious about
>>> whether there is existing VT-d emulation code (outside QEMU, of
>>> course) so that I can have a reference?
>> Yes, it has. The author of this patch - Nadav has done lots of researc=
h on
>> emulated IOMMU. See following papers:
>>
>> https://hal.inria.fr/inria-00493752/document
>> http://www.cse.iitd.ac.in/~sbansal/csl862-virt/readings/vIOMMU.pdf
> Thanks for these good materials. I will google the author for sure
> next time. :)
>
> -- peterx
