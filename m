Received: from eggs.gnu.org ([2001:4830:134:3::10]:35024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fL7k7-0001Pi-3Z
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fL7k3-0007v6-2j
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:54:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fL7k2-0007tv-PO
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:54:19 -0400
Date: Tue, 22 May 2018 10:54:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180522135413.GB25013@localhost.localdomain>
References: <1526949675-106737-1-git-send-email-babu.moger@amd.com>
	<1526949675-106737-3-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1526949675-106737-3-git-send-email-babu.moger@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 2/5] i386: Populate AMD Processor Cache
 Information for cpuid 0x8000001D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Mon, May 21, 2018 at 08:41:12PM -0400, Babu Moger wrote:
> Add information for cpuid 0x8000001D leaf. Populate cache topology info=
rmation
> for different cache types(Data Cache, Instruction Cache, L2 and L3) sup=
ported
> by 0x8000001D leaf. Please refer Processor Programming Reference (PPR) =
for AMD
> Family 17h Model for more details.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  target/i386/kvm.c |  29 +++++++++++++--
>  2 files changed, 129 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d9773b6..1dd060a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -336,6 +336,85 @@ static void encode_cache_cpuid80000006(CPUCacheInf=
o *l2,
>      }
>  }
> =20

The number of variables here is large, so maybe we should
document what each one mean so it's easier to review:


> +/* Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E =
*/
> +/* Please refer AMD64 Architecture Programmer=E2=80=99s Manual Volume =
3 */
> +#define MAX_CCX 2

CCX is "core complex", right?  A comment would be useful here.

> +#define MAX_CORES_IN_CCX 4
> +#define MAX_NODES_EPYC 4

A comment explaining why it's OK to use a EPYC-specific constant
here would be useful.


> +#define MAX_CORES_IN_NODE 8
> +
> +/* Number of logical processors sharing L3 cache */
> +#define NUM_SHARING_CACHE(threads, num_sharing)   ((threads > 1) ? \
> +                         (((num_sharing - 1) * threads) + 1)  : \
> +                         (num_sharing - 1))

This formula is confusing to me.  If 4 cores are sharing the
cache and threads=3D=3D1, 4 logical processors share the cache, and
we return 3.  Sounds OK.

But, if 4 cores are sharing the cache and threads=3D=3D2, the number
of logical processors sharing the cache is 8.  We should return
7.  The formula above returns (((4 - 1) * 2) + 1), which is
correct.

But isn't it simpler to write this as:

#define NUM_SHARING_CACHE(threads, num_sharing) \
        (((num_sharing) * (threads)) - 1)


(Maybe the "- 1" part could be moved outside the macro for
clarity.  See below.)


> +/*
> + * L3 Cache is shared between all the cores in a core complex.
> + * Maximum cores that can share L3 is 4.
> + */
> +static int num_sharing_l3_cache(int nr_cores)

Can we document what exactly this function is going to return?
This returns the number of cores sharing l3 cache, not the number
of logical processors, correct?


