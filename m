Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9E9C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9915A208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaaitEqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9915A208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTgv4-00037n-PJ
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTguD-00029t-Gj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTguB-00056L-AF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:13:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTguA-00055y-SG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:13:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id u127so783793wmg.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zkEuPMDzluLFQtrXDBrAtM2JpfOVb/ftLW/hQeHNTtU=;
 b=JaaitEqMgmaLJhyBRh55aJQsMNkQY11o6Y99DunftEbCwRXf3pi649ywJHl7VmEue9
 0+UXlJDgIfi9w+ezUf1oXLcjNQb/JkLbov1MCdR8V0C+mPAfE8bR2yS/r2sc8I40LWbL
 3L0JFiayjKWWvONJeDY1JiGgunpykA7qppqiJnrrZ2OYky5ltqgO4J6m6EnKjA2z5BMm
 +gMVkiLdq1853joq0CumLk1Vl4KNsX5pw5jJeY+wiigvD1/4HaXGjclzVDUZnFfI55DE
 N/0pv1xg+wlTabZmg3fGbEMV+bE2cES/yPXhwOKMBB2VE65zgQvoPXUc2cx/Q8dmopTL
 tyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zkEuPMDzluLFQtrXDBrAtM2JpfOVb/ftLW/hQeHNTtU=;
 b=kIhwnmgCVoiqGzhX3TbHJ1GOMF3nffEzQRyE/LoQB6AzjiWv/av1m3sI8t0cWRTTHL
 lC0AwZOVKlTdKLOzYS573m8NNutTDqG2X2ysMXpwkEmkmyGBFzOR9XeHF/GE/l6sOT9N
 DQWQisndb8yg1aCY8yXQfut+BbSfGceN5apaw+PxGTeYXxbfwi49sPuUgoSeXgD/UeQr
 +zHjEj2TBMTx4e33U+gBxS0newvRNCWo3QB0vWlL589Qt4PC6F3SKV0dFTybwMHXCPVi
 1p00cm5CgAY8pJPrCZr5BOODya+AbPR/NXbgKpQY1E073r/MV2DAnn530US2BJfTkc7y
 MGGA==
X-Gm-Message-State: AGi0PubgCS8j8krJXXbI+X2mjyT2jIG1puBYWptYHtZSERjLFvxJZN6c
 vWWeF/zvISUjKE3YP9qgfmg=
X-Google-Smtp-Source: APiQypKt1E4gnGFwKoSJt/RA8w/gcvYrWyo393/wjEB16EwY8bVpr8Yx/Q6NNPF2zATD61ZtyGjAQQ==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr1514809wmf.166.1588144393173; 
 Wed, 29 Apr 2020 00:13:13 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id y10sm6220025wma.5.2020.04.29.00.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 00:13:12 -0700 (PDT)
Subject: Re: [PATCH 07/11] mips/malta: Fix create_cps() error handling
To: Markus Armbruster <armbru@redhat.com>
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-8-armbru@redhat.com>
 <75dc4fbc-2b39-c8ef-8030-370672621c2f@amsat.org>
 <871ro6x26g.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d9a17752-6a8d-a59e-f661-a9e6c59b670f@amsat.org>
Date: Wed, 29 Apr 2020 09:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <871ro6x26g.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Peter for crediting his advice.

On 4/29/20 7:59 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 4/24/20 9:20 PM, Markus Armbruster wrote:
>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>> pointer to a variable containing NULL.  Passing an argument of the
>>> latter kind twice without clearing it in between is wrong: if the
>>> first call sets an error, it no longer points to NULL for the second
>>>
>>> create_cps() is wrong that way.  The last calls treats an error as
>>> fatal.  Do that for the prior ones, too.
>>>
>>> Fixes: bff384a4fbd5d0e86939092e74e766ef0f5f592c
>>> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
>>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   hw/mips/mips_malta.c | 15 ++++++---------
>>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>>> index e4c4de1b4e..17bf41616b 100644
>>> --- a/hw/mips/mips_malta.c
>>> +++ b/hw/mips/mips_malta.c
>>> @@ -1185,17 +1185,14 @@ static void create_cpu_without_cps(MachineState *ms,
>>>   static void create_cps(MachineState *ms, MaltaState *s,
>>>                          qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>>>   {
>>> -    Error *err = NULL;
>>> -
>>>       sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(s->cps),
>>>                             TYPE_MIPS_CPS);
>>> -    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type", &err);
>>> -    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp", &err);
>>> -    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
>>> -    if (err != NULL) {
>>> -        error_report("%s", error_get_pretty(err));
>>
>> In https://www.mail-archive.com/qemu-devel@nongnu.org/msg695645.html I
>> also remove "qemu/error-report.h" which is not needed once you remove
>> this call.
> 
> Missed it, sorry.  I only reviewed the Coccinelle scripts [PATCH 1+3/7].

My bad for not Cc'ing you on the whole series, which is Error related, 
and use the default get_maintainer.pl selection.

> I'd replace my patch by yours to give you proper credit, but your commit
> message mentions "the coccinelle script", presumably the one from PATCH
> 1/7, and that patch isn't quite ready in my opinion.

I'm not worried about credit, but duplicating effort or wasting time.

Peter once warned the problem with Coccinelle scripts is finding the 
correct balance between time spent to improve QEMU codebase, and time 
spent learning Coccinelle and improving a script that is often used only 
once in a lifetime.
If the script is not provided, we ask for the script. If the script is 
embedded in various patch descriptions, we ask to add it independently 
for reuse or as example. Then the script must be almost perfect. 
Meanwhile all the following patches referencing it, while reviewed, are 
stuck.

Anyway back to your patch:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>>> -        exit(1);
>>> -    }
>>> +    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type",
>>> +                            &error_fatal);
>>> +    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp",
>>> +                            &error_fatal);
>>> +    object_property_set_bool(OBJECT(&s->cps), true, "realized",
>>> +                             &error_fatal);
>>>   
>>>       sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
>>>   
>>>
> 

