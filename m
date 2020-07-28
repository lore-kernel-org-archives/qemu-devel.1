Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F5FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEEE206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNhc1aYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEEE206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0LHz-0007mH-HG
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0LHR-0007Em-1r
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:48:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0LHN-0003eq-Hc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595926088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ao3c9TQKb+juCT9/UCqPiTX4wcTHfvLH4i6SAgssd44=;
 b=GNhc1aYzVV/sddzs9eSjkVrbl6CGkJb4ArmWQc4IYH/dckT7DzgUuk0ygB1I7XCSa3LJKc
 jp+kQjCJYkoD/2H09znb9YJJpli82vCPYNvCZxUessyBNvm06fRx+/HzmbS88AuN8qH2oj
 nggBHn9WFjwnhdA8Qo6FImtAudwd9E8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-I9n3-TntMqu6TfwaycGEJw-1; Tue, 28 Jul 2020 04:48:06 -0400
X-MC-Unique: I9n3-TntMqu6TfwaycGEJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2548D8014D7;
 Tue, 28 Jul 2020 08:48:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-161.ams2.redhat.com [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA3C560CD0;
 Tue, 28 Jul 2020 08:48:02 +0000 (UTC)
Subject: Re: [PATCH] bugfix: irq: Avoid covering object refcount of qemu_irq
To: Peter Maydell <peter.maydell@linaro.org>,
 Keqian Zhu <zhukeqian1@huawei.com>
References: <20200727130225.32640-1-zhukeqian1@huawei.com>
 <CAFEAcA9vQMP0YLAuzdPW2m3RcRNySxA0gJQZmeXBUYRy4=Dk+w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <92e8dc9b-deed-afb8-89ae-f50b68bbafa8@redhat.com>
Date: Tue, 28 Jul 2020 10:48:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9vQMP0YLAuzdPW2m3RcRNySxA0gJQZmeXBUYRy4=Dk+w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: yezengruan@huawei.com, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 wanghaibin.wang@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/07/2020 16.41, Peter Maydell wrote:
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

I think this could better be done without calling qemu_allocate_irqs():
Simply call qemu_allocate_irq() (without "s" at the end) within the
for-loop for each irq instead. What do you think?

 Thomas


