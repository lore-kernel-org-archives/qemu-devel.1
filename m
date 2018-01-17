Received: from eggs.gnu.org ([2001:4830:134:3::10]:57832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ebp4C-0000dX-DJ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ebp49-0001XB-33
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:51:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ebp48-0001Vl-PI
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:51:49 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0HEpLK4079353
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 09:51:47 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fj6htx5s7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 09:51:46 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 17 Jan 2018 14:51:44 -0000
References: <20180117141849.65757-1-borntraeger@de.ibm.com>
	<20180117141849.65757-3-borntraeger@de.ibm.com>
	<20180117153727.2552d1a2.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 17 Jan 2018 15:51:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180117153727.2552d1a2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f5f88b8a-4a59-a399-c253-f9aa83846553@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>



On 01/17/2018 03:37 PM, Cornelia Huck wrote:
> On Wed, 17 Jan 2018 15:18:48 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
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
>>  target/s390x/kvm.c              | 16 ++++++++++++++++
>>  target/s390x/machine.c          | 17 +++++++++++++++++
>>  7 files changed, 38 insertions(+)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index ae3cee9..1577b2c 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -89,6 +89,7 @@ static void s390_cpu_reset(CPUState *s)
>>      CPUS390XState *env = &cpu->env;
>>  
>>      env->pfault_token = -1UL;
>> +    env->bpbc = 0;
>>      scc->parent_reset(s);
>>      cpu->env.sigp_order = 0;
>>      s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 1a8b6b9..8514905 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -93,6 +93,7 @@ struct CPUS390XState {
>>  
>>      uint32_t fpc;          /* floating-point control register */
>>      uint32_t cc_op;
>> +    uint8_t bpbc;          /* branch prediction blocking */
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
> 
> No nice "facility" suffix? :)

assist I think.

> 
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
>> index b24f6ad..95ee870 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -357,6 +357,7 @@ static uint16_t full_GEN7_GA1[] = {
>>      S390_FEAT_SIE_GPERE,
>>      S390_FEAT_SIE_IB,
>>      S390_FEAT_SIE_CEI,
>> +    S390_FEAT_BPB,
> 
> Will this be provided that far back on real hardware?

I theory this could be backported to every machine (but its pretty unlikely).
Since its just in the full model (and no default model) and kvm will only provide
it if the host has it, this is the most flexible approach if this is backported
further than we expected.

> 
>>  };
>>  
>>  static uint16_t full_GEN7_GA2[] = {
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 6a18a41..3cd4fab 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -490,6 +490,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>>          cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GSCB;
>>      }
>>  
>> +    if (can_sync_regs(cs, KVM_SYNC_BPBC)) {
>> +       cs->kvm_run->s.regs.bpbc = env->bpbc;
>> +       cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_BPBC;
>> +    }
>> +
>>      /* Finally the prefix */
>>      if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
>>          cs->kvm_run->s.regs.prefix = env->psa;
>> @@ -600,6 +605,10 @@ int kvm_arch_get_registers(CPUState *cs)
>>          memcpy(env->gscb, cs->kvm_run->s.regs.gscb, 32);
>>      }
>>  
>> +    if (can_sync_regs(cs, KVM_SYNC_BPBC)) {
>> +       env->bpbc = cs->kvm_run->s.regs.bpbc;
>> +    }
>> +
>>      /* pfault parameters */
>>      if (can_sync_regs(cs, KVM_SYNC_PFAULT)) {
>>          env->pfault_token = cs->kvm_run->s.regs.pft;
>> @@ -2278,6 +2287,13 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>          clear_bit(S390_FEAT_CMM_NT, model->features);
>>      }
>>  
>> +    /* stfle.82 is a transparent bit. As there is some state attached
>> +     * anyway we only enable this bit if the host kernel can handle
>> +     * migrate and reset */
> 
> Having a transparent bit with some state attached seems a bit odd...

Yes, its a quirk,but the firmware fixes are already out.
