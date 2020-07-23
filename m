Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98541C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 02:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F90320714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 02:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZllRiLpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F90320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyQtd-0007UT-N3
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 22:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jyQt3-00075E-Ov
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 22:23:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jyQt1-00019w-N3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 22:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595470986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0pOae+kXbAA9T5ra3Y67ZIDr3uDeZw2SffWSpXP2no=;
 b=ZllRiLpqvv6Dwr4l1AKaQoNoRacMke6ls7ypID9C7j3zekfuMf4EpYo959Lzibd8yh+/33
 USA4rGVPdc8aYMvbalgcclYnjbWKfzI/zn23JcUWTi4+LmWJS0HnbWW0GLAEqoxQeORoFA
 UzBV0YnX3JM8yihjwzFNr1WcpURBfx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-r5PEq0QlOlWyQAZe9F0vCQ-1; Wed, 22 Jul 2020 22:23:04 -0400
X-MC-Unique: r5PEq0QlOlWyQAZe9F0vCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 663B78017FB;
 Thu, 23 Jul 2020 02:23:03 +0000 (UTC)
Received: from [10.72.13.141] (ovpn-13-141.pek2.redhat.com [10.72.13.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5C5071D16;
 Thu, 23 Jul 2020 02:22:53 +0000 (UTC)
Subject: Re: [PATCH 2/2] e1000e: make TX reentrant
To: Li Qiang <liq3ea@gmail.com>
References: <20200722085747.6514-1-jasowang@redhat.com>
 <20200722085747.6514-2-jasowang@redhat.com>
 <CAKXe6SJ2=RFAyun+X44qVPooBT85NC1doa1svT6H4NFQgq2H8A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2dad6d02-4c84-c231-1ecb-4188a9bd41d6@redhat.com>
Date: Thu, 23 Jul 2020 10:22:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJ2=RFAyun+X44qVPooBT85NC1doa1svT6H4NFQgq2H8A@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:23:06
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/22 下午7:24, Li Qiang wrote:
> Jason Wang <jasowang@redhat.com> 于2020年7月22日周三 下午4:58写道：
>> In loopback mode, e1000e RX can DMA into TX doorbell which requires
>> TX to be reentrant. This patch make e1000e's TX routine reentrant by
>> introducing a per device boolean for recording whether or not a TX
>> rountine is being called and return early.
>>
> Could we introduce a per-queue 'sending' variable just like the RX.
> So we can do this in net core layer.


It's kind of not easy since TX routine is called before the packet can 
reach network queue.

Thanks


>
> Thanks,
> Li Qiang
>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/net/e1000e_core.c | 8 ++++++++
>>   hw/net/e1000e_core.h | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> index bcd186cac5..8126a644a5 100644
>> --- a/hw/net/e1000e_core.c
>> +++ b/hw/net/e1000e_core.c
>> @@ -923,6 +923,12 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
>>           return;
>>       }
>>
>> +    if (core->sending) {
>> +        return;
>> +    }
>> +
>> +    core->sending = true;
>> +
>>       while (!e1000e_ring_empty(core, txi)) {
>>           base = e1000e_ring_head_descr(core, txi);
>>
>> @@ -940,6 +946,8 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
>>       if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
>>           e1000e_set_interrupt_cause(core, cause);
>>       }
>> +
>> +    core->sending = false;
>>   }
>>
>>   static bool
>> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
>> index aee32f7e48..4679c1761f 100644
>> --- a/hw/net/e1000e_core.h
>> +++ b/hw/net/e1000e_core.h
>> @@ -114,6 +114,7 @@ struct E1000Core {
>>       void (*owner_start_recv)(PCIDevice *d);
>>
>>       uint32_t msi_causes_pending;
>> +    bool sending;
>>   };
>>
>>   void
>> --
>> 2.20.1
>>


