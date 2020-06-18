Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABCEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158A8214DB
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZzXPpLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158A8214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlqUo-0006EJ-8a
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 05:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlqTv-0005bw-FA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 05:05:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33714
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlqTt-0006zS-92
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 05:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592471108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TA+Pi6x2Y5G0LjckQ7kl/TakRYfJm/kexyjaiB08cHI=;
 b=MZzXPpLlXMnFDqrfZ7bFEQUPXkhy4uDXHTgzUCRT4N9Wo4t++evgDMbcOXCbM+CU83za0r
 stGSkR4nGKEkwmYGbnMbHUGRop6xphtK+0U6pv4vH7XPqcmGz7Yy5Y9TCujOfUW5eT2aIW
 80L8SnksGsH2xgUXZTRstue281bNqA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-opbirGvVNZKqjneA2VWxMQ-1; Thu, 18 Jun 2020 05:05:06 -0400
X-MC-Unique: opbirGvVNZKqjneA2VWxMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 940A18035C2;
 Thu, 18 Jun 2020 09:05:04 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95F457BA1A;
 Thu, 18 Jun 2020 09:04:55 +0000 (UTC)
Subject: Re: [PATCH v3 2/5] virtio-iommu: Implement RESV_MEM probe request
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200611151209.22547-1-eric.auger@redhat.com>
 <20200611151209.22547-3-eric.auger@redhat.com>
 <20200617091613.GA871763@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3dfa575c-2c65-a405-4548-b33d13dce353@redhat.com>
Date: Thu, 18 Jun 2020 11:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200617091613.GA871763@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean-Philippe,

On 6/17/20 11:16 AM, Jean-Philippe Brucker wrote:
> On Thu, Jun 11, 2020 at 05:12:06PM +0200, Eric Auger wrote:
>> This patch implements the PROBE request. At the moment,
>> only THE RESV_MEM property is handled. The first goal is
>> to report iommu wide reserved regions such as the MSI regions
>> set by the machine code. On x86 this will be the IOAPIC MSI
>> region, [0xFEE00000 - 0xFEEFFFFF], on ARM this may be the ITS
>> doorbell.
>>
>> In the future we may introduce per device reserved regions.
>> This will be useful when protecting host assigned devices
>> which may expose their own reserved regions
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> Looks good to me apart from one comment inconsistency (below)
noted
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Thanks!

