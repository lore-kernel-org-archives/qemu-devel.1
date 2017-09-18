Received: from eggs.gnu.org ([2001:4830:134:3::10]:51019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtS-00019a-1k
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtQ-0002mb-9X
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:42 -0400
Date: Tue, 19 Sep 2017 06:39:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918203948.GA27153@umbus>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-9-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <1505668548-16616-9-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 8/8] openpic: Fix problem when IRQ
 transitions from edge to level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2017 at 06:15:48PM +0100, Mark Cave-Ayland wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Some interrupts get triggered before the OS has setup the
> right interrupt type. If an edge interrupt is latched that
> way, not delivered (still masked), then the interrupt is
> changed to level and isn't asserted anymore, it will be
> stuck "pending", causing an interrupt flood. This can happen
> with the PMU GPIO interrupt for example.
>=20
> There are a few other corner cases like this, so let's keep
> track of the input "level" so we can properly re-evaluate
> when the trigger type changes.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  hw/intc/openpic.c |   32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index debfcbf..34749f8 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -236,6 +236,7 @@ typedef struct IRQSource {
>      int last_cpu;
>      int output;     /* IRQ level, e.g. OPENPIC_OUTPUT_INT */
>      int pending;    /* TRUE if IRQ is pending */
> +    int cur_level;  /* Cache current level */
>      IRQType type;
>      bool level:1;   /* level-triggered */
>      bool nomask:1;  /* critical interrupts ignore mask on some FSL MPICs=
 */
> @@ -552,14 +553,26 @@ static void openpic_set_irq(void *opaque, int n_IRQ=
, int level)
>      }
> =20
>      src =3D &opp->src[n_IRQ];
> -    DPRINTF("openpic: set irq %d =3D %d ivpr=3D0x%08x\n",
> -            n_IRQ, level, src->ivpr);
> +    DPRINTF("openpic: set irq %d =3D %d ivpr=3D0x%08x (l=3D%d,cl=3D%d)\n=
",
> +            n_IRQ, level, src->ivpr, src->level, src->cur_level);
> +
> +    /* Keep track of the current input level in order to properly deal
> +     * with the configuration of the source changing from edge to level
> +     * after it's been latched. Otherwise the interrupt can get stuck.
> +     */
> +    src->cur_level =3D level;
> +
>      if (src->level) {
> -        /* level-sensitive irq */
>          src->pending =3D level;
>          openpic_update_irq(opp, n_IRQ);
>      } else {
> -        /* edge-sensitive irq */
> +        /* edge-sensitive irq
> +         *
> +         * In an ideal world we would only set pending on an "edge", ie
> +         * if level is set and src->cur_level as clear. However that wou=
ld
> +         * require all the devices to properly send "pulses" rather than
> +         * just "raise" which isn't the case today.
> +         */
>          if (level) {
>              src->pending =3D 1;
>              openpic_update_irq(opp, n_IRQ);
> @@ -676,6 +689,13 @@ static inline void write_IRQreg_ivpr(OpenPICState *o=
pp, int n_IRQ, uint32_t val)
>      switch (opp->src[n_IRQ].type) {
>      case IRQ_TYPE_NORMAL:
>          opp->src[n_IRQ].level =3D !!(opp->src[n_IRQ].ivpr & IVPR_SENSE_M=
ASK);
> +
> +        /* If we switched to level we need to re-evaluate "pending" based
> +         * on the actual input state.
> +         */
> +        if (opp->src[n_IRQ].level) {
> +            opp->src[n_IRQ].pending =3D opp->src[n_IRQ].cur_level;
> +        }
>          break;
> =20
>      case IRQ_TYPE_FSLINT:
> @@ -687,6 +707,7 @@ static inline void write_IRQreg_ivpr(OpenPICState *op=
p, int n_IRQ, uint32_t val)
>          break;
>      }
> =20
> +    /* Re-evaluate a level irq */
>      openpic_update_irq(opp, n_IRQ);
>      DPRINTF("Set IVPR %d to 0x%08x -> 0x%08x\n", n_IRQ, val,
>              opp->src[n_IRQ].ivpr);
> @@ -1232,7 +1253,7 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQ=
Dest *dst, int cpu)
>      }
> =20
>      if (!src->level) {
> -        /* edge-sensitive IRQ */
> +        /* edge-sensitive IRQ or level dropped */
>          src->ivpr &=3D ~IVPR_ACTIVITY_MASK;
>          src->pending =3D 0;
>          IRQ_resetbit(&dst->raised, irq);
> @@ -1564,6 +1585,7 @@ static const VMStateDescription vmstate_openpic_irq=
source =3D {
>          VMSTATE_UINT32(destmask, IRQSource),
>          VMSTATE_INT32(last_cpu, IRQSource),
>          VMSTATE_INT32(pending, IRQSource),
> +        VMSTATE_INT32(cur_level, IRQSource),
>          VMSTATE_END_OF_LIST()

This alters the migration stream without bumping the version number.
I suspect it will be best to move this hunk into your other patch
updating the migration of the openpic.

>      }
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnALxQACgkQbDjKyiDZ
s5Lc/g//V2h3cqGOCxq7mYDUqV2unk21EcMcKP7UpcdKCtQbH5wG8iZA3eSeU8kl
VLuBvS7cZN0u+vAkJBHCU9IODTcpBptquQDIzCOD/KRdPHr3wEqJEuT+ej+6c4qf
vd0h+95OoRNLvR71i2wuZ86yyTxHiiCT61avVd3nhoQZfkd7QcJxHses1Hznv8hh
o8Mgu72LsqkqBa4gljF/5bcYVmv/YlkOsUpZOgL/Kkxp3EJoXU5C5FAiqWuLHej6
eE/P4DVQi9Tqm6i/V2yZjEcw8EpwElyR7SznwsLBwa1Bmjgg1TBrWh8H8OpMrllv
Q/gla2E0aT5dboV376nsvw3Zus0XdWVHRBm3TvmjgL1MSSUdorY8fg7E3FNcVlPi
bH5Ek5dccuNH33+NWMaSBKQunaUL+F1C3OVZYRW1UhYzdOr1tH1FUg0aDzYsdqiQ
E2/FRjl5qbM7ZZaDEETjwTwmGThsQ011U1cwCjjPkM1yRgczbA3yiRSAeoqfigfF
rFS7bkLqo9eLzG1OzCpc3bhYyfgDtAL4SpKQVkNwsa66jesuF1PT3DzDh41myGUe
Nt98BBi+Spq+5uOgJR+k2KmxsswLyV/m0n90/N7imTDxWWlK86SQoaez0BhtX4fn
jOa27Zga1KZ5CfCk+HR3pQ1+K7+Bcok+oRQVO3InG16FFMt7zoU=
=O1OQ
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
