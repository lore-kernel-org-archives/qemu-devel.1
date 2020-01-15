Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E2AC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32482084D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3RfF1HQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32482084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iriUg-0004vO-2M
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iriTK-0003nr-Lh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iriTJ-00059N-5b
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:12:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52620
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iriTI-00058o-VV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579093952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRtlBIlRG22NDwjLZS+xtBq4H5JjBkREdqV9c7G0F38=;
 b=V3RfF1HQjdhqDeg3YgJqux/JWIJui36bXAc4mKg4ZcfVoylcCJg1TS103XoqEJFlr8uhIr
 vNCAnSrIfTP/1rEjVGsuBkXZhKU5YjiaOS9uR/tPdvBD78ftPfMqoBsHZUb3/BcC8ojraV
 g6WVHLjq+Ik3ga8RJrMHhJJUVgHPQlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-2edH_nM6P_ijDOsgfgn3TQ-1; Wed, 15 Jan 2020 08:12:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9C2D10CE786;
 Wed, 15 Jan 2020 13:12:29 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D475E5D9C5;
 Wed, 15 Jan 2020 13:12:21 +0000 (UTC)
Subject: Re: [PATCH v12 09/13] virtio-iommu: Implement fault reporting
To: Peter Xu <peterx@redhat.com>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-10-eric.auger@redhat.com>
 <20200114190433.GE225163@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2a060fcf-f9d6-c6bf-d444-018df532e475@redhat.com>
Date: Wed, 15 Jan 2020 14:12:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200114190433.GE225163@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 2edH_nM6P_ijDOsgfgn3TQ-1
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 1/14/20 8:04 PM, Peter Xu wrote:
> On Thu, Jan 09, 2020 at 03:43:15PM +0100, Eric Auger wrote:
>> The event queue allows to report asynchronous errors.
>> The translate function now injects faults when relevant.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v11 -> v12:
>> - reporting the addr associated with the fault and set the
>>   VIRTIO_IOMMU_FAULT_F_ADDRESS flag.
>> - added cpu_to_le<n>
>>
>> v10 -> v11:
>> - change a virtio_error into an error_report_once
>>   (no buffer available for output faults)
>> ---
>>  hw/virtio/trace-events   |  1 +
>>  hw/virtio/virtio-iommu.c | 73 +++++++++++++++++++++++++++++++++++++---
>>  2 files changed, 69 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index 095aa8b509..e83500bee9 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -72,3 +72,4 @@ virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=%d"
>>  virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
>>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>>  virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
>> +virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index d192bcb505..09193970ee 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -477,6 +477,51 @@ out:
>>      }
>>  }
>>  
>> +static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
>> +                                      int flags, uint32_t endpoint,
>> +                                      uint64_t address)
>> +{
>> +    VirtIODevice *vdev = &viommu->parent_obj;
>> +    VirtQueue *vq = viommu->event_vq;
>> +    struct virtio_iommu_fault fault;
>> +    VirtQueueElement *elem;
>> +    size_t sz;
>> +
>> +    memset(&fault, 0, sizeof(fault));
>> +    fault.reason = reason;
>> +    fault.flags = cpu_to_le32(flags);
>> +    fault.endpoint = cpu_to_le32(endpoint);
>> +    fault.address = cpu_to_le64(address);
>> +
>> +    for (;;) {
>> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>> +
>> +        if (!elem) {
>> +            error_report_once(
>> +                "no buffer available in event queue to report event");
> 
> (Should this also be a guest issue?  IIRC you are still using a
>  mixture of both qemu_log_mask and error_report()... I'll stop
>  commenting on this, assuming that you prefer both ways to be used...)

I've just removed the qemu_log_mask in virtio_iommu_unmap(). So now you
should not find any qemu_log_mask anymore. Sorry for the oversight.
> 
>> +            return;
>> +        }
>> +
>> +        if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
>> +            virtio_error(vdev, "error buffer of wrong size");
>> +            virtqueue_detach_element(vq, elem, 0);
>> +            g_free(elem);
>> +            continue;
> 
> If virtio_error(), should we stop rather than continue?
My understanding is the buffer just popped had a wrong size so it is not
usable. We skip it we try to use another one if any. Does it make sense?

Thanks

Eric
> 
>> +        }
>> +        break;
>> +    }
>> +    /* we have a buffer to fill in */
>> +    sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>> +                      &fault, sizeof(fault));
>> +    assert(sz == sizeof(fault));
>> +
>> +    trace_virtio_iommu_report_fault(reason, flags, endpoint, address);
>> +    virtqueue_push(vq, elem, sz);
>> +    virtio_notify(vdev, vq);
>> +    g_free(elem);
>> +
>> +}
>> +
>>  static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>                                              IOMMUAccessFlags flag,
>>                                              int iommu_idx)
>> @@ -485,9 +530,10 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>      VirtIOIOMMUInterval interval, *mapping_key;
>>      VirtIOIOMMUMapping *mapping_value;
>>      VirtIOIOMMU *s = sdev->viommu;
>> +    bool read_fault, write_fault;
>>      VirtIOIOMMUEndpoint *ep;
>> +    uint32_t sid, flags;
>>      bool bypass_allowed;
>> -    uint32_t sid;
>>      bool found;
>>  
>>      interval.low = addr;
>> @@ -513,6 +559,9 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>      if (!ep) {
>>          if (!bypass_allowed) {
>>              error_report_once("%s sid=%d is not known!!", __func__, sid);
>> +            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_UNKNOWN,
>> +                                      VIRTIO_IOMMU_FAULT_F_ADDRESS,
>> +                                      sid, addr);
>>          } else {
>>              entry.perm = flag;
>>          }
>> @@ -524,6 +573,9 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>              error_report_once("%s %02x:%02x.%01x not attached to any domain",
>>                                __func__, PCI_BUS_NUM(sid),
>>                                PCI_SLOT(sid), PCI_FUNC(sid));
>> +            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_DOMAIN,
>> +                                      VIRTIO_IOMMU_FAULT_F_ADDRESS,
>> +                                      sid, addr);
>>          } else {
>>              entry.perm = flag;
>>          }
>> @@ -536,15 +588,26 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>      if (!found) {
>>          error_report_once("%s no mapping for 0x%"PRIx64" for sid=%d",
>>                            __func__, addr, sid);
>> +        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
>> +                                  VIRTIO_IOMMU_FAULT_F_ADDRESS,
>> +                                  sid, addr);
>>          goto unlock;
>>      }
>>  
>> -    if (((flag & IOMMU_RO) &&
>> -            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_READ)) ||
>> -        ((flag & IOMMU_WO) &&
>> -            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_WRITE))) {
>> +    read_fault = (flag & IOMMU_RO) &&
>> +                    !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_READ);
>> +    write_fault = (flag & IOMMU_WO) &&
>> +                    !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_WRITE);
>> +
>> +    flags = read_fault ? VIRTIO_IOMMU_FAULT_F_READ : 0;
>> +    flags |= write_fault ? VIRTIO_IOMMU_FAULT_F_WRITE : 0;
>> +    if (flags) {
>>          error_report_once("%s permission error on 0x%"PRIx64"(%d): allowed=%d",
>>                            __func__, addr, flag, mapping_value->flags);
>> +        flags |= VIRTIO_IOMMU_FAULT_F_ADDRESS;
>> +        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
>> +                                  flags | VIRTIO_IOMMU_FAULT_F_ADDRESS,
>> +                                  sid, addr);
>>          goto unlock;
>>      }
>>      entry.translated_addr = addr - mapping_key->low + mapping_value->phys_addr;
>> -- 
>> 2.20.1
>>
> 


