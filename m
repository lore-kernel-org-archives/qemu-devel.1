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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D182C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A157207CD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmD0XYoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A157207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB3JS-0001P4-84
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kB3IO-0000oB-ME; Wed, 26 Aug 2020 17:49:28 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:43200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kB3II-0006F1-7J; Wed, 26 Aug 2020 17:49:28 -0400
Received: by mail-qk1-x741.google.com with SMTP id o64so3898660qkb.10;
 Wed, 26 Aug 2020 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nNek0V222qYZZCJ/aR8HFQWUVMvdrAIVrf0z72F5G8s=;
 b=SmD0XYoqDdiBicF89ahqGFvrR9gNXOFxGM9JTS4uJ5y7TH2jRS5UYW0H9Q/GCZkU0e
 VVUjwve0+/Mxzf5qoBgutXxqeXEq51ZiYLaiURzDhWsYJZCe2/7DePIXKcorBPPQ9el4
 ez7Ziip8kR5cMa50WINtqUOVrsipagWRQK+gZKg0i3wQAzv8k+8IcHvmWiUs0Fhc2j4j
 WMv736JJUHlKBQ8/bDQ4jeglqPuMe+kBZh5H/l4Ms3MKUVxFEjg07b8U+FcCapZSSJD+
 X1XupblxRfNMIt2vmPLkaL8nI0+1xo2MwvSW3doj/3sEelvug/Ys39vFT/miV461AlJc
 B8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nNek0V222qYZZCJ/aR8HFQWUVMvdrAIVrf0z72F5G8s=;
 b=hvjiAvXLBisBw0Bzpo9MtFAFvbpgdFCjxIvXWpRjl5BCVJvwpKRqu9TKVyYQjmFYbT
 lmI5ufhgEftTgejVK4yz2elvCGURga1K3K1pPMsZmCd9jSkQ/S8rL50K/Lj5lMmw+V2j
 PCJAu0ClPmmiUnr2GyGcq2LnMl+vkPulkTT8+d72b3S3xp+lquAjkfEZSG+8GbfCGlx0
 E585YFxtKJ6O7H9tYxvHQPO/4/EfNGM5UvpcNpWAy9l69r7EbK5mFC3ra+G4N+NcqYCR
 dOa/1tEo6ETUk5hGVxjXnecxFA4MAYk7AmqswZwB/Kxk0GGEMugmERyWw7U+UxMyz+Vs
 6wRg==
X-Gm-Message-State: AOAM533HZS77zccaKUUEl4m/C3miJFj0s11RszOBQUIV2/IfpTCodRsD
 sif7CqL2+G1TN9D/DuEvp1ycwAGV+a0=
X-Google-Smtp-Source: ABdhPJyGHX7oKxYvYV9PE5klVEcW9M4LIPPecguMmb8JrepiLdFhSIAvrJ2iLVIErj/Bd1HhIjGx3g==
X-Received: by 2002:ae9:e80c:: with SMTP id a12mr9001964qkg.306.1598478560170; 
 Wed, 26 Aug 2020 14:49:20 -0700 (PDT)
Received: from [192.168.15.40] (201-43-216-181.dsl.telesp.net.br.
 [201.43.216.181])
 by smtp.gmail.com with ESMTPSA id t1sm259577qkt.119.2020.08.26.14.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 14:49:19 -0700 (PDT)
Subject: Re: [PATCH 03/10] spapr: robustify NVLink2 NUMA node logic
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-4-danielhb413@gmail.com>
 <20200820021425.GJ271315@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <6449954a-3107-763e-0fd9-6e2b082108f2@gmail.com>
Date: Wed, 26 Aug 2020 18:49:16 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820021425.GJ271315@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x741.google.com
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



