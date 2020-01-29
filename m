Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43661C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 06:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E278206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 06:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vc+eCdIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E278206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhEd-000077-7K
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 01:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwhDy-00087f-O5
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 01:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwhDw-0007iH-U0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 01:53:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwhDw-0007gc-Qr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 01:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580280796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nbuuthuWPZZqSKstMfSIch8SaSyz/dvmAt5HpD5YvQ=;
 b=Vc+eCdIXkZbywsdtarGyRH7F6UKXB8kh0gozzjcKGRgEocqVirfVn85bN6mhRtCn72aF8E
 jW9Ih+hzjNL5LQ9+LIgf4PvOgiAWuORumBHu9Elp8Q2lZmmDc5ln12dwAoR8aDsRcv+eYp
 kHbKZpJcBjsGSapjm0IxzcAf1sl9ShY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-blOaIxHmMhGBkRUN3iVs7Q-1; Wed, 29 Jan 2020 01:53:12 -0500
Received: by mail-wr1-f69.google.com with SMTP id c6so9512798wrm.18
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 22:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+nbuuthuWPZZqSKstMfSIch8SaSyz/dvmAt5HpD5YvQ=;
 b=B8w2kHv3gnVLcchkJNPUi+Q+0e05B27gEf6MTFo1leGGD95JGRa5EdVvrQDWMpIlrR
 cHJrW73EJPl/26QHfx6DJ3kTSZOKs/6qZ8rRMrDMgZOa4lRxqzeOWSg3r39lBAFAcOMp
 SabzkaQS8JUMsAnUQ5ZXbqs9D2OwikuVRPNKW8a5Sz7ETrGyE0Ld/BK3AtDsJNSwsa0k
 8frzx+xR2hPvEZgY8lf0cB4CO0W/szdT5DQsMA/g+wS7PeSs1NtTAAQji4JPkHuMpGVY
 /AWMekGaoeOKym0LAsfRA2du7R4ioExxbWyLE7MRNs5ML71NaXmZDtOY3FEzy+E0FbOF
 S+oQ==
X-Gm-Message-State: APjAAAXqyIMs4QlxMa+KB2iljNQxs1vJU1DdOLuFZN0p/3lsqtUtAyMK
 maoWpmLEAOXYyiIabvsmtcucQU6EO+HEy2ftbXmrX2Y90w4hb4uwE5Sf6sUNml+9bPYqCObl2BP
 mnLt7VM4RpVw3wlE=
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr35080808wrs.247.1580280791548; 
 Tue, 28 Jan 2020 22:53:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqzyELTLNjbdaehVgjQE1jkQkDXq1TFnch3ftnz+Un8j9CZnVKPygRkxwkyJ2QvmbYbZwXSqOg==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr35080772wrs.247.1580280791265; 
 Tue, 28 Jan 2020 22:53:11 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z4sm1119198wma.2.2020.01.28.22.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 22:53:10 -0800 (PST)
Subject: Re: [PATCH v3 13/14] dp8393x: Don't reset Silicon Revision register
To: Finn Thain <fthain@telegraphics.com.au>
References: <cover.1579474761.git.fthain@telegraphics.com.au>
 <34caf9dea82cd30dc51b4f8768adb7a90b236bf2.1579474761.git.fthain@telegraphics.com.au>
 <dcd1dcd2-719c-1db0-e9ce-25d26ed1f6d4@redhat.com>
 <alpine.LNX.2.21.1.2001290922330.8@nippy.intranet>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1e00d5c7-33c1-70b8-2ac3-de6004690406@redhat.com>
Date: Wed, 29 Jan 2020 07:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1.2001290922330.8@nippy.intranet>
Content-Language: en-US
X-MC-Unique: blOaIxHmMhGBkRUN3iVs7Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Finn,

On 1/28/20 11:28 PM, Finn Thain wrote:
> On Tue, 28 Jan 2020, Philippe Mathieu-Daud? wrote:
>> On 1/19/20 11:59 PM, Finn Thain wrote:
>>> The jazzsonic driver in Linux uses the Silicon Revision register value
>>> to probe the chip. The driver fails unless the SR register contains 4.
>>> Unfortunately, reading this register in QEMU usually returns 0 because
>>> the s->regs[] array gets wiped after a software reset.
>>>
>>> Fixes: bd8f1ebce4 ("net/dp8393x: fix hardware reset")
>>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>>> ---
>>>    hw/net/dp8393x.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>>> index 1b73a8703b..71af0fad51 100644
>>> --- a/hw/net/dp8393x.c
>>> +++ b/hw/net/dp8393x.c
>>> @@ -591,6 +591,10 @@ static uint64_t dp8393x_read(void *opaque, hwaddr addr,
>>> unsigned int size)
>>>                    val |= s->cam[s->regs[SONIC_CEP] & 0xf][2* (SONIC_CAP0 -
>>> reg)];
>>>                }
>>>                break;
>>> +        /* Read-only */
>>> +        case SONIC_SR:
>>> +            val = 4; /* only revision recognized by Linux/mips */
>>> +            break;
>>>            /* All other registers have no special contrainst */
>>>            default:
>>>                val = s->regs[reg];
>>> @@ -971,7 +975,6 @@ static void dp8393x_realize(DeviceState *dev, Error
>>> **errp)
>>>        qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>>>          s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
>>> -    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
>>>          memory_region_init_ram(&s->prom, OBJECT(dev),
>>>                               "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
>>>
>>
>> Please fix in dp8393x_reset() instead:
>>
>> -- >8 --
>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>> index cdc2631c0c..65eb9c23a7 100644
>> --- a/hw/net/dp8393x.c
>> +++ b/hw/net/dp8393x.c
>> @@ -862,6 +862,7 @@ static void dp8393x_reset(DeviceState *dev)
>>       timer_del(s->watchdog);
>>
>>       memset(s->regs, 0, sizeof(s->regs));
>> +    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
>>       s->regs[SONIC_CR] = SONIC_CR_RST | SONIC_CR_STP | SONIC_CR_RXDIS;
>>       s->regs[SONIC_DCR] &= ~(SONIC_DCR_EXBUS | SONIC_DCR_LBR);
>>       s->regs[SONIC_RCR] &= ~(SONIC_RCR_LB0 | SONIC_RCR_LB1 | SONIC_RCR_BRD |
>> SONIC_RCR_RNT);
>> @@ -914,7 +915,6 @@ static void dp8393x_realize(DeviceState *dev, Error
>> **errp)
>>       qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>>
>>       s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
>> -    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
>>
>>       memory_region_init_ram(&s->prom, OBJECT(dev),
>>                              "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
>> ---
>>
> 
> This would allow the host to change the value of the Silicon Revision
> register.
How the guest can modify it? We have:

589 static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
590                           unsigned int size)
591 {
592     dp8393xState *s = opaque;
593     int reg = addr >> s->it_shift;
594
...
597     switch (reg) {
...
602         /* Prevent write to read-only registers */
...
606         case SONIC_SR:
...
608             DPRINTF("writing to reg %d invalid\n", reg);
609             break;

> However, the datasheet says,
> 
>      4.3.13 Silicon Revision Register
>      This is a 16-bit read only register. It contains information on the
>      current revision of the SONIC. The value of the DP83932CVF revision
>      register is 6h.
> 
> I haven't actually tried storing a different value in this register on
> National Semiconductor hardware, but I'm willing to do that test if you
> wish.
> 


