Received: from eggs.gnu.org ([2001:4830:134:3::10]:60727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xo-0005He-L3
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xn-0002U8-Bl
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:04 -0500
Date: Fri, 9 Dec 2016 09:51:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161208225113.GI13139@umbus.fritz.box>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481135102-20011-10-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <1481135102-20011-10-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 9/9] target-ppc: Add xxperm and xxpermr
 instructions
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


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2016 at 11:55:02PM +0530, Nikunj A Dadhania wrote:
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
>=20
> xxperm:  VSX Vector Permute
> xxpermr: VSX Vector Permute Right-indexed
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Merged to ppc-for-2.9.

> ---
>  target-ppc/fpu_helper.c             | 23 +++++++++++++++++++++++
>  target-ppc/helper.h                 |  2 ++
>  target-ppc/translate/vsx-impl.inc.c |  2 ++
>  target-ppc/translate/vsx-ops.inc.c  |  2 ++
>  4 files changed, 29 insertions(+)
>=20
> diff --git a/target-ppc/fpu_helper.c b/target-ppc/fpu_helper.c
> index 3b867cf..1ccd5e6 100644
> --- a/target-ppc/fpu_helper.c
> +++ b/target-ppc/fpu_helper.c
> @@ -2869,3 +2869,26 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t x=
b)
>      float_check_status(env);
>      return xt;
>  }
> +
> +#define VSX_XXPERM(op, indexed)                                       \
> +void helper_##op(CPUPPCState *env, uint32_t opcode)                   \
> +{                                                                     \
> +    ppc_vsr_t xt, xa, pcv, xto;                                       \
> +    int i, idx;                                                       \
> +                                                                      \
> +    getVSR(xA(opcode), &xa, env);                                     \
> +    getVSR(xT(opcode), &xt, env);                                     \
> +    getVSR(xB(opcode), &pcv, env);                                    \
> +                                                                      \
> +    for (i =3D 0; i < 16; i++) {                                        \
> +        idx =3D pcv.VsrB(i) & 0x1F;                                     \
> +        if (indexed) {                                                \
> +            idx =3D 31 - idx;                                           \
> +        }                                                             \
> +        xto.VsrB(i) =3D (idx <=3D 15) ? xa.VsrB(idx) : xt.VsrB(idx - 16)=
; \
> +    }                                                                 \
> +    putVSR(xT(opcode), &xto, env);                                    \
> +}
> +
> +VSX_XXPERM(xxperm, 0)
> +VSX_XXPERM(xxpermr, 1)
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index 9f812c8..399cf99 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -538,6 +538,8 @@ DEF_HELPER_2(xvrspip, void, env, i32)
>  DEF_HELPER_2(xvrspiz, void, env, i32)
>  DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
>  DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
> +DEF_HELPER_2(xxperm, void, env, i32)
> +DEF_HELPER_2(xxpermr, void, env, i32)
> =20
>  DEF_HELPER_2(efscfsi, i32, env, i32)
>  DEF_HELPER_2(efscfui, i32, env, i32)
> diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
> index 8321134..1d88cee 100644
> --- a/target-ppc/translate/vsx-impl.inc.c
> +++ b/target-ppc/translate/vsx-impl.inc.c
> @@ -913,6 +913,8 @@ GEN_VSX_HELPER_2(xvrspic, 0x16, 0x0A, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvrspim, 0x12, 0x0B, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvrspip, 0x12, 0x0A, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvrspiz, 0x12, 0x09, 0, PPC2_VSX)
> +GEN_VSX_HELPER_2(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
> +GEN_VSX_HELPER_2(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
> =20
>  static void gen_xxbrd(DisasContext *ctx)
>  {
> diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
> index 42e83d2..93fb9b8 100644
> --- a/target-ppc/translate/vsx-ops.inc.c
> +++ b/target-ppc/translate/vsx-ops.inc.c
> @@ -275,6 +275,8 @@ VSX_LOGICAL(xxlnand, 0x8, 0x16, PPC2_VSX207),
>  VSX_LOGICAL(xxlorc, 0x8, 0x15, PPC2_VSX207),
>  GEN_XX3FORM(xxmrghw, 0x08, 0x02, PPC2_VSX),
>  GEN_XX3FORM(xxmrglw, 0x08, 0x06, PPC2_VSX),
> +GEN_XX3FORM(xxperm, 0x08, 0x03, PPC2_ISA300),
> +GEN_XX3FORM(xxpermr, 0x08, 0x07, PPC2_ISA300),
>  GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
>  GEN_XX1FORM(xxspltib, 0x08, 0x0B, PPC2_ISA300),
>  GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSePhAAoJEGw4ysog2bOSKwQP/RMgwQwFH6OvHPHKgf8TTkCw
cr94V888G79ImkeMDdMPKc/2Q0UUlQl5Qnh0UIRB/jByMVG5smf003INvTX71+uu
k0L3tdEpFj0c6ggKG1og8AgJVrax3m02Uq0iT8AQDnfnyxmWrHa45zRi/DvDfEru
fisnpiYTO9eyL6UHn6lVifsPf5sKh48SiNWNzOOjKWNrG8t7XDZ3AUQYhD0qTVPp
kAaqNqSPshBQqTjRwDdqdythmk6OroCCRhCGO56ffJu1xXz4j28h4iYJEd5IrFlf
NlV4cG+Syb62EbKI0wQKxEy3AyeJ2jSNf3bVYjFraPTffcqA8TJaHLH29yCPc1Ih
f8IasSfK1BZS92sPZC7yr44RN0VHjVoTJ4T5ZrsOpoxTqUgOMNhrDbpDHQyk/Q1A
9LmuwvLoNRQvqKdKa532bLZJVWZp+I2IzHsE9caCtxSyt+NqbEiO1v7hopM5WHQK
T65S0HB2baE7H6Ji2+BACcJiFGKvzLnVfkTHP8bGeaQf5qARiGvXi4QFGtUeAsMS
tvVFxbqnlRObRYpzSUShakCuUlO8lJlahuFUSWLw1T/uqexifMK6pvxkKgeL15XS
D2NrO6fPggof8rz9cFit6hOx24zCP8uORPgligOtKKy2JmQbQgfKKAY064DUqGJL
ttl0OBHCqssVW32oVDX8
=f67t
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
