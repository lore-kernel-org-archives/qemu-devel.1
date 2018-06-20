Received: from eggs.gnu.org ([2001:4830:134:3::10]:47649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVXHi-0001RB-Ky
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVXHg-00045g-Mw
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:12:06 -0400
Date: Wed, 20 Jun 2018 15:25:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620052532.GB24636@umbus.fritz.box>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<5227f6905dc3cf9aa0ed933b591d1741acbeeac5.1529398335.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <5227f6905dc3cf9aa0ed933b591d1741acbeeac5.1529398335.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v4 03/11] ppc4xx_i2c: Rewrite to model
 hardware more closely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
> Rewrite to make it closer to how real device works so that guest OS
> drivers can access I2C devices. Previously this was only a hack to
> allow U-Boot to get past accessing SPD EEPROMs but to support other
> I2C devices and allow guests to access them we need to model real
> device more properly.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Ugh.  This is still a large enough change that it's pretty difficult
to review, at least for someone not already familiar with the hardware.

> ---
>  hw/i2c/ppc4xx_i2c.c         | 222 +++++++++++++++++++++-----------------=
------
>  include/hw/i2c/ppc4xx_i2c.h |   3 +-
>  2 files changed, 110 insertions(+), 115 deletions(-)
>=20
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> index fca80d6..3ebce17 100644
> --- a/hw/i2c/ppc4xx_i2c.c
> +++ b/hw/i2c/ppc4xx_i2c.c
> @@ -38,13 +38,26 @@
>  #define IIC_CNTL_READ       (1 << 1)
>  #define IIC_CNTL_CHT        (1 << 2)
>  #define IIC_CNTL_RPST       (1 << 3)
> +#define IIC_CNTL_AMD        (1 << 6)
> +#define IIC_CNTL_HMT        (1 << 7)
> +
> +#define IIC_MDCNTL_EINT     (1 << 2)
> +#define IIC_MDCNTL_ESM      (1 << 3)
> +#define IIC_MDCNTL_FMDB     (1 << 6)
> =20
>  #define IIC_STS_PT          (1 << 0)
> +#define IIC_STS_IRQA        (1 << 1)
>  #define IIC_STS_ERR         (1 << 2)
> +#define IIC_STS_MDBF        (1 << 4)
>  #define IIC_STS_MDBS        (1 << 5)
> =20
>  #define IIC_EXTSTS_XFRA     (1 << 0)
> =20
> +#define IIC_INTRMSK_EIMTC   (1 << 0)
> +#define IIC_INTRMSK_EITA    (1 << 1)
> +#define IIC_INTRMSK_EIIC    (1 << 2)
> +#define IIC_INTRMSK_EIHE    (1 << 3)
> +
>  #define IIC_XTCNTLSS_SRST   (1 << 0)
> =20
>  #define IIC_DIRECTCNTL_SDAC (1 << 3)
> @@ -56,21 +69,13 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>  {
>      PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
> =20
> -    /* FIXME: Should also reset bus?
> -     *if (s->address !=3D ADDR_RESET) {
> -     *    i2c_end_transfer(s->bus);
> -     *}
> -     */
> -
> -    i2c->mdata =3D 0;
> -    i2c->lmadr =3D 0;
> -    i2c->hmadr =3D 0;
> +    i2c->mdidx =3D -1;
> +    memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
> +    /* [hl][ms]addr are not affected by reset */
>      i2c->cntl =3D 0;
>      i2c->mdcntl =3D 0;
>      i2c->sts =3D 0;
> -    i2c->extsts =3D 0x8f;
> -    i2c->lsadr =3D 0;
> -    i2c->hsadr =3D 0;
> +    i2c->extsts =3D (1 << 6);
>      i2c->clkdiv =3D 0;
>      i2c->intrmsk =3D 0;
>      i2c->xfrcnt =3D 0;
> @@ -78,69 +83,29 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>      i2c->directcntl =3D 0xf;
>  }
> =20
> -static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
> -{
> -    return true;
> -}
> -
>  static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int=
 size)
