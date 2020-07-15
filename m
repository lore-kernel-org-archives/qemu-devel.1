Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C701CC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9636A2064C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YP2qpxUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9636A2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvcte-0007bZ-Qx
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 04:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvcsy-00073y-HR
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:35:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49480
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvcsw-0003gz-9v
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594802125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siW6dxLecboADCbmWSOl2mXENIDqESrv++45U2BjXYo=;
 b=YP2qpxUs9SO/1n6GihIzdDhJpEtgQngswivVuZXKRag3vCtP7N3JXneLR/FJURnO0pgo+C
 DYIAdaAQbDqBuvYOaArvVQm4X7T3OXQ2grLMreci/pj++coFaBX4WMN4jYxFESGFu0XeQk
 y18K2ZCHtlJdHsw2Yrm4r0iMTw0b6UM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-ZKjJClWzNPKP--hnDae67w-1; Wed, 15 Jul 2020 04:35:18 -0400
X-MC-Unique: ZKjJClWzNPKP--hnDae67w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16AC419200C0;
 Wed, 15 Jul 2020 08:35:17 +0000 (UTC)
Received: from [10.72.13.230] (ovpn-13-230.pek2.redhat.com [10.72.13.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF9D78541;
 Wed, 15 Jul 2020 08:35:11 +0000 (UTC)
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Li Qiang <liq3ea@gmail.com>
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
 <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
 <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
 <e4a34525-dbd1-1f85-475b-b5004885215b@redhat.com>
 <CAKXe6SJb=1YLLGF+TP1fMd95k_WzZd73JeUJv5Sn4EE4m2zP4w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f19f605c-9468-e7eb-f255-60766df2a50c@redhat.com>
Date: Wed, 15 Jul 2020 16:35:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJb=1YLLGF+TP1fMd95k_WzZd73JeUJv5Sn4EE4m2zP4w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Bug 1886362 <1886362@bugs.launchpad.net>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/14 下午6:48, Li Qiang wrote:
> Jason Wang <jasowang@redhat.com> 于2020年7月14日周二 下午4:56写道：
>>
>> On 2020/7/10 下午6:37, Li Qiang wrote:
>>> Paolo Bonzini <pbonzini@redhat.com> 于2020年7月10日周五 上午1:36写道：
>>>> On 09/07/20 17:51, Li Qiang wrote:
>>>>> Maybe we should check whether the address is a RAM address in 'dma_memory_rw'?
>>>>> But it is a hot path. I'm not sure it is right. Hope more discussion.
>>>> Half of the purpose of dma-helpers.c (as opposed to address_space_*
>>>> functions in exec.c) is exactly to support writes to MMIO.  This is
>>> Hi Paolo,
>>>
>>> Could you please explain more about this(to support writes to MMIO).
>>> I can just see the dma helpers with sg DMA, not related with MMIO.
>>
>> Please refer doc/devel/memory.rst.
>>
>> The motivation of memory API is to allow support modeling different
>> memory regions. DMA to MMIO is allowed in hardware so Qemu should
>> emulate this behaviour.
>>
> I just read the code again.
> So the dma_blk_io is used for some device that will need DMA to
> MMIO(may be related with
> device spec).  But for most of the devices(networking card for
> example) there is no need this DMA to MMIO.
> So we just ksuse dma_memory_rw.  Is this understanding right?
>
> Then another question.
> Though the dma helpers uses a bouncing buffer, it finally write to the
> device addressspace in 'address_space_unmap'.
> Is there any posibility that we can again write to the MMIO like this issue?


I think the point is to make DMA to MMIO work as real hardware. For 
e1000e and other networking devices we need make sure such DMA doesn't 
break anything.

Thanks


>
>
>>>
>>>> especially true of dma_blk_io, which takes care of doing the DMA via a
>>>> bounce buffer, possibly in multiple steps and even blocking due to
>>>> cpu_register_map_client.
>>>>
>>>> For dma_memory_rw this is not needed, so it only needs to handle
>>>> QEMUSGList, but I think the design should be the same.
>>>>
>>>> However, this is indeed a nightmare for re-entrancy.  The easiest
>>>> solution is to delay processing of descriptors to a bottom half whenever
>>>> MMIO is doing something complicated.  This is also better for latency
>>>> because it will free the vCPU thread more quickly and leave the work to
>>>> the I/O thread.
>>> Do you mean we define a per-e1000e bottom half. And in the MMIO write
>>> or packet send
>>> trigger this bh?
>>
>> Probably a TX bh.
>>
> I will try to write this tx bh to strength my understanding in this part.
> Maybe reference the virtio-net implementation I think.
>
>
>
> Thanks,
> Li Qiang
>
>>> So even if we again trigger the MMIO write, then
>>> second bh will not be executed?
>>
>> Bh is serialized so no re-entrancy issue.
>>
>> Thanks
>>
>>
>>>
>>> Thanks,
>>> Li Qiang
>>>
>>>> Paolo
>>>>


