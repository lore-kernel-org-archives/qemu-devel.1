Received: from eggs.gnu.org ([2001:4830:134:3::10]:34283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fJ23k-0005ig-In
	for qemu-devel@nongnu.org; Wed, 16 May 2018 15:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fJ23g-0005y0-EK
	for qemu-devel@nongnu.org; Wed, 16 May 2018 15:26:00 -0400
Received: from mail-bn3nam01on0051.outbound.protection.outlook.com
	([104.47.33.51]:17920
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fJ23g-0005w5-4P
	for qemu-devel@nongnu.org; Wed, 16 May 2018 15:25:56 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Wed, 16 May 2018 19:25:53 +0000
Message-ID: <SN1PR12MB24776FFE9477B3FC6259274D95920@SN1PR12MB2477.namprd12.prod.outlook.com>
References: <20180514164156.27034-1-babu.moger@amd.com>
	<20180514164156.27034-4-babu.moger@amd.com>
	<20180514194705.GB25013@localhost.localdomain>
	<SN1PR12MB2477C16786E8FAF00884B3A1959C0@SN1PR12MB2477.namprd12.prod.outlook.com>
	<20180516125224.GH25013@localhost.localdomain>
In-Reply-To: <20180516125224.GH25013@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 3/7] i386: Populate AMD Processor Cache
 Information for cpuid 0x8000001D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "geoff@hostfission.com" <geoff@hostfission.com>, "kash@tripleback.net" <kash@tripleback.net>


> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Wednesday, May 16, 2018 7:52 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; geoff@hostfission.com; kash@tripleback.net
> Subject: Re: [PATCH v9 3/7] i386: Populate AMD Processor Cache Informatio=
n
> for cpuid 0x8000001D
>=20
> On Mon, May 14, 2018 at 11:49:30PM +0000, Moger, Babu wrote:
> >
> > > -----Original Message-----
> > > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > > Sent: Monday, May 14, 2018 2:47 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: mst@redhat.com; marcel.apfelbaum@gmail.com;
> pbonzini@redhat.com;
> > > rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > > kvm@vger.kernel.org; geoff@hostfission.com; kash@tripleback.net
> > > Subject: Re: [PATCH v9 3/7] i386: Populate AMD Processor Cache
> Information
> > > for cpuid 0x8000001D
> > >
> > > On Mon, May 14, 2018 at 11:41:52AM -0500, Babu Moger wrote:
> > > > Add information for cpuid 0x8000001D leaf. Populate cache topology
> > > information
> > > > for different cache types(Data Cache, Instruction Cache, L2 and L3)
> > > supported
> > > > by 0x8000001D leaf. Please refer Processor Programming Reference
> (PPR)
> > > for AMD
> > > > Family 17h Model for more details.
> > > >
> > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > > > ---
> > > >  target/i386/cpu.c | 79
> > > +++++++++++++++++++++++++++++++++++++++++++++++
> > > >  target/i386/kvm.c | 29 +++++++++++++++--
> > > >  2 files changed, 105 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > index e1daff37ab..7f40241786 100644
> > > > --- a/target/i386/cpu.c
> > > > +++ b/target/i386/cpu.c
> > > > @@ -307,6 +307,14 @@ static uint32_t
> > > encode_cache_cpuid80000005(CPUCacheInfo *cache)
> > > >                            a =3D=3D ASSOC_FULL ? 0xF : \
> > > >                            0 /* invalid value */)
> > > >
> > > > +/* Definitions used on CPUID Leaf 0x8000001D */
> > > > +/* Number of logical cores in a complex */
> > > > +#define CORES_IN_CMPLX  4
> > >
> > > Number of cores is configurable in QEMU, so we can't hardcode
> > > this.
> >
> > In EPYC architecture, in a single die we have 2 core complexes.
> >  Each core complex has 4 cores at max(CORES_IN_CMPLX).
> > Without SMT(thread=3D1), L3 is shared between 4(4x1) cores.
> >    NUM_SHARING_CACHE should be 3.
> > With SMT(thread=3D2), L3 is shared between 8(4x2) cores.
> >   NUM_SHARING_CACHE should be 7.
> > This is what we are trying to achieve here. This is a fixed h/w configu=
ration.
>=20
> There's nothing in this part of the code that makes it specific
> to the EPYC CPU model, so it has to be more generic.  But
> probably my suggestion wasn't correct either.  Se my question
> below:
>=20
>=20
> >
> > >
> > > I understand you want to make it match the hardware as close as
> > > possible (as you noted in your reply on v7), but this should be
> > > done by simply configuring QEMU as closely to the hardware as
> > > possible.
> > >
> > >
> > > > +/* Number of logical processors sharing cache */
> > > > +#define NUM_SHARING_CACHE(threads)   ((threads > 1) ? \
> > > > +                         (((CORES_IN_CMPLX - 1) * threads) + 1)  :=
 \
