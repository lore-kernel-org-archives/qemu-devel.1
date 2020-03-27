Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F26C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F56206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5ItcOL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F56206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHkLq-0005Pz-6A
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 04:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jHkKz-0004c9-0M
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jHkKw-000885-Tc
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:27:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jHkKw-00086F-Nq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585297650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsPQj0YCzXCqH70y7QKEykTLKK0R9rSMGdc7ugINK5o=;
 b=J5ItcOL9LTN5E3GggfifjFP03kB5oPvWBEe/vim+O2kr3roYdX4k0KORGQzOmxvYM/2Hxq
 J665EQeAAoMmb4JJGud6HDpFvate5v/laEo+a3elp9bgfyQR5i2B1YRkd7A/KI+OkRswbj
 axlhQb6yN5y6xMq4o8yppsGKNjbYc8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-IaDpAuOGObmWDfB9Mfo4GA-1; Fri, 27 Mar 2020 04:27:28 -0400
X-MC-Unique: IaDpAuOGObmWDfB9Mfo4GA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13FE3107ACCA;
 Fri, 27 Mar 2020 08:27:26 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C6275DA75;
 Fri, 27 Mar 2020 08:27:11 +0000 (UTC)
Subject: Re: [EXT] Re: [PATCH v9 2/9] memory: Add interface to set iommu page
 size mask
To: Bharat Bhushan <bbhushan2@marvell.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>, "Tomasz Nowicki [C]"
 <tnowicki@marvell.com>, "drjones@redhat.com" <drjones@redhat.com>,
 "linuc.decode@gmail.com" <linuc.decode@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "bharatb.linux@gmail.com" <bharatb.linux@gmail.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "yang.zhong@intel.com" <yang.zhong@intel.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-3-bbhushan2@marvell.com>
 <325b9322-54b9-e0ea-a67c-52fa91082173@redhat.com>
 <MWHPR1801MB1966CDAEEB7C76ED465C10B2E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <606c2790-b3be-5501-386b-bc5a33ba7584@redhat.com>
Date: Fri, 27 Mar 2020 09:27:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <MWHPR1801MB1966CDAEEB7C76ED465C10B2E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

On 3/27/20 6:33 AM, Bharat Bhushan wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Auger Eric <eric.auger@redhat.com>
>> Sent: Thursday, March 26, 2020 9:36 PM
>> To: Bharat Bhushan <bbhushan2@marvell.com>; peter.maydell@linaro.org;
>> peterx@redhat.com; eric.auger.pro@gmail.com; alex.williamson@redhat.com;
>> kevin.tian@intel.com; mst@redhat.com; Tomasz Nowicki [C]
>> <tnowicki@marvell.com>; drjones@redhat.com; linuc.decode@gmail.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; bharatb.linux@gmail.com; jean-
>> philippe@linaro.org; yang.zhong@intel.com
>> Subject: [EXT] Re: [PATCH v9 2/9] memory: Add interface to set iommu page size
>> mask
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> Hi Bharat,
>> On 3/23/20 9:46 AM, Bharat Bhushan wrote:
>>> Allow to set page size mask to be supported by iommu.
>> by iommu memory region. I mean this is not global to the IOMMU.
> 
> Yes.
> 
>>> This is required to expose page size mask compatible with host with
>>> virtio-iommu.
>>>
>>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>>> ---
>>>  include/exec/memory.h | 20 ++++++++++++++++++++
>>>  memory.c              | 10 ++++++++++
>>>  2 files changed, 30 insertions(+)
>>>
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h index
>>> e85b7de99a..063c424854 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -355,6 +355,16 @@ typedef struct IOMMUMemoryRegionClass {
>>>       * @iommu: the IOMMUMemoryRegion
>>>       */
>>>      int (*num_indexes)(IOMMUMemoryRegion *iommu);
>>> +
>>> +    /*
>>> +     * Set supported IOMMU page size
>>> +     *
>>> +     * Optional method: if this is supported then set page size that
>>> +     * can be supported by IOMMU. This is called to set supported page
>>> +     * size as per host Linux.
>> What about: If supported, allows to restrict the page size mask that can be
>> supported with a given IOMMU memory region. For example, this allows to
>> propagate host physical IOMMU page size mask limitations to the virtual IOMMU
>> (vfio assignment with virtual iommu).
> 
> Much better 
> 
>>> +     */
>>> +     void (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
>>> +                                      uint64_t page_size_mask);
>>>  } IOMMUMemoryRegionClass;
>>>
>>>  typedef struct CoalescedMemoryRange CoalescedMemoryRange; @@ -1363,6
>>> +1373,16 @@ int
>> memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
>>>   */
>>>  int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
>>>
>>> +/**
>>> + * memory_region_iommu_set_page_size_mask: set the supported pages
>>> + * size by iommu.
>> supported page sizes for a given IOMMU memory region
>>> + *
>>> + * @iommu_mr: the memory region
>> IOMMU memory region
>>> + * @page_size_mask: supported page size mask  */ void
>>> +memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion
>> *iommu_mr,
>>> +                                            uint64_t page_size_mask);
>>> +
>>>  /**
>>>   * memory_region_name: get a memory region's name
>>>   *
>>> diff --git a/memory.c b/memory.c
>>> index aeaa8dcc9e..14c8783084 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -1833,6 +1833,16 @@ static int
>> memory_region_update_iommu_notify_flags(IOMMUMemoryRegion
>> *iommu_mr,
>>>      return ret;
>>>  }
>>>
>>> +void memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion
>> *iommu_mr,
>>> +                                            uint64_t page_size_mask)
>>> +{
>>> +    IOMMUMemoryRegionClass *imrc =
>>> +IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
>>> +
>>> +    if (imrc->iommu_set_page_size_mask) {
>>> +        imrc->iommu_set_page_size_mask(iommu_mr, page_size_mask);
>> Shouldn't it return an int in case the setting cannot be applied?
> 
> iommu_set_page_size_mask() is setting page-size-mask for endpoint. Below function from code
> 
> 	static void virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>               	                              uint64_t page_size_mask)
> 	{
>     		IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> 
> 	              sdev->page_size_mask = page_size_mask;
> 	}
> 
> Do you see any reason it cannot be applied, am I missing something?
maybe the function can be called several times and one setting is
already in place. In other contexts, maybe the setting we try to apply
is not compatible with other settings enforced?

Thanks

Eric
> 
> Thanks
> -Bharat
> 
>>> +    }
>>> +}
>>> +
>>>  int memory_region_register_iommu_notifier(MemoryRegion *mr,
>>>                                            IOMMUNotifier *n, Error
>>> **errp)  {
>>>
>> Thanks
>> Eric
> 


