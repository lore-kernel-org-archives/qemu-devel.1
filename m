Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F79C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F8220706
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFeFfPkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F8220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRzAP-0005am-2u
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 10:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jRz9H-0003uZ-SU
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jRz92-0008CG-NP
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:17:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jRz92-0008Bw-8Z
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587737849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCgRDumVMic88GUva32qwC+IS1jV6+CCLCJSi1nfKl4=;
 b=HFeFfPkYTPX3h9mdAsziE5re5v+Cq2vDotvE4yVZ2sYS95SyG72lZTBsha39iU8/FMFA8V
 IAkejfLewdpwAe8gxhLmRfRNYpGGIm7LhTUIQ8uvzFgPKodX0nopxHODAsaMWTfXQtZcNI
 g6SguHKR/+7tbpAxtTbvwoZvq+RVqMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-Din7HjdhNNO3CEIEB3GyaA-1; Fri, 24 Apr 2020 10:17:27 -0400
X-MC-Unique: Din7HjdhNNO3CEIEB3GyaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 264EE460;
 Fri, 24 Apr 2020 14:17:25 +0000 (UTC)
Received: from [10.36.114.19] (ovpn-114-19.ams2.redhat.com [10.36.114.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6301560605;
 Fri, 24 Apr 2020 14:17:07 +0000 (UTC)
Subject: Re: [EXT] Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on
 mmio region translation by viommu
To: Bharat Bhushan <bbhushan2@marvell.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-2-bbhushan2@marvell.com>
 <20200323170835.5021f845@w520.home>
 <8ec6af3c-6bd7-a3dc-c531-16db6b2089c5@redhat.com>
 <20200326115318.094ab79a@x1.home>
 <MWHPR1801MB196612966851882A99A6D3F3E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <72e3ea5c-c98c-3e02-26d1-b956ee81e30f@redhat.com>
Date: Fri, 24 Apr 2020 16:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <MWHPR1801MB196612966851882A99A6D3F3E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "yang.zhong@intel.com" <yang.zhong@intel.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "Tomasz Nowicki \[C\]" <tnowicki@marvell.com>,
 "mst@redhat.com" <mst@redhat.com>, "drjones@redhat.com" <drjones@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bharatb.linux@gmail.com" <bharatb.linux@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "linuc.decode@gmail.com" <linuc.decode@gmail.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

On 4/2/20 11:01 AM, Bharat Bhushan wrote:
> Hi Eric/Alex,
> 
>> -----Original Message-----
>> From: Alex Williamson <alex.williamson@redhat.com>
>> Sent: Thursday, March 26, 2020 11:23 PM
>> To: Auger Eric <eric.auger@redhat.com>
>> Cc: Bharat Bhushan <bbhushan2@marvell.com>; peter.maydell@linaro.org;
>> peterx@redhat.com; eric.auger.pro@gmail.com; kevin.tian@intel.com;
>> mst@redhat.com; Tomasz Nowicki [C] <tnowicki@marvell.com>;
>> drjones@redhat.com; linuc.decode@gmail.com; qemu-devel@nongnu.org; qemu-
>> arm@nongnu.org; bharatb.linux@gmail.com; jean-philippe@linaro.org;
>> yang.zhong@intel.com; David Gibson <david@gibson.dropbear.id.au>
>> Subject: [EXT] Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on mmio
>> region translation by viommu
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> On Thu, 26 Mar 2020 18:35:48 +0100
>> Auger Eric <eric.auger@redhat.com> wrote:
>>
>>> Hi Alex,
>>>
>>> On 3/24/20 12:08 AM, Alex Williamson wrote:
>>>> [Cc +dwg who originated this warning]
>>>>
>>>> On Mon, 23 Mar 2020 14:16:09 +0530
>>>> Bharat Bhushan <bbhushan2@marvell.com> wrote:
>>>>
>>>>> On ARM, the MSI doorbell is translated by the virtual IOMMU.
>>>>> As such address_space_translate() returns the MSI controller MMIO
>>>>> region and we get an "iommu map to non memory area"
>>>>> message. Let's remove this latter.
>>>>>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>>>>> ---
>>>>>  hw/vfio/common.c | 2 --
>>>>>  1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
>>>>> 5ca11488d6..c586edf47a 100644
>>>>> --- a/hw/vfio/common.c
>>>>> +++ b/hw/vfio/common.c
>>>>> @@ -426,8 +426,6 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb,
>> void **vaddr,
>>>>>                                   &xlat, &len, writable,
>>>>>                                   MEMTXATTRS_UNSPECIFIED);
>>>>>      if (!memory_region_is_ram(mr)) {
>>>>> -        error_report("iommu map to non memory area %"HWADDR_PRIx"",
>>>>> -                     xlat);
>>>>>          return false;
>>>>>      }
>>>>>
>>>>
>>>> I'm a bit confused here, I think we need more justification beyond
>>>> "we hit this warning and we don't want to because it's ok in this
>>>> one special case, therefore remove it".  I assume the special case
>>>> is that the device MSI address is managed via the SET_IRQS ioctl and
>>>> therefore we won't actually get DMAs to this range.
>>> Yes exactly. The guest creates a mapping between one giova and this
>>> gpa (corresponding to the MSI controller doorbell) because MSIs are
>>> mapped on ARM. But practically the physical device is programmed with
>>> an host chosen iova that maps onto the physical MSI controller's
>>> doorbell. so the device never performs DMA accesses to this range.
>>>
>>>   But I imagine the case that
>>>> was in mind when adding this warning was general peer-to-peer
>>>> between and assigned and emulated device.
>>> yes makes sense.
>>>
>>>   Maybe there's an argument to be made
>>>> that such a p2p mapping might also be used in a non-vIOMMU case.  We
>>>> skip creating those mappings and drivers continue to work, maybe
>>>> because nobody attempts to do p2p DMA with the types of devices we
>>>> emulate, maybe because p2p DMA is not absolutely reliable on bare
>>>> metal and drivers test it before using it.
>>> MSI doorbells are mapped using the IOMMU_MMIO flag (dma-iommu.c
>>> iommu_dma_get_msi_page).
>>> One idea could be to pass that flag through the IOMMU Notifier
>>> mechanism into the iotlb->perm. Eventually when we get this in
>>> vfio_get_vaddr() we would not print the warning. Could that make sense?
>>
>> Yeah, if we can identify a valid case that doesn't need a warning, that's fine by me.
>> Thanks,
> 
> Let me know if I understood the proposal correctly:
> 
> virtio-iommu driver in guest will make map (VIRTIO_IOMMU_T_MAP) with VIRTIO_IOMMU_MAP_F_MMIO flag for MSI mapping.
> In qemu, virtio-iommu device will set a new defined flag (say IOMMU_MMIO) in iotlb->perm in memory_region_notify_iommu(). vfio_get_vaddr() will check same flag and will not print the warning.>
> Is above correct?
Yes that's what I had in mind.

Thanks

Eric
> 
> Thanks
> -Bharat
> 
>>
>> Alex
> 
> 


