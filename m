Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED245C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8F72078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgvrmlHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8F72078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnGH-00082h-Ly
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDnFV-0006TX-BV; Thu, 03 Sep 2020 07:17:49 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:42381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDnFT-00077Y-AN; Thu, 03 Sep 2020 07:17:48 -0400
Received: by mail-qt1-x842.google.com with SMTP id 60so1538323qtc.9;
 Thu, 03 Sep 2020 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RYvM7/VVud8H9oX0U9lZ+9pQSsp09l2mWS7au7zulzg=;
 b=FgvrmlHmw/8YFE36GY2Tnd4acgewgh3Xk+0nEow4wRjDymhGZQMwuDQBSxf6R+jWnU
 8Ulsx1Zj1808oUYnQv7H1ID3oOjzOadTWJZWpy8l8ubBhz4zOg9eWYnrG54wV+nag2VF
 i8qklHtWqGdS3kzaSqunEi0/+aEYYT2LA2AB+hsMyGKOAbsGxgSu3y+NsvJWc8ePXR/B
 qDD0TOWlzYfQR+HXYqA36Z5Cf4j4wnN34zGuHKUNQ3D1OlzczdFbpcA4aRiJRUUHwMoO
 2NX2T/Ai2zRph0FEHM2hJM5qYEqZ2oPL4R27qd6ndBdMY9a78Ez/FMPZdqUVsWSg3UWt
 Fpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RYvM7/VVud8H9oX0U9lZ+9pQSsp09l2mWS7au7zulzg=;
 b=VL2+R9e6j9UaFYU80gRn5MLKhPkOnQJhnzx4ymdbcI9P9hxW2o5uI5wBuNMPBoIkX/
 UPfX4acOpSd5BB+OGhXL+tOUhzK/DOqk8qTw6tyGbHeFGHiHpvubUxCXRo/wZASuO+nT
 Tvl2m5pNa9CHsrFP94Z98L6gyudRBBSm+0XJXb0lhaftVgZglBKwgJaUgMtsvoBT5qQW
 1hiQ1cMvKReM5ZI4D1nY+o8xKzy1E/T89ngaEJIvqOHIyWfoEkUEsIWQsmj9mkAjyjBx
 qpbVAe5XXo80LSNIAjuehj6sia7KoG0LooFZjpx6mQVAkCWagKC2vAT/BODK2yLDeRYn
 9/Bw==
X-Gm-Message-State: AOAM531EGDfuGyoiCcLCuVknC2q/UI+qVpecEW25HotbNDusfYV8ezlj
 ZxeFuXZyTaOru13iIx95sEfEaZW1Hps=
X-Google-Smtp-Source: ABdhPJytSOFeu7iF4g+OpQLPjC6XlfFEMQc/55rWlQFb+wnfREvZoKN5flFxDmld8S2nnWKOw7GjRA==
X-Received: by 2002:aed:3a27:: with SMTP id n36mr2804129qte.215.1599131865217; 
 Thu, 03 Sep 2020 04:17:45 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca?
 ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id p68sm1999578qka.78.2020.09.03.04.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 04:17:44 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] spapr_hcall: h_home_node_associativity now reads
 numa_assoc_array
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200901125645.118026-1-danielhb413@gmail.com>
 <20200901125645.118026-8-danielhb413@gmail.com>
 <20200903014645.GI1897@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <4d90d8e3-6787-ecaa-2e19-3178ed4b0d97@gmail.com>
Date: Thu, 3 Sep 2020 08:17:40 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903014645.GI1897@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x842.google.com
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/2/20 10:46 PM, David Gibson wrote:
> On Tue, Sep 01, 2020 at 09:56:45AM -0300, Daniel Henrique Barboza wrote:
>> home_node_associativity reply now uses the associativity
>> values for tcpu->node_id provided by numa_assoc_array.
>>
>> This will avoid further changes in this code when numa_assoc_array
>> changes values, but it won't be enough to prevent further changes
>> if (falar aqui q se mudar o tamanho do array tem q mexer nessa
>> funcao tambem, falar q a macro associativity() deixa a automacao
>> de tudo mto unreadable)
> 
> Uh.. I'm guessing that was a note to yourself you intended to
> translate before publishing?

Ops! Forgot to edit it :|

> 
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/ppc/spapr_hcall.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index c1d01228c6..2ec30efdcb 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1878,9 +1878,13 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
>>                                                 target_ulong opcode,
>>                                                 target_ulong *args)
> 
> You could move this function to spapr_numa.c as well (the name's a bit
> misleading, but spapr_hcall.c isn't really intended to hold *all*
> hcall implementations, just the ones that don't have somewhere better
> to live).

Ok!


> 
>>   {
>> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>>       target_ulong flags = args[0];
>>       target_ulong procno = args[1];
>>       PowerPCCPU *tcpu;
>> +    uint32_t assoc_domain1;
>> +    uint32_t assoc_domain2;
>> +    uint32_t assoc_domain3;
>>       int idx;
>>   
>>       /* only support procno from H_REGISTER_VPA */
>> @@ -1893,13 +1897,21 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
>>           return H_P2;
>>       }
>>   
>> +    /*
>> +     * Index 0 is the ibm,associativity size of the node,
>> +     * which isn't relevant here.
>> +     */
>> +    assoc_domain1 = smc->numa_assoc_array[tcpu->node_id][1];
>> +    assoc_domain2 = smc->numa_assoc_array[tcpu->node_id][2];
>> +    assoc_domain3 = smc->numa_assoc_array[tcpu->node_id][3];
> 
> Using all these temporaries is a little ugly.  Maybe do something like:
> 	uint32_t *assoc = smc->numa_assoc_array[tcpu->node_id];
> 
> Then just use assoc[1], assoc[2] etc. below.
> 
>> +
>>       /* sequence is the same as in the "ibm,associativity" property */
>>   
>>       idx = 0;
>>   #define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
>>                                ((uint64_t)(b) & 0xffffffff))
>> -    args[idx++] = ASSOCIATIVITY(0, 0);
>> -    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
>> +    args[idx++] = ASSOCIATIVITY(assoc_domain1, assoc_domain2);
>> +    args[idx++] = ASSOCIATIVITY(assoc_domain3, tcpu->node_id);
>>       args[idx++] = ASSOCIATIVITY(procno, -1);
>>       for ( ; idx < 6; idx++) {
>>           args[idx] = -1;
> 
> Better yet would be to make this handle an arbitrary length of assoc
> array, further isolating this from the specifics of how we construct
> the arrays.  Ideally, you'd call a common path with
> spapr_numa_fixup_cpu_dt() to get the assoc array for a cpu, then here
> just translate it into the in-register format the hcall expects.


Since we're moving this to spapr_numa.c then I guess it's ok to add
more juggling to handle an arbitrary size. I got a bit nervous about
adding too much stuff here in spapr_hcall.c.


Thanks,


DHB

> 

