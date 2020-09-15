Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E23EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7003206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KKHPwc0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7003206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICPj-0005Pd-I2
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kICOv-0004sV-2Z; Tue, 15 Sep 2020 10:57:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16626
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kICOs-0005ol-NF; Tue, 15 Sep 2020 10:57:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08FEjfPI095470; Tue, 15 Sep 2020 10:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2QfBFiCXgVVErPpf91x8YNL31SOvrIwIzM9Ym9mgr+U=;
 b=KKHPwc0r1po95vpICcSNMAevKvoQ+suFAamK8z+joXVLjAJ8wuPdzmexC6OETcdXIoI4
 z2N6YwbTaAKKoOdcAXtCKnqQvrI0IFK9otk2u0B8uD6y6nc8S1aN+V6hSL/dVaIjKwl1
 WwqWAcPBFTAu5sGGPZH1z+fkt6ODpQ8cuAPZnUjI3JhiaeuhT9jh5MRsiEKu7VVUTFed
 p1fCmMdWZ0ocVqYdDtzrgQJFE6G9QWwJ2lBijvs2G7SMlOjdMztuNCWrlovZ8eLlcOWA
 dbKBIZPdxAXkuizQaEI7WT09n2n+1R4iT5fRhfpCAGFj515xgj+wHrgLp7BUVkh2kQdr +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33jxg8tv31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 10:57:40 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FEjjs7095836;
 Tue, 15 Sep 2020 10:57:40 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33jxg8tv1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 10:57:40 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FEqCgT029665;
 Tue, 15 Sep 2020 14:57:38 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma01dal.us.ibm.com with ESMTP id 33gny968sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 14:57:38 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08FEvc5X39977220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 14:57:38 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5ABE124052;
 Tue, 15 Sep 2020 14:57:37 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE3D8124053;
 Tue, 15 Sep 2020 14:57:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.9])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue, 15 Sep 2020 14:57:37 +0000 (GMT)
Subject: Re: [PATCH v5 8/8] s390: guest support for diagnose 0x318
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-9-walling@linux.ibm.com>
 <6707d734-772d-0a34-0980-6d8e71873238@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <4225f7e4-3388-4a07-8373-68be66d4d66b@linux.ibm.com>
Date: Tue, 15 Sep 2020 10:57:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6707d734-772d-0a34-0980-6d8e71873238@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-15_11:2020-09-15,
 2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 09:43:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 11:08 AM, Thomas Huth wrote:
