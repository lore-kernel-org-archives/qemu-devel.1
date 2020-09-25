Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4F9C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BF22075E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flLiE/u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BF22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnN6-0004D9-3L
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLnHy-0007Km-5W; Fri, 25 Sep 2020 08:57:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLnHv-00025b-Qr; Fri, 25 Sep 2020 08:57:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id d4so2923606wmd.5;
 Fri, 25 Sep 2020 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9tA6yjGk5Zyqmh7GnRqcUOboSgoRbkNP2z9bloFWbUE=;
 b=flLiE/u62ukpU4GMj+Jo43z5UyeCXcR+xzzLD/3kkII8DDt1rThoq6G6JxjbCff8Mw
 YsZfaYD8ajG5Oor45F6s6Zd+4WJqSuYm5ajp3b8WTLW7pTGB4yXu+eQSTUDPbGPKDqTm
 cXge8ezPbYF3hVH9MW75UaULjT8oMJlOxxtFGBNemvSt9Q/cDnmPCFAsuEEJgZqVDVY/
 2VVd3Kg74KBk6t/z3L+WfCg34VHi/MHgoAq6r5zZTWYHxlpZ1VZaBlHdSzrW9IU1UBI2
 h44OVi3Ypxstob+se4GttSZEzfy3ZxkvKRWXhslEh8d6Jzj1nYZ9mxVGfv8oqVkyKaug
 9gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9tA6yjGk5Zyqmh7GnRqcUOboSgoRbkNP2z9bloFWbUE=;
 b=lY2ra2nF/0dDZyuDcdEbj5r/JH+7m8uBAqgATuAU44Cd7ClTxIkVDitCAvjDkgrpYM
 xS6o5gFn0PkBPqSQ62HKHRERXLsxcmDNttTwHeu9pA8GsLwrInXodfwSxAYxK9rQskgf
 J/xhXZ2tG8RAjoHco492JI7aGHRM8adY/qvgjG+5w8WNowEMRRm2lQFG2XFHlAbNdyQr
 gpM/AkMzzcsrToe1lHwYA/Oko8pliCLcJBqvW7HYwfGPrdWol3CumWsZYk+qoqRnNrE3
 q1EHmawJybBvTrJAFT4hFGrnnvDJXu++0v6aMPx7TYQ0qOuIA2/zfndTtRwdECascYe+
 aYOA==
X-Gm-Message-State: AOAM531OtDp3MVS7I3X07TauB7zhCm172KVdPQbMB6LoeXu1mOfQ8QRg
 O8aVfGZREDH29DhVvJuh48M=
X-Google-Smtp-Source: ABdhPJzGI+J78XnlCt7x3a7XgQ3E3YmKrriq73CQpS7/UH5aE4w2AMupqUnc/k1UkhpDoJQt10cw9g==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr3057967wmg.117.1601038642216; 
 Fri, 25 Sep 2020 05:57:22 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id f6sm2883705wro.5.2020.09.25.05.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 05:57:21 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] hw/timer/bcm2835: Support the timer COMPARE
 registers
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
References: <20200921035257.434532-1-f4bug@amsat.org>
 <20200921035257.434532-5-f4bug@amsat.org>
 <49f67ca8-7a4e-c698-3deb-e53ee942cf06@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f5e4628-1866-267b-a073-38ddaf763433@amsat.org>