> +{
> +    int i, nodes =3D 1;
> +
> +    /* Check if we can fit all the cores in one CCX */
> +    if (nr_cores <=3D MAX_CORES_IN_CCX) {
> +        return nr_cores;
> +    }
> +    /*
> +     * Figure out the number of nodes(or dies) required to build
> +     * this config. Max cores in a node is 8
> +     */
> +    for (i =3D nodes; i <=3D MAX_NODES_EPYC; i++) {
> +        if (nr_cores <=3D (i * MAX_CORES_IN_NODE)) {
> +            nodes =3D i;
> +            break;
> +        }
> +        /* We support nodes 1, 2, 4 */
> +        if (i =3D=3D 3) {
> +            continue;
> +        }
> +    }

"continue" as the very last statement of a for loop does nothing,
so it looks like this could be written as:

    for (i =3D nodes; i <=3D MAX_NODES_EPYC; i++) {
        if (nr_cores <=3D (i * MAX_CORES_IN_NODE)) {
            nodes =3D i;
            break;
        }
    }

which in turn seems to be the same as:

    nodes =3D DIV_ROUND_UP(nr_cores, MAX_CORES_IN_NODE);
    nodes =3D MIN(nodes, MAX_NODES_EPYC)

But, is this really what we want here?


> +    /* Spread the cores accros all the CCXs and return max cores in a =
ccx */
> +    return (nr_cores / (nodes * MAX_CCX)) +
> +            ((nr_cores % (nodes * MAX_CCX)) ? 1 : 0);

This also seems to be the same as DIV_ROUND_UP?

    return DIV_ROUND_UP(nr_cores, nodes * MAX_CCX);

I didn't confirm the logic is valid, though, because I don't know
what we should expect.  What is the expected return value of this
function in the following cases?

 -smp 24,sockets=3D2,cores=3D12,threads=3D1
 -smp 64,sockets=3D2,cores=3D32,threads=3D1


> +}
> +
> +/* Encode cache info for CPUID[8000001D] */
> +static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *=
cs,
> +                                uint32_t *eax, uint32_t *ebx,
> +                                uint32_t *ecx, uint32_t *edx)
> +{
> +    uint32_t num_share_l3;
> +    assert(cache->size =3D=3D cache->line_size * cache->associativity =
*
> +                          cache->partitions * cache->sets);
> +
> +    *eax =3D CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
> +               (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
> +
> +    /* L3 is shared among multiple cores */
> +    if (cache->level =3D=3D 3) {
> +        num_share_l3 =3D num_sharing_l3_cache(cs->nr_cores);
> +        *eax |=3D (NUM_SHARING_CACHE(cs->nr_threads, num_share_l3) << =
14);

Considering that the line below has an explicit "- 1", I think
the "- 1" part could be moved outside the NUM_SHARING_CACHE
macro, and used explicitly here.

But then the NUM_SHARING_CACHE would be just a simple
multiplication, so this could be simply written as:

    /* num_sharing_l3_cache() renamed to cores_sharing_l3_cache() */
    uint32_t l3_cores =3D cores_sharing_l3_cache(cs->nr_cores);
    uint32_t l3_logical_processors =3D l3_cores * cs->nr_threads;
    *eax |=3D (l3_logical_processors - 1) << 14;

> +    } else {
> +        *eax |=3D ((cs->nr_threads - 1) << 14);
> +    }
> +
> +    assert(cache->line_size > 0);
> +    assert(cache->partitions > 0);
> +    assert(cache->associativity > 0);
> +    /* We don't implement fully-associative caches */
> +    assert(cache->associativity < cache->sets);
> +    *ebx =3D (cache->line_size - 1) |
> +           ((cache->partitions - 1) << 12) |
> +           ((cache->associativity - 1) << 22);
> +
> +    assert(cache->sets > 0);
> +    *ecx =3D cache->sets - 1;
> +
> +    *edx =3D (cache->no_invd_sharing ? CACHE_NO_INVD_SHARING : 0) |
> +           (cache->inclusive ? CACHE_INCLUSIVE : 0) |
> +           (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
> +}
> +
>  /*
>   * Definitions of the hardcoded cache entries we expose:
>   * These are legacy cache values. If there is a need to change any
> @@ -4005,6 +4084,30 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t in=
dex, uint32_t count,
>              *edx =3D 0;
>          }
>          break;
> +    case 0x8000001D:
> +        *eax =3D 0;
> +        switch (count) {
> +        case 0: /* L1 dcache info */
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, =
cs,
> +                                       eax, ebx, ecx, edx);
> +            break;
> +        case 1: /* L1 icache info */
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, =
cs,
> +                                       eax, ebx, ecx, edx);
> +            break;
> +        case 2: /* L2 cache info */
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, c=
s,
> +                                       eax, ebx, ecx, edx);
> +            break;
> +        case 3: /* L3 cache info */
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, c=
s,
> +                                       eax, ebx, ecx, edx);
> +            break;
> +        default: /* end of info */
> +            *eax =3D *ebx =3D *ecx =3D *edx =3D 0;
> +            break;
> +        }
> +        break;
>      case 0xC0000000:
>          *eax =3D env->cpuid_xlevel2;
>          *ebx =3D 0;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index d6666a4..a8bf7eb 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -979,9 +979,32 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>          c =3D &cpuid_data.entries[cpuid_i++];
> =20
> -        c->function =3D i;
> -        c->flags =3D 0;
> -        cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +        switch (i) {
> +        case 0x8000001d:
> +            /* Query for all AMD cache information leaves */
> +            for (j =3D 0; ; j++) {
> +                c->function =3D i;
> +                c->flags =3D KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +                c->index =3D j;
> +                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c=
->edx);
> +
> +                if (c->eax =3D=3D 0) {
> +                    break;
> +                }
> +                if (cpuid_i =3D=3D KVM_MAX_CPUID_ENTRIES) {
> +                    fprintf(stderr, "cpuid_data is full, no space for =
"
> +                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
> +                    abort();
> +                }
> +                c =3D &cpuid_data.entries[cpuid_i++];
> +            }
> +            break;
> +        default:
> +            c->function =3D i;
> +            c->flags =3D 0;
> +            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->ed=
x);
> +            break;
> +        }
>      }
> =20
>      /* Call Centaur's CPUID instructions they are supported. */
> --=20
> 1.8.3.1
>=20

--=20
Eduardo
