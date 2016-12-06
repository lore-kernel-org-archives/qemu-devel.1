Received: from eggs.gnu.org ([2001:4830:134:3::10]:55956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cE77U-0007q8-Kv
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 23:12:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cE77R-0004Lh-HQ
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 23:12:44 -0500
Date: Tue, 6 Dec 2016 15:11:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161206041122.GP32366@umbus.fritz.box>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-14-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8G1nIWD3RY794FAy"
Content-Disposition: inline
In-Reply-To: <1480937130-24561-14-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 13/13] target-ppc: Add xxperm and xxpermr
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


--8G1nIWD3RY794FAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 04:55:30PM +0530, Nikunj A Dadhania wrote:
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
>=20
> xxperm:  VSX Vector Permute
> xxpermr: VSX Vector Permute Right-indexed
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target-ppc/fpu_helper.c             | 50 +++++++++++++++++++++++++++++++=
++++++
>  target-ppc/helper.h                 |  2 ++
>  target-ppc/translate/vsx-impl.inc.c |  2 ++
>  target-ppc/translate/vsx-ops.inc.c  |  2 ++
>  4 files changed, 56 insertions(+)
>=20
> diff --git a/target-ppc/fpu_helper.c b/target-ppc/fpu_helper.c
> index 3b867cf..be552c7 100644
> --- a/target-ppc/fpu_helper.c
> +++ b/target-ppc/fpu_helper.c
> @@ -2869,3 +2869,53 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t x=
b)
>      float_check_status(env);
>      return xt;
>  }
> +
> +static void vsr_copy_256(ppc_vsr_t *xa, ppc_vsr_t *xt, int8_t *src)
> +{
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    memcpy(src, xa, sizeof(*xa));
> +    memcpy(src + 16, xt, sizeof(*xt));
> +#else
> +    memcpy(src, xt, sizeof(*xt));
> +    memcpy(src + 16, xa, sizeof(*xa));

Is this right?  I thought the order of the bytes within each word
varied with the host endianness as well.

> +#endif
> +}
> +
> +static int8_t vsr_get_byte(int8_t *src, int bound, int idx)
> +{
> +    if (idx >=3D bound) {
> +        return 0xFF;
> +    }

AFAICT you don't need this check.  For both xxperm and xxpermr you're
already masking the index to 5 bits, so it can't exceed 31.

> +#if defined(HOST_WORDS_BIGENDIAN)
> +    return src[idx];
> +#else
> +    return src[bound - 1 - idx];
> +#endif
> +}
> +
> +#define VSX_XXPERM(op, indexed)                                    \
> +void helper_##op(CPUPPCState *env, uint32_t opcode)                \
> +{                                                                  \
> +    ppc_vsr_t xt, xa, pcv;                                         \
> +    int i, idx;                                                    \
> +    int8_t src[32];                                                \
> +                                                                   \
> +    getVSR(xA(opcode), &xa, env);                                  \
> +    getVSR(xT(opcode), &xt, env);                                  \
> +    getVSR(xB(opcode), &pcv, env);                                 \
> +                                                                   \
> +    vsr_copy_256(&xa, &xt, src);                                   \

You have a double copy here AFAICT - first from the actual env
structure to xt and xa, then to the src array.  That seems like it
would be good to avoid.

It seems like it would nice in any case to avoid even the one copy.
You'd need a temporary for the output of course and to copy that, but
you should be able to combine indexed with host endianness to
translate each index to retrieve directly from the VSR values in env.

> +    for (i =3D 0; i < 16; i++) {                                     \
> +        idx =3D pcv.VsrB(i) & 0x1F;                                  \
> +        if (indexed) {                                             \
> +            xt.VsrB(i) =3D vsr_get_byte(src, 32, 31 - idx);          \
> +        } else {                                                   \
> +            xt.VsrB(i) =3D vsr_get_byte(src, 32, idx);               \
> +        }                                                          \
> +    }                                                              \
> +    putVSR(xT(opcode), &xt, env);                                  \
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
> index 77f098b..2ad152e 100644
> --- a/target-ppc/translate/vsx-impl.inc.c
> +++ b/target-ppc/translate/vsx-impl.inc.c
> @@ -914,6 +914,8 @@ GEN_VSX_HELPER_2(xvrspic, 0x16, 0x0A, 0, PPC2_VSX)
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

--8G1nIWD3RY794FAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYRjpmAAoJEGw4ysog2bOSrZMQANt8Dtmim7JN5735VzdQMre7
c1ckfqplRzSKo7jiBNn5HXLtnk/JhfqvTepEPIuwvRBBQWINJZ8yGAo6JNo3cW3r
UcKJdoUu4ZGxF4eyLyyNWhfEs4Ix3jWUrI1g9to2Cu7kEnKuh8TwwikcnuEPeMUB
AgcT2qs0VN8FzgdD1H92LzulohsddlAULsYjHQgJ6ll7P12461AJlyuj5wTP3WlN
eQ9sfKiSV6JceFMSiGLVDM2kbXo7AmdQBh2z3336VKC60+PjHv1fuhNaDB8HBsQs
E+5g7z1NvAyciBeiDsC5dPtq3t0G2+f6z3P2EfrtGwwKvIaaD1R0Gw6aHb3zwzbP
VpBf3O4soPyGIjXQYWKiItzdtw0Ft6rGE0JtLagQor0XTmhc7EaOI+1859v2kFMb
NXwt52GBserD06TDFTfFKJ/HeuJmtaWQViprQ9EeX9px4G2xLu+QuKmFzk9ZD0g1
f8zjQZAfJRELnDAQJLKOeyQ74iN+NkfZDSHVRbrYEumEJPbOaw0V0CwxDhQdAZur
Syc1TM+wQs1UUMyXB8jso9PxfHIPBf1KgqfVJNH2ZTDMfgwEMgSc2xYgX9b0Z9Ro
MyeiZSZu4msgmUcG/aXRvtUz4b3i3xYKjj9LZN1DiZSv+IavnOp+o8gJN0+srtIJ
POpkB/Sy0sFejxmmxCZ6
=SMxM
-----END PGP SIGNATURE-----

--8G1nIWD3RY794FAy--
