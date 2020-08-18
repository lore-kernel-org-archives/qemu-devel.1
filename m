Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF916C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6652063A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCfEINMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6652063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7w3w-00072Y-SJ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 03:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7w2v-000620-3n
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:28:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7w2s-0003Ca-W5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597735712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m+Eogft0eH/F8D94Ip+Yff4IYCR4r9fJNY7fS2qBA54=;
 b=JCfEINMcfUbExRZPcHEMCn7IvpDgtMdyHpqvh8hbsDlR9lbMYBTI/LYCwalQGU1397uXUV
 4TGxJ7SmPeVJZ6/Ywwbq1By5JBP0fxeJOvah72zfVgIjpfrj+6J8XdQiVYh/w83kEOU+7t
 xMiwME2FiOglJieUS6cfumQpZDitGzQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-rs9Auu2cOi-NZzqR0GWkrQ-1; Tue, 18 Aug 2020 03:28:28 -0400
X-MC-Unique: rs9Auu2cOi-NZzqR0GWkrQ-1
Received: by mail-wm1-f72.google.com with SMTP id h205so7059769wmf.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 00:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=m+Eogft0eH/F8D94Ip+Yff4IYCR4r9fJNY7fS2qBA54=;
 b=U6GWi2/tbPyqGKkJk3upjeoyCNMPHeNdecxlfs2eI3in1/+/C9sJYdrgLqJk9kV7Mw
 oWLpwC9R2kpzYYKXDPqFyVtjwoR/IFfzXGsu2VqvbzanFfvuF+WRd9wK5Qyv21kflLUc
 pJHR8Fl7OlttcG78zlqwExohHsI2SmudlrNbyfau2FfwcHPSXTtqSYKm0Elwqz6zRrud
 W30hLPj4+4PrOpqKa5ArqDdntUxAchEUc7mVm+TZhsGz3xL8Q3troOWY++k5eEX98tvv
 86XWZBAeq7q2aIvgoQYWVxzvSdxArFe4yJeFeMcTA6dgbKiVJSqC9RWtoemgYnSr+A2L
 1E0g==
X-Gm-Message-State: AOAM531igUnSUEpHhVB+cSo51H5LYPfPdaCvLUoeknxyoproq8NIij76
 4Sfz3wQcb7YqLycc4JvqIhThRTHGXSa7Meak7GxBnBYalPyBZB26RPWfx19oW9S9bE5zIlLZ48C
 pHfvhH+a6tcJVYxA=
X-Received: by 2002:a1c:4c:: with SMTP id 73mr17641552wma.58.1597735707403;
 Tue, 18 Aug 2020 00:28:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCrhN9psw+Cnlm2Z0QSAeOdgahiSdWmNiPRBCSCvSsveZKjv4pN8fQiCUeq0Egu+M/54v2dg==
X-Received: by 2002:a1c:4c:: with SMTP id 73mr17641520wma.58.1597735707202;
 Tue, 18 Aug 2020 00:28:27 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id q5sm32663260wrp.60.2020.08.18.00.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 00:28:26 -0700 (PDT)
Subject: Re: [PATCH v4 4/8] ppc/e500: Use start-powered-off CPUState property
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20200818033323.336912-1-bauerman@linux.ibm.com>
 <20200818033323.336912-5-bauerman@linux.ibm.com>
 <83c5045d-ee26-9433-46a3-4919bcea7cd3@redhat.com>
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
Message-ID: <65395b58-82d7-fd6b-ebc2-3fa7cb25d324@redhat.com>
Date: Tue, 18 Aug 2020 09:28:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <83c5045d-ee26-9433-46a3-4919bcea7cd3@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 9:22 AM, Philippe Mathieu-Daudé wrote:
> On 8/18/20 5:33 AM, Thiago Jung Bauermann wrote:
>> Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), use
>> the start-powered-off property which makes cpu_common_reset() initialize it
>> to 1 in common code.
>>
>> Also change creation of CPU object from cpu_create() to object_new() and
>> qdev_realize() because cpu_create() realizes the CPU and it's not possible
>> to set a property after the object is realized.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  hw/ppc/e500.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index ab9884e315..0077aca74d 100644
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
>> @@ -864,8 +861,9 @@ void ppce500_init(MachineState *machine)
>>          PowerPCCPU *cpu;
>>          CPUState *cs;
>>          qemu_irq *input;
>> +        Error *err = NULL;
>>  
>> -        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
>> +        cpu = POWERPC_CPU(object_new(machine->cpu_type));
>>          env = &cpu->env;
>>          cs = CPU(cpu);
>>  
>> @@ -897,6 +895,19 @@ void ppce500_init(MachineState *machine)
>>          } else {
>>              /* Secondary CPUs */
>>              qemu_register_reset(ppce500_cpu_reset_sec, cpu);
>> +
>> +            /*
>> +             * Secondary CPU starts in halted state for now. Needs to change
>> +             * when implementing non-kernel boot.
>> +             */
>> +            object_property_set_bool(OBJECT(cs), "start-powered-off", true,
>> +                                     &error_abort);
> 
> [*]
> 
>> +        }
>> +
>> +        if (!qdev_realize(DEVICE(cs), NULL, &err)) {
>> +            error_report_err(err);
>> +            object_unref(OBJECT(cs));
>> +            exit(EXIT_FAILURE);
>>          }
> 
> The last 4 lines are equivalent to:
> 
>            qdev_realize(DEVICE(cs), NULL, &error_fatal)) {

I meant:

             qdev_realize(DEVICE(cs), NULL, &error_fatal);

> 
> This is also the preferred form, as we can not propagate errors
> from the machine_init() handler.
> 
> Since you use &error_abort in [*], maybe you want to use it here too.
> 
>>      }
>>  
>>
> 


