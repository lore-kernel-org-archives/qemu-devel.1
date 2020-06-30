Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE3DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF19206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiwVutjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF19206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBep-0005Hl-FR
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqBeA-0004dN-Cc
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:29:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50020
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqBe7-0005hw-RP
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593505778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WT/YFKnl15KcGvwJBWSa5CF8eXHhaqtaU6U18AT3ck=;
 b=SiwVutjXDaunVfic7YWIWwZTEGs4hKkrtJaSRd5iA74W+bWWjxBH7CzhdPjDKWhHC2Ad0F
 CE1c27VyemZhAjt6eZv6w4u1J3cGu6L47QqgENGaIQ5zmGoHQarItAFmdfdfF/FhileUml
 YRSCNwGAclc4AWOzT9gcth/2qmtX+sY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-BuYO0fnOP-yGxApj-SfFJA-1; Tue, 30 Jun 2020 04:29:36 -0400
X-MC-Unique: BuYO0fnOP-yGxApj-SfFJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55930805EF8;
 Tue, 30 Jun 2020 08:29:35 +0000 (UTC)
Received: from [10.72.13.159] (ovpn-13-159.pek2.redhat.com [10.72.13.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4F86E6F0;
 Tue, 30 Jun 2020 08:29:20 +0000 (UTC)
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
From: Jason Wang <jasowang@redhat.com>
To: Peter Xu <peterx@redhat.com>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200626064122.9252-2-eperezma@redhat.com> <20200626212917.GD175520@xz-x1>
 <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
 <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
Message-ID: <1b4eaaaf-c2ab-0da8-afb4-1b7b4221e6cf@redhat.com>
Date: Tue, 30 Jun 2020 16:29:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/30 上午10:41, Jason Wang wrote:
>
> On 2020/6/29 下午9:34, Peter Xu wrote:
>> On Mon, Jun 29, 2020 at 01:51:47PM +0800, Jason Wang wrote:
>>> On 2020/6/28 下午10:47, Peter Xu wrote:
>>>> On Sun, Jun 28, 2020 at 03:03:41PM +0800, Jason Wang wrote:
>>>>> On 2020/6/27 上午5:29, Peter Xu wrote:
>>>>>> Hi, Eugenio,
>>>>>>
>>>>>> (CCing Eric, Yan and Michael too)
>>>>>>
>>>>>> On Fri, Jun 26, 2020 at 08:41:22AM +0200, Eugenio Pérez wrote:
>>>>>>> diff --git a/memory.c b/memory.c
>>>>>>> index 2f15a4b250..7f789710d2 100644
>>>>>>> --- a/memory.c
>>>>>>> +++ b/memory.c
>>>>>>> @@ -1915,8 +1915,6 @@ void 
>>>>>>> memory_region_notify_one(IOMMUNotifier *notifier,
>>>>>>>             return;
>>>>>>>         }
>>>>>>> -    assert(entry->iova >= notifier->start && entry_end <= 
>>>>>>> notifier->end);
>>>>>> I can understand removing the assertion should solve the issue, 
>>>>>> however imho
>>>>>> the major issue is not about this single assertion but the whole 
>>>>>> addr_mask
>>>>>> issue behind with virtio...
>>>>> I don't get here, it looks to the the range was from guest IOMMU 
>>>>> drivers.
>>>> Yes.  Note that I didn't mean that it's a problem in virtio, it's 
>>>> just the fact
>>>> that virtio is the only one I know that would like to support 
>>>> arbitrary address
>>>> range for the translated region.  I don't know about tcg, but vfio 
>>>> should still
>>>> need some kind of page alignment in both the address and the 
>>>> addr_mask.  We
>>>> have that assumption too across the memory core when we do 
>>>> translations.
>>>
>>> Right but it looks to me the issue is not the alignment.
>>>
>>>
>>>> A further cause of the issue is the MSI region when vIOMMU enabled 
>>>> - currently
>>>> we implemented the interrupt region using another memory region so 
>>>> it split the
>>>> whole DMA region into two parts.  That's really a clean approach to IR
>>>> implementation, however that's also a burden to the invalidation 
>>>> part because
>>>> then we'll need to handle things like this when the listened range 
>>>> is not page
>>>> alighed at all (neither 0-0xfedffff, nor 0xfef0000-MAX).  If 
>>>> without the IR
>>>> region (so the whole iommu address range will be a single FlatRange),
>>>
>>> Is this a bug? I remember that at least for vtd, it won't do any 
>>> DMAR on the
>>> intrrupt address range
>> I don't think it's a bug, at least it's working as how I 
>> understand...  that
>> interrupt range is using an IR region, that's why I said the IR 
>> region splits
>> the DMAR region into two pieces, so we have two FlatRange for the same
>> IOMMUMemoryRegion.
>
>
> I don't check the qemu code but if "a single FlatRange" means 
> 0xFEEx_xxxx is subject to DMA remapping, OS need to setup passthrough 
> mapping for that range in order to get MSI to work. This is not what 
> vtd spec said:
>
> """
>
> 3.14 Handling Requests to Interrupt Address Range
>
> Requests without PASID to address range 0xFEEx_xxxx are treated as
> potential interrupt requests and are not subjected to DMA remapping
> (even if translation structures specify a mapping for this
> range). Instead, remapping hardware can be enabled to subject such
> interrupt requests to interrupt remapping.
>
> """
>
> My understanding is vtd won't do any DMA translation on 0xFEEx_xxxx 
> even if IR is not enabled.


Ok, we had a dedicated mr for interrupt:

memory_region_add_subregion_overlap(MEMORY_REGION(&vtd_dev_as->iommu),
VTD_INTERRUPT_ADDR_FIRST,
&vtd_dev_as->iommu_ir, 1);

So it should be fine. I guess the reason that I'm asking is that I 
thought "IR" means "Interrupt remapping" but in fact it means "Interrupt 
Region"?

But I'm still not clear about the invalidation part for interrupt 
region, maybe you can elaborate a little more on this.

Btw, I think guest can trigger the assert in vtd_do_iommu_translate() if 
we teach vhost to DMA to that region:

     /*
      * We have standalone memory region for interrupt addresses, we
      * should never receive translation requests in this region.
      */
     assert(!vtd_is_interrupt_addr(addr));

Is this better to return false here? (We can work on the fix for vhost 
but it should be not trivial)

Thanks



