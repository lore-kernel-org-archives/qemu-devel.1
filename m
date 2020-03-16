Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16641C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D542F20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Avd0dxTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D542F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDlob-0003QC-Kz
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 05:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jDlgY-0000rq-8M
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jDlgW-0007gB-Ge
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:05:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jDlgW-0007bI-9c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584349519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkZFy3O/e8vRMuJt1+ye5o1azRJd0Pjjwn40vXnnCmY=;
 b=Avd0dxTiYGfyXM85Mf5i1NrMIGkVfNqakkoPEFu+zb++gF/Z8TTh+Mbn7YFcTJ1qexnA4+
 ZGNWjmQe8L0sdJ9LN721Yl+NjpMu7hDX6Zw5J3ekuwxP5CrfRgY9COFdzSV8+Ny5XFoj0Q
 erSHHrxSNe1xVXVXBlDHfP0cy9hfzIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-uhlrNQ5SMq6wio6-j8wQiQ-1; Mon, 16 Mar 2020 05:05:16 -0400
X-MC-Unique: uhlrNQ5SMq6wio6-j8wQiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F2C58017CC;
 Mon, 16 Mar 2020 09:05:14 +0000 (UTC)
Received: from [10.36.118.12] (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0543A19C70;
 Mon, 16 Mar 2020 09:04:59 +0000 (UTC)
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
To: Bharat Bhushan <bharatb.linux@gmail.com>
References: <20200313074811.27175-1-bbhushan2@marvell.com>
 <20200313074811.27175-4-bbhushan2@marvell.com>
 <da0a4d7b-c27d-839d-56b6-da67c94adeb7@redhat.com>
 <CAAeCc_m=PKV0T8DmaE06F9NMYfU792f9TDdoyKkaPaEN3597ag@mail.gmail.com>
 <9b4ab5e8-8848-50ba-17c8-652567483126@redhat.com>
 <CAAeCc_ksAdoNJcFWkoB4YcySAb5Hw7D+kLyHx-Nt0hZJY17AXA@mail.gmail.com>
 <CAAeCc_nnM-DGCyXjFJuk-6L8F+Oetq076SEjeV8kUAGxfJVQTw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <cc447790-d1c5-784b-9706-fbcd76f0c94b@redhat.com>
Date: Mon, 16 Mar 2020 10:04:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAAeCc_nnM-DGCyXjFJuk-6L8F+Oetq076SEjeV8kUAGxfJVQTw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 mst@redhat.com, drjones@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, qemu-arm@nongnu.org,
 Bharat Bhushan <bbhushan2@marvell.com>, linuc.decode@gmail.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

On 3/16/20 9:58 AM, Bharat Bhushan wrote:
> Hi Eric,
> 
> On Mon, Mar 16, 2020 at 1:15 PM Bharat Bhushan <bharatb.linux@gmail.com> wrote:
>>
>> Hi Eric,
>>
>> On Mon, Mar 16, 2020 at 1:02 PM Auger Eric <eric.auger@redhat.com> wrote:
>>>
>>> Hi Bharat,
>>>
>>> On 3/16/20 7:41 AM, Bharat Bhushan wrote:
>>>> Hi Eric,
>>>>
>>>> On Fri, Mar 13, 2020 at 8:11 PM Auger Eric <eric.auger@redhat.com> wrote:
>>>>>
>>>>> Hi Bharat
>>>>>
>>>>> On 3/13/20 8:48 AM, Bharat Bhushan wrote:
>>>>>> iommu-notifier are called when a device is attached
>>>>> IOMMU notifiers
>>>>>> or detached to as address-space.
>>>>>> This is needed for VFIO.
>>>>> and vhost for detach
>>>>>>
>>>>>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>>>>>> ---
>>>>>>  hw/virtio/virtio-iommu.c | 47 ++++++++++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 47 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>>>>> index e51344a53e..2006f72901 100644
>>>>>> --- a/hw/virtio/virtio-iommu.c
>>>>>> +++ b/hw/virtio/virtio-iommu.c
>>>>>> @@ -49,6 +49,7 @@ typedef struct VirtIOIOMMUEndpoint {
>>>>>>      uint32_t id;
>>>>>>      VirtIOIOMMUDomain *domain;
>>>>>>      QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
>>>>>> +    VirtIOIOMMU *viommu;
>>>>> This needs specal care on post-load. When migrating the EPs, only the id
>>>>> is migrated. On post-load you need to set viommu as it is done for
>>>>> domain. migration is allowed with vhost.
>>>>
>>>> ok, I have not tried vhost/migration. Below change set viommu when
>>>> reconstructing endpoint.
>>>
>>>
>>> Yes I think this should be OK.
>>>
>>> By the end I did the series a try with vhost/vfio. with vhost it works
>>> (not with recent kernel though, but the issue may be related to kernel).
>>> With VFIO however it does not for me.
>>>
>>> First issue is: your guest can use 4K page and your host can use 64KB
>>> pages. In that case VFIO_DMA_MAP will fail with -EINVAL. We must devise
>>> a way to pass the host settings to the VIRTIO-IOMMU device.
>>>
>>> Even with 64KB pages, it did not work for me. I have obviously not the
>>> storm of VFIO_DMA_MAP failures but I have some, most probably due to
>>> some wrong notifications somewhere. I will try to investigate on my side.
>>>
>>> Did you test with VFIO on your side?
>>
>> I did not tried with different page sizes, only tested with 4K page size.
>>
>> Yes it works, I tested with two n/w device assigned to VM, both interfaces works
>>
>> First I will try with 64k page size.
> 
> 64K page size does not work for me as well,
> 
> I think we are not passing correct page_size_mask here
> (config.page_size_mask is set to TARGET_PAGE_MASK ( which is
> 0xfffffffffffff000))
I guess you mean with guest using 4K and host using 64K.
> 
> We need to set this correctly as per host page size, correct?
Yes that's correct. We need to put in place a control path to retrieve
the page settings on host through VFIO to inform the virtio-iommu device.

Besides this issue, did you try with 64kB on host and guest?

Thanks

Eric
> 
> Thanks
> -Bharat
> 
>>
>> Thanks
>> -Bharat
>>
>>>
>>> Thanks
>>>
>>> Eric
>>>>
>>>> @@ -984,6 +973,7 @@ static gboolean reconstruct_endpoints(gpointer
>>>> key, gpointer value,
>>>>
>>>>      QLIST_FOREACH(iter, &d->endpoint_list, next) {
>>>>          iter->domain = d;
>>>> +       iter->viommu = s;
>>>>          g_tree_insert(s->endpoints, GUINT_TO_POINTER(iter->id), iter);
>>>>      }
>>>>      return false; /* continue the domain traversal */
>>>>
>>>>>>  } VirtIOIOMMUEndpoint;
>>>>>>
>>>>>>  typedef struct VirtIOIOMMUInterval {
>>>>>> @@ -155,8 +156,44 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
>>>>>>      memory_region_notify_iommu(mr, 0, entry);
>>>>>>  }
>>>>>>
>>>>>> +static gboolean virtio_iommu_mapping_unmap(gpointer key, gpointer value,
>>>>>> +                                           gpointer data)
>>>>>> +{
>>>>>> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
>>>>>> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
>>>>>> +
>>>>>> +    virtio_iommu_notify_unmap(mr, interval->low,
>>>>>> +                              interval->high - interval->low + 1);
>>>>>> +
>>>>>> +    return false;
>>>>>> +}
>>>>>> +
>>>>>> +static gboolean virtio_iommu_mapping_map(gpointer key, gpointer value,
>>>>>> +                                         gpointer data)
>>>>>> +{
>>>>>> +    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
>>>>>> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
>>>>>> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
>>>>>> +
>>>>>> +    virtio_iommu_notify_map(mr, interval->low, mapping->phys_addr,
>>>>>> +                            interval->high - interval->low + 1);
>>>>>> +
>>>>>> +    return false;
>>>>>> +}
>>>>>> +
>>>>>>  static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
>>>>>>  {
>>>>>> +    VirtioIOMMUNotifierNode *node;
>>>>>> +    VirtIOIOMMU *s = ep->viommu;
>>>>>> +    VirtIOIOMMUDomain *domain = ep->domain;
>>>>>> +
>>>>>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
>>>>>> +        if (ep->id == node->iommu_dev->devfn) {
>>>>>> +            g_tree_foreach(domain->mappings, virtio_iommu_mapping_unmap,
>>>>>> +                           &node->iommu_dev->iommu_mr);
>>>>> I understand this should fo the job for domain removal
>>>>
>>>> did not get the comment, are you saying we should do this on domain removal?
>>> see my reply on 2/5
>>>
>>> Note the above code should be moved after the check of !ep->domain below
>>
>> ohh yes, will move
>>
>> Thanks
>> -Bharat
>>
>>>>
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>>      if (!ep->domain) {
>>>>>>          return;
>>>>>>      }
>>>>>> @@ -178,6 +215,7 @@ static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>>>>>>      }
>>>>>>      ep = g_malloc0(sizeof(*ep));
>>>>>>      ep->id = ep_id;
>>>>>> +    ep->viommu = s;
>>>>>>      trace_virtio_iommu_get_endpoint(ep_id);
>>>>>>      g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
>>>>>>      return ep;
>>>>>> @@ -272,6 +310,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>>>>>>  {
>>>>>>      uint32_t domain_id = le32_to_cpu(req->domain);
>>>>>>      uint32_t ep_id = le32_to_cpu(req->endpoint);
>>>>>> +    VirtioIOMMUNotifierNode *node;
>>>>>>      VirtIOIOMMUDomain *domain;
>>>>>>      VirtIOIOMMUEndpoint *ep;
>>>>>>
>>>>>> @@ -299,6 +338,14 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>>>>>>
>>>>>>      ep->domain = domain;
>>>>>>
>>>>>> +    /* Replay existing address space mappings on the associated memory region */
>>>>> maybe use the "domain" terminology here.
>>>>
>>>> ok,
>>>>
>>>> Thanks
>>>> -Bharat
>>>>
>>>>>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
>>>>>> +        if (ep_id == node->iommu_dev->devfn) {
>>>>>> +            g_tree_foreach(domain->mappings, virtio_iommu_mapping_map,
>>>>>> +                           &node->iommu_dev->iommu_mr);
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>>      return VIRTIO_IOMMU_S_OK;
>>>>>>  }
>>>>>>
>>>>>>
>>>>> Thanks
>>>>>
>>>>> Eric
>>>>>
>>>>
>>>
> 


