Received: from eggs.gnu.org ([2001:4830:134:3::10]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecJeW-0002lc-1b
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 18:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecJeS-0000G2-Tx
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 18:31:24 -0500
Date: Fri, 19 Jan 2018 10:28:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118232829.GX30352@umbus.fritz.box>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<20180108055348.20444-2-david@gibson.dropbear.id.au>
	<f1f754e4-adbf-0b18-e5f5-55d68e2edd89@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1hAU+gb7eAuiw2fm"
Content-Disposition: inline
In-Reply-To: <f1f754e4-adbf-0b18-e5f5-55d68e2edd89@redhat.com>
Subject: Re: [Qemu-devel] [PULL 01/12] target-ppc: optimize cmp translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, surajjs@au1.ibm.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org


--1hAU+gb7eAuiw2fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 05:36:40PM +0100, Paolo Bonzini wrote:
> On 08/01/2018 06:53, David Gibson wrote:
> > From: "pbonzini@redhat.com" <pbonzini@redhat.com>
> >=20
> > We know that only one bit (in addition to SO) is going to be set in
> > the condition register, so do two movconds instead of three setconds,
> > three shifts and two ORs.
> >=20
> > For ppc64-linux-user, the code size reduction is around 5% and the
> > performance improvement slightly less than 10%.  For softmmu, the
> > improvement is around 5%.
> >=20
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  target/ppc/translate.c | 29 ++++++++++++-----------------
> >  1 file changed, 12 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index 4075fc8589..8a6bd329d0 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -605,27 +605,22 @@ static opc_handler_t invalid_handler =3D {
> >  static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
> >  {
> >      TCGv t0 =3D tcg_temp_new();
> > -    TCGv_i32 t1 =3D tcg_temp_new_i32();
> > -
> > -    tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
> > -
> > -    tcg_gen_setcond_tl((s ? TCG_COND_LT: TCG_COND_LTU), t0, arg0, arg1=
);
> > -    tcg_gen_trunc_tl_i32(t1, t0);
> > -    tcg_gen_shli_i32(t1, t1, CRF_LT_BIT);
> > -    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
> > +    TCGv t1 =3D tcg_temp_new();
> > +    TCGv_i32 t =3D tcg_temp_new_i32();
> > =20
> > -    tcg_gen_setcond_tl((s ? TCG_COND_GT: TCG_COND_GTU), t0, arg0, arg1=
);
> > -    tcg_gen_trunc_tl_i32(t1, t0);
> > -    tcg_gen_shli_i32(t1, t1, CRF_GT_BIT);
> > -    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
> > +    tcg_gen_movi_tl(t0, CRF_EQ);
> > +    tcg_gen_movi_tl(t1, CRF_LT);
> > +    tcg_gen_movcond_tl((s ? TCG_COND_LT : TCG_COND_LTU), t0, arg0, arg=
1, t1, t0);
> > +    tcg_gen_movi_tl(t1, CRF_GT);
> > +    tcg_gen_movcond_tl((s ? TCG_COND_GT : TCG_COND_GTU), t0, arg0, arg=
1, t1, t0);
> > =20
> > -    tcg_gen_setcond_tl(TCG_COND_EQ, t0, arg0, arg1);
> > -    tcg_gen_trunc_tl_i32(t1, t0);
> > -    tcg_gen_shli_i32(t1, t1, CRF_EQ_BIT);
> > -    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
> > +    tcg_gen_trunc_tl_i32(t, t0);
> > +    tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
> > +    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t);
> > =20
> >      tcg_temp_free(t0);
> > -    tcg_temp_free_i32(t1);
> > +    tcg_temp_free(t1);
> > +    tcg_temp_free_i32(t);
> >  }
> > =20
> >  static inline void gen_op_cmpi(TCGv arg0, target_ulong arg1, int s, in=
t crf)
> >=20
>=20
> David, can you queue this again now that the ARM backend has been
> fixed?

Done, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1hAU+gb7eAuiw2fm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphLZ0ACgkQbDjKyiDZ
s5IphxAA5IeNggCHcv0oaLo2RGNJVN+nxfpghDo21DP6605pVSpfaafO0N12bOa+
Se6B/eVZmhoaKcLSCgnFMPI8xzcSMbD3583NxzmhQAHGIUsJ8Stw+MkFvJvSrevO
mGgRAVkonLPEFpjBUDI8A9D/Xa24ZZpdlRhSn0CXf4wKejolkgXEJ8gvzpZAIhxm
NSeT9BI8zZY1MckhKmxkvYnn2dNWuqj2qu2OZWp7T43FVNJaZML11puLp1wqp/ZK
vgfwGXeXHhzS2I/9JMP15A/awIu9/lKq+B5zBE1PzCXrlCs+4ocQYKzEuGMaEwEo
bkBS2KutSeftijvZnjwD2znvPajIKg8tRQOLJtE2I39eStR8DZ54AjowMoQYCRAP
Tt4rW+aQjLzuaxfp8GuAZhOngeDfgMlgF6fRy8TAy24cQZWEy0VvJ/apkkfRAmBl
PT3cYr0YaQ/N01fv7cOTUqXNEhC3m57DLMaTJp38ZoXNRAZlgZf2lh4Pdy59ey2B
GWdM8Pi7mopuSDSkuZjsqmt0ygO9Gylvei0yXKiokH959sj8tylaI0LKlZjg46+J
OZ9iBEis94l3IY14C0JFs4C+RdNUOcnHWUQXsn7434izbcL8RDcTGRikwtmUqTE/
QXaL7NNgd8oII2zSLl4SFhWP5ES2fZtCeI/e/hjyZvcEvjGa0WM=
=eRVU
-----END PGP SIGNATURE-----

--1hAU+gb7eAuiw2fm--
