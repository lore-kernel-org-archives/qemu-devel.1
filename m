Received: from eggs.gnu.org ([2001:4830:134:3::10]:45035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh78m-0001qb-Ro
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 00:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh78j-0006Mh-Ut
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 00:38:12 -0400
Date: Mon, 14 Aug 2017 14:37:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170814043746.GC3452@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<eb1b3ac28031d7cb942e4977bb73bbabb909dcfc.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <eb1b3ac28031d7cb942e4977bb73bbabb909dcfc.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 01/12] ppc4xx: Move MAL from ppc405_uc
 to ppc4xx_devs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> This device appears in other SoCs as well not just in 405 ones
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc405_uc.c      | 263 ------------------------------------------=
-----
>  hw/ppc/ppc4xx_devs.c    | 264 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/ppc4xx.h |   2 +
>  3 files changed, 266 insertions(+), 263 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index f6fe3e6..3c74402 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -42,7 +42,6 @@
>  //#define DEBUG_OCM
>  //#define DEBUG_I2C
>  //#define DEBUG_GPT
> -//#define DEBUG_MAL
>  //#define DEBUG_CLOCKS
>  //#define DEBUG_CLOCKS_LL
> =20
> @@ -1513,268 +1512,6 @@ static void ppc4xx_gpt_init(hwaddr base, qemu_irq=
 irqs[5])
