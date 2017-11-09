Received: from eggs.gnu.org ([2001:4830:134:3::10]:53636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pixo@polepetko.eu>) id 1eCpJo-00025P-3a
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pixo@polepetko.eu>) id 1eCpJe-0002Nf-94
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:04:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 09 Nov 2017 17:04:27 +0100
From: pixo@polepetko.eu
In-Reply-To: <111e80b1-025c-aa6c-1df8-27ded2258371@amsat.org>
References: <20171103173037.17012-1-pixo@polepetko.eu>
	<111e80b1-025c-aa6c-1df8-27ded2258371@amsat.org>
Message-ID: <1c6e1d30b20c4b6963bca5f59585497a@polepetko.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] AMD Processor Topology Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Andre Przywara <andre.przywara@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Longpeng(Mike)" <longpeng2@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Andre?= =?UTF-8?Q?as_F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?Q?Beno=C3=AEt_C?= =?UTF-8?Q?anet?= <benoit@irqsave.net>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mat?= =?UTF-8?Q?hieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>

Hi Philippe,

Most of the code for 'case 0x8000001E:' is a copy of 'case 4:' of the=20
same procedure in both cpu.c and kvm.c
Values were changes for AMD Zen architecture.
The only new code is 'case 0x8000001D:' which defines core topology.

Hope this info helps wit review.

