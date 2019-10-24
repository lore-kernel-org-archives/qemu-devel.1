Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EBCCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92B52070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8CTdGRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92B52070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNee2-0006hF-8z
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iNdWH-0003Nl-ES
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iNdWG-0000v8-7L
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:51:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iNdWC-0000sh-1X; Thu, 24 Oct 2019 09:51:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id w18so25650434wrt.3;
 Thu, 24 Oct 2019 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N6f3Hfdwoq7dm6WmI2PCE15ux3AudUug4cU85NhzejU=;
 b=k8CTdGRo0Sbwa8X2+iBKodHLLK/y+lvS8xYXjCdmQ80wQ4BmvJURqEE01GhoAPULpD
 AVgh6MounJV7IFGPe3lOHuXZQO379Sx/KcHlxZUSq8Ll3ufaW+HBNgiJgaup4zX1odxi
 yVmN9ksFuu4fr7S/VttJIcAL1sD7AJixnSdXyGugKB1KFj+arwMGjghg3rzS6fCcGEbo
 3HXGPDXClYt4+2PwGbpF17MYkGk8FBQPOWZs84VX5fb9+3npadTSaxFwyGWSuGr3Gbsb
 tR3FiL65N7uO9ZIMWLVRedI0jn/jwhSaG3hoqQrMLABQnRHqbzM/htOO5vKOI2kD8/2n
 TvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N6f3Hfdwoq7dm6WmI2PCE15ux3AudUug4cU85NhzejU=;
 b=JA3RnwrcV8Iq6XgPv2S6aFoI+rGK2Q1HV4r39Xv3N85VvH2notgCCAHOjkpSoReABR
 yenQ92Gvddii7F9UmOmNisscU02EqwiXGFlQmUBdQ2NGAdT5HolAmtHA3Yc2CQCUL4Jb
 46ZaxRjLYuapgutJDHfg8SUQqsWMJAgIic4lk/WGmcFHFd7TeGr+bM5kdYTNJOWe0d19
 DGeFuHsXn9Yc4nNcyL/PyrUy3tJ6EFgDc1YbCcODG1MgisGP3vYiZ+ev4kh/kPPljSmh
 pwnCWIVGBHrYOEox1UXpIdOQx3AfxJ+SWfBC8MQ+Rq9YazCXIuJyfaIl+fu2PFeBnFJQ
 4wNg==
X-Gm-Message-State: APjAAAXG85j0xrvA+6iwku1uug9zHEwdQHMMQtE8a3F/FdB+wBBQl+Do
 2j1uhjXKYmMelBMZDsdUEnk=
X-Google-Smtp-Source: APXvYqxOvcvWPosHKluKq1lq29L2nofwRCACRkx9xVQHSdZQGs3gL5Brnwat7X1lSm12ZYB1h2EUJg==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr3975830wrw.117.1571925070271; 
 Thu, 24 Oct 2019 06:51:10 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id o189sm1638075wmo.23.2019.10.24.06.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 06:51:06 -0700 (PDT)
Subject: Re: [PATCH v3 00/16] hw/arm/raspi: Add thermal/timer, improve address
 space, run U-boot
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
 <CAFEAcA_WTyJ2AWZfKQSipFmn46ztG1XTL9sE9P2QDD7ob-FKFg@mail.gmail.com>
 <1ad1b559-13c4-ed2c-f82b-e6a516219e57@amsat.org>
 <CAFEAcA8Zst6XbPWiAat=z1s7HBzEMscsP=ibrPxP75kHXjZ3Kw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <87b354d2-88aa-4c21-b3a5-8e3313b83156@amsat.org>
Date: Thu, 24 Oct 2019 15:51:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Zst6XbPWiAat=z1s7HBzEMscsP=ibrPxP75kHXjZ3Kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Rob Herring <robh@kernel.org>, Matthias Brugger <mbrugger@suse.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 3:49 PM, Peter Maydell wrote:
> On Thu, 24 Oct 2019 at 14:46, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 10/24/19 3:42 PM, Peter Maydell wrote:
>>> On Sun, 20 Oct 2019 at 00:47, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> Since v2:
>>>> - fixed issue in videocore address space
>>>> - allow to start with some cores OFF (to boot firmwares)
>>>> - add proof-of-concept test for '-smp cores=1' and U-boot
>>>> - fixed my email setup
>>>>
>>>> Previous cover:
>>>>
>>>> Hi,
>>>>
>>>> Some patches from v1 are already merged. This v2 addresses the
>>>> review comment from v1, and add patches to clean the memory
>>>> space when using multiple cores.
>>>>
>>>> Laurent, if you test U-Boot with this patchset again, do you mind
>>>> replying with a "Tested-by:" tag?
>>>>
>>>> The next patchset is probably about the interrupt controller blocks,
>>>> then will come another one about the MBox/Properties.
>>>>
>>>> The last patch is unrelated to the series, but since I cleaned this
>>>> for the raspi and the highbank is the only board with the same issue,
>>>> I included the patch in this series.
>>>
>>> I'm going to apply 1-10 and 14 to target-arm.next.
>>> (I've reviewed 10, and the rest have been reviewed.)

I guess you meant you reviewed patch 9.

>>
>> Thanks!
>>
>> Do you mind amending this to patch #3
>> "hw/timer/bcm2835: Add the BCM2835 SYS_timer"
>> or should I respin (or resend it alone)?
>>
>> -- >8 --
>> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
>> index 49b40b55f9..3387a6214a 100644
>> --- a/hw/timer/bcm2835_systmr.c
>> +++ b/hw/timer/bcm2835_systmr.c
>> @@ -115,10 +115,7 @@ static void bcm2835_systmr_reset(DeviceState *dev)
>>    {
>>        BCM2835SystemTimerState *s = BCM2835_SYSTIMER(dev);
>>
>> -    s->reg.status = 0;
>> -    for (size_t i = 0; i < ARRAY_SIZE(s->reg.compare); i++) {
>> -        s->reg.compare[i] = 0;
>> -    }
>> +    memset(&s->reg, 0, sizeof(s->reg));
>>    }
>>
> 
> Sure, I'll just squash that in.

Thanks a lot!

Phil.

