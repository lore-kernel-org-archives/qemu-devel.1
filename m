Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759B7C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6A1206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndVZrY93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6A1206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE8pA-0002x0-AO
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 06:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE8oQ-00027b-L3; Fri, 04 Sep 2020 06:19:18 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:40341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE8oN-0003GN-SJ; Fri, 04 Sep 2020 06:19:18 -0400
Received: by mail-qk1-x742.google.com with SMTP id w16so5793250qkj.7;
 Fri, 04 Sep 2020 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UKRMYqXmQQevvRg/1ui67odNTSxd6o/9Cfk4AMCgLVs=;
 b=ndVZrY931pO/F/IUBhVKl5pNAPttjEw8MBV4qgx2d3lrkJu+2jBO/WLQXEW3hUKZEk
 spL5SujlW3w13wU27rQUhcmIq+y6ZbI8neQ2zdWs9z5Wn2YLztsin7TEB9Wyzmw8rchs
 Oypwzyzid1lSaY5lFiYAGWecrCvxGn2tnuhsJAz3IN8/wz1yhfGQIFoJQZkiBeH+4yIx
 ZBtl24GIDpc7HsVX7nzpV61a/oIQIvqv3hRFaiAj4RyMmFVKjUAlo26yzgPlg6PKYOqG
 tBE0/gCoeU1mzudJXmVdnKkX8LqWfB5V+wonRcQQaF7Kto3DzKT3dYysGGu4tc4D7Pln
 TgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UKRMYqXmQQevvRg/1ui67odNTSxd6o/9Cfk4AMCgLVs=;
 b=Eh22M4pT0LzLV1PViWokHE0Fckj3T9xCVSjUDMbVLT33oAJNVLALRIxkpFjj/c+0QR
 5TRn5dcO41a1bqiCTTewi3L2HewHkhqm7jErkOlAbCpyFsPLMYk033n0igfW5erEpqvR
 i0oZLy5A/2BYqu+WwKybX2vUhYOMc8SiXaJ1hPlDA88XI4I/DfBw9PK1mBXaxGK+aToo
 7AZz1fGkVLqLkRoN6fRtyjfGAXbewZ5tsEF3zGTwqpQ3xHci7Dn/tLPzKUlMYL+1SNSu
 A2SORGVbpRT0T/Ew2//IcaMUHCp1ZIgXYc355itBNATQsGu3hMm4p0EOuKkBlgNknZR4
 6/0g==
X-Gm-Message-State: AOAM531pOotBqGlAx9Fgn0JO53EIykfKi91rguolEjY2JA8TfMorLXcu
 9+oVIJvriOQYhRwnZs6/M8B9olDSSaE=
X-Google-Smtp-Source: ABdhPJyRfiV5pkS9PgkHd0NWurLbwbB9tDUr7qIAKSfM7GGNCFn/QkuVIdSFCeTwoOp6HmRlhY3Yww==
X-Received: by 2002:ae9:f209:: with SMTP id m9mr7055170qkg.301.1599214754442; 
 Fri, 04 Sep 2020 03:19:14 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca?
 ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id k185sm4103637qkd.94.2020.09.04.03.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 03:19:13 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] spapr_numa: create a vcpu associativity helper
To: Greg Kurz <groug@kaod.org>
References: <20200904010439.581957-1-danielhb413@gmail.com>
 <20200904010439.581957-3-danielhb413@gmail.com>
 <20200904120200.21cc9052@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <e08a161b-111e-16f1-c60d-ab067cd068ed@gmail.com>
