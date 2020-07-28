Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558FEC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2414820838
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2414820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0EYg-0002dw-Ep
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 21:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1k0EXX-0001D0-6L; Mon, 27 Jul 2020 21:36:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33762 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1k0EXV-00058e-Cz; Mon, 27 Jul 2020 21:36:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 0BD3A25CBDE627D941BF;
 Tue, 28 Jul 2020 09:36:16 +0800 (CST)
Received: from [10.174.187.22] (10.174.187.22) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 09:36:06 +0800
Subject: Re: [PATCH] bugfix: irq: Avoid covering object refcount of qemu_irq
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200727130225.32640-1-zhukeqian1@huawei.com>
 <CAFEAcA9vQMP0YLAuzdPW2m3RcRNySxA0gJQZmeXBUYRy4=Dk+w@mail.gmail.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <d8b6e214-a729-26a6-ae2f-f6b59091b613@huawei.com>
Date: Tue, 28 Jul 2020 09:36:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9vQMP0YLAuzdPW2m3RcRNySxA0gJQZmeXBUYRy4=Dk+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhukeqian1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 21:36:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Esteban Bosse <estebanbosse@gmail.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, yezengruan@huawei.com,
 qemu-arm <qemu-arm@nongnu.org>, wanghaibin.wang@huawei.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2020/7/27 22:41, Peter Maydell wrote:
> On Mon, 27 Jul 2020 at 14:03, Keqian Zhu <zhukeqian1@huawei.com> wrote:
>>
>> Avoid covering object refcount of qemu_irq, otherwise it may causes
>> memory leak.
>>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>  hw/core/irq.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/irq.c b/hw/core/irq.c
>> index fb3045b912..59af4dfc74 100644
>> --- a/hw/core/irq.c
>> +++ b/hw/core/irq.c
>> @@ -125,7 +125,9 @@ void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
>>      int i;
>>      qemu_irq *old_irqs = qemu_allocate_irqs(NULL, NULL, n);
>>      for (i = 0; i < n; i++) {
>> -        *old_irqs[i] = *gpio_in[i];
>> +        old_irqs[i]->handler = gpio_in[i]->handler;
>> +        old_irqs[i]->opaque = gpio_in[i]->opaque;
>> +
>>          gpio_in[i]->handler = handler;
>>          gpio_in[i]->opaque = &old_irqs[i];
>>      }
> 
> This function is leaky by design, because it doesn't do anything
> with the old_irqs array and there's no function for un-intercepting
> the IRQs (which would need to free that memory). This is not ideal
> but OK because it's only used in the test suite.
One of our internal self-developed module also use this function, and we
implemented a function to remove intercepting, so there is no memory leak
after this bugfix.

I suggest to merge this bugfix to prepare for future code which may invoke
this function.

> 
> Is there a specific bug you're trying to fix here?
The memory leak is reported by ASAN.
> 

Thanks,
Keqian
> thanks
> -- PMM
> .
> 