On 8/19/20 11:14 PM, David Gibson wrote:
> On Fri, Aug 14, 2020 at 05:54:17PM -0300, Daniel Henrique Barboza wrote:
>> NVLink2 GPUs are allocated in their own NUMA node, at maximum
>> distance from every other resource in the board. The existing
>> logic makes some assumptions that don't scale well:
>>
>> - only NVLink2 GPUs will ever require such mechanism, meaning
>> that the GPU logic is tightly coupled with the NUMA setup of
>> the machine, via how ibm,max-associativity-domains is set.
>>
>> - the code is relying on the lack of support for sparse NUMA
>> nodes in QEMU. Eventually this support can be implemented, and
>> then the assumption that spapr->gpu_numa_id represents the total
>> of NUMA nodes plus all generated NUMA ids for the GPUs, which
>> relies on all QEMU NUMA nodes not being sparsed, has a good
>> potential for disaster.
>>
>> This patch aims to fix both assumptions by creating a generic
>> mechanism to get an available NUMA node, regardless of the
>> NUMA setup being sparse or not. The idea is to rename the existing
>> spapr->gpu_numa_id to spapr->current_numa_id and add a new
>> spapr->extra_numa_nodes attribute. They are used in a new function
>> called spapr_pci_get_available_numa_id(), that takes into account
>> that the NUMA conf can be sparsed or not, to retrieve an available
>> NUMA id for the caller. Each consecutive call of
>> spapr_pci_get_available_numa_id() will generate a new ID, up
>> to the limit of numa_state->num_nodes + spapr->extra_numa_nodes
>> exceeding MAX_NODES. This is a generic code being used only by
>> NVLink2 ATM, being available to be used in the future by any
>> other device.
>>
>> With this new function in place, we can decouple
>> ibm,max-associativity-domains logic from NVLink2 logic by
>> using the new spapr->extra_numa_nodes to define the maxdomains
>> of the forth NUMA level. Instead of defining it as gpu_numa_id,
>> use num_nodes + extra_numa_nodes. This also makes it resilient
>> to any future change in the support of sparse NUMA nodes.
>>
>> Despite all the code juggling, no functional change was made
>> because sparse NUMA nodes isn't a thing and we do not support
>> distinct NUMA distances via user input. Next patches will
>> change that.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/ppc/spapr.c              | 15 ++++++++++-----
>>   hw/ppc/spapr_pci.c          | 33 +++++++++++++++++++++++++++++++++
>>   hw/ppc/spapr_pci_nvlink2.c  | 10 ++++++----
>>   include/hw/pci-host/spapr.h |  2 ++
>>   include/hw/ppc/spapr.h      |  4 +++-
>>   5 files changed, 54 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 3b16edaf4c..22e78cfc84 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -910,13 +910,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>           cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
>>           cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
>>       };
>> -    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
>> +    uint32_t maxdomain = cpu_to_be32(spapr->extra_numa_nodes > 1 ? 1 : 0);
>>       uint32_t maxdomains[] = {
>>           cpu_to_be32(4),
>>           maxdomain,
>>           maxdomain,
>>           maxdomain,
>> -        cpu_to_be32(spapr->gpu_numa_id),
>> +        cpu_to_be32(ms->numa_state->num_nodes + spapr->extra_numa_nodes),
>>       };
>>   
>>       _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
>> @@ -2824,13 +2824,18 @@ static void spapr_machine_init(MachineState *machine)
>>       /*
>>        * NVLink2-connected GPU RAM needs to be placed on a separate NUMA node.
>>        * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() which is
>> -     * called from vPHB reset handler so we initialize the counter here.
>> +     * called from vPHB reset handler. We have code to generate an extra numa
>> +     * id to place the GPU via 'extra_numa_nodes' and 'current_numa_node', which
>> +     * are initialized here.
>> +     *
>>        * If no NUMA is configured from the QEMU side, we start from 1 as GPU RAM
>>        * must be equally distant from any other node.
>> -     * The final value of spapr->gpu_numa_id is going to be written to
>> +     *
>> +     * The extra NUMA node ids generated for GPU usage will be written to
>>        * max-associativity-domains in spapr_build_fdt().
>>        */
>> -    spapr->gpu_numa_id = MAX(1, machine->numa_state->num_nodes);
>> +    spapr->current_numa_id = 0;
>> +    spapr->extra_numa_nodes = 0;
>>   
>>       if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
>>           ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00, 0,
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index 0a418f1e67..09ac58fd7f 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -2492,3 +2492,36 @@ void spapr_pci_switch_vga(bool big_endian)
>>                              &big_endian);
>>       }
>>   }
>> +
>> +unsigned spapr_pci_get_available_numa_id(Error **errp)
>> +{
>> +    MachineState *machine = MACHINE(qdev_get_machine());
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(machine);
>> +    NodeInfo *numa_info = machine->numa_state->nodes;
>> +    unsigned i, start;
>> +
>> +    if (machine->numa_state->num_nodes + spapr->extra_numa_nodes >= MAX_NODES) {
>> +        error_setg(errp,
>> +                   "Unable to get an extra NUMA node beyond MAX_NODES = %d",
>> +                   MAX_NODES);
>> +        return spapr->current_numa_id;
>> +    }
>> +
>> +    if (spapr->extra_numa_nodes == 0) {
>> +        start = 0;
>> +    } else {
>> +        start = spapr->current_numa_id + 1;
>> +    }
>> +
>> +    for (i = start; i < MAX_NODES; i++) {
>> +        if (!numa_info[i].present) {
>> +            spapr->extra_numa_nodes++;
>> +            spapr->current_numa_id = i;
>> +            return i;
>> +        }
>> +    }
> 
> I think I see what you're trying to do, but this logic makes me a bit
> nervous.  I guess migration isn't really an issue for the GPUs, but as
> a general rule we want the NUMA ids for everything to be the same from
> boot to boot (assuming similar command line configuration).

I didn't change the existing logic of GPU node assignment, although I surely
added more complexity on top of it.

This patch, and some chunks of other patches as well, were heavy influenced by
my idea of attempting to contemplate sparse NUMA nodes. Right now QEMU does not
support it, but when it does, the GPU logic will hit us in the face pretty hard.
For example, I can create 2 NUMA nodes in the command line, ids 0 and 2. The GPU code
will consider that the next gpu_id is max_nodes + spapr->gpu_numa_id, so 2 + 0 = 2,
and suddenly the GPU is in node_id 2 with other stuff. There are other areas
where a sparse configuration, if not considered, will be a spectacular disaster.

All that said, and seeing the amount of immediate work that we can push forward
in this work, I'd be OK with dropping this sparse NUMA node support for now. I
can document in ppc-spapr-numa.rst the hotspots (well, some of them at least)
that will blow up when QEMU moves to sparse NUMA confs. I would drop this
patch entirely and simplify the rest of the code as well.


Thanks,


DHB


> 
> I think that's probably true here, but the rules are complex enough
> that it's hard to convince myself there isn't some edge case where
> something that doesn't seem relevant could change the numa nodes the
> gpus end up with.
> 
>> +
>> +    error_setg(errp, "Unable to find a valid NUMA id");
>> +
>> +    return spapr->current_numa_id;
>> +}
>> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
>> index 76ae77ebc8..611c8a2957 100644
>> --- a/hw/ppc/spapr_pci_nvlink2.c
>> +++ b/hw/ppc/spapr_pci_nvlink2.c
>> @@ -87,9 +87,8 @@ static void spapr_pci_collect_nvgpu(SpaprPhbPciNvGpuConfig *nvgpus,
>>                                       PCIDevice *pdev, uint64_t tgt,
>>                                       MemoryRegion *mr, Error **errp)
>>   {
>> -    MachineState *machine = MACHINE(qdev_get_machine());
>> -    SpaprMachineState *spapr = SPAPR_MACHINE(machine);
>>       SpaprPhbPciNvGpuSlot *nvslot = spapr_nvgpu_get_slot(nvgpus, tgt);
>> +    Error *local_err = NULL;
>>   
>>       if (!nvslot) {
>>           error_setg(errp, "Found too many GPUs per vPHB");
>> @@ -100,8 +99,11 @@ static void spapr_pci_collect_nvgpu(SpaprPhbPciNvGpuConfig *nvgpus,
>>   
>>       nvslot->gpa = nvgpus->nv2_ram_current;
>>       nvgpus->nv2_ram_current += memory_region_size(mr);
>> -    nvslot->numa_id = spapr->gpu_numa_id;
>> -    ++spapr->gpu_numa_id;
>> +
>> +    nvslot->numa_id = spapr_pci_get_available_numa_id(&local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +    }
>>   }
>>   
>>   static void spapr_pci_collect_nvnpu(SpaprPhbPciNvGpuConfig *nvgpus,
>> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
>> index 600eb55c34..8d93223a76 100644
>> --- a/include/hw/pci-host/spapr.h
>> +++ b/include/hw/pci-host/spapr.h
>> @@ -129,6 +129,8 @@ struct SpaprPhbState {
>>   #define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS * \
>>                                         64 * KiB)
>>   
>> +unsigned spapr_pci_get_available_numa_id(Error **errp);
>> +
>>   int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
>>                    uint32_t intc_phandle, void *fdt, int *node_offset);
>>   
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 3134d339e8..739a6a4942 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -227,7 +227,9 @@ struct SpaprMachineState {
>>       bool cmd_line_caps[SPAPR_CAP_NUM];
>>       SpaprCapabilities def, eff, mig;
>>   
>> -    unsigned gpu_numa_id;
>> +    unsigned current_numa_id;
> 
> The nane "current_numa_id" is a bit unclear.  AFAICT this is used
> specifically for the GPU "extra" numa nodes, which isn't obvious from
> the name.
> 
>> +    unsigned extra_numa_nodes;
>> +
>>       SpaprTpmProxy *tpm_proxy;
>>   
>>       Error *fwnmi_migration_blocker;
> 

