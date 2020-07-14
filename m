Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD39C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3899120BED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFHfzzyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3899120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGk5-00006G-IY
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 04:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvGjY-00087h-7l
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:56:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60514
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvGjW-0004r6-JJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594716973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mb3xLadYgvtGafOIOLevZL13nk6RJbho9+GF8PQ1eMI=;
 b=SFHfzzyxca/jJUvKEHiOkXziZcp2IbM8+yukVAWXU9RU97mY7MUgx7bRl6qnaNet/WvnOs
 DdHJHIcBcv9tofHwLd8uh8rZKXToNYIqoHpj28HfX1i4v0RWCuBIxfITludI9i7rvqw13u
 s2rBJb03rXuWkeo4QWNO46uc2gMXE88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-S8PbshMIOImGDo3JKpNcBw-1; Tue, 14 Jul 2020 04:56:11 -0400
X-MC-Unique: S8PbshMIOImGDo3JKpNcBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 169701083;
 Tue, 14 Jul 2020 08:56:10 +0000 (UTC)
Received: from [10.72.12.168] (ovpn-12-168.pek2.redhat.com [10.72.12.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A7A45D9DC;
 Tue, 14 Jul 2020 08:56:07 +0000 (UTC)
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Li Qiang <liq3ea@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
 <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
 <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e4a34525-dbd1-1f85-475b-b5004885215b@redhat.com>
Date: Tue, 14 Jul 2020 16:56:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: Bug 1886362 <1886362@bugs.launchpad.net>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/10 下午6:37, Li Qiang wrote:
> Paolo Bonzini <pbonzini@redhat.com> 于2020年7月10日周五 上午1:36写道：
>> On 09/07/20 17:51, Li Qiang wrote:
>>> Maybe we should check whether the address is a RAM address in 'dma_memory_rw'?
>>> But it is a hot path. I'm not sure it is right. Hope more discussion.
>> Half of the purpose of dma-helpers.c (as opposed to address_space_*
>> functions in exec.c) is exactly to support writes to MMIO.  This is
> Hi Paolo,
>
> Could you please explain more about this(to support writes to MMIO).
> I can just see the dma helpers with sg DMA, not related with MMIO.


Please refer doc/devel/memory.rst.

The motivation of memory API is to allow support modeling different 
memory regions. DMA to MMIO is allowed in hardware so Qemu should 
emulate this behaviour.


>
>
>> especially true of dma_blk_io, which takes care of doing the DMA via a
>> bounce buffer, possibly in multiple steps and even blocking due to
>> cpu_register_map_client.
>>
>> For dma_memory_rw this is not needed, so it only needs to handle
>> QEMUSGList, but I think the design should be the same.
>>
>> However, this is indeed a nightmare for re-entrancy.  The easiest
>> solution is to delay processing of descriptors to a bottom half whenever
>> MMIO is doing something complicated.  This is also better for latency
>> because it will free the vCPU thread more quickly and leave the work to
>> the I/O thread.
> Do you mean we define a per-e1000e bottom half. And in the MMIO write
> or packet send
> trigger this bh?


Probably a TX bh.


> So even if we again trigger the MMIO write, then
> second bh will not be executed?


Bh is serialized so no re-entrancy issue.

Thanks


>
>
> Thanks,
> Li Qiang
>
>> Paolo
>>