Date: Fri, 4 Sep 2020 07:19:10 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904120200.21cc9052@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.403,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/4/20 7:02 AM, Greg Kurz wrote:
> On Thu,  3 Sep 2020 22:04:38 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> 
>> The work to be done in h_home_node_associativity() intersects
>> with what is already done in spapr_numa_fixup_cpu_dt(). This
>> patch creates a new helper, spapr_numa_get_vcpu_assoc(), to
>> be used for both spapr_numa_fixup_cpu_dt() and
>> h_home_node_associativity().
>>
>> While we're at it, use memcpy() instead of loop assignment
>> to created the returned array.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
> 
> Hi Daniel,
> 
> A few comments below.
> 
>>   hw/ppc/spapr_numa.c | 30 ++++++++++++++++++++----------
>>   1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index 368c1a494d..980a6488bf 100644
>> --- a/hw/ppc/spapr_numa.c
>> +++ b/hw/ppc/spapr_numa.c
>> @@ -71,13 +71,15 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
>>                         sizeof(spapr->numa_assoc_array[nodeid]))));
>>   }
>>   
>> -int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>> -                            int offset, PowerPCCPU *cpu)
>> +static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
>> +                                          PowerPCCPU *cpu,
>> +                                          uint *vcpu_assoc_size)
>>   {
>> -    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
>> -    uint32_t vcpu_assoc[vcpu_assoc_size];
>> +    uint32_t *vcpu_assoc = NULL;
> 
> You don't need to initialize this pointer since it is assigned a value
> unconditionally just below.
> 
>>       int index = spapr_get_vcpu_id(cpu);
>> -    int i;
>> +
>> +    *vcpu_assoc_size = (NUMA_ASSOC_SIZE + 1) * sizeof(uint32_t);
> 
> It's a bit weird to return something that is definitely a compile
> time constant by reference... What about introducing a macro ?
> 
> #define VCPU_NUMA_ASSOC_SIZE (NUMA_ASSOC_SIZE + 1)
> 
>> +    vcpu_assoc = g_malloc(*vcpu_assoc_size);
>>   
> 
>      vcpu_assoc = g_new(uint32_t, VCPU_NUMA_ASSOC_SIZE);
> 
>>       /*
>>        * VCPUs have an extra 'cpu_id' value in ibm,associativity
>> @@ -86,16 +88,24 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>>        * cpu_id last.
>>        */
>>       vcpu_assoc[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
>> +    memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id],
>> +           MAX_DISTANCE_REF_POINTS);
>> +    vcpu_assoc[MAX_DISTANCE_REF_POINTS + 1] = cpu_to_be32(index);
>>   
> 
>      memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id],
>             (VPCU_ASSOC_SIZE - 2) * sizeof(uint32_t));
>      vcpu_assoc[VCPU_ASSOC_SIZE - 1] = cpu_to_be32(index);
> 
> I personally find more clear than using MAX_DISTANCE_REF_POINTS in an array
> that was just allocated with NUMA_ASSOC_SIZE... one has to check spapr.h
> to see that NUMA_ASSOC_SIZE == MAX_DISTANCE_REF_POINTS + 1


That all makes sense to me. I'll introduce a VCPU_ASSOC_SIZE in spapr_numa.h
and use it when operating the associativity for vcpus, both in this patch
and also in patch 3.


Thanks,


DHB


> 
>> -    for (i = 1; i <= MAX_DISTANCE_REF_POINTS; i++) {
>> -        vcpu_assoc[i] = spapr->numa_assoc_array[cpu->node_id][i];
>> -    }
>> +    return vcpu_assoc;
>> +}
>> +
>> +int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>> +                            int offset, PowerPCCPU *cpu)
>> +{
>> +    g_autofree uint32_t *vcpu_assoc = NULL;
>> +    uint vcpu_assoc_size;
>>   
>> -    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
>> +    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, cpu, &vcpu_assoc_size);
>>   
>>       /* Advertise NUMA via ibm,associativity */
>>       return fdt_setprop(fdt, offset, "ibm,associativity",
>> -                       vcpu_assoc, sizeof(vcpu_assoc));
>> +                       vcpu_assoc, vcpu_assoc_size);
> 
>      return fdt_setprop(fdt, offset, "ibm,associativity",
>                         vcpu_assoc, VCPU_NUMA_ASSOC_SIZE * sizeof(uint32_t));
> 
>>   }
>>   
>>   
> 

