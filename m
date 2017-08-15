Received: from eggs.gnu.org ([2001:4830:134:3::10]:36630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhTuj-0006kQ-7D
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhTuh-0004ik-IA
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:57:13 -0400
Date: Tue, 15 Aug 2017 14:11:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170815041125.GO3452@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<4282985e208e7c623dcb32e737cd43ab4c2a2716.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ctUzwJm0i+kwMBIK"
Content-Disposition: inline
In-Reply-To: <4282985e208e7c623dcb32e737cd43ab4c2a2716.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 02/12] ppc4xx: Make MAL emulation more
 generic
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


--ctUzwJm0i+kwMBIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> Allow MAL with more RX and TX channels as found in newer versions.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Looks reasonable.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc405_uc.c      |   2 +-
>  hw/ppc/ppc4xx_devs.c    | 171 +++++++++++++++++++-----------------------=
------
>  include/hw/ppc/ppc4xx.h |   3 +-
>  3 files changed, 70 insertions(+), 106 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 3c74402..03856d5 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -2281,7 +2281,7 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_sp=
ace_mem,
>      mal_irqs[1] =3D pic[12];
>      mal_irqs[2] =3D pic[13];
>      mal_irqs[3] =3D pic[14];
> -    ppc405_mal_init(env, mal_irqs);
> +    ppc4xx_mal_init(env, 4, 2, mal_irqs);
>      /* Ethernet */
>      /* Uses pic[9], pic[15], pic[17] */
>      /* CPU control */
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index 8e4f78e..6e1cc09 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -737,6 +737,7 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, i=
nt nr_banks,
> =20
>  /***********************************************************************=
******/
>  /* MAL */
> +
>  enum {
>      MAL0_CFG      =3D 0x180,
>      MAL0_ESR      =3D 0x181,
> @@ -750,17 +751,13 @@ enum {
>      MAL0_RXEOBISR =3D 0x192,
>      MAL0_RXDEIR   =3D 0x193,
>      MAL0_TXCTP0R  =3D 0x1A0,
> -    MAL0_TXCTP1R  =3D 0x1A1,
> -    MAL0_TXCTP2R  =3D 0x1A2,
> -    MAL0_TXCTP3R  =3D 0x1A3,
>      MAL0_RXCTP0R  =3D 0x1C0,
> -    MAL0_RXCTP1R  =3D 0x1C1,
>      MAL0_RCBS0    =3D 0x1E0,
>      MAL0_RCBS1    =3D 0x1E1,
>  };
> =20
> -typedef struct ppc40x_mal_t ppc40x_mal_t;
> -struct ppc40x_mal_t {
> +typedef struct ppc4xx_mal_t ppc4xx_mal_t;
> +struct ppc4xx_mal_t {
>      qemu_irq irqs[4];
>      uint32_t cfg;
>      uint32_t esr;
> @@ -773,16 +770,32 @@ struct ppc40x_mal_t {
>      uint32_t rxcarr;
>      uint32_t rxeobisr;
>      uint32_t rxdeir;
> -    uint32_t txctpr[4];
> -    uint32_t rxctpr[2];
> -    uint32_t rcbs[2];
> +    uint32_t *txctpr;
> +    uint32_t *rxctpr;
> +    uint32_t *rcbs;
> +    uint8_t  txcnum;
> +    uint8_t  rxcnum;
>  };
> =20
> -static void ppc40x_mal_reset(void *opaque);
> +static void ppc4xx_mal_reset(void *opaque)
> +{
> +    ppc4xx_mal_t *mal;
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
> =20
>  static uint32_t dcr_read_mal(void *opaque, int dcrn)
>  {
> -    ppc40x_mal_t *mal;
> +    ppc4xx_mal_t *mal;
>      uint32_t ret;
> =20
>      mal =3D opaque;
> @@ -820,48 +833,32 @@ static uint32_t dcr_read_mal(void *opaque, int dcrn)
>      case MAL0_RXDEIR:
>          ret =3D mal->rxdeir;
>          break;
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
>      default:
>          ret =3D 0;
>          break;
>      }
> +    if (dcrn >=3D MAL0_TXCTP0R && dcrn < MAL0_TXCTP0R + mal->txcnum) {
> +        ret =3D mal->txctpr[dcrn - MAL0_TXCTP0R];
> +    }
> +    if (dcrn >=3D MAL0_RXCTP0R && dcrn < MAL0_RXCTP0R + mal->rxcnum) {
> +        ret =3D mal->rxctpr[dcrn - MAL0_RXCTP0R];
> +    }
> +    if (dcrn >=3D MAL0_RCBS0 && dcrn < MAL0_RCBS0 + mal->rxcnum) {
> +        ret =3D mal->rcbs[dcrn - MAL0_RCBS0];
> +    }
> =20
>      return ret;
>  }
> =20
>  static void dcr_write_mal(void *opaque, int dcrn, uint32_t val)
>  {
> -    ppc40x_mal_t *mal;
> -    int idx;
> +    ppc4xx_mal_t *mal;
> =20
>      mal =3D opaque;
>      switch (dcrn) {
>      case MAL0_CFG:
>          if (val & 0x80000000) {
> -            ppc40x_mal_reset(mal);
> +            ppc4xx_mal_reset(mal);
>          }
>          mal->cfg =3D val & 0x00FFC087;
>          break;
> @@ -900,65 +897,35 @@ static void dcr_write_mal(void *opaque, int dcrn, u=
int32_t val)
>          /* Read/clear */
>          mal->rxdeir &=3D ~val;
>          break;
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
> +    }
> +    if (dcrn >=3D MAL0_TXCTP0R && dcrn < MAL0_TXCTP0R + mal->txcnum) {
> +        mal->txctpr[dcrn - MAL0_TXCTP0R] =3D val;
> +    }
> +    if (dcrn >=3D MAL0_RXCTP0R && dcrn < MAL0_RXCTP0R + mal->rxcnum) {
> +        mal->rxctpr[dcrn - MAL0_RXCTP0R] =3D val;
> +    }
> +    if (dcrn >=3D MAL0_RCBS0 && dcrn < MAL0_RCBS0 + mal->rxcnum) {
> +        mal->rcbs[dcrn - MAL0_RCBS0] =3D val & 0x000000FF;
>      }
>  }
> =20
> -static void ppc40x_mal_reset(void *opaque)
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
> -void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4])
> +void ppc4xx_mal_init(CPUPPCState *env, uint8_t txcnum, uint8_t rxcnum,
> +                     qemu_irq irqs[4])
>  {
> -    ppc40x_mal_t *mal;
> +    ppc4xx_mal_t *mal;
>      int i;
> =20
> -    mal =3D g_malloc0(sizeof(ppc40x_mal_t));
> +    assert(txcnum <=3D 32 && rxcnum <=3D 32);
> +    mal =3D g_malloc0(sizeof(*mal));
> +    mal->txcnum =3D txcnum;
> +    mal->rxcnum =3D rxcnum;
> +    mal->txctpr =3D g_new0(uint32_t, txcnum);
> +    mal->rxctpr =3D g_new0(uint32_t, rxcnum);
> +    mal->rcbs =3D g_new0(uint32_t, rxcnum);
>      for (i =3D 0; i < 4; i++) {
>          mal->irqs[i] =3D irqs[i];
>      }
> -    qemu_register_reset(&ppc40x_mal_reset, mal);
> +    qemu_register_reset(&ppc4xx_mal_reset, mal);
>      ppc_dcr_register(env, MAL0_CFG,
>                       mal, &dcr_read_mal, &dcr_write_mal);
>      ppc_dcr_register(env, MAL0_ESR,
> @@ -981,20 +948,16 @@ void ppc405_mal_init(CPUPPCState *env, qemu_irq irq=
s[4])
>                       mal, &dcr_read_mal, &dcr_write_mal);
>      ppc_dcr_register(env, MAL0_RXDEIR,
>                       mal, &dcr_read_mal, &dcr_write_mal);
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
> +    for (i =3D 0; i < txcnum; i++) {
> +        ppc_dcr_register(env, MAL0_TXCTP0R + i,
> +                         mal, &dcr_read_mal, &dcr_write_mal);
> +    }
> +    for (i =3D 0; i < rxcnum; i++) {
> +        ppc_dcr_register(env, MAL0_RXCTP0R + i,
> +                         mal, &dcr_read_mal, &dcr_write_mal);
> +    }
> +    for (i =3D 0; i < rxcnum; i++) {
> +        ppc_dcr_register(env, MAL0_RCBS0 + i,
> +                         mal, &dcr_read_mal, &dcr_write_mal);
> +    }
>  }
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index db50cfa..cb0bb55 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -53,7 +53,8 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq,=
 int nbanks,
>                          hwaddr *ram_sizes,
>                          int do_init);
> =20
> -void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4]);
> +void ppc4xx_mal_init(CPUPPCState *env, uint8_t txcnum, uint8_t rxcnum,
> +                     qemu_irq irqs[4]);
> =20
>  #define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ctUzwJm0i+kwMBIK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmSdG0ACgkQbDjKyiDZ
s5LSCw/+MmXp/SvZ5kDFWgbd9UalASZ/rbdmVFRGSeXlsEvJOHhhX1Arr8YcxCR3
5SvU21DA4kjvV2FwtE8tUdkUP6atp2uaHKrZPEciJRMAETRjpAX24RsEAqFZxOkL
9x7TrB10enpbZlTFrCoiWlg/JRvKqmYMm726K0CkhYiCkxYUWftz7y2U6bVsPoee
giPKG2xxpHyvFlnDVSCMQ8k77a3xgF7IDPdXrBuVHE7ej+ag8x64bTD1SwymPYpf
rJsNhl+eO5WTZsEqmfxxKFAUznosP9psAKUf+pnRpuZM9Zm5JpqeQFbyJqrMZWE8
w6jD7VRNfhd2X+iiLnwItv12ThqbvPW6KOlDKOUujuKp0KfmiuUhUG/BDmkZZ8I7
XmbSms57zZPo5YSjzG0sL+3He/l5uQii0VxYdDjov7F4JOsIrevDcYADHDcB/LrQ
Hi9f7wXZ91xEdueAR/tvovviNUV9nEV22//9ek1rPnQRwC6uv/NKhsSbQppgAAbv
tkBqvqhNEK4eHRU1/xK6BjhU91KYNLu/Z92i3PJkR7zYQowD9ZVwB3Wa5mYaj+0V
g78EkxGz08xPWPQz5bAoZLH7NtO4tkEoz8hC4UbSZM5KYsEeeWyRPVAtifz8hPeN
7qgMAkkluDnna/v8HyG//7QPS8VYwuYInRjhF7tRO0i3yPXArpQ=
=dF9q
-----END PGP SIGNATURE-----

--ctUzwJm0i+kwMBIK--
