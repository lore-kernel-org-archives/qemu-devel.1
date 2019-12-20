Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99BCC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E501206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E501206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dornerworks.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJAY-0006Pe-Aw
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jeff.Kubascik@dornerworks.com>) id 1iiIit-0005yn-Vp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jeff.Kubascik@dornerworks.com>) id 1iiIir-0004LT-OV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:53:42 -0500
Received: from mail.dornerworks.com ([12.207.209.150]:48884
 helo=webmail.dornerworks.com) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Jeff.Kubascik@dornerworks.com>)
 id 1iiIir-0004BF-9x; Fri, 20 Dec 2019 08:53:41 -0500
Subject: Re: [PATCH] target/arm: fix IL bit for data abort exceptions
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
References: <20191217210230.99559-1-jeff.kubascik@dornerworks.com>
 <7a274247-e593-5828-73f8-2042971e8633@linaro.org>
 <CAFEAcA8Egy=Jkw8yKSumkeX=+Qxi8bPy-0fJjopHR6gCmz3FLQ@mail.gmail.com>
From: Jeff Kubascik <jeff.kubascik@dornerworks.com>
Message-ID: <e8daa5c4-ba9a-a6dc-1037-7eec6335ad0b@dornerworks.com>
Date: Fri, 20 Dec 2019 08:54:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Egy=Jkw8yKSumkeX=+Qxi8bPy-0fJjopHR6gCmz3FLQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [99.18.96.11]
X-ClientProxiedBy: Mcbain.dw.local (172.27.1.45) To Mcbain.dw.local
 (172.27.1.45)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 12.207.209.150
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
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/2019 7:43 AM, Peter Maydell wrote:
> On Wed, 18 Dec 2019 at 01:03, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 12/17/19 11:02 AM, Jeff Kubascik wrote:
>>> diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
>>> index 5feb312941..e63f8bda29 100644
>>> --- a/target/arm/tlb_helper.c
>>> +++ b/target/arm/tlb_helper.c
>>> @@ -44,7 +44,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
>>>          syn = syn_data_abort_with_iss(same_el,
>>>                                        0, 0, 0, 0, 0,
>>>                                        ea, 0, s1ptw, is_write, fsc,
>>> -                                      false);
>>> +                                      true);
>>>          /* Merge the runtime syndrome with the template syndrome.  */
>>>          syn |= template_syn;
>>
>> This doesn't look correct.  Surely the IL bit should come from template_syn?
> 
> Yes. In translate.c we put it into the syndrome information by
> passing true/false to syn_data_abort_with_iss() depending on
> whether the issinfo passed in to disas_set_da_iss() has the
> ISSIs16Bit flag set.
> 
> I think this is a regression introduced in commit 46beb58efbb8a2a32
> when we converted the Thumb decoder over to decodetree. Before that
> 16 bit Thumb insns were in a different place in the old decoder and
> the 16-bit Thumb path passed ISSIs16Bit in with its issflags.
> (We should cc: qemu-stable@nongnu.org on the fix for this.)

The problem here was syn_data_abort_with_iss would return syn with the IL bit
set, which carries through when it gets or'd with template_syn. I had to change
the is_16bit argument to true so that it clear the IL bit.

>>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>>> index 2b6c1f91bf..300480f1b7 100644
>>> --- a/target/arm/translate.c
>>> +++ b/target/arm/translate.c
>>> @@ -8555,7 +8555,7 @@ static ISSInfo make_issinfo(DisasContext *s, int rd, bool p, bool w)
>>>
>>>      /* ISS not valid if writeback */
>>>      if (p && !w) {
>>> -        ret = rd;
>>> +        ret = rd | (s->is_16bit ? ISSIs16Bit : 0);
>>>      } else {
>>>          ret = ISSInvalid;
>>>      }
> 
> Rather than setting an is_16bit flag, we could just use
> "dc->base.pc_next - dc->pc_curr == 2", couldn't we?
> 
> thanks
> -- PMM
> 

Sincerely,
Jeff Kubascik

