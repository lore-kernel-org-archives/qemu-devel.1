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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C660CC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807782078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHzaxMYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807782078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnLh-0006vB-J8
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDnKU-0005Jc-Eg; Thu, 03 Sep 2020 07:22:58 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDnKS-0007gP-Bi; Thu, 03 Sep 2020 07:22:58 -0400
Received: by mail-qt1-x844.google.com with SMTP id b3so1526665qtg.13;
 Thu, 03 Sep 2020 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b/Qp+gbTch2LjzEZgzt4OKh0RPkd8640XPn5uDAqiiM=;
 b=GHzaxMYQVpN+YZaug2bZKbLXu0bxaGnkZdCatV2nDCgl5J3PCuVr3ZDxznvp0bkHfT
 fyoQQd1KZN9DssfcmoRuyvBP34hVSqzO+F7hCbeivsaMooxD5Ya34kT2w3x1oaYkKJkS
 wHNYNJ8s4IDAAaAhm8nJvjOV40wma7u3+aYzQwUDmJJgPGNTeRrlh8f6Qnyu4znWFfAn
 wSOt/UP9Fppdt9wHUWUvenY99uOtOC2U/gANMH9gR29aeg0MXBWyLdUnXXKvydqiu5o+
 UNYhWXjE//bN0ltjtD8BeJVAHnli1fyn+QaIQ+QjIhr/qLLGb8mz1tl03gBywp4Cbr3S
 FD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b/Qp+gbTch2LjzEZgzt4OKh0RPkd8640XPn5uDAqiiM=;
 b=HFhn4+B1DWfX+GPZ2KmtCNQp8K/08n4z534E46ckIFVfGOJgx4+xRSNogvAx/1rpR4
 KaDKl09D4dqgeNKG5F5KxIEQ4TVMg7T3d8hWaP7CTUyjSURKiyp7Z9Q5GClBjrhr2Ptn
 wKRGF5iuOmsosc4DZYY/G5cyHG3a+baBxNsCZv1SZ6dC1q4OPpLSjisSC5SOHazd5OBV
 9/7YAGLJEFeI7GmUjfcDjoyABCZd2WGivoJlUD+t8XDP72gbhwC8XwV0xmKl/kP9uJ/n
 ahDV5mUtzGtYMth78QIpD1k7HzDTin0qoTaF54/powIxtCA3pNxY3+U1aucoPFdq8QxY
 QyjA==
X-Gm-Message-State: AOAM532igIOJsHN3iEehixC0dCHyRPOkyU9E1M+8nK84AjhV05EwQ0WN
 jRLrrRGuzWbVnbyQLYLEQpKKwE6UZBA=
X-Google-Smtp-Source: ABdhPJw8mOsnj9ixMj6bbNef0XUwRnhtXGPKASfXy/G7B4QnCedu9ckjJyd6KUawRw4m+EJZcvDIig==
X-Received: by 2002:aed:3b7a:: with SMTP id q55mr2965553qte.78.1599132174569; 
 Thu, 03 Sep 2020 04:22:54 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca?
 ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id 192sm1865112qkm.110.2020.09.03.04.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 04:22:54 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] spapr, spapr_numa: move lookup-arrays handling to
 spapr_numa.c
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200901125645.118026-1-danielhb413@gmail.com>
 <20200901125645.118026-6-danielhb413@gmail.com>
 <20200903013430.GG1897@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <f34dd2cc-49ba-6118-715a-1acce48820fa@gmail.com>
Date: Thu, 3 Sep 2020 08:22:51 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903013430.GG1897@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x844.google.com
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



