Received: from eggs.gnu.org ([2001:4830:134:3::10]:55861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dTEte-0006VN-Ea
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 18:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dTEtb-0003Uq-7e
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 18:05:14 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:48962
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Hogan@imgtec.com>)
	id 1dTEta-0003T2-Lz
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 18:05:11 -0400
Date: Thu, 6 Jul 2017 23:05:06 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170706220506.GJ6973@jhogan-linux.le.imgtec.org>
References: <cover.bcfb6a7121f5fd92c9ebda9f199ff06cb0d4bc05.1473159543.git-series.james.hogan@imgtec.com>
	<c8da94c2255ec01501a5ceb6f32d13fc9767026c.1473159543.git-series.james.hogan@imgtec.com>
	<89dddc42-fd28-2c34-5203-62013c5af58b@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VzV6c7pmyfq9zC4X"
Content-Disposition: inline
In-Reply-To: <89dddc42-fd28-2c34-5203-62013c5af58b@imgtec.com>
Subject: Re: [Qemu-devel] [PATCH 7/9] target-mips: Add segmentation control
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

--VzV6c7pmyfq9zC4X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2016 at 03:57:08PM +0100, Yongbok Kim wrote:
>=20
>=20
> On 06/09/2016 12:03, James Hogan wrote:
> > The optional segmentation control registers CP0_SegCtl0, CP0_SegCtl1 &
> > CP0_SegCtl2 control the behaviour and required privilege of the legacy
> > virtual memory segments.
> >=20
> > Add them to the CP0 interface so they can be read and written when
> > CP0_Config3.SC=3D1, and initialise them to describe the standard legacy
> > layout so they can be used in future patches regardless of whether they
> > are exposed to the guest.
> >=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Leon Alrae <leon.alrae@imgtec.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  target-mips/cpu.h       | 31 ++++++++++++++++-
> >  target-mips/helper.h    |  3 ++-
> >  target-mips/machine.c   |  7 ++--
> >  target-mips/op_helper.c | 24 ++++++++++++-
> >  target-mips/translate.c | 84 +++++++++++++++++++++++++++++++++++++++++=
+-
> >  5 files changed, 147 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target-mips/cpu.h b/target-mips/cpu.h
> > index 2abb330272d9..fd8292eaa9c3 100644
> > --- a/target-mips/cpu.h
> > +++ b/target-mips/cpu.h
> > @@ -306,6 +306,36 @@ struct CPUMIPSState {
> >  #define CP0PG_XIE 30
> >  #define CP0PG_ELPA 29
> >  #define CP0PG_IEC 27
> > +    target_ulong CP0_SegCtl0;
> > +    target_ulong CP0_SegCtl1;
> > +    target_ulong CP0_SegCtl2;
> > +#define CP0SC_PA        9
> > +#define CP0SC_PA_MASK   (0x7FULL << CP0SC_PA)
> > +#define CP0SC_PA_1GMASK (0x7EULL << CP0SC_PA)
> > +#define CP0SC_AM        4
> > +#define CP0SC_AM_MASK   (0x7ULL << CP0SC_AM)
> > +#define CP0SC_AM_UK     0ULL
> > +#define CP0SC_AM_MK     1ULL
> > +#define CP0SC_AM_MSK    2ULL
> > +#define CP0SC_AM_MUSK   3ULL
> > +#define CP0SC_AM_MUSUK  4ULL
> > +#define CP0SC_AM_USK    5ULL
> > +#define CP0SC_AM_UUSK   7ULL
> > +#define CP0SC_EU        3
> > +#define CP0SC_EU_MASK   (1ULL << CP0SC_EU)
> > +#define CP0SC_C         0
> > +#define CP0SC_C_MASK    (0x7ULL << CP0SC_C)
> > +#define CP0SC_MASK      (CP0SC_C_MASK | CP0SC_EU_MASK | CP0SC_AM_MASK =
| \
> > +                         CP0SC_PA_MASK)
> > +#define CP0SC_1GMASK    (CP0SC_C_MASK | CP0SC_EU_MASK | CP0SC_AM_MASK =
| \
> > +                         CP0SC_PA_1GMASK)
> > +#define CP0SC0_MASK     (CP0SC_MASK | (CP0SC_MASK << 16))
>=20
> Defining 16 as a macro would be preferable.

