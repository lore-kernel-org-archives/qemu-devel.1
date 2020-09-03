Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0DDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1B82072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNbkCfLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1B82072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDgoc-0004nf-32
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 00:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kDgnv-0004OT-EB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 00:24:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kDgns-0005Us-Jn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 00:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599107091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrBkIfRRlZnM6NnydMVOGU2AkA/c9nxKxtV3yoepHXU=;
 b=BNbkCfLe/nnjRrplS7YBGzLyNmyoUNhzASXIVwpf2iFokpRylrctkuB6QN+VOSl5n3tJdR
 9HW/d1GJopK1EdJeHXp51WkcL0q0E30bCUS62eWCIKTZfrHDenQsAPi1ek6ExYti0LGJvG
 01SDVmswG0iYdFakj73PIm8g8KXoLZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-LzUdnA8VMAaJy_lnuCMRTw-1; Thu, 03 Sep 2020 00:24:49 -0400
X-MC-Unique: LzUdnA8VMAaJy_lnuCMRTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA2301074642;
 Thu,  3 Sep 2020 04:24:47 +0000 (UTC)
Received: from [10.72.13.109] (ovpn-13-109.pek2.redhat.com [10.72.13.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8749560C0F;
 Thu,  3 Sep 2020 04:24:38 +0000 (UTC)
Subject: Re: [RFC 0/3] try to solve the DMA to MMIO issue
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200902162206.101872-1-liq3ea@163.com>
 <b840aab8-542d-af43-43e5-0a07f442b5d5@redhat.com>
 <20200903040611.fjam4nwqopec723y@mozz.bu.edu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <801411e4-e847-6d79-fc54-7cdd692b9c43@redhat.com>
Date: Thu, 3 Sep 2020 12:24:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903040611.fjam4nwqopec723y@mozz.bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, dmitry.fleytman@gmail.com, mst@redhat.com,
 liq3ea@gmail.com, Li Qiang <liq3ea@163.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/3 下午12:06, Alexander Bulekov wrote:
> On 200903 1154, Jason Wang wrote:
>> On 2020/9/3 上午12:22, Li Qiang wrote:
>>> The qemu device fuzzer has found several DMA to MMIO issue.
>>> These issues is caused by the guest driver programs the DMA
>>> address, then in the device MMIO handler it trigger the DMA
>>> and as the DMA address is MMIO it will trigger another dispatch
>>> and reenter the MMIO handler again. However most of the device
>>> is not reentrant.
>>>
>>> DMA to MMIO will cause issues depend by the device emulator,
>>> mostly it will crash the qemu. Following is three classic
>>> DMA to MMIO issue.
>>>
>>> e1000e: https://bugs.launchpad.net/qemu/+bug/1886362
>>> xhci: https://bugs.launchpad.net/qemu/+bug/1891354
>>> virtio-gpu: https://bugs.launchpad.net/qemu/+bug/1888606
>>>
>>> The DMA to MMIO issue I think can be classified as following:
>>> 1. DMA to the device itself
>>> 2. device A DMA to device B and to device C
>>> 3. device A DMA to device B and to device A
>>>
>>> The first case of course should not be allowed.
>>> The second case I think it ok as the device IO handler has no
>>> assumption about the IO data came from no matter it come from
>>> device or other device. This is for P2P DMA.
>>> The third case I think it also should not be allowed.
>>>
>>> So our issue has been reduced by one case: not allowed the
>>> device's IO handler reenter.
>>>
>>> Paolo suggested that we can refactor the device emulation with
>>> BH. However it is a lot of work.
>>> I have thought several propose to address this, also discuss
>>> this with Jason Wang in private email.
>>>
>>> I have can solve this issue in core framework or in specific device.
>>> After try several methods I choose address it in per-device for
>>> following reason:
>>> 1. If we address it in core framwork we have to recored and check the
>>> device or MR info in MR dispatch write function. Unfortunally we have
>>> no these info in core framework.
>>> 2. The performance will also be decrease largely
>>> 3. Only the device itself know its IO
>>
>> I think we still need to seek a way to address this issue completely.
>>
>> How about adding a flag in MemoryRegionOps and detect the reentrancy through
>> that flag?
> What happens for devices with multiple MemoryRegions? Make all the
> MemoryRegionOps share the same flag?


I think there could be two approaches:

1) record the device in MR as Qiang mentioned
2) Only forbid the reentrancy in MMIO handler and depends on the device 
to solve the multiple Memory Region issue, if the regions want to access 
the same data, it needs to be synchronized internally

But the point is still to try to solve it in the layer of memory 
regions. Otherwise we may still hit similar issues.


>
> What about the virtio-gpu bug, where the problem happens in a bh->mmio
> access rather than an mmio->mmio access?


Yes, it needs more thought, but as a first step, we can try to fix the 
MMIO handler issue and do bh fix on top.

Thanks


>
> -Alex
>
>> Thanks
>>
>>
>>> The (most of the) device emulation is protected by BQL one time only
>>> a device emulation code can be run. We can add a flag to indicate the
>>> IO is running. The first two patches does this. For simplicity at the
>>> RFC stage I just set it while enter the IO callback and clear it exit
>>> the IO callback. It should be check/set/clean according the per-device's
>>> IO emulation.
>>> The second issue which itself suffers a race condition so I uses a
>>> atomic.
>>>
>>>
>>>
>>>
>>> Li Qiang (3):
>>>     e1000e: make the IO handler reentrant
>>>     xhci: make the IO handler reentrant
>>>     virtio-gpu: make the IO handler reentrant
>>>
>>>    hw/display/virtio-gpu.c        | 10 ++++++
>>>    hw/net/e1000e.c                | 35 +++++++++++++++++++-
>>>    hw/usb/hcd-xhci.c              | 60 ++++++++++++++++++++++++++++++++++
>>>    hw/usb/hcd-xhci.h              |  1 +
>>>    include/hw/virtio/virtio-gpu.h |  1 +
>>>    5 files changed, 106 insertions(+), 1 deletion(-)
>>>


