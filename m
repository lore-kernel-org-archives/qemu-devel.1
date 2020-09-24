Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB91EC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC2E2311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/f4n5qS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC2E2311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPUf-0007k5-7L
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLPLj-0004BY-TY; Thu, 24 Sep 2020 07:23:44 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:37765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLPLh-0004WO-FG; Thu, 24 Sep 2020 07:23:43 -0400
Received: by mail-qk1-x743.google.com with SMTP id 16so2857029qkf.4;
 Thu, 24 Sep 2020 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZW0Amdtus0PuLVY7U3dcrUU7eiue+aXgSdxhhLiZA2g=;
 b=Y/f4n5qSBGY4HIsFO7Bg/2wMn6srmQodt23hXUPLa+SAW4qbD/3wAgv/xp57Vq2WjX
 jxpOoK6q8tBiqjz3uU69D0xxKuopOKe6/uB+SW7ijzaPsgsCwKXSM1LyzrL+ofQg2PLr
 kuRugaTXI7Z1glE1tCg4HFctv42zJyqOB73k+KIXj8iu8JAYhwlUUeTL004UZ/VvpjNg
 Mde/s2ULGYt4DXxOd5592o9VU2QWoQEEfiQPhhyMaC1dCGo9DD+2isS/Opd9XkEX9vXR
 vkxCn0sSwlCPCe9caGSkszKgxIt4AJuj7qP7Lm7wU1BLOZMREHdmxHjsfCofOmezbPT/
 onNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZW0Amdtus0PuLVY7U3dcrUU7eiue+aXgSdxhhLiZA2g=;
 b=f3F+5Iq8JKpSKbBgQ1ZqmqfbzgX6eC2yfcNb6TjR7YmX4sAEtO6iLpeNj054cdttD2
 dC/YjqlBAT2CuSpnEMqh90ave3xEq+Qzbzz9XODqOo8DSv84DS5ijwCFwSvCGpvKPA8Q
 zKQ2ppQhLEWXHYfh06JtFp+HmYgR2wwBj4brl8GprVP3x+ln+i0/EpqHef869ychzJ2/
 8ReH9xOCbH6BlAm6Tacrl5ghJnEdphmg6Fxuqm740G/3engM39D8SskcyIsCKHSIxyhl
 cRosLmUaDul/7tPayx7DNCA8ZcIUojGRWf0vdwwquMlqyKXzDZqWuNLCup7k1ZUXTrMN
 +7+w==
X-Gm-Message-State: AOAM530x4VERDF3TWboDRMYxbOB9yAq69BRMAGdY2pAnQqUKdygroACa
 Om9WnrnFQeyw5u473ZsFl84=
X-Google-Smtp-Source: ABdhPJzocPiVfbQ8LngNIW5GfSzEirt9Fh5VOJzI0GyzBOasOs4jUx+Utr9PUE0PKV/pu6pF7T7LOg==
X-Received: by 2002:a05:620a:211b:: with SMTP id
 l27mr4037560qkl.56.1600946619295; 
 Thu, 24 Sep 2020 04:23:39 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c625:6c0e:4720:8228:5f68?
 ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id r21sm1957884qtj.80.2020.09.24.04.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 04:23:30 -0700 (PDT)
Subject: Re: [PATCH 2/6] spapr_numa: forbid asymmetrical NUMA setups
To: Greg Kurz <groug@kaod.org>
References: <20200923193458.203186-1-danielhb413@gmail.com>
 <20200923193458.203186-3-danielhb413@gmail.com>
 <20200924100106.45e49a84@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <d7521aa3-85db-b6b4-810e-ac8a3303003c@gmail.com>
Date: Thu, 24 Sep 2020 08:23:28 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924100106.45e49a84@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.214,
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



On 9/24/20 5:01 AM, Greg Kurz wrote:
> On Wed, 23 Sep 2020 16:34:54 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> 
>> The pSeries machine does not support asymmetrical NUMA
>> configurations. This doesn't make much of a different
>> since we're not using user input for pSeries NUMA setup,
>> but this will change in the next patches.
>>
>> To avoid breaking existing setups, gate this change by
>> checking for legacy NUMA support.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/ppc/spapr_numa.c | 34 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index 64fe567f5d..36aaa273ee 100644
>> --- a/hw/ppc/spapr_numa.c
>> +++ b/hw/ppc/spapr_numa.c
>> @@ -19,6 +19,24 @@
>>   /* Moved from hw/ppc/spapr_pci_nvlink2.c */
>>   #define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
>>   
>> +static bool spapr_numa_is_symmetrical(MachineState *ms)
>> +{
>> +    int src, dst;
>> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>> +
>> +    for (src = 0; src < nb_numa_nodes; src++) {
>> +        for (dst = src; dst < nb_numa_nodes; dst++) {
>> +            if (numa_info[src].distance[dst] !=
>> +                numa_info[dst].distance[src]) {
>> +                return false;
>> +            }
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>                                      MachineState *machine)
>>   {
>> @@ -61,6 +79,22 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>   
>>           spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
>>       }
>> +
>> +    /*
>> +     * Legacy NUMA guests (pseries-5.1 and order, or guests with only
> 
> s/order/older
> 
>> +     * 1 NUMA node) will not benefit from anything we're going to do
>> +     * after this point.
>> +     */
>> +    if (spapr_machine_using_legacy_numa(spapr)) {
>> +        return;
>> +    }
>> +
>> +    if (!spapr_numa_is_symmetrical(machine)) {
>> +        error_report("Asymmetrical NUMA topologies aren't supported "
>> +                     "in the pSeries machine");
>> +        exit(1);
> 
> Even if the code base is still heavily populated with exit(1), it seems
> that exit(EXIT_FAILURE) is preferred.
> 
> Anyway,
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>


Given that a new spin of this series is required, I'll change this to
exit(EXIT_FAILURE) there as well.


Thanks,


DHB

> 
>> +    }
>> +
>>   }
>>   
>>   void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
> 

