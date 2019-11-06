Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5FEC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6CD217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6CD217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJCA-0006al-Gd
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1iSJAH-0005Jr-Gn
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1iSJAF-0001KQ-GQ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:07:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1iSJAF-0001IC-AC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:07:51 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA6B4U7v082521
 for <qemu-devel@nongnu.org>; Wed, 6 Nov 2019 06:07:46 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3csxux18-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:07:43 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Wed, 6 Nov 2019 11:07:10 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 6 Nov 2019 11:07:07 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA6B76N325428112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Nov 2019 11:07:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C38D911C04C;
 Wed,  6 Nov 2019 11:07:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6012611C04A;
 Wed,  6 Nov 2019 11:07:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.97])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  6 Nov 2019 11:07:05 +0000 (GMT)
Subject: Re: [PATCH v17 4/7] target/ppc: Build rtas error log upon an MCE
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
 <20191024074307.22821-5-ganeshgr@linux.ibm.com>
 <20191104161054.GH3552@umbus.metropole.lan>
From: Ganesh <ganeshgr@linux.ibm.com>
Date: Wed, 6 Nov 2019 16:37:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20191104161054.GH3552@umbus.metropole.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19110611-0028-0000-0000-000003B32BF0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110611-0029-0000-0000-00002475875D
Message-Id: <e095aac0-949e-6f5e-ecac-bcc25802a8c5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-06_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911060114
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: arawinda.p@gmail.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/4/19 9:40 PM, David Gibson wrote:
> On Thu, Oct 24, 2019 at 01:13:04PM +0530, Ganesh Goudar wrote:
>> From: Aravinda Prasad <arawinda.p@gmail.com>
>>
>> Upon a machine check exception (MCE) in a guest address space,
>> KVM causes a guest exit to enable QEMU to build and pass the
>> error to the guest in the PAPR defined rtas error log format.
>>
>> This patch builds the rtas error log, copies it to the rtas_addr
>> and then invokes the guest registered machine check handler. The
>> handler in the guest takes suitable action(s) depending on the type
>> and criticality of the error. For example, if an error is
>> unrecoverable memory corruption in an application inside the
>> guest, then the guest kernel sends a SIGBUS to the application.
>> For recoverable errors, the guest performs recovery actions and
>> logs the error.
>>
>> [Assume SLOF has allocated enough room for rtas error log]
> Is that correct with the SLOF image currently included in qemu?
Yes
>
> Apart from that detail,
>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
>> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
>> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
>
>
>> ---
>>   hw/ppc/spapr_events.c  | 220 ++++++++++++++++++++++++++++++++++++++++-
>>   hw/ppc/spapr_rtas.c    |  26 +++++
>>   include/hw/ppc/spapr.h |   6 +-
>>   target/ppc/kvm.c       |   4 +-
>>   4 files changed, 253 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index 0ce96b86be..db44e09154 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -214,6 +214,104 @@ struct hp_extended_log {
>>       struct rtas_event_log_v6_hp hp;
>>   } QEMU_PACKED;
>>   
>> +struct rtas_event_log_v6_mc {
>> +#define RTAS_LOG_V6_SECTION_ID_MC                   0x4D43 /* MC */
>> +    struct rtas_event_log_v6_section_header hdr;
>> +    uint32_t fru_id;
>> +    uint32_t proc_id;
>> +    uint8_t error_type;
>> +#define RTAS_LOG_V6_MC_TYPE_UE                           0
>> +#define RTAS_LOG_V6_MC_TYPE_SLB                          1
>> +#define RTAS_LOG_V6_MC_TYPE_ERAT                         2
>> +#define RTAS_LOG_V6_MC_TYPE_TLB                          4
>> +#define RTAS_LOG_V6_MC_TYPE_D_CACHE                      5
>> +#define RTAS_LOG_V6_MC_TYPE_I_CACHE                      7
>> +    uint8_t sub_err_type;
>> +#define RTAS_LOG_V6_MC_UE_INDETERMINATE                  0
>> +#define RTAS_LOG_V6_MC_UE_IFETCH                         1
>> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH         2
>> +#define RTAS_LOG_V6_MC_UE_LOAD_STORE                     3
>> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE     4
>> +#define RTAS_LOG_V6_MC_SLB_PARITY                        0
>> +#define RTAS_LOG_V6_MC_SLB_MULTIHIT                      1
>> +#define RTAS_LOG_V6_MC_SLB_INDETERMINATE                 2
>> +#define RTAS_LOG_V6_MC_ERAT_PARITY                       1
>> +#define RTAS_LOG_V6_MC_ERAT_MULTIHIT                     2
>> +#define RTAS_LOG_V6_MC_ERAT_INDETERMINATE                3
>> +#define RTAS_LOG_V6_MC_TLB_PARITY                        1
>> +#define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
>> +#define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
>> +    uint8_t reserved_1[6];
>> +    uint64_t effective_address;
>> +    uint64_t logical_address;
>> +} QEMU_PACKED;
>> +
>> +struct mc_extended_log {
>> +    struct rtas_event_log_v6 v6hdr;
>> +    struct rtas_event_log_v6_mc mc;
>> +} QEMU_PACKED;
>> +
>> +struct MC_ierror_table {
>> +    unsigned long srr1_mask;
>> +    unsigned long srr1_value;
>> +    bool nip_valid; /* nip is a valid indicator of faulting address */
>> +    uint8_t error_type;
>> +    uint8_t error_subtype;
>> +    unsigned int initiator;
>> +    unsigned int severity;
>> +};
>> +
>> +static const struct MC_ierror_table mc_ierror_table[] = {
>> +{ 0x00000000081c0000, 0x0000000000040000, true,
>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_IFETCH,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000000081c0000, 0x0000000000080000, true,
>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000000081c0000, 0x00000000000c0000, true,
>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000000081c0000, 0x0000000000100000, true,
>> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000000081c0000, 0x0000000000140000, true,
>> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000000081c0000, 0x0000000000180000, true,
>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, } };
>> +
>> +struct MC_derror_table {
>> +    unsigned long dsisr_value;
>> +    bool dar_valid; /* dar is a valid indicator of faulting address */
>> +    uint8_t error_type;
>> +    uint8_t error_subtype;
>> +    unsigned int initiator;
>> +    unsigned int severity;
>> +};
>> +
>> +static const struct MC_derror_table mc_derror_table[] = {
>> +{ 0x00008000, false,
>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_LOAD_STORE,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00004000, true,
>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000800, true,
>> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000400, true,
>> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000080, true,
>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,  /* Before PARITY */
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000100, true,
>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, } };
>> +
>> +#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
>> +
>>   typedef enum EventClass {
>>       EVENT_CLASS_INTERNAL_ERRORS     = 0,
>>       EVENT_CLASS_EPOW                = 1,
>> @@ -622,7 +720,125 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>>                               RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
>>   }
>>   
>> -void spapr_mce_req_event(PowerPCCPU *cpu)
>> +static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
>> +                                        struct mc_extended_log *ext_elog)
>> +{
>> +    int i;
>> +    CPUPPCState *env = &cpu->env;
>> +    uint32_t summary;
>> +    uint64_t dsisr = env->spr[SPR_DSISR];
>> +
>> +    summary = RTAS_LOG_VERSION_6 | RTAS_LOG_OPTIONAL_PART_PRESENT;
>> +    if (recovered) {
>> +        summary |= RTAS_LOG_DISPOSITION_FULLY_RECOVERED;
>> +    } else {
>> +        summary |= RTAS_LOG_DISPOSITION_NOT_RECOVERED;
>> +    }
>> +
>> +    if (SRR1_MC_LOADSTORE(env->spr[SPR_SRR1])) {
>> +        for (i = 0; i < ARRAY_SIZE(mc_derror_table); i++) {
>> +            if (!(dsisr & mc_derror_table[i].dsisr_value)) {
>> +                continue;
>> +            }
>> +
>> +            ext_elog->mc.error_type = mc_derror_table[i].error_type;
>> +            ext_elog->mc.sub_err_type = mc_derror_table[i].error_subtype;
>> +            if (mc_derror_table[i].dar_valid) {
>> +                ext_elog->mc.effective_address = cpu_to_be64(env->spr[SPR_DAR]);
>> +            }
>> +
>> +            summary |= mc_derror_table[i].initiator
>> +                        | mc_derror_table[i].severity;
>> +
>> +            return summary;
>> +        }
>> +    } else {
>> +        for (i = 0; i < ARRAY_SIZE(mc_ierror_table); i++) {
>> +            if ((env->spr[SPR_SRR1] & mc_ierror_table[i].srr1_mask) !=
>> +                    mc_ierror_table[i].srr1_value) {
>> +                continue;
>> +            }
>> +
>> +            ext_elog->mc.error_type = mc_ierror_table[i].error_type;
>> +            ext_elog->mc.sub_err_type = mc_ierror_table[i].error_subtype;
>> +            if (mc_ierror_table[i].nip_valid) {
>> +                ext_elog->mc.effective_address = cpu_to_be64(env->nip);
>> +            }
>> +
>> +            summary |= mc_ierror_table[i].initiator
>> +                        | mc_ierror_table[i].severity;
>> +
>> +            return summary;
>> +        }
>> +    }
>> +
>> +    summary |= RTAS_LOG_INITIATOR_CPU;
>> +    return summary;
>> +}
>> +
>> +static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    CPUState *cs = CPU(cpu);
>> +    uint64_t rtas_addr;
>> +    CPUPPCState *env = &cpu->env;
>> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>> +    target_ulong msr = 0;
>> +    struct rtas_error_log log;
>> +    struct mc_extended_log *ext_elog;
>> +    uint32_t summary;
>> +
>> +    /*
>> +     * Properly set bits in MSR before we invoke the handler.
>> +     * SRR0/1, DAR and DSISR are properly set by KVM
>> +     */
>> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
>> +        msr |= (1ULL << MSR_LE);
>> +    }
>> +
>> +    if (env->msr & (1ULL << MSR_SF)) {
>> +        msr |= (1ULL << MSR_SF);
>> +    }
>> +
>> +    msr |= (1ULL << MSR_ME);
>> +
>> +    ext_elog = g_malloc0(sizeof(*ext_elog));
>> +    summary = spapr_mce_get_elog_type(cpu, recovered, ext_elog);
>> +
>> +    log.summary = cpu_to_be32(summary);
>> +    log.extended_length = cpu_to_be32(sizeof(*ext_elog));
>> +
>> +    spapr_init_v6hdr(&ext_elog->v6hdr);
>> +    ext_elog->mc.hdr.section_id = cpu_to_be16(RTAS_LOG_V6_SECTION_ID_MC);
>> +    ext_elog->mc.hdr.section_length =
>> +                    cpu_to_be16(sizeof(struct rtas_event_log_v6_mc));
>> +    ext_elog->mc.hdr.section_version = 1;
>> +
>> +    /* get rtas addr from fdt */
>> +    rtas_addr = spapr_get_rtas_addr();
>> +    if (!rtas_addr) {
>> +        /* Unable to fetch rtas_addr. Hence reset the guest */
>> +        ppc_cpu_do_system_reset(cs);
>> +        g_free(ext_elog);
>> +        return;
>> +    }
>> +
>> +    stq_be_phys(&address_space_memory, rtas_addr + RTAS_ERROR_LOG_OFFSET,
>> +                env->gpr[3]);
>> +    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
>> +                              sizeof(env->gpr[3]), &log, sizeof(log));
>> +    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
>> +                              sizeof(env->gpr[3]) + sizeof(log), ext_elog,
>> +                              sizeof(*ext_elog));
>> +
>> +    env->gpr[3] = rtas_addr + RTAS_ERROR_LOG_OFFSET;
>> +    env->msr = msr;
>> +    env->nip = spapr->guest_machine_check_addr;
>> +
>> +    g_free(ext_elog);
>> +}
>> +
>> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>   {
>>       SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>       CPUState *cs = CPU(cpu);
>> @@ -656,6 +872,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu)
>>           }
>>       }
>>       spapr->mc_status = cpu->vcpu_id;
>> +
>> +    spapr_mce_dispatch_elog(cpu, recovered);
>>   }
>>   
>>   static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index 8d8d8cdfcb..2c066a372d 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -477,6 +477,32 @@ void spapr_dt_rtas_tokens(void *fdt, int rtas)
>>       }
>>   }
>>   
>> +hwaddr spapr_get_rtas_addr(void)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    int rtas_node;
>> +    const fdt32_t *rtas_data;
>> +    void *fdt = spapr->fdt_blob;
>> +
>> +    /* fetch rtas addr from fdt */
>> +    rtas_node = fdt_path_offset(fdt, "/rtas");
>> +    if (rtas_node < 0) {
>> +        return 0;
>> +    }
>> +
>> +    rtas_data = fdt_getprop(fdt, rtas_node, "linux,rtas-base", NULL);
>> +    if (!rtas_data) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * We assume that the OS called RTAS instantiate-rtas, but some other
>> +     * OS might call RTAS instantiate-rtas-64 instead. This fine as of now
>> +     * as SLOF only supports 32-bit variant.
>> +     */
>> +    return (hwaddr)fdt32_to_cpu(*rtas_data);
>> +}
>> +
>>   static void core_rtas_register_types(void)
>>   {
>>       spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 1f5eb8c856..4afa8d4d09 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -724,6 +724,9 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr);
>>   
>>   #define RTAS_ERROR_LOG_MAX      2048
>>   
>> +/* Offset from rtas-base where error log is placed */
>> +#define RTAS_ERROR_LOG_OFFSET       0x30
>> +
>>   #define RTAS_EVENT_SCAN_RATE    1
>>   
>>   /* This helper should be used to encode interrupt specifiers when the related
>> @@ -812,7 +815,7 @@ void spapr_clear_pending_events(SpaprMachineState *spapr);
>>   int spapr_max_server_number(SpaprMachineState *spapr);
>>   void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>>                         uint64_t pte0, uint64_t pte1);
>> -void spapr_mce_req_event(PowerPCCPU *cpu);
>> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
>>   
>>   /* DRC callbacks. */
>>   void spapr_core_release(DeviceState *dev);
>> @@ -903,4 +906,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
>>   #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
>>   
>>   void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>> +hwaddr spapr_get_rtas_addr(void);
>>   #endif /* HW_SPAPR_H */
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index 2d8db6d832..9a902c1064 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -2805,9 +2805,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>>   
>>   int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
>>   {
>> +    bool recovered = run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
>> +
>>       cpu_synchronize_state(CPU(cpu));
>>   
>> -    spapr_mce_req_event(cpu);
>> +    spapr_mce_req_event(cpu, recovered);
>>   
>>       return 0;
>>   }