>  }
> =20
>  /***********************************************************************=
******/
> -/* MAL */
> -enum {
> -    MAL0_CFG      =3D 0x180,
> -    MAL0_ESR      =3D 0x181,
> -    MAL0_IER      =3D 0x182,
> -    MAL0_TXCASR   =3D 0x184,
> -    MAL0_TXCARR   =3D 0x185,
> -    MAL0_TXEOBISR =3D 0x186,
> -    MAL0_TXDEIR   =3D 0x187,
> -    MAL0_RXCASR   =3D 0x190,
> -    MAL0_RXCARR   =3D 0x191,
> -    MAL0_RXEOBISR =3D 0x192,
> -    MAL0_RXDEIR   =3D 0x193,
> -    MAL0_TXCTP0R  =3D 0x1A0,
> -    MAL0_TXCTP1R  =3D 0x1A1,
> -    MAL0_TXCTP2R  =3D 0x1A2,
> -    MAL0_TXCTP3R  =3D 0x1A3,
> -    MAL0_RXCTP0R  =3D 0x1C0,
> -    MAL0_RXCTP1R  =3D 0x1C1,
> -    MAL0_RCBS0    =3D 0x1E0,
> -    MAL0_RCBS1    =3D 0x1E1,
> -};
> -
> -typedef struct ppc40x_mal_t ppc40x_mal_t;
> -struct ppc40x_mal_t {
> -    qemu_irq irqs[4];
> -    uint32_t cfg;
> -    uint32_t esr;
> -    uint32_t ier;
> -    uint32_t txcasr;
> -    uint32_t txcarr;
> -    uint32_t txeobisr;
> -    uint32_t txdeir;
> -    uint32_t rxcasr;
> -    uint32_t rxcarr;
> -    uint32_t rxeobisr;
> -    uint32_t rxdeir;
> -    uint32_t txctpr[4];
> -    uint32_t rxctpr[2];
> -    uint32_t rcbs[2];
> -};
> -
> -static void ppc40x_mal_reset (void *opaque);
> -
> -static uint32_t dcr_read_mal (void *opaque, int dcrn)
> -{
> -    ppc40x_mal_t *mal;
> -    uint32_t ret;
> -
> -    mal =3D opaque;
> -    switch (dcrn) {
> -    case MAL0_CFG:
> -        ret =3D mal->cfg;
> -        break;
> -    case MAL0_ESR:
> -        ret =3D mal->esr;
> -        break;
> -    case MAL0_IER:
> -        ret =3D mal->ier;
> -        break;
> -    case MAL0_TXCASR:
> -        ret =3D mal->txcasr;
> -        break;
> -    case MAL0_TXCARR:
> -        ret =3D mal->txcarr;
> -        break;
> -    case MAL0_TXEOBISR:
> -        ret =3D mal->txeobisr;
> -        break;
> -    case MAL0_TXDEIR:
> -        ret =3D mal->txdeir;
> -        break;
> -    case MAL0_RXCASR:
> -        ret =3D mal->rxcasr;
> -        break;
> -    case MAL0_RXCARR:
> -        ret =3D mal->rxcarr;
> -        break;
> -    case MAL0_RXEOBISR:
> -        ret =3D mal->rxeobisr;
> -        break;
> -    case MAL0_RXDEIR:
> -        ret =3D mal->rxdeir;
> -        break;
> -    case MAL0_TXCTP0R:
> -        ret =3D mal->txctpr[0];
> -        break;
> -    case MAL0_TXCTP1R:
> -        ret =3D mal->txctpr[1];
> -        break;
> -    case MAL0_TXCTP2R:
> -        ret =3D mal->txctpr[2];
> -        break;
> -    case MAL0_TXCTP3R:
> -        ret =3D mal->txctpr[3];
> -        break;
> -    case MAL0_RXCTP0R:
> -        ret =3D mal->rxctpr[0];
> -        break;
> -    case MAL0_RXCTP1R:
> -        ret =3D mal->rxctpr[1];
> -        break;
> -    case MAL0_RCBS0:
> -        ret =3D mal->rcbs[0];
> -        break;
> -    case MAL0_RCBS1:
> -        ret =3D mal->rcbs[1];
> -        break;
> -    default:
> -        ret =3D 0;
> -        break;
> -    }
> -
> -    return ret;
> -}
> -
> -static void dcr_write_mal (void *opaque, int dcrn, uint32_t val)
> -{
> -    ppc40x_mal_t *mal;
> -    int idx;
> -
> -    mal =3D opaque;
> -    switch (dcrn) {
> -    case MAL0_CFG:
> -        if (val & 0x80000000)
> -            ppc40x_mal_reset(mal);
> -        mal->cfg =3D val & 0x00FFC087;
> -        break;
> -    case MAL0_ESR:
> -        /* Read/clear */
> -        mal->esr &=3D ~val;
> -        break;
> -    case MAL0_IER:
> -        mal->ier =3D val & 0x0000001F;
> -        break;
> -    case MAL0_TXCASR:
> -        mal->txcasr =3D val & 0xF0000000;
> -        break;
> -    case MAL0_TXCARR:
> -        mal->txcarr =3D val & 0xF0000000;
> -        break;
> -    case MAL0_TXEOBISR:
> -        /* Read/clear */
> -        mal->txeobisr &=3D ~val;
> -        break;
> -    case MAL0_TXDEIR:
> -        /* Read/clear */
> -        mal->txdeir &=3D ~val;
> -        break;
> -    case MAL0_RXCASR:
> -        mal->rxcasr =3D val & 0xC0000000;
> -        break;
> -    case MAL0_RXCARR:
> -        mal->rxcarr =3D val & 0xC0000000;
> -        break;
> -    case MAL0_RXEOBISR:
> -        /* Read/clear */
> -        mal->rxeobisr &=3D ~val;
> -        break;
> -    case MAL0_RXDEIR:
> -        /* Read/clear */
> -        mal->rxdeir &=3D ~val;
> -        break;
> -    case MAL0_TXCTP0R:
> -        idx =3D 0;
> -        goto update_tx_ptr;
> -    case MAL0_TXCTP1R:
> -        idx =3D 1;
> -        goto update_tx_ptr;
> -    case MAL0_TXCTP2R:
> -        idx =3D 2;
> -        goto update_tx_ptr;
> -    case MAL0_TXCTP3R:
> -        idx =3D 3;
> -    update_tx_ptr:
> -        mal->txctpr[idx] =3D val;
> -        break;
> -    case MAL0_RXCTP0R:
> -        idx =3D 0;
> -        goto update_rx_ptr;
> -    case MAL0_RXCTP1R:
> -        idx =3D 1;
> -    update_rx_ptr:
> -        mal->rxctpr[idx] =3D val;
> -        break;
> -    case MAL0_RCBS0:
> -        idx =3D 0;
> -        goto update_rx_size;
> -    case MAL0_RCBS1:
> -        idx =3D 1;
> -    update_rx_size:
> -        mal->rcbs[idx] =3D val & 0x000000FF;
> -        break;
> -    }
> -}
> -
> -static void ppc40x_mal_reset (void *opaque)
> -{
> -    ppc40x_mal_t *mal;
> -
> -    mal =3D opaque;
> -    mal->cfg =3D 0x0007C000;
> -    mal->esr =3D 0x00000000;
> -    mal->ier =3D 0x00000000;
> -    mal->rxcasr =3D 0x00000000;
> -    mal->rxdeir =3D 0x00000000;
> -    mal->rxeobisr =3D 0x00000000;
> -    mal->txcasr =3D 0x00000000;
> -    mal->txdeir =3D 0x00000000;
> -    mal->txeobisr =3D 0x00000000;
> -}
> -
> -static void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4])
> -{
> -    ppc40x_mal_t *mal;
> -    int i;
> -
> -    mal =3D g_malloc0(sizeof(ppc40x_mal_t));
> -    for (i =3D 0; i < 4; i++)
> -        mal->irqs[i] =3D irqs[i];
> -    qemu_register_reset(&ppc40x_mal_reset, mal);
> -    ppc_dcr_register(env, MAL0_CFG,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_ESR,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_IER,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_TXCASR,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_TXCARR,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_TXEOBISR,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_TXDEIR,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_RXCASR,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_RXCARR,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_RXEOBISR,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_RXDEIR,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_TXCTP0R,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_TXCTP1R,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_TXCTP2R,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_TXCTP3R,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_RXCTP0R,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_RXCTP1R,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_RCBS0,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -    ppc_dcr_register(env, MAL0_RCBS1,
> -                     mal, &dcr_read_mal, &dcr_write_mal);
> -}
> -
> -/***********************************************************************=
******/
>  /* SPR */
>  void ppc40x_core_reset(PowerPCCPU *cpu)
>  {
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index e7f413e..8e4f78e 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -734,3 +734,267 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size,=
 int nr_banks,
> =20
>      return ram_size;
>  }
> +
> +/***********************************************************************=
******/
> +/* MAL */
> +enum {
> +    MAL0_CFG      =3D 0x180,
> +    MAL0_ESR      =3D 0x181,
> +    MAL0_IER      =3D 0x182,
> +    MAL0_TXCASR   =3D 0x184,
> +    MAL0_TXCARR   =3D 0x185,
> +    MAL0_TXEOBISR =3D 0x186,
> +    MAL0_TXDEIR   =3D 0x187,
> +    MAL0_RXCASR   =3D 0x190,
> +    MAL0_RXCARR   =3D 0x191,
> +    MAL0_RXEOBISR =3D 0x192,
> +    MAL0_RXDEIR   =3D 0x193,
> +    MAL0_TXCTP0R  =3D 0x1A0,
> +    MAL0_TXCTP1R  =3D 0x1A1,
> +    MAL0_TXCTP2R  =3D 0x1A2,
> +    MAL0_TXCTP3R  =3D 0x1A3,
> +    MAL0_RXCTP0R  =3D 0x1C0,
> +    MAL0_RXCTP1R  =3D 0x1C1,
> +    MAL0_RCBS0    =3D 0x1E0,
> +    MAL0_RCBS1    =3D 0x1E1,
> +};
> +
> +typedef struct ppc40x_mal_t ppc40x_mal_t;
> +struct ppc40x_mal_t {
> +    qemu_irq irqs[4];
> +    uint32_t cfg;
> +    uint32_t esr;
> +    uint32_t ier;
> +    uint32_t txcasr;
> +    uint32_t txcarr;
> +    uint32_t txeobisr;
> +    uint32_t txdeir;
> +    uint32_t rxcasr;
> +    uint32_t rxcarr;
> +    uint32_t rxeobisr;
> +    uint32_t rxdeir;
> +    uint32_t txctpr[4];
> +    uint32_t rxctpr[2];
> +    uint32_t rcbs[2];
> +};
> +
> +static void ppc40x_mal_reset(void *opaque);
> +
> +static uint32_t dcr_read_mal(void *opaque, int dcrn)
> +{
> +    ppc40x_mal_t *mal;
> +    uint32_t ret;
> +
> +    mal =3D opaque;
> +    switch (dcrn) {
> +    case MAL0_CFG:
> +        ret =3D mal->cfg;
> +        break;
> +    case MAL0_ESR:
> +        ret =3D mal->esr;
> +        break;
> +    case MAL0_IER:
> +        ret =3D mal->ier;
> +        break;
> +    case MAL0_TXCASR:
> +        ret =3D mal->txcasr;
> +        break;
> +    case MAL0_TXCARR:
> +        ret =3D mal->txcarr;
> +        break;
> +    case MAL0_TXEOBISR:
> +        ret =3D mal->txeobisr;
> +        break;
> +    case MAL0_TXDEIR:
> +        ret =3D mal->txdeir;
> +        break;
> +    case MAL0_RXCASR:
> +        ret =3D mal->rxcasr;
> +        break;
> +    case MAL0_RXCARR:
> +        ret =3D mal->rxcarr;
> +        break;
> +    case MAL0_RXEOBISR:
> +        ret =3D mal->rxeobisr;
> +        break;
> +    case MAL0_RXDEIR:
> +        ret =3D mal->rxdeir;
> +        break;
> +    case MAL0_TXCTP0R:
> +        ret =3D mal->txctpr[0];
> +        break;
> +    case MAL0_TXCTP1R:
> +        ret =3D mal->txctpr[1];
> +        break;
> +    case MAL0_TXCTP2R:
> +        ret =3D mal->txctpr[2];
> +        break;
> +    case MAL0_TXCTP3R:
> +        ret =3D mal->txctpr[3];
> +        break;
> +    case MAL0_RXCTP0R:
> +        ret =3D mal->rxctpr[0];
> +        break;
> +    case MAL0_RXCTP1R:
> +        ret =3D mal->rxctpr[1];
> +        break;
> +    case MAL0_RCBS0:
> +        ret =3D mal->rcbs[0];
> +        break;
> +    case MAL0_RCBS1:
> +        ret =3D mal->rcbs[1];
> +        break;
> +    default:
> +        ret =3D 0;
> +        break;
> +    }
> +
> +    return ret;
> +}
> +
> +static void dcr_write_mal(void *opaque, int dcrn, uint32_t val)
> +{
> +    ppc40x_mal_t *mal;
> +    int idx;
> +
> +    mal =3D opaque;
> +    switch (dcrn) {
> +    case MAL0_CFG:
> +        if (val & 0x80000000) {
> +            ppc40x_mal_reset(mal);
> +        }
> +        mal->cfg =3D val & 0x00FFC087;
> +        break;
> +    case MAL0_ESR:
> +        /* Read/clear */
> +        mal->esr &=3D ~val;
> +        break;
> +    case MAL0_IER:
> +        mal->ier =3D val & 0x0000001F;
> +        break;
> +    case MAL0_TXCASR:
> +        mal->txcasr =3D val & 0xF0000000;
> +        break;
> +    case MAL0_TXCARR:
> +        mal->txcarr =3D val & 0xF0000000;
> +        break;
> +    case MAL0_TXEOBISR:
> +        /* Read/clear */
> +        mal->txeobisr &=3D ~val;
> +        break;
> +    case MAL0_TXDEIR:
> +        /* Read/clear */
> +        mal->txdeir &=3D ~val;
> +        break;
> +    case MAL0_RXCASR:
> +        mal->rxcasr =3D val & 0xC0000000;
> +        break;
> +    case MAL0_RXCARR:
> +        mal->rxcarr =3D val & 0xC0000000;
> +        break;
> +    case MAL0_RXEOBISR:
> +        /* Read/clear */
> +        mal->rxeobisr &=3D ~val;
> +        break;
> +    case MAL0_RXDEIR:
> +        /* Read/clear */
> +        mal->rxdeir &=3D ~val;
> +        break;
> +    case MAL0_TXCTP0R:
> +        idx =3D 0;
> +        goto update_tx_ptr;
> +    case MAL0_TXCTP1R:
> +        idx =3D 1;
> +        goto update_tx_ptr;
> +    case MAL0_TXCTP2R:
> +        idx =3D 2;
> +        goto update_tx_ptr;
> +    case MAL0_TXCTP3R:
> +        idx =3D 3;
> +    update_tx_ptr:
> +        mal->txctpr[idx] =3D val;
> +        break;
> +    case MAL0_RXCTP0R:
> +        idx =3D 0;
> +        goto update_rx_ptr;
> +    case MAL0_RXCTP1R:
> +        idx =3D 1;
> +    update_rx_ptr:
> +        mal->rxctpr[idx] =3D val;
> +        break;
> +    case MAL0_RCBS0:
> +        idx =3D 0;
> +        goto update_rx_size;
> +    case MAL0_RCBS1:
> +        idx =3D 1;
> +    update_rx_size:
> +        mal->rcbs[idx] =3D val & 0x000000FF;
> +        break;
> +    }
> +}
> +
> +static void ppc40x_mal_reset(void *opaque)
> +{
> +    ppc40x_mal_t *mal;
> +
> +    mal =3D opaque;
> +    mal->cfg =3D 0x0007C000;
> +    mal->esr =3D 0x00000000;
> +    mal->ier =3D 0x00000000;
> +    mal->rxcasr =3D 0x00000000;
> +    mal->rxdeir =3D 0x00000000;
> +    mal->rxeobisr =3D 0x00000000;
> +    mal->txcasr =3D 0x00000000;
> +    mal->txdeir =3D 0x00000000;
> +    mal->txeobisr =3D 0x00000000;
> +}
> +
> +void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4])
> +{
> +    ppc40x_mal_t *mal;
> +    int i;
> +
> +    mal =3D g_malloc0(sizeof(ppc40x_mal_t));
> +    for (i =3D 0; i < 4; i++) {
> +        mal->irqs[i] =3D irqs[i];
> +    }
> +    qemu_register_reset(&ppc40x_mal_reset, mal);
> +    ppc_dcr_register(env, MAL0_CFG,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_ESR,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_IER,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_TXCASR,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_TXCARR,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_TXEOBISR,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_TXDEIR,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_RXCASR,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_RXCARR,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_RXEOBISR,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_RXDEIR,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_TXCTP0R,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_TXCTP1R,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_TXCTP2R,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_TXCTP3R,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_RXCTP0R,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_RXCTP1R,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_RCBS0,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +    ppc_dcr_register(env, MAL0_RCBS1,
> +                     mal, &dcr_read_mal, &dcr_write_mal);
> +}
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index 66e57a5..db50cfa 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -53,6 +53,8 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq,=
 int nbanks,
>                          hwaddr *ram_sizes,
>                          int do_init);
> =20
> +void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4]);
> +
>  #define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
> =20
>  #endif /* PPC4XX_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmRKRoACgkQbDjKyiDZ
s5LlzRAA4KkkffmHWlcMmgw6iucb+GJhu8Ft+XTqtb1vt7StbvWL6C1xd+JUQH1J
B9KzGUDpbUYw3ptGVdFYgZcSqW7hEkIpN2TLmhaeFOn7ZGsrg8+7veOuPCjqOijT
3ccLMZlA4N1qAcOlZe8iz/zF89/T9XzhMCRteDly4LcwCP5qFYotAjcj9xIaRkhF
ZJt8rxZGjYq/WvxejktEG+Magt5eGd8AxVxmf+iiA0RIYHemMhiwl/4ph/9B/Ye/
GZ7Dfsj2iisWUnddF3E/WUJatallMbTLh7Fs4/qWar/WdErluirPgCLInf5scZ0C
9jMecZVnpAB5C+3MQIjX6Cja6YwZJfWgpgZIeM1PYilm28Ska1Lub9m1qPVNQYNJ
xzdLvd2dNnTDuMbKbI1Ly8X6S8nroJFsmYh4i7i+N3xQBMf6qh19EDbmf7g00wkk
FNQRDkln4qX3tlwBllSG2i7bi0rB5pZrZgqDPf2g6EIAafS5mdbVUH9JpYTrq4Gu
tv15lS/h2PblUXu7+1wX0hkN1VFGJEEAARmrUNYjbD7t23jfZCFeJHQ9hvp1H5M1
L7idBCUqyYv8xafJSEijr9G4qErp0pUsDCTJ2pa9hGike2x+/X+0vMn8o3ZBw6GL
37drhZu3wiOammJftBvdhoAJsebhRq2AS1hVGFqnmMiLo7Crfik=
=yDX/
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
