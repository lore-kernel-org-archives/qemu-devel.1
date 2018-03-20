Received: from eggs.gnu.org ([2001:4830:134:3::10]:48448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1eyL1M-0001Rw-57
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1eyL1I-0007kf-Fh
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:26:00 -0400
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com
	([104.47.38.44]:14304
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1eyL1I-0007jU-6W
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:25:56 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Tue, 20 Mar 2018 17:25:52 +0000
Message-ID: <CY4PR12MB17686EB283987B8A5EDCF49295AB0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
	<1520888449-4352-3-git-send-email-babu.moger@amd.com>
	<20180316180006.GH28578@localhost.localdomain>
In-Reply-To: <20180316180006.GH28578@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD Processor
 Cache Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "Lendacky,
	Thomas" <Thomas.Lendacky@amd.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "Hook,
	Gary" <Gary.Hook@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Eduardo, Thanks for the comments. Please see the response inline.

> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Friday, March 16, 2018 1:00 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; rkrcmar@redhat.com;
> Lendacky, Thomas <Thomas.Lendacky@amd.com>; Singh, Brijesh
> <brijesh.singh@amd.com>; kvm@vger.kernel.org; kash@tripleback.net;
> mtosatti@redhat.com; Hook, Gary <Gary.Hook@amd.com>; qemu-
> devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD
> Processor Cache Information
>=20
> On Mon, Mar 12, 2018 at 05:00:46PM -0400, Babu Moger wrote:
> > From: Stanislav Lanci <pixo@polepetko.eu>
> >
> > Add information for cpuid 0x8000001D leaf. Populate cache topology
> information
> > for different cache types(Data Cache, Instruction Cache, L2 and L3)
> supported
> > by 0x8000001D leaf. Please refer Processor Programming Reference (PPR)
> for AMD
> > Family 17h Model for more details.
> >
> > Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
>=20
> The new CPUID leaves don't seem to match the existing AMD cache
> information
> leaves.  Is this intentional?  Why?

It is not intentional. These values are from older family of processors. Th=
ese values have changed from Family 14  or later.
The latest one is Family 17. You can see the differences here.
 https://support.amd.com/TechDocs/41131.pdf
https://support.amd.com/TechDocs/55072_AMD_Family_15h_Models_70h-7Fh_BKDG.p=
df
https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf

Some of these are bugs in our code. For some we need to add checks for the =
family and correct these values.
You understand the code much better than me. Correct me if I missed somethi=
ng.=20

Note that older family of processors don't support topology extensions. =20

>=20
> Details below:
>=20
> > ---
> >  target/i386/cpu.c | 65
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  target/i386/kvm.c | 29 ++++++++++++++++++++++---
> >  2 files changed, 91 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 42dd381..5fdbedd 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> [...]
> > @@ -3590,6 +3594,67 @@ void cpu_x86_cpuid(CPUX86State *env,
> uint32_t index, uint32_t count,
> >              *edx =3D 0;
> >          }
> >          break;
> > +    case 0x8000001D: /* AMD TOPOEXT cache info */
> > +        switch (count) {
>=20
> Copying macro definitions here, for reference:
>=20
> > /* L1 data cache: */
> > #define L1D_LINE_SIZE         64
> > #define L1D_ASSOCIATIVITY      8
> > #define L1D_SETS              64
> > #define L1D_PARTITIONS         1
> > /* Size =3D LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS =3D 32KiB */
> > #define L1D_DESCRIPTOR CPUID_2_L1D_32KB_8WAY_64B
> > /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
> > #define L1D_LINES_PER_TAG      1
> > #define L1D_SIZE_KB_AMD       64
> > #define L1D_ASSOCIATIVITY_AMD  2
>=20
> So, we already have:
>=20
> CPUID[2]: 32KB 8-way cache, 64-byte lines
> CPUID[4]: 8-way cache, 64-byte lines, 64 sets, 1 partition (32 KB)
> CPUID[0x80000005]: 64 KB 2-way cache, 1 line per tag

64 KiB, 2-way are for the older family products.=20
Newer one should be 8-way, 32KiB. Will need to add checks here.

>=20
>=20
> > +        case 0: /* L1 dcache info */
> > +            *eax |=3D TYPE_DCACHE | \
> > +                    CACHE_LEVEL(1) | \
> > +                    CACHE_SELF_INIT_LEVEL | \
> > +                    ((cs->nr_threads - 1) << 14);
> > +            *ebx =3D (L1D_LINE_SIZE - 1) | \
> > +                   ((L1D_PARTITIONS - 1) << 12) | \
> > +                   ((L1D_ASSOCIATIVITY - 1) << 22);
> > +            *ecx =3D L1D_SETS - 1;
> > +            *edx =3D 0;
> > +            break;
>=20
> This adds:
> CPUID[0x8000001D]: 8-way cache, 64-byte lines, 64 sets, 1 partition (32 K=
iB)

Should match after the above new check.

>=20
> This agrees with CPUID[2] and CPUID[4] (Intel leaves, reserved on AMD), b=
ut
> not
> with CPUID[0x80000005].
>=20
> >
> >  /* L1 instruction cache: */
> >  #define L1I_LINE_SIZE         64
> >  #define L1I_ASSOCIATIVITY      8
> >  #define L1I_SETS              64
> > +#define L1I_SETS_AMD         256
> >  #define L1I_PARTITIONS         1
> >  /* Size =3D LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS =3D 32KiB */
> >  #define L1I_DESCRIPTOR CPUID_2_L1I_32KB_8WAY_64B
> >  /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
> >  #define L1I_LINES_PER_TAG      1
> >  #define L1I_SIZE_KB_AMD       64
> >  #define L1I_ASSOCIATIVITY_AMD  2
>=20
> Currently we have:
>=20
> CPUID[2]: 32KiB 8-way cache, 64-byte lines
> CPUID[4]: 8-way cache, 64-byte lines, 64 sets, 1 partition (32 KiB)
> CPUID[0x80000005]: 64 KiB 2-way cache, 1 line per tag

This is for the older family(64 KiB 2-way). Newer one is 64 KiB 4-way.   We=
 need to add check here.
>=20
>=20
> >
> > +        case 1: /* L1 icache info */
> > +            *eax |=3D TYPE_ICACHE | \
> > +                    CACHE_LEVEL(1) | \
> > +                    CACHE_SELF_INIT_LEVEL | \
> > +                    ((cs->nr_threads - 1) << 14);
> > +            *ebx =3D (L1I_LINE_SIZE - 1) | \
> > +                   ((L1I_PARTITIONS - 1) << 12) | \
> > +                   ((L1I_ASSOCIATIVITY_AMD - 1) << 22);
> > +            *ecx =3D L1I_SETS_AMD - 1;
> > +            *edx =3D 0;
> > +            break;
>=20
> This adds:
> CPUID[0x8000001D]: 2-way cache, 64-byte lines, 256 sets, 1 partition (32 =
KiB)
>=20
> This doesn't match any of the existing leaves.

This is bug in my code. This should be 4-way.  Should match after the fix.
>=20
>=20
> >  /* Level 2 unified cache: */
> >  #define L2_LINE_SIZE          64
> >  #define L2_ASSOCIATIVITY      16
> > +#define L2_ASSOCIATIVITY_AMD   8
> >  #define L2_SETS             4096
> > +#define L2_SETS_AMD         1024
> >  #define L2_PARTITIONS          1
> >  /* Size =3D LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS =3D 4MiB */
> >  /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
> >  #define L2_DESCRIPTOR CPUID_2_L2_2MB_8WAY_64B
> >  /*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
> >  #define L2_LINES_PER_TAG       1
> >  #define L2_SIZE_KB_AMD       512
>=20
> Currently we have:
> CPUID[2]: 4MiB 8-way cache, 64-byte lines
> CPUID[4]: 64-byte lines, 16-way, 1 partition, 4096 sets (4 MiB)
> CPUID[0x80000006]: 512 KiB, 16-way cache, 1 line per tag

This should have been 8-way. This is a bug. Will fix.
This should have been (AMD_ENC_ASSOC(L2_ASSOCIATIVITY_AMD) << 12)


>=20
> >
> > +        case 2: /* L2 cache info */
> > +            *eax |=3D TYPE_UNIFIED | \
> > +                    CACHE_LEVEL(2) | \
> > +                    CACHE_SELF_INIT_LEVEL | \
> > +                    ((cs->nr_threads - 1) << 14);
> > +            *ebx =3D (L2_LINE_SIZE - 1) | \
> > +                   ((L2_PARTITIONS - 1) << 12) | \
> > +                   ((L2_ASSOCIATIVITY_AMD - 1) << 22);
> > +            *ecx =3D L2_SETS_AMD - 1;
> > +            *edx =3D CACHE_INCLUSIVE;
> > +            break;
>=20
> This adds:
> CPUID[0x8000001D]: 64-byte lines, 8-way, 1 partition, 1024 sets (512 KiB)=
.
>=20
> This doesn't match any of the existing leaves.

Should match after above fix.
>=20
>=20
> >  /* Level 3 unified cache: */
> >  #define L3_N_LINE_SIZE         64
> >  #define L3_N_ASSOCIATIVITY     16
> >  #define L3_N_SETS           16384
> > +#define L3_N_SETS_AMD        8192
> >  #define L3_N_PARTITIONS         1
> >  #define L3_N_DESCRIPTOR CPUID_2_L3_16MB_16WAY_64B
> >  #define L3_N_LINES_PER_TAG      1
> >  #define L3_N_SIZE_KB_AMD    16384
> >
>=20
> Currently we have:
> CPUID[2]: 16MiB 16-way cache, 64-byte lines
> CPUID[4]: 64-byte lines, 16-way, 16384 sets, 1 partition (16 MiB)
> CPUID[0x80000006]: 16 MiB cache, 16-way, 1 line per tag
>=20
>=20
> > +        case 3: /* L3 cache info */
> > +            if (cpu->enable_l3_cache) {
> > +                *eax |=3D TYPE_UNIFIED | \
> > +                        CACHE_LEVEL(3) | \
> > +                        CACHE_SELF_INIT_LEVEL | \
> > +                        ((cs->nr_cores * cs->nr_threads - 1) << 14);
> > +                *ebx =3D (L3_N_LINE_SIZE - 1) | \
> > +                       ((L3_N_PARTITIONS - 1) << 12) | \
> > +                       ((L3_N_ASSOCIATIVITY - 1) << 22);
> > +                *ecx =3D L3_N_SETS_AMD - 1;
> > +                *edx =3D CACHE_NO_INVD_SHARING;
>=20
> This adds:
> CPUID[0x8000001D]: 64-byte lines, 16-way, 1 partition, 8192 sets (8 MiB)

I am not very clear about this. It appears the number of sets should be 163=
84.
Let me talk to someone and confirm.

>=20
> This doesn't match any of the existing leaves.
>=20
>=20
> > +            } else {
> > +                *eax =3D 0;
> > +                *ebx =3D 0;
> > +                *ecx =3D 0;
> > +                *edx =3D 0;
> > +            }
> > +            break;
> > +        default: /* end of info */
> > +            *eax =3D 0;
> > +            *ebx =3D 0;
> > +            *ecx =3D 0;
> > +            *edx =3D 0;
> > +            break;
> > +        }
> > +        break;
> >      case 0xC0000000:
> >          *eax =3D env->cpuid_xlevel2;
> >          *ebx =3D 0;
> [...]
>=20
> --
> Eduardo
