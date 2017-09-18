Received: from eggs.gnu.org ([2001:4830:134:3::10]:51001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtR-000170-0S
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtN-0002ho-Qo
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:41 -0400
Date: Tue, 19 Sep 2017 06:37:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918203749.GI15823@umbus>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-7-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JI+G0+mN8WmwPnOn"
Content-Disposition: inline
In-Reply-To: <1505668548-16616-7-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 6/8] ppc: Fix OpenPIC model
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


--JI+G0+mN8WmwPnOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2017 at 06:15:46PM +0100, Mark Cave-Ayland wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Apple uses an IBM MPIC2A without timers, it has 64 sources.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to ppc-for-2.11.

> ---
>  hw/intc/openpic.c        |   35 +++++++++++++++++++++++++++++++++++
>  hw/ppc/mac_newworld.c    |    2 +-
>  include/hw/ppc/openpic.h |    1 +
>  3 files changed, 37 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index 9dd285b..10d6e87 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -92,6 +92,16 @@ static int get_current_cpu(void);
>  #define RAVEN_MAX_TMR      OPENPIC_MAX_TMR
>  #define RAVEN_MAX_IPI      OPENPIC_MAX_IPI
> =20
> +/* KeyLargo */
> +#define KEYLARGO_MAX_CPU  4
> +#define KEYLARGO_MAX_EXT  64
> +#define KEYLARGO_MAX_IPI  4
> +#define KEYLARGO_MAX_IRQ  (64 + KEYLARGO_MAX_IPI)
> +#define KEYLARGO_MAX_TMR  0
> +#define KEYLARGO_IPI_IRQ  (KEYLARGO_MAX_EXT) /* First IPI IRQ */
> +/* Timers don't exist but this makes the code happy... */
> +#define KEYLARGO_TMR_IRQ  (KEYLARGO_IPI_IRQ + KEYLARGO_MAX_IPI)
> +
>  /* Interrupt definitions */
>  #define RAVEN_FE_IRQ     (RAVEN_MAX_EXT)     /* Internal functional IRQ =
*/
>  #define RAVEN_ERR_IRQ    (RAVEN_MAX_EXT + 1) /* Error IRQ */
> @@ -120,6 +130,7 @@ static FslMpicInfo fsl_mpic_42 =3D {
>  #define VID_REVISION_1_3   3
> =20
>  #define VIR_GENERIC      0x00000000 /* Generic Vendor ID */
> +#define VIR_MPIC2A       0x00004614 /* IBM MPIC-2A */
> =20
>  #define GCR_RESET        0x80000000
>  #define GCR_MODE_PASS    0x00000000
> @@ -329,6 +340,8 @@ typedef struct OpenPICState {
>      uint32_t nb_cpus;
>      /* Timer registers */
>      OpenPICTimer timers[OPENPIC_MAX_TMR];
> +    uint32_t max_tmr;
> +
>      /* Shared MSI registers */
>      OpenPICMSI msi[MAX_MSI];
>      uint32_t max_irq;
> @@ -1717,6 +1730,28 @@ static void openpic_realize(DeviceState *dev, Erro=
r **errp)
> =20
>          map_list(opp, list_le, &list_count);
>          break;
> +
> +    case OPENPIC_MODEL_KEYLARGO:
> +        opp->nb_irqs =3D KEYLARGO_MAX_EXT;
> +        opp->vid =3D VID_REVISION_1_2;
> +        opp->vir =3D VIR_GENERIC;
> +        opp->vector_mask =3D 0xFF;
> +        opp->tfrr_reset =3D 4160000;
> +        opp->ivpr_reset =3D IVPR_MASK_MASK | IVPR_MODE_MASK;
> +        opp->idr_reset =3D 0;
> +        opp->max_irq =3D KEYLARGO_MAX_IRQ;
> +        opp->irq_ipi0 =3D KEYLARGO_IPI_IRQ;
> +        opp->irq_tim0 =3D KEYLARGO_TMR_IRQ;
> +        opp->brr1 =3D -1;
> +        opp->mpic_mode_mask =3D GCR_MODE_MIXED;
> +
> +        if (opp->nb_cpus !=3D 1) {
> +            error_setg(errp, "Only UP supported today");
> +            return;
> +        }
> +
> +        map_list(opp, list_le, &list_count);
> +        break;
>      }
> =20
>      for (i =3D 0; i < opp->nb_cpus; i++) {
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index c581d96..62bd8d3 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -351,7 +351,7 @@ static void ppc_core99_init(MachineState *machine)
>      pic =3D g_new0(qemu_irq, 64);
> =20
>      dev =3D qdev_create(NULL, TYPE_OPENPIC);
> -    qdev_prop_set_uint32(dev, "model", OPENPIC_MODEL_RAVEN);
> +    qdev_prop_set_uint32(dev, "model", OPENPIC_MODEL_KEYLARGO);
>      qdev_init_nofail(dev);
>      s =3D SYS_BUS_DEVICE(dev);
>      pic_mem =3D s->mmio[0].memory;
> diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
> index 6137e2d..e55ce54 100644
> --- a/include/hw/ppc/openpic.h
> +++ b/include/hw/ppc/openpic.h
> @@ -20,6 +20,7 @@ enum {
>  #define OPENPIC_MODEL_RAVEN       0
>  #define OPENPIC_MODEL_FSL_MPIC_20 1
>  #define OPENPIC_MODEL_FSL_MPIC_42 2
> +#define OPENPIC_MODEL_KEYLARGO    3
> =20
>  #define OPENPIC_MAX_SRC     256
>  #define OPENPIC_MAX_TMR     4

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JI+G0+mN8WmwPnOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnALp0ACgkQbDjKyiDZ
s5KXlw/7BOMKYLDuSbP2IHOLiC3Pc/5Doe4oAD7zrdonWEF7F5sQWJ2bXSED27Gv
is7Iar57ELP3KXRQ2NhhFvawcbcO4jgwrUlPqhLlMtVtwm4hbvTS8IeOUVVyOSaz
/3UbZT4kgdF5V2Lz0zuk/ZjvGTBzFemjaTpg3BTODfOvvpt8uRX7qsCU8vKGsh14
JB/dkyE/OAn8VjzUVYbAom0GuYMR2Ncp3CR3mN2BMikOWuv1jpxQNw/G4w4ImOdi
/dnIVCcknVDBTvBgFr8FmjLKk9Mpkx2UgvYwbEGhgEhAL5koXtWDWh7hfiLvCnVh
RRdB26kSnnEi56rJ5e3DP+SNCzMalQCCJR9HGUP7Yu7LcxnBpLuHdtQibBlluQ2u
YoZ+bozyQ2U1n1sFpMlEmRaqd+vba/uAP4UEEKB64W7aa15zdEv2YZEtbFKaeImk
6FfLEtdH0PVDlRBba7pCnvIjPgRdbmLg19Pmlhv0iwW3n7jgBExQbOenuIG1gvtr
cVftWLCs+lqRoPVs66vVaqh+5qY6D+MxF+Mzmb7tJOnAv+lYkHt59OAorPgK9+aK
y6sLqZXtpwhJsau0T8DHDLGYuUY4atfVWTgb9ARVrkUAi9TeQ/AG1pLlVDJtB8Ah
oW9H6T04gcqB5OtLMBc+K0CHOn7bvBW50pNAhSKG9jbrOrHkWTs=
=Dy/s
-----END PGP SIGNATURE-----

--JI+G0+mN8WmwPnOn--