> > > > +                         (CORES_IN_CMPLX - 1))
> > >
> > > I don't see why the check for threads > 1, here.  Why not simply
> > > write this as:
> > >
> > >   ((nr_cores * nr_threads) - 1))
> > >
> > > which will work for any cores/threads value?
> >
> > We cannot achieve the above numbers if we use this logic.
> > For example.. with nr_cores =3D 8, nr_threads=3D2.
> >   This will report (8x2)-1=3D15 which is not what we want.
>=20
> I'm confused.  What would be the correct value for
> Fn8000_001D_EAX_x[25:14] for a 8-core 2-threads-per-core CPU?
>=20
> I assumed the L3 cache would be shared by the whole socket, but
> it's shared only by a core complex (which has 4 cores in EPYC).
> Is that right?

That is correct.

>=20
> So, what would be a reasonable value for Fn8000_001D_EAX_3[25:14]
> for the following configurations?
>=20
>   -cpu EPYC,cores=3D2,threads=3D1
    1
>   -cpu EPYC,cores=3D2,threads=3D2
    3
>   -cpu EPYC,cores=3D3,threads=3D1
     2
>   -cpu EPYC,cores=3D3,threads=3D2
    5
>   -cpu EPYC,cores=3D4,threads=3D1
     3
>   -cpu EPYC,cores=3D4,threads=3D2
     7
>   -cpu EPYC,cores=3D5,threads=3D1
>   -cpu EPYC,cores=3D5,threads=3D2
>   -cpu EPYC,cores=3D6,threads=3D1
>   -cpu EPYC,cores=3D6,threads=3D2
>   -cpu EPYC,cores=3D7,threads=3D1
>   -cpu EPYC,cores=3D7,threads=3D2
>   -cpu EPYC,cores=3D8,threads=3D1
>   -cpu EPYC,cores=3D8,threads=3D2
>   -cpu EPYC,cores=3D9,threads=3D1
>   -cpu EPYC,cores=3D9,threads=3D2

Some of these combinations are not valid.   We are thinking of coming up wi=
th a statically=20
defined data model and pickup the model that best fits the above parameter =
or something like that.
We may have to report Invalid for some of the combinations. Still thinking.=
 Let me know if you think
of any better way to handle it or if there are similar cases which are alre=
ady handled which we can base on.

