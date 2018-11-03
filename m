Received: from eggs.gnu.org ([2001:4830:134:3::10]:42023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJ91M-0007C1-Dk
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJ91I-0002kA-8p
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:16 -0400
Received: from ozlabs.org ([203.11.71.1]:49299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gJ91H-0002bU-7f
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:11 -0400
Date: Sat, 3 Nov 2018 12:57:13 +0000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181103125713.GB24365@umbus.hotspot.internet-for-guests.com>
References: <20181101173852.27257-1-laurent@vivier.eu>
	<CAFEAcA9+gSUHW++EKtuqWL4ofWAKqO0H5JUGUoyyAhY7h24o0Q@mail.gmail.com>
	<dcc24ea9-676f-8276-fe54-49bf67f20e56@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <dcc24ea9-676f-8276-fe54-49bf67f20e56@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH] softfloat: don't execute ppc64 ISA 3.0B
 instruction if it is not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2018 at 06:54:59PM +0100, Laurent Vivier wrote:
> On 01/11/2018 18:49, Peter Maydell wrote:
> > On 1 November 2018 at 17:38, Laurent Vivier <laurent@vivier.eu> wrote:
> >> commit 27ae5109a2 has introduced an assembly instruction only supported
> >> by ISA 3.0B and it fails to execute on previous versions of the POWER
> >> CPU (like PowerPC G5).
> >>
> >> This patch fixes that by checking the ISA level, and falls back to
> >> the default C function if the instruction is not supported.
> >>
> >> Fixes: 27ae5109a2ba8b6b679cce3e03e16570a34390a0
> >>        (softfloat: Specialize udiv_qrnnd for ppc64)
> >> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >> ---
> >>  include/fpu/softfloat-macros.h | 39 ++++++++++++++++++++--------------
> >>  1 file changed, 23 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-ma=
cros.h
> >> index c86687fa5e..fe98b33df9 100644
> >> --- a/include/fpu/softfloat-macros.h
> >> +++ b/include/fpu/softfloat-macros.h
> >> @@ -78,6 +78,9 @@ this code that are retained.
> >>  /* Portions of this work are licensed under the terms of the GNU GPL,
> >>   * version 2 or later. See the COPYING file in the top-level director=
y.
> >>   */
> >> +#if defined(_ARCH_PPC64)
> >> +extern bool have_isa_3_00;
> >> +#endif
> >=20
> > I was wondering where this bool came from. The answer is
> > that it's defined in tcg/ppc/tcg-target.inc.c. It's ok to
> > use it here because fpu/softfloat.c is only compiled if
> > CONFIG_TCG is true, so the tcg code will be present. The
> > other user of this include file is target/m68k/softfloat.c,
> > which also will only be compiled for a ppc host if CONFIG_TCG.
> >=20
> > It's a little awkward to be borrowing this tcg/ppc internal
> > flag into the softfloat code, though.
>=20
> I agree, I was hopping Richard can advice another way to do that.

We already have ISA version flags in insns_flags & insns_flags2, so
I'm hoping we can use those rather than introduce a new bool.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvdmycACgkQbDjKyiDZ
s5K+/BAAvCgoxBSupd4axmc0Cx7cg0HPEK95yUaP8vGzD5erTJAcHD4hwx+jcBqj
hePan42kwFkEXb27Y/WO0LuEXkpRNHMhD91KGzzx3a6MtnHII0GCPqoCZ0So9MGM
Q9gucFwM7ZlXuAv4i4LACwMNhvi8thJkaw8LVSQOUSvZP70fyNBS6gHnmbL1OwYF
BADUrLwM3wMg9LwYPhQnXjyqRbr+T5WFo1QtrXMrLY7iHbOljsG3JkXobY12L+kf
xjEiww6FBkDnQ9zH7GxYFJTNJZXwkHM83ohsm5OuevEVPpelsoRmzrLeSuucI8pW
7ZbXBktAFMqWHpsr3IjDRYj3FTqhl4c4cq/N3WtWUy0aGxWbUjlLWr176nLazJs7
WbJWoSpzJqy0JFKvxQStPDU384Y8bDSYsGzAED3xQa7qo1j61RjcyJsTIRp+7lf1
yAMa5fen7ZV0DtGWFEo9s1lBFoc/6G9MIjvxM3dsYF9f24aRNKWKWw/MUhiCA3zO
0q2U5rKFBVMr0bl0EbERinrBBW8LmL/nAbqTqDUdw96MIs6rFY5dWfO2Lr0sV+7f
kMdECnuX0+/QxuPX2j0yqsTID3753aSOaxEohZf7XmNbxV7LigBhCQ804YZcxCKB
79CTwlSciZdl6D5Gx9tOUUJRrUYjbH1T5z8CDjJwvHaYmMn2uJU=
=1mYg
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
