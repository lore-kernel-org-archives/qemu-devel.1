Received: from eggs.gnu.org ([2001:4830:134:3::10]:41133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cTgeP-0002cY-OR
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 22:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cTgeM-0006fR-J4
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 22:11:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cTgeM-0006eh-AI
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 22:11:02 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-15-git-send-email-peterx@redhat.com>
	<fad506bc-2398-fef9-b720-7720569ac0a6@redhat.com>
	<20170116091801.GL30108@pxdev.xzpeter.org>
	<0eedf780-16b2-ca5c-8eea-5d41e6837f23@redhat.com>
	<20170117144514.GO30108@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <99e185dc-e3c9-678f-7a69-fc006658d07f@redhat.com>
Date: Wed, 18 Jan 2017 11:10:53 +0800
MIME-Version: 1.0
In-Reply-To: <20170117144514.GO30108@pxdev.xzpeter.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 2017=E5=B9=B401=E6=9C=8817=E6=97=A5 22:45, Peter Xu wrote:
> On Mon, Jan 16, 2017 at 05:54:55PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 17:18, Peter Xu wrote:
>>>>>   static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_=
t domain_id,
>>>>>                                         hwaddr addr, uint8_t am)
>>>>>   {
>>>>> @@ -1222,6 +1251,7 @@ static void vtd_iotlb_page_invalidate(IntelIO=
MMUState *s, uint16_t domain_id,
>>>>>       info.addr =3D addr;
>>>>>       info.mask =3D ~((1 << am) - 1);
>>>>>       g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page=
, &info);
>>>>> +    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
>>>> Is the case of GLOBAL or DSI flush missed, or we don't care it at al=
l?
>>> IMHO we don't. For device assignment, since we are having CM=3D1 here=
,
>>> we should have explicit page invalidations even if guest sends
>>> global/domain invalidations.
>>>
>>> Thanks,
>>>
>>> -- peterx
>> Is this spec required?
> I think not. IMO the spec is very coarse grained on describing cache
> mode...
>
>> Btw, it looks to me that both DSI and GLOBAL are
>> indeed explicit flush.
> Actually when cache mode is on, it is unclear to me on how we should
> treat domain/global invalidations, at least from the spec (as
> mentioned earlier). My understanding is that they are not "explicit
> flushes", which IMHO should only mean page selective IOTLB
> invalidations.

Probably not, at least from the view of performance. DSI and global=20
should be more efficient in some cases.

>
>> Just have a quick go through on driver codes and find this something
>> interesting in intel_iommu_flush_iotlb_psi():
>>
>> ...
>>      /*
>>       * Fallback to domain selective flush if no PSI support or the si=
ze is
>>       * too big.
>>       * PSI requires page size to be 2 ^ x, and the base address is na=
turally
>>       * aligned to the size
>>       */
>>      if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iommu-=
>cap))
>>          iommu->flush.flush_iotlb(iommu, did, 0, 0,
>>                          DMA_TLB_DSI_FLUSH);
>>      else
>>          iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
>>                          DMA_TLB_PSI_FLUSH);
>> ...
> I think this is interesting... and I doubt its correctness while with
> cache mode enabled.
>
> If so (sending domain invalidation instead of a big range of page
> invalidations), how should we capture which pages are unmapped in
> emulated IOMMU?

We don't need to track individual pages here, since all pages for a=20
specific domain were unmapped I believe?

>
>> It looks like DSI_FLUSH is possible even for CM on.
>>
>> And in flush_unmaps():
>>
>> ...
>>          /* In caching mode, global flushes turn emulation expensive *=
/
>>          if (!cap_caching_mode(iommu->cap))
>>              iommu->flush.flush_iotlb(iommu, 0, 0, 0,
>>                       DMA_TLB_GLOBAL_FLUSH);
>> ...
>>
>> If I understand the comments correctly, GLOBAL is ok for CM too (thoug=
h the
>> code did not do it for performance reason).
> I think it should be okay to send global flush for CM, but not sure
> whether we should notify anything when we receive it. Hmm, anyway, I
> think I need some more reading to make sure I understand the whole
> thing correctly. :)
>
> For example, when I see this commit:
>
> commit 78d5f0f500e6ba8f6cfd0673475ff4d941d705a2
> Author: Nadav Amit <nadav.amit@gmail.com>
> Date:   Thu Apr 8 23:00:41 2010 +0300
>
>      intel-iommu: Avoid global flushes with caching mode.
>     =20
>      While it may be efficient on real hardware, emulation of global
>      invalidations is very expensive as all shadow entries must be exam=
ined.
>      This patch changes the behaviour when caching mode is enabled (whi=
ch is
>      the case when IOMMU emulation takes place). In this case, page spe=
cific
>      invalidation is used instead.
>
> Before I ask someone else besides qemu-devel, I am curious about
> whether there is existing VT-d emulation code (outside QEMU, of
> course) so that I can have a reference?

Yes, it has. The author of this patch - Nadav has done lots of research=20
on emulated IOMMU. See following papers:

https://hal.inria.fr/inria-00493752/document
http://www.cse.iitd.ac.in/~sbansal/csl862-virt/readings/vIOMMU.pdf

Thanks

> Quick search didn't answer me.
>
> Thanks,
>
> -- peterx
