Received: from eggs.gnu.org ([2001:4830:134:3::10]:58045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dTDrU-0007ho-NE
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dTDrQ-0003WV-Dx
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:58:56 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:8586
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Hogan@imgtec.com>)
	id 1dTDrQ-0003W4-2Z
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:58:52 -0400
Date: Thu, 6 Jul 2017 21:58:50 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170706205850.GI6973@jhogan-linux.le.imgtec.org>
References: <cover.bcfb6a7121f5fd92c9ebda9f199ff06cb0d4bc05.1473159543.git-series.james.hogan@imgtec.com>
	<c9cf87a5675358a3faec364ce40d908d11decfa2.1473159543.git-series.james.hogan@imgtec.com>
	<08f77489-344c-2d55-fdfa-3004b5350ae3@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HnUrGTC8cx3b8/Hq"
Content-Disposition: inline
In-Reply-To: <08f77489-344c-2d55-fdfa-3004b5350ae3@imgtec.com>
Subject: Re: [Qemu-devel] [PATCH 6/9] target-mips: Add an MMU mode for ERL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Leon Alrae <leon.alrae@imgtec.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

--HnUrGTC8cx3b8/Hq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2016 at 02:18:31PM +0100, Yongbok Kim wrote:
>=20
>=20
> On 06/09/2016 12:03, James Hogan wrote:
> > The segmentation control feature allows a legacy memory segment to
> > become unmapped uncached at error level (according to CP0_Status.ERL),
> > and in fact the user segment is already treated in this way by QEMU.
> >=20
> > Add a new MMU mode for this state so that QEMU's mappings don't persist
> > between ERL=3D0 and ERL=3D1.
> >=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Leon Alrae <leon.alrae@imgtec.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  target-mips/cpu.h       | 17 +++++++++++++----
> >  target-mips/op_helper.c |  2 ++
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/target-mips/cpu.h b/target-mips/cpu.h
> > index 8ddc965e4735..2abb330272d9 100644
> > --- a/target-mips/cpu.h
> > +++ b/target-mips/cpu.h
> > @@ -134,7 +134,7 @@ struct CPUMIPSFPUContext {
> >  #define FP_UNIMPLEMENTED  32
> >  };
> > =20
> > -#define NB_MMU_MODES 3
> > +#define NB_MMU_MODES 4
> >  #define TARGET_INSN_START_EXTRA_WORDS 2
> > =20
> >  typedef struct CPUMIPSMVPContext CPUMIPSMVPContext;
> > @@ -550,7 +550,7 @@ struct CPUMIPSState {
> >  #define EXCP_INST_NOTAVAIL 0x2 /* No valid instruction word for BadIns=
tr */
> >      uint32_t hflags;    /* CPU State */
> >      /* TMASK defines different execution modes */
> > -#define MIPS_HFLAG_TMASK  0xF5807FF
> > +#define MIPS_HFLAG_TMASK  0x1F5807FF
> >  #define MIPS_HFLAG_MODE   0x00007 /* execution modes                  =
  */
> >      /* The KSU flags must be the lowest bits in hflags. The flag order
> >         must be the same as defined for CP0 Status. This allows to use
> > @@ -600,6 +600,7 @@ struct CPUMIPSState {
> >  #define MIPS_HFLAG_FRE   0x2000000 /* FRE enabled */
> >  #define MIPS_HFLAG_ELPA  0x4000000
> >  #define MIPS_HFLAG_ITC_CACHE  0x8000000 /* CACHE instr. operates on IT=
C tag */
> > +#define MIPS_HFLAG_ERL   0x10000000 /* error level flag */
> >      target_ulong btarget;        /* Jump / branch target              =
 */
> >      target_ulong bcond;          /* Branch condition (if needed)      =
 */
> > =20
> > @@ -694,11 +695,16 @@ extern uint32_t cpu_rddsp(uint32_t mask_num, CPUM=
IPSState *env);
> >  #define MMU_MODE0_SUFFIX _kernel
> >  #define MMU_MODE1_SUFFIX _super
> >  #define MMU_MODE2_SUFFIX _user
> > +#define MMU_MODE3_SUFFIX _error
> >  #define MMU_USER_IDX 2
> > =20
> >  static inline int hflags_mmu_index(uint32_t hflags)
> >  {
> > -    return hflags & MIPS_HFLAG_KSU;
> > +    if (hflags & MIPS_HFLAG_ERL) {
> > +        return 3; /* ERL */
>=20
> Not really useful but consider to macro it.

Yeh, I mainly didn't do this as the other MMU indices don't have
definitions either (see switch of literal numbers below).

Cheers
James

>=20
> > +    } else {
> > +        return hflags & MIPS_HFLAG_KSU;
> > +    }
> >  }
> > =20
> >  static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
> > @@ -966,7 +972,10 @@ static inline void compute_hflags(CPUMIPSState *en=
v)
> >                       MIPS_HFLAG_F64 | MIPS_HFLAG_FPU | MIPS_HFLAG_KSU |
> >                       MIPS_HFLAG_AWRAP | MIPS_HFLAG_DSP | MIPS_HFLAG_DS=
PR2 |
> >                       MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA | MIPS_HFLAG_FRE=
 |
> > -                     MIPS_HFLAG_ELPA);
> > +                     MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL);
> > +    if (env->CP0_Status & (1 << CP0St_ERL)) {
> > +        env->hflags |=3D MIPS_HFLAG_ERL;
> > +    }
> >      if (!(env->CP0_Status & (1 << CP0St_EXL)) &&
> >          !(env->CP0_Status & (1 << CP0St_ERL)) &&
> >          !(env->hflags & MIPS_HFLAG_DM)) {
> > diff --git a/target-mips/op_helper.c b/target-mips/op_helper.c
> > index 71ad16e41dd4..829ab0bc3cca 100644
> > --- a/target-mips/op_helper.c
> > +++ b/target-mips/op_helper.c
> > @@ -66,6 +66,7 @@ static inline type do_##name(CPUMIPSState *env, targe=
t_ulong addr,      \
> >      case 1: return (type) cpu_##insn##_super_ra(env, addr, retaddr);  =
  \
> >      default:                                                          =
  \
> >      case 2: return (type) cpu_##insn##_user_ra(env, addr, retaddr);   =
  \
> > +    case 3: return (type) cpu_##insn##_error_ra(env, addr, retaddr);  =
  \
> >      }                                                                 =
  \
