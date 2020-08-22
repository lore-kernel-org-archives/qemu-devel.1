Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83226C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0C3208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+7kmga6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0C3208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9UdV-000588-KS
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 10:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9UcK-0003oD-UB
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9UcJ-0003xZ-8a
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598106934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a87a02siL9dCsA0yAEMZQ5Bq601ugwisDBkIdwi62ss=;
 b=E+7kmga6Ahs/LCD+Cc3JWyXEl3vAiRtjUq+5liXwzMr6Mn2ICJjfZSi0pjxBo0rblDE7jl
 3hKTI5UpDOj3RhfMT48+GG/sh/w2ficfq1xTclwciJtwsm2U4U0QE03/z9ZiWQbIXu7A8P
 9h1AWWlNzI3oipNCQLk819XQ4aQrHUo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-LonCVRiHNXid8Z6OjR1Bag-1; Sat, 22 Aug 2020 10:35:31 -0400
X-MC-Unique: LonCVRiHNXid8Z6OjR1Bag-1
Received: by mail-wm1-f71.google.com with SMTP id a5so1148657wmj.5
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 07:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=a87a02siL9dCsA0yAEMZQ5Bq601ugwisDBkIdwi62ss=;
 b=OAto1quZ223vkWXduLXfbvq7lkv2mblQfWiZng0L1TKsvGE7l8H6jgKZOLwZq86MqI
 ecF3YztMydPfPzvx3sjQPyfJvQDeCWX8rBNjkEjot+hRGdkIOOIak0QjSg02FXKfQKZa
 z1XA0yXsB91p4yveuWWI/xJhMQbSruAMmUivcUiMkNPUO+kC+/RigiVvBG/jDLyOnvlS
 kcCnomGz9sQDiK9NGlRPUDvv9ajudUkZsSQCXL+T7CSiHKAHKiEvdCZEkAKU8dBO1nzj
 RGs3ITzpZldvliHVrhgy7Djz5W8P9a2Np78cVB5TCNmdYmXgqz9foAMSJbfDeh1G/w7K
 jYMg==
X-Gm-Message-State: AOAM530vohSdQ/a/94UeA7bZzd34BosNBJfPYbnoFEpOIneRsOuEiNFP
 3PCwvwhKwiICuemh58jCEbsMehrT0nFl5etYTG/HxLtZLy1mEetmwR/p8oxrWDF3TSn/KguPaev
 wPN+h9dIVnfpM3f8=
X-Received: by 2002:a1c:7fd3:: with SMTP id a202mr7699430wmd.67.1598106929773; 
 Sat, 22 Aug 2020 07:35:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzK5ou0MYb8iYlB4RU3Oq99Fpjm2RTbFeqBHKcjV+s/hD51l7jU8KU1L3J7k47j3t3PPa8vaw==
X-Received: by 2002:a1c:7fd3:: with SMTP id a202mr7699399wmd.67.1598106929542; 
 Sat, 22 Aug 2020 07:35:29 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p22sm11705808wmc.38.2020.08.22.07.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 07:35:28 -0700 (PDT)
Subject: Re: [PATCH v6 4/8] ppc/e500: Use start-powered-off CPUState property
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20200819164306.625357-1-bauerman@linux.ibm.com>
 <20200819164306.625357-5-bauerman@linux.ibm.com>
 <3dd050ad-147e-c365-883a-3384130b0d2f@kaod.org>
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
Message-ID: <2fee9e37-f420-c0d0-dc57-c0ce273a1882@redhat.com>
Date: Sat, 22 Aug 2020 16:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3dd050ad-147e-c365-883a-3384130b0d2f@kaod.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 10:35:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Kurz <groug@kaod.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/20 10:59 AM, Cédric Le Goater wrote:
> Hello,
> 
> On 8/19/20 6:43 PM, Thiago Jung Bauermann wrote:
>> Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), use
>> the start-powered-off property which makes cpu_common_reset() initialize it
>> to 1 in common code.
>>
>> Also change creation of CPU object from cpu_create() to object_new() and
>> qdev_realize_and_unref() because cpu_create() realizes the CPU and it's not
>> possible to set a property after the object is realized.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> 
> This is breaking make check : 
> 
>     tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
>     ERROR boot-serial-test - too few tests run (expected 7, got 0)
>     make: *** [/home/legoater/work/qemu/qemu-powernv-5.2.git/tests/Makefile.include:650: check-qtest-ppc64] Error 1
>     make: *** Waiting for unfinished jobs....
>     
>     
>     gdb --args build/ppc64-softmmu/qemu-system-ppc64  -display none   -M ppce500
>     ...
>     Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
>     0x000055555596ebf2 in ppce500_init (machine=0x5555567aa6e0)
>         at /home/legoater/work/qemu/qemu-powernv-5.2.git/hw/ppc/e500.c:880
>     880	        irqs[i].irq[OPENPIC_OUTPUT_INT] = input[PPCE500_INPUT_INT];
>  
>     
>     AFAIUI, 'input is not initialized since the CPU is not yet realized.

Thiago, see ad938fc1d53 ("hw/arm/palm.c: Encapsulate misc GPIO handling
in a device") and eventually f8a865d36dc ("hw/arm/allwinner-a10:
Simplify by passing IRQs with qdev_pass_gpios") to get an idea how you
can fix that.

> 
>     C.
> 
>> ---
>>  hw/ppc/e500.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index ab9884e315..d7b803ef26 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -704,9 +704,6 @@ static void ppce500_cpu_reset_sec(void *opaque)
>>
>>      cpu_reset(cs);
>>
>> -    /* Secondary CPU starts in halted state for now. Needs to change when
>> -       implementing non-kernel boot. */
>> -    cs->halted = 1;
>>      cs->exception_index = EXCP_HLT;
>>  }
>>
>> @@ -865,7 +862,7 @@ void ppce500_init(MachineState *machine)
>>          CPUState *cs;
>>          qemu_irq *input;
>>
>> -        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
>> +        cpu = POWERPC_CPU(object_new(machine->cpu_type));
>>          env = &cpu->env;
>>          cs = CPU(cpu);
>>
>> @@ -897,7 +894,16 @@ void ppce500_init(MachineState *machine)
>>          } else {
>>              /* Secondary CPUs */
>>              qemu_register_reset(ppce500_cpu_reset_sec, cpu);
>> +
>> +            /*
>> +             * Secondary CPU starts in halted state for now. Needs to change
>> +             * when implementing non-kernel boot.
>> +             */
>> +            object_property_set_bool(OBJECT(cs), "start-powered-off", true,
>> +                                     &error_fatal);
>>          }
>> +
>> +        qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
>>      }
>>
>>      env = firstenv;
>>
> 


