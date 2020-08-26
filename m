Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E906C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1520C20737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca5bfPY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1520C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB2xF-0008OS-BO
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kB2nZ-0001tJ-Ad; Wed, 26 Aug 2020 17:17:37 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:37121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kB2nX-0002yW-BN; Wed, 26 Aug 2020 17:17:37 -0400
Received: by mail-qk1-x742.google.com with SMTP id b14so3805081qkn.4;
 Wed, 26 Aug 2020 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RUSLX6L8biv4VKymPT/6xwTGpdMdk3HPdf9fCj/Ml8o=;
 b=ca5bfPY4/3rIZsSlMOlAMyKHu4thraKskekFnc74y/dQ+L/6GvE7//VbKy0DqPyBFW
 yvy2hTRtZ4C960hPqY0V/yKfN2GLaQDXn8gNcItbjTXMo3rbDzt5H0ExUC8ndhvP9h8i
 nUmU2dCHT81MJ0kN6uejllMz9dsD03IIXZ8IWTUaj+kDjwUQn4052FhrThrfmq+vnJ+t
 EaH+V+F0N+C9kq7O746GDhuBeFmIxmuotJHq05A+O3GgbKYCvmgWLtf1b9S3AO/sT+F1
 5dt4qfmTdlrQoiSCVgwi6OM7AoqO428JKrBUQW0EoArkiPjKPrcrl1m1QvbtbxcLPKR3
 XZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RUSLX6L8biv4VKymPT/6xwTGpdMdk3HPdf9fCj/Ml8o=;
 b=XMTTKXSCSQ5b9/kG/6oXZkGynvqcpwWt855PzBbpi+ZTknl1mDp/UzxO3PEZRxMFt7
 PkXiwUMVc4CH2Qrvuk7ovEuWqQr6/DaQfaagzNaylImslaPE36IGIGsDNbeD1Q+lqlCx
 SSr9YD4Us8En1ZLsXJgramDR0MYxUAuSmYibBexF7RSMYNO0VT6F/zuhKsIjaiXvsGVB
 xReLQFyz4DLt/5utGvY/vtQ/glYnHyKtpb+iE6Ig2FK44P4njiCaM7eyvfZjmdstD/O6
 kv9wbYCS2mZcfcR5UbKvB0eue6q9bNYn83AD6hGVeJ1bXYPzQlHxJC5bG7k03kb4TlZn
 mi5Q==
X-Gm-Message-State: AOAM532QptmVmspvzi2VJeC8g0Mh4yfw5ganUQ2g4LnAugxcjOLwDpHz
 cjZ2m/P+CTaHTtfhrww9SzdIc4RmhF0=
X-Google-Smtp-Source: ABdhPJwCVlnMoVL5W/BEb6LHmcn6SsRMT9BWELAfXK3TwXZfw1JRjJymcS0DVwknxvmgZcXkmoQzPA==
X-Received: by 2002:ae9:df85:: with SMTP id
 t127mr16548013qkf.265.1598476652637; 
 Wed, 26 Aug 2020 14:17:32 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c152:8180:e1dd:d6ac:1152?
 ([2804:431:c7c7:c152:8180:e1dd:d6ac:1152])
 by smtp.gmail.com with ESMTPSA id s5sm217142qks.16.2020.08.26.14.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 14:17:31 -0700 (PDT)
Subject: Re: [PATCH 05/10] spapr: make ibm,max-associativity-domains scale
 with user input
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-6-danielhb413@gmail.com>
 <20200820025543.GL271315@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <e057d212-e3bc-a21b-d3d4-86995b6b568e@gmail.com>
Date: Wed, 26 Aug 2020 18:17:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820025543.GL271315@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.239,
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



On 8/19/20 11:55 PM, David Gibson wrote:
> On Fri, Aug 14, 2020 at 05:54:19PM -0300, Daniel Henrique Barboza wrote:
>> The ibm,max-associativity-domains is considering that only a single
>> associativity domain can exist in the same NUMA level. This is true
>> today because we do not support any type of NUMA distance user
>> customization, and all nodes are in the same distance to each other.
>>
>> To enhance NUMA distance support in the pSeries machine we need to
>> make this limit flexible. This patch rewrites the max-associativity
>> logic to consider that multiple associativity domains can co-exist
>> in the same NUMA level. We're using the legacy_numa() helper to
>> avoid leaking unneeded guest changes.
> 
> 
> Hrm.  I find the above a bit hard to understand.  Having the limit be
> one less than the number of nodes at every level except the last seems
> kind of odd to me.

I took a bit to reply on this because I was reconsidering this logic.

I tried to "not be greedy" with this maximum number and ended up doing
something that breaks in a simple scenario. Today, in a single conf with
a single NUMA node with a single CPU, and say 2 GPUs, given that all GPUs
are in their own associativity domains, we would have something like:

cpu0: 0 0 0 0 0 0
gpu1: gpu_1 gpu_1 gpu_1 gpu_1
gpu2: gpu_2 gpu_2 gpu_2 gpu_2

This would already break apart what I did there. I think we should simplify
and just set maxdomains to be all nodes in all levels, like we do today
but using spapr->gpu_numa_id as an alias to maxnodes.


Thanks,

DHB

> 
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/ppc/spapr.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 073a59c47d..b0c4b80a23 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -919,13 +919,20 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>           cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
>>           cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
>>       };
>> -    uint32_t maxdomain = cpu_to_be32(spapr->extra_numa_nodes > 1 ? 1 : 0);
>> +
>> +    /* The maximum domains for a given NUMA level, supposing that every
>> +     * additional NUMA node belongs to the same domain (aside from the
>> +     * 4th level, where we must support all available NUMA domains), is
>> +     * total number of domains - 1. */
>> +    uint32_t total_nodes_number = ms->numa_state->num_nodes +
>> +                                  spapr->extra_numa_nodes;
>> +    uint32_t maxdomain = cpu_to_be32(total_nodes_number - 1);
>>       uint32_t maxdomains[] = {
>>           cpu_to_be32(4),
>>           maxdomain,
>>           maxdomain,
>>           maxdomain,
>> -        cpu_to_be32(ms->numa_state->num_nodes + spapr->extra_numa_nodes),
>> +        cpu_to_be32(total_nodes_number),
>>       };
>>   
>>       _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
>> @@ -962,6 +969,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>                        qemu_hypertas->str, qemu_hypertas->len));
>>       g_string_free(qemu_hypertas, TRUE);
>>   
>> +    if (spapr_machine_using_legacy_numa(spapr)) {
>> +        maxdomain = cpu_to_be32(spapr->extra_numa_nodes > 1 ? 1 : 0);
>> +        maxdomains[1] = maxdomain;
>> +        maxdomains[2] = maxdomain;
>> +        maxdomains[3] = maxdomain;
>> +    }
>> +
>>       if (smc->pre_5_1_assoc_refpoints) {
>>           nr_refpoints = 2;
>>       }
> 

