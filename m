Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91161C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6D721D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuTBZJz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6D721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iht6W-0006ZB-Ca
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iht57-0005h0-Ul
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iht55-0007uj-87
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:30:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25792
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iht54-0007np-P5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576751453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tygimuW6/XhKjBMlfyKJvIAh68dK23wap9XfVLQOs0Q=;
 b=LuTBZJz+RX+p7Hl9KLQSpiM4dWl97Zqp8YqNBdjd72zxE88n4xK2UZxYZ9rdQWp7CBRYwH
 xSBuSt1dSy50npeXHP6t4/X362t1OrmHDiX8ezjIFkWDTFLJFyhJR3XwYTD7udA0QEP9d+
 +kzo6CeC91+jbAPHYVhOFrZ9PRZORNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-FsVGmdpaPqKk1x9Eqj-ylw-1; Thu, 19 Dec 2019 05:30:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5CCB800D5B;
 Thu, 19 Dec 2019 10:30:50 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 890516888D;
 Thu, 19 Dec 2019 10:30:42 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
To: Peter Xu <peterx@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-9-eric.auger@redhat.com> <20191210193342.GJ3352@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <44c0041d-68ad-796f-16cc-4bab7ba0f164@redhat.com>
Date: Thu, 19 Dec 2019 11:30:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191210193342.GJ3352@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: FsVGmdpaPqKk1x9Eqj-ylw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 12/10/19 8:33 PM, Peter Xu wrote:
> On Fri, Nov 22, 2019 at 07:29:31PM +0100, Eric Auger wrote:
>> This patch implements the translate callback
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v10 -> v11:
>> - take into account the new value struct and use
>>   g_tree_lookup_extended
>> - switched to error_report_once
>>
>> v6 -> v7:
>> - implemented bypass-mode
>>
>> v5 -> v6:
>> - replace error_report by qemu_log_mask
>>
>> v4 -> v5:
>> - check the device domain is not NULL
>> - s/printf/error_report
>> - set flags to IOMMU_NONE in case of all translation faults
>> ---
>>  hw/virtio/trace-events   |  1 +
>>  hw/virtio/virtio-iommu.c | 63 +++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index f25359cee2..de7cbb3c8f 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -72,3 +72,4 @@ virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoint=%d"
>>  virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=%d"
>>  virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
>>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>> +virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index f0a56833a2..a83666557b 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -412,19 +412,80 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>                                              int iommu_idx)
>>  {
>>      IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
>> +    viommu_interval interval, *mapping_key;
>> +    viommu_mapping *mapping_value;
>> +    VirtIOIOMMU *s = sdev->viommu;
>> +    viommu_endpoint *ep;
>> +    bool bypass_allowed;
>>      uint32_t sid;
>> +    bool found;
>> +
>> +    interval.low = addr;
>> +    interval.high = addr + 1;
>>  
>>      IOMMUTLBEntry entry = {
>>          .target_as = &address_space_memory,
>>          .iova = addr,
>>          .translated_addr = addr,
>> -        .addr_mask = ~(hwaddr)0,
>> +        .addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1,
>>          .perm = IOMMU_NONE,
>>      };
>>  
>> +    bypass_allowed = virtio_has_feature(s->acked_features,
>> +                                        VIRTIO_IOMMU_F_BYPASS);
>> +
> 
> Would it be easier to check bypass_allowed here once and then drop the
> latter [1] and [2] check?
bypass_allowed does not mean you systematically bypass. You bypass if
the SID is unknown or if the device is not attached to any domain.
Otherwise you translate. But maybe I miss your point.
> 
>>      sid = virtio_iommu_get_sid(sdev);
>>  
>>      trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
>> +    qemu_mutex_lock(&s->mutex);
>> +
>> +    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
>> +    if (!ep) {
>> +        if (!bypass_allowed) {
> 
> [1]
> 
>> +            error_report_once("%s sid=%d is not known!!", __func__, sid);
>> +        } else {
>> +            entry.perm = flag;
>> +        }
>> +        goto unlock;
>> +    }
>> +
>> +    if (!ep->domain) {
>> +        if (!bypass_allowed) {
> 
> [2]
> 
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s %02x:%02x.%01x not attached to any domain\n",
>> +                          __func__, PCI_BUS_NUM(sid),
>> +                          PCI_SLOT(sid), PCI_FUNC(sid));
>> +        } else {
>> +            entry.perm = flag;
>> +        }
>> +        goto unlock;
>> +    }
>> +
>> +    found = g_tree_lookup_extended(ep->domain->mappings, (gpointer)(&interval),
>> +                                   (void **)&mapping_key,
>> +                                   (void **)&mapping_value);
>> +    if (!found) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s no mapping for 0x%"PRIx64" for sid=%d\n",
>> +                      __func__, addr, sid);
> 
> I would still suggest that we use the same logging interface (either
> error_report_once() or qemu_log_mask(), not use them randomly).
OK I will switch to error_report_once() then
> 
>> +        goto unlock;
>> +    }
>> +
>> +    if (((flag & IOMMU_RO) &&
>> +            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_READ)) ||
>> +        ((flag & IOMMU_WO) &&
>> +            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_WRITE))) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "Permission error on 0x%"PRIx64"(%d): allowed=%d\n",
>> +                      addr, flag, mapping_value->flags);
> 
> (Btw, IIUC this may not be a guest error. Say, what if the device is
>  simply broken?)
> 
>> +        goto unlock;
>> +    }
>> +    entry.translated_addr = addr - mapping_key->low + mapping_value->phys_addr;
>> +    entry.perm = flag;
>> +    trace_virtio_iommu_translate_out(addr, entry.translated_addr, sid);
>> +
>> +unlock:
>> +    qemu_mutex_unlock(&s->mutex);
>>      return entry;
>>  }
>>  
>> -- 
>> 2.20.1
>>
> 
Thanks

Eric


