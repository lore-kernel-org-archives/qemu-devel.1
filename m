Received: from eggs.gnu.org ([2001:4830:134:3::10]:60128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1ejaxN-0008Uj-Ey
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1ejaxI-000581-0Y
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:24:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:52499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luwei.kang@intel.com>)
	id 1ejaxH-00054q-K8
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:24:51 -0500
From: "Kang, Luwei" <luwei.kang@intel.com>
Date: Thu, 8 Feb 2018 01:24:46 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167EC22C8@SHSMSX101.ccr.corp.intel.com>
References: <1517414266-12077-1-git-send-email-luwei.kang@intel.com>
	<20180207145358.GI13301@localhost.localdomain>
In-Reply-To: <20180207145358.GI13301@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/2] i386: Add Intel Processor Trace
 feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

> On Wed, Jan 31, 2018 at 11:57:45PM +0800, Luwei Kang wrote:
> > From: Chao Peng <chao.p.peng@linux.intel.com>
> >
> > Expose Intel Processor Trace feature to guest.
> >
> > To make Intel PT live migration safe and get same CPUID information
> > with same CPU model on diffrent host. CPUID[14] is constant in this
> > patch. Intel PT use EPT is first supported in IceLake, the CPUID[14]
> > get on this machine as default value. Intel PT would be disabled If
> > any machine don't support this minial feature list.
> >
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > ---
> >  target/i386/cpu.c | 53
> > +++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  target/i386/cpu.h |  1 +
> >  target/i386/kvm.c | 23 +++++++++++++++++++++++
> >  3 files changed, 75 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index
> > a49d222..aaa427a 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -172,7 +172,14 @@
> >  #define L2_ITLB_4K_ASSOC       4
> >  #define L2_ITLB_4K_ENTRIES   512
> >
> > -
> > +/* CPUID Leaf 0x14 constants: */
> > +#define INTLE_PT_MAX_SUBLEAF     0x1
>=20
> Typo.
>=20
> > +#define INTEL_PT_MINIMAL_EBX     0xf
> > +#define INTEL_PT_MINIMAL_ECX     0x7
>=20
> I suggest documenting what capabilities are included in
> INTEL_PT_MINIMAL_* here.
>=20
>=20
> > +#define INTLE_PT_ADDR_RANGES_NUM 0x2 /* Number of configurable
> > +address ranges */
>=20
> Typo.
>=20
> > +#define INTEL_PT_MTC_BITMAP      (0x0249 << 16) /* Support ART(0,3,6,9=
) */
> > +#define INTEL_PT_CYCLE_BITMAP    0x1fff         /* Support 0,2^(0~11) =
*/
> > +#define INTEL_PT_PSB_BITMAP      (0x003f << 16) /* Support 2K,4K,8K,16=
K,32K,64K */
> >
> >  static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
> >                                       uint32_t vendor2, uint32_t
> > vendor3) @@ -427,7 +434,7 @@ static FeatureWordInfo feature_word_info[F=
EATURE_WORDS] =3D {
> >              NULL, NULL, "mpx", NULL,
> >              "avx512f", "avx512dq", "rdseed", "adx",
> >              "smap", "avx512ifma", "pcommit", "clflushopt",
> > -            "clwb", NULL, "avx512pf", "avx512er",
> > +            "clwb", "intel-pt", "avx512pf", "avx512er",
> >              "avx512cd", "sha-ni", "avx512bw", "avx512vl",
> >          },
> >          .cpuid_eax =3D 7,
> > @@ -3452,6 +3459,27 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t in=
dex, uint32_t count,
> >          }
> >          break;
> >      }
> > +    case 0x14: {
> > +        /* Intel Processor Trace Enumeration */
> > +        *eax =3D 0;
> > +        *ebx =3D 0;
> > +        *ecx =3D 0;
> > +        *edx =3D 0;
> > +        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
> > +            !kvm_enabled()) {
> > +            break;
> > +        }
> > +
> > +        if (count =3D=3D 0) {
> > +            *eax =3D INTLE_PT_MAX_SUBLEAF;
> > +            *ebx =3D INTEL_PT_MINIMAL_EBX;
> > +            *ecx =3D INTEL_PT_MINIMAL_ECX;
> > +        } else if (count =3D=3D 1) {
> > +            *eax =3D INTEL_PT_MTC_BITMAP | INTLE_PT_ADDR_RANGES_NUM;
> > +            *ebx =3D INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP;
> > +        }
> > +        break;
> > +    }
> >      case 0x40000000:
> >          /*
> >           * CPUID code in kvm_arch_init_vcpu() ignores stuff @@
> > -4082,6 +4110,27 @@ static int x86_cpu_filter_features(X86CPU *cpu)
> >          }
> >      }
> >
> > +    if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) {
>=20
> What if the accelerator is not KVM, but is reporting intel-pt as supporte=
d?

I have add this check in cpu_x86_cpuid() but I think we'd better add kvm_en=
abled() check here as well.
What is your opinion?

>=20
> > +        KVMState *s =3D CPU(cpu)->kvm_state;
> > +        uint32_t eax_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_=
EAX);
> > +        uint32_t ebx_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_=
EBX);
> > +        uint32_t ecx_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_=
ECX);
> > +        uint32_t eax_1 =3D kvm_arch_get_supported_cpuid(s, 0x14, 1, R_=
EAX);
> > +        uint32_t ebx_1 =3D kvm_arch_get_supported_cpuid(s, 0x14, 1,
> > + R_EBX);
> > +
> > +        if (!eax_0 ||
>=20
> OK.
>=20
> > +           ((ebx_0 & INTEL_PT_MINIMAL_EBX) !=3D INTEL_PT_MINIMAL_EBX)
> > + ||
>=20
> How do we know if KVM is going to emulate #GP properly when setting a bit=
 that is supported by the host CPU but cleared on the
> guest CPUID?  Do we care?

I think it need KVM make this check and Qemu don't need aware this.
For example, EBX[0].CR3_filter (IA32_RTIT_CTL.cr3 can't be set if 0) is sup=
port by host but we mask off this bit in kvm guest. Qemu will set the CPUID=
 to KVM by ioctl KVM_SET_CPUID2. KVM will trap the behavior when KVM guest =
want to set IA32_RTIT_CTL.cr3. If we find EBX[0].CR3_filter is not supporte=
d a #GP will be emulated. This check will added in KVM patch set V5 and it =
still working in progress.

>=20
> > +           ((ecx_0 & INTEL_PT_MINIMAL_ECX) !=3D INTEL_PT_MINIMAL_ECX)
> > + ||
>=20
> Same comment as above.
>=20
> Also: bit 31 must match the host, meaning we must reject a host where ecx=
_0 & (1 << 31) is set.

Get it, will add in next version.

>=20
>=20
> > +           ((eax_1 & (INTLE_PT_ADDR_RANGES_NUM | INTEL_PT_MTC_BITMAP))=
 !=3D
> > +                (INTLE_PT_ADDR_RANGES_NUM | INTEL_PT_MTC_BITMAP)) ||
>=20
> This will make the code accept hosts with 3 address ranges (0b011), but r=
eject ones with 4 address ranges (0b100).  This doesn't
> sound right to me.

I see, will fix it.

>=20
>=20
> > +           ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) !=
=3D
> > +                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP))) {
>=20
> How do we know if KVM is going to emulate #GP properly when setting an in=
valid CycThresh or PSBFreq value?  Do we care?

It will check in KVM and will emulate a #GP if set an invalid value but I t=
hink qemu can't aware this.
>From my point of view, I think qemu don't need to care or get this informat=
ion.

>=20
>=20
> > +            env->features[FEAT_7_0_EBX] &=3D ~CPUID_7_0_EBX_INTEL_PT;
> > +            cpu->filtered_features[FEAT_7_0_EBX] |=3D
> > + CPUID_7_0_EBX_INTEL_PT;
>=20
> This matches what I have suggested.  But I recommend adding a comment men=
tioning why we do this.  Something like:
>=20
>  /*
>   * Processor Trace capabilities aren't configurable, so if the
>   * host can't emulate the capabilities we report on
>   * cpu_x86_cpuid(), intel-pt can't be enabled on the current host.
>   */

