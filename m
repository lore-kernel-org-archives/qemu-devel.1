Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB175C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 04:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8650620801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 04:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Kv9219h1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8650620801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Gsi-0006FT-OA
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 23:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1j4Gs1-0005nJ-Tt
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 23:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1j4Grz-0004zG-KD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 23:21:57 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12795)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1j4Grz-0004qp-Bx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 23:21:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4cb7bf0000>; Tue, 18 Feb 2020 20:21:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Feb 2020 20:21:51 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 20:21:51 -0800
Received: from [10.40.101.248] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Feb
 2020 04:21:39 +0000
Subject: Re: [PATCH v12 Kernel 4/7] vfio iommu: Implementation of ioctl to for
 dirty pages tracking.
To: Alex Williamson <alex.williamson@redhat.com>
References: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
 <1581104554-10704-5-git-send-email-kwankhede@nvidia.com>
 <20200210102518.490a0d87@x1.home>
 <7e7356c8-29ed-31fa-5c0b-2545ae69f321@nvidia.com>
 <20200212161320.02d8dfac@w520.home>
 <0244aca6-80f7-1c1d-812e-d53a48b5479d@nvidia.com>
 <20200213162011.40b760a8@w520.home>
 <ea31fb62-4cd3-babb-634d-f69407586c93@nvidia.com>
 <20200217135518.4d48ebd6@w520.home>
 <57199367-e562-800a-ef73-f28bc5ddb2fe@nvidia.com>
 <20200218144105.4076b7eb@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <96d9990f-b27f-759e-1395-9b2eff218bfa@nvidia.com>
Date: Wed, 19 Feb 2020 09:51:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218144105.4076b7eb@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582086079; bh=O3y4CWgwr08G+dQhS3puMScdD7qBx5krj3X12P0U+Cw=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Kv9219h1VVhzVE13guvjarmgaNz4Ty9nS4Ids1Ri5lrdioWsZWG+8PrH4Pzi86i7N
 QGnfTiJXVZSyNcASRjCiPB4tbMXP32gjU0yHrW+I5LBeuLJvJ/jbVOvKB5wM2b/QM8
 Faa+jP5A/RaNBMmYmXa3RXsZip977fLL8QGGnRW4E8srXIXD8QpD01Bstor5vkdeKg
 jesIgAIjR44vCTFKExv0X/VRybj3CqgyRVfXBROkrDRSczR4W1beM3yQVofMal+/aZ
 EVbnIiRqGDvO1kvx0ebAJ9W9U5C+p3lw+u/SB5ul2WQ47t9rrnZqNJ2dVIZ6R+kRxR
 kMmoEagKXrifg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/19/2020 3:11 AM, Alex Williamson wrote:
> On Tue, 18 Feb 2020 11:28:53 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> <snip>
>>
>>>>>>>     As I understand the above algorithm, we find a vfio_dma
>>>>>>> overlapping the request and populate the bitmap for that range.  Then
>>>>>>> we go back and put_user() for each byte that we touched.  We could
>>>>>>> instead simply work on a one byte buffer as we enumerate the requested
>>>>>>> range and do a put_user() ever time we reach the end of it and have bits
>>>>>>> set. That would greatly simplify the above example.  But I would expect
>>>>>>> that we're a) more likely to get asked for ranges covering a single
>>>>>>> vfio_dma
>>>>>>
>>>>>> QEMU ask for single vfio_dma during each iteration.
>>>>>>
>>>>>> If we restrict this ABI to cover single vfio_dma only, then it
>>>>>> simplifies the logic here. That was my original suggestion. Should we
>>>>>> think about that again?
>>>>>
>>>>> But we currently allow unmaps that overlap multiple vfio_dmas as long
>>>>> as no vfio_dma is bisected, so I think that implies that an unmap while
>>>>> asking for the dirty bitmap has even further restricted semantics.  I'm
>>>>> also reluctant to design an ABI around what happens to be the current
>>>>> QEMU implementation.
>>>>>
>>>>> If we take your example above, ranges {0x0000,0xa000} and
>>>>> {0xa000,0x10000} ({start,end}), I think you're working with the
>>>>> following two bitmaps in this implementation:
>>>>>
>>>>> 00000011 11111111b
>>>>> 00111111b
>>>>>
>>>>> And we need to combine those into:
>>>>>
>>>>> 11111111 11111111b
>>>>>
>>>>> Right?
>>>>>
>>>>> But it seems like that would be easier if the second bitmap was instead:
>>>>>
>>>>> 11111100b
>>>>>
>>>>> Then we wouldn't need to worry about the entire bitmap being shifted by
>>>>> the bit offset within the byte, which limits our fixes to the boundary
>>>>> byte and allows us to use copy_to_user() directly for the bulk of the
>>>>> copy.  So how do we get there?
>>>>>
>>>>> I think we start with allocating the vfio_dma bitmap to account for
>>>>> this initial offset, so we calculate bitmap_base_iova as:
>>>>>      (iova & ~((PAGE_SIZE << 3) - 1))
>>>>> We then use bitmap_base_iova in calculating which bits to set.
>>>>>
>>>>> The user needs to follow the same rules, and maybe this adds some value
>>>>> to the user providing the bitmap size rather than the kernel
>>>>> calculating it.  For example, if the user wanted the dirty bitmap for
>>>>> the range {0xa000,0x10000} above, they'd provide at least a 1 byte
>>>>> bitmap, but we'd return bit #2 set to indicate 0xa000 is dirty.
>>>>>
>>>>> Effectively the user can ask for any iova range, but the buffer will be
>>>>> filled relative to the zeroth bit of the bitmap following the above
>>>>> bitmap_base_iova formula (and replacing PAGE_SIZE with the user
>>>>> requested pgsize).  I'm tempted to make this explicit in the user
>>>>> interface (ie. only allow bitmaps starting on aligned pages), but a
>>>>> user is able to map and unmap single pages and we need to support
>>>>> returning a dirty bitmap with an unmap, so I don't think we can do that.
>>>>>       
>>>>
>>>> Sigh, finding adjacent vfio_dmas within the same byte seems simpler than
>>>> this.
>>>
>>> How does KVM do this?  My intent was that if all of our bitmaps share
>>> the same alignment then we can merge the intersection and continue to
>>> use copy_to_user() on either side.  However, if QEMU doesn't do the
>>> same, it doesn't really help us.  Is QEMU stuck with an implementation
>>> of only retrieving dirty bits per MemoryRegionSection exactly because
>>> of this issue and therefore we can rely on it in our implementation as
>>> well?  Thanks,
>>>    
>>
>> QEMU sync dirty_bitmap per MemoryRegionSection. Within
>> MemoryRegionSection there could be multiple KVMSlots. QEMU queries
>> dirty_bitmap per KVMSlot and mark dirty for each KVMSlot.
>> On kernel side, KVM_GET_DIRTY_LOG ioctl calls
>> kvm_get_dirty_log_protect(), where it uses copy_to_user() to copy bitmap
>> of that memSlot.
>> vfio_dma is per MemoryRegionSection. We can reply on MemoryRegionSection
>> in our implementation. But to get bitmap during unmap, we have to take
>> care of concatenating bitmaps.
> 
> So KVM does not worry about bitmap alignment because the interface is
> based on slots, a dirty bitmap can only be retrieved for a single,
> entire slot.  We need VFIO_IOMMU_UNMAP_DMA to maintain its support for
> spanning multiple vfio_dmas, but maybe we have some leeway that we
> don't need to support both multiple vfio_dmas and dirty bitmap at the
> same time.  It seems like it would be a massive simplification if we
> required an unmap with dirty bitmap to span exactly one vfio_dma,
> right? 

