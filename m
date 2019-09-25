Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28785C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E6E21D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E6E21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD07I-00046Y-JO
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 01:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1iD05B-0002ca-0k
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1iD059-0000GH-CR
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:43:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1iD055-0000Ap-9m; Wed, 25 Sep 2019 01:43:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8P5gOPD021804; Wed, 25 Sep 2019 01:42:59 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v821h8nqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Sep 2019 01:42:58 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8P5eIdu026349;
 Wed, 25 Sep 2019 05:42:58 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma04dal.us.ibm.com with ESMTP id 2v5bg7kv5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Sep 2019 05:42:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8P5gvJs47251830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Sep 2019 05:42:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A9AAB2065;
 Wed, 25 Sep 2019 05:42:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D479B205F;
 Wed, 25 Sep 2019 05:42:55 +0000 (GMT)
Received: from [9.124.31.203] (unknown [9.124.31.203])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 25 Sep 2019 05:42:54 +0000 (GMT)
Subject: Re: [PATCH v14 2/7] ppc: spapr: Introduce FWNMI capability
To: David Gibson <david@gibson.dropbear.id.au>
References: <156879398718.18368.17640174821710157715.stgit@aravinda>
 <156879433743.18368.1281417894007921022.stgit@aravinda>
 <20190925011200.GF17405@umbus>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <c205239e-a859-b06f-1dbb-4fb1b3d4dca3@linux.vnet.ibm.com>
