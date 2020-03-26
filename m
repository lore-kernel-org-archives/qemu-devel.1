Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7CBC2D0E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA3020719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3kQHm1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA3020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHWRM-0000vV-Jy
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 13:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jHWQS-0008V5-7L
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jHWQQ-0007Wn-Kl
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:36:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35259)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jHWQQ-0007VW-GQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585244173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSXRKJ3jjJIKb5g83cbWtnsMmNgKqEK0FvYZddqErZM=;
 b=D3kQHm1YZj7EN2vx3caNGBICe4rRY1EbBxSm4BJCtf/JduZn+GtI1ITrqN0JNm74wj8sqt
 WKnsWUN/aNZge/PaapD4O06b7pd3CT+KYneHee66PIqJtf4eDyaCzUiv7JjNQ9aPz7hTNu
 m0omUT4swi73F1hYkgaXAXBbcKsishI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-cJRT_C-yOpqInvlBp49sKA-1; Thu, 26 Mar 2020 13:36:10 -0400
X-MC-Unique: cJRT_C-yOpqInvlBp49sKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88285190B2A0;
 Thu, 26 Mar 2020 17:36:07 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA0D5C1BA;
 Thu, 26 Mar 2020 17:35:50 +0000 (UTC)
Subject: Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on mmio region
 translation by viommu
To: Alex Williamson <alex.williamson@redhat.com>,
 Bharat Bhushan <bbhushan2@marvell.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-2-bbhushan2@marvell.com>
 <20200323170835.5021f845@w520.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8ec6af3c-6bd7-a3dc-c531-16db6b2089c5@redhat.com>
Date: Thu, 26 Mar 2020 18:35:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200323170835.5021f845@w520.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, drjones@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, linuc.decode@gmail.com,
 David Gibson <david@gibson.dropbear.id.au>, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 3/24/20 12:08 AM, Alex Williamson wrote:
> [Cc +dwg who originated this warning]
> 
> On Mon, 23 Mar 2020 14:16:09 +0530
> Bharat Bhushan <bbhushan2@marvell.com> wrote:
> 
>> On ARM, the MSI doorbell is translated by the virtual IOMMU.
>> As such address_space_translate() returns the MSI controller
>> MMIO region and we get an "iommu map to non memory area"
>> message. Let's remove this latter.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>> ---
>>  hw/vfio/common.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 5ca11488d6..c586edf47a 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -426,8 +426,6 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
>>                                   &xlat, &len, writable,
>>                                   MEMTXATTRS_UNSPECIFIED);
>>      if (!memory_region_is_ram(mr)) {
>> -        error_report("iommu map to non memory area %"HWADDR_PRIx"",
>> -                     xlat);
>>          return false;
>>      }
>>  
> 
> I'm a bit confused here, I think we need more justification beyond "we
> hit this warning and we don't want to because it's ok in this one
> special case, therefore remove it".  I assume the special case is that
> the device MSI address is managed via the SET_IRQS ioctl and therefore
> we won't actually get DMAs to this range.
Yes exactly. The guest creates a mapping between one giova and this gpa
(corresponding to the MSI controller doorbell) because MSIs are mapped
on ARM. But practically the physical device is programmed with an host
chosen iova that maps onto the physical MSI controller's doorbell. so
the device never performs DMA accesses to this range.

  But I imagine the case that
> was in mind when adding this warning was general peer-to-peer between
> and assigned and emulated device.
yes makes sense.

  Maybe there's an argument to be made
> that such a p2p mapping might also be used in a non-vIOMMU case.  We
> skip creating those mappings and drivers continue to work, maybe
> because nobody attempts to do p2p DMA with the types of devices we
> emulate, maybe because p2p DMA is not absolutely reliable on bare metal
> and drivers test it before using it.
MSI doorbells are mapped using the IOMMU_MMIO flag (dma-iommu.c
iommu_dma_get_msi_page).
One idea could be to pass that flag through the IOMMU Notifier mechanism
into the iotlb->perm. Eventually when we get this in vfio_get_vaddr() we
would not print the warning. Could that make sense?

Thanks

Eric



  Anyway, I need a better argument
> why this is ok.  Thanks,
> 
> Alex
> 


