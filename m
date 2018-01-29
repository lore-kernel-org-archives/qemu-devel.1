Received: from eggs.gnu.org ([2001:4830:134:3::10]:36218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1eg3TS-0006dN-Ar
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1eg3TM-0000SL-2Y
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:03:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:52191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luwei.kang@intel.com>)
	id 1eg3TL-0000RY-Mg
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:03:20 -0500
From: "Kang, Luwei" <luwei.kang@intel.com>
Date: Mon, 29 Jan 2018 07:03:13 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167E9614F@SHSMSX101.ccr.corp.intel.com>
References: <1516904751-10248-1-git-send-email-luwei.kang@intel.com>
	<20180126191410.GJ25150@localhost.localdomain>
In-Reply-To: <20180126191410.GJ25150@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/2] i386: Add Intel Processor Trace
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>

> > From: Chao Peng <chao.p.peng@linux.intel.com>
> >
> > Expose Intel Processor Trace feature to guest.
> >
> > In order to make this feature migration-safe, new feature word
> > information "FEAT_INTEL_PT_EBX" and "FEAT_INTEL_PT_ECX" be added.
> > Some constant value initialized in CPUID[0x14].0x01 to guarantee get
> > same result in diffrent hardware when this feature is enabled.
> >
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > ---
> > v1->v2:
> >  - In order to make this feature migration-safe, new feature word
> >    information "FEAT_INTEL_PT_EBX" and "FEAT_INTEL_PT_ECX" be added.
> >    Some constant value initialized in CPUID[0x14].0x01 to guarantee
> >    get same result in diffrent hardware when this feature is enabled.
> >
> > ---
> >  target/i386/cpu.c | 68
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  target/i386/cpu.h |  6 +++++
> >  target/i386/kvm.c | 23 +++++++++++++++++++
> >  3 files changed, 95 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index
> > a49d222..ee8c6e6 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -172,7 +172,11 @@
> >  #define L2_ITLB_4K_ASSOC       4
> >  #define L2_ITLB_4K_ENTRIES   512
> >
> > -
> > +/* CPUID Leaf 0x14 constants: */
> > +#define INTLE_PT_ADDR_RANGES_NUM 2
> > +#define INTEL_PT_MTC_BITMAP      (0x0249 << 16) /* Support ART(0,3,6,9=
) */
> > +#define INTEL_PT_CYCLE_BITMAP    0x3fff         /* Support 0,2^(0~12) =
*/
> > +#define INTEL_PT_PSB_BITMAP      (0x003f << 16) /* Support 2K,4K,8K,16=
K,32K,64K */
> >
> >  static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
> >                                       uint32_t vendor2, uint32_t
> > vendor3) @@ -427,7 +431,7 @@ static FeatureWordInfo feature_word_info[F=
EATURE_WORDS] =3D {
> >              NULL, NULL, "mpx", NULL,
> >              "avx512f", "avx512dq", "rdseed", "adx",
> >              "smap", "avx512ifma", "pcommit", "clflushopt",
> > -            "clwb", NULL, "avx512pf", "avx512er",
> > +            "clwb", "intel-pt", "avx512pf", "avx512er",
> >              "avx512cd", "sha-ni", "avx512bw", "avx512vl",
> >          },
> >          .cpuid_eax =3D 7,
> > @@ -545,6 +549,38 @@ static FeatureWordInfo feature_word_info[FEATURE_W=
ORDS] =3D {
> >          .cpuid_reg =3D R_EDX,
> >          .tcg_features =3D ~0U,
> >      },
> > +    [FEAT_INTEL_PT_EBX] =3D {
> > +        .feat_names =3D {
> > +            "cr3-filter", "psb-cycle", "filtering", "mtc-cofi",
> > +            "ptwrite", "power-evt", NULL, NULL,
>=20
> Note that this will make all those bits configurable on the command-line.=
  You don't really need to do this in the first version, if you
> don't really want to.
>=20
> Also, if we want to make this configurable, we will need to choose carefu=
lly the property names, because changing them later would
> be more difficult.
>=20
> Note that the feature names live in a single QOM property namespace, so "=
filtering", "any-entries" and "transport" are probably too
> generic.  Maybe we could prefix all names here with "intel-pt-" or "pt-"?
>=20
> If you don't want to make all bits configurable on the first version, you=
 can fill the CPUID[14h] bits with constant default values just
> like you did with the INTEL_PT_* constants below.
>=20

Agree, I think it is too complex to make all Intel PT sub-feature configura=
ble in command line. We also need make some short and clear enough property=
 names for each sub-feature.

>=20
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +        },
> > +        .cpuid_eax =3D 0x14,
> > +        .cpuid_needs_ecx =3D true, .cpuid_ecx =3D 0,
> > +        .cpuid_reg =3D R_EBX,
> > +        .tcg_features =3D ~0U,
>=20
> TCG doesn't implement this feature, so ~0U doesn't look right.
>=20
>=20
> > +    },
> > +    [FEAT_INTEL_PT_ECX] =3D {
> > +        .feat_names =3D {
> > +            "topa-output", "any-entries", "single-range", "transport",
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +        },
> > +        .cpuid_eax =3D 0x14,
> > +        .cpuid_needs_ecx =3D true, .cpuid_ecx =3D 0,
> > +        .cpuid_reg =3D R_ECX,
> > +        .tcg_features =3D ~0U,
>=20
> Same as above.
>=20
> > +    },
> >  };
> >
> >  typedef struct X86RegisterInfo32 {
> > @@ -3452,6 +3488,34 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t in=
dex, uint32_t count,
> >          }
> >          break;
> >      }
> > +    case 0x14: {
> > +	/* Intel Processor Trace Enumeration */
> > +        *eax =3D 0;
> > +        *ebx =3D 0;
> > +        *ecx =3D 0;
> > +        *edx =3D 0;
> > +        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
> > +             !kvm_enabled()) {
> > +            break;
> > +        }
> > +
> > +        if (count =3D=3D 0) {
> > +            *eax =3D 1;
> > +            *ebx =3D env->features[FEAT_INTEL_PT_EBX];
> > +            *ecx =3D env->features[FEAT_INTEL_PT_ECX];
> > +        } else if (count =3D=3D 1) {
> > +            *eax =3D INTLE_PT_ADDR_RANGES_NUM;
> > +            if (env->features[FEAT_INTEL_PT_EBX] &
> > +                    CPUID_INTEL_PT_EBX_MTC_COFI) {
> > +                *eax |=3D INTEL_PT_MTC_BITMAP;
> > +            }
> > +            if (env->features[FEAT_INTEL_PT_EBX] &
> > +                    CPUID_INTEL_PT_EBX_PSB_CYCLE) {
> > +                *ebx =3D INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP;
> > +            }
>=20
> We still need to validate the bitmaps and number of ranges against the ho=
st capabilities (reported on GET_SUPPORTED_CPUID),
> don't we?

Yes, we need to validate the bitmaps and number of ranges against the host =
capabilities. For example,  MSR_IA32_RTIT_CTL.MTCFreq only support the valu=
e defined in bitmap or will cause #GP fault.

>=20
> If you are going to set CPUID bits that are not already present on env->f=
eatures[], you will want x86_cpu_filter_features() to
> manually validate the constants against x86_cpu_get_supported_feature_wor=
d(), to ensure we won't try to enable unsupported
> bits.
>=20
> (If doing that, we need to make sure CPUID_7_0_EBX_INTEL_PT will be set o=
n xc->filtered_features[FEAT_7_0_EBX] if something is
> unsupported, to tell the calling code that intel-pt can't be enabled on t=
he current host)
>=20

So, Can I make all the value in CPUID[14] as constant and make the CPUID in=
formation get from IceLake hardware as default(minimal) value.
CPUID[14] available only when Intel PT is supported and enabled.
We also need to check the host value by kvm_arch_get_supported_cpuid().  If=
 something is unsupported in minimal value Intel PT can't be enabled.  I di=
dn't use x86_cpu_get_supported_feature_word() because the value of CPUID[14=
] will all be constant hence sub-leaf FEAT_INTEL_PT_EBX/ FEAT_INTEL_PT_ECX =
are unnecessary(will remove in next version).
Please help correct me if anything wrong.

Thanks,
Luwei Kang

> In the future we could extend FeatureWordInfo to make it easier to handle=
 counter/bitmap fields like those, then we won't need
> special cases inside x86_cpu_filter_features().
>=20
>=20