> On 10/09/2020 11.36, Collin Walling wrote:
>> DIAGNOSE 0x318 (diag318) is an s390 instruction that allows the storage
>> of diagnostic information that is collected by the firmware in the case
>> of hardware/firmware service events.
>>
>> QEMU handles the instruction by storing the info in the CPU state. A
>> subsequent register sync will communicate the data to the hypervisor.
>>
>> QEMU handles the migration via a VM State Description.
>>
>> This feature depends on the Extended-Length SCCB (els) feature. If
>> els is not present, then a warning will be printed and the SCLP bit
>> that allows the Linux kernel to execute the instruction will not be
>> set.
>>
>> Availability of this instruction is determined by byte 134 (aka fac134)
>> bit 0 of the SCLP Read Info block. This coincidentally expands into the
>> space used for CPU entries, which means VMs running with the diag318
>> capability may not be able to read information regarding all CPUs
>> unless the guest kernel supports an extended-length SCCB.
>>
>> This feature is not supported in protected virtualization mode.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c                     |  5 +++++
>>  include/hw/s390x/sclp.h             |  3 +++
>>  target/s390x/cpu.h                  |  2 ++
>>  target/s390x/cpu_features.h         |  1 +
>>  target/s390x/cpu_features_def.h.inc |  3 +++
>>  target/s390x/cpu_models.c           |  1 +
>>  target/s390x/gen-features.c         |  1 +
>>  target/s390x/kvm.c                  | 31 +++++++++++++++++++++++++++++
>>  target/s390x/machine.c              | 17 ++++++++++++++++
>>  9 files changed, 64 insertions(+)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 87d468087b..ad5d70e14d 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -139,6 +139,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
>>                           read_info->conf_char_ext);
>>  
>> +    if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
>> +        s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
>> +                            &read_info->fac134);
>> +    }
> 
> Wasn't this feature also possible if there are less than 240 CPUs? Or do
> I mix that up with something else? ... well, maybe it's best anyway if
> we only allow this when ELS is enabled.
> 
>>      read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
>>                                          SCLP_HAS_IOA_RECONFIG);
>>  
>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>> index 141e57f765..516f949109 100644
>> --- a/include/hw/s390x/sclp.h
>> +++ b/include/hw/s390x/sclp.h
>> @@ -133,6 +133,9 @@ typedef struct ReadInfo {
>>      uint16_t highest_cpu;
>>      uint8_t  _reserved5[124 - 122];     /* 122-123 */
>>      uint32_t hmfai;
>> +    uint8_t  _reserved7[134 - 128];     /* 128-133 */
>> +    uint8_t  fac134;
>> +    uint8_t  _reserved8[144 - 135];     /* 135-143 */
>>      struct CPUEntry entries[];
> 
> Could you please add a comment after entries[] like,
> 
>  /* only here with "ELS", it's at offset 128 otherwise */
> 
> ?
> 
>>  } QEMU_PACKED ReadInfo;
>>  
> [...]
>>  static uint16_t full_GEN12_GA2[] = {
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index a2d5ad78f6..b79feeba9f 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -105,6 +105,7 @@
>>  
>>  #define DIAG_TIMEREVENT                 0x288
>>  #define DIAG_IPL                        0x308
>> +#define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
>>  #define DIAG_KVM_HYPERCALL              0x500
>>  #define DIAG_KVM_BREAKPOINT             0x501
>>  
>> @@ -602,6 +603,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>>          cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_ETOKEN;
>>      }
>>  
>> +    if (can_sync_regs(cs, KVM_SYNC_DIAG318)) {
>> +        cs->kvm_run->s.regs.diag318 = env->diag318_info;
>> +        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_DIAG318;
>> +    }
>> +
>>      /* Finally the prefix */
>>      if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
>>          cs->kvm_run->s.regs.prefix = env->psa;
>> @@ -741,6 +747,10 @@ int kvm_arch_get_registers(CPUState *cs)
>>          }
>>      }
>>  
>> +    if (can_sync_regs(cs, KVM_SYNC_DIAG318)) {
>> +        env->diag318_info = cs->kvm_run->s.regs.diag318;
>> +    }
>> +
>>      return 0;
>>  }
>>  
>> @@ -1601,6 +1611,19 @@ static int handle_sw_breakpoint(S390CPU *cpu, struct kvm_run *run)
>>      return -ENOENT;
>>  }
>>  
>> +static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
>> +{
>> +    uint64_t reg = (run->s390_sieic.ipa & 0x00f0) >> 4;
>> +    uint64_t diag318_info = run->s.regs.gprs[reg];
>> +
>> +    cpu->env.diag318_info = diag318_info;
>> +
>> +    if (can_sync_regs(CPU(cpu), KVM_SYNC_DIAG318)) {
>> +        run->s.regs.diag318 = diag318_info;
>> +        run->kvm_dirty_regs |= KVM_SYNC_DIAG318;
>> +    }
>> +}
> 
> What's supposed to happen if a guest calls diag 318 but the
> S390_FEAT_DIAG_318 has not been enabled? Shouldn't there be a program
> interrupt in that case?
> 
>  Thomas
> 
> 

Right... an edge case where a guest kernel tries to erroneously call
diag 318 without checking the SCLP bit first. I'll add this fence.

-- 
Regards,
Collin

Stay safe and stay healthy