Given that the information about each segment occupies half of a
register, and that it is described that way in the PRA (i.e. as 16bit
segment configurations, with the fields within that described in a
single place), I think the use of literal 16 is more readable in this
case.

>=20
> > +#define CP0SC1_XAM      59
> > +#define CP0SC1_XAM_MASK (0x7ULL << CP0SC1_XAM)
> > +#define CP0SC1_MASK     (CP0SC_MASK | (CP0SC_MASK << 16) | CP0SC1_XAM_=
MASK)
> > +#define CP0SC2_XR       56
> > +#define CP0SC2_XR_MASK  (0xFFULL << CP0SC2_XR)
> > +#define CP0SC2_MASK     (CP0SC_1GMASK | (CP0SC_1GMASK << 16) | CP0SC2_=
XR_MASK)
> >      int32_t CP0_Wired;
> >      int32_t CP0_SRSConf0_rw_bitmask;
> >      int32_t CP0_SRSConf0;
> > @@ -449,6 +479,7 @@ struct CPUMIPSState {
> >  #define CP0C3_MSAP  28
> >  #define CP0C3_BP 27
> >  #define CP0C3_BI 26
> > +#define CP0C3_SC 25
> >  #define CP0C3_IPLW 21
> >  #define CP0C3_MMAR 18
> >  #define CP0C3_MCU  17
> > diff --git a/target-mips/helper.h b/target-mips/helper.h
> > index 666936c81bfe..961741370ad2 100644
> > --- a/target-mips/helper.h
> > +++ b/target-mips/helper.h
> > @@ -122,6 +122,9 @@ DEF_HELPER_2(mtc0_entrylo1, void, env, tl)
> >  DEF_HELPER_2(mtc0_context, void, env, tl)
> >  DEF_HELPER_2(mtc0_pagemask, void, env, tl)
> >  DEF_HELPER_2(mtc0_pagegrain, void, env, tl)
> > +DEF_HELPER_2(mtc0_segctl0, void, env, tl)
> > +DEF_HELPER_2(mtc0_segctl1, void, env, tl)
> > +DEF_HELPER_2(mtc0_segctl2, void, env, tl)
> >  DEF_HELPER_2(mtc0_wired, void, env, tl)
> >  DEF_HELPER_2(mtc0_srsconf0, void, env, tl)
> >  DEF_HELPER_2(mtc0_srsconf1, void, env, tl)
> > diff --git a/target-mips/machine.c b/target-mips/machine.c
> > index e795fecaa0d6..d90f217c3fe5 100644
> > --- a/target-mips/machine.c
> > +++ b/target-mips/machine.c
> > @@ -206,8 +206,8 @@ const VMStateDescription vmstate_tlb =3D {
> > =20
> >  const VMStateDescription vmstate_mips_cpu =3D {
> >      .name =3D "cpu",
> > -    .version_id =3D 9,
> > -    .minimum_version_id =3D 9,
> > +    .version_id =3D 10,
> > +    .minimum_version_id =3D 10,
> >      .post_load =3D cpu_post_load,
> >      .fields =3D (VMStateField[]) {
> >          /* Active TC */
> > @@ -247,6 +247,9 @@ const VMStateDescription vmstate_mips_cpu =3D {
> >          VMSTATE_UINTTL(env.CP0_Context, MIPSCPU),
> >          VMSTATE_INT32(env.CP0_PageMask, MIPSCPU),
> >          VMSTATE_INT32(env.CP0_PageGrain, MIPSCPU),
> > +        VMSTATE_UINTTL(env.CP0_SegCtl0, MIPSCPU),
> > +        VMSTATE_UINTTL(env.CP0_SegCtl1, MIPSCPU),
> > +        VMSTATE_UINTTL(env.CP0_SegCtl2, MIPSCPU),
> >          VMSTATE_INT32(env.CP0_Wired, MIPSCPU),
> >          VMSTATE_INT32(env.CP0_SRSConf0, MIPSCPU),
> >          VMSTATE_INT32(env.CP0_SRSConf1, MIPSCPU),
> > diff --git a/target-mips/op_helper.c b/target-mips/op_helper.c
> > index 829ab0bc3cca..983de785b318 100644
> > --- a/target-mips/op_helper.c
> > +++ b/target-mips/op_helper.c
> > @@ -1337,6 +1337,30 @@ void helper_mtc0_pagegrain(CPUMIPSState *env, ta=
rget_ulong arg1)
> >      restore_pamask(env);
> >  }
> > =20
> > +void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
> > +{
> > +    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> > +
> > +    env->CP0_SegCtl0 =3D arg1 & CP0SC0_MASK;
>=20
> Writes of unsupported values to the C field require to leave the field
> unmodified in the R6. Permit 2 (Uncached) only?

Good point.

Though its worth noting that we don't do that for Config0.K0 either:

void helper_mtc0_config0(CPUMIPSState *env, target_ulong arg1)
{
    env->CP0_Config0 =3D (env->CP0_Config0 & 0x81FFFFF8) | (arg1 & 0x000000=
07);
}

>=20
> > +    tlb_flush(cs, 1);
>=20
> cpu_mips_tlb_flush()?

Hmm. My reasoning was that this doesn't in any way affect TLB content or
give away the eviction of TLB entries into the shadow half of the TLB.
It only affects the virtual segments that determine whether the TLB is
used for lookup or not.

So if entries are evicted into the shadow part of the TLB by TLBWR,
there is no reason they should be invalidated just because the segments
were changed.

AFAIU the same logic applies to two other uses of cpu_mips_tlb_flush():
- When status.UX/SX/KX is cleared (mappings still persist and nothing is
  given away about evicted TLB entries).
- When the ASID is changed (ASID stored in tlb entries so mappings
  persist, with nothing given away about evicted TLB entries).

Whereas the remaining uses of cpu_mips_tlb_flush() make absolute sense:
- tlbinv and tlbinvf would legitimately be expected to ensure mappings
  are no longer accessible.
- tlbr calls r4k_mips_tlb_flush_extra() unconditionally anyway.

As do the uses of r4k_mips_tlb_flush_extra():
- tlbwi to revoke permissions would legitimately be expected to ensure
  the old mapping is no longer accessible.
  erm, BUG? what about XI, RI, and EHINV bits changing? I'll check/fix
  if I get the time.
- tlbp gives away that a mapping has been evicted.
- tlbr could be used to deduce that a mapping has been evicted.

>=20
> > +}
> > +
> > +void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
> > +{
> > +    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> > +
> > +    env->CP0_SegCtl1 =3D arg1 & CP0SC1_MASK;
> > +    tlb_flush(cs, 1);
> > +}
> > +
> > +void helper_mtc0_segctl2(CPUMIPSState *env, target_ulong arg1)
> > +{
> > +    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> > +
> > +    env->CP0_SegCtl2 =3D arg1 & CP0SC2_MASK;
> > +    tlb_flush(cs, 1);
> > +}
> > +
> >  void helper_mtc0_wired(CPUMIPSState *env, target_ulong arg1)
> >  {
> >      if (env->insn_flags & ISA_MIPS32R6) {
> > diff --git a/target-mips/translate.c b/target-mips/translate.c
> > index af17fc95eb8f..28d93bb56cd0 100644
> > --- a/target-mips/translate.c
> > +++ b/target-mips/translate.c
> > @@ -1449,6 +1449,7 @@ typedef struct DisasContext {
> >      uint64_t PAMask;
> >      bool mvh;
> >      bool eva;
> > +    bool sc;
> >      int CP0_LLAddr_shift;
> >      bool ps;
> >      bool vp;
> > @@ -5216,6 +5217,21 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
> >              gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageGrain)=
);
> >              rn =3D "PageGrain";
> >              break;
> > +        case 2:
> > +            CP0_CHECK(ctx->sc);
> > +            tcg_gen_ld32s_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_=
SegCtl0));
>=20
> This might cause problem in 64-bit guest with big-endian host. Replace it
> with tcg_gen_ld_tl() and tcg_gen_ext32s_tl().

Hmm yes, MFC0 UserLocal looks suspect too (how did that ever work...).

>=20
> > +            rn =3D "SegCtl0";
> > +            break;
> > +        case 3:
> > +            CP0_CHECK(ctx->sc);
> > +            tcg_gen_ld32s_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_=
SegCtl1));
>=20
> same as above
>=20
> > +            rn =3D "SegCtl1";
> > +            break;
> > +        case 4:
> > +            CP0_CHECK(ctx->sc);
> > +            tcg_gen_ld32s_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_=
SegCtl2));
>=20
> and here.
>=20
> > +            rn =3D "SegCtl2";
> > +            break;
> >          default:
> >              goto cp0_unimplemented;
> >          }
> > @@ -5872,6 +5888,21 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
> >              rn =3D "PageGrain";
> >              ctx->bstate =3D BS_STOP;
> >              break;
> > +        case 2:
> > +            CP0_CHECK(ctx->sc);
> > +            gen_helper_mtc0_segctl0(cpu_env, arg);
> > +            rn =3D "SegCtl0";
> > +            break;
> > +        case 3:
> > +            CP0_CHECK(ctx->sc);
> > +            gen_helper_mtc0_segctl1(cpu_env, arg);
> > +            rn =3D "SegCtl1";
> > +            break;
> > +        case 4:
> > +            CP0_CHECK(ctx->sc);
> > +            gen_helper_mtc0_segctl2(cpu_env, arg);
> > +            rn =3D "SegCtl2";
> > +            break;
> >          default:
> >              goto cp0_unimplemented;
> >          }
> > @@ -6534,6 +6565,20 @@ static void gen_dmfc0(DisasContext *ctx, TCGv ar=
g, int reg, int sel)
> >              gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageGrain)=
);
> >              rn =3D "PageGrain";
> >              break;
> > +        case 2:
> > +            CP0_CHECK(ctx->sc);
> > +            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Seg=
Ctl0));
> > +            rn =3D "SegCtl0";
> > +            break;
> > +        case 3:
> > +            CP0_CHECK(ctx->sc);
> > +            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Seg=
Ctl1));
> > +            rn =3D "SegCtl1";
> > +            break;
> > +        case 4:
> > +            CP0_CHECK(ctx->sc);
> > +            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Seg=
Ctl2));
> > +            rn =3D "SegCtl2";
> >          default:
> >              goto cp0_unimplemented;
> >          }
> > @@ -7172,6 +7217,21 @@ static void gen_dmtc0(DisasContext *ctx, TCGv ar=
g, int reg, int sel)
> >              gen_helper_mtc0_pagegrain(cpu_env, arg);
> >              rn =3D "PageGrain";
> >              break;
> > +        case 2:
> > +            CP0_CHECK(ctx->sc);
> > +            gen_helper_mtc0_segctl0(cpu_env, arg);
> > +            rn =3D "SegCtl0";
> > +            break;
> > +        case 3:
> > +            CP0_CHECK(ctx->sc);
> > +            gen_helper_mtc0_segctl1(cpu_env, arg);
> > +            rn =3D "SegCtl1";
> > +            break;
> > +        case 4:
> > +            CP0_CHECK(ctx->sc);
> > +            gen_helper_mtc0_segctl2(cpu_env, arg);
> > +            rn =3D "SegCtl2";
> > +            break;
> >          default:
> >              goto cp0_unimplemented;
> >          }
> > @@ -19989,6 +20049,7 @@ void gen_intermediate_code(CPUMIPSState *env, s=
truct TranslationBlock *tb)
> >      ctx.PAMask =3D env->PAMask;
> >      ctx.mvh =3D (env->CP0_Config5 >> CP0C5_MVH) & 1;
> >      ctx.eva =3D (env->CP0_Config5 >> CP0C5_EVA) & 1;
> > +    ctx.sc =3D (env->CP0_Config3 >> CP0C3_SC) & 1;
> >      ctx.CP0_LLAddr_shift =3D env->CP0_LLAddr_shift;
> >      ctx.cmgcr =3D (env->CP0_Config3 >> CP0C3_CMGCR) & 1;
> >      /* Restore delay slot state from the tb context.  */
> > @@ -20463,6 +20524,29 @@ void cpu_state_reset(CPUMIPSState *env)
> >              env->tcs[0].CP0_TCStatus =3D (1 << CP0TCSt_A);
> >          }
> >      }
> > +
> > +    /*
> > +     * Configure default legacy segmentation control. We use this rega=
rdless of
> > +     * whether segmentation control is presented to the guest.
> > +     */
> > +    /* KSeg3 (seg0 0xE0000000..0xFFFFFFFF) */
> > +    env->CP0_SegCtl0 =3D   (CP0SC_AM_MK << CP0SC_AM);
> > +    /* KSeg2 (seg1 0xC0000000..0xDFFFFFFF) */
> > +    env->CP0_SegCtl0 |=3D ((CP0SC_AM_MSK << CP0SC_AM)) << 16;
> > +    /* KSeg1 (seg2 0xA0000000..0x9FFFFFFF) */
> > +    env->CP0_SegCtl1 =3D   (0 << CP0SC_PA) | (CP0SC_AM_UK << CP0SC_AM)=
 |
