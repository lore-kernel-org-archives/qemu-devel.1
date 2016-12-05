Received: from eggs.gnu.org ([2001:4830:134:3::10]:39224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cE3GJ-00041x-RS
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 19:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cE3GG-0001BO-HB
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 19:05:35 -0500
Date: Tue, 6 Dec 2016 10:01:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161205230125.GN32366@umbus.fritz.box>
References: <1480741206-32737-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1480741206-32737-6-git-send-email-joserz@linux.vnet.ibm.com>
	<20161205031926.GA32366@umbus.fritz.box>
	<20161205185257.GD16556@pacoca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1HuzLmPZrG5RH6bG"
Content-Disposition: inline
In-Reply-To: <20161205185257.GD16556@pacoca>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 5/7] target-ppc: Implement
 bcdsr. instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: joserz@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--1HuzLmPZrG5RH6bG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 04:52:57PM -0200, joserz@linux.vnet.ibm.com wrote:
> On Mon, Dec 05, 2016 at 02:19:26PM +1100, David Gibson wrote:
> > On Sat, Dec 03, 2016 at 03:00:04AM -0200, Jose Ricardo Ziviani wrote:
> > > bcdsr.: Decimal shift and round. This instruction works like bcds.
> > > however, when performing right shift, 1 will be added to the
> > > result if the last digit was >=3D 5.
> > >=20
> > > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > > ---
> > >  target-ppc/helper.h                 |  1 +
> > >  target-ppc/int_helper.c             | 45 +++++++++++++++++++++++++++=
++++++++++
> > >  target-ppc/translate/vmx-impl.inc.c |  1 +
> > >  target-ppc/translate/vmx-ops.inc.c  |  2 ++
> > >  4 files changed, 49 insertions(+)
> > >=20
> > > diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> > > index 386ea67..d9528eb 100644
> > > --- a/target-ppc/helper.h
> > > +++ b/target-ppc/helper.h
> > > @@ -394,6 +394,7 @@ DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
> > >  DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
> > >  DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
> > >  DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
> > > +DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
> > > =20
> > >  DEF_HELPER_2(xsadddp, void, env, i32)
> > >  DEF_HELPER_2(xssubdp, void, env, i32)
> > > diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> > > index 4b5eea1..c9fcb1a 100644
> > > --- a/target-ppc/int_helper.c
> > > +++ b/target-ppc/int_helper.c
> > > @@ -3124,6 +3124,51 @@ uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t =
*a, ppc_avr_t *b, uint32_t ps)
> > >      return cr;
> > >  }
> > > =20
> > > +uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint=
32_t ps)
> > > +{
> > > +    int cr;
> > > +    int i;
> > > +    int unused =3D 0;
> > > +    int invalid =3D 0;
> > > +    bool ox_flag =3D false;
> > > +    int sgnb =3D bcd_get_sgn(b);
> > > +    ppc_avr_t ret =3D *b;
> > > +    ret.u64[LO_IDX] &=3D ~0xf;
> > > +
> > > +#if defined(HOST_WORDS_BIGENDIAN)
> > > +    ppc_avr_t bcd_one =3D { .u64 =3D { 0, 0x10 } };
> > > +    int upper =3D ARRAY_SIZE(a->s32) - 1;
> >=20
> > Same comment as previous patches about the shift argument.
> >=20
> > > +#else
> > > +    ppc_avr_t bcd_one =3D { .u64 =3D { 0x10, 0 } };
> > > +    int upper =3D 0;
> > > +#endif
> > > +
> > > +    if (bcd_is_valid(b) =3D=3D false) {
> > > +        return CRF_SO;
> > > +    }
> > > +
> > > +    if (a->s32[upper] > 0) {
> > > +        i =3D (a->s32[upper] > 31) ? 31 : a->s32[upper];
> > > +        ulshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], i * 4, &ox_flag);
> > > +    } else {
> > > +        i =3D (a->s32[upper] < -31) ? 31 : -a->s32[upper];
> > > +        urshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], i * 4);
> > > +
> > > +        if (bcd_get_digit(&ret, 0, &invalid) >=3D 5) {
> >=20
> > So, the ISA actually says you increment only if the last digit is >
> > 5.  That doesn't seem like correct rounding, so it might be an error
> > in the ISA document - best check this with the hardware people.
> >=20
>=20
> Just checked with hw team here and they will have this updated to
> "greater than or equal to 5" in the next version (v3.0B).
>=20
> I was told this operation is used more as arithmetic (divide by power of
> 10) than logical.

Right, that makes sense, but we needed to check.  After all if it was
the actual hardware that got this wrong (not just the documentation),
then qemu would need to match that, regardless of how useless the
instruction would be as a result.

>=20
> > > +            bcd_add_mag(&ret, &ret, &bcd_one, &invalid, &unused);
> > > +        }
> > > +    }
> > > +    bcd_put_digit(&ret, bcd_preferred_sgn(sgnb, ps), 0);
> > > +
> > > +    cr =3D bcd_cmp_zero(&ret);
> > > +    if (unlikely(ox_flag)) {
> > > +        cr |=3D CRF_SO;
> > > +    }
> > > +    *r =3D ret;
> > > +
> > > +    return cr;
> > > +}
> > > +
> > >  void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
> > >  {
> > >      int i;
> > > diff --git a/target-ppc/translate/vmx-impl.inc.c b/target-ppc/transla=
te/vmx-impl.inc.c
> > > index fc54881..451abb5 100644
> > > --- a/target-ppc/translate/vmx-impl.inc.c
> > > +++ b/target-ppc/translate/vmx-impl.inc.c
> > > @@ -1018,6 +1018,7 @@ GEN_BCD2(bcdsetsgn)
> > >  GEN_BCD(bcdcpsgn);
> > >  GEN_BCD(bcds);
> > >  GEN_BCD(bcdus);
> > > +GEN_BCD(bcdsr);
> > > =20
> > >  static void gen_xpnd04_1(DisasContext *ctx)
> > >  {
> > > diff --git a/target-ppc/translate/vmx-ops.inc.c b/target-ppc/translat=
e/vmx-ops.inc.c
> > > index cdd3abe..fa9c996 100644
> > > --- a/target-ppc/translate/vmx-ops.inc.c
> > > +++ b/target-ppc/translate/vmx-ops.inc.c
> > > @@ -132,6 +132,8 @@ GEN_HANDLER_E_2(vprtybd, 0x4, 0x1, 0x18, 9, 0, PP=
C_NONE, PPC2_ISA300),
> > >  GEN_HANDLER_E_2(vprtybq, 0x4, 0x1, 0x18, 10, 0, PPC_NONE, PPC2_ISA30=
0),
> > > =20
> > >  GEN_VXFORM_DUAL(vsubcuw, xpnd04_1, 0, 22, PPC_ALTIVEC, PPC_NONE),
> > > +GEN_VXFORM_300(bcdsr, 0, 23),
> > > +GEN_VXFORM_300(bcdsr, 0, 31),
> > >  GEN_VXFORM_DUAL(vaddubs, vmul10uq, 0, 8, PPC_ALTIVEC, PPC_NONE),
> > >  GEN_VXFORM_DUAL(vadduhs, vmul10euq, 0, 9, PPC_ALTIVEC, PPC_NONE),
> > >  GEN_VXFORM(vadduws, 0, 10),
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1HuzLmPZrG5RH6bG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYRfHFAAoJEGw4ysog2bOSCX8P/3Bt30iyGfU0Ye5NOn872YPY
6fceTP9e8T6KqZFtxh3HBEvsgbKZJGXh9gAHa7B9fbhdCq8+9z4vEVITG9M864sK
pWnd50VYegqQNCKP+X3TFgeBmvRgbGerV+T59gU+s5/OVbgX/Bs8mqFtqLVz0Hax
HzLL6BtOjl93Dd0icrGXvvXv7v6USfaWeLUNI3Q1vu+vs+Oh8UXNLtu/uh4RkoYY
4DF22obDvLBmiFNMKgS26lgzoMRox/3bhmrgHJOghQblqh/mmtfrEh62xrCjQVMP
SeiZl0zPxUVFy/pUQrN5d75jb/q63WD3pSA5wIR5lMYaJ4nivq/9A+UyAsWd6ofA
nxC7fAAblN+q9MlOjJTiBxKWM2lbxdSJtG6o25UeeLXlD8snibdzYHn9VeuDqbPJ
iSi67/Oo3s/v2lZ5CDL46Fd7IkQXvYlVUfJmLgJ6Dwg6m69hlWR7lajgo9FZfMBK
Na7aSx+GYIOZxfaXwE8XWLukyaS1Oyp5jWYFrQ86fuBsfprfqoDKEbUF6j8VFgN3
l1D60Kjkwagba50RPiVlnrUxoT9tAwGcCK5y1YYSps3c46ZdhISDznJbHdApzZ2u
7Nm/EJJvFGQ8SOejAIrJqf0gkmkl1WIPmeKiaeJCXXhvDrJi+RAXmUnQJiU3qfXH
F3z/AIi46tY8dI7NCCIB
=45zV
-----END PGP SIGNATURE-----

--1HuzLmPZrG5RH6bG--
