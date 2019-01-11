Received: from eggs.gnu.org ([209.51.188.92]:36707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghlQy-0003x4-Jj
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghlQw-0003Oh-TN
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:16:28 -0500
Date: Fri, 11 Jan 2019 11:50:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190111005001.GR6682@umbus.fritz.box>
References: <20190104195654.19976-1-farosas@linux.ibm.com>
	<20190104195654.19976-3-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e7jIye1Ygp5H0AIi"
Content-Disposition: inline
In-Reply-To: <20190104195654.19976-3-farosas@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] target/ppc: Add GDB callbacks for SPRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--e7jIye1Ygp5H0AIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 05:56:53PM -0200, Fabiano Rosas wrote:
> These will be used to let GDB know about PPC's Special Purpose
> Registers (SPR).
>=20
> They take an index based on the order the registers appear in the XML
> file sent by QEMU to GDB. This index does not match the actual
> location of the registers in the env->spr array so the
> gdb_find_spr_idx function does that conversion.
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  target/ppc/translate_init.inc.c | 50 +++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 03f1d34a97..f10a3637d9 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -9483,6 +9483,56 @@ static bool avr_need_swap(CPUPPCState *env)
>  #endif
>  }
> =20
> +#if !defined(CONFIG_USER_ONLY)
> +static int gdb_find_spr_idx(CPUPPCState *env, int n)
> +{
> +    int idx =3D -1;
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
> +        ppc_spr_t *spr =3D &env->spr_cb[i];
> +
> +        if (spr->name && ++idx =3D=3D n) {
> +            break;
> +        }
> +    }
> +    return i;
> +}

This is very subtle - it relies on the fact that you also generate the
XML in sequence, which makes for a very non-obvious dependency between
different parts of the code.  At the very least this needs a big fat
comment explaining how the gdb ids are allocated.

I think better would be to explicitly put a gdb_id into the spr_cb
structure - that would be filled in at the same time you generate the
XML, then referenced here.

> +static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> +{
> +    int reg;
> +    int len;
> +
> +    reg =3D gdb_find_spr_idx(env, n);
> +    if (!reg) {
> +        return 0;
> +    }
> +
> +    len =3D TARGET_LONG_SIZE;
> +    stn_p(mem_buf, len, env->spr[reg]);
> +    ppc_maybe_bswap_register(env, mem_buf, len);
> +    return len;
> +}
> +
> +static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> +{
> +    int reg;
> +    int len;
> +
> +    reg =3D gdb_find_spr_idx(env, n);
> +    if (!reg) {
> +        return 0;
> +    }
> +
> +    len =3D TARGET_LONG_SIZE;
> +    ppc_maybe_bswap_register(env, mem_buf, len);
> +    env->spr[reg] =3D ldn_p(mem_buf, len);
> +
> +    return len;
> +}
> +#endif
> +
>  static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--e7jIye1Ygp5H0AIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw36DkACgkQbDjKyiDZ
s5LJlA/8Do3V++cuMLARywhoGMowat9nnjoQ3nF1bFuvyO6eOIB8WiD5YjNqwUDe
JFl1qBym6Dd+bWr4hRWPBMIkVphm4g3STYhGf9iy5tFUfh6epxg+DABBWjnTglVU
etPWMAlrKWs/eoz8D4SsrgFMbBf4cdI2gVMiyk2uAga1KLr3npZDDnICtYlUAVkn
FT0Um6IbQCwCHltw3sIFGbqr/mZl+5Tdsjxq81hbGOxFK0L5Sj522aaM9iWHscEp
EoiTzXs9fEiJacycRHEi6UH/RtcfmUBwWimA/5g31JpGhQcyLL2eD99s0b2DhvrA
ZovgDzWqK+psBYA+NKRAJEUMh5VSfxPWrlIitBaG3oO+V7eCL2JiELc3kWZ0Ic3V
vGc/lARnbt5a7y3Q/c8cpG0CJitY8eeEkxlYLyijxS+0JrNPBdlvgQMr5OnprZ4g
QMTCnlIGOB9QYaSPOoirAsdC4eH0NFT4+mHIGf2kWXZXcOt0k/WyjvWveNCLpk5/
y/DhXacIWz0c9MEIf8wPt7mky6Lg1sU7Dg5yvMhm9sNOzlWoaE6RG+w2iYGgOs77
EC1apy0BKLeroa3FCad+t54JKb6GZ20eipZ9xvUcYCxWmuua2CmFtlkZKzTvlXjJ
1GK3Et2bLFRlcJ1GkPvFhXt2tXOoQBpy4dblaaQgnbtpz5twPXE=
=0ejD
-----END PGP SIGNATURE-----

--e7jIye1Ygp5H0AIi--