Agree.

Thanks a lot for the code review.

Luwei Kang

>=20
>=20
> > +            rv =3D 1;
> > +        }
> > +    }
> > +
> >      return rv;
> >  }
> >
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h index
> > f91e37d..7facc8b 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -644,6 +644,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
> > #define CPUID_7_0_EBX_PCOMMIT  (1U << 22) /* Persistent Commit */
> > #define CPUID_7_0_EBX_CLFLUSHOPT (1U << 23) /* Flush a Cache Line Optim=
ized */
> >  #define CPUID_7_0_EBX_CLWB     (1U << 24) /* Cache Line Write Back */
> > +#define CPUID_7_0_EBX_INTEL_PT (1U << 25) /* Intel Processor Trace */
> >  #define CPUID_7_0_EBX_AVX512PF (1U << 26) /* AVX-512 Prefetch */
> > #define CPUID_7_0_EBX_AVX512ER (1U << 27) /* AVX-512 Exponential and
> > Reciprocal */  #define CPUID_7_0_EBX_AVX512CD (1U << 28) /* AVX-512
> > Conflict Detection */ diff --git a/target/i386/kvm.c
> > b/target/i386/kvm.c index ad4b159..f9f4cd1 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -865,6 +865,29 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >                  c =3D &cpuid_data.entries[cpuid_i++];
> >              }
> >              break;
> > +        case 0x14: {
> > +            uint32_t times;
> > +
> > +            c->function =3D i;
> > +            c->index =3D 0;
> > +            c->flags =3D KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> > +            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->ed=
x);
> > +            times =3D c->eax;
> > +
> > +            for (j =3D 1; j <=3D times; ++j) {
> > +                if (cpuid_i =3D=3D KVM_MAX_CPUID_ENTRIES) {
> > +                    fprintf(stderr, "cpuid_data is full, no space for =
"
> > +                                "cpuid(eax:0x14,ecx:0x%x)\n", j);
> > +                    abort();
> > +                }
> > +                c =3D &cpuid_data.entries[cpuid_i++];
> > +                c->function =3D i;
> > +                c->index =3D j;
> > +                c->flags =3D KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> > +                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c=
->edx);
> > +            }
> > +            break;
> > +        }
> >          default:
> >              c->function =3D i;
> >              c->flags =3D 0;
> > --
> > 1.8.3.1
> >
> >
>=20
> --
> Eduardo
