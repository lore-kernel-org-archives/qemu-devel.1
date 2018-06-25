Received: from eggs.gnu.org ([2001:4830:134:3::10]:46550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXFzx-0007vr-2f
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 21:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXFzv-0000LR-MT
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 21:08:53 -0400
Date: Mon, 25 Jun 2018 10:46:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180625004605.GA22971@umbus.fritz.box>
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 23, 2018 at 04:17:08PM -0400, Programmingkid wrote:
>=20
> > On Jun 23, 2018, at 12:17 PM, Richard Henderson <richard.henderson@lina=
ro.org> wrote:
> >=20
> > On 06/22/2018 07:22 PM, John Arbuckle wrote:
> >> When the fdiv instruction divides a finite number by zero,
> >> the result actually depends on the FPSCR[ZE] bit. If this
> >> bit is set, the return value is zero. If it is not set
> >> the result should be either positive or negative infinity.
> >> The sign of this result would depend on the sign of the
> >> two inputs. What currently happens is only infinity is
> >> returned even if the FPSCR[ZE] bit is set. This patch
> >> fixes this problem by actually checking the FPSCR[ZE] bit
> >> when deciding what the answer should be.
> >>=20
> >> fdiv is suppose to only set the FPSCR's FPRF bits during a
> >> division by zero situation when the FPSCR[ZE] is not set.
> >> What currently happens is these bits are always set. This
> >> patch fixes this problem by checking the FPSCR[ZE] bit to
> >> decide if the FPRF bits should be set.=20
> >>=20
> >> https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming=
-environments-for-32-e3087633.html
> >> This document has the information on the fdiv. Page 133 has the inform=
ation on what action is executed when a division by zero situation takes pl=
ace.=20
> >>=20
> >> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> >> ---
> >> target/ppc/fpu_helper.c            | 16 ++++++++++++++++
> >> target/ppc/translate/fp-impl.inc.c | 28 +++++++++++++++++++++++++++-
> >> 2 files changed, 43 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> >> index 7714bfe0f9..de694604fb 100644
> >> --- a/target/ppc/fpu_helper.c
> >> +++ b/target/ppc/fpu_helper.c
> >> @@ -658,6 +658,20 @@ uint64_t helper_fdiv(CPUPPCState *env, uint64_t a=
rg1, uint64_t arg2)
> >>     } else if (unlikely(float64_is_zero(farg1.d) && float64_is_zero(fa=
rg2.d))) {
> >>         /* Division of zero by zero */
> >>         farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXZDZ,=
 1);
> >> +    } else if (arg2 =3D=3D 0) {
> >> +        /* Division by zero */
> >> +        float_zero_divide_excp(env, GETPC());
> >> +        if (fpscr_ze) { /* if zero divide exception is enabled */
> >> +            farg1.ll =3D 0;
> >> +        } else {
> >> +            uint64_t sign =3D (farg1.ll ^ farg2.ll) >> 63;
> >> +            if (sign) { /* Negative sign bit */
> >> +                farg1.ll =3D 0xfff0000000000000; /* Negative Infinity=
 */
> >> +            } else { /* Positive sign bit */
> >> +                farg1.ll =3D 0x7ff0000000000000; /* Positive Infinity=
 */
> >> +            }
> >> +            helper_compute_fprf_float64(env, farg1.d);
> >=20
> > I don't believe you.
> > (1) This is against IEEE spec,
>=20
> I'm trying to implement IBM PowerPC specs.=20

Which should have an IEEE compliant FPU.

> > (2) There is nothing about this zero result in the Power manual,
>=20
> This is for PowerPC. Power and PowerPC are cousins to each other
> rather than having a child-parent relationship. Yes there are a lot
> of similar instructions between them, this does not mean they are
> compatible with each other.

The're definitely supposed to be compatible, at least for userspace
(PR=3D1) instructions.  The distinction between "POWER" and "PowerPC" is
kind of confusing, but basically every PowerPC or POWER chip from
POWER2 onwards should be backwards compatible for non-privileged
instructions.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlswO0sACgkQbDjKyiDZ
s5KvkBAAtbUx5gHTEQrgaRDXZ0Zxj88eSsDEk70X13Y0Zh8gm3sbNuA6F724lIHu
kjT++JkoqF7SqfX43GAtxUtKQ9N47pokgwSFLToSWzcf7rXa3P/8GlYYXZD5PHu0
fdtxXB16+F1WkanuOEb9JwbkdOHwCUYE4tRmXv30YXp/cJ2k8UwSTYhB4VlULyWP
E6v/6LYHrDqs4umGPWv8YkIhAxB4APufK2o9fpctAPP0ZzeoCaYh4ObpwflNeoXh
baxB72FQq17itVGucHNrXPCnCt75ExnqE/6efL9sovm870wmnVjtyb9Ob8dacWOR
4jLV4sDLlW0+dSDeMTBw0/3n7JlCa0+mBtBjqofv8UGGw3b5HCQqCN0qbCTCJJK7
RvM64LyfpPFctcHt5gx28UPb8Er0p+AjFIkRIPH9S9gaEUTPn1WvwRx4GmCzvwl9
CT8xY0GaQ7VFyEnI9pDQSvj1RxOeaEprqZx4k6Bu9eAgx2r40nvNdAVenztklou5
2K5nUGmYf7FuSixqkEjNajR5Npx0Bq0eCBIG1wpDIrBp6XgM7v8QIn8ryP7l2HXc
CG/j3GbTS0lkMIAd7+RYHP8988+w1AmH8TaNkkjbXWQbu1N4OZTcAA7DWQMhN/LO
nuXZKy855ajG1uwWxXF0Dpg13Baj/DkDiXwhMlbvq/ZQJIef5rU=
=+3N1
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
