Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63309C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A49206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIhpjMXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A49206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDq73-00032M-3y
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 10:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDq64-0002NB-25; Thu, 03 Sep 2020 10:20:16 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:42432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDq61-0006Xx-U1; Thu, 03 Sep 2020 10:20:15 -0400
Received: by mail-qv1-xf44.google.com with SMTP id h1so1367971qvo.9;
 Thu, 03 Sep 2020 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EL387opXsbxjQQWX54Vru1qGfL4aj0+Ej5NNFBYQ5QI=;
 b=gIhpjMXCa1Oytq6IuBP0T0VH3qm05joQhSg5ZLGg72llvVdFUTO3VjzcRuR3H6P/dU
 KnNUoG9YOhJoUj2KQKyRhfYzb0mlOGZw9gJ5VqKFFk5STgNIja8iMzoXbMxaSuF0pYbL
 WSdm3SXTRMyuGle5K2KqASO/mdVjaz7zOGjNzgRonh6njyziaf9o5B4lZbhWrfU2is1Q
 rumU1vBEcG3oCxhBuJqg4ZCBlPQ30mj6BXl0qLXb1uAmORhrrh29rJHImN3Wt8AWGcvj
 EUznEitxM0ScOCynkmku+BuYw+wn/7Gdzqc7Ok7708+Py94GoUWgC4jiYys+Ypfozrh6
 7irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EL387opXsbxjQQWX54Vru1qGfL4aj0+Ej5NNFBYQ5QI=;
 b=MqemQ5wJe9UnG516+DEKnqyM9aVC88oSg1B+ZOOUMCZ+fQquxnVMt0w1FZTzNhgZ2P
 o4ycTfFQrlDIasoaWmUGFhhw8W3JnjUWV20Rq3dvTYviwKZuYJc+72CGLl8dRGt1AUfF
 sbIqtiSrG//lNZoaQd9IlMASrG6pBihZVq8X/nNLTGhF1pXOrWw1phj9FwDnTL4MApe9
 /WYrOwBL3HvD7+wDzNcuWXuSMxA3I8JAsBhsARjEKy+YsUZOUfCD3XjTj76soJHik8xh
 5tmTZE4njU+PFlxF2Vg7dykxmxwWjm+qQpACw7HOwRv3ky1z0VJNSAZH5mMfKj1CajtV
 4qhw==
X-Gm-Message-State: AOAM533DcA7e/3teSZyLyipkKHXifhUa0dSENBh+6wC8PxHVdxBVIQUR
 HFSRMELeRpK3wznDxVgXi53a0Z7o208=
X-Google-Smtp-Source: ABdhPJy0Ju2dnQNU3I1VWPRgRspfVVIPiaI0ZyqV65TqZm80Or7HKeeAuUb7gcGLgJfu6+53pL35CQ==
X-Received: by 2002:a0c:eac5:: with SMTP id y5mr2149785qvp.2.1599142811706;
 Thu, 03 Sep 2020 07:20:11 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca?
 ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id e13sm2061717qtr.85.2020.09.03.07.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 07:20:10 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] spapr_numa: move NVLink2 associativity handling to
 spapr_numa.c
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200901125645.118026-1-danielhb413@gmail.com>
 <20200901125645.118026-7-danielhb413@gmail.com>
 <20200903015632.GL1897@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <606dd354-5c95-9112-1c0f-919e142c9df8@gmail.com>
Date: Thu, 3 Sep 2020 11:20:08 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903015632.GL1897@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf44.google.com
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



On 9/2/20 10:56 PM, David Gibson wrote:
> On Tue, Sep 01, 2020 at 09:56:44AM -0300, Daniel Henrique Barboza wrote:
>> This patch adds a new spapr_numa_write_assoc_nvlink2() helper
>> to handle the ibm,associativity for NVLink2 GPUs.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> It might be nice to "precompute" the assoc arrays for the gpus as you
> now do for the regular numa nodes.  That can be a later revision, though.

Hmm ... I have the follow-up series with the NUMA calculation ready, and
one of the steps I had to take there was to initiate all the associativity
arrays with 'node_id' instead of leaving unintialized (reason: the kernel
make associativity matches with zeroes). In the end I'm initializing every
numa node as we do with GPUs.

I'll bring some of this future code to this series and handle GPUs like
a regular numa node as you suggested. Let's see how it goes.



Thanks,

DHB

