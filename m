Received: from eggs.gnu.org ([2001:4830:134:3::10]:35913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJrPt-0002xX-7v
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJrPq-0004u6-0V
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:44:01 -0500
Date: Wed, 29 Nov 2017 12:35:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171129013530.GD3023@umbus.fritz.box>
References: <ec95e71d-3d96-489d-6939-cdbef4d8c34e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Content-Disposition: inline
In-Reply-To: <ec95e71d-3d96-489d-6939-cdbef4d8c34e@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] etsec: fix IRQ (un)masking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 08:42:13PM -0600, Michael Davidsaver wrote:
> Interrupt conditions occurring while masked are not being
> signaled when later unmasked.
> The fix is to raise/lower IRQs when IMASK is changed.
>=20
> To avoid problems like this in future, consolidate
> IRQ pin update logic in one function.
>=20
> Also fix probable typo "IEVENT_TXF | IEVENT_TXF",
> and update IRQ pins on reset.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Looks sane, but I would like to get an R-b from someone who knows FSL
better than me before applying.

> ---
>  hw/net/fsl_etsec/etsec.c     | 68 +++++++++++++++++++++++---------------=
------
>  hw/net/fsl_etsec/etsec.h     |  2 ++
>  hw/net/fsl_etsec/registers.h | 10 +++++++
>  hw/net/fsl_etsec/rings.c     | 12 +-------
>  4 files changed, 49 insertions(+), 43 deletions(-)
>=20
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index 9da1932970..0b66274ce3 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -49,6 +49,28 @@ static const int debug_etsec;
>      }                                          \
>      } while (0)
> =20
> +/* call after any change to IEVENT or IMASK */
> +void etsec_update_irq(eTSEC *etsec)
> +{
> +    uint32_t ievent =3D etsec->regs[IEVENT].value;
> +    uint32_t imask  =3D etsec->regs[IMASK].value;
> +    uint32_t active =3D ievent & imask;
> +
> +    int tx  =3D !!(active & IEVENT_TX_MASK);
> +    int rx  =3D !!(active & IEVENT_RX_MASK);
> +    int err =3D !!(active & IEVENT_ERR_MASK);
> +
> +    DPRINTF("%s IRQ ievent=3D%"PRIx32" imask=3D%"PRIx32" %c%c%c\n",
> +            __func__, ievent, imask,
> +            tx  ? 'T' : '_',
> +            rx  ? 'R' : '_',
> +            err ? 'E' : '_');
> +
> +    qemu_set_irq(etsec->tx_irq, tx);
> +    qemu_set_irq(etsec->rx_irq, rx);
> +    qemu_set_irq(etsec->err_irq, err);
> +}
> +
>  static uint64_t etsec_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      eTSEC          *etsec     =3D opaque;
> @@ -139,31 +161,6 @@ static void write_rbasex(eTSEC          *etsec,
>      etsec->regs[RBPTR0 + (reg_index - RBASE0)].value =3D value & ~0x7;
>  }
> =20
> -static void write_ievent(eTSEC          *etsec,
> -                         eTSEC_Register *reg,
> -                         uint32_t        reg_index,
> -                         uint32_t        value)
> -{
> -    /* Write 1 to clear */
> -    reg->value &=3D ~value;
> -
> -    if (!(reg->value & (IEVENT_TXF | IEVENT_TXF))) {
> -        qemu_irq_lower(etsec->tx_irq);
> -    }
> -    if (!(reg->value & (IEVENT_RXF | IEVENT_RXF))) {
> -        qemu_irq_lower(etsec->rx_irq);
> -    }
> -
> -    if (!(reg->value & (IEVENT_MAG | IEVENT_GTSC | IEVENT_GRSC | IEVENT_=
TXC |
> -                        IEVENT_RXC | IEVENT_BABR | IEVENT_BABT | IEVENT_=
LC |
> -                        IEVENT_CRL | IEVENT_FGPI | IEVENT_FIR | IEVENT_F=
IQ |
> -                        IEVENT_DPE | IEVENT_PERR | IEVENT_EBERR | IEVENT=
_TXE |
> -                        IEVENT_XFUN | IEVENT_BSY | IEVENT_MSRO | IEVENT_=
MMRD |
> -                        IEVENT_MMRW))) {
> -        qemu_irq_lower(etsec->err_irq);
> -    }
> -}
> -
>  static void write_dmactrl(eTSEC          *etsec,
>                            eTSEC_Register *reg,
>                            uint32_t        reg_index,
> @@ -178,9 +175,7 @@ static void write_dmactrl(eTSEC          *etsec,
>          } else {
>              /* Graceful receive stop now */
>              etsec->regs[IEVENT].value |=3D IEVENT_GRSC;
> -            if (etsec->regs[IMASK].value & IMASK_GRSCEN) {
> -                qemu_irq_raise(etsec->err_irq);
> -            }
> +            etsec_update_irq(etsec);
>          }
>      }
> =20
> @@ -191,9 +186,7 @@ static void write_dmactrl(eTSEC          *etsec,
>          } else {
>              /* Graceful transmit stop now */
>              etsec->regs[IEVENT].value |=3D IEVENT_GTSC;
> -            if (etsec->regs[IMASK].value & IMASK_GTSCEN) {
> -                qemu_irq_raise(etsec->err_irq);
> -            }
> +            etsec_update_irq(etsec);
>          }
>      }
> =20
> @@ -222,7 +215,16 @@ static void etsec_write(void     *opaque,
> =20
>      switch (reg_index) {
>      case IEVENT:
> -        write_ievent(etsec, reg, reg_index, value);
> +        /* Write 1 to clear */
> +        reg->value &=3D ~value;
> +
> +        etsec_update_irq(etsec);
> +        break;
> +
> +    case IMASK:
> +        reg->value =3D value;
> +
> +        etsec_update_irq(etsec);
>          break;
> =20
>      case DMACTRL:
> @@ -337,6 +339,8 @@ static void etsec_reset(DeviceState *d)
>          MII_SR_EXTENDED_STATUS  | MII_SR_100T2_HD_CAPS | MII_SR_100T2_FD=
_CAPS |
>          MII_SR_10T_HD_CAPS      | MII_SR_10T_FD_CAPS   | MII_SR_100X_HD_=
CAPS  |
>          MII_SR_100X_FD_CAPS     | MII_SR_100T4_CAPS;
> +
> +    etsec_update_irq(etsec);
>  }
> =20
>  static ssize_t etsec_receive(NetClientState *nc,
> diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
> index 30c828e241..877988572e 100644
> --- a/hw/net/fsl_etsec/etsec.h
> +++ b/hw/net/fsl_etsec/etsec.h
> @@ -163,6 +163,8 @@ DeviceState *etsec_create(hwaddr        base,
>                            qemu_irq      rx_irq,
>                            qemu_irq      err_irq);
> =20
> +void etsec_update_irq(eTSEC *etsec);
> +
>  void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr);
>  void etsec_walk_rx_ring(eTSEC *etsec, int ring_nbr);
>  ssize_t etsec_rx_ring_write(eTSEC *etsec, const uint8_t *buf, size_t siz=
e);
> diff --git a/hw/net/fsl_etsec/registers.h b/hw/net/fsl_etsec/registers.h
> index c4ed2b9d62..f085537ecd 100644
> --- a/hw/net/fsl_etsec/registers.h
> +++ b/hw/net/fsl_etsec/registers.h
> @@ -74,6 +74,16 @@ extern const eTSEC_Register_Definition eTSEC_registers=
_def[];
>  #define IEVENT_RXC   (1 << 30)
>  #define IEVENT_BABR  (1 << 31)
> =20
> +/* Mapping between interrupt pin and interrupt flags */
> +#define IEVENT_RX_MASK (IEVENT_RXF | IEVENT_RXB)
> +#define IEVENT_TX_MASK (IEVENT_TXF | IEVENT_TXB)
> +#define IEVENT_ERR_MASK (IEVENT_MAG | IEVENT_GTSC | IEVENT_GRSC | IEVENT=
_TXC | \
> +    IEVENT_RXC | IEVENT_BABR | IEVENT_BABT | IEVENT_LC | \
> +    IEVENT_CRL | IEVENT_FGPI | IEVENT_FIR | IEVENT_FIQ | \
> +    IEVENT_DPE | IEVENT_PERR | IEVENT_EBERR | IEVENT_TXE | \
> +    IEVENT_XFUN | IEVENT_BSY | IEVENT_MSRO | IEVENT_MMRD | \
> +    IEVENT_MMRW)
> +
>  #define IMASK_RXFEN  (1 <<  7)
>  #define IMASK_GRSCEN (1 <<  8)
>  #define IMASK_RXBEN  (1 << 15)
> diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
> index d0f93eebfc..337a55fc95 100644
> --- a/hw/net/fsl_etsec/rings.c
> +++ b/hw/net/fsl_etsec/rings.c
> @@ -152,17 +152,7 @@ static void ievent_set(eTSEC    *etsec,
>  {
>      etsec->regs[IEVENT].value |=3D flags;
> =20
> -    if ((flags & IEVENT_TXB && etsec->regs[IMASK].value & IMASK_TXBEN)
> -        || (flags & IEVENT_TXF && etsec->regs[IMASK].value & IMASK_TXFEN=
)) {
> -        qemu_irq_raise(etsec->tx_irq);
> -        RING_DEBUG("%s Raise Tx IRQ\n", __func__);
> -    }
> -
> -    if ((flags & IEVENT_RXB && etsec->regs[IMASK].value & IMASK_RXBEN)
> -        || (flags & IEVENT_RXF && etsec->regs[IMASK].value & IMASK_RXFEN=
)) {
> -        qemu_irq_raise(etsec->rx_irq);
> -        RING_DEBUG("%s Raise Rx IRQ\n", __func__);
> -    }
> +    etsec_update_irq(etsec);
>  }
> =20
>  static void tx_padding_and_crc(eTSEC *etsec, uint32_t min_frame_len)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloeDuIACgkQbDjKyiDZ
s5INnRAAzuc6ax2YnBq8Yu4hVyx2kFhKxyd8tfQ5AJ/QgMbxzqTZgycaftFNMLoY
QPjcR81OoLQCsMudJBeoo1sGBvWwl3rr8C/S2zaw8zuEIDfMJpXIqy8pJm9e0LNh
Lzfn/t6xS4Zx41rpdhwhDeB1VbJiX5YmbRzh8ms2W7sJSfr1X0nMss8Ph+h+M3ry
gDHmWQkOqM8xkySXH1FMIEW2QkcC3nFDqareG2nwaVmbJwovtyf6eDqc9lhSn3s0
ebzDWbHY24jSF30xJlN0My9peYedkJK01hD3uor4Oo4HGb/+he0cmrQOhkCmEhNd
UR1KdTdzbNU95GUsj5iGFBNYaJsdcKG+JhSxwvk1Fqykk+xzdOdQXI5uki5luAxQ
oxv1nQKNdjRxJZ2Zk5a2qcpicIV7TDMAAA4yVclqgCmWWnzwAeVDgkpaazvh3C3A
fja1bDBpnCbDDtpR2BB+t16BbAo/L4/iz7vyiD9xsRF2cNPsb5ERQlQg3vbasWke
S+g0slUvO76IWpLTwRnmuy+IB3KylO10SVtQeIR3ERcFc6ToO++kPbM/6N/CCBrO
oAZSEsNSUYHQV27cKBEVJzO3ULW4t2h7BJHmLGB0cmU/n6WXRMK+VWb1EzaQv/qc
Mi0+KnxNSVUOduqfcpCpiBoJ8G0yg3bimcgJCEBD6485spzvteA=
=k2ut
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
