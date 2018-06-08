Received: from eggs.gnu.org ([2001:4830:134:3::10]:40111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR83R-0002c4-RT
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR83Q-0006vi-PE
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:27:09 -0400
Date: Fri, 8 Jun 2018 13:06:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608030619.GG3344@umbus.fritz.box>
References: <20180606073353.18465-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline
In-Reply-To: <20180606073353.18465-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: extend eieio for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Ellerman <mpe@ellerman.id.au>


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 09:33:53AM +0200, C=E9dric Le Goater wrote:
> POWER9 introduced a new variant of the eieio instruction using bit 6
> as a hint to tell the CPU it is a store-forwarding barrier.
>=20
> The usage of this eieio extension was recently added in Linux 4.17
> which activated the "support for a store forwarding barrier at kernel
> entry/exit".
>=20
> Unfortunately, it is not possible to insert this new eieio instruction
> without considerable change in ppc_tr_translate_insn(). So instead we
> loosen the QEMU eieio instruction mask and modify the gen_eieio()
> helper to test for bit6. On non-POWER9 CPUs, the bit6 is just ignored
> but a warning is emitted as this is not an instruction software should
> be using.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.0.

> ---
>=20
>  Changes since v1:
>=20
>  - removed specific PPC2_MEM_EIEIO2 flag
>  - ignore bit6 on non-POWER9 CPU
>=20
>  target/ppc/translate.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 8ba8f67dc513..5fe1ba655599 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2967,7 +2967,28 @@ static void gen_stswx(DisasContext *ctx)
>  /* eieio */
>  static void gen_eieio(DisasContext *ctx)
>  {
> -    tcg_gen_mb(TCG_MO_LD_ST | TCG_BAR_SC);
> +    TCGBar bar =3D TCG_MO_LD_ST;
> +
> +    /*
> +     * POWER9 has a eieio instruction variant using bit 6 as a hint to
> +     * tell the CPU it is a store-forwarding barrier.
> +     */
> +    if (ctx->opcode & 0x2000000) {
> +        /*
> +         * ISA says that "Reserved fields in instructions are ignored
> +         * by the processor". So ignore the bit 6 on non-POWER9 CPU but
> +         * as this is not an instruction software should be using,
> +         * complain to the user.
> +         */
> +        if (!(ctx->insns_flags2 & PPC2_ISA300)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "invalid eieio using bit 6 at=
 @"
> +                          TARGET_FMT_lx "\n", ctx->base.pc_next - 4);
> +        } else {
> +            bar =3D TCG_MO_ST_LD;
> +        }
> +    }
> +
> +    tcg_gen_mb(bar | TCG_BAR_SC);
>  }
> =20
>  #if !defined(CONFIG_USER_ONLY)
> @@ -6483,7 +6504,7 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC=
_STRING),
>  GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
> -GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x03FFF801, PPC_MEM_EIEIO),
> +GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
>  GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
>  GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
>  GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ8qoACgkQbDjKyiDZ
s5LX7hAAvBkp/OdMMG7rD817E+vRj4RP13sxn/3CkMzd9VM7lKQSA0Ma42EUt6ms
3XK72xCZrkHTc+0sKgM6h0Pe4iEtHyn3d+9hzWsqCLkBV/d3i5qiAvpzoWrkgpzx
81DbHckwXGLEzgnrT0n6tX2yKoJjejjwf4etNxDARtKmrkOKBJhxJJ74/j0z5fN6
Vio9XgjqRCxRhcmXxTt5bA8vCitriM7C/hnqx0CLtzBupd9yRS+zr/CnwrdTv5f8
ZtZsf1Lu59rkuF+Bp7rtjM379KkkErkYh1r24HYLrG39IERzeyUW/RX1DBrTTzRF
knM0NZSV4f/n+fys7+Gnqm1hlDpD9MOJfop0iXARjchaLnC017h3NlxLo+DzU7Dd
w8ymW6+F1qwaa/HYMBHvNmjkjtoYRo5aRPgtkWwxgLaObrnPZyY3rHUcCuL69Sog
bwaSK7vPMJe6CxLw6aRXe20seLQ2DUg/vpYz/ypQkfPsifvzO51IWVSwsx6y0p9H
XpHeoNiyA8TCztIJw/igf3E9TOxPRgDKQwhfPJAFFaM+/ehOC/yzvTxLOBm7g7GV
umWi5EocEFj503dAw/yRcgntLRoDc6+2F3LRUxOJHTZwdzng1O6TSTKZjZtMk3tI
uka96icsrarIOKqIq0LEVnRkk6knLF3RglbjPmTf67DW4pyqvb8=
=wncC
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
