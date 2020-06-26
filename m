Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8ADC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A1920C09
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2rUPWsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A1920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jok8P-00071R-1u
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 04:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jok7i-0006a2-Gc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 04:54:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50716
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jok7g-00011L-7k
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 04:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593161650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTpWvBCKu8Qg6Ct0C2kD/5C/MiqsERUJ3ec+f60MM1s=;
 b=G2rUPWsIA6hoMlZAfhjw2v1V67mTz09+6p2Nm4iijs7lO6vaxTup7RUn3qhtIKTP2p9Uwt
 +jW+8RsdJZv6F+1nqVZGmgyqo2v4DDRA0YURhINPs2QnDHOKrmFzlH5zUKyAtpKUc+Imso
 7M3biNAXaU4ZIqFUSKYM7k45/qWTutw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-xeeG4C_LNXa6WKPV8k3ZQw-1; Fri, 26 Jun 2020 04:54:03 -0400
X-MC-Unique: xeeG4C_LNXa6WKPV8k3ZQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81C9C87951A;
 Fri, 26 Jun 2020 08:54:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0EE75D9D3;
 Fri, 26 Jun 2020 08:53:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6346111384D4; Fri, 26 Jun 2020 10:53:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v5 2/5] virtio-iommu: Implement RESV_MEM probe request
References: <20200624132625.27453-1-eric.auger@redhat.com>
 <20200624132625.27453-3-eric.auger@redhat.com>
 <87zh8r1v6z.fsf@dusky.pond.sub.org>
 <5cf11295-b762-9246-8b4b-9d5d1c83749a@redhat.com>
Date: Fri, 26 Jun 2020 10:53:52 +0200
In-Reply-To: <5cf11295-b762-9246-8b4b-9d5d1c83749a@redhat.com> (Auger Eric's
 message of "Fri, 26 Jun 2020 09:41:37 +0200")
Message-ID: <878sgaw6lb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
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

Auger Eric <eric.auger@redhat.com> writes:

> Hi Markus,
> On 6/25/20 9:05 AM, Markus Armbruster wrote:
>> Eric Auger <eric.auger@redhat.com> writes:
>> 
>>> This patch implements the PROBE request. At the moment,
>>> only THE RESV_MEM property is handled. The first goal is
>>> to report iommu wide reserved regions such as the MSI regions
>>> set by the machine code. On x86 this will be the IOAPIC MSI
>>> region, [0xFEE00000 - 0xFEEFFFFF], on ARM this may be the ITS
>>> doorbell.
>>>
>>> In the future we may introduce per device reserved regions.
>>> This will be useful when protecting host assigned devices
>>> which may expose their own reserved regions
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>
>>> ---
>>>
>>> v4 -> v5:
>>> - assert if reserved region type is different from RESERVED or
>>>   MSI
>>>
>>> v3 -> v4:
>>> - removed any reference to the NONE property that does not
>>>   exist anymore.
>>>
>>> v2 -> v3:
>>> - on probe, do not fill the reminder of the buffer with zeroes
>>>   as the buffer was already zero initialized (Bharat)
>>>
>>> v1 -> v2:
>>> - move the unlock back to the same place
>>> - remove the push label and factorize the code after the out label
>>> - fix a bunch of cpu_to_leX according to the latest spec revision
>>> - do not remove sizeof(last) from free space
>>> - check the ep exists
>>> ---
>>>  include/hw/virtio/virtio-iommu.h |  2 +
>>>  hw/virtio/virtio-iommu.c         | 92 ++++++++++++++++++++++++++++++--
>>>  hw/virtio/trace-events           |  1 +
>>>  3 files changed, 91 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>>> index e653004d7c..49eb105cd8 100644
>>> --- a/include/hw/virtio/virtio-iommu.h
>>> +++ b/include/hw/virtio/virtio-iommu.h
>>> @@ -53,6 +53,8 @@ typedef struct VirtIOIOMMU {
>>>      GHashTable *as_by_busptr;
>>>      IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>>>      PCIBus *primary_bus;
>>> +    ReservedRegion *reserved_regions;
>>> +    uint32_t nb_reserved_regions;
>>>      GTree *domains;
>>>      QemuMutex mutex;
>>>      GTree *endpoints;
>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>> index 483883ec1d..aabc3e36b1 100644
>>> --- a/hw/virtio/virtio-iommu.c
>>> +++ b/hw/virtio/virtio-iommu.c
>>> @@ -38,6 +38,7 @@
>>>  
>>>  /* Max size */
>>>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>>> +#define VIOMMU_PROBE_SIZE 512
>>>  
>>>  typedef struct VirtIOIOMMUDomain {
>>>      uint32_t id;
>>> @@ -378,6 +379,63 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>>      return ret;
>>>  }
>>>  
>>> +static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
>>> +                                               uint8_t *buf, size_t free)
>>> +{
>>> +    struct virtio_iommu_probe_resv_mem prop = {};
>>> +    size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
>>> +    int i;
>>> +
>>> +    total = size * s->nb_reserved_regions;
>>> +
>>> +    if (total > free) {
>>> +        return -ENOSPC;
>>> +    }
>>> +
>>> +    for (i = 0; i < s->nb_reserved_regions; i++) {
>>> +        prop.head.type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM);
>>> +        prop.head.length = cpu_to_le16(length);
>>> +        prop.subtype = s->reserved_regions[i].type;
>>> +        assert(prop.subtype == VIRTIO_IOMMU_RESV_MEM_T_RESERVED ||
>>> +               prop.subtype == VIRTIO_IOMMU_RESV_MEM_T_MSI);
>> 
>> The assertion makes sense here: we're mapping from the generic
>> ReservedRegion type (which is unsigned) to the specific
>> virtio_iommu_probe_resv_mem subtype (which is uint8_t, but only these
>> two values are valid).
>> 
>> Howver, the assertion should test s->reserved_regions[i].type and go
>> before the assignment, to ensure it doesn't truncate!
> OK I will do.
>> 
>> Can I trigger the assertion with -device?  My try to find the answer
>> myself failed:
> At the moment the virtio-iommu-pci device only can be instantiated with
> machvirt, booting in dt mode.

I asked because if I can, then invalid types need to be rejected
cleanly.

Invalid property values can be rejected by the setter, or by the realize
method.  Since this setter by design accepts anything that fits into
unsigned, it's realize.

[...]


