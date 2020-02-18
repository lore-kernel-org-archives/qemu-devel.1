Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CEAC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 05:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92ED920836
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 05:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SXytaGDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92ED920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3vv8-0003hA-RL
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 00:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1j3vuZ-0003Fh-Vd
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1j3vuX-0000Ts-14
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:59:10 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1j3vuW-0000TK-OP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:59:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4b7d1d0000>; Mon, 17 Feb 2020 21:58:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 17 Feb 2020 21:59:06 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 17 Feb 2020 21:59:06 -0800
Received: from [10.40.101.150] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 05:58:57 +0000
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
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <57199367-e562-800a-ef73-f28bc5ddb2fe@nvidia.com>
Date: Tue, 18 Feb 2020 11:28:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217135518.4d48ebd6@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582005533; bh=UVFuTcvlyh3iWYM+gJt93GCmfNP7VaK7DTQFFJhvpSk=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=SXytaGDwhevD6jXrh2a64+moNmNGuOsWvDYZ4i02wQXHW4VGGAYAdtBQ07O/y5wCt
 caYOqD7Dk7TC7JjSS59wBggf3aAz9ANVALhBmcn6EMGkNP/FwnlCFi/+1tK4bXbJuc
 +rLy27AcexbPB/Js/6InITnDv4SlhG9MHw9ddp+S8giLHtp3A25TVOwvZQtDIjFd3g
 DqRDhqeRAAOuCqg9OJ5MSZBC6ErTApYqwgZWCNJs5JlYQi59pd5EysJiZ574WLa0Rf
 BT4oXP+e8iLa2b5yZYL6HJehK/FVYzt0dWL1f/3e8Dsdsaxk8xpq1F+2get2uh/muc
 1RsxHD2eeiPew==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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

<snip>

>>>>>    As I understand the above algorithm, we find a vfio_dma
>>>>> overlapping the request and populate the bitmap for that range.  Then
>>>>> we go back and put_user() for each byte that we touched.  We could
>>>>> instead simply work on a one byte buffer as we enumerate the requested
>>>>> range and do a put_user() ever time we reach the end of it and have bits
>>>>> set. That would greatly simplify the above example.  But I would expect
>>>>> that we're a) more likely to get asked for ranges covering a single
>>>>> vfio_dma
>>>>
>>>> QEMU ask for single vfio_dma during each iteration.
>>>>
>>>> If we restrict this ABI to cover single vfio_dma only, then it
>>>> simplifies the logic here. That was my original suggestion. Should we
>>>> think about that again?
>>>
>>> But we currently allow unmaps that overlap multiple vfio_dmas as long
>>> as no vfio_dma is bisected, so I think that implies that an unmap while
>>> asking for the dirty bitmap has even further restricted semantics.  I'm
>>> also reluctant to design an ABI around what happens to be the current
>>> QEMU implementation.
>>>
>>> If we take your example above, ranges {0x0000,0xa000} and
>>> {0xa000,0x10000} ({start,end}), I think you're working with the
>>> following two bitmaps in this implementation:
>>>
>>> 00000011 11111111b
>>> 00111111b
>>>
>>> And we need to combine those into:
>>>
>>> 11111111 11111111b
>>>
>>> Right?
>>>
>>> But it seems like that would be easier if the second bitmap was instead:
>>>
>>> 11111100b
>>>
>>> Then we wouldn't need to worry about the entire bitmap being shifted by
>>> the bit offset within the byte, which limits our fixes to the boundary
>>> byte and allows us to use copy_to_user() directly for the bulk of the
>>> copy.  So how do we get there?
>>>
>>> I think we start with allocating the vfio_dma bitmap to account for
>>> this initial offset, so we calculate bitmap_base_iova as:
>>>     (iova & ~((PAGE_SIZE << 3) - 1))
>>> We then use bitmap_base_iova in calculating which bits to set.
>>>
>>> The user needs to follow the same rules, and maybe this adds some value
>>> to the user providing the bitmap size rather than the kernel
>>> calculating it.  For example, if the user wanted the dirty bitmap for
>>> the range {0xa000,0x10000} above, they'd provide at least a 1 byte
>>> bitmap, but we'd return bit #2 set to indicate 0xa000 is dirty.
>>>
>>> Effectively the user can ask for any iova range, but the buffer will be
>>> filled relative to the zeroth bit of the bitmap following the above
>>> bitmap_base_iova formula (and replacing PAGE_SIZE with the user
>>> requested pgsize).  I'm tempted to make this explicit in the user
>>> interface (ie. only allow bitmaps starting on aligned pages), but a
>>> user is able to map and unmap single pages and we need to support
>>> returning a dirty bitmap with an unmap, so I don't think we can do that.
>>>    
>>
>> Sigh, finding adjacent vfio_dmas within the same byte seems simpler than
>> this.
> 
> How does KVM do this?  My intent was that if all of our bitmaps share
> the same alignment then we can merge the intersection and continue to
> use copy_to_user() on either side.  However, if QEMU doesn't do the
> same, it doesn't really help us.  Is QEMU stuck with an implementation
> of only retrieving dirty bits per MemoryRegionSection exactly because
> of this issue and therefore we can rely on it in our implementation as
> well?  Thanks,
> 

QEMU sync dirty_bitmap per MemoryRegionSection. Within 
MemoryRegionSection there could be multiple KVMSlots. QEMU queries 
dirty_bitmap per KVMSlot and mark dirty for each KVMSlot.
On kernel side, KVM_GET_DIRTY_LOG ioctl calls 
kvm_get_dirty_log_protect(), where it uses copy_to_user() to copy bitmap 
of that memSlot.
vfio_dma is per MemoryRegionSection. We can reply on MemoryRegionSection 
in our implementation. But to get bitmap during unmap, we have to take 
care of concatenating bitmaps.

In QEMU, in function kvm_physical_sync_dirty_bitmap() there is a comment 
where bitmap size is calculated and bitmap is defined as 'void __user 
*dirty_bitmap' which is also the concern you raised and could be handled 
similarly as below.

         /* XXX bad kernel interface alert
          * For dirty bitmap, kernel allocates array of size aligned to
          * bits-per-long.  But for case when the kernel is 64bits and
          * the userspace is 32bits, userspace can't align to the same
          * bits-per-long, since sizeof(long) is different between kernel
          * and user space.  This way, userspace will provide buffer which
          * may be 4 bytes less than the kernel will use, resulting in
          * userspace memory corruption (which is not detectable by valgrind
          * too, in most cases).
          * So for now, let's align to 64 instead of HOST_LONG_BITS here, in
          * a hope that sizeof(long) won't become >8 any time soon.
          */
         if (!mem->dirty_bmap) {
             hwaddr bitmap_size = ALIGN(((mem->memory_size) >> 
TARGET_PAGE_BITS),
                                         /*HOST_LONG_BITS*/ 64) / 8;
             /* Allocate on the first log_sync, once and for all */
             mem->dirty_bmap = g_malloc0(bitmap_size);
         }

Thanks,
Kirti


