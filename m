Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 05:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BECB207D5
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 05:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faWOKvZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BECB207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh4Z4-0006dI-MJ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 01:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh4YJ-0006BK-IH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 01:05:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29107
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh4YI-0000f0-QT
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 01:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591333557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ECagGBGyG3wMb85LrEJFHRADEfIFXYBC0krRvc8FK0Q=;
 b=faWOKvZcoIwRbQldmSIv6PUdC/l2/tMtf1zeTndmRExkpevG7AOSAAheUoDD12iG123KQi
 Bwz5alpoprZ1LWRayWUK6H/XHld/lvuf3LMmAFGt2F+5SUoV/ZdJGpbQBXuEU/Uyfy1Ujm
 8a7uUFmi4gRjZWsdgEotgMUCLs9HzRM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-kwqcRWjMMmOsnJbRCTWHOg-1; Fri, 05 Jun 2020 01:05:55 -0400
X-MC-Unique: kwqcRWjMMmOsnJbRCTWHOg-1
Received: by mail-wr1-f71.google.com with SMTP id w4so3283271wrl.13
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 22:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ECagGBGyG3wMb85LrEJFHRADEfIFXYBC0krRvc8FK0Q=;
 b=O6Bt/OZkJqInB78uHf1l0KEV2GAMaTB9HDxZjq+akOqBh3kjoSy8E/FGR9wV2+PZ5P
 0dLqf7SV0VYC+hlkC0nE7+pLWf2S8uHGetvCyhRgroANfRSbpywt/0oVPMl6kPo17I0O
 Lb+brkqOdQB5ObyqjKVS+GXOPYeB2+7LuY/4ciCtnadfZ+Puwx+EMXX26CuwxgDoHiuy
 eOl7JiJdw0cNQyw9Wiu+LjO/uZ0WYpkxrJlMn3o6wBzEaTN9tZZZkwC613oLDK31iGph
 c6DHPnWtogpWwydGRzjNhv4SV9Ac4w05BpDlXLGeGuWqf12E3hh+ntSqkqrtbsy4x2/8
 b5Yw==
X-Gm-Message-State: AOAM530J6/Fk7yfJPhIYwmftbGIT1NpEWxJ76RuVqSm1sAPnDZycU6qm
 wJFZXHUYOnk09wwW/lRU8j9ARTGiZHNVVTc/OjVzY3a17VlOKLR2txFRHMnzaKBxd+66XG863fa
 sSFkzTaUKliFBqdI=
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr836741wmi.126.1591333554890; 
 Thu, 04 Jun 2020 22:05:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+YQ4eJ9MARA40FAC15CnX33NH3sgxPO8krRAeDGP8PWrngMGZT6oqftrPMja5b56A7/H1lQ==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr836729wmi.126.1591333554674; 
 Thu, 04 Jun 2020 22:05:54 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k14sm10269043wrq.97.2020.06.04.22.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 22:05:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/sd/sd: Delay timer_new_ns() from init to realize
 to avoid memleaks
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-3-philmd@redhat.com>
 <CAFEAcA8P9yFjX5t96NJwzQpFEwsYg1eAWicO-Vneh1_zszJ_Aw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <a36cb24a-0d0d-7772-b30e-81df474462cd@redhat.com>
Date: Fri, 5 Jun 2020 07:05:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8P9yFjX5t96NJwzQpFEwsYg1eAWicO-Vneh1_zszJ_Aw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 01:01:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 2:26 PM, Peter Maydell wrote:
> On Sat, 15 Feb 2020 at 15:48, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> In commit f3a508eb4e the Euler Robot reported calling timer_new()
>> in instance_init() can leak heap memory. The easier fix is to
>> delay the timer creation at instance realize(). Similarly move
>> timer_del() into a new instance unrealize() method.
> 
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 71a9af09ab..d72cf3de2a 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -2058,14 +2058,12 @@ static void sd_instance_init(Object *obj)
>>      SDState *sd = SD_CARD(obj);
>>
>>      sd->enable = true;
>> -    sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
>>  }
>>
>>  static void sd_instance_finalize(Object *obj)
>>  {
>>      SDState *sd = SD_CARD(obj);
>>
>> -    timer_del(sd->ocr_power_timer);
>>      timer_free(sd->ocr_power_timer);
>>  }
>>
>> @@ -2098,6 +2096,15 @@ static void sd_realize(DeviceState *dev, Error **errp)
>>          }
>>          blk_set_dev_ops(sd->blk, &sd_block_ops, sd);
>>      }
>> +
>> +    sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
>> +}
>> +
>> +static void sd_unrealize(DeviceState *dev, Error **errp)
>> +{
>> +    SDState *sd = SD_CARD(dev);
>> +
>> +    timer_del(sd->ocr_power_timer);
>>  }
> 
> Here too the old code was doing things correctly in that
> it does a timer_del/timer_free on the timer it allocates
> in instance_init, and the new code has weirdly split the
> freeing between unrealize and finalize.

Indeed I now see it, thanks.

> 
> thanks
> -- PMM
> 