>  {
>      PPC4xxI2CState *i2c =3D PPC4xx_I2C(opaque);
>      uint64_t ret;
> +    int i;
> =20
>      switch (addr) {
>      case 0:
> -        ret =3D i2c->mdata;
> -        if (ppc4xx_i2c_is_master(i2c)) {
> +        if (i2c->mdidx < 0) {
>              ret =3D 0xff;
> -
> -            if (!(i2c->sts & IIC_STS_MDBS)) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Trying to read "
> -                              "without starting transfer\n",
> -                              TYPE_PPC4xx_I2C, __func__);
> -            } else {
> -                int pending =3D (i2c->cntl >> 4) & 3;
> -
> -                /* get the next byte */
> -                int byte =3D i2c_recv(i2c->bus);
> -
> -                if (byte < 0) {
> -                    qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: read failed "
> -                                  "for device 0x%02x\n", TYPE_PPC4xx_I2C,
> -                                  __func__, i2c->lmadr);
> -                    ret =3D 0xff;
> -                } else {
> -                    ret =3D byte;
> -                    /* Raise interrupt if enabled */
> -                    /*ppc4xx_i2c_raise_interrupt(i2c)*/;
> -                }
> -
> -                if (!pending) {
> -                    i2c->sts &=3D ~IIC_STS_MDBS;
> -                    /*i2c_end_transfer(i2c->bus);*/
> -                /*} else if (i2c->cntl & (IIC_CNTL_RPST | IIC_CNTL_CHT))=
 {*/
> -                } else if (pending) {
> -                    /* current smbus implementation doesn't like
> -                       multibyte xfer repeated start */
> -                    i2c_end_transfer(i2c->bus);
> -                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)=
) {
> -                        /* if non zero is returned, the adress is not va=
lid */
> -                        i2c->sts &=3D ~IIC_STS_PT;
> -                        i2c->sts |=3D IIC_STS_ERR;
> -                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
> -                    } else {
> -                        /*i2c->sts |=3D IIC_STS_PT;*/
> -                        i2c->sts |=3D IIC_STS_MDBS;
> -                        i2c->sts &=3D ~IIC_STS_ERR;
> -                        i2c->extsts =3D 0;
> -                    }
> -                }
> -                pending--;
> -                i2c->cntl =3D (i2c->cntl & 0xcf) | (pending << 4);
> -            }
> -        } else {
> -            qemu_log_mask(LOG_UNIMP, "[%s]%s: slave mode not implemented=
\n",
> -                          TYPE_PPC4xx_I2C, __func__);
> +            break;
> +        }
> +        ret =3D i2c->mdata[0];
> +        if (i2c->mdidx =3D=3D 3) {
> +            i2c->sts &=3D ~IIC_STS_MDBF;
> +        } else if (i2c->mdidx =3D=3D 0) {
> +            i2c->sts &=3D ~IIC_STS_MDBS;
> +        }
> +        for (i =3D 0; i < i2c->mdidx; i++) {
> +            i2c->mdata[i] =3D i2c->mdata[i + 1];
> +        }
> +        if (i2c->mdidx >=3D 0) {
> +            i2c->mdidx--;
>          }
>          break;
>      case 4:
> @@ -160,6 +125,7 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr=
 addr, unsigned int size)