Yes.

> I don't see that we'd break any existing users with that, it's
> unfortunate that we can't have the flexibility of the existing calling
> convention, but I think there's good reason for it here.  Our separate
> dirty bitmap log reporting would follow the same semantics.  I think
> this all aligns with how the MemoryListener works in QEMU right now,
> correct?  For example we wouldn't need any extra per MAP_DMA tracking
> in QEMU like KVM has for its slots.
> 

That right.
Should we go ahead with the implementation to get dirty bitmap for one 
vfio_dma for GET_DIRTY ioctl and unmap with dirty ioctl? Accordingly we 
can have sanity checks in these ioctls.

Thanks,
Kirti

>> In QEMU, in function kvm_physical_sync_dirty_bitmap() there is a comment
>> where bitmap size is calculated and bitmap is defined as 'void __user
>> *dirty_bitmap' which is also the concern you raised and could be handled
>> similarly as below.
>>
>>           /* XXX bad kernel interface alert
>>            * For dirty bitmap, kernel allocates array of size aligned to
>>            * bits-per-long.  But for case when the kernel is 64bits and
>>            * the userspace is 32bits, userspace can't align to the same
>>            * bits-per-long, since sizeof(long) is different between kernel
>>            * and user space.  This way, userspace will provide buffer which
>>            * may be 4 bytes less than the kernel will use, resulting in
>>            * userspace memory corruption (which is not detectable by valgrind
>>            * too, in most cases).
>>            * So for now, let's align to 64 instead of HOST_LONG_BITS here, in
>>            * a hope that sizeof(long) won't become >8 any time soon.
>>            */
>>           if (!mem->dirty_bmap) {
>>               hwaddr bitmap_size = ALIGN(((mem->memory_size) >>
>> TARGET_PAGE_BITS),
>>                                           /*HOST_LONG_BITS*/ 64) / 8;
>>               /* Allocate on the first log_sync, once and for all */
>>               mem->dirty_bmap = g_malloc0(bitmap_size);
>>           }
> 
> Sort of, the the KVM ioctl seems to just pass a slot number and user
> dirty bitmap pointer, so the size of the bitmap is inferred by the size
> of the slot, but if both kernel and user round up to a multiple of
> longs they might come up with different lengths.  QEMU therefore decides
> to always round up the size for an LP64 based long.  Since you've
> specified bitmap_size in our ioctl, the size agreement is explicit.
> 
> The concern I had looks like it addressed in KVM by placing the void*
> __user pointer in a union with a u64:
> 
> struct kvm_dirty_log {
>          __u32 slot;
>          __u32 padding1;
>          union {
>                  void __user *dirty_bitmap; /* one bit per page */
>                  __u64 padding2;
>          };
> };
> 
> The the kvm_vm_compat_ioctl() ioctl handles this with it's own private
> structure:
> 
> truct compat_kvm_dirty_log {
>          __u32 slot;
>          __u32 padding1;
>          union {
>                  compat_uptr_t dirty_bitmap; /* one bit per page */
>                  __u64 padding2;
>          };
> };
> 
> Which gets extracted via:
> 
> 	log.dirty_bitmap = compat_ptr(compat_log.dirty_bitmap);
> 
> However, compat_ptr() has:
> 
> /*
>   * A pointer passed in from user mode. This should not
>   * be used for syscall parameters, just declare them
>   * as pointers because the syscall entry code will have
>   * appropriately converted them already.
>   */
> #ifndef compat_ptr
> static inline void __user *compat_ptr(compat_uptr_t uptr)
> {
>          return (void __user *)(unsigned long)uptr;
> }
> #endif
> 
> So maybe we don't need to do anything special?  I'm tempted to think
> the KVM handling is using legacy mechanism or the padding in the union
> was assumed not to be for that purpose.  Thanks,
> 
> Alex
> 

