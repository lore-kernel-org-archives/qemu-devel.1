Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895B7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DE620772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6cQw/Vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DE620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqbta-00083s-Ke
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqbsg-0007Un-Ik
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:30:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqbse-0000Pu-RV
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593606624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOcgnWQHUQDGK0rZwLTPvOJ3kRPTP7TeppcymXHtxXI=;
 b=b6cQw/VtIJrcUP+Slr04+iSYpWhVx2+l4hrD2csKPWNVACJ/0KdUqaopeR0ik+xdnDyOTx
 jZ7MOSbnIc8/QIQ4yDVEO8VilfXj6jrh5jyDnycJETTDJ8LgO/GmMDpD55LffHOUOQxQKs
 EuNv7VHf648AVDi7kbvkRF1GdfthjlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-Nwy9wFRDOUGwJzwWDVSplg-1; Wed, 01 Jul 2020 08:30:22 -0400
X-MC-Unique: Nwy9wFRDOUGwJzwWDVSplg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF9FAA0C01;
 Wed,  1 Jul 2020 12:30:21 +0000 (UTC)
Received: from [10.72.13.177] (ovpn-13-177.pek2.redhat.com [10.72.13.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3F9D5C1C5;
 Wed,  1 Jul 2020 12:30:08 +0000 (UTC)
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>
References: <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
 <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <1b4eaaaf-c2ab-0da8-afb4-1b7b4221e6cf@redhat.com>
 <20200630052148-mutt-send-email-mst@kernel.org>
 <49f547e1-dd87-7abe-1075-9dcece75b641@redhat.com>
 <20200630152050.GC3138@xz-x1>
 <d9dd8662-33e3-03fe-f227-f519858534e0@redhat.com>
 <20200701121626.GD40675@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f4d031fc-6951-be63-991c-c5689274dbf1@redhat.com>
Date: Wed, 1 Jul 2020 20:30:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701121626.GD40675@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
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
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/1 下午8:16, Peter Xu wrote:
> On Wed, Jul 01, 2020 at 04:11:49PM +0800, Jason Wang wrote:
>> On 2020/6/30 下午11:20, Peter Xu wrote:
>>> On Tue, Jun 30, 2020 at 05:23:31PM +0800, Jason Wang wrote:
>>>>>> Ok, we had a dedicated mr for interrupt:
>>>>>>
>>>>>> memory_region_add_subregion_overlap(MEMORY_REGION(&vtd_dev_as->iommu),
>>>>>> VTD_INTERRUPT_ADDR_FIRST,
>>>>>> &vtd_dev_as->iommu_ir, 1);
>>>>>>
>>>>>> So it should be fine. I guess the reason that I'm asking is that I thought
>>>>>> "IR" means "Interrupt remapping" but in fact it means "Interrupt Region"?
>>> I was meaning "interrupt remapping", and of course it's the interrupt region
>>> too when IR enabled...
>>
>> Right.
>>
>>
>>>>>> But I'm still not clear about the invalidation part for interrupt region,
>>>>>> maybe you can elaborate a little more on this.
>>>>>>
>>>>>> Btw, I think guest can trigger the assert in vtd_do_iommu_translate() if we
>>>>>> teach vhost to DMA to that region:
>>>>> Why would we want to?
>>>> I meant a buggy(malicious) guest driver.
>>> Yes seems possible.  Do you want to post a patch?  Let me know if you want me
>>> to...  Thanks,
>>
>> Yes please.
> Oh wait...  Actually the comment above explains...
>
>      /*
>       * We have standalone memory region for interrupt addresses, we
>       * should never receive translation requests in this region.
>       */
>      assert(!vtd_is_interrupt_addr(addr));
>
> I overlooked myself that the IR region will be there even if ir=off.


Yes, but the point stands still but the issue is still if ir=off.


>    So I
> think the assert should stand.


Do you mean vhost can't trigger the assert()? If yes, I don't get how it 
can't.

Thanks


>