Date: Fri, 25 Sep 2020 14:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <49f67ca8-7a4e-c698-3deb-e53ee942cf06@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.238,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 9:39 PM, Luc Michel wrote:
> Hi Phil,
> 
> On 9/21/20 5:52 AM, Philippe Mathieu-Daudé wrote:
>> This peripheral has 1 free-running timer and 4 compare registers.
>>
>> Only the free-running timer is implemented. Add support the
>> COMPARE registers (each register is wired to an IRQ).
>>
>> Reference: "BCM2835 ARM Peripherals" datasheet [*]
>>              chapter 12 "System Timer":
>>
>>    The System Timer peripheral provides four 32-bit timer channels
>>    and a single 64-bit free running counter. Each channel has an
>>    output compare register, which is compared against the 32 least
>>    significant bits of the free running counter values. When the
>>    two values match, the system timer peripheral generates a signal
>>    to indicate a match for the appropriate channel. The match signal
>>    is then fed into the interrupt controller.
>>
>> This peripheral is used since Linux 3.7, commit ee4af5696720
>> ("ARM: bcm2835: add system timer").
>>
>> [*]
>> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
>>
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   include/hw/timer/bcm2835_systmr.h | 11 +++++++--
>>   hw/timer/bcm2835_systmr.c         | 41 +++++++++++++++++++------------
>>   hw/timer/trace-events             |  4 ++-
>>   3 files changed, 37 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/hw/timer/bcm2835_systmr.h
>> b/include/hw/timer/bcm2835_systmr.h
>> index e0db9e9e12b..17fdd9d67b2 100644
>> --- a/include/hw/timer/bcm2835_systmr.h
>> +++ b/include/hw/timer/bcm2835_systmr.h
>> @@ -11,6 +11,7 @@
>>     #include "hw/sysbus.h"
>>   #include "hw/irq.h"
>> +#include "qemu/timer.h"
>>   #include "qom/object.h"
>>     #define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
>> @@ -20,18 +21,24 @@ DECLARE_INSTANCE_CHECKER(BCM2835SystemTimerState,
>> BCM2835_SYSTIMER,
>>     #define BCM2835_SYSTIMER_COUNT 4
>>   +typedef struct {
>> +    unsigned id;
>> +    QEMUTimer timer;
>> +    qemu_irq irq;
>> +    BCM2835SystemTimerState *state;
>> +} BCM2835SystemTimerCompare;
>> +
>>   struct BCM2835SystemTimerState {
>>       /*< private >*/
>>       SysBusDevice parent_obj;
>>         /*< public >*/
>>       MemoryRegion iomem;
>> -    qemu_irq irq;
>> -
>>       struct {
>>           uint32_t ctrl_status;
>>           uint32_t compare[BCM2835_SYSTIMER_COUNT];
>>       } reg;
>> +    BCM2835SystemTimerCompare tmr[BCM2835_SYSTIMER_COUNT];
>>   };
>>     #endif
>> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
>> index b234e83824f..43e644f5e45 100644
>> --- a/hw/timer/bcm2835_systmr.c
>> +++ b/hw/timer/bcm2835_systmr.c
>> @@ -28,20 +28,13 @@ REG32(COMPARE1,     0x10)
>>   REG32(COMPARE2,     0x14)
>>   REG32(COMPARE3,     0x18)
>>   -static void bcm2835_systmr_update_irq(BCM2835SystemTimerState *s)
>> +static void bcm2835_systmr_timer_expire(void *opaque)
>>   {
>> -    bool enable = !!s->reg.ctrl_status;
>> +    BCM2835SystemTimerCompare *tmr = opaque;
>>   -    trace_bcm2835_systmr_irq(enable);
>> -    qemu_set_irq(s->irq, enable);
>> -}
>> -
>> -static void bcm2835_systmr_update_compare(BCM2835SystemTimerState *s,
>> -                                          unsigned timer_index)
>> -{
>> -    /* TODO fow now, since neither Linux nor U-boot use these timers. */
>> -    qemu_log_mask(LOG_UNIMP, "COMPARE register %u not implemented\n",
>> -                  timer_index);
>> +    trace_bcm2835_systmr_timer_expired(tmr->id);
>> +    tmr->state->reg.ctrl_status |= 1 << tmr->id;
>> +    qemu_set_irq(tmr->irq, 1);
>>   }
>>     static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
>> @@ -78,16 +71,25 @@ static void bcm2835_systmr_write(void *opaque,
>> hwaddr offset,
>>                                    uint64_t value, unsigned size)
>>   {
>>       BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
>> +    int index;
>>         trace_bcm2835_systmr_write(offset, value);
>>       switch (offset) {
>>       case A_CTRL_STATUS:
>>           s->reg.ctrl_status &= ~value; /* Ack */
>> -        bcm2835_systmr_update_irq(s);
>> +        for (index = 0; index < ARRAY_SIZE(s->tmr); index++) {
>> +            if (extract32(value, index, 1)) {
>> +                trace_bcm2835_systmr_irq_ack(index);
>> +                qemu_set_irq(s->tmr[index].irq, 0);
>> +            }
>> +        }
>>           break;
>>       case A_COMPARE0 ... A_COMPARE3:
>> -        s->reg.compare[(offset - A_COMPARE0) >> 2] = value;
>> -        bcm2835_systmr_update_compare(s, (offset - A_COMPARE0) >> 2);
>> +        index = (offset - A_COMPARE0) >> 2;
>> +        s->reg.compare[index] = value;
>> +        timer_mod(&s->tmr[index].timer, value);
>
> I think "value" is wrong here. timer_mod takes an absolute time value.
> Here "value" is a 32 bits truncated view of "current_time + some_time".

Yes, you are correct. The reduced datasheet is not easy to understand.

>> +        trace_bcm2835_systmr_run(index,
>> +                                 value -
>> qemu_clock_get_us(QEMU_CLOCK_VIRTUAL));
> Here also.
> 
> I think you can do something like (untested):
>            {
>                uint64_t now, triggers_at;
>                uint32_t clo, triggers_in;
> 
>                index = (offset - A_COMPARE0) >> 2;
>                s->reg.compare[index] = value;
> 
>                /* get the current clock and its truncated 32 bits view */
>                now = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
>                clo = now;
> 
>                /* will overflow in case clo > value. We still get the
> correct value on 32 bits (which is "UINT32_MAX - (clo - value)") */
>                triggers_in = value - clo;
> 
>                /* timer_mod takes an absolute time value, go back to 64
> bits values */
>                triggers_at = now + triggers_in;
>                timer_mod(&s->tmr[index].timer, triggers_at);
> 
>                trace_bcm2835_systmr_run(index, triggers_in);

This matches the datasheet description, thanks!

>            }
> 
> 
> The rest is OK to me.
> 

