Received: from eggs.gnu.org ([2001:4830:134:3::10]:59211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ec90S-0004QZ-MO
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ec90P-0003zf-Ga
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:09:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ec90P-0003zB-7v
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:09:17 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0IC7oQl061576
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:09:14 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fjtnej0en-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:09:13 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Jan 2018 12:09:11 -0000
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
	<20180118085628.40798-3-borntraeger@de.ibm.com>
	<35627c4d-eb85-5085-9868-337269a92763@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Jan 2018 13:09:06 +0100
MIME-Version: 1.0
In-Reply-To: <35627c4d-eb85-5085-9868-337269a92763@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <62590be0-16e4-78bb-bd05-5c85a7d9a5e7@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>



On 01/18/2018 01:01 PM, Halil Pasic wrote:
> 
> 
> On 01/18/2018 09:56 AM, Christian Borntraeger wrote:
>> We need to handle the bpb control on reset and migration. Normally
>> stfle.82 is transparent (and the normal guest part works without
>> hypervisor activity). To prevent any issues we require full
>> host kernel support for this feature.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/cpu.c              |  1 +
>>  target/s390x/cpu.h              |  1 +
>>  target/s390x/cpu_features.c     |  1 +
>>  target/s390x/cpu_features_def.h |  1 +
>>  target/s390x/gen-features.c     |  1 +
>>  target/s390x/kvm.c              | 14 ++++++++++++++
>>  target/s390x/machine.c          | 17 +++++++++++++++++
>>  7 files changed, 36 insertions(+)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index ae3cee9..d2e6b9f 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -89,6 +89,7 @@ static void s390_cpu_reset(CPUState *s)
>>      CPUS390XState *env = &cpu->env;
>>
>>      env->pfault_token = -1UL;
>> +    env->bpbc = false;
>>      scc->parent_reset(s);
>>      cpu->env.sigp_order = 0;
>>      s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 1a8b6b9..c0ef85d 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -93,6 +93,7 @@ struct CPUS390XState {
>>
>>      uint32_t fpc;          /* floating-point control register */
>>      uint32_t cc_op;
>> +    bool bpbc;             /* branch prediction blocking */
>>
>>      float_status fpu_status; /* passed to softfloat lib */
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index 31a4676..5d1c210 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -89,6 +89,7 @@ static const S390FeatDef s390_features[] = {
>>      FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security-assist-extension-4 facility (excluding subfunctions)"),
>>      FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2"),
>>      FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
>> +    FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch Prediction Blocking"),
>>      FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
>>      FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-protection facility"),
>>      FEAT_INIT("sea_esop2", S390_FEAT_TYPE_STFL, 131, "Side-effect-access facility and Enhanced-suppression-on-protection facility 2"),
>> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
>> index 4b6d4e9..4487cfd 100644
>> --- a/target/s390x/cpu_features_def.h
>> +++ b/target/s390x/cpu_features_def.h
>> @@ -80,6 +80,7 @@ typedef enum {
>>      S390_FEAT_MSA_EXT_4,
>>      S390_FEAT_EDAT_2,
>>      S390_FEAT_DFP_PACKED_CONVERSION,
>> +    S390_FEAT_BPB,
>>      S390_FEAT_VECTOR,
>>      S390_FEAT_INSTRUCTION_EXEC_PROT,
>>      S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index b24f6ad..563aced 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -352,6 +352,7 @@ static uint16_t base_GEN14_GA1[] = {
>>   * support these features yet.
>>   */
>>  static uint16_t full_GEN7_GA1[] = {
>> +    S390_FEAT_BPB,
>>      S390_FEAT_SIE_F2,
>>      S390_FEAT_SIE_SKEY,
>>      S390_FEAT_SIE_GPERE,
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 6a18a41..8736001 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -490,6 +490,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>>          cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GSCB;
>>      }
>>
>> +    if (can_sync_regs(cs, KVM_SYNC_BPBC)) {
> 
> This is for compat machines <= 2.7, or? Should the guest of these get the
> STFLE bit 82 regardless of the outcome of kvm_check_extension(kvm_state, KVM_CAP_S390_BPB)
> if we have STFLE bit 82 in the host?

I mirror the bpbc in the env of the CPU,  mostly to properly reset the bpbc value on reset. 
We need this here to have the up-to-date values in QEMU (on synchronize-state) and kernel
(on synchronize-back).
So whenever the kernel exposes this we will reset bpbc on reset.
