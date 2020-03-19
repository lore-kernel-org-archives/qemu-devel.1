Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA6C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AE720782
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AE720782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEwWk-0006o4-Ch
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jEwWA-0006OC-KV
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jEwW9-0002JU-0T
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:51:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jEwW8-0002JK-PN
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:51:28 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02JEp9xB067463
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:51:27 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yu8aegm8m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:51:26 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Thu, 19 Mar 2020 14:50:44 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 19 Mar 2020 14:50:41 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02JEoe7P63897746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 14:50:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF705A405B;
 Thu, 19 Mar 2020 14:50:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68261A406B;
 Thu, 19 Mar 2020 14:50:40 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.52.26])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 14:50:40 +0000 (GMT)
Subject: Re: [PATCH v11 09/16] s390x: protvirt: SCLP interpretation
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200319131921.2367-1-frankja@linux.ibm.com>
 <20200319131921.2367-10-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Thu, 19 Mar 2020 15:50:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319131921.2367-10-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031914-0028-0000-0000-000003E79D2B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031914-0029-0000-0000-000024ACF8B4
Message-Id: <67a26568-1435-f74a-bb0f-90ac0f994d08@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-19_05:2020-03-19,
 2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190065
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 19.03.20 14:19, Janosch Frank wrote:
> SCLP for a protected guest is done over the SIDAD, so we need to use
> the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
> memory when reading/writing SCBs.
> 
> To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
> since the function that injects the sclp external interrupt would
> reject a zero sccb address.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

series looks good to me.


> ---
>  hw/s390x/sclp.c         | 56 +++++++++++++++++++++++++++++++++--------
>  include/hw/s390x/sclp.h |  2 ++
>  target/s390x/kvm.c      | 25 ++++++++++++++----
>  3 files changed, 67 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index af0bfbc2eca74767..d8ae207731f1060a 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -33,6 +33,22 @@ static inline SCLPDevice *get_sclp_device(void)
>      return sclp;
>  }
>  
> +static inline bool sclp_command_code_valid(uint32_t code)
> +{
> +    switch (code & SCLP_CMD_CODE_MASK) {
> +    case SCLP_CMDW_READ_SCP_INFO:
> +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
> +    case SCLP_CMDW_READ_CPU_INFO:
> +    case SCLP_CMDW_CONFIGURE_IOA:
> +    case SCLP_CMDW_DECONFIGURE_IOA:
> +    case SCLP_CMD_READ_EVENT_DATA:
> +    case SCLP_CMD_WRITE_EVENT_DATA:
> +    case SCLP_CMD_WRITE_EVENT_MASK:
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int *count)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> @@ -193,6 +209,34 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
>      }
>  }
>  
> +/*
> + * We only need the address to have something valid for the
> + * service_interrupt call.
> + */
> +#define SCLP_PV_DUMMY_ADDR 0x4000
> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> +                                uint32_t code)
> +{
> +    SCLPDevice *sclp = get_sclp_device();
> +    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
> +    SCCB work_sccb;
> +    hwaddr sccb_len = sizeof(SCCB);
> +
> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
> +
> +    if (!sclp_command_code_valid(code)) {
> +        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
> +        goto out_write;
> +    }
> +
> +    sclp_c->execute(sclp, &work_sccb, code);
> +out_write:
> +    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> +                          be16_to_cpu(work_sccb.h.length));
> +    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
> +    return 0;
> +}
> +
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>  {
>      SCLPDevice *sclp = get_sclp_device();
> @@ -225,17 +269,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>          return -PGM_SPECIFICATION;
>      }
>  
> -    switch (code & SCLP_CMD_CODE_MASK) {
> -    case SCLP_CMDW_READ_SCP_INFO:
> -    case SCLP_CMDW_READ_SCP_INFO_FORCED:
> -    case SCLP_CMDW_READ_CPU_INFO:
> -    case SCLP_CMDW_CONFIGURE_IOA:
> -    case SCLP_CMDW_DECONFIGURE_IOA:
> -    case SCLP_CMD_READ_EVENT_DATA:
> -    case SCLP_CMD_WRITE_EVENT_DATA:
> -    case SCLP_CMD_WRITE_EVENT_MASK:
> -        break;
> -    default:
> +    if (!sclp_command_code_valid(code)) {
>          work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>          goto out_write;
>      }
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index cd7b24359f28deb4..822eff4396ff5dde 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -217,5 +217,7 @@ void s390_sclp_init(void);
>  void sclp_service_interrupt(uint32_t sccb);
>  void raise_irq_cpu_hotplug(void);
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> +                                uint32_t code);
>  
>  #endif
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 462a1d70ee78104c..6b7819d2c51a111c 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1233,12 +1233,27 @@ static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>      sccb = env->regs[ipbh0 & 0xf];
>      code = env->regs[(ipbh0 & 0xf0) >> 4];
>  
> -    r = sclp_service_call(env, sccb, code);
> -    if (r < 0) {
> -        kvm_s390_program_interrupt(cpu, -r);
> -        return;
> +    switch (run->s390_sieic.icptcode) {
> +    case ICPT_PV_INSTR_NOTIFICATION:
> +        g_assert(s390_is_pv());
> +        /* The notification intercepts are currently handled by KVM */
> +        error_report("unexpected SCLP PV notification");
> +        exit(1);
> +        break;
> +    case ICPT_PV_INSTR:
> +        g_assert(s390_is_pv());
> +        sclp_service_call_protected(env, sccb, code);
> +        /* Setting the CC is done by the Ultravisor. */
> +        break;
> +    case ICPT_INSTRUCTION:
> +        g_assert(!s390_is_pv());
> +        r = sclp_service_call(env, sccb, code);
> +        if (r < 0) {
> +            kvm_s390_program_interrupt(cpu, -r);
> +            return;
> +        }
> +        setcc(cpu, r);
>      }
> -    setcc(cpu, r);
>  }
>  
>  static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
> 


