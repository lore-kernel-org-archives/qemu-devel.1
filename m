Received: from eggs.gnu.org ([2001:4830:134:3::10]:36733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCk-0002MB-P1
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCj-0005GG-Hq
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:38 -0400
Date: Fri, 6 Oct 2017 14:21:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006032116.GO3260@umbus.fritz.box>
References: <20171003062310.9919-1-sandipan@linux.vnet.ibm.com>
	<6c84dd7f-4441-0624-d6a4-bffe837eea49@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6kWzDLe2BYLyVXGp"
Content-Disposition: inline
In-Reply-To: <6c84dd7f-4441-0624-d6a4-bffe837eea49@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3] target/ppc: Fix carry flag setting for
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


--6kWzDLe2BYLyVXGp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 08:42:56AM -0400, Richard Henderson wrote:
> On 10/03/2017 02:23 AM, Sandipan Das wrote:
> > @@ -231,6 +231,10 @@ target_ulong helper_sraw(CPUPPCState *env, target_=
ulong value,
> >          ret =3D (int32_t)value >> 31;
> >          env->ca =3D (ret !=3D 0);
> >      }
> > +
> > +    /* update CA32 for ISA v3.0 */
> > +    env->ca32 =3D env->ca;
>=20
> As I said before, modify ca32 only when ca is modified.
> E.g.
>=20
>   env->ca32 =3D env->ca =3D (ret !=3D 0);
>=20
> > @@ -257,6 +261,10 @@ target_ulong helper_srad(CPUPPCState *env, target_=
ulong value,
> >          ret =3D (int64_t)value >> 63;
> >          env->ca =3D (ret !=3D 0);
> >      }
> > +
> > +    /* update CA32 for ISA v3.0 */
> > +    env->ca32 =3D env->ca;
>=20
> Likewise.
>=20
> > @@ -2192,6 +2192,10 @@ static void gen_srawi(DisasContext *ctx)
> >          tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
> >          tcg_gen_sari_tl(dst, dst, sh);
> >      }
> > +
> > +    /* update CA32 for ISA v3.0 */
> > +    tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>=20
> Likewise.

Also, for the helper functions it definitely makes sense to always set
CA32 when CA is set, regardless of CPU model, it's close enough to
free.  When we're generating code, however, the trade-off is
different, we only need to test the CPU model at translate time, but
we need to execute the generated instrucitons potentially more times.

So I'm wondering if for the gen_* functions we _should_ be checking
for ISA300 before generating the CA32 update instructions.

>=20
> > @@ -2269,6 +2273,10 @@ static inline void gen_sradi(DisasContext *ctx, =
int n)
> >          tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
> >          tcg_gen_sari_tl(dst, src, sh);
> >      }
> > +
> > +    /* update CA32 for ISA v3.0 */
> > +    tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>=20
> Likewise.
>=20
>=20
> r~
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6kWzDLe2BYLyVXGp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW9qwACgkQbDjKyiDZ
s5JlWRAAwbfHjE/0ZN+8BXA5EFNuMcaz186q32aFYGyr2xmlV27WfvrCyNxYLAeP
ldtC3CYn02oxioT+KLterzjLugZi4N4wqH28SgceWHzKZJ5clf8IElWN9MyN9o31
ZxQrDLoyD88IA6ixHYdJWRCQ9em+HkhC/dKUShktYChcdZwuZI/Cj4K1sLx977YE
7QRcmrBh2Iy9UldGsxKY9aTQqiD8WEgMVSvQSzEqmbCKm+bO98eFmnP4OD6vRonU
67XFu28dLEsxMASB9ARmRd+i1rmIZM/1CEzj3nyjq14OltTlVF7w1qOxR0jNjVe2
ndI073RtSu1WG/6e/ve+zokRJlw8xntNfrLO+y7r4dBWK/NjkT/OnGMb5ono0TpF
crkIsFHdfWILPfXRxKbgKM1NMNNQEMQJY3SG8nNtnI+eXpqhKDKCTvbKcwwHVPRF
5f+MjSa3StnrdL8LHTdgOb3j+RDS3Q+OHWzXnO4y23P5V7O66K7/mM6nSL4juPUe
1H8o0g0qRPZwBXvRqhrNddGHzNGtDDt9nD1Ee9N+r0alnVsVroziyiVRSQiVGWgG
Oz9MBtdkeTcx1clgc0YGc96jOHxsSDvqIXEANk8lcCZPePo0vbCPccoJXFDn6wBq
mXqyIfhz7DGY2PwjFfAnZTp1PjIFxxXalyCjgATnmsk12Ni60MU=
=Ef1A
-----END PGP SIGNATURE-----

--6kWzDLe2BYLyVXGp--