On 9/2/20 10:34 PM, David Gibson wrote:
> On Tue, Sep 01, 2020 at 09:56:43AM -0300, Daniel Henrique Barboza wrote:
>> In a similar fashion as the previous patch, let's move the
>> handling of ibm,associativity-lookup-arrays from spapr.c to
>> spapr_numa.c. A spapr_numa_write_assoc_lookup_arrays() helper was
>> created, and spapr_dt_dynamic_reconfiguration_memory() can now
>> use it to advertise the lookup-arrays.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/ppc/spapr.c              | 25 ++----------------------
>>   hw/ppc/spapr_numa.c         | 39 +++++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/spapr_numa.h |  2 ++
>>   3 files changed, 43 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 172f965fe0..65d2ccd578 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -535,13 +535,10 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
>>                                                      void *fdt)
>>   {
>>       MachineState *machine = MACHINE(spapr);
>> -    int nb_numa_nodes = machine->numa_state->num_nodes;
>> -    int ret, i, offset;
>> +    int ret, offset;
>>       uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
>>       uint32_t prop_lmb_size[] = {cpu_to_be32(lmb_size >> 32),
>>                                   cpu_to_be32(lmb_size & 0xffffffff)};
>> -    uint32_t *int_buf, *cur_index, buf_len;
>> -    int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
>>       MemoryDeviceInfoList *dimms = NULL;
>>   
>>       /*
>> @@ -582,25 +579,7 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
>>           return ret;
>>       }
>>   
>> -    /* ibm,associativity-lookup-arrays */
>> -    buf_len = (nr_nodes * 4 + 2) * sizeof(uint32_t);
>> -    cur_index = int_buf = g_malloc0(buf_len);
>> -    int_buf[0] = cpu_to_be32(nr_nodes);
>> -    int_buf[1] = cpu_to_be32(4); /* Number of entries per associativity list */
>> -    cur_index += 2;
>> -    for (i = 0; i < nr_nodes; i++) {
>> -        uint32_t associativity[] = {
>> -            cpu_to_be32(0x0),
>> -            cpu_to_be32(0x0),
>> -            cpu_to_be32(0x0),
>> -            cpu_to_be32(i)
>> -        };
>> -        memcpy(cur_index, associativity, sizeof(associativity));
>> -        cur_index += 4;
>> -    }
>> -    ret = fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", int_buf,
>> -            (cur_index - int_buf) * sizeof(uint32_t));
>> -    g_free(int_buf);
>> +    ret = spapr_numa_write_assoc_lookup_arrays(spapr, fdt, offset);
>>   
>>       return ret;
>>   }
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index b8882d209e..9eb4bdbe80 100644
>> --- a/hw/ppc/spapr_numa.c
>> +++ b/hw/ppc/spapr_numa.c
>> @@ -75,6 +75,45 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>>                          vcpu_assoc, sizeof(vcpu_assoc));
>>   }
>>   
>> +
>> +int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
>> +                                         int offset)
>> +{
>> +    MachineState *machine = MACHINE(spapr);
>> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>> +    int nb_numa_nodes = machine->numa_state->num_nodes;
>> +    int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
>> +    uint32_t *int_buf, *cur_index, buf_len;
>> +    int ret, i, j;
>> +
>> +    /* ibm,associativity-lookup-arrays */
>> +    buf_len = (nr_nodes * MAX_DISTANCE_REF_POINTS + 2) * sizeof(uint32_t);
>> +    cur_index = int_buf = g_malloc0(buf_len);
>> +    int_buf[0] = cpu_to_be32(nr_nodes);
>> +     /* Number of entries per associativity list */
>> +    int_buf[1] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
>> +    cur_index += 2;
>> +    for (i = 0; i < nr_nodes; i++) {
>> +        /*
>> +         * For the lookup-array we use the ibm,associativity array,
>> +         * from numa_assoc_array. without the first element (size).
>> +         */
>> +        uint32_t associativity[MAX_DISTANCE_REF_POINTS];
>> +
>> +        for (j = 0; j < MAX_DISTANCE_REF_POINTS; j++) {
>> +            associativity[j] = smc->numa_assoc_array[i][j + 1];
>> +        }
>> +
>> +        memcpy(cur_index, associativity, sizeof(associativity));
> 
> AFAICT, you could just use a single memcpy() to copy from the
> numa_assoc_array() into the property here, rather than using a loop
> and temporary array.

I remember that I was having some weird problems with memcpy() and
numa_assoc_array and this is how I got around it. I'll try to sort it
out again.

> 
>> +        cur_index += 4;
> 
> Shouldn't this be  += MAX_DISTANCE_REF_POINTS?


Yeah it should. Good catch.

> 
>> +    }
>> +    ret = fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", int_buf,
>> +                      (cur_index - int_buf) * sizeof(uint32_t));
>> +    g_free(int_buf);
>> +
>> +    return ret;
>> +}
>> +
>>   /*
>>    * Helper that writes ibm,associativity-reference-points and
>>    * max-associativity-domains in the RTAS pointed by @rtas
>> diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
>> index f92fb4f28a..f6127501a6 100644
>> --- a/include/hw/ppc/spapr_numa.h
>> +++ b/include/hw/ppc/spapr_numa.h
>> @@ -22,6 +22,8 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
>>                                          int offset, int nodeid);
>>   int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>>                               int offset, PowerPCCPU *cpu);
>> +int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
>> +                                         int offset);
>>   
>>   
>>   #endif /* HW_SPAPR_NUMA_H */
> 

