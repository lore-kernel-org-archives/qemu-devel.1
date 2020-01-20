Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEBFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE4521835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE4521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itamy-0008Tm-LA
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1itah7-0001VC-AI
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1itah5-00077B-Qm
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:18:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9448
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1itah5-00075r-Kl
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:18:31 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00KHCYEW057398
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 12:18:29 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgbp9f3e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 12:18:29 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Mon, 20 Jan 2020 17:18:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 20 Jan 2020 17:18:24 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00KHIOOG63897722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jan 2020 17:18:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7CC5A405C;
 Mon, 20 Jan 2020 17:18:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1866A405B;
 Mon, 20 Jan 2020 17:18:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.51.38])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 20 Jan 2020 17:18:21 +0000 (GMT)
Subject: Re: [PATCH v20 5/7] ppc: spapr: Handle "ibm,nmi-register" and
 "ibm,nmi-interlock" RTAS calls
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200117093855.19074-1-ganeshgr@linux.ibm.com>
 <20200117093855.19074-6-ganeshgr@linux.ibm.com>
 <20200120004633.GI54439@umbus>
From: Ganesh <ganeshgr@linux.ibm.com>
Date: Mon, 20 Jan 2020 22:48:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20200120004633.GI54439@umbus>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20012017-0020-0000-0000-000003A27136
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012017-0021-0000-0000-000021F9FD7D
Message-Id: <c64f80ec-b959-4e7c-9339-40e4c1b7e629@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-20_07:2020-01-20,
 2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001200145
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/20/20 6:16 AM, David Gibson wrote:
> On Fri, Jan 17, 2020 at 03:08:53PM +0530, Ganesh Goudar wrote:
>> From: Aravinda Prasad <arawinda.p@gmail.com>
>>
>> This patch adds support in QEMU to handle "ibm,nmi-register"
>> and "ibm,nmi-interlock" RTAS calls.
>>
>> The machine check notification address is saved when the
>> OS issues "ibm,nmi-register" RTAS call.
>>
>> This patch also handles the case when multiple processors
>> experience machine check at or about the same time by
>> handling "ibm,nmi-interlock" call. In such cases, as per
>> PAPR, subsequent processors serialize waiting for the first
>> processor to issue the "ibm,nmi-interlock" call. The second
>> processor that also received a machine check error waits
>> till the first processor is done reading the error log.
>> The first processor issues "ibm,nmi-interlock" call
>> when the error log is consumed.
>>
>> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
>> [Register fwnmi RTAS calls in core_rtas_register_types()
>>   where other RTAS calls are registered]
>> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_caps.c    |  7 +++++
>>   hw/ppc/spapr_rtas.c    | 59 ++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/spapr.h |  4 ++-
>>   3 files changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index 3001098601..c43498da49 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -502,6 +502,13 @@ static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
>>       if (!val) {
>>           return; /* Disabled by default */
>>       }
>> +
>> +    if (kvm_enabled()) {
>> +        if (kvmppc_set_fwnmi() < 0) {
>> +            error_report("Could not enable fwnmi capability");
>> +            exit(1);
> We have uniform failure handling for the cap_apply functions so you
> shouldn't roll your own.  Simply error_setg() on the supplied errp,
> and the generic caps code will handle exiting out.
>
> Also, I think you should explicitly mention KVM in this message, to
> make it clear that's where the problem is occurring.  From the user's
> point of view they've just *set* the spapr fwnmi capability so this
> won't help them figure out why it isn't working.
sure
>
> Also, weren't you going to report a (non fatal) warning in the TCG
> case, since TCG FWNMI behaviour doesn't precisely match true FWNMI
> behaviour (though in a way that probably won't matter in practice).
ok
>
>> +        }
>> +    }
>>   }
>>   
>>   SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index 2c066a372d..3f162d82f5 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -400,6 +400,61 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>       rtas_st(rets, 1, 100);
>>   }
>>   
>> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>> +                                  SpaprMachineState *spapr,
>> +                                  uint32_t token, uint32_t nargs,
>> +                                  target_ulong args,
>> +                                  uint32_t nret, target_ulong rets)
>> +{
>> +    hwaddr rtas_addr;
>> +
>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_OFF) {
>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>> +        return;
>> +    }
>> +
>> +    rtas_addr = spapr_get_rtas_addr();
>> +    if (!rtas_addr) {
>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>> +        return;
>> +    }
>> +
>> +    spapr->guest_machine_check_addr = rtas_ld(args, 1);
>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +}
>> +
>> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>> +                                   SpaprMachineState *spapr,
>> +                                   uint32_t token, uint32_t nargs,
>> +                                   target_ulong args,
>> +                                   uint32_t nret, target_ulong rets)
>> +{
>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_OFF) {
>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>> +        return;
>> +    }
>> +
>> +    if (spapr->guest_machine_check_addr == -1) {
>> +        /* NMI register not called */
>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>> +        return;
>> +    }
>> +
>> +    if (spapr->mc_status != cpu->vcpu_id) {
>> +        /* The vCPU that hit the NMI should invoke "ibm,nmi-interlock" */
>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
>> +     * hence unset mc_status.
>> +     */
>> +    spapr->mc_status = -1;
>> +    qemu_cond_signal(&spapr->mc_delivery_cond);
>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +}
>> +
>>   static struct rtas_call {
>>       const char *name;
>>       spapr_rtas_fn fn;
>> @@ -528,6 +583,10 @@ static void core_rtas_register_types(void)
>>                           rtas_set_power_level);
>>       spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
>>                           rtas_get_power_level);
>> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
>> +                        rtas_ibm_nmi_register);
>> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
>> +                        rtas_ibm_nmi_interlock);
>>   }
>>   
>>   type_init(core_rtas_register_types)
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 652a5514e8..f6f82d88aa 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -656,8 +656,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>   #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>>   #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
>>   #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
>> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
>> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
>>   
>> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
>> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
>>   
>>   /* RTAS ibm,get-system-parameter token values */
>>   #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20


