Received: from eggs.gnu.org ([2001:4830:134:3::10]:56602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dTDo9-0006vB-1f
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dTDo4-00011K-OH
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:55:29 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:29302
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Hogan@imgtec.com>)
	id 1dTDo4-0000zh-Ep
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:55:24 -0400
Date: Thu, 6 Jul 2017 21:55:22 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170706205522.GB32741@jhogan-linux.le.imgtec.org>
References: <cover.bcfb6a7121f5fd92c9ebda9f199ff06cb0d4bc05.1473159543.git-series.james.hogan@imgtec.com>
	<8ab0a89634e5cde1eaf41ef34e1a575730d30751.1473159543.git-series.james.hogan@imgtec.com>
	<357709a6-142a-1544-1c01-675897378cff@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <357709a6-142a-1544-1c01-675897378cff@imgtec.com>
Subject: Re: [Qemu-devel] [PATCH 5/9] target-mips: Abstract mmu_idx from
 hflags
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

--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2016 at 05:08:46PM +0100, Yongbok Kim wrote:
> On 06/09/2016 12:03, James Hogan wrote:
> > The MIPS mmu_idx is sometimes calculated from hflags without an env
> > pointer available as cpu_mmu_index() requires.
> >=20
> > Create a common hflags_mmu_index() for the purpose of this calculation
> > which can operate on any hflags, not just with an env pointer, and
> > update cpu_mmu_index() itself and gen_intermediate_code() to use it.
> >=20
> > This will also allow the logic to be more easily updated when a new MMU
> > mode is added.
> >=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Leon Alrae <leon.alrae@imgtec.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  target-mips/cpu.h       | 8 +++++++-
> >  target-mips/translate.c | 2 +-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target-mips/cpu.h b/target-mips/cpu.h
> > index 6ea2bf14c817..8ddc965e4735 100644
> > --- a/target-mips/cpu.h
> > +++ b/target-mips/cpu.h
> > @@ -695,9 +695,15 @@ extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMI=
PSState *env);
> >  #define MMU_MODE1_SUFFIX _super
> >  #define MMU_MODE2_SUFFIX _user
> >  #define MMU_USER_IDX 2
> > +
> > +static inline int hflags_mmu_index(uint32_t hflags)
> > +{
> > +    return hflags & MIPS_HFLAG_KSU;
> > +}
> > +
> >  static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
> >  {
> > -    return env->hflags & MIPS_HFLAG_KSU;
> > +    return hflags_mmu_index(env->hflags);
> >  }
> > =20
> >  static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
> > diff --git a/target-mips/translate.c b/target-mips/translate.c
> > index 8506c39a359c..af17fc95eb8f 100644
> > --- a/target-mips/translate.c
> > +++ b/target-mips/translate.c
> > @@ -20004,7 +20004,7 @@ void gen_intermediate_code(CPUMIPSState *env, s=
truct TranslationBlock *tb)
> >  #ifdef CONFIG_USER_ONLY
> >          ctx.mem_idx =3D MIPS_HFLAG_UM;
> >  #else
> > -        ctx.mem_idx =3D ctx.hflags & MIPS_HFLAG_KSU;
> > +        ctx.mem_idx =3D hflags_mmu_index(ctx.hflags);
> >  #endif
> >      ctx.default_tcg_memop_mask =3D (ctx.insn_flags & ISA_MIPS32R6) ?
> >                                   MO_UNALN : MO_ALIGN;
> >=20
>=20
> There are two other lines in the op_helper.c.
> 1466: switch (env->hflags & MIPS_HFLAG_KSU) {
> 2242: switch (env->hflags & MIPS_HFLAG_KSU) {
>=20
> Using the function in the cpu.h also can be considered.

Yeh, I avoided changing these as it wasn't clear if they were interested
in just logging the mode from KSU, or specifically the mmu index (i.e.
to answer "what address space am I looking at?"), and it looked more
like the former given the reference to MIPS_HFLAG_{UM,SM,KM}
definitions.

I've now changed them both to effecitvely log the mmu index, changing
the MIPS_HFLAG_{UM,SM,KM} references to literal numbers as used
elsewhere when comparing MMU indicies.

Cheers
James

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlleo7kACgkQbAtpk944
dnpNMhAAvqnpWpdQ+WTGmQVqy8OgPWq4B4CrzW+rrnOX9p1vAPrpPheSmI6PRIFi
TuWX2PNAvRP3d/X51ZyrzEjhTVe5nKY4EZ9ll/7OGfCQMQrCi5lkXtyD6QO2y/VP
5r1BNvCi+OaY/ZuY0jbJ2gQWlSETvYP9q5Jnk5qLWp2ZkwaXDUAdZKDkpATc7jPg
kB+F+iOctwf/Pdd3MOgKpNZ7oCSmwegkVVG8qVq+I4GEuaEVgcY7WqKkI2n+lXL4
Nokg8UTK2OHZrpkQRHgvFzFNwyB5H8zg+grY0M+1kNcpumpwX7VaqjoP3JrIrnbL
3nQD0CbJ3UiyGS2nJgjFj61gj1s8NosGNkADz6r/iID/9NAcF+TQG053TwNbd6Tu
ydjmuRGVxwocZxbNhtE9vXhaDBnGQwiuycCtYrje9p67exWekfJDt0DB63z7+vPr
1ILrKPx9mBf3Q4H60rUMVj7UsP7xBepIIVMoeH+1TbaaWcukGUDnUTlGn4e29/uk
ip+reXKTXvi37HhdXK9y7PQntt+8kx9OchC/IIh8YNAkSryKyKy9GfkOVkzeEm/6
bU2RMF5r37IjizQb8xEsdkOgFebTZrpqUyfvMr5GzVzt+IRp8qpmg3wo+FCY9Wu2
N+hOKorqeCMFaXbh5+ntBHPpDEJ58UjPt+fmTYBlRycRiu/hfAQ=
=E3/B
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
