Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363E9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8D8208B6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttpgiwXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8D8208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWRZY-0000dO-MV
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 17:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWRYn-0000A7-B1
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:58:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWRYk-00058V-Gl
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:58:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id s9so7258728wro.8
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mlMKPI/CoGC+PyJeXk0mxcqFYJSo+rU3BoJznCtE2Gg=;
 b=ttpgiwXq3tLHcfVhLE1//Brzlk/PDFJ+f69A8qmicRfhPL7cUJ3SMpRSGhoPzy6kmm
 I/8ejFWgA16VLDdZOnC4psTW/89LBPaMkzCEi8fDl+eVfYP+pgVpH6B/1KfNhwBC2xBj
 yydfp+vh0IjoFljBBO0a/BpRcWga6/0SiScWyM3Axl2ied0eL9q1/TVXhuhfICLaiOIb
 22IGjH78/HBvHTqMLi21JWuyF4/3+5Pa0XeApjFFdZWfWqVpxqPUxU+L3cUrm/M7b5al
 5O4Ydqs/hpaagrKV2mzQU8VtyfXHgbPLHdmjgP8qSjKwOwL346sFhs/F5/49TNeKkH1h
 PQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mlMKPI/CoGC+PyJeXk0mxcqFYJSo+rU3BoJznCtE2Gg=;
 b=BJ97cwtbm15fwhYDXTAMNiQLOldgNXwWGqfwf58aORFPo1ZUtm+t5CP0K1frzq569h
 FMl5mrMniP2+pYyw0kSf3XCxNmliZlx3Kt5mzQPpUc2ZBNTqQbqgru2LV2quHhi744kQ
 QBRSLYUT3VBhrXpBFa5RcTatw6ST3Fi1uWmlBmpRpnbdR7tonmFisaOGuHnF/U0e7DNK
 K+lwUzLGTnGUN+nOQS/TDLbSkj476jqH7d9rpXxlQ8rYHjM9etuzV0LoXjyPSs2VbzIx
 2XUlffrBlMVNHqp58yURusvRoOZhBxnUwHYY0KND1MsQ/VoGWKVcQcaW7KBJS/DQIsTR
 IuQg==
X-Gm-Message-State: AOAM531VB0PTo0ns/oCZlpoyuY8aVuwrOmu6DYvixbG4DwXpt1Civw2q
 l1R5HmPEkoEDlblf6p/8i9sYln87H6A=
X-Google-Smtp-Source: ABdhPJyjJEfsA+CK0u3In8jIrRPg/EUiZTYcfoL+nZerwo7DVbkP2RuIBNHy3Fj5B+7CT3rvfGiUPw==
X-Received: by 2002:adf:f903:: with SMTP id b3mr9776109wrr.142.1603576724579; 
 Sat, 24 Oct 2020 14:58:44 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id l5sm13211307wrq.14.2020.10.24.14.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 14:58:44 -0700 (PDT)
Subject: Re: [PATCH 05/20] hw/rx: Add RX62N Clock generator
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-6-ysato@users.sourceforge.jp>
 <aafa29bc-d3fb-7331-7a40-9c5f62b5bc31@amsat.org>
