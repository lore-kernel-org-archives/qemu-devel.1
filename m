Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBD9C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C12C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oc97rTGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C12C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDkKn-0002JB-Dz
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 03:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jDkFI-0000di-EU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jDkFG-0005lw-PT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:33:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jDkFG-0005bW-Gn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584343986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+61qPTf5vwQgvoFdP/S2rqcE0YL1D5c8EAzWuQ9S9o=;
 b=Oc97rTGxGDKKtPgU8rZcSsgdq6aKWszsSNRvpDuAwR89xN9hT9SPtILM0H68LlBKTz2n0s
 bmOZ3C49E5UKCioFCkUdzJp9cHZPSNt6jOsp2IUFmI/chfor+BP2sBoggA/0IWVbykEAWO
 GA6DU9Pz7cMf+PCuKJi2DBfzJkysKaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-SbWYjq-MPmKX_GRjVo3fpw-1; Mon, 16 Mar 2020 03:33:04 -0400
X-MC-Unique: SbWYjq-MPmKX_GRjVo3fpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B8A6801E53;
 Mon, 16 Mar 2020 07:33:02 +0000 (UTC)
Received: from [10.36.118.12] (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C62A8FC1E;
 Mon, 16 Mar 2020 07:32:49 +0000 (UTC)
Subject: Re: [PATCH v7 2/5] virtio-iommu: Add iommu notifier for map/unmap
To: Bharat Bhushan <bharatb.linux@gmail.com>
References: <20200313074811.27175-1-bbhushan2@marvell.com>
 <20200313074811.27175-3-bbhushan2@marvell.com>
 <369b162f-3a0c-6861-0737-96aa8914b915@redhat.com>
 <CAAeCc_mEoFLUux6mScyCbA_9n9eJf7Tt9tGrGOG-ENN5Kmr_7A@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f42d9697-22f2-0919-352f-54127a97e16d@redhat.com>
Date: Mon, 16 Mar 2020 08:32:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAAeCc_mEoFLUux6mScyCbA_9n9eJf7Tt9tGrGOG-ENN5Kmr_7A@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 3/16/20 7:36 AM, Bharat Bhushan wrote:
> Hi Eric,
> 
> On Fri, Mar 13, 2020 at 7:55 PM Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Bharat,
>> On 3/13/20 8:48 AM, Bharat Bhushan wrote:
>>> This patch extends VIRTIO_IOMMU_T_MAP/UNMAP request to
>>> notify registered iommu-notifier. Which will call vfio
>> s/iommu-notifier/iommu-notifiers
>>> notifier to map/unmap region in iommu.
>> can be any notifier (vhost/vfio).
>>>
>>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>  hw/virtio/trace-events           |  2 +
>>>  hw/virtio/virtio-iommu.c         | 66 +++++++++++++++++++++++++++++++-
>>>  include/hw/virtio/virtio-iommu.h |  6 +++
>>>  3 files changed, 73 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>>> index e83500bee9..d94a1cd8a3 100644
>>> --- a/hw/virtio/trace-events
>>> +++ b/hw/virtio/trace-events
>>> @@ -73,3 +73,5 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
>>>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>>>  virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
>>>  virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
>>> +virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t paddr, uint64_t map_size) "mr=%s iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64
>>> +virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map_size) "mr=%s iova=0x%"PRIx64" size=0x%"PRIx64
>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>> index 4cee8083bc..e51344a53e 100644
>>> --- a/hw/virtio/virtio-iommu.c
>>> +++ b/hw/virtio/virtio-iommu.c
>>> @@ -123,6 +123,38 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>>>      }
>>>  }
>>>
>>> +static void virtio_iommu_notify_map(IOMMUMemoryRegion *mr, hwaddr iova,
>>> +                                    hwaddr paddr, hwaddr size)
>>> +{
>>> +    IOMMUTLBEntry entry;
>>> +
>>> +    entry.target_as = &address_space_memory;
>>> +    entry.addr_mask = size - 1;
>>> +
>>> +    entry.iova = iova;
>>> +    trace_virtio_iommu_notify_map(mr->parent_obj.name, iova, paddr, size);
>>> +    entry.perm = IOMMU_RW;
>>> +    entry.translated_addr = paddr;
>>> +
>>> +    memory_region_notify_iommu(mr, 0, entry);
>>> +}
>>> +
>>> +static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
>>> +                                      hwaddr size)
>>> +{
>>> +    IOMMUTLBEntry entry;
>>> +
>>> +    entry.target_as = &address_space_memory;
>>> +    entry.addr_mask = size - 1;
>>> +
>>> +    entry.iova = iova;
>>> +    trace_virtio_iommu_notify_unmap(mr->parent_obj.name, iova, size);
>>> +    entry.perm = IOMMU_NONE;
>>> +    entry.translated_addr = 0;
>>> +
>>> +    memory_region_notify_iommu(mr, 0, entry);
>>> +}
>>> +
>>>  static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
>>>  {
>>>      if (!ep->domain) {
>>> @@ -307,9 +339,12 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>>>      uint64_t virt_start = le64_to_cpu(req->virt_start);
>>>      uint64_t virt_end = le64_to_cpu(req->virt_end);
>>>      uint32_t flags = le32_to_cpu(req->flags);
>>> +    hwaddr size = virt_end - virt_start + 1;
>>> +    VirtioIOMMUNotifierNode *node;
>>>      VirtIOIOMMUDomain *domain;
>>>      VirtIOIOMMUInterval *interval;
>>>      VirtIOIOMMUMapping *mapping;
>>> +    VirtIOIOMMUEndpoint *ep;
>>>
>>>      if (flags & ~VIRTIO_IOMMU_MAP_F_MASK) {
>>>          return VIRTIO_IOMMU_S_INVAL;
>>> @@ -339,9 +374,37 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>>>
>>>      g_tree_insert(domain->mappings, interval, mapping);
>>>
>>> +    /* All devices in an address-space share mapping */
>>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
>>> +        QLIST_FOREACH(ep, &domain->endpoint_list, next) {
>>> +            if (ep->id == node->iommu_dev->devfn) {
>>> +                virtio_iommu_notify_map(&node->iommu_dev->iommu_mr,
>>> +                                        virt_start, phys_start, size);
>>> +            }
>>> +        }
>>> +    }
>>> +
>>>      return VIRTIO_IOMMU_S_OK;
>>>  }
>>>
>>> +static void virtio_iommu_remove_mapping(VirtIOIOMMU *s, VirtIOIOMMUDomain *domain,
>>> +                                        VirtIOIOMMUInterval *interval)
>>> +{
>>> +    VirtioIOMMUNotifierNode *node;
>>> +    VirtIOIOMMUEndpoint *ep;
>>> +
>>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
>>> +        QLIST_FOREACH(ep, &domain->endpoint_list, next) {
>>> +            if (ep->id == node->iommu_dev->devfn) {
>>> +                virtio_iommu_notify_unmap(&node->iommu_dev->iommu_mr,
>>> +                                          interval->low,
>>> +                                          interval->high - interval->low + 1);
>>> +            }
>>> +        }
>>> +    }
>>> +    g_tree_remove(domain->mappings, (gpointer)(interval));
>>> +}
>> What about virtio_iommu_put_domain() where you destroy the mapping
>> gtree. I guess you also need to send invalidations there?
> 
> In virtio_iommu_put_domain(), before destroying domain->mappings we
> are calling virtio_iommu_detach_endpoint_from_domain(), which send
> invalidations, no ?
Yes I noticed that later as it is in patch 3/5 (this is the comment you
did not get)
> 
>>> +
>>>  static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>>                                struct virtio_iommu_req_unmap *req)
>>>  {
>>> @@ -368,7 +431,7 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>>          uint64_t current_high = iter_key->high;
>>>
>>>          if (interval.low <= current_low && interval.high >= current_high) {
>>> -            g_tree_remove(domain->mappings, iter_key);
>>> +            virtio_iommu_remove_mapping(s, domain, iter_key);
>>>              trace_virtio_iommu_unmap_done(domain_id, current_low, current_high);
>>>          } else {
>>>              ret = VIRTIO_IOMMU_S_RANGE;
>>> @@ -655,6 +718,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>      VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
>>>
>>> +    QLIST_INIT(&s->notifiers_list);
>>>      virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
>>>                  sizeof(struct virtio_iommu_config));
>>>
>>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>>> index 6f67f1020a..4539c8ae72 100644
>>> --- a/include/hw/virtio/virtio-iommu.h
>>> +++ b/include/hw/virtio/virtio-iommu.h
>>> @@ -44,6 +44,11 @@ typedef struct IOMMUPciBus {
>>>      IOMMUDevice  *pbdev[0]; /* Parent array is sparse, so dynamically alloc */
>>>  } IOMMUPciBus;
>>>
>>> +typedef struct VirtioIOMMUNotifierNode {
>>> +    IOMMUDevice *iommu_dev;
>>> +    QLIST_ENTRY(VirtioIOMMUNotifierNode) next;
>>> +} VirtioIOMMUNotifierNode;
>> You may use scripts/git.orderfile for a better diff ordering.
> 
> ok, run "git config diff.orderFile scripts/git.orderfile"
> 
>>> +
>>>  typedef struct VirtIOIOMMU {
>>>      VirtIODevice parent_obj;
>>>      VirtQueue *req_vq;
>>> @@ -56,6 +61,7 @@ typedef struct VirtIOIOMMU {
>>>      GTree *domains;
>>>      QemuMutex mutex;
>>>      GTree *endpoints;
>>> +    QLIST_HEAD(, VirtioIOMMUNotifierNode) notifiers_list;
>> See what was done in smmuv3 and intel. We now directly use a list of
>> IOMMUDevice directly. VirtioIOMMUNotifierNode does not bring anything extra.
> 
> ok,
> 
> Thanks
> -Bharat
> 
>>>  } VirtIOIOMMU;
>>>
>>>  #endif
>>>
>>
>> Thanks
>>
>> Eric
>>
> 


