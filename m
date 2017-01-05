Received: from eggs.gnu.org ([2001:4830:134:3::10]:34288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPGVM-0007oR-BG
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPGVJ-0000ai-8X
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:27:28 -0500
Date: Fri, 6 Jan 2017 09:01:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170105220117.GE13763@umbus.fritz.box>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1483615579-17618-4-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline
In-Reply-To: <1483615579-17618-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 03/14] target-ppc: Use float64 arg in
 helper_compute_fprf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 04:56:08PM +0530, Nikunj A Dadhania wrote:
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
>=20
> Use float64 argument instead of unit64_t in helper_compute_fprf()
> This allows code in helper_compute_fprf() to be reused later to
> work with float128 argument too.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Uh.. how can this possibly be correct, without updating the callers of
helper_compute_fprf()?

> ---
>  target-ppc/fpu_helper.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/target-ppc/fpu_helper.c b/target-ppc/fpu_helper.c
> index 1ccd5e6..4da991a 100644
> --- a/target-ppc/fpu_helper.c
> +++ b/target-ppc/fpu_helper.c
> @@ -66,23 +66,21 @@ static inline int ppc_float64_get_unbiased_exp(float6=
4 f)
>      return ((f >> 52) & 0x7FF) - 1023;
>  }
> =20
> -void helper_compute_fprf(CPUPPCState *env, uint64_t arg)
> +void helper_compute_fprf(CPUPPCState *env, float64 arg)
>  {
> -    CPU_DoubleU farg;
>      int isneg;
>      int fprf;
> =20
> -    farg.ll =3D arg;
> -    isneg =3D float64_is_neg(farg.d);
> -    if (unlikely(float64_is_any_nan(farg.d))) {
> -        if (float64_is_signaling_nan(farg.d, &env->fp_status)) {
> +    isneg =3D float64_is_neg(arg);
> +    if (unlikely(float64_is_any_nan(arg))) {
> +        if (float64_is_signaling_nan(arg, &env->fp_status)) {
>              /* Signaling NaN: flags are undefined */
>              fprf =3D 0x00;
>          } else {
>              /* Quiet NaN */
>              fprf =3D 0x11;
>          }
> -    } else if (unlikely(float64_is_infinity(farg.d))) {
> +    } else if (unlikely(float64_is_infinity(arg))) {
>          /* +/- infinity */
>          if (isneg) {
>              fprf =3D 0x09;
> @@ -90,7 +88,7 @@ void helper_compute_fprf(CPUPPCState *env, uint64_t arg)
>              fprf =3D 0x05;
>          }
>      } else {
> -        if (float64_is_zero(farg.d)) {
> +        if (float64_is_zero(arg)) {
>              /* +/- zero */
>              if (isneg) {
>                  fprf =3D 0x12;
> @@ -98,7 +96,7 @@ void helper_compute_fprf(CPUPPCState *env, uint64_t arg)
>                  fprf =3D 0x02;
>              }
>          } else {
> -            if (isden(farg.d)) {
> +            if (isden(arg)) {
>                  /* Denormalized numbers */
>                  fprf =3D 0x10;
>              } else {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbsItAAoJEGw4ysog2bOSAmQP/2PhR2n7tCMIjgREt95HMddr
sTEtMPYO+VgpBWPBB7D9b5dbCciSu7DsLq1GwHm/FKnksN1t2OEq8mhq53xkpvzQ
bL3PV1EVUktmHojHh+xTOQ10kAVGqx0MoyVyN6liM3ieTIs2y2BJw6j2WW1/VF0Y
LDBThphIf69ICt9hCk3fMsmeMXF59PoaerXDvR8hP3urmL6DVk427WhCkv3A2+8G
a8itpfQWSyuEqKpVA+C9p3sPXBKf6vxZ8n9zuZFs6i4l2jgIje1xUFfc4djbnpuV
6kD6SLiLsF3zP/e6Hg+117Q3RPgt2hMO1tBu+uRVpTeepPvSkVxBvAHJtpi216vB
iUmYuWBqBKu4p0JvY/nsj/4fyhueSq8MbJnqfI3IZZmINUTQBmyWz7+KPU2OasqP
Jo4C2nHymuPP200EWyUlsupvzhzp/ME9XdIuwucJSJ1RkVc9BbHZpexyYh0Xu4JR
e2nk/uFD3s8u7uNQitUGPyJZ5iwptrt1S8PwBWQevSgzEFyC+8M1mmmfp77fvNps
bNStvnJkj3QdQS9imZirigdGDLDKhG0DxZiJceSwXDfaq2JdYhHYkJM9ogolGFW6
L3HO3fQlCsYSrd4odzygwSxjW/HpPSFJxJrRNmz6eRBIamtTTYQJThriPsFMdJ/Z
5obnyJP6DgbJKIYaRWY6
=EALb
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