> > +                         (2 << CP0SC_C);
> > +    /* KSeg0 (seg3 0x80000000..0x9FFFFFFF) */
> > +    env->CP0_SegCtl1 |=3D ((0 << CP0SC_PA) | (CP0SC_AM_UK << CP0SC_AM)=
 |
> > +                         (3 << CP0SC_C)) << 16;
> > +    /* USeg (seg4 0x40000000..0x7FFFFFFF) */
> > +    env->CP0_SegCtl2 =3D   (2 << CP0SC_PA) | (CP0SC_AM_MUSK << CP0SC_A=
M) |
> > +                         (1 << CP0SC_EU) | (2 << CP0SC_C);
>=20
> Reset value of C is Undefined in the spec?

Well, it says the reset state of the SegCtl registers is Implementation
Dependent (since some cores can be hardware configured to boot in EVA
mode).

>=20
> > +    /* USeg (seg5 0x00000000..0x3FFFFFFF) */
> > +    env->CP0_SegCtl2 |=3D ((0 << CP0SC_PA) | (CP0SC_AM_MUSK << CP0SC_A=
M) |
> > +                         (1 << CP0SC_EU) | (2 << CP0SC_C)) << 16;
>=20
> Same here
>=20
> > +    /* XKPhys (note, SegCtl2.XR =3D 0, so XAM won't be used) */
> > +    env->CP0_SegCtl1 |=3D (CP0SC_AM_UK << CP0SC1_XAM);
>=20
> SegCtl1.XAM is undefined too?