On 2017-11-08 13:44, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Stanislav,
>=20
> This does not seem so trivial ;)
>=20
> Cc'ing more reviewers.
>=20
> On 11/03/2017 02:30 PM, Stanislav Lanci wrote:
>> V2:
>> Adds information about cache size and topology on leaf 0x8000001D for=20
>> family 17h
>> Without the added cache topology guest with SMT suffers latency=20
>> problems
>>=20
>> Add CPUID 0x8000001E for describing AMD Processor Topology Information
>> Disables warning about smt for 17h family of AMD CPUs
>>=20
>> Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
>> ---
>>  target/i386/cpu.c | 93=20
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  target/i386/kvm.c | 28 +++++++++++++++--
>>  2 files changed, 117 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index ddc45abd70..1545e3fe31 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -113,7 +113,9 @@
>>  /* L1 instruction cache: */
>>  #define L1I_LINE_SIZE         64
>>  #define L1I_ASSOCIATIVITY      8
>> +#define L1I_ASSOC_AMD_ZEN      4
>>  #define L1I_SETS              64
>> +#define L1I_SETS_AMD_ZEN     256
>>  #define L1I_PARTITIONS         1
>>  /* Size =3D LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS =3D 32KiB */
>>  #define L1I_DESCRIPTOR CPUID_2_L1I_32KB_8WAY_64B
>> @@ -125,7 +127,9 @@
>>  /* Level 2 unified cache: */
>>  #define L2_LINE_SIZE          64
>>  #define L2_ASSOCIATIVITY      16
>> +#define L2_ASSOC_AMD_ZEN       8
>>  #define L2_SETS             4096
>> +#define L2_SETS_AMD_ZEN     1024
>>  #define L2_PARTITIONS          1
>>  /* Size =3D LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS =3D 4MiB */
>>  /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
>> @@ -142,6 +146,7 @@
>>  #define L3_N_LINE_SIZE         64
>>  #define L3_N_ASSOCIATIVITY     16
>>  #define L3_N_SETS           16384
>> +#define L3_N_SETS_AMD_ZEN    4096
>>  #define L3_N_PARTITIONS         1
>>  #define L3_N_DESCRIPTOR CPUID_2_L3_16MB_16WAY_64B
>>  #define L3_N_LINES_PER_TAG      1
>> @@ -3072,6 +3077,91 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t=20
>> index, uint32_t count,
>>              *edx =3D 0;
>>          }
>>          break;
>> +    case 0x8000001D: /* AMD TOPOEXT cache info for ZEN */
>> +        if (cpu->cache_info_passthrough) {
>> +            host_cpuid(index, count, eax, ebx, ecx, edx);
>> +            break;
>> +        } else if ((env->cpuid_version & 0xFF00F00) =3D=3D 0x800F00) =
{
>> +            *eax =3D 0;
>> +            switch (count) {
>> +            case 0: /* L1 dcache info */
>> +                *eax |=3D CPUID_4_TYPE_DCACHE | \
>> +                        CPUID_4_LEVEL(1) | \
>> +                        CPUID_4_SELF_INIT_LEVEL | \
>> +                        ((cs->nr_threads - 1) << 14);
>> +                *ebx =3D (L1D_LINE_SIZE - 1) | \
>> +                       ((L1D_PARTITIONS - 1) << 12) | \
>> +                       ((L1D_ASSOCIATIVITY - 1) << 22);
>> +                *ecx =3D L1D_SETS - 1;
>> +                *edx =3D 0;
>> +                break;
>> +            case 1: /* L1 icache info */
>> +                *eax |=3D CPUID_4_TYPE_ICACHE | \
>> +                        CPUID_4_LEVEL(1) | \
>> +                        CPUID_4_SELF_INIT_LEVEL | \
>> +                        ((cs->nr_threads - 1) << 14);
>> +                *ebx =3D (L1I_LINE_SIZE - 1) | \
>> +                       ((L1I_PARTITIONS - 1) << 12) | \
>> +                       ((L1I_ASSOC_AMD_ZEN - 1) << 22);
>> +                *ecx =3D L1I_SETS_AMD_ZEN - 1;
>> +                *edx =3D 0;
>> +                break;
>> +            case 2: /* L2 cache info */
>> +                *eax |=3D CPUID_4_TYPE_UNIFIED | \
>> +                        CPUID_4_LEVEL(2) | \
>> +                        CPUID_4_SELF_INIT_LEVEL | \
>> +                        ((cs->nr_threads - 1) << 14);
>> +                *ebx =3D (L2_LINE_SIZE - 1) | \
>> +                       ((L2_PARTITIONS - 1) << 12) | \
>> +                       ((L2_ASSOC_AMD_ZEN - 1) << 22);
>> +                *ecx =3D L2_SETS_AMD_ZEN - 1;
>> +                *edx =3D CPUID_4_INCLUSIVE;
>> +                break;
>> +            case 3: /* L3 cache info */
>> +                if (!cpu->enable_l3_cache) {
>> +                    *eax =3D 0;
>> +                    *ebx =3D 0;
>> +                    *ecx =3D 0;
>> +                    *edx =3D 0;
>> +                    break;
>> +                }
>> +                *eax |=3D CPUID_4_TYPE_UNIFIED | \
>> +                        CPUID_4_LEVEL(3) | \
>> +                        CPUID_4_SELF_INIT_LEVEL | \
>> +                        ((cs->nr_cores * cs->nr_threads - 1) << 14);
>> +                *ebx =3D (L3_N_LINE_SIZE - 1) | \
>> +                       ((L3_N_PARTITIONS - 1) << 12) | \
>> +                       ((L3_N_ASSOCIATIVITY - 1) << 22);
>> +                *ecx =3D L3_N_SETS_AMD_ZEN - 1;
>> +                *edx =3D CPUID_4_NO_INVD_SHARING;
>> +                break;
>> +            default: /* end of info */
>> +                *eax =3D 0;
>> +                *ebx =3D 0;
>> +                *ecx =3D 0;
>> +                *edx =3D 0;
>> +                break;
>> +            }
>> +        } else {
>> +            *eax =3D 0;
>> +            *ebx =3D 0;
>> +            *ecx =3D 0;
>> +            *edx =3D 0;
>> +        }
>> +        break;
>> +    case 0x8000001E: /* AMD TOPOEXT cpu topology info for ZEN */
>> +        if ((env->cpuid_version & 0xFF00F00) =3D=3D 0x800F00) {
>> +            *eax =3D cpu->apic_id;
>> +            *ebx =3D (cs->nr_threads - 1) << 8 | cpu->core_id;
>> +            *ecx =3D cpu->socket_id;
>> +            *edx =3D 0;
>> +        } else {
>> +            *eax =3D 0;
>> +            *ebx =3D 0;
>> +            *ecx =3D 0;
>> +            *edx =3D 0;
>> +        }
>> +        break;
>>      case 0xC0000000:
>>          *eax =3D env->cpuid_xlevel2;
>>          *ebx =3D 0;
>> @@ -3742,7 +3832,8 @@ static void x86_cpu_realizefn(DeviceState *dev,=20
>> Error **errp)
>>       * NOTE: the following code has to follow qemu_init_vcpu().=20
>> Otherwise
>>       * cs->nr_threads hasn't be populated yet and the checking is=20
>> incorrect.
>>       */
>> -    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned) {
>> +    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned && \
>> +       (env->cpuid_version & 0xFF00F00) !=3D 0x800F00) {
>>          error_report("AMD CPU doesn't support hyperthreading. Please=20
>> configure"
>>                       " -smp options properly.");
>>          ht_warned =3D true;
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 6db7783edc..d6b4e1ae74 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -869,9 +869,31 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>          }
>>          c =3D &cpuid_data.entries[cpuid_i++];
>>=20
>> -        c->function =3D i;
>> -        c->flags =3D 0;
>> -        cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
>> +        switch (i) {
>> +        case 0x8000001d:
>> +            for (j =3D 0; ; j++) {
>> +                c->function =3D i;
>> +                c->flags =3D KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
>> +                c->index =3D j;
>> +                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx,=20
>> &c->edx);
>> +
>> +                if (c->eax =3D=3D 0) {
>> +                    break;
>> +                }
>> +                if (cpuid_i =3D=3D KVM_MAX_CPUID_ENTRIES) {
>> +                    fprintf(stderr, "cpuid_data is full, no space for=
=20
>> "
>> +                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
>> +                    abort();
>> +                }
>> +                c =3D &cpuid_data.entries[cpuid_i++];
>> +            }
>> +            break;
>> +        default:
>> +            c->function =3D i;
>> +            c->flags =3D 0;
>> +            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx,=20
>> &c->edx);
>> +            break;
>> +        }
>>      }
>>=20
>>      /* Call Centaur's CPUID instructions they are supported. */
>>=20
