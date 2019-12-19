Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261FAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4710206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISbEIS4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4710206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxS8-0003iO-3w
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ihxRP-0002aP-T7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ihxRN-0002Wb-B0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:10:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ihxRM-0002U8-7w
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576768210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0UTtIepKxxGnA5XLSDgUjbcapXtoa0Q6IZaZy2NQbM=;
 b=ISbEIS4SH9qQ0lX/hmRRObmE43xT5PZP+uau5nuo5y7eWQrRqAhKN0/1Ir0lARFv5S2DOP
 dsnW96m4qmqxoi+QR2YxT04YR1C8+BZqWkOgY9EuCOLkwXc8EtYYircMzAO9ANy7OfZ/30
 oDb8KLwlgAhyubxXf5tlPgncWqExy4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-P934_7KrNnW88u4Xt8GOAQ-1; Thu, 19 Dec 2019 10:10:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 333D59B5A7;
 Thu, 19 Dec 2019 15:10:00 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44DF76E3F7;
 Thu, 19 Dec 2019 15:09:52 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
To: Peter Xu <peterx@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-9-eric.auger@redhat.com> <20191210193342.GJ3352@xz-x1>
 <44c0041d-68ad-796f-16cc-4bab7ba0f164@redhat.com>
 <20191219133308.GA4246@xz-x1>
 <9d58b293-ada0-353e-bba2-ad1f538dfc62@redhat.com>
 <20191219144936.GB50561@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9ec9d0d5-062b-f96b-c72c-4d15865ff9a1@redhat.com>
Date: Thu, 19 Dec 2019 16:09:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191219144936.GB50561@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: P934_7KrNnW88u4Xt8GOAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter, jean,