Erm, it indeed does say that. UK is effectively the default since
SegCtl2.XR resets to 0.

What are you suggesting though, that we put a random rather than
sensible value in there?

>=20
> >  #endif
> >      if ((env->insn_flags & ISA_MIPS32R6) &&
> >          (env->active_fpu.fcr0 & (1 << FCR0_F64))) {
> >=20
>=20
>=20
> Regards,
> Yongbok

Thanks for the reviews,

Cheers
James

--VzV6c7pmyfq9zC4X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlles/8ACgkQbAtpk944
dno0hxAAoV3Kn+xsnD4l/F4MxCRIKqDQQPFzn2L6AlfeEApg6sWlLs1ObaFoM6ZC
ZhKE6TmJnQFn3MUMngj9Oc6VJahtrVWulgzMoTW8g/hFNB1EQFJYZZDTK2PhV1d9
a6g1gTSAuGKQwVUjJOx/YamT4lH7GP6Nal8dlaH8asS09u7jthwz1E6dDmRZQ7Y4
11hMjs4UsSyHek0nyO+0DPGQcT2XtRHys/Zf+GIVYTADB0JZiLZuszpyc+6B6tsO
iLLpZPkp5lD5Leu+31MwVj5mrsrGL1SxmWhSnFWuaH/BmSW78xi6FV6kPXd8ISGM
iBj2FNiDRAQWSFDoiJAbCZ63zWwfUxG79iPMJj1/Ie9gE9eCtp/hsaDdZbKKJas4
0rccg45EwSU6z9W75/a7EXDKusjKo8CUcf7g0NxZsMBYxPC4LpnTsxNcrqlELHGA
btkzEx8VYRkap3UHtuY8AFTdf3dJdNI2XS2wqR2an2AQekfVRhDj3xhzHPIYwVbh
9ofZdLF9ZsJFgY0pf+nbRWfS4NzJWEM+/W4eSjYuzuE+h7cCiatdtU+AsJSERp3q
LfEtvfgfCYY4Kb6l1ohwNTWdJx1FTmzfhr9an8ieQq+QJJwzochKOOB6TYMCmDh9
YhLpMptp7N+sOQXSPJ3BJL+GxnmcmBdnW/SCWAtGZW4CnicLSHQ=
=yfO8
-----END PGP SIGNATURE-----

--VzV6c7pmyfq9zC4X--
