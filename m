Received: from eggs.gnu.org ([2001:4830:134:3::10]:58035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1erQYo-0000aA-0Z
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1erQYk-0001Wx-1S
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:55:58 -0500
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com
	([104.47.32.50]:52928
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1erQYj-0001Wb-Gx
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:55:53 -0500
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Thu, 1 Mar 2018 15:55:50 +0000
Message-ID: <CY4PR12MB17687EBCC5940ACFEB3E4D7C95C60@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
	<1519439425-27883-3-git-send-email-babu.moger@amd.com>
	<20180228180858.GB8418@flask>
In-Reply-To: <20180228180858.GB8418@flask>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/i386: Populate AMD Processor
 Cache Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pixo@polepetko.eu" <pixo@polepetko.eu>, "Hook, Gary" <Gary.Hook@amd.com>

Radim, Thanks for your comments. I am working on the changes.
But, I need few clarifications on your comments. Please see inline.=20

> -----Original Message-----
> From: Radim Kr=E8m=E1=F8 [mailto:rkrcmar@redhat.com]
> Sent: Wednesday, February 28, 2018 12:09 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> mtosatti@redhat.com; qemu-devel@nongnu.org; kvm@vger.kernel.org;
> pixo@polepetko.eu; Hook, Gary <Gary.Hook@amd.com>
> Subject: Re: [PATCH v2 2/5] target/i386: Populate AMD Processor Cache
> Information
>=20
> 2018-02-23 21:30-0500, Babu Moger:
> > From: Stanislav Lanci <pixo@polepetko.eu>
> >
> > Adds information about cache size and topology from cpuid 0x8000001D
> leaf
> > for different cache types on AMD processors.
> >
> > Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > @@ -3590,6 +3594,78 @@ void cpu_x86_cpuid(CPUX86State *env,
> uint32_t index, uint32_t count,
> >              *edx =3D 0;
> >          }
> >          break;
> > +    case 0x8000001D: /* AMD TOPOEXT cache info */
> > +        if (cpu->cache_info_passthrough) {
> > +            host_cpuid(index, count, eax, ebx, ecx, edx);
> > +            break;
> > +        } else if (env->features[FEAT_8000_0001_ECX] &
> CPUID_EXT3_TOPOEXT) {
> > +            *eax =3D 0;
> > +            switch (count) {
> > +            case 0: /* L1 dcache info */
> > +                *eax |=3D CPUID_4_TYPE_DCACHE | \
> > +                        CPUID_4_LEVEL(1) | \
> > +                        CPUID_4_SELF_INIT_LEVEL | \
> > +                        ((cs->nr_threads - 1) << 14);
>=20
> CPUID_4 uses the same format even for bits 25-14, so this would look
> better with a macro.

Yes. We can do that.=20

>=20
> > +                *ebx =3D (L1D_LINE_SIZE - 1) | \
> > +                       ((L1D_PARTITIONS - 1) << 12) | \
> > +                       ((L1D_ASSOCIATIVITY - 1) << 22);
> > +                *ecx =3D L1D_SETS - 1;
>=20
> These numbers seem to have the same meaning as CPUID 4, but have
> conflicting values.

I am not sure about conflicting values. Looking at the specs(page 78 CPUID_=
Fn8000001D_EBX_x00)
 https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
 It looks correct to me.

>=20
> I think we should not expose CPUID 4 with AMD CPUs or at least when they
> have CPUID_EXT3_TOPOEXT (the latter is easier wrt. compatibility).

Can you please elaborate on these comments?=20
Did you mean we should remove the check CPUID_EXT3_TOPOEXT and remove all C=
PUID 4 references?=20

>=20
> > +                *edx =3D 0;
> > +                break;
> > +            case 1: /* L1 icache info */
> > +                *eax |=3D CPUID_4_TYPE_ICACHE | \
> > +                        CPUID_4_LEVEL(1) | \
> > +                        CPUID_4_SELF_INIT_LEVEL | \
> > +                        ((cs->nr_threads - 1) << 14);
> > +                *ebx =3D (L1I_LINE_SIZE - 1) | \
> > +                       ((L1I_PARTITIONS - 1) << 12) | \
> > +                       ((L1I_ASSOCIATIVITY_AMD - 1) << 22);
> > +                *ecx =3D L1I_SETS_AMD - 1;
> > +                *edx =3D 0;
> > +                break;
> > +            case 2: /* L2 cache info */
> > +                *eax |=3D CPUID_4_TYPE_UNIFIED | \
> > +                        CPUID_4_LEVEL(2) | \
> > +                        CPUID_4_SELF_INIT_LEVEL | \
> > +                        ((cs->nr_threads - 1) << 14);
> > +                *ebx =3D (L2_LINE_SIZE - 1) | \
> > +                       ((L2_PARTITIONS - 1) << 12) | \
> > +                       ((L2_ASSOCIATIVITY_AMD - 1) << 22);
> > +                *ecx =3D L2_SETS_AMD - 1;
> > +                *edx =3D CPUID_4_INCLUSIVE;
> > +                break;
> > +            case 3: /* L3 cache info */
> > +                if (!cpu->enable_l3_cache) {
> > +                    *eax =3D 0;
> > +                    *ebx =3D 0;
> > +                    *ecx =3D 0;
> > +                    *edx =3D 0;
> > +                    break;
> > +                }
> > +                *eax |=3D CPUID_4_TYPE_UNIFIED | \
> > +                        CPUID_4_LEVEL(3) | \
> > +                        CPUID_4_SELF_INIT_LEVEL | \
> > +                        ((cs->nr_cores * cs->nr_threads - 1) << 14);
>=20
> This number seems to be the only difference that isn't just a difference
> constant.  It tempts me to merge the cases for 4 and 0x8000001D as it
> seems that vendors try to be compatible.

Yes. We could merge cases for 4 and 0x8000001D.

>=20
> > +                *ebx =3D (L3_N_LINE_SIZE - 1) | \
> > +                       ((L3_N_PARTITIONS - 1) << 12) | \
> > +                       ((L3_N_ASSOCIATIVITY - 1) << 22);
> > +                *ecx =3D L3_N_SETS_AMD - 1;
> > +                *edx =3D CPUID_4_NO_INVD_SHARING;
> > +                break;
> > +            default: /* end of info */
> > +                *eax =3D 0;
> > +                *ebx =3D 0;
> > +                *ecx =3D 0;
> > +                *edx =3D 0;
> > +                break;
> > +            }
> > +        } else {
> > +            *eax =3D 0;
> > +            *ebx =3D 0;
> > +            *ecx =3D 0;
> > +            *edx =3D 0;
> > +        }
> > +        break;
> >      case 0xC0000000:
> >          *eax =3D env->cpuid_xlevel2;
> >          *ebx =3D 0;
>=20
> The numbers looks like real hardware,

Do you want me to change anything here?=20

>=20
> thanks.