On 12/19/19 3:49 PM, Peter Xu wrote:
> On Thu, Dec 19, 2019 at 03:38:34PM +0100, Auger Eric wrote:
>> Hi Peter,
>>
>> On 12/19/19 2:33 PM, Peter Xu wrote:
>>> On Thu, Dec 19, 2019 at 11:30:40AM +0100, Auger Eric wrote:
>>>> Hi Peter,
>>>> On 12/10/19 8:33 PM, Peter Xu wrote:
>>>>> On Fri, Nov 22, 2019 at 07:29:31PM +0100, Eric Auger wrote:
>>>>>> This patch implements the translate callback
>>>>>>
>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> v10 -> v11:
>>>>>> - take into account the new value struct and use
>>>>>>   g_tree_lookup_extended
>>>>>> - switched to error_report_once
>>>>>>
>>>>>> v6 -> v7:
>>>>>> - implemented bypass-mode
>>>>>>
>>>>>> v5 -> v6:
>>>>>> - replace error_report by qemu_log_mask
>>>>>>
>>>>>> v4 -> v5:
>>>>>> - check the device domain is not NULL
>>>>>> - s/printf/error_report
>>>>>> - set flags to IOMMU_NONE in case of all translation faults
>>>>>> ---
>>>>>>  hw/virtio/trace-events   |  1 +
>>>>>>  hw/virtio/virtio-iommu.c | 63 +++++++++++++++++++++++++++++++++++++++-
>>>>>>  2 files changed, 63 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>>>>>> index f25359cee2..de7cbb3c8f 100644
>>>>>> --- a/hw/virtio/trace-events
>>>>>> +++ b/hw/virtio/trace-events
>>>>>> @@ -72,3 +72,4 @@ virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoint=%d"
>>>>>>  virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=%d"
>>>>>>  virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
>>>>>>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>>>>>> +virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
>>>>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>>>>> index f0a56833a2..a83666557b 100644
>>>>>> --- a/hw/virtio/virtio-iommu.c
>>>>>> +++ b/hw/virtio/virtio-iommu.c
>>>>>> @@ -412,19 +412,80 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>>>>                                              int iommu_idx)
>>>>>>  {
>>>>>>      IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
>>>>>> +    viommu_interval interval, *mapping_key;
>>>>>> +    viommu_mapping *mapping_value;
>>>>>> +    VirtIOIOMMU *s = sdev->viommu;
>>>>>> +    viommu_endpoint *ep;
>>>>>> +    bool bypass_allowed;
>>>>>>      uint32_t sid;
>>>>>> +    bool found;
>>>>>> +
>>>>>> +    interval.low = addr;
>>>>>> +    interval.high = addr + 1;
>>>>>>  
>>>>>>      IOMMUTLBEntry entry = {
>>>>>>          .target_as = &address_space_memory,
>>>>>>          .iova = addr,
>>>>>>          .translated_addr = addr,
>>>>>> -        .addr_mask = ~(hwaddr)0,
>>>>>> +        .addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1,
>>>>>>          .perm = IOMMU_NONE,
>>>>>>      };
>>>>>>  
>>>>>> +    bypass_allowed = virtio_has_feature(s->acked_features,
>>>>>> +                                        VIRTIO_IOMMU_F_BYPASS);
>>>>>> +
>>>>>
>>>>> Would it be easier to check bypass_allowed here once and then drop the
>>>>> latter [1] and [2] check?
>>>> bypass_allowed does not mean you systematically bypass. You bypass if
>>>> the SID is unknown or if the device is not attached to any domain.
>>>> Otherwise you translate. But maybe I miss your point.
>>>
>>> Ah ok, then could I ask how will this VIRTIO_IOMMU_F_BYPASS be used?
>>> For example, I think VT-d defines passthrough in a totally different
>>> way in that the PT mark will be stored in the per-device context
>>> entries, then we can allow a specific device to be pass-through when
>>> doing DMA.  That information is explicit (e.g., unknown SID will
>>> always fail the DMA), and per-device.
>>>
>>> Here do you mean that you just don't put a device into any domain to
>>> show it wants to use PT?  Then I'm not sure how do you identify
>>> whether this is a legal PT or a malicious device (e.g., an unknown
>>> device that even does not have any driver bound to it, which will also
>>> satisfy "unknown SID" and "not attached to any domain", iiuc).
>>
>> The virtio-iommu spec currently says:
>>
>> "If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all accesses from
>> unattached endpoints are
>> allowed and translated by the IOMMU using the identity function. If the
>> feature is not negotiated, any
>> memory access from an unattached endpoint fails. Upon attaching an
>> endpoint in bypass mode to a new
>> domain, any memory access from the endpoint fails, since the domain does
>> not contain any mapping.
>> "
>>
>> I guess this can serve the purpose of devices doing early accesses,
>> before the guest OS gets the hand and maps them?
> 
> OK, so there's no global enablement knob for virtio-iommu? Hmm... Then:
well this is a global knob. If this is bot negotiated any unmapped
device can PT.

My assumption above must be wrong as this is a negotiated feature so
anyway the virtio-iommu driver should be involved.

I don't really remember the rationale of the feature bit tbh.

In "[virtio-dev] RE: [RFC] virtio-iommu version 0.4 " Jean discussed
that with Kevein. Sorry I cannot find the link.

" If the endpoint is not attached to any address space,
then the device MAY abort the transaction."

Kevin> From definition of BYPASS, it's orthogonal to whether there is an
address space attached, then should we still allow "May abort" behavior?

Jean> The behavior is left as an implementation choice, and I'm not sure
it's worth enforcing in the architecture. If the endpoint isn't attached
to any domain then (unless VIRTIO_IOMMU_F_BYPASS is negotiated), it
isn't necessarily able to do DMA at all. The virtio-iommu device may
setup DMA mastering lazily, in which case any DMA transaction would
abort, or have setup DMA already, in which case the endpoint can access
MEM_T_BYPASS regions.

Hopefully Jean will remember and comment on this.

Thanks

Eric

> 
>   - This flag is a must for all virtio-iommu emulation, right?
>     (otherwise I can't see how system bootstraps..)
> 
>   - Should this flag be gone right after OS starts (otherwise I think
>     we still have the issue that any malicious device can be seen as
>     in PT mode as default)?  How is that done?
> 
> Thanks,
> 


