Received: from eggs.gnu.org ([2001:4830:134:3::10]:58982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1evXib-0000cC-OM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 20:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1evXiY-0004pw-JI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 20:23:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1evXiY-0004mP-8R
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 20:23:02 -0400
MIME-Version: 1.0
Message-ID: <35513ca9-0395-4a86-9e77-ef947bfe518d@default>
Date: Mon, 12 Mar 2018 17:22:55 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH] KVM: x86: Add support for save/load
 MSR_SMI_COUNT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: konrad.wilk@oracle.com, rth@twiddle.net, pbonzini@redhat.com, mtosatti@redhat.com, habkost@redhat.com, kvm@vger.kernel.org


Another gentle ping.

(Just following "If your patch seems to have been ignored" section in QEMU'=
s submitting patches guidelines...)

----- liran.alon@oracle.com wrote:

> Gentle ping.
> (https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__patchwork.ozlabs.o=
rg_patch_878657_&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE=
&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D0Tkp5xsMC2T3S-eFyhiskC=
78npxkFbKd-ImC38ZLY6U&s=3DNac2AezmnhywhWwDPWr-KOimFCc0U72S3QBvuO0vvJs&e=3D)
>=20
> ----- liran.alon@oracle.com wrote:
>=20
> > This MSR returns the number of #SMIs that occurred on
> > CPU since boot.
> >=20
> > KVM commit 52797bf9a875 ("KVM: x86: Add emulation of
> MSR_SMI_COUNT")
> > introduced support for emulating this MSR.
> >=20
> > This commit adds support for QEMU to save/load this
> > MSR for migration purposes.
> >=20
> > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > ---
> >  target/i386/cpu.c     |  1 +
> >  target/i386/cpu.h     |  3 +++
> >  target/i386/kvm.c     | 13 +++++++++++++
> >  target/i386/machine.c | 20 ++++++++++++++++++++
> >  4 files changed, 37 insertions(+)
> >=20
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index b5e431e769da..ba9ec6a6116b 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3645,6 +3645,7 @@ static void x86_cpu_reset(CPUState *s)
> >      cpu_x86_update_cr0(env, 0x60000010);
> >      env->a20_mask =3D ~0x0;
> >      env->smbase =3D 0x30000;
> > +    env->msr_smi_count =3D 0;
> > =20
> >      env->idt.limit =3D 0xffff;
> >      env->gdt.limit =3D 0xffff;
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index faf39ec1ce77..254e557bb8fa 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1,3 +1,4 @@
> > +
> >  /*
> >   * i386 virtual CPU header
> >   *
> > @@ -359,6 +360,7 @@ typedef enum X86Seg {
> >  #define MSR_P6_PERFCTR0                 0xc1
> > =20
> >  #define MSR_IA32_SMBASE                 0x9e
> > +#define MSR_SMI_COUNT                   0x34
> >  #define MSR_MTRRcap                     0xfe
> >  #define MSR_MTRRcap_VCNT                8
> >  #define MSR_MTRRcap_FIXRANGE_SUPPORT    (1 << 8)
> > @@ -1123,6 +1125,7 @@ typedef struct CPUX86State {
> > =20
> >      uint64_t pat;
> >      uint32_t smbase;
> > +    uint64_t msr_smi_count;
> > =20
> >      uint32_t pkru;
> > =20
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index ad4b159b28af..a53735f266c5 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -92,6 +92,7 @@ static bool has_msr_hv_stimer;
> >  static bool has_msr_hv_frequencies;
> >  static bool has_msr_xss;
> >  static bool has_msr_spec_ctrl;
> > +static bool has_msr_smi_count;
> > =20
> >  static uint32_t has_architectural_pmu_version;
> >  static uint32_t num_architectural_pmu_gp_counters;
> > @@ -1124,6 +1125,9 @@ static int kvm_get_supported_msrs(KVMState
> *s)
> >                  case MSR_IA32_SMBASE:
> >                      has_msr_smbase =3D true;
> >                      break;
> > +                case MSR_SMI_COUNT:
> > +                    has_msr_smi_count =3D true;
> > +                    break;
> >                  case MSR_IA32_MISC_ENABLE:
> >                      has_msr_misc_enable =3D true;
> >                      break;
> > @@ -1633,6 +1637,9 @@ static int kvm_put_msrs(X86CPU *cpu, int
> level)
> >      if (has_msr_smbase) {
> >          kvm_msr_entry_add(cpu, MSR_IA32_SMBASE, env->smbase);
> >      }
> > +    if (has_msr_smi_count) {
> > +        kvm_msr_entry_add(cpu, MSR_SMI_COUNT, env->msr_smi_count);
> > +    }
> >      if (has_msr_bndcfgs) {
> >          kvm_msr_entry_add(cpu, MSR_IA32_BNDCFGS,
> env->msr_bndcfgs);
> >      }
> > @@ -1979,6 +1986,9 @@ static int kvm_get_msrs(X86CPU *cpu)
> >      if (has_msr_smbase) {
> >          kvm_msr_entry_add(cpu, MSR_IA32_SMBASE, 0);
> >      }
> > +    if (has_msr_smi_count) {
> > +        kvm_msr_entry_add(cpu, MSR_SMI_COUNT, 0);
> > +    }
> >      if (has_msr_feature_control) {
> >          kvm_msr_entry_add(cpu, MSR_IA32_FEATURE_CONTROL, 0);
> >      }
> > @@ -2205,6 +2215,9 @@ static int kvm_get_msrs(X86CPU *cpu)
> >          case MSR_IA32_SMBASE:
> >              env->smbase =3D msrs[i].data;
> >              break;
> > +        case MSR_SMI_COUNT:
> > +            env->msr_smi_count =3D msrs[i].data;
> > +            break;
> >          case MSR_IA32_FEATURE_CONTROL:
> >              env->msr_ia32_feature_control =3D msrs[i].data;
> >              break;
> > diff --git a/target/i386/machine.c b/target/i386/machine.c
> > index 361c05aedfdc..9432496cbda8 100644
> > --- a/target/i386/machine.c
> > +++ b/target/i386/machine.c
> > @@ -395,6 +395,25 @@ static const VMStateDescription
> > vmstate_msr_tsc_adjust =3D {
> >      }
> >  };
> > =20
> > +static bool msr_smi_count_needed(void *opaque)
> > +{
> > +    X86CPU *cpu =3D opaque;
> > +    CPUX86State *env =3D &cpu->env;
> > +
> > +    return env->msr_smi_count !=3D 0;
> > +}
> > +
> > +static const VMStateDescription vmstate_msr_smi_count =3D {
> > +    .name =3D "cpu/msr_smi_count",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D msr_smi_count_needed,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT64(env.msr_smi_count, X86CPU),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static bool tscdeadline_needed(void *opaque)
> >  {
> >      X86CPU *cpu =3D opaque;
> > @@ -952,6 +971,7 @@ VMStateDescription vmstate_x86_cpu =3D {
> >          &vmstate_avx512,
> >          &vmstate_xss,
> >          &vmstate_tsc_khz,
> > +        &vmstate_msr_smi_count,
> >  #ifdef TARGET_X86_64
> >          &vmstate_pkru,
> >  #endif
> > --=20
> > 1.9.1
