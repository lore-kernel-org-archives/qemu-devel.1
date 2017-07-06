Received: from eggs.gnu.org ([2001:4830:134:3::10]:52139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dTFza-0001er-Tv
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dTFzX-00047J-NB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:15:26 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:16604
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Hogan@imgtec.com>)
	id 1dTFzX-00046Y-8s
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:15:23 -0400
Date: Fri, 7 Jul 2017 00:15:21 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170706231521.GK6973@jhogan-linux.le.imgtec.org>
References: <cover.bcfb6a7121f5fd92c9ebda9f199ff06cb0d4bc05.1473159543.git-series.james.hogan@imgtec.com>
	<9057a85806e92c0cf6e0f5df93f44d894523c263.1473159543.git-series.james.hogan@imgtec.com>
	<bbf5a749-ed79-1b59-92cd-4ad7ee249f02@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bHoIUPdzgh/2fjbD"
Content-Disposition: inline
In-Reply-To: <bbf5a749-ed79-1b59-92cd-4ad7ee249f02@imgtec.com>
Subject: Re: [Qemu-devel] [PATCH 8/9] target-mips: Implement segmentation
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

--bHoIUPdzgh/2fjbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2016 at 02:06:25PM +0100, Yongbok Kim wrote:
>=20
>=20
> On 06/09/2016 12:03, James Hogan wrote:
> > Implement the optional segmentation control feature in the virtual to
> > physical address translation code.
> >=20
> > The fixed legacy segment and XKPhys handling is replaced with a dynamic
> > layout based on the segmentation control registers (which should be set
> > up even when the feature is not exposed to the guest).
> >=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Leon Alrae <leon.alrae@imgtec.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  target-mips/helper.c | 154 +++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 123 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/target-mips/helper.c b/target-mips/helper.c
> > index 2065fc3ec119..63d709bd620f 100644
> > --- a/target-mips/helper.c
> > +++ b/target-mips/helper.c
> > @@ -107,15 +107,107 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *=
physical, int *prot,
> >      return TLBRET_NOMATCH;
> >  }
> > =20
> > +static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
> > +{
>=20
> Nice :) I like this simplified logic to decode access controls.
>=20
> > +    /*
> > +     * Interpret access control mode and mmu_idx.
> > +     *           AdE?     TLB?
> > +     *      AM  K S U E  K S U E
> > +     * UK    0  0 1 1 0  0 - - 0
> > +     * MK    1  0 1 1 0  1 - - !eu
> > +     * MSK   2  0 0 1 0  1 1 - !eu
> > +     * MUSK  3  0 0 0 0  1 1 1 !eu
> > +     * MUSUK 4  0 0 0 0  0 1 1 0
> > +     * USK   5  0 0 1 0  0 0 - 0
> > +     * -     6  - - - -  - - - -
> > +     * UUSK  7  0 0 0 0  0 0 0 0
> > +     */
> > +    int32_t adetlb_mask;
> > +
> > +    switch (mmu_idx) {
> > +    case 3 /* ERL */:
> > +        /* If EU is set, always unmapped */
> > +        if (eu) {
> > +            return 0;
> > +        }
>=20
> I guess checking ERL and EU has to be outside of the switch case.
> If ERL =3D 1 and EU =3D 0 then it has to check with the current Privilege=
 level
> but in this case it falls through and always checks against Kernel mode.

No, "The processor is in Kernel Mode when the DM bit in the Debug
register is 0... and any of the following is true... The ERL bit in the
Status register is 1"

See how compute_hflags() leaves hflags & KSU =3D=3D KM in the specified
cases.

>=20
> > +        /* fall through */
> > +    case MIPS_HFLAG_KM:
> > +        /* Never AdE, TLB mapped if AM=3D{1,2,3} */
> > +        adetlb_mask =3D 0x70000000;
> > +        goto check_tlb;
> > +
> > +    case MIPS_HFLAG_SM:
> > +        /* AdE if AM=3D{0,1}, TLB mapped if AM=3D{2,3,4} */
> > +        adetlb_mask =3D 0xc0380000;
> > +        goto check_ade;
> > +
> > +    case MIPS_HFLAG_UM:
> > +        /* AdE if AM=3D{0,1,2,5}, TLB mapped if AM=3D{3,4} */
> > +        adetlb_mask =3D 0xe4180000;
> > +        /* fall through */
> > +    check_ade:
> > +        /* does this AM cause AdE in current execution mode */
> > +        if ((adetlb_mask << am) < 0) {
> > +            return TLBRET_BADADDR;
> > +        }
> > +        adetlb_mask <<=3D 8;
> > +        /* fall through */
> > +    check_tlb:
> > +        /* is this AM mapped in current execution mode */
> > +        return ((adetlb_mask << am) < 0);
> > +    default:
> > +        assert(0);
> > +        return TLBRET_BADADDR;
> > +    };
> > +}
> > +
> > +static int get_seg_physical_address(CPUMIPSState *env, hwaddr *physica=
l,
> > +                                    int *prot, target_ulong real_addre=
ss,
> > +                                    int rw, int access_type, int mmu_i=
dx,
> > +                                    unsigned int am, bool eu,
> > +                                    target_ulong segmask,
> > +                                    target_ulong physical_base)
>=20
> uint64_t for physical_base. see below comment.
>=20
> > +{
> > +    int mapped =3D is_seg_am_mapped(am, eu, mmu_idx);
> > +
> > +    if (mapped < 0) {
> > +        /* is_seg_am_mapped can report TLBRET_BADADDR */
> > +        return mapped;
> > +    } else if (mapped) {
> > +        /* The segment is TLB mapped */
> > +        return env->tlb->map_address(env, physical, prot, real_address=
, rw,
> > +                                     access_type);
> > +    } else {
> > +        /* The segment is unmapped */
> > +        *physical =3D physical_base | (real_address & segmask);
> > +        *prot =3D PAGE_READ | PAGE_WRITE;
> > +        return TLBRET_MATCH;
> > +    }
> > +}
> > +
> > +static int get_segctl_physical_address(CPUMIPSState *env, hwaddr *phys=
ical,
> > +                                       int *prot, target_ulong real_ad=
dress,
> > +                                       int rw, int access_type, int mm=
u_idx,
> > +                                       uint16_t segctl, target_ulong s=
egmask)
> > +{
> > +    unsigned int am =3D (segctl & CP0SC_AM_MASK) >> CP0SC_AM;
> > +    bool eu =3D (segctl >> CP0SC_EU) & 1;
> > +    target_ulong pa =3D ((target_ulong)segctl & CP0SC_PA_MASK) << 20;
>=20
> According to the architecture spec, PA supports mapping of up to a 36-bit
> physical address. uint64_t would be better for PA and physical_base.

Yes, good catch.

>=20
> > +
> > +    return get_seg_physical_address(env, physical, prot, real_address,=
 rw,
> > +                                    access_type, mmu_idx, am, eu, segm=
ask,
> > +                                    pa & ~segmask);
> > +}
> > +
> >  static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
> >                                  int *prot, target_ulong real_address,
> >                                  int rw, int access_type, int mmu_idx)
> >  {
> >      /* User mode can only access useg/xuseg */
> > +#if defined(TARGET_MIPS64)
> >      int user_mode =3D mmu_idx =3D=3D MIPS_HFLAG_UM;
> >      int supervisor_mode =3D mmu_idx =3D=3D MIPS_HFLAG_SM;
> >      int kernel_mode =3D !user_mode && !supervisor_mode;
> > -#if defined(TARGET_MIPS64)
> >      int UX =3D (env->CP0_Status & (1 << CP0St_UX)) !=3D 0;
> >      int SX =3D (env->CP0_Status & (1 << CP0St_SX)) !=3D 0;
> >      int KX =3D (env->CP0_Status & (1 << CP0St_KX)) !=3D 0;
> > @@ -148,12 +240,16 @@ static int get_physical_address (CPUMIPSState *en=
v, hwaddr *physical,
> > =20
> >      if (address <=3D USEG_LIMIT) {
> >          /* useg */
> > -        if (env->CP0_Status & (1 << CP0St_ERL)) {
> > -            *physical =3D address & 0xFFFFFFFF;
> > -            *prot =3D PAGE_READ | PAGE_WRITE;
> > +        uint16_t segctl;
> > +
> > +        if (address >=3D 0x40000000UL) {
> > +            segctl =3D env->CP0_SegCtl2;
> >          } else {
> > -            ret =3D env->tlb->map_address(env, physical, prot, real_ad=
dress, rw, access_type);
> > +            segctl =3D env->CP0_SegCtl2 >> 16;
> >          }
> > +        ret =3D get_segctl_physical_address(env, physical, prot, real_=
address, rw,
> > +                                          access_type, mmu_idx, segctl,
> > +                                          0x3FFFFFFF);
> >  #if defined(TARGET_MIPS64)
> >      } else if (address < 0x4000000000000000ULL) {
> >          /* xuseg */
> > @@ -172,10 +268,16 @@ static int get_physical_address (CPUMIPSState *en=
v, hwaddr *physical,
> >          }
> >      } else if (address < 0xC000000000000000ULL) {
> >          /* xkphys */
> > -        if (kernel_mode && KX &&
> > -            (address & 0x07FFFFFFFFFFFFFFULL) <=3D env->PAMask) {
> > -            *physical =3D address & env->PAMask;
> > -            *prot =3D PAGE_READ | PAGE_WRITE;
> > +        if (KX && (address & 0x07FFFFFFFFFFFFFFULL) <=3D env->PAMask) {
>=20
> KX should be dropped from here.
> More over, we need to check KX, SX and UX whether it meets minimum
> privilege level according to AM.

Oh, hmm... good point!

Cheers
James

>=20
> > +            unsigned int am =3D CP0SC_AM_UK;
>=20
> When the region is disabled, it is valid for Kernel mode only.
>=20
> > +            unsigned int xr =3D (env->CP0_SegCtl2 & CP0SC2_XR_MASK) >>=
 CP0SC2_XR;
> > +
> > +            if (xr & (1 << ((address >> 59) & 0x7))) {
> > +                am =3D (env->CP0_SegCtl1 & CP0SC1_XAM_MASK) >> CP0SC1_=
XAM;
> > +            }
> > +            ret =3D get_seg_physical_address(env, physical, prot, real=
_address,
> > +                                           rw, access_type, mmu_idx, a=
m, false,
> > +                                           env->PAMask, 0);
> >          } else {
> >              ret =3D TLBRET_BADADDR;
> >          }
> > @@ -190,35 +292,25 @@ static int get_physical_address (CPUMIPSState *en=
v, hwaddr *physical,
> >  #endif
> >      } else if (address < (int32_t)KSEG1_BASE) {
> >          /* kseg0 */
> > -        if (kernel_mode) {
> > -            *physical =3D address - (int32_t)KSEG0_BASE;
> > -            *prot =3D PAGE_READ | PAGE_WRITE;
> > -        } else {
> > -            ret =3D TLBRET_BADADDR;
> > -        }
> > +        ret =3D get_segctl_physical_address(env, physical, prot, real_=
address, rw,
> > +                                          access_type, mmu_idx,
> > +                                          env->CP0_SegCtl1 >> 16, 0x1F=
FFFFFF);
> >      } else if (address < (int32_t)KSEG2_BASE) {
> >          /* kseg1 */
> > -        if (kernel_mode) {
> > -            *physical =3D address - (int32_t)KSEG1_BASE;
> > -            *prot =3D PAGE_READ | PAGE_WRITE;
> > -        } else {
> > -            ret =3D TLBRET_BADADDR;
> > -        }
> > +        ret =3D get_segctl_physical_address(env, physical, prot, real_=
address, rw,
> > +                                          access_type, mmu_idx,
> > +                                          env->CP0_SegCtl1, 0x1FFFFFFF=
);
> >      } else if (address < (int32_t)KSEG3_BASE) {
> >          /* sseg (kseg2) */
> > -        if (supervisor_mode || kernel_mode) {
> > -            ret =3D env->tlb->map_address(env, physical, prot, real_ad=
dress, rw, access_type);
> > -        } else {
> > -            ret =3D TLBRET_BADADDR;
> > -        }
> > +        ret =3D get_segctl_physical_address(env, physical, prot, real_=
address, rw,
> > +                                          access_type, mmu_idx,
> > +                                          env->CP0_SegCtl0 >> 16, 0x1F=
FFFFFF);
> >      } else {
> >          /* kseg3 */
> >          /* XXX: debug segment is not emulated */
> > -        if (kernel_mode) {
> > -            ret =3D env->tlb->map_address(env, physical, prot, real_ad=
dress, rw, access_type);
> > -        } else {
> > -            ret =3D TLBRET_BADADDR;
> > -        }
> > +        ret =3D get_segctl_physical_address(env, physical, prot, real_=
address, rw,
> > +                                          access_type, mmu_idx,
> > +                                          env->CP0_SegCtl0, 0x1FFFFFFF=
);
> >      }
> >      return ret;
> >  }
> >=20
>=20
>=20
> Regards,
> Yongbok

--bHoIUPdzgh/2fjbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllexIgACgkQbAtpk944
dnqX8BAAwMWGUo718GlxXRyQsUWt1Zsr1d3kS3GXdwQg3CEVKAXFMF7WPXeJRS22
iiFPBuPv0/W3PZzafrHQHlae1S2MpprCmQEbZzyKyYhfRv5arorPNkOUzCIEVv4x
4jreDvsXMMudvOmaOo3TcO9MJ+852E6LACC1sf7W2ohl7VcQiYYa0gQM2AXAKfxr
68YgIE0DgznLevqjeM3DzdpkCYU4hhbgZev0x9FlN/S6RtW81i3IIgB7DtheWuX8
FnFd/Y5nNLULJwxtYIngwTT113M+nhEa04Qt13CbQVMJ0kZn/FbVKzUkfu48DNLH
bNrra5QYiI0iAsmt1rFd2cGIzj62TPNsAdOjs6gJk/EcEkN5Ogb2A9qfnrWK4C0a
y57ikuUuiHSTQE8xkt3Opipkm85x+UbjOC6faqRp3OAdeNFvxRVW82r4cs6+ePh2
NXynL3ZW6k57zK5xF8YMpkopM8VqpoYnj4fkY2qEkJtplwc2YIkJHrjlahcfSXiF
LPedq3PxxjeHNw/vfKPdWJhBP6+gFr0GLQRJ62YnaPEWpXkMvF07ARKJ3Ro/JM9L
iQFukgkVXtvG5ZsQlYQ+ExyS+KwKUifEoqk9lnWDt2y3VNJGuRvt5lhm8sfK7eiM
PjnAk8xQ6rWr6lg3GEwNRopIPsu53ganyeEbU8oOau06PLZSiVo=
=MzjV
-----END PGP SIGNATURE-----

--bHoIUPdzgh/2fjbD--