Eric
> 
>>
>> ---
>>
>> v2 -> v3:
>> - on probe, do not fill the reminder of the buffer with zeroes
>>   as the buffer was already zero initialized (Bharat)
>>
>> v1 -> v2:
>> - move the unlock back to the same place
>> - remove the push label and factorize the code after the out label
>> - fix a bunch of cpu_to_leX according to the latest spec revision
>> - do not remove sizeof(last) from free space
>> - check the ep exists
>> ---
>>  include/hw/virtio/virtio-iommu.h |  2 +
>>  hw/virtio/virtio-iommu.c         | 91 ++++++++++++++++++++++++++++++--
>>  hw/virtio/trace-events           |  1 +
>>  3 files changed, 90 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>> index e653004d7c..49eb105cd8 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -53,6 +53,8 @@ typedef struct VirtIOIOMMU {
>>      GHashTable *as_by_busptr;
>>      IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>>      PCIBus *primary_bus;
>> +    ReservedRegion *reserved_regions;
>> +    uint32_t nb_reserved_regions;
>>      GTree *domains;
>>      QemuMutex mutex;
>>      GTree *endpoints;
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 483883ec1d..be1527c1d6 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -38,6 +38,7 @@
>>  
>>  /* Max size */
>>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>> +#define VIOMMU_PROBE_SIZE 512
>>  
>>  typedef struct VirtIOIOMMUDomain {
>>      uint32_t id;
>> @@ -378,6 +379,62 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>      return ret;
>>  }
>>  
>> +static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
>> +                                               uint8_t *buf, size_t free)
>> +{
>> +    struct virtio_iommu_probe_resv_mem prop = {};
>> +    size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
>> +    int i;
>> +
>> +    total = size * s->nb_reserved_regions;
>> +
>> +    if (total > free) {
>> +        return -ENOSPC;
>> +    }
>> +
>> +    for (i = 0; i < s->nb_reserved_regions; i++) {
>> +        prop.head.type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM);
>> +        prop.head.length = cpu_to_le16(length);
>> +        prop.subtype = s->reserved_regions[i].type;
>> +        prop.start = cpu_to_le64(s->reserved_regions[i].low);
>> +        prop.end = cpu_to_le64(s->reserved_regions[i].high);
>> +
>> +        memcpy(buf, &prop, size);
>> +
>> +        trace_virtio_iommu_fill_resv_property(ep, prop.subtype,
>> +                                              prop.start, prop.end);
>> +        buf += size;
>> +    }
>> +    return total;
>> +}
>> +
>> +/**
>> + * virtio_iommu_probe - Fill the probe request buffer with
>> + * the properties the device is able to return and add a NONE
>> + * property at the end.
> 
> The NONE property doesn't exist anymore
> 
>> + */
>> +static int virtio_iommu_probe(VirtIOIOMMU *s,
>> +                              struct virtio_iommu_req_probe *req,
>> +                              uint8_t *buf)
>> +{
>> +    uint32_t ep_id = le32_to_cpu(req->endpoint);
>> +    size_t free = VIOMMU_PROBE_SIZE;
>> +    ssize_t count;
>> +
>> +    if (!virtio_iommu_mr(s, ep_id)) {
>> +        return VIRTIO_IOMMU_S_NOENT;
>> +    }
>> +
>> +    count = virtio_iommu_fill_resv_mem_prop(s, ep_id, buf, free);
>> +    if (count < 0) {
>> +        return VIRTIO_IOMMU_S_INVAL;
>> +    }
>> +    buf += count;
>> +    free -= count;
> 
> Nit: could be removed since we only support one property at the moment.
> 
>> +
>> +    return VIRTIO_IOMMU_S_OK;
>> +}
>> +
>>  static int virtio_iommu_iov_to_req(struct iovec *iov,
>>                                     unsigned int iov_cnt,
>>                                     void *req, size_t req_sz)
>> @@ -407,15 +464,27 @@ virtio_iommu_handle_req(detach)
>>  virtio_iommu_handle_req(map)
>>  virtio_iommu_handle_req(unmap)
>>  
>> +static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
>> +                                     struct iovec *iov,
>> +                                     unsigned int iov_cnt,
>> +                                     uint8_t *buf)
>> +{
>> +    struct virtio_iommu_req_probe req;
>> +    int ret = virtio_iommu_iov_to_req(iov, iov_cnt, &req, sizeof(req));
>> +
>> +    return ret ? ret : virtio_iommu_probe(s, &req, buf);
>> +}
>> +
>>  static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>>  {
>>      VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
>>      struct virtio_iommu_req_head head;
>>      struct virtio_iommu_req_tail tail = {};
>> +    size_t output_size = sizeof(tail), sz;
>>      VirtQueueElement *elem;
>>      unsigned int iov_cnt;
>>      struct iovec *iov;
>> -    size_t sz;
>> +    void *buf = NULL;
>>  
>>      for (;;) {
>>          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>> @@ -452,6 +521,17 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>>          case VIRTIO_IOMMU_T_UNMAP:
>>              tail.status = virtio_iommu_handle_unmap(s, iov, iov_cnt);
>>              break;
>> +        case VIRTIO_IOMMU_T_PROBE:
>> +        {
>> +            struct virtio_iommu_req_tail *ptail;
>> +
>> +            output_size = s->config.probe_size + sizeof(tail);
>> +            buf = g_malloc0(output_size);
>> +
>> +            ptail = (struct virtio_iommu_req_tail *)
>> +                        (buf + s->config.probe_size);
>> +            ptail->status = virtio_iommu_handle_probe(s, iov, iov_cnt, buf);
>> +        }
>>          default:
>>              tail.status = VIRTIO_IOMMU_S_UNSUPP;
>>          }
>> @@ -459,12 +539,13 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>>  
>>  out:
>>          sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>> -                          &tail, sizeof(tail));
>> -        assert(sz == sizeof(tail));
>> +                          buf ? buf : &tail, output_size);
>> +        assert(sz == output_size);
>>  
>> -        virtqueue_push(vq, elem, sizeof(tail));
>> +        virtqueue_push(vq, elem, sz);
>>          virtio_notify(vdev, vq);
>>          g_free(elem);
>> +        g_free(buf);
>>      }
>>  }
>>  
>> @@ -667,6 +748,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>      s->config.page_size_mask = TARGET_PAGE_MASK;
>>      s->config.input_range.end = -1UL;
>>      s->config.domain_range.end = 32;
>> +    s->config.probe_size = VIOMMU_PROBE_SIZE;
>>  
>>      virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
>>      virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
>> @@ -676,6 +758,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
>> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
>>  
>>      qemu_mutex_init(&s->mutex);
>>  
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index 6427a0047d..23109f69bb 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -74,3 +74,4 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
>>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>>  virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
>>  virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
>> +virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start, uint64_t end) "dev= %d, type=%d start=0x%"PRIx64" end=0x%"PRIx64
>> -- 
>> 2.20.1
>>
> 


