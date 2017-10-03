Received: from eggs.gnu.org ([2001:4830:134:3::10]:44263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzEu2-0001x1-VH
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 00:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzEu1-00035X-Ot
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 00:33:54 -0400
Date: Tue, 3 Oct 2017 15:27:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171003042716.GB3260@umbus.fritz.box>
References: <20170930113610.28608-1-sandipan@linux.vnet.ibm.com>
	<db510034-c358-eda5-63df-19ff1341792d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <db510034-c358-eda5-63df-19ff1341792d@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix carry flag setting for
 shift algebraic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2017 at 08:19:10AM -0400, Richard Henderson wrote:
> On 09/30/2017 07:36 AM, Sandipan Das wrote:
> > For POWER ISA v3.0, the XER bit CA32 needs to be set by the shift
> > right algebraic instructions whenever the CA bit is to be set. This
> > change affects the following instructions:
> >   * Shift Right Algebraic Word (sraw[.])
> >   * Shift Right Algebraic Word Immediate (srawi[.])
> >   * Shift Right Algebraic Doubleword (srad[.])
> >   * Shift Right Algebraic Doubleword Immediate (sradi[.])
> >=20
> > Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> > ---
> >  target/ppc/helper.h     |  4 ++--
> >  target/ppc/int_helper.c | 10 ++++++++--
> >  target/ppc/translate.c  | 16 ++++++++++++++--
> >  3 files changed, 24 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> > index bb6a94a8b3..069d65ad7b 100644
> > --- a/target/ppc/helper.h
> > +++ b/target/ppc/helper.h
> > @@ -40,12 +40,12 @@ DEF_HELPER_4(divwe, tl, env, tl, tl, i32)
> > =20
> >  DEF_HELPER_FLAGS_1(popcntb, TCG_CALL_NO_RWG_SE, tl, tl)
> >  DEF_HELPER_FLAGS_2(cmpb, TCG_CALL_NO_RWG_SE, tl, tl, tl)
> > -DEF_HELPER_3(sraw, tl, env, tl, tl)
> > +DEF_HELPER_4(sraw, tl, env, tl, tl, tl)
> >  #if defined(TARGET_PPC64)
> >  DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, i32, tl, tl)
> >  DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
> >  DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> > -DEF_HELPER_3(srad, tl, env, tl, tl)
> > +DEF_HELPER_4(srad, tl, env, tl, tl, tl)
> >  DEF_HELPER_0(darn32, tl)
> >  DEF_HELPER_0(darn64, tl)
> >  #endif
> > diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> > index da4e1a62c9..4f270eb49d 100644
> > --- a/target/ppc/int_helper.c
> > +++ b/target/ppc/int_helper.c
> > @@ -210,7 +210,7 @@ target_ulong helper_cmpb(target_ulong rs, target_ul=
ong rb)
> > =20
> >  /* shift right arithmetic helper */
> >  target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
> > -                         target_ulong shift)
> > +                         target_ulong shift, target_ulong is_isa300)
> >  {
> >      int32_t ret;
> > =20
> > @@ -231,12 +231,15 @@ target_ulong helper_sraw(CPUPPCState *env, target=
_ulong value,
> >          ret =3D (int32_t)value >> 31;
> >          env->ca =3D (ret !=3D 0);
> >      }
> > +    if (is_isa300) {
> > +        env->ca32 =3D env->ca;
> > +    }
>=20
> You do not need to pass a new parameter, because ca32 does not exist prio=
r to
> ISA 3.00, and thus any code running ISA 2.x does not care about its value.
>=20
> You only need set ca32 when ca is set.  Move those assignments
> adjacent.

Ah, good point.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnTEaIACgkQbDjKyiDZ
s5Ir1Q//fm3A6euJ/TIzAjD/aCrzHd2v8/XJzfUdNJ79Ja6gOWrq6dz9H9LEg/zL
e74tOwZf3paen/eQoI3hnlGhXiIQlGJ4H6Dgc0hgOM0EmfJjd4rzIlMpb7g9AsCP
2tNz5xCiWoZ/cFpPvXNk7mmIcl77U3tGodo0Nyd7zeyd/iWvb9kEhlKMmn4bpmhn
ye8IWJ04WNX3lpqjWYlYNbsa3Wp9ZQoCB372YZDFYNCcG6v2MtfICbU7wexKfGyG
rHXrnhS8RldPzGOX9hioE3/xiH3G419aUOsKWSnS5K5+CpzmWpzONOjaxJKYFLXY
1w2jsqpOWPNAHS5rQYXHGq9XGF7LL0f9ivDz1o+xGzbhFfnei/g6sr2fdzkxM/sh
EYPVh0TvCiGUHL0DrwDc4vc7WSDdRtR9eMooqWAshqJ/2j6SPoQPTlRsFWA54s+X
DPk1ccog83gksVJMU369n2SLrkUXGfkCp2wOT99bO1EoOorYTSGIYJX+oYm1cY/Y
yj7Qr4vqZa3aq5lXYdqc891NiPmSGlmX+UbPNN4QamJL/hrOn4TrJtjYEWO8btwX
pujFHYDROkUGB0DBTKZUjsjj2IBx/Gs2T2v9BRlsSwB29zfLv1BwyS+UJ77/IX/q
ONn2pYDEW3TZ0jQrENXl4TdaBEYIW2KzW2Gk383oA4VT4wYGCug=
=a3am
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
