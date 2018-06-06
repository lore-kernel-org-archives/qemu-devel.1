Received: from eggs.gnu.org ([2001:4830:134:3::10]:48440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQTRx-0005ST-7H
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQTRr-00031V-0F
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:05:45 -0400
Date: Wed, 6 Jun 2018 17:08:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180606070859.GL17757@umbus.fritz.box>
References: <20180606060830.25942-1-clg@kaod.org>
	<20180606063206.GI17757@umbus.fritz.box>
	<66b6b9eb-5b26-2a73-a637-a7f8027fd372@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hTKW8p8tUZ/8vLMe"
Content-Disposition: inline
In-Reply-To: <66b6b9eb-5b26-2a73-a637-a7f8027fd372@kaod.org>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Ellerman <mpe@ellerman.id.au>


--hTKW8p8tUZ/8vLMe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 08:42:08AM +0200, C=E9dric Le Goater wrote:
> On 06/06/2018 08:32 AM, David Gibson wrote:
> > On Wed, Jun 06, 2018 at 08:08:30AM +0200, C=E9dric Le Goater wrote:
> >> POWER9 introduced a new variant of the eieio instruction using bit 6
> >> as a hint to tell the CPU it is a store-forwarding barrier.
> >>
> >> The usage of this eieio extension was recently added in Linux 4.17
> >> which activated the "support for a store forwarding barrier at kernel
> >> entry/exit".
> >>
> >> Unfortunately, it is not possible to insert this new eieio instruction
> >> without considerable change in ppc_tr_translate_insn(). So instead we
> >> loosen the QEMU eieio instruction mask. The gen_eieio() helper is
> >> modified to test for bit6 and a custom instruction flag to catch
> >> invalid eieio opcodes on non-POWER9 CPUs.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  target/ppc/cpu.h                |  5 ++++-
> >>  target/ppc/translate.c          | 19 +++++++++++++++++--
> >>  target/ppc/translate_init.inc.c |  3 ++-
> >>  3 files changed, 23 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> >> index 0247c1f04c37..021c9b2f10d1 100644
> >> --- a/target/ppc/cpu.h
> >> +++ b/target/ppc/cpu.h
> >> @@ -2206,6 +2206,9 @@ enum {
> >>      /* POWER ISA 3.0                                                 =
        */
> >>      PPC2_ISA300        =3D 0x0000000000080000ULL,
> >> =20
> >> +    /* POWER ISA 3.0 eieio variants                                  =
        */
> >> +    PPC2_MEM_EIEIO2    =3D 0x0000000000100000ULL,
> >> +
> >>  #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2=
_DBRX | \
> >>                          PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 =
| \
> >>                          PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
> >> @@ -2213,7 +2216,7 @@ enum {
> >>                          PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
> >>                          PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
> >>                          PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
> >> -                        PPC2_ISA300)
> >> +                        PPC2_ISA300 | PPC2_MEM_EIEIO2)
> >>  };
> >> =20
> >>  /********************************************************************=
*********/
> >> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> >> index 8ba8f67dc513..a73ef02aef1d 100644
> >> --- a/target/ppc/translate.c
> >> +++ b/target/ppc/translate.c
> >> @@ -2967,7 +2967,22 @@ static void gen_stswx(DisasContext *ctx)
> >>  /* eieio */
> >>  static void gen_eieio(DisasContext *ctx)
> >>  {
> >> -    tcg_gen_mb(TCG_MO_LD_ST | TCG_BAR_SC);
> >> +    TCGBar bar =3D TCG_MO_LD_ST;
> >> +
> >> +    /*
> >> +     * POWER9 has a eieio instruction variant using bit 6 as a hint to
> >> +     * tell the CPU it is a store-forwarding barrier.
> >> +     */
> >> +    if (ctx->opcode & 0x2000000) {
> >> +        if (!(ctx->insns_flags2 & PPC2_MEM_EIEIO2)) {
> >=20
> > Since we have to adapt the gen_eieio code anyway we don't really need
> > the new instruction flag - we can just reuse PPC2_ISA300 for it.
>=20
> OK. That seems now a little superfluous, indeed. Unless there are more
> or these instructions which depend on CPU revision. I don't know so
> let's stick to  PPC2_ISA300.
>=20
> >=20
> >> +            qemu_log_mask(LOG_GUEST_ERROR, "invalid eieio using bit 6=
 at @"
> >> +                          TARGET_FMT_lx "\n", ctx->base.pc_next - 4);
> >=20
> > Logging is ok, but it's not enough in this context - that will turn
> > the variant eieio into a no-op.  You need to actually generate an
> > invalid instruction exception here, which is what I assume will happen
> > if you try to execute the new variant on a POWER8:
> >     gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>=20
> well, I didn't try but ISA says that :
>=20
> 	"Reserved fields in instructions are ignored by the processor."
>=20
> So it should be a no-op.

Ah, ok.  So, no 0x700, but.. that doesn't mean a no-op, that means it
should act as a normal eieio.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hTKW8p8tUZ/8vLMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsXiIgACgkQbDjKyiDZ
s5JWExAA2n7tDyVb5qGJiHqdTVu/Lsr0321tkxuzNKHmWnDmMkC879oWeSB7r8lx
kmueHw6VITfsiXfOU7E+HEUXuIBGoi2v4BspkpDMYHvdYHafYQNMueAdtTREvElG
BwRKP6TPVUWZeeS2VhpedP/FU2PBX9+WO50Xr3lNw09g1lLAC7hbe+uCNEGLIsI/
kZzEhoiOMuP9v3FQI+XBRKaWEBpyihSIPziPiKQqhz6V6KKvT1sEdHDgOqwrv0Lk
S3hdWo8uU6/IA9VqORAnhutKz3LY8jdS3ya4Z92pJT1yV6w4FzRZ+npQqq+zVn9l
Tllq0IInGXkqiSksQiK1kwp23lJqm/QY83OHeCztVNYrFCZCMtoLtC8W9OS+MMLZ
BDJxWjGxvfrh+B4zccccP5xKBtk2J/hkd7MSOVGKqilPiNB9w8MsXTzURWYB40ZX
0GrCHHycxuu2ut9flRNRUfF5Xnq6sxfHr7glvJyvb0taQzr4ChSKFewqwoVzT3Bw
YGzQ5Htotd+K6Qzb68OBy+E5wiQFKWW19muMehEQYZ6Tp7wXHLwVHv09NZq9gFyo
2J8rc7H+M552JXOnID2dg34GaTOG2HA1rHUX40xNLpPqcnXAYgt60X39F1J9Upii
DdqKoIhGujK7INS5W355WW15WaBbDCTlvgXivNVyUHmCysmDb0w=
=0QPM
-----END PGP SIGNATURE-----

--hTKW8p8tUZ/8vLMe--
