Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65104C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB9520656
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBYMI7hF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB9520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jokNE-0004UM-CR
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jokMX-0003wc-IM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 05:09:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31833
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jokMU-0002Gu-Oc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 05:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593162569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDA6LRSP7pCh1A35I+F4goltEgJgs5w0V5KAOx84I8E=;
 b=DBYMI7hFIAd1U8CaUioN1vjbxh5iiDp2kOBcq8UGd04seTG9rJH8C8VPjYcyDDMTu+w7AF
 qVqYBbstphXAQI9ipf9r0dipFu7GJYHG3wpI2EGIRaVuFHTl+U5gPCB+qXLdWQypbYrOax
 U8nShb2WCcbMP7cdwHe5RHreLVIxQGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-8voNNJvGPkuy2ge4impFLA-1; Fri, 26 Jun 2020 05:09:27 -0400
X-MC-Unique: 8voNNJvGPkuy2ge4impFLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E605A1800D4A;
 Fri, 26 Jun 2020 09:09:25 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 322EA5C66E;
 Fri, 26 Jun 2020 09:09:16 +0000 (UTC)
Subject: Re: [PATCH v5 2/5] virtio-iommu: Implement RESV_MEM probe request
To: Markus Armbruster <armbru@redhat.com>
References: <20200624132625.27453-1-eric.auger@redhat.com>
 <20200624132625.27453-3-eric.auger@redhat.com>
 <87zh8r1v6z.fsf@dusky.pond.sub.org>
 <5cf11295-b762-9246-8b4b-9d5d1c83749a@redhat.com>
 <878sgaw6lb.fsf@dusky.pond.sub.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ae44520e-129a-82f8-c12c-992b0edb7ffd@redhat.com>
Date: Fri, 26 Jun 2020 11:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <878sgaw6lb.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
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
Cc: peter.maydell@linaro.org, jean-philippe@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, qemu-arm@nongnu.org,
 pbonzini@redhat.com, bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus

On 6/26/20 10:53 AM, Markus Armbruster wrote:
> Auger Eric <eric.auger@redhat.com> writes:
> 
>> Hi Markus,
>> On 6/25/20 9:05 AM, Markus Armbruster wrote:
>>> Eric Auger <eric.auger@redhat.com> writes:
>>>
>>>> This patch implements the PROBE request. At the moment,
>>>> only THE RESV_MEM property is handled. The first goal is
>>>> to report iommu wide reserved regions such as the MSI regions
>>>> set by the machine code. On x86 this will be the IOAPIC MSI
>>>> region, [0xFEE00000 - 0xFEEFFFFF], on ARM this may be the ITS
>>>> doorbell.
>>>>
>>>> In the future we may introduce per device reserved regions.
>>>> This will be useful when protecting host assigned devices
>>>> which may expose their own reserved regions
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>
>>>> ---
>>>>
>>>> v4 -> v5:
>>>> - assert if reserved region type is different from RESERVED or
>>>>   MSI
>>>>
>>>> v3 -> v4:
>>>> - removed any reference to the NONE property that does not
>>>>   exist anymore.
>>>>
>>>> v2 -> v3:
>>>> - on probe, do not fill the reminder of the buffer with zeroes
>>>>   as the buffer was already zero initialized (Bharat)
>>>>
>>>> v1 -> v2:
>>>> - move the unlock back to the same place
>>>> - remove the push label and factorize the code after the out label
>>>> - fix a bunch of cpu_to_leX according to the latest spec revision
>>>> - do not remove sizeof(last) from free space
>>>> - check the ep exists
>>>> ---
>>>>  include/hw/virtio/virtio-iommu.h |  2 +
>>>>  hw/virtio/virtio-iommu.c         | 92 ++++++++++++++++++++++++++++++--
>>>>  hw/virtio/trace-events           |  1 +
>>>>  3 files changed, 91 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>>>> index e653004d7c..49eb105cd8 100644
>>>> --- a/include/hw/virtio/virtio-iommu.h
>>>> +++ b/include/hw/virtio/virtio-iommu.h
>>>> @@ -53,6 +53,8 @@ typedef struct VirtIOIOMMU {
>>>>      GHashTable *as_by_busptr;
>>>>      IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>>>>      PCIBus *primary_bus;
>>>> +    ReservedRegion *reserved_regions;
>>>> +    uint32_t nb_reserved_regions;
>>>>      GTree *domains;
>>>>      QemuMutex mutex;
>>>>      GTree *endpoints;
>>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>>> index 483883ec1d..aabc3e36b1 100644
>>>> --- a/hw/virtio/virtio-iommu.c
>>>> +++ b/hw/virtio/virtio-iommu.c
>>>> @@ -38,6 +38,7 @@
>>>>  
>>>>  /* Max size */
>>>>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>>>> +#define VIOMMU_PROBE_SIZE 512
>>>>  
>>>>  typedef struct VirtIOIOMMUDomain {
>>>>      uint32_t id;
>>>> @@ -378,6 +379,63 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>>>      return ret;
>>>>  }
>>>>  
>>>> +static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
>>>> +                                               uint8_t *buf, size_t free)
>>>> +{
>>>> +    struct virtio_iommu_probe_resv_mem prop = {};
>>>> +    size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
>>>> +    int i;
>>>> +
>>>> +    total = size * s->nb_reserved_regions;
>>>> +
>>>> +    if (total > free) {
>>>> +        return -ENOSPC;
>>>> +    }
>>>> +
>>>> +    for (i = 0; i < s->nb_reserved_regions; i++) {
>>>> +        prop.head.type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM);
>>>> +        prop.head.length = cpu_to_le16(length);
>>>> +        prop.subtype = s->reserved_regions[i].type;
>>>> +        assert(prop.subtype == VIRTIO_IOMMU_RESV_MEM_T_RESERVED ||
>>>> +               prop.subtype == VIRTIO_IOMMU_RESV_MEM_T_MSI);
>>>
>>> The assertion makes sense here: we're mapping from the generic
>>> ReservedRegion type (which is unsigned) to the specific
>>> virtio_iommu_probe_resv_mem subtype (which is uint8_t, but only these
>>> two values are valid).
>>>
>>> Howver, the assertion should test s->reserved_regions[i].type and go
>>> before the assignment, to ensure it doesn't truncate!
>> OK I will do.
>>>
>>> Can I trigger the assertion with -device?  My try to find the answer
>>> myself failed:
>> At the moment the virtio-iommu-pci device only can be instantiated with
>> machvirt, booting in dt mode.
> 
> I asked because if I can, then invalid types need to be rejected
> cleanly.
> 
> Invalid property values can be rejected by the setter, or by the realize
> method.  Since this setter by design accepts anything that fits into
> unsigned, it's realize.

OK. Then the place where I do the assert is not the right one as this
will happen later. Probe request is triggered by the guest virtio-iommu
driver.

Thanks

Eric
> 
> [...]
> 


