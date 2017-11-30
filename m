Received: from eggs.gnu.org ([2001:4830:134:3::10]:57619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKG46-0004Dq-Su
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 23:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKG45-0001Ja-PY
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 23:03:10 -0500
Date: Thu, 30 Nov 2017 14:58:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171130035841.GT3023@umbus.fritz.box>
References: <20171129162219.16288-1-mallachiev@ispras.ru>
	<20171129162219.16288-2-mallachiev@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r3KnbM2MoJFBL7Dl"
Content-Disposition: inline
In-Reply-To: <20171129162219.16288-2-mallachiev@ispras.ru>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] target-ppc: Don't invalidate
 non-supported msr bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kurban Mallachiev <mallachiev@ispras.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Laurent Vivier <lvivier@redhat.com>


--r3KnbM2MoJFBL7Dl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 07:22:19PM +0300, Kurban Mallachiev wrote:
> The msr invalidation code (commits 993eb and 2360b) inverts all
> bits except MSR_TGPR and MSR_HVB. On non PowerPC 601 processors
> this leads to incorrect change of excp_prefix in hreg_store_msr()
> function. The problem is that new msr value get multiplied by msr_mask
> and inverted msr does not, thus values of MSR_EP bit in new msr value
> and inverted msr are distinct, so that excp_prefix changes but should
> not.
>=20
> Signed-off-by: Kurban Mallachiev <mallachiev@ispras.ru>

So, the whole logic of ppc_store_msr() / hreg_store_msr() looks much
harier than it should be to me.  Nonetheless, this definitely looks
like an improvement over the current code.

Applied to ppc-for-2.11.

Laurent, could this be related to the loadvm state problems you were
seeing in several BZs?

> ---
>  target/ppc/machine.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 384caee800..96113ee881 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -298,9 +298,9 @@ static int cpu_post_load(void *opaque, int version_id)
>          ppc_store_sdr1(env, env->spr[SPR_SDR1]);
>      }
> =20
> -    /* Invalidate all msr bits except MSR_TGPR/MSR_HVB before restoring =
*/
> +    /* Invalidate all supported msr bits except MSR_TGPR/MSR_HVB before =
restoring */
>      msr =3D env->msr;
> -    env->msr ^=3D ~((1ULL << MSR_TGPR) | MSR_HVB);
> +    env->msr ^=3D env->msr_mask & ~((1ULL << MSR_TGPR) | MSR_HVB);
>      ppc_store_msr(env, msr);
> =20
>      hreg_compute_mem_idx(env);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r3KnbM2MoJFBL7Dl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofgfEACgkQbDjKyiDZ
s5Kq9Q/+Pn0vQ5G5sRX34vgjrP8JNIx7OyrZYfO0SMhKx7PQrewgdC8F2OTDMuVg
dS3z6VhCPlYvSkwY/AChF9oXO3UVTl7aMNyaKwhFuxpsUXp4QSZTEU/rM0ykEEGB
zVKUeKgK0rGK1EzoGOmUKcKd5jK7XgHQU0B1Y7PTwsz6kWgWqN7ZkZMFacaGPuFp
fPyGt22o0siJtYvLEpmVKcOJP4Icn/h5u7lviaUs6Ta3pwDpIdaOGxodpFMqfAs7
lInk6G1FmjfOi1bhUMhMTdivad14LNPYcHvhC7PraFUbrIXwLz63SAqk+3SIzo2j
z636xUhfstq1OsSp/0uPFvnSf/+vAL7MaGdDS32dGhGDSmi3Jp5TmUP8hALoWeBZ
loZV7pRT2Mzid/rQiSUQW1kCjdGsJ0gLtdmpg8sJFj6pGDX+o6UjkGqQXJKwVYUM
RFo4Bmx5TK3x1piPn5ir542Ng/yjkPHlJQ1LCiQzSIezb8fjCyH47tqMTPJJepTX
gJ4oAAszFbBWa44VUK4UgDEaXxMTMW+Mx+AQPlpxT3tT1bE30xfN1NwHBT1p/PMe
dSzmcey3uOdxJ6nzi5XTgVP2LwBni+nXnhuOV3fqWFunGtaZ1hnwt/YBNolWvTLF
m3pXHsNV83mBkfRt3SgRyUCg/vi0pDQTI/8YShgTxooslgcAGVs=
=YggS
-----END PGP SIGNATURE-----

--r3KnbM2MoJFBL7Dl--
