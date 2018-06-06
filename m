Received: from eggs.gnu.org ([2001:4830:134:3::10]:34835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQRzX-000893-P1
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQRzU-0007ml-IX
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:32:19 -0400
Date: Wed, 6 Jun 2018 16:32:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180606063206.GI17757@umbus.fritz.box>
References: <20180606060830.25942-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Li7ckgedzMh1NgdW"
Content-Disposition: inline
In-Reply-To: <20180606060830.25942-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: extend eieio for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Li7ckgedzMh1NgdW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 08:08:30AM +0200, C=E9dric Le Goater wrote:
> POWER9 introduced a new variant of the eieio instruction using bit 6
> as a hint to tell the CPU it is a store-forwarding barrier.
>=20
> The usage of this eieio extension was recently added in Linux 4.17
> which activated the "support for a store forwarding barrier at kernel
> entry/exit".
>=20
> Unfortunately, it is not possible to insert this new eieio instruction
> without considerable change in ppc_tr_translate_insn(). So instead we
> loosen the QEMU eieio instruction mask. The gen_eieio() helper is
> modified to test for bit6 and a custom instruction flag to catch
> invalid eieio opcodes on non-POWER9 CPUs.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/cpu.h                |  5 ++++-
>  target/ppc/translate.c          | 19 +++++++++++++++++--
>  target/ppc/translate_init.inc.c |  3 ++-
>  3 files changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 0247c1f04c37..021c9b2f10d1 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2206,6 +2206,9 @@ enum {
>      /* POWER ISA 3.0                                                    =
     */
>      PPC2_ISA300        =3D 0x0000000000080000ULL,
> =20
> +    /* POWER ISA 3.0 eieio variants                                     =
     */
> +    PPC2_MEM_EIEIO2    =3D 0x0000000000100000ULL,
> +
>  #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DB=
RX | \
>                          PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 | \
>                          PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
> @@ -2213,7 +2216,7 @@ enum {
>                          PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
>                          PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
>                          PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
> -                        PPC2_ISA300)
> +                        PPC2_ISA300 | PPC2_MEM_EIEIO2)
>  };
> =20
>  /***********************************************************************=
******/
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 8ba8f67dc513..a73ef02aef1d 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2967,7 +2967,22 @@ static void gen_stswx(DisasContext *ctx)
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
> +        if (!(ctx->insns_flags2 & PPC2_MEM_EIEIO2)) {

Since we have to adapt the gen_eieio code anyway we don't really need
the new instruction flag - we can just reuse PPC2_ISA300 for it.

> +            qemu_log_mask(LOG_GUEST_ERROR, "invalid eieio using bit 6 at=
 @"
> +                          TARGET_FMT_lx "\n", ctx->base.pc_next - 4);

Logging is ok, but it's not enough in this context - that will turn
the variant eieio into a no-op.  You need to actually generate an
invalid instruction exception here, which is what I assume will happen
if you try to execute the new variant on a POWER8:
    gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);

> +            return;
> +        }
> +        bar =3D TCG_MO_ST_LD;
> +    }
> +
> +    tcg_gen_mb(bar | TCG_BAR_SC);
>  }
> =20
>  #if !defined(CONFIG_USER_ONLY)
> @@ -6483,7 +6498,7 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC=
_STRING),
>  GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
> -GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x03FFF801, PPC_MEM_EIEIO),
> +GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
>  GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
>  GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
>  GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 1a89017ddea8..6b70f6dc5a2c 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8847,7 +8847,8 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                          PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
>                          PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
> -                        PPC2_TM | PPC2_PM_ISA206 | PPC2_ISA300 | PPC2_PR=
CNTL;
> +                        PPC2_TM | PPC2_PM_ISA206 | PPC2_ISA300 | PPC2_PR=
CNTL |
> +                        PPC2_MEM_EIEIO2;
>      pcc->msr_mask =3D (1ull << MSR_SF) |
>                      (1ull << MSR_TM) |
>                      (1ull << MSR_VR) |

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Li7ckgedzMh1NgdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsXf+QACgkQbDjKyiDZ
s5KhLw/9E59nw4BYT/2RXaZgdl3nIeM4ud+3/36RGGNEAnvxxI5r65NxPgk63xGX
M5d9M4KKvAT9/rHzXgwRfx41iEA7ItWXqfvV4baLEiAFb2ONwydWmjt/Ba/8wCtq
ETa20mjGevLjS1htWuzZGTBgx2l8Ct+uadJ3gLLARePOGMbg9JtfcGKGOJ0ouxSZ
OcabUlv7u2vmeRTm9+gWTWq4WskfkVxAQAs9HKlXKjehNjOPaMrYBe8um5/6l1ib
vqz290a25xo9QJmbyzhi9se6Mimkq9VVL35J1GImDuNI84R4uayr1hjQDHYtGXLG
+5DbkcPVzqpMPdHojqRs2Z7xpaJZHYM7R6JdpnZZwn5QRT57paiIVS5w+/BfPCln
R/M8gJ5ou7qdF2JrUooOE0STAPGyv5uFL6Om8nZx1j6kBqPHvjmRO0m/qvLo3e4L
/PkD3kjtyhsBoeFhCIx1jvxY6Kf+fVL1smO3SNuV/VpS8mWlpJbvOyZJN6E929Dp
WbmvW3iuZer+Km7S4pK/9G/o5cTTpXHmYz5WEW9aRE7lCAPZAodmIEmjjiYOhd5a
g0YMycBMIRtNs93eg1ZusY528JJUusX9R2+JP8C7HtokQxKcheBArlXei6x6/gi1
ads8VLRNEKdYjey78jQQ1kBnY7q77fj6opr14A/J0VA2YBAvTA0=
=E2Fw
-----END PGP SIGNATURE-----

--Li7ckgedzMh1NgdW--