> >  }
> >  #endif
> > @@ -93,6 +94,7 @@ static inline void do_##name(CPUMIPSState *env, targe=
t_ulong addr,      \
> >      case 1: cpu_##insn##_super_ra(env, addr, val, retaddr); break;    =
  \
> >      default:                                                          =
  \
> >      case 2: cpu_##insn##_user_ra(env, addr, val, retaddr); break;     =
  \
> > +    case 3: cpu_##insn##_error_ra(env, addr, val, retaddr); break;    =
  \
> >      }                                                                 =
  \
> >  }
> >  #endif
> >=20
>=20
> Otherwise,
>=20
> Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
>=20
> Regards,
> Yongbok

--HnUrGTC8cx3b8/Hq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllepIkACgkQbAtpk944
dnpe9Q//f5VH5KtjJ22IJBCDdd/Q7/EKD///YKJi9Q+PGOcD3gSnT8gfpbPbe/9X
W49H/z+QRrpnhr9+bKv7pWp0EgKx/fGqVRZN824Qm+1oz7tCV0Vgx8Abq10yOAZd
OOcWueN3019DC+vCvkt7/9vpDjPvikIuKKRjnErpzmiMW+R65p8qlmfWDFk8ars9
5VHgXEyEtVM3Ajx4xhTsBwqedTiPvWoi5DEzMeYmhOFgW789EiOrHUCLajNWY2El
kexGVYXenCaUomDAF9vmXc33U7A1YrqZlTaQI+R5Ttu+Ezuvav2561jH4IjbyZ9t
khIDeV8oC9OKPYDGAOJdx2s8Xc/sFYRxFgGqp9/dm02UnDF1yJJFsg7Br75UygSu
hBjrID5NtFhWYLJnGyUgTSwAqb+OWN/su5RxFSVXY0z7OC0qjafcqv7IiHOm/YaD
SPj/kjNiVXzO1KHXa5UDgsEBzjn47rdK9/G4sBLJQ5+nK3U9U0cHnJG1BPUwBxf5
qA1H8WkN2XRKB/5VhdJk7TiNJVp7FSDYxpTD5pZiy9L+LLelShSzMoLlxWI80Rlh
fOyNPXzbgs/bzaWwavYzgJPvHaP83JFrTTo0Ct2B8/hPOmVmF0Hwnj2V7sCocf8V
+kFUTarzYkqvUebcx8lCcqZOmXIJxfXa07DQO1ydIyrxT68CY8k=
=uXAg
-----END PGP SIGNATURE-----

--HnUrGTC8cx3b8/Hq--
