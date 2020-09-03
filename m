Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1260C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C31F20767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3cS5ofv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C31F20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDn5v-0006Yt-IG
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kDn4S-00048g-Qp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kDn4Q-0005bg-GO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FdU5gdh4xFvnFBywEfr90MIaoYD85nZvYnLyquklHQ=;
 b=Y3cS5ofv2b9tft2CfUX7OPA41tIWXtOrLuogfCDwyJh1sc3rhNth8BPoVmBVJfOaDkaIHG
 QVXu7g/GgaJNxPTO2vv2gXIjsgUhKZ+Pq4tGF0ddqrRivCqhAsYWW0SL1wai3vX2aUPRZB
 Fseoo1Cv8z6YxnwpRWQVJdThDoT7oH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-mGlZfL66NCSyJTLm6lMOsA-1; Thu, 03 Sep 2020 07:06:18 -0400
X-MC-Unique: mGlZfL66NCSyJTLm6lMOsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EEB3100670D;
 Thu,  3 Sep 2020 11:06:15 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 049BE60250;
 Thu,  3 Sep 2020 11:06:01 +0000 (UTC)
Subject: Re: [RFC v8 3/5] memory: Add IOMMU_DEVIOTLB_UNMAP
 IOMMUTLBNotificationType
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-4-eperezma@redhat.com>
 <58783cf8-ef7f-1481-8c5e-acd76a8b752f@redhat.com>
 <CAJaqyWeTruYQGz5CedQW3ogMNO_B77QFRYW-+M_e-pemjvoobg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <99c1436d-7701-e7d9-ec3a-c47566aa1ce2@redhat.com>
Date: Thu, 3 Sep 2020 13:06:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeTruYQGz5CedQW3ogMNO_B77QFRYW-+M_e-pemjvoobg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eugenio,
On 9/3/20 12:13 PM, Eugenio Perez Martin wrote:
> Hi Eric,
> 
> On Wed, Sep 2, 2020 at 12:32 PM Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Eugenio,
>>
>> On 9/1/20 4:26 PM, Eugenio Pérez wrote:
>>> Adapt intel and vhost to use this new notification type
>> I think you should explain in the commit message what is the benefice to
>> introduce this new event type.
> 
> Will do, thanks!
> 
>>>
>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>> ---
>>>  hw/i386/intel_iommu.c | 2 +-
>>>  hw/virtio/vhost.c     | 2 +-
>>>  include/exec/memory.h | 2 ++
>>>  3 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 0c4aef5cb5..cdddb089e7 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -2468,7 +2468,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
>>>          sz = VTD_PAGE_SIZE;
>>>      }
>>>
>>> -    event.type = IOMMU_NOTIFIER_UNMAP;
>>> +    event.type = IOMMU_NOTIFIER_DEVIOTLB;
>> If this is used only for device IOTLB cache invalidation, shouldn't this
>> be named IOMMU_NOTIFIER_DEVIOTLB_UNMAP to be consistent with the rest?
>>>      event.entry.target_as = &vtd_dev_as->as;
>>>      event.entry.addr_mask = sz - 1;
>>>      event.entry.iova = addr;
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index 1a1384e7a6..6ca168b47e 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -729,7 +729,7 @@ static void vhost_iommu_region_add(MemoryListener *listener,
>>>      iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
>>>                                                     MEMTXATTRS_UNSPECIFIED);
>>>      iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
>>> -                        IOMMU_NOTIFIER_UNMAP,
>>> +                        IOMMU_NOTIFIER_DEVIOTLB,
>>>                          section->offset_within_region,
>>>                          int128_get64(end),
>>>                          iommu_idx);
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index 8a56707169..215e23973d 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -87,6 +87,8 @@ typedef enum {
>>>      IOMMU_NOTIFIER_UNMAP = 0x1,
>>>      /* Notify entry changes (newly created entries) */
>>>      IOMMU_NOTIFIER_MAP = 0x2,
>>> +    /* Notify changes on device IOTLB entries */
>>> +    IOMMU_NOTIFIER_DEVIOTLB = 0x04,
>>>  } IOMMUNotifierFlag;
>>>
>>>  #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
>> shouldn't we rename this one??
>>>
>>
> 
> Agree, but I'm not sure about the right name. IOMMU_NOTIFIER_ALL_ROOT?
> IOMMU_NOTIFIER_ALL_REGULAR?
I would rather name it IOMMU_NOTIFIER_IOTLB_EVENTS versus
IOMMU_NOTIFIER_DEVIOTLB_EVENTS? This is the cache type that differs,
isn't it?

Thanks

Eric
> 
> Thanks!
> 
>> Thanks
>>
>> Eric
>>
> 
> 