Message-ID: <5e1bee51-68cd-27c9-8e40-b8e1cc95b96e@amsat.org>
Date: Sat, 24 Oct 2020 23:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <aafa29bc-d3fb-7331-7a40-9c5f62b5bc31@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/20 11:56 PM, Philippe Mathieu-Daudé wrote:
> On 8/27/20 2:38 PM, Yoshinori Sato wrote:
>> This module generated core and peripheral clock.
>>
>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>> ---
>>   include/hw/rx/rx62n-cpg.h |  72 ++++++++
>>   include/hw/rx/rx62n.h     |   5 +-
>>   hw/rx/rx62n-cpg.c         | 344 ++++++++++++++++++++++++++++++++++++++
>>   hw/rx/rx62n.c             |  52 +++---
>>   hw/rx/meson.build         |   2 +-
>>   5 files changed, 447 insertions(+), 28 deletions(-)
>>   create mode 100644 include/hw/rx/rx62n-cpg.h
>>   create mode 100644 hw/rx/rx62n-cpg.c
> ...
> 
>> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
>> index 4b5c3c1079..ec63fa5db1 100644
>> --- a/hw/rx/rx62n.c
>> +++ b/hw/rx/rx62n.c
>> @@ -47,6 +47,7 @@
>>   #define RX62N_TMR_BASE  0x00088200
>>   #define RX62N_CMT_BASE  0x00088000
>>   #define RX62N_SCI_BASE  0x00088240
>> +#define RX62N_CPG_BASE  0x00080010
>>   /*
>>    * RX62N Peripheral IRQ
>> @@ -56,10 +57,6 @@
>>   #define RX62N_CMT_IRQ   28
>>   #define RX62N_SCI_IRQ   214
>> -#define RX62N_XTAL_MIN_HZ  (8 * 1000 * 1000)
>> -#define RX62N_XTAL_MAX_HZ (14 * 1000 * 1000)
>> -#define RX62N_PCLK_MAX_HZ (50 * 1000 * 1000)
>> -
>>   /*
>>    * IRQ -> IPR mapping table
>>    * 0x00 - 0x91: IPR no (IPR00 to IPR91)
>> @@ -149,36 +146,45 @@ static void register_tmr(RX62NState *s, int unit)
>>   {
>>       SysBusDevice *tmr;
>>       int i, irqbase;
>> +    char ckname[16];
>>       object_initialize_child(OBJECT(s), "tmr[*]",
>>                               &s->tmr[unit], TYPE_RENESAS_TMR);
>>       tmr = SYS_BUS_DEVICE(&s->tmr[unit]);
>> -    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", s->pclk_freq_hz);
>> -    sysbus_realize(tmr, &error_abort);
>>       irqbase = RX62N_TMR_IRQ + TMR_NR_IRQ * unit;
>>       for (i = 0; i < TMR_NR_IRQ; i++) {
>>           sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
>>       }
>>       sysbus_mmio_map(tmr, 0, RX62N_TMR_BASE + unit * 0x10);
>> +
>> +    qdev_prop_set_uint32(DEVICE(tmr), "unit", unit);
> 
> Runtime failure:
> 
> qemu-system-rx: Property 'renesas-tmr.unit' not found
> 
>> +    sysbus_realize(tmr, &error_abort);
>> +    snprintf(ckname, sizeof(ckname), "pck_tmr8-%d", unit);
>> +    qdev_connect_clock_in(DEVICE(tmr), "pck",
>> +                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));
>>   }
>>   static void register_cmt(RX62NState *s, int unit)
>>   {
>>       SysBusDevice *cmt;
>>       int i, irqbase;
>> +    char ckname[16];
>>       object_initialize_child(OBJECT(s), "cmt[*]",
>>                               &s->cmt[unit], TYPE_RENESAS_CMT);
>>       cmt = SYS_BUS_DEVICE(&s->cmt[unit]);
>> -    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", s->pclk_freq_hz);
>> -    sysbus_realize(cmt, &error_abort);
>> +    qdev_prop_set_uint32(DEVICE(cmt), "unit", unit);
>>       irqbase = RX62N_CMT_IRQ + CMT_NR_IRQ * unit;
>>       for (i = 0; i < CMT_NR_IRQ; i++) {
>>           sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
>>       }
>>       sysbus_mmio_map(cmt, 0, RX62N_CMT_BASE + unit * 0x10);
>> +    sysbus_realize(cmt, &error_abort);
>> +    snprintf(ckname, sizeof(ckname), "pck_cmt-%d", unit);
>> +    qdev_connect_clock_in(DEVICE(cmt), "pck",
>> +                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));

qemu-system-rx: Can not find clock-in 'pck' for device type 'renesas-tmr'

>>   }
> 