>=20
> >
> > >
> > > (Or the function could just get nr_logical_cpus argument like I
> > > suggested on v7, to make the code here simpler.)
> > >
> > >
> > > > +
> > > >  /*
> > > >   * Encode cache info for CPUID[0x80000006].ECX and
> > > CPUID[0x80000006].EDX
> > > >   * @l3 can be NULL.
> > > > @@ -336,6 +344,41 @@ static void
> > > encode_cache_cpuid80000006(CPUCacheInfo *l2,
> > > >      }
> > > >  }
> > > >
> > > > +/* Encode cache info for CPUID[8000001D] */
> > > > +static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, int
> > > nr_threads,
> > > > +                                uint32_t *eax, uint32_t *ebx,
> > > > +                                uint32_t *ecx, uint32_t *edx)
> > > > +{
> > > > +    assert(cache->size =3D=3D cache->line_size * cache->associativ=
ity *
> > > > +                          cache->partitions * cache->sets);
> > > > +
> > > > +    *eax =3D CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
> > > > +               (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
> > > > +
> > > > +    /* L3 is shared among multiple cores */
> > > > +    if (cache->level =3D=3D 3) {
> > > > +        *eax |=3D (NUM_SHARING_CACHE(nr_threads) << 14);
> > > > +    } else {
> > > > +        *eax |=3D ((nr_threads - 1) << 14);
> > > > +    }
> > > > +
> > > > +    assert(cache->line_size > 0);
> > > > +    assert(cache->partitions > 0);
> > > > +    assert(cache->associativity > 0);
> > > > +    /* We don't implement fully-associative caches */
> > > > +    assert(cache->associativity < cache->sets);
> > > > +    *ebx =3D (cache->line_size - 1) |
> > > > +           ((cache->partitions - 1) << 12) |
> > > > +           ((cache->associativity - 1) << 22);
> > > > +
> > > > +    assert(cache->sets > 0);
> > > > +    *ecx =3D cache->sets - 1;
> > > > +
> > > > +    *edx =3D (cache->no_invd_sharing ? CACHE_NO_INVD_SHARING : 0)
> |
> > > > +           (cache->inclusive ? CACHE_INCLUSIVE : 0) |
> > > > +           (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Definitions of the hardcoded cache entries we expose:
> > > >   * These are legacy cache values. If there is a need to change any
> > > > @@ -4035,6 +4078,42 @@ void cpu_x86_cpuid(CPUX86State *env,
> > > uint32_t index, uint32_t count,
> > > >              *edx =3D 0;
> > > >          }
> > > >          break;
> > > > +    case 0x8000001D:
> > > > +        *eax =3D 0;
> > > > +        CPUCacheInfo *l1d, *l1i, *l2, *l3;
> > > > +        if (env->cache_info && !cpu->legacy_cache) {
> > > > +            l1d =3D &env->cache_info->l1d_cache;
> > > > +            l1i =3D &env->cache_info->l1i_cache;
> > > > +            l2 =3D &env->cache_info->l2_cache;
> > > > +            l3 =3D &env->cache_info->l3_cache;
> > > > +        } else {
> > > > +            l1d =3D &legacy_l1d_cache_amd;
> > > > +            l1i =3D &legacy_l1i_cache_amd;
> > > > +            l2 =3D &legacy_l2_cache_amd;
> > > > +            l3 =3D &legacy_l3_cache;
> > > > +        }
> > > > +        switch (count) {
> > > > +        case 0: /* L1 dcache info */
> > > > +            encode_cache_cpuid8000001d(l1d, cs->nr_threads,
> > > > +                                       eax, ebx, ecx, edx);
> > > > +            break;
> > > > +        case 1: /* L1 icache info */
> > > > +            encode_cache_cpuid8000001d(l1i, cs->nr_threads,
> > > > +                                       eax, ebx, ecx, edx);
> > > > +            break;
> > > > +        case 2: /* L2 cache info */
> > > > +            encode_cache_cpuid8000001d(l2, cs->nr_threads,
> > > > +                                       eax, ebx, ecx, edx);
> > > > +            break;
> > > > +        case 3: /* L3 cache info */
> > > > +            encode_cache_cpuid8000001d(l3, cs->nr_threads,
> > > > +                                       eax, ebx, ecx, edx);
> > > > +            break;
> > > > +        default: /* end of info */
> > > > +            *eax =3D *ebx =3D *ecx =3D *edx =3D 0;
> > > > +            break;
> > > > +        }
> > > > +        break;
> > > >      case 0xC0000000:
> > > >          *eax =3D env->cpuid_xlevel2;
> > > >          *ebx =3D 0;
> > > > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > > > index 6c49954e68..6e66f9c51d 100644
> > > > --- a/target/i386/kvm.c
> > > > +++ b/target/i386/kvm.c
> > > > @@ -967,9 +967,32 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > > >          }
> > > >          c =3D &cpuid_data.entries[cpuid_i++];
> > > >
> > > > -        c->function =3D i;
> > > > -        c->flags =3D 0;
> > > > -        cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->ed=
x);
> > > > +        switch (i) {
> > > > +        case 0x8000001d:
> > > > +            /* Query for all AMD cache information leaves */
> > > > +            for (j =3D 0; ; j++) {
> > > > +                c->function =3D i;
> > > > +                c->flags =3D KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> > > > +                c->index =3D j;
> > > > +                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx=
, &c-
> >edx);
> > > > +
> > > > +                if (c->eax =3D=3D 0) {
> > > > +                    break;
> > > > +                }
> > > > +                if (cpuid_i =3D=3D KVM_MAX_CPUID_ENTRIES) {
> > > > +                    fprintf(stderr, "cpuid_data is full, no space =
for "
> > > > +                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
> > > > +                    abort();
> > > > +                }
> > > > +                c =3D &cpuid_data.entries[cpuid_i++];
> > > > +            }
> > > > +            break;
> > > > +        default:
> > > > +            c->function =3D i;
> > > > +            c->flags =3D 0;
> > > > +            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c=
->edx);
> > > > +            break;
> > > > +        }
> > > >      }
> > > >
> > > >      /* Call Centaur's CPUID instructions they are supported. */
> > > > --
> > > > 2.17.0
> > > >
> > >
> > > --
> > > Eduardo
>=20
> --
> Eduardo