>          break;
>      case 9:
>          ret =3D i2c->extsts;
> +        ret |=3D !!i2c_bus_busy(i2c->bus) << 4;
>          break;
>      case 10:
>          ret =3D i2c->lsadr;
> @@ -203,70 +169,98 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr =
addr, uint64_t value,
> =20
>      switch (addr) {
>      case 0:
> -        i2c->mdata =3D value;
> -        if (!i2c_bus_busy(i2c->bus)) {
> -            /* assume we start a write transfer */
> -            if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 0)) {
> -                /* if non zero is returned, the adress is not valid */
> -                i2c->sts &=3D ~IIC_STS_PT;
> -                i2c->sts |=3D IIC_STS_ERR;
> -                i2c->extsts |=3D IIC_EXTSTS_XFRA;
> -            } else {
> -                i2c->sts |=3D IIC_STS_PT;
> -                i2c->sts &=3D ~IIC_STS_ERR;
> -                i2c->extsts =3D 0;
> -            }
> +        if (i2c->mdidx >=3D 3) {
> +            break;
>          }
> -        if (i2c_bus_busy(i2c->bus)) {
> -            if (i2c_send(i2c->bus, i2c->mdata)) {
> -                /* if the target return non zero then end the transfer */
> -                i2c->sts &=3D ~IIC_STS_PT;
> -                i2c->sts |=3D IIC_STS_ERR;
> -                i2c->extsts |=3D IIC_EXTSTS_XFRA;
> -                i2c_end_transfer(i2c->bus);
> -            }
> +        i2c->mdata[++i2c->mdidx] =3D value;
> +        if (i2c->mdidx =3D=3D 3) {
> +            i2c->sts |=3D IIC_STS_MDBF;
> +        } else if (i2c->mdidx =3D=3D 0) {
> +            i2c->sts |=3D IIC_STS_MDBS;
>          }
>          break;
>      case 4:
>          i2c->lmadr =3D value;
> -        if (i2c_bus_busy(i2c->bus)) {
> -            i2c_end_transfer(i2c->bus);
> -        }
>          break;
>      case 5:
>          i2c->hmadr =3D value;
>          break;
>      case 6:
> -        i2c->cntl =3D value;
> -        if (i2c->cntl & IIC_CNTL_PT) {
> -            if (i2c->cntl & IIC_CNTL_READ) {
> -                if (i2c_bus_busy(i2c->bus)) {
> -                    /* end previous transfer */
> -                    i2c->sts &=3D ~IIC_STS_PT;
> -                    i2c_end_transfer(i2c->bus);
> +        i2c->cntl =3D value & 0xfe;
> +        if (value & IIC_CNTL_AMD) {
> +            qemu_log_mask(LOG_UNIMP, "%s: only 7 bit addresses supported=
\n",
> +                          __func__);
> +        }
> +        if (value & IIC_CNTL_HMT && i2c_bus_busy(i2c->bus)) {
> +            i2c_end_transfer(i2c->bus);
> +            if (i2c->mdcntl & IIC_MDCNTL_EINT &&
> +                i2c->intrmsk & IIC_INTRMSK_EIHE) {
> +                    i2c->sts |=3D IIC_STS_IRQA;
> +                    qemu_irq_raise(i2c->irq);
> +            }
> +        } else if (value & IIC_CNTL_PT) {
> +            int recv =3D (value & IIC_CNTL_READ) >> 1;
> +            int tct =3D value >> 4 & 3;
> +            int i;
> +
> +            if (recv && (i2c->lmadr >> 1) >=3D 0x50 && (i2c->lmadr >> 1)=
 < 0x58) {
> +                /* smbus emulation does not like multi byte reads w/o re=
start */
> +                value |=3D IIC_CNTL_RPST;
> +            }
> +
> +            for (i =3D 0; i <=3D tct; i++) {
> +                if (!i2c_bus_busy(i2c->bus)) {
> +                    i2c->extsts =3D (1 << 6);
> +                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, re=
cv)) {
> +                        i2c->sts |=3D IIC_STS_ERR;
> +                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
> +                        break;
> +                    } else {
> +                        i2c->sts &=3D ~IIC_STS_ERR;
> +                    }
> +                }
> +                if (!(i2c->sts & IIC_STS_ERR) &&
> +                    i2c_send_recv(i2c->bus, &i2c->mdata[i], !recv)) {
> +                        i2c->sts |=3D IIC_STS_ERR;
> +                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
> +                        break;
>                  }
> -                if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
> -                    /* if non zero is returned, the adress is not valid =
*/
> -                    i2c->sts &=3D ~IIC_STS_PT;
> -                    i2c->sts |=3D IIC_STS_ERR;
> -                    i2c->extsts |=3D IIC_EXTSTS_XFRA;
> -                } else {
> -                    /*i2c->sts |=3D IIC_STS_PT;*/
> -                    i2c->sts |=3D IIC_STS_MDBS;
> -                    i2c->sts &=3D ~IIC_STS_ERR;
> -                    i2c->extsts =3D 0;
> +                if (value & IIC_CNTL_RPST || !(value & IIC_CNTL_CHT)) {
> +                    i2c_end_transfer(i2c->bus);
>                  }
> -            } else {
> -                /* we actually already did the write transfer... */
> -                i2c->sts &=3D ~IIC_STS_PT;
> +            }
> +            i2c->xfrcnt =3D i;
> +            i2c->mdidx =3D i - 1;
> +            if (recv && i2c->mdidx >=3D 0) {
> +                i2c->sts |=3D IIC_STS_MDBS;
> +            }
> +            if (recv && i2c->mdidx =3D=3D 3) {
> +                i2c->sts |=3D IIC_STS_MDBF;
> +            }
> +            if (i && i2c->mdcntl & IIC_MDCNTL_EINT &&
> +                i2c->intrmsk & IIC_INTRMSK_EIMTC) {
> +                i2c->sts |=3D IIC_STS_IRQA;
> +                qemu_irq_raise(i2c->irq);
>              }
>          }
>          break;
>      case 7:
> -        i2c->mdcntl =3D value & 0xdf;
> +        i2c->mdcntl =3D value & 0x3d;
> +        if (value & IIC_MDCNTL_ESM) {
> +            qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
> +                          __func__);
> +        }
> +        if (value & IIC_MDCNTL_FMDB) {
> +            i2c->mdidx =3D -1;
> +            memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
> +            i2c->sts &=3D ~(IIC_STS_MDBF | IIC_STS_MDBS);
> +        }
>          break;
>      case 8:
> -        i2c->sts &=3D ~(value & 0xa);
> +        i2c->sts &=3D ~(value & 0x0a);
> +        if (value & IIC_STS_IRQA && i2c->mdcntl & IIC_MDCNTL_EINT) {
> +            qemu_irq_lower(i2c->irq);
> +        }
>          break;
>      case 9:
>          i2c->extsts &=3D ~(value & 0x8f);
> @@ -287,12 +281,12 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr =
addr, uint64_t value,
>          i2c->xfrcnt =3D value & 0x77;
>          break;
>      case 15:
> +        i2c->xtcntlss &=3D ~(value & 0xf0);
>          if (value & IIC_XTCNTLSS_SRST) {
>              /* Is it actually a full reset? U-Boot sets some regs before=
 */
>              ppc4xx_i2c_reset(DEVICE(i2c));
>              break;
>          }
> -        i2c->xtcntlss =3D value;
>          break;
>      case 16:
>          i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNT=
L_SCLC);
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index ea6c8e1..0891a9c 100644
> --- a/include/hw/i2c/ppc4xx_i2c.h
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -46,7 +46,8 @@ typedef struct PPC4xxI2CState {
>      qemu_irq irq;
>      MemoryRegion iomem;
>      bitbang_i2c_interface *bitbang;
> -    uint8_t mdata;
> +    int mdidx;
> +    uint8_t mdata[4];
>      uint8_t lmadr;
>      uint8_t hmadr;
>      uint8_t cntl;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsp5UwACgkQbDjKyiDZ
s5LUHhAA2Si7Qcw2mN2MUgCmT4EQOK7Doh7RD3+ZAQgJIlpYOkH9wkrUC4+07ftK
2kjMAecxJmKJ9//ez2e3TJrsonJjPmU2/4PsXsBs3soTaPYkbgEXwwsb6yn990Vn
vhGzfTQaMq5GH9RUOINhsg6dcXXBfqm10OHdTnECFgOSDUZsh8AbNOIxXsdMCN5p
GP3xacGaskoOGcJPOUow/cER8buHoXtzZPhWKz74eSNWbaaHZzWfDRqfegg87ldP
CFH2c8g6znojKkL+kBqoXd203gCk1fVvicoF1caSFU2A3FNr+Qr7oATuBr2hzdN1
NDCOmDsLC/HYmauNgy6hz37r0zXkazN6w3MdPNJX8fqoNkN3oEYbhDKsgnUrkZHC
trY1+S0k1Iqz+W9JtBjsuPP4Bp6FUkttOxzSCdjmjFHDQbvcLUFTjrSvKc2rZQa0
xuMZyjHKQIIH8lveH8B9+PzEimv3ZajMNqhmRLl/Nq8RvcjSHsBW6Hf7RQDsGdu1
dEO9o4AET4t8JOnvPpy1+vDtFeqPjZOsuVy434RLOpYUwfqYCAg0S5H4DI1X3rf1
EElNqKD+xXPvCVTBfpHHJV2b9JVIBQRTg2Kry4huFBmk0FVdLB9VjzbVx/smeC7J
r9FFTp2MwCwvjMW6wunj8uSxverWeIOm716ass/zloSm3UvxRRg=
=asdc
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
