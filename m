Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FEC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D12520705
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUA85n9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D12520705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHkN1-0006Q8-Bw
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 04:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jHkML-0005tT-QA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jHkMK-00049V-Fz
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:28:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46833)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jHkMK-000486-D8
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585297735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20Y4zlJaNBnfNuuKPoWhp+FJmNwDi/MeDM40fcn1rQM=;
 b=JUA85n9gtDbixyhfO/rdVEMXtBKVNpwQ+MBPeIIbKwcsDnAFw9lmVLnPXrwMcmKXZiK4dG
 WFurLfYltUEcfp++8jfrwQYFLiaus9EjmUyN5yDyJEq6l8wIaE2BgPXDbv7g4z6dwzzpPs
 WHzVFgd0jidy/vvc3GgFJh5QSnYfPtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-rmVpEUTCNqSu8GjkXpE1AQ-1; Fri, 27 Mar 2020 04:28:52 -0400
X-MC-Unique: rmVpEUTCNqSu8GjkXpE1AQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 337E5107ACCC;
 Fri, 27 Mar 2020 08:28:50 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EBCE19C69;
 Fri, 27 Mar 2020 08:28:36 +0000 (UTC)
Subject: Re: [EXT] Re: [PATCH v9 4/9] virtio-iommu: set supported page size
 mask
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
 <20200323084617.1782-5-bbhushan2@marvell.com>
 <994d9a4f-b8a8-7bda-f5a2-81d65711f580@redhat.com>
 <MWHPR1801MB1966FFC12887DFDA34B2D5D8E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f21bd15c-50ca-024a-2836-015fbfe38e61@redhat.com>
Date: Fri, 27 Mar 2020 09:28:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <MWHPR1801MB1966FFC12887DFDA34B2D5D8E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
On 3/27/20 6:13 AM, Bharat Bhushan wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Auger Eric <eric.auger@redhat.com>
>> Sent: Thursday, March 26, 2020 9:22 PM
>> To: Bharat Bhushan <bbhushan2@marvell.com>; peter.maydell@linaro.org;
>> peterx@redhat.com; eric.auger.pro@gmail.com; alex.williamson@redhat.com;
>> kevin.tian@intel.com; mst@redhat.com; Tomasz Nowicki [C]
>> <tnowicki@marvell.com>; drjones@redhat.com; linuc.decode@gmail.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; bharatb.linux@gmail.com; jean-
>> philippe@linaro.org; yang.zhong@intel.com
>> Subject: [EXT] Re: [PATCH v9 4/9] virtio-iommu: set supported page size mask
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> Hi Bharat,
>>
>> On 3/23/20 9:46 AM, Bharat Bhushan wrote:
>>> Add optional interface to set page size mask.
>>> Currently this is set global configuration and not per endpoint.
>> This allows to override the page size mask per end-point?
> 
> This patch adds per endpoint page-size-mask configuration in addition to global page-size-mask.
> endpoint page-size-mask will override global page-size-mask configuration for that endpoint.
Yes my comment was a suggestion for commit msg rephrasing. Sorry if it
was unclear. The above text sounds clearer.

thanks

Eric
> 
> Thanks
> -Bharat
> 
>>>
>>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>>> ---
>>>  include/hw/virtio/virtio-iommu.h | 1 +
>>>  hw/virtio/virtio-iommu.c         | 9 +++++++++
>>>  2 files changed, 10 insertions(+)
>>>
>>> diff --git a/include/hw/virtio/virtio-iommu.h
>>> b/include/hw/virtio/virtio-iommu.h
>>> index 6f67f1020a..4efa09610a 100644
>>> --- a/include/hw/virtio/virtio-iommu.h
>>> +++ b/include/hw/virtio/virtio-iommu.h
>>> @@ -35,6 +35,7 @@ typedef struct IOMMUDevice {
>>>      void         *viommu;
>>>      PCIBus       *bus;
>>>      int           devfn;
>>> +    uint64_t      page_size_mask;
>>>      IOMMUMemoryRegion  iommu_mr;
>>>      AddressSpace  as;
>>>  } IOMMUDevice;
>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c index
>>> 4cee8083bc..a28818202c 100644
>>> --- a/hw/virtio/virtio-iommu.c
>>> +++ b/hw/virtio/virtio-iommu.c
>>> @@ -650,6 +650,14 @@ static gint int_cmp(gconstpointer a, gconstpointer b,
>> gpointer user_data)
>>>      return (ua > ub) - (ua < ub);
>>>  }
>>>
>>> +static void virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>>> +                                            uint64_t page_size_mask)
>>> +{
>>> +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
>>> +
>>> +    sdev->page_size_mask = page_size_mask; }
>>> +
>>>  static void virtio_iommu_device_realize(DeviceState *dev, Error
>>> **errp)  {
>>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev); @@ -865,6 +873,7 @@
>>> static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>>>      IOMMUMemoryRegionClass *imrc =
>> IOMMU_MEMORY_REGION_CLASS(klass);
>>>
>>>      imrc->translate = virtio_iommu_translate;
>>> +    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
>>>  }
>>>
>>>  static const TypeInfo virtio_iommu_info = {
>>>
>> Thanks
>>
>> Eric
> 
> 