> 
>> ---
>>   hw/ppc/spapr_numa.c         | 23 +++++++++++++++++++++++
>>   hw/ppc/spapr_pci_nvlink2.c  | 19 ++-----------------
>>   include/hw/ppc/spapr_numa.h |  3 +++
>>   3 files changed, 28 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index 9eb4bdbe80..785cc24624 100644
>> --- a/hw/ppc/spapr_numa.c
>> +++ b/hw/ppc/spapr_numa.c
>> @@ -15,6 +15,8 @@
>>   #include "hw/ppc/spapr_numa.h"
>>   #include "hw/ppc/fdt.h"
>>   
>> +/* Moved from hw/ppc/spapr_pci_nvlink2.c */
>> +#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
>>   
>>   void spapr_numa_associativity_init(MachineState *machine)
>>   {
>> @@ -114,6 +116,27 @@ int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
>>       return ret;
>>   }
>>   
>> +void spapr_numa_write_assoc_nvlink2(void *fdt, int offset, int numa_id,
>> +                                    SpaprPhbState *sphb)
>> +{
>> +    uint32_t associativity[NUMA_ASSOC_SIZE];
>> +    int i;
>> +
>> +    associativity[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
>> +    for (i = 1; i < NUMA_ASSOC_SIZE; i++) {
>> +        associativity[i] = cpu_to_be32(numa_id);
>> +    };
>> +
>> +    if (sphb->pre_5_1_assoc) {
>> +        associativity[1] = SPAPR_GPU_NUMA_ID;
>> +        associativity[2] = SPAPR_GPU_NUMA_ID;
>> +        associativity[3] = SPAPR_GPU_NUMA_ID;
>> +    }
>> +
>> +    _FDT((fdt_setprop(fdt, offset, "ibm,associativity", associativity,
>> +                      sizeof(associativity))));
>> +}
>> +
>>   /*
>>    * Helper that writes ibm,associativity-reference-points and
>>    * max-associativity-domains in the RTAS pointed by @rtas
>> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
>> index 76ae77ebc8..662a0af990 100644
>> --- a/hw/ppc/spapr_pci_nvlink2.c
>> +++ b/hw/ppc/spapr_pci_nvlink2.c
>> @@ -29,6 +29,7 @@
>>   #include "qemu/error-report.h"
>>   #include "hw/ppc/fdt.h"
>>   #include "hw/pci/pci_bridge.h"
>> +#include "hw/ppc/spapr_numa.h"
>>   
>>   #define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
>>                                        (((phb)->index) << 16) | ((pdev)->devfn))
>> @@ -37,8 +38,6 @@
>>   #define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8) | \
>>                                        ((gn) << 4) | (nn))
>>   
>> -#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
>> -
>>   typedef struct SpaprPhbPciNvGpuSlot {
>>           uint64_t tgt;
>>           uint64_t gpa;
>> @@ -360,13 +359,6 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
>>           Object *nv_mrobj = object_property_get_link(OBJECT(nvslot->gpdev),
>>                                                       "nvlink2-mr[0]",
>>                                                       &error_abort);
>> -        uint32_t associativity[] = {
>> -            cpu_to_be32(0x4),
>> -            cpu_to_be32(nvslot->numa_id),
>> -            cpu_to_be32(nvslot->numa_id),
>> -            cpu_to_be32(nvslot->numa_id),
>> -            cpu_to_be32(nvslot->numa_id)
>> -        };
>>           uint64_t size = object_property_get_uint(nv_mrobj, "size", NULL);
>>           uint64_t mem_reg[2] = { cpu_to_be64(nvslot->gpa), cpu_to_be64(size) };
>>           char *mem_name = g_strdup_printf("memory@%"PRIx64, nvslot->gpa);
>> @@ -376,14 +368,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
>>           _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
>>           _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
>>   
>> -        if (sphb->pre_5_1_assoc) {
>> -            associativity[1] = SPAPR_GPU_NUMA_ID;
>> -            associativity[2] = SPAPR_GPU_NUMA_ID;
>> -            associativity[3] = SPAPR_GPU_NUMA_ID;
>> -        }
>> -
>> -        _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
>> -                          sizeof(associativity))));
>> +        spapr_numa_write_assoc_nvlink2(fdt, off, nvslot->numa_id, sphb);
>>   
>>           _FDT((fdt_setprop_string(fdt, off, "compatible",
>>                                    "ibm,coherent-device-memory")));
>> diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
>> index f6127501a6..b6e0721b07 100644
>> --- a/include/hw/ppc/spapr_numa.h
>> +++ b/include/hw/ppc/spapr_numa.h
>> @@ -15,6 +15,7 @@
>>   
>>   #include "hw/boards.h"
>>   #include "hw/ppc/spapr.h"
>> +#include "hw/pci-host/spapr.h"
>>   
>>   void spapr_numa_associativity_init(MachineState *machine);
>>   void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas);
>> @@ -24,6 +25,8 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>>                               int offset, PowerPCCPU *cpu);
>>   int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
>>                                            int offset);
>> +void spapr_numa_write_assoc_nvlink2(void *fdt, int offset, int numa_id,
>> +                                    SpaprPhbState *sphb);
>>   
>>   
>>   #endif /* HW_SPAPR_NUMA_H */
> 

