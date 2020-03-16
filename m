Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD2CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F73C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzV5aF3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F73C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDkKj-0002Gy-1J
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 03:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jDkFB-0000be-3w
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jDkF9-0004xN-I2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:33:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jDkF9-0004tH-C8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584343978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wf3WwVL/JBIClkEjmfQynOAqNs2BQUeZP5Q2JbyPWw4=;
 b=ZzV5aF3A8yi+92QpAisncRcOe39uZerLHC8ztbQCcIg2xVdevJ46up0yS28cQYdracyJh/
 ByXkDA7FtddYgCfv6IQ76zIbsUYTjqrR+sGyFVNKvEL8qrdSmC5Pc3Ceccjug6K7PxWKlJ
 Dz21sClwBRS2JNyz42RuWM9BXB6C618=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-dKLpBODMP9eskMr_QQzfUw-1; Mon, 16 Mar 2020 03:32:55 -0400
X-MC-Unique: dKLpBODMP9eskMr_QQzfUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC4ED800D50;
 Mon, 16 Mar 2020 07:32:53 +0000 (UTC)
Received: from [10.36.118.12] (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 115E460BE2;
 Mon, 16 Mar 2020 07:32:40 +0000 (UTC)
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
To: Bharat Bhushan <bharatb.linux@gmail.com>
References: <20200313074811.27175-1-bbhushan2@marvell.com>
 <20200313074811.27175-4-bbhushan2@marvell.com>
 <da0a4d7b-c27d-839d-56b6-da67c94adeb7@redhat.com>
 <CAAeCc_m=PKV0T8DmaE06F9NMYfU792f9TDdoyKkaPaEN3597ag@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9b4ab5e8-8848-50ba-17c8-652567483126@redhat.com>
Date: Mon, 16 Mar 2020 08:32:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAAeCc_m=PKV0T8DmaE06F9NMYfU792f9TDdoyKkaPaEN3597ag@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 3/16/20 7:41 AM, Bharat Bhushan wrote:
> Hi Eric,
> 
> On Fri, Mar 13, 2020 at 8:11 PM Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Bharat
>>
>> On 3/13/20 8:48 AM, Bharat Bhushan wrote:
>>> iommu-notifier are called when a device is attached
>> IOMMU notifiers
>>> or detached to as address-space.
>>> This is needed for VFIO.
>> and vhost for detach
>>>
>>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>>> ---
>>>  hw/virtio/virtio-iommu.c | 47 ++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 47 insertions(+)
>>>
>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>> index e51344a53e..2006f72901 100644
>>> --- a/hw/virtio/virtio-iommu.c
>>> +++ b/hw/virtio/virtio-iommu.c
>>> @@ -49,6 +49,7 @@ typedef struct VirtIOIOMMUEndpoint {
>>>      uint32_t id;
>>>      VirtIOIOMMUDomain *domain;
>>>      QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
>>> +    VirtIOIOMMU *viommu;
>> This needs specal care on post-load. When migrating the EPs, only the id
>> is migrated. On post-load you need to set viommu as it is done for
>> domain. migration is allowed with vhost.
> 
> ok, I have not tried vhost/migration. Below change set viommu when
> reconstructing endpoint.


Yes I think this should be OK.

By the end I did the series a try with vhost/vfio. with vhost it works
(not with recent kernel though, but the issue may be related to kernel).
With VFIO however it does not for me.

First issue is: your guest can use 4K page and your host can use 64KB
pages. In that case VFIO_DMA_MAP will fail with -EINVAL. We must devise
a way to pass the host settings to the VIRTIO-IOMMU device.

Even with 64KB pages, it did not work for me. I have obviously not the
storm of VFIO_DMA_MAP failures but I have some, most probably due to
some wrong notifications somewhere. I will try to investigate on my side.

Did you test with VFIO on your side?

Thanks

Eric
> 
> @@ -984,6 +973,7 @@ static gboolean reconstruct_endpoints(gpointer
> key, gpointer value,
> 
>      QLIST_FOREACH(iter, &d->endpoint_list, next) {
>          iter->domain = d;
> +       iter->viommu = s;
>          g_tree_insert(s->endpoints, GUINT_TO_POINTER(iter->id), iter);
>      }
>      return false; /* continue the domain traversal */
> 
>>>  } VirtIOIOMMUEndpoint;
>>>
>>>  typedef struct VirtIOIOMMUInterval {
>>> @@ -155,8 +156,44 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
>>>      memory_region_notify_iommu(mr, 0, entry);
>>>  }
>>>
>>> +static gboolean virtio_iommu_mapping_unmap(gpointer key, gpointer value,
>>> +                                           gpointer data)
>>> +{
>>> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
>>> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
>>> +
>>> +    virtio_iommu_notify_unmap(mr, interval->low,
>>> +                              interval->high - interval->low + 1);
>>> +
>>> +    return false;
>>> +}
>>> +
>>> +static gboolean virtio_iommu_mapping_map(gpointer key, gpointer value,
>>> +                                         gpointer data)
>>> +{
>>> +    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
>>> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
>>> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
>>> +
>>> +    virtio_iommu_notify_map(mr, interval->low, mapping->phys_addr,
>>> +                            interval->high - interval->low + 1);
>>> +
>>> +    return false;
>>> +}
>>> +
>>>  static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
>>>  {
>>> +    VirtioIOMMUNotifierNode *node;
>>> +    VirtIOIOMMU *s = ep->viommu;
>>> +    VirtIOIOMMUDomain *domain = ep->domain;
>>> +
>>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
>>> +        if (ep->id == node->iommu_dev->devfn) {
>>> +            g_tree_foreach(domain->mappings, virtio_iommu_mapping_unmap,
>>> +                           &node->iommu_dev->iommu_mr);
>> I understand this should fo the job for domain removal
> 
> did not get the comment, are you saying we should do this on domain removal?
see my reply on 2/5

Note the above code should be moved after the check of !ep->domain below
> 
>>> +        }
>>> +    }
>>> +
>>>      if (!ep->domain) {
>>>          return;
>>>      }
>>> @@ -178,6 +215,7 @@ static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>>>      }
>>>      ep = g_malloc0(sizeof(*ep));
>>>      ep->id = ep_id;
>>> +    ep->viommu = s;
>>>      trace_virtio_iommu_get_endpoint(ep_id);
>>>      g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
>>>      return ep;
>>> @@ -272,6 +310,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>>>  {
>>>      uint32_t domain_id = le32_to_cpu(req->domain);
>>>      uint32_t ep_id = le32_to_cpu(req->endpoint);
>>> +    VirtioIOMMUNotifierNode *node;
>>>      VirtIOIOMMUDomain *domain;
>>>      VirtIOIOMMUEndpoint *ep;
>>>
>>> @@ -299,6 +338,14 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>>>
>>>      ep->domain = domain;
>>>
>>> +    /* Replay existing address space mappings on the associated memory region */
>> maybe use the "domain" terminology here.
> 
> ok,
> 
> Thanks
> -Bharat
> 
>>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
>>> +        if (ep_id == node->iommu_dev->devfn) {
>>> +            g_tree_foreach(domain->mappings, virtio_iommu_mapping_map,
>>> +                           &node->iommu_dev->iommu_mr);
>>> +        }
>>> +    }
>>> +
>>>      return VIRTIO_IOMMU_S_OK;
>>>  }
>>>
>>>
>> Thanks
>>
>> Eric
>>
> 


