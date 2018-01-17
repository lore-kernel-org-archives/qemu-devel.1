Received: from eggs.gnu.org ([2001:4830:134:3::10]:57222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebp2h-0007Wd-RB
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebp2e-0008MY-L0
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:50:19 -0500
References: <20180117141849.65757-1-borntraeger@de.ibm.com>
	<20180117141849.65757-3-borntraeger@de.ibm.com>
	<20180117153727.2552d1a2.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <94c656aa-4c1d-5297-8e3a-2816c3628290@redhat.com>
Date: Wed, 17 Jan 2018 15:50:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180117153727.2552d1a2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 17.01.2018 15:37, Cornelia Huck wrote:
> On Wed, 17 Jan 2018 15:18:48 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
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
>>      CPUS390XState *env =3D &cpu->env;
>> =20
>>      env->pfault_token =3D -1UL;
>> +    env->bpbc =3D 0;
>>      scc->parent_reset(s);
>>      cpu->env.sigp_order =3D 0;
>>      s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 1a8b6b9..8514905 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -93,6 +93,7 @@ struct CPUS390XState {
>> =20
>>      uint32_t fpc;          /* floating-point control register */
>>      uint32_t cc_op;
>> +    uint8_t bpbc;          /* branch prediction blocking */
>> =20
>>      float_status fpu_status; /* passed to softfloat lib */
>> =20
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index 31a4676..5d1c210 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -89,6 +89,7 @@ static const S390FeatDef s390_features[] =3D {
>>      FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security=
-assist-extension-4 facility (excluding subfunctions)"),
>>      FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facilit=
y 2"),
>>      FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-poi=
nt packed-conversion facility"),
>> +    FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch Prediction Bloc=
king"),
>=20
> No nice "facility" suffix? :)
>=20
>>      FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
>>      FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution=
-protection facility"),
>>      FEAT_INIT("sea_esop2", S390_FEAT_TYPE_STFL, 131, "Side-effect-acc=
ess facility and Enhanced-suppression-on-protection facility 2"),
>> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_featur=
es_def.h
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
>> @@ -357,6 +357,7 @@ static uint16_t full_GEN7_GA1[] =3D {
>>      S390_FEAT_SIE_GPERE,
>>      S390_FEAT_SIE_IB,
>>      S390_FEAT_SIE_CEI,
>> +    S390_FEAT_BPB,
>=20
> Will this be provided that far back on real hardware?
>=20
>>  };
>> =20
>>  static uint16_t full_GEN7_GA2[] =3D {
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 6a18a41..3cd4fab 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -490,6 +490,11 @@ int kvm_arch_put_registers(CPUState *cs, int leve=
l)
>>          cs->kvm_run->kvm_dirty_regs |=3D KVM_SYNC_GSCB;
>>      }
>> =20
>> +    if (can_sync_regs(cs, KVM_SYNC_BPBC)) {
>> +       cs->kvm_run->s.regs.bpbc =3D env->bpbc;
>> +       cs->kvm_run->kvm_dirty_regs |=3D KVM_SYNC_BPBC;
>> +    }
>> +
>>      /* Finally the prefix */
>>      if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
>>          cs->kvm_run->s.regs.prefix =3D env->psa;
>> @@ -600,6 +605,10 @@ int kvm_arch_get_registers(CPUState *cs)
>>          memcpy(env->gscb, cs->kvm_run->s.regs.gscb, 32);
>>      }
>> =20
>> +    if (can_sync_regs(cs, KVM_SYNC_BPBC)) {
>> +       env->bpbc =3D cs->kvm_run->s.regs.bpbc;
>> +    }
>> +
>>      /* pfault parameters */
>>      if (can_sync_regs(cs, KVM_SYNC_PFAULT)) {
>>          env->pfault_token =3D cs->kvm_run->s.regs.pft;
>> @@ -2278,6 +2287,13 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *=
model, Error **errp)
>>          clear_bit(S390_FEAT_CMM_NT, model->features);
>>      }
>> =20
>> +    /* stfle.82 is a transparent bit. As there is some state attached
>> +     * anyway we only enable this bit if the host kernel can handle
>> +     * migrate and reset */
>=20
> Having a transparent bit with some state attached seems a bit odd...
>=20

And exactly for this reason I tend to nack patch nr 3 (if that is of any
weight :) ).

As soon as we enable bits for CPU models, we guarantee that migration
works. While introducing this change we already had one example where
this was not the case. Not good. (and remember having another such
exception)

It is easier to patch a feature in than silently enabling *anything*
somebody thinks is transparent (but its not). Especially not for the
host model. The expanded host model is migration safe.

And as we saw, in the unlikely event of such heavy changes, we need to
touch fw/linux/qemu either way.

But there is more I dislike about the approach in patch 3:

1. feature names. We need aliases. Different QEMU versions on the same
hw might end up not understanding what a feature means. (old one: only
knows stfl_123, new one knows stfl_123 a.k.a crazy_feat)

2. CPU model compatibility checks. We suddenly support _in this QEMU
version_ CPU features for CPU models that were never defined.

E.g. somewhen in the future I could say -z14,stfl_123=3Don

just because it is a transparent feature but maybe completely fanced by
ibc. Not good.

I can understand that we need something like that for development. I
propose something like a special cpu model for that (similar to
host-passthrough).

--=20

Thanks,

David / dhildenb