Date: Wed, 25 Sep 2019 11:12:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190925011200.GF17405@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-25_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909250058
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, ganeshgr@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Wednesday 25 September 2019 06:42 AM, David Gibson wrote:
> On Wed, Sep 18, 2019 at 01:42:17PM +0530, Aravinda Prasad wrote:
>> Introduce the KVM capability KVM_CAP_PPC_FWNMI so that
>> the KVM causes guest exit with NMI as exit reason
>> when it encounters a machine check exception on the
>> address belonging to a guest. Without this capability
>> enabled, KVM redirects machine check exceptions to
>> guest's 0x200 vector.
>>
>> This patch also introduces fwnmi-mce capability to
>> deal with the case when a guest with the
>> KVM_CAP_PPC_FWNMI capability enabled is attempted
>> to migrate to a host that does not support this
>> capability.
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> 
> Mostly ok, but there's one ugly problem.
> 
>> ---
>>  hw/ppc/spapr.c         |    1 +
>>  hw/ppc/spapr_caps.c    |   29 +++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |    4 +++-
>>  target/ppc/kvm.c       |   26 ++++++++++++++++++++++++++
>>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
>>  5 files changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index ea56499..8288e8b 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4487,6 +4487,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>>      spapr_caps_add_properties(smc, &error_abort);
>>      smc->irq = &spapr_irq_dual;
>>      smc->dr_phb_enabled = true;
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index 481dfd2..c11ff87 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -496,6 +496,25 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>>      }
>>  }
>>  
>> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
>> +                                Error **errp)
>> +{
>> +    if (!val) {
>> +        return; /* Disabled by default */
>> +    }
>> +
>> +    if (tcg_enabled()) {
>> +        /*
>> +         * TCG support may not be correct in some conditions (e.g., in case
>> +         * of software injected faults like duplicate SLBs).
>> +         */
>> +        warn_report("Firmware Assisted Non-Maskable Interrupts not supported in TCG");
>> +    } else if (kvm_enabled() && !kvmppc_has_cap_ppc_fwnmi()) {
>> +        error_setg(errp,
>> +"Firmware Assisted Non-Maskable Interrupts not supported by KVM, try cap-fwnmi-mce=off");
>> +    }
>> +}
>> +
>>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>      [SPAPR_CAP_HTM] = {
>>          .name = "htm",
>> @@ -595,6 +614,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>          .type = "bool",
>>          .apply = cap_ccf_assist_apply,
>>      },
>> +    [SPAPR_CAP_FWNMI_MCE] = {
>> +        .name = "fwnmi-mce",
>> +        .description = "Handle fwnmi machine check exceptions",
>> +        .index = SPAPR_CAP_FWNMI_MCE,
>> +        .get = spapr_cap_get_bool,
>> +        .set = spapr_cap_set_bool,
>> +        .type = "bool",
>> +        .apply = cap_fwnmi_mce_apply,
>> +    },
>>  };
>>  
>>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
>> @@ -734,6 +762,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
>>  
>>  void spapr_caps_init(SpaprMachineState *spapr)
>>  {
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 03111fd..66049ac 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -79,8 +79,10 @@ typedef enum {
>>  #define SPAPR_CAP_LARGE_DECREMENTER     0x08
>>  /* Count Cache Flush Assist HW Instruction */
>>  #define SPAPR_CAP_CCF_ASSIST            0x09
>> +/* FWNMI machine check handling */
>> +#define SPAPR_CAP_FWNMI_MCE             0x0A
>>  /* Num Caps */
>> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
>> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI_MCE + 1)
>>  
>>  /*
>>   * Capability Values
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index 8c5b1f2..8b1ab78 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -85,6 +85,7 @@ static int cap_ppc_safe_indirect_branch;
>>  static int cap_ppc_count_cache_flush_assist;
>>  static int cap_ppc_nested_kvm_hv;
>>  static int cap_large_decr;
>> +static int cap_ppc_fwnmi;
>>  
>>  static uint32_t debug_inst_opcode;
>>  
>> @@ -2055,6 +2056,26 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>>      }
>>  }
>>  
>> +int kvmppc_set_fwnmi(void)
>> +{
>> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>> +    CPUState *cs = CPU(cpu);
>> +    int ret;
>> +
>> +    ret = kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
>> +    if (ret) {
>> +        error_report("This KVM version does not support FWNMI");
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * cap_ppc_fwnmi is set when FWNMI is available and enabled in KVM
>> +     * and not just when FWNMI is available in KVM
>> +     */
>> +    cap_ppc_fwnmi = 1;
> 
> Using these cap globals is only slighly ugly when they can be
> initialized very early and thereafter remain constant.  However, since
> you're only setting this later (in fact *never* until several patches
> down the series, since kvmppc_set_fwnmi() isn't called), this makes it
> very ugly with this global set at an indeterminite time having effects
> on things the relative order of which is not at all obvious.
> 
> I think it would make much more sense to eliminate the cap_ppc_fwnmi
> global, and instead attempt the enable_cap in cap_fwnmi_mce_apply,
> failing the apply if the enable_cap fails.

ok

> 
>> +    return ret;
>> +}
>> +
>>  int kvmppc_smt_threads(void)
>>  {
>>      return cap_ppc_smt ? cap_ppc_smt : 1;
>> @@ -2355,6 +2376,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>>      return cap_mmu_hash_v3;
>>  }
>>  
>> +bool kvmppc_has_cap_ppc_fwnmi(void)
>> +{
>> +    return cap_ppc_fwnmi;
>> +}
>> +
>>  static bool kvmppc_power8_host(void)
>>  {
>>      bool ret = false;
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index 98bd7d5..ce5c1f9 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
>> @@ -27,6 +27,8 @@ void kvmppc_enable_h_page_init(void);
>>  void kvmppc_set_papr(PowerPCCPU *cpu);
>>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>> +int kvmppc_set_fwnmi(void);
>> +bool kvmppc_has_cap_ppc_fwnmi(void);
>>  int kvmppc_smt_threads(void);
>>  void kvmppc_hint_smt_possible(Error **errp);
>>  int kvmppc_set_smt_threads(int smt);
>> @@ -159,6 +161,16 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>>  {
>>  }
>>  
>> +static inline int kvmppc_set_fwnmi(void)
>> +{
>> +    return -1;
>> +}
>> +
>> +static inline bool kvmppc_has_cap_ppc_fwnmi(void)
>> +{
>> +    return false;
>> +}
>> +
>>  static inline int kvmppc_smt_threads(void)
>>  {
>>      return 1;
>>
> 

-- 
Regards,
Aravinda

