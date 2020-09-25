Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D40EC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FC920BED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agYFxTjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FC920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLn60-0001p5-FG
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLn2D-00056u-DM; Fri, 25 Sep 2020 08:41:10 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:36725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLn2A-0008KN-FZ; Fri, 25 Sep 2020 08:41:09 -0400
Received: by mail-qv1-xf42.google.com with SMTP id f11so1233235qvw.3;
 Fri, 25 Sep 2020 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r2I0xvUUMJVD4WDyMshDfJjhLibFVhonZCVK7m16xEo=;
 b=agYFxTjnYGFQloWfNhoq8C+PauDCTJrxpApyAxqZj39ukGZrxFAUN27LHmCC80Yk/4
 OWQzSKxGQbjEJBvT/zQHHW6mYhoye8Xby/v/zt8dFFoh9hJr9/+LkSIBcx6RuuJGL55T
 jlGyew6/+k5T03cNa5Zi1T2jPWRnBfnysM5QChAZkjXSq9pZkYYF7FJl7xBj0cYw0pqz
 5fUkLtJlP0wahTiO6De+YVDX9nQOBqjwH/Nm+JpsVE11+qSJS+CgM+QumCM7Sy7FwM+A
 Do/gLtGF0fpk5ov5s4HNCsY3Z1mkM7JRk5QR81yukcZoYjSmk6LNJb4MXV9ZboCgy2BH
 AXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r2I0xvUUMJVD4WDyMshDfJjhLibFVhonZCVK7m16xEo=;
 b=rGIrDpirZZpkPB9GVle6YaFCvYRdO96c7DdtjxEqfot7wH8EeCOxlBTTGApxxcXz/c
 PXpUy0TbyOSR4xjr80+THgbtbXJCjyFROu6uXot//WIw7SXHSOD5nwAmaVgPpQeYzX0a
 qXzAti1YX2zr0sl/ehmqle+ukJTpiWQbrQifACPRxOJFXvfHD/A9LJ+LKHwWO26nTzMI
 MQE4n0npge2jI8Ry3VaHAs2MuvnO9Bc1tr8PT77aJ+QZ7vIw79WFZve82X6tVCHQngBP
 CktZBVM1ZtLEb8weulqvMNuJWL/ILj4Upvdsq9ala8v7D8fgPn1ggMWYRTh+mjik/Q9c
 NwKA==
X-Gm-Message-State: AOAM533x2N5kuJxeUGSuEvkw9nL3+mQQpTzNKb+RnIqE/l8rUdlvA2oK
 3g3hj5S9zKZmvGbJrIHVC/swqc0yfWQ=
X-Google-Smtp-Source: ABdhPJzYeZ97QBukBm3wgJhZM+owwa83AqexXZKQaQcm1f0DAgI2OJzXlJoPmPvDHvHuL6TLO9zlwQ==
X-Received: by 2002:a0c:bd02:: with SMTP id m2mr4368814qvg.0.1601037664996;
 Fri, 25 Sep 2020 05:41:04 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c625:6c0e:4720:8228:5f68?
 ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id p192sm1680858qke.7.2020.09.25.05.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 05:41:04 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] spapr_numa: forbid asymmetrical NUMA setups
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-3-danielhb413@gmail.com>
 <20200925034816.GV2298@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <f787466e-0f39-fb2e-c36f-59a6bc2dde00@gmail.com>
Date: Fri, 25 Sep 2020 09:41:02 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925034816.GV2298@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.238,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/25/20 12:48 AM, David Gibson wrote:
> On Thu, Sep 24, 2020 at 04:50:54PM -0300, Daniel Henrique Barboza wrote:
>> The pSeries machine does not support asymmetrical NUMA
>> configurations. This doesn't make much of a different
>> since we're not using user input for pSeries NUMA setup,
>> but this will change in the next patches.
>>
>> To avoid breaking existing setups, gate this change by
>> checking for legacy NUMA support.
>>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> 
> Having read the rest of the series, I realized there's another type of
> configuration that PAPR can't represent, so possibly we should add
> logic to catch that as well.  That's what I'm going to call
> "non-transitive" configurations, e.g.
> 
> Node	0	1	2
> 0	10	20	40
> 1	20	10	20
> 2	40	20	10	
> 
> Basically the closeness of 0 to 1 and 1 to 2 forces them all to be in
> the same domain at every PAPR level, even though 0-2 is supposed to be
> more expensive.


Yes, this is correct. I'm not sure how to proceed in this case
though. Should we error out?


DHB

> 
>> ---
>>   hw/ppc/spapr_numa.c | 34 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index 64fe567f5d..fe395e80a3 100644
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
>> +     * Legacy NUMA guests (pseries-5.1 and older, or guests with only
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
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>>   }
>>   
>>   void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
> 

