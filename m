Received: from eggs.gnu.org ([2001:4830:134:3::10]:58996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1ey3yd-00070j-RS
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 19:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1ey3yZ-0003mw-L5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 19:14:03 -0400
Received: from mail-bl2nam02on0085.outbound.protection.outlook.com
	([104.47.38.85]:47185
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1ey3yZ-0003lf-Ar
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 19:13:59 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 19 Mar 2018 23:13:50 +0000
Message-ID: <CY4PR12MB176825D4C365D47323524AAF95D40@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20180316223719.7528-1-ehabkost@redhat.com>
In-Reply-To: <20180316223719.7528-1-ehabkost@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.13] i386: Helpers to encode cache
 information consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Igor
	Mammedov <imammedo@redhat.com>, "Hook, Gary" <Gary.Hook@amd.com>, =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Kash Pande <kash@tripleback.net>

Hi Eduardo,
  Thanks for patches. I am verifying the patch right now.  Will respond tom=
orrow.


> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Friday, March 16, 2018 5:37 PM
> To: qemu-devel@nongnu.org
> Cc: Singh, Brijesh <brijesh.singh@amd.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Moger, Babu <Babu.Moger@amd.com>;
> Lendacky, Thomas <Thomas.Lendacky@amd.com>; Igor Mammedov
> <imammedo@redhat.com>; Hook, Gary <Gary.Hook@amd.com>; Eduardo
> Habkost <ehabkost@redhat.com>; Radim Kr=E8m=E1=F8 <rkrcmar@redhat.com>;
> Kash Pande <kash@tripleback.net>
> Subject: [PATCH for-2.13] i386: Helpers to encode cache information
> consistently
>=20
> Instead of having a collection of macros that need to be used in
> complex expressions to build CPUID data, define a CPUCacheInfo
> struct that can hold information about a given cache.  Helper
> functions will take a CPUCacheInfo struct as input to encode
> CPUID leaves for a cache.
>=20
> This will help us ensure consistency between cache information
> CPUID leaves, and make the existing inconsistencies in CPUID info
> more visible.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 525
> ++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 410 insertions(+), 115 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6bb4ce8719..1c0571cac5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -57,16 +57,226 @@
>  #include "disas/capstone.h"
>=20
>=20
> -/* Cache topology CPUID constants: */
> +/* Cache information data structures: */
>=20
> -/* CPUID Leaf 2 Descriptors */
> +enum CacheType {
> +    DCACHE,
> +    ICACHE,
> +    UNIFIED_CACHE
> +};
>=20
> -#define CPUID_2_L1D_32KB_8WAY_64B 0x2c
> -#define CPUID_2_L1I_32KB_8WAY_64B 0x30
> -#define CPUID_2_L2_2MB_8WAY_64B   0x7d
> -#define CPUID_2_L3_16MB_16WAY_64B 0x4d
> +struct CPUCacheInfo {
> +    enum CacheType type;
> +    uint8_t level;
> +    /* Size in bytes */
> +    uint32_t size;
> +    /* Line size, in bytes */
> +    uint16_t line_size;
> +    /*
> +     * Associativity.
> +     * Note: representation of fully-associative caches is not implement=
ed
> +     */
> +    uint8_t associativity;
> +    /* Physical line partitions. CPUID[0x8000001D].EBX, CPUID[4].EBX */
> +    uint8_t partitions;
> +    /* Number of sets. CPUID[0x8000001D].ECX, CPUID[4].ECX */
> +    uint32_t sets;
> +    /*
> +     * Lines per tag.
> +     * AMD-specific: CPUID[0x80000005], CPUID[0x80000006].
> +     * (Is this synonym to @partitions?)
> +     */
> +    uint8_t lines_per_tag;
> +
> +    /* Self-initializing cache */
> +    bool self_init;
> +    /*
> +     * WBINVD/INVD is not guaranteed to act upon lower level caches of
> +     * non-originating threads sharing this cache.
> +     * CPUID[4].EDX[bit 0], CPUID[0x8000001D].EDX[bit 0]
> +     */
> +    bool no_invd_sharing;
> +    /*
> +     * Cache is inclusive of lower cache levels.
> +     * CPUID[4].EDX[bit 1], CPUID[0x8000001D].EDX[bit 1].
> +     */
> +    bool inclusive;
> +    /*
> +     * A complex function is used to index the cache, potentially using =
all
> +     * address bits.  CPUID[4].EDX[bit 2].
> +     */
> +    bool complex_indexing;
> +};
>=20
>=20
> +/* Helpers for building CPUID[2] descriptors: */
> +
> +struct CPUID2CacheDescriptorInfo {
> +    enum CacheType type;
> +    int level;
> +    int size;
> +    int line_size;
> +    int associativity;
> +};
> +
> +#define KiB 1024
> +#define MiB (1024 * 1024)
> +
> +/*
> + * Known CPUID 2 cache descriptors.
> + * From Intel SDM Volume 2A, CPUID instruction
> + */
> +struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] =3D {
> +    [0x06] =3D { .level =3D 1, .type =3D ICACHE,        .size =3D   8 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 32, },
> +    [0x08] =3D { .level =3D 1, .type =3D ICACHE,        .size =3D  16 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 32, },
> +    [0x09] =3D { .level =3D 1, .type =3D ICACHE,        .size =3D  32 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    [0x0A] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D   8 * =
KiB,
> +               .associativity =3D 2,  .line_size =3D 32, },
> +    [0x0C] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  16 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 32, },
> +    [0x0D] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  16 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    [0x0E] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  24 * =
KiB,
> +               .associativity =3D 6,  .line_size =3D 64, },
> +    [0x1D] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 128 * =
KiB,
> +               .associativity =3D 2,  .line_size =3D 64, },
> +    [0x21] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 256 * =
KiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    /* lines per sector is not supported cpuid2_cache_descriptor(),
> +    * so descriptors 0x22, 0x23 are not included
> +    */
> +    [0x24] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
> +               .associativity =3D 16, .line_size =3D 64, },
> +    /* lines per sector is not supported cpuid2_cache_descriptor(),
> +    * so descriptors 0x25, 0x20 are not included
> +    */
> +    [0x2C] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  32 * =
KiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    [0x30] =3D { .level =3D 1, .type =3D ICACHE,        .size =3D  32 * =
KiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    [0x41] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 128 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 32, },
> +    [0x42] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 256 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 32, },
> +    [0x43] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 32, },
> +    [0x44] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
> +               .associativity =3D 4,  .line_size =3D 32, },
> +    [0x45] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
> +               .associativity =3D 4,  .line_size =3D 32, },
> +    [0x46] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   4 * =
MiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    [0x47] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   8 * =
MiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    [0x48] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   3 * =
MiB,
> +               .associativity =3D 12, .line_size =3D 64, },
> +    /* Descriptor 0x49 depends on CPU family/model, so it is not include=
d */
> +    [0x4A] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   6 * =
MiB,
> +               .associativity =3D 12, .line_size =3D 64, },
> +    [0x4B] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   8 * =
MiB,
> +               .associativity =3D 16, .line_size =3D 64, },
> +    [0x4C] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D  12 * =
MiB,
> +               .associativity =3D 12, .line_size =3D 64, },
> +    [0x4D] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D  16 * =
MiB,
> +               .associativity =3D 16, .line_size =3D 64, },
> +    [0x4E] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   6 * =
MiB,
> +               .associativity =3D 24, .line_size =3D 64, },
> +    [0x60] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  16 * =
KiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    [0x66] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D   8 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    [0x67] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  16 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    [0x68] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  32 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    [0x78] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    /* lines per sector is not supported cpuid2_cache_descriptor(),
> +    * so descriptors 0x79, 0x7A, 0x7B, 0x7C are not included.
> +    */
> +    [0x7D] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    [0x7F] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
> +               .associativity =3D 2,  .line_size =3D 64, },
> +    [0x80] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    [0x82] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 256 * =
KiB,
> +               .associativity =3D 8,  .line_size =3D 32, },
> +    [0x83] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
> +               .associativity =3D 8,  .line_size =3D 32, },
> +    [0x84] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
> +               .associativity =3D 8,  .line_size =3D 32, },
> +    [0x85] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
> +               .associativity =3D 8,  .line_size =3D 32, },
> +    [0x86] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    [0x87] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    [0xD0] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    [0xD1] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    [0xD2] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
> +               .associativity =3D 4,  .line_size =3D 64, },
> +    [0xD6] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    [0xD7] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    [0xD8] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   4 * =
MiB,
> +               .associativity =3D 8,  .line_size =3D 64, },
> +    [0xDC] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D 1.5 * =
MiB,
> +               .associativity =3D 12, .line_size =3D 64, },
> +    [0xDD] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   3 * =
MiB,
> +               .associativity =3D 12, .line_size =3D 64, },
> +    [0xDE] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   6 * =
MiB,
> +               .associativity =3D 12, .line_size =3D 64, },
> +    [0xE2] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
> +               .associativity =3D 16, .line_size =3D 64, },
> +    [0xE3] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   4 * =
MiB,
> +               .associativity =3D 16, .line_size =3D 64, },
> +    [0xE4] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   8 * =
MiB,
> +               .associativity =3D 16, .line_size =3D 64, },
> +    [0xEA] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D  12 * =
MiB,
> +               .associativity =3D 24, .line_size =3D 64, },
> +    [0xEB] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D  18 * =
MiB,
> +               .associativity =3D 24, .line_size =3D 64, },
> +    [0xEC] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D  24 * =
MiB,
> +               .associativity =3D 24, .line_size =3D 64, },
> +};
> +
> +/*
> + * "CPUID leaf 2 does not report cache descriptor information,
> + * use CPUID leaf 4 to query cache parameters"
> + */
> +#define CACHE_DESCRIPTOR_UNAVAILABLE 0xFF
> +
> +/*
> + * Return a CPUID 2 cache descriptor for a given cache.
> + * If no known descriptor is found, return
> CACHE_DESCRIPTOR_UNAVAILABLE
> + */
> +static uint8_t cpuid2_cache_descriptor(struct CPUCacheInfo *cache)
> +{
> +    int i;
> +
> +    assert(cache->size > 0);
> +    assert(cache->level > 0);
> +    assert(cache->line_size > 0);
> +    assert(cache->associativity > 0);
> +    for (i =3D 0; i < ARRAY_SIZE(cpuid2_cache_descriptors); i++) {
> +        struct CPUID2CacheDescriptorInfo *d =3D &cpuid2_cache_descriptor=
s[i];
> +        if (d->level =3D=3D cache->level && d->type =3D=3D cache->type &=
&
> +            d->size =3D=3D cache->size && d->line_size =3D=3D cache->lin=
e_size &&
> +            d->associativity =3D=3D cache->associativity) {
> +                return i;
> +            }
> +    }
> +
> +    return CACHE_DESCRIPTOR_UNAVAILABLE;
> +}
> +
>  /* CPUID Leaf 4 constants: */
>=20
>  /* EAX: */
> @@ -84,6 +294,57 @@
>  #define CPUID_4_INCLUSIVE       (1 << 1)
>  #define CPUID_4_COMPLEX_IDX     (1 << 2)
>=20
> +/* Encode CacheType for CPUID[4].EAX */
> +#define CPUID_4_TYPE(t) (((t) =3D=3D DCACHE)  ? CPUID_4_TYPE_DCACHE  : \
> +                         ((t) =3D=3D ICACHE)  ? CPUID_4_TYPE_ICACHE  : \
> +                         ((t) =3D=3D UNIFIED_CACHE) ? CPUID_4_TYPE_UNIFI=
ED : \
> +                         0 /* Invalid value */)
> +
> +
> +/* Encode cache info for CPUID[4] */
> +static void encode_cache_cpuid4(struct CPUCacheInfo *cache,
> +                                int num_apic_ids, int num_cores,
> +                                uint32_t *eax, uint32_t *ebx,
> +                                uint32_t *ecx, uint32_t *edx)
> +{
> +    assert(cache->size =3D=3D cache->line_size * cache->associativity *
> +                          cache->partitions * cache->sets);
> +
> +    assert(num_apic_ids > 0);
> +    *eax =3D CPUID_4_TYPE(cache->type) | \
> +           (cache->level << 5) | \
> +           (cache->self_init ? CPUID_4_SELF_INIT_LEVEL : 0) | \
> +           ((num_cores - 1) << 26) | \
> +           ((num_apic_ids - 1) << 14);
> +
> +    assert(cache->line_size > 0);
> +    assert(cache->partitions > 0);
> +    assert(cache->associativity > 0);
> +    /* We don't implement fully-associative caches */
> +    assert(cache->associativity < cache->sets);
> +    *ebx =3D (cache->line_size - 1) | \
> +           ((cache->partitions - 1) << 12) | \
> +           ((cache->associativity - 1) << 22);
> +
> +    assert(cache->sets > 0);
> +    *ecx =3D cache->sets - 1;
> +
> +    *edx =3D (cache->no_invd_sharing ? CPUID_4_NO_INVD_SHARING : 0) | \
> +           (cache->inclusive ? CPUID_4_INCLUSIVE : 0) | \
> +           (cache->complex_indexing ? CPUID_4_COMPLEX_IDX : 0);
> +}
> +
> +/* Encode cache info for CPUID[0x80000005].ECX or
> CPUID[0x80000005].EDX */
> +static uint32_t encode_cache_cpuid80000005(struct CPUCacheInfo *cache)
> +{
> +    assert(cache->size % 1024 =3D=3D 0);
> +    assert(cache->lines_per_tag > 0);
> +    assert(cache->associativity > 0);
> +    assert(cache->line_size > 0);
> +    return ((cache->size / 1024) << 24) | (cache->associativity << 16) |=
 \
> +           (cache->lines_per_tag << 8) | (cache->line_size);
> +}
> +
>  #define ASSOC_FULL 0xFF
>=20
>  /* AMD associativity encoding used on CPUID Leaf 0x80000006: */
> @@ -100,57 +361,134 @@
>                            a =3D=3D ASSOC_FULL ? 0xF : \
>                            0 /* invalid value */)
>=20
> +/*
> + * Encode cache info for CPUID[0x80000006].ECX and
> CPUID[0x80000006].EDX
> + * @l3 can be NULL.
> + */
> +static void encode_cache_cpuid80000006(struct CPUCacheInfo *l2,
> +                                       struct CPUCacheInfo *l3,
> +                                       uint32_t *ecx, uint32_t *edx)
> +{
> +    assert(l2->size % 1024 =3D=3D 0);
> +    assert(l2->associativity > 0);
> +    assert(l2->lines_per_tag > 0);
> +    assert(l2->line_size > 0);
> +    *ecx =3D ((l2->size / 1024) << 16) | \
> +           (AMD_ENC_ASSOC(l2->associativity) << 12) | \
> +           (l2->lines_per_tag << 8) | (l2->line_size);
> +
> +    if (l3) {
> +        assert(l3->size % (512 * 1024) =3D=3D 0);
> +        assert(l3->associativity > 0);
> +        assert(l3->lines_per_tag > 0);
> +        assert(l3->line_size > 0);
> +        *edx =3D ((l3->size / (512 * 1024)) << 18) | \
> +               (AMD_ENC_ASSOC(l3->associativity) << 12) | \
> +               (l3->lines_per_tag << 8) | (l3->line_size);
> +    } else {
> +        *edx =3D 0;
> +    }
> +}
>=20
>  /* Definitions of the hardcoded cache entries we expose: */
>=20
>  /* L1 data cache: */
> -#define L1D_LINE_SIZE         64
> -#define L1D_ASSOCIATIVITY      8
> -#define L1D_SETS              64
> -#define L1D_PARTITIONS         1
> -/* Size =3D LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS =3D 32KiB */
> -#define L1D_DESCRIPTOR CPUID_2_L1D_32KB_8WAY_64B
> +static struct CPUCacheInfo l1d_cache =3D {
> +    .type =3D DCACHE,
> +    .level =3D 1,
> +    .size =3D 32 * KiB,
> +    .self_init =3D 1,
> +    .line_size =3D 64,
> +    .associativity =3D 8,
> +    .sets =3D 64,
> +    .partitions =3D 1,
> +    .no_invd_sharing =3D true,
> +};
> +
>  /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
> -#define L1D_LINES_PER_TAG      1
> -#define L1D_SIZE_KB_AMD       64
> -#define L1D_ASSOCIATIVITY_AMD  2
> +static struct CPUCacheInfo l1d_cache_amd =3D {
> +    .type =3D DCACHE,
> +    .level =3D 1,
> +    .size =3D 64 * KiB,
> +    .self_init =3D 1,
> +    .line_size =3D 64,
> +    .associativity =3D 2,
> +    .lines_per_tag =3D 1,
> +    .no_invd_sharing =3D true,
> +};
>=20
>  /* L1 instruction cache: */
> -#define L1I_LINE_SIZE         64
> -#define L1I_ASSOCIATIVITY      8
> -#define L1I_SETS              64
> -#define L1I_PARTITIONS         1
> -/* Size =3D LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS =3D 32KiB */
> -#define L1I_DESCRIPTOR CPUID_2_L1I_32KB_8WAY_64B
> +static struct CPUCacheInfo l1i_cache =3D {
> +    .type =3D ICACHE,
> +    .level =3D 1,
> +    .size =3D 32 * KiB,
> +    .self_init =3D 1,
> +    .line_size =3D 64,
> +    .associativity =3D 8,
> +    .sets =3D 64,
> +    .partitions =3D 1,
> +    .no_invd_sharing =3D true,
> +};
> +
>  /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
> -#define L1I_LINES_PER_TAG      1
> -#define L1I_SIZE_KB_AMD       64
> -#define L1I_ASSOCIATIVITY_AMD  2
> +static struct CPUCacheInfo l1i_cache_amd =3D {
> +    .type =3D ICACHE,
> +    .level =3D 1,
> +    .size =3D 64 * KiB,
> +    .self_init =3D 1,
> +    .line_size =3D 64,
> +    .associativity =3D 2,
> +    .lines_per_tag =3D 1,
> +    .no_invd_sharing =3D true,
> +};
>=20
>  /* Level 2 unified cache: */
> -#define L2_LINE_SIZE          64
> -#define L2_ASSOCIATIVITY      16
> -#define L2_SETS             4096
> -#define L2_PARTITIONS          1
> -/* Size =3D LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS =3D 4MiB */
> +static struct CPUCacheInfo l2_cache =3D {
> +    .type =3D UNIFIED_CACHE,
> +    .level =3D 2,
> +    .size =3D 4 * MiB,
> +    .self_init =3D 1,
> +    .line_size =3D 64,
> +    .associativity =3D 16,
> +    .sets =3D 4096,
> +    .partitions =3D 1,
> +    .no_invd_sharing =3D true,
> +};
> +
>  /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
> -#define L2_DESCRIPTOR CPUID_2_L2_2MB_8WAY_64B
> +static struct CPUCacheInfo l2_cache_cpuid2 =3D {
> +    .type =3D UNIFIED_CACHE,
> +    .level =3D 2,
> +    .size =3D 2 * MiB,
> +    .line_size =3D 64,
> +    .associativity =3D 8,
> +};
> +
> +
>  /*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
> -#define L2_LINES_PER_TAG       1
> -#define L2_SIZE_KB_AMD       512
> +static struct CPUCacheInfo l2_cache_amd =3D {
> +    .type =3D UNIFIED_CACHE,
> +    .level =3D 2,
> +    .size =3D 512 * KiB,
> +    .line_size =3D 64,
> +    .lines_per_tag =3D 1,
> +    .associativity =3D 16,
> +};
>=20
>  /* Level 3 unified cache: */
> -#define L3_SIZE_KB             0 /* disabled */
> -#define L3_ASSOCIATIVITY       0 /* disabled */
> -#define L3_LINES_PER_TAG       0 /* disabled */
> -#define L3_LINE_SIZE           0 /* disabled */
> -#define L3_N_LINE_SIZE         64
> -#define L3_N_ASSOCIATIVITY     16
> -#define L3_N_SETS           16384
> -#define L3_N_PARTITIONS         1
> -#define L3_N_DESCRIPTOR CPUID_2_L3_16MB_16WAY_64B
> -#define L3_N_LINES_PER_TAG      1
> -#define L3_N_SIZE_KB_AMD    16384
> +static struct CPUCacheInfo l3_cache =3D {
> +    .type =3D UNIFIED_CACHE,
> +    .level =3D 3,
> +    .size =3D 16 * MiB,
> +    .line_size =3D 64,
> +    .associativity =3D 16,
> +    .sets =3D 16384,
> +    .partitions =3D 1,
> +    .lines_per_tag =3D 1,
> +    .self_init =3D true,
> +    .inclusive =3D true,
> +    .complex_indexing =3D true,
> +};
>=20
>  /* TLB definitions: */
>=20
> @@ -3298,85 +3636,53 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t
> index, uint32_t count,
>          if (!cpu->enable_l3_cache) {
>              *ecx =3D 0;
>          } else {
> -            *ecx =3D L3_N_DESCRIPTOR;
> +            *ecx =3D cpuid2_cache_descriptor(&l3_cache);
>          }
> -        *edx =3D (L1D_DESCRIPTOR << 16) | \
> -               (L1I_DESCRIPTOR <<  8) | \
> -               (L2_DESCRIPTOR);
> +        *edx =3D (cpuid2_cache_descriptor(&l1d_cache) << 16) | \
> +               (cpuid2_cache_descriptor(&l1i_cache) <<  8) | \
> +               (cpuid2_cache_descriptor(&l2_cache_cpuid2));
>          break;
>      case 4:
>          /* cache info: needed for Core compatibility */
>          if (cpu->cache_info_passthrough) {
>              host_cpuid(index, count, eax, ebx, ecx, edx);
> +            /* QEMU gives out its own APIC IDs, never pass down bits 31.=
.26.  */
>              *eax &=3D ~0xFC000000;
> +            if ((*eax & 31) && cs->nr_cores > 1) {
> +                *eax |=3D (cs->nr_cores - 1) << 26;
> +            }
>          } else {
>              *eax =3D 0;
>              switch (count) {
>              case 0: /* L1 dcache info */
> -                *eax |=3D CPUID_4_TYPE_DCACHE | \
> -                        CPUID_4_LEVEL(1) | \
> -                        CPUID_4_SELF_INIT_LEVEL;
> -                *ebx =3D (L1D_LINE_SIZE - 1) | \
> -                       ((L1D_PARTITIONS - 1) << 12) | \
> -                       ((L1D_ASSOCIATIVITY - 1) << 22);
> -                *ecx =3D L1D_SETS - 1;
> -                *edx =3D CPUID_4_NO_INVD_SHARING;
> +                encode_cache_cpuid4(&l1d_cache,
> +                                    1, cs->nr_cores,
> +                                    eax, ebx, ecx, edx);
>                  break;
>              case 1: /* L1 icache info */
> -                *eax |=3D CPUID_4_TYPE_ICACHE | \
> -                        CPUID_4_LEVEL(1) | \
> -                        CPUID_4_SELF_INIT_LEVEL;
> -                *ebx =3D (L1I_LINE_SIZE - 1) | \
> -                       ((L1I_PARTITIONS - 1) << 12) | \
> -                       ((L1I_ASSOCIATIVITY - 1) << 22);
> -                *ecx =3D L1I_SETS - 1;
> -                *edx =3D CPUID_4_NO_INVD_SHARING;
> +                encode_cache_cpuid4(&l1i_cache,
> +                                    1, cs->nr_cores,
> +                                    eax, ebx, ecx, edx);
>                  break;
>              case 2: /* L2 cache info */
> -                *eax |=3D CPUID_4_TYPE_UNIFIED | \
> -                        CPUID_4_LEVEL(2) | \
> -                        CPUID_4_SELF_INIT_LEVEL;
> -                if (cs->nr_threads > 1) {
> -                    *eax |=3D (cs->nr_threads - 1) << 14;
> -                }
> -                *ebx =3D (L2_LINE_SIZE - 1) | \
> -                       ((L2_PARTITIONS - 1) << 12) | \
> -                       ((L2_ASSOCIATIVITY - 1) << 22);
> -                *ecx =3D L2_SETS - 1;
> -                *edx =3D CPUID_4_NO_INVD_SHARING;
> +                encode_cache_cpuid4(&l2_cache,
> +                                    cs->nr_threads, cs->nr_cores,
> +                                    eax, ebx, ecx, edx);
>                  break;
>              case 3: /* L3 cache info */
> -                if (!cpu->enable_l3_cache) {
> -                    *eax =3D 0;
> -                    *ebx =3D 0;
> -                    *ecx =3D 0;
> -                    *edx =3D 0;
> +                pkg_offset =3D apicid_pkg_offset(cs->nr_cores, cs->nr_th=
reads);
> +                if (cpu->enable_l3_cache) {
> +                    encode_cache_cpuid4(&l3_cache,
> +                                        (1 << pkg_offset), cs->nr_cores,
> +                                        eax, ebx, ecx, edx);
>                      break;
>                  }
> -                *eax |=3D CPUID_4_TYPE_UNIFIED | \
> -                        CPUID_4_LEVEL(3) | \
> -                        CPUID_4_SELF_INIT_LEVEL;
> -                pkg_offset =3D apicid_pkg_offset(cs->nr_cores, cs->nr_th=
reads);
> -                *eax |=3D ((1 << pkg_offset) - 1) << 14;
> -                *ebx =3D (L3_N_LINE_SIZE - 1) | \
> -                       ((L3_N_PARTITIONS - 1) << 12) | \
> -                       ((L3_N_ASSOCIATIVITY - 1) << 22);
> -                *ecx =3D L3_N_SETS - 1;
> -                *edx =3D CPUID_4_INCLUSIVE | CPUID_4_COMPLEX_IDX;
> -                break;
> +                /* fall through */
>              default: /* end of info */
> -                *eax =3D 0;
> -                *ebx =3D 0;
> -                *ecx =3D 0;
> -                *edx =3D 0;
> +                *eax =3D *ebx =3D *ecx =3D *edx =3D 0;
>                  break;
>              }
>          }
> -
> -        /* QEMU gives out its own APIC IDs, never pass down bits 31..26.=
  */
> -        if ((*eax & 31) && cs->nr_cores > 1) {
> -            *eax |=3D (cs->nr_cores - 1) << 26;
> -        }
>          break;
>      case 5:
>          /* mwait info: needed for Core compatibility */
> @@ -3580,10 +3886,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t
> index, uint32_t count,
>                 (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
>          *ebx =3D (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |=
 \
>                 (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
> -        *ecx =3D (L1D_SIZE_KB_AMD << 24) | (L1D_ASSOCIATIVITY_AMD << 16)=
 |
> \
> -               (L1D_LINES_PER_TAG << 8) | (L1D_LINE_SIZE);
> -        *edx =3D (L1I_SIZE_KB_AMD << 24) | (L1I_ASSOCIATIVITY_AMD << 16)=
 | \
> -               (L1I_LINES_PER_TAG << 8) | (L1I_LINE_SIZE);
> +        *ecx =3D encode_cache_cpuid80000005(&l1d_cache_amd);
> +        *edx =3D encode_cache_cpuid80000005(&l1i_cache_amd);
>          break;
>      case 0x80000006:
>          /* cache info (L2 cache) */
> @@ -3599,18 +3903,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t
> index, uint32_t count,
>                 (L2_DTLB_4K_ENTRIES << 16) | \
>                 (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
>                 (L2_ITLB_4K_ENTRIES);
> -        *ecx =3D (L2_SIZE_KB_AMD << 16) | \
> -               (AMD_ENC_ASSOC(L2_ASSOCIATIVITY) << 12) | \
> -               (L2_LINES_PER_TAG << 8) | (L2_LINE_SIZE);
> -        if (!cpu->enable_l3_cache) {
> -            *edx =3D ((L3_SIZE_KB / 512) << 18) | \
> -                   (AMD_ENC_ASSOC(L3_ASSOCIATIVITY) << 12) | \
> -                   (L3_LINES_PER_TAG << 8) | (L3_LINE_SIZE);
> -        } else {
> -            *edx =3D ((L3_N_SIZE_KB_AMD / 512) << 18) | \
> -                   (AMD_ENC_ASSOC(L3_N_ASSOCIATIVITY) << 12) | \
> -                   (L3_N_LINES_PER_TAG << 8) | (L3_N_LINE_SIZE);
> -        }
> +        encode_cache_cpuid80000006(&l2_cache_amd,
> +                                   cpu->enable_l3_cache ? &l3_cache : NU=
LL,
> +                                   ecx, edx);
>          break;
>      case 0x80000007:
>          *eax =3D 0;
> --
> 2.14.3
