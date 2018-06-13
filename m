Received: from eggs.gnu.org ([2001:4830:134:3::10]:39913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSuUv-00045W-Ax
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSuUr-0003IT-Ab
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:22:53 -0400
Date: Wed, 13 Jun 2018 11:22:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613012236.GQ30690@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<d13ea58b288f386a12a76c41a617c500c4454341.1528291908.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hIO1AjEoFJ7b3ahE"
Content-Disposition: inline
In-Reply-To: <d13ea58b288f386a12a76c41a617c500c4454341.1528291908.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] ppc4xx_i2c: Implement directcntl
 register
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


--hIO1AjEoFJ7b3ahE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 03:31:48PM +0200, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  default-configs/ppc-softmmu.mak    |  1 +
>  default-configs/ppcemb-softmmu.mak |  1 +
>  hw/i2c/ppc4xx_i2c.c                | 14 +++++++++++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index 4d7be45..7d0dc2f 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -26,6 +26,7 @@ CONFIG_USB_EHCI_SYSBUS=3Dy
>  CONFIG_SM501=3Dy
>  CONFIG_IDE_SII3112=3Dy
>  CONFIG_I2C=3Dy
> +CONFIG_BITBANG_I2C=3Dy
> =20
>  # For Macs
>  CONFIG_MAC=3Dy
> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-=
softmmu.mak
> index 67d18b2..37af193 100644
> --- a/default-configs/ppcemb-softmmu.mak
> +++ b/default-configs/ppcemb-softmmu.mak
> @@ -19,3 +19,4 @@ CONFIG_USB_EHCI_SYSBUS=3Dy
>  CONFIG_SM501=3Dy
>  CONFIG_IDE_SII3112=3Dy
>  CONFIG_I2C=3Dy
> +CONFIG_BITBANG_I2C=3Dy
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> index a68b5f7..5806209 100644
> --- a/hw/i2c/ppc4xx_i2c.c
> +++ b/hw/i2c/ppc4xx_i2c.c
> @@ -30,6 +30,7 @@
>  #include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/i2c/ppc4xx_i2c.h"
> +#include "bitbang_i2c.h"
> =20
>  #define PPC4xx_I2C_MEM_SIZE 18
> =20
> @@ -46,7 +47,13 @@
> =20
>  #define IIC_XTCNTLSS_SRST   (1 << 0)
> =20
> +#define IIC_DIRECTCNTL_SDAC (1 << 3)
> +#define IIC_DIRECTCNTL_SCLC (1 << 2)
> +#define IIC_DIRECTCNTL_MSDA (1 << 1)
> +#define IIC_DIRECTCNTL_MSCL (1 << 0)
> +
>  typedef struct {
> +    bitbang_i2c_interface *bitbang;
>      uint8_t mdata;
>      uint8_t lmadr;
>      uint8_t hmadr;
> @@ -308,7 +315,11 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr a=
ddr, uint64_t value,
>          i2c->xtcntlss =3D value;
>          break;
>      case 16:
> -        i2c->directcntl =3D value & 0x7;
> +        i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNT=
L_SCLC);
> +        i2c->directcntl |=3D (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
> +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL, i2c->directcntl &=
 1);

Shouldn't that use i2c->directcntl & IIC_DIRECTCNTL_MSCL ?

> +        i2c->directcntl |=3D bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_S=
DA,
> +                               (value & IIC_DIRECTCNTL_SDAC) !=3D 0) << =
1;

Last expression might be clearer as:
	value & IIC_DIRECTCNTL_SDAC ? IIC_DIRECTCNTL_MSDA : 0

>          break;
>      default:
>          if (addr < PPC4xx_I2C_MEM_SIZE) {
> @@ -343,6 +354,7 @@ static void ppc4xx_i2c_init(Object *o)
>      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
>      sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
>      s->bus =3D i2c_init_bus(DEVICE(s), "i2c");
> +    r->bitbang =3D bitbang_i2c_init(s->bus);
>  }
> =20
>  static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hIO1AjEoFJ7b3ahE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgcdwACgkQbDjKyiDZ
s5LKBg/9EPhDTCCBwS+yE6AN+QvO6QsOkl8Srb46G0L7EFoizp/wTyZo/KeBMg7j
QJ/en3/i11avWHj+zrV5mMtQqoD3S1A+BNRPIJ4yv2R+jO5w0msQYKntrXpdwlnE
GHWP6FEZfZZ5KWMXKb2lyIBDiSaz6W596N/zlppWdcJz+sLgRDtavHn6iyhxgzrh
Nfl7evj0QXXjboWZQybiMavymTZWkQ8n3mAQbjewZdwCxIkfT3Nix6sZsfc87tIj
oDUV0aOX/YCrrOU6FyeLtYANDYeIQOLqToNqoS+XcJTijauReOKpBXAgt0hqvEX4
bty5gh/274Kf/WoQnEV9JOgRM8WnRP4dmarnkLOxiyq5sBLoNVy6XyVbh9dlAe9g
Eh6C5IA4KRXzPrkyoCio6vIP/wRIJbnfTxqoWDswf+zTvfGnbWVaq7da80Yx7KQC
pb6eAhCj5X4mM0uAyBBs2gBkR6C52yavmQWrmoqK6mFr0ovwKi3L17xWI2sQJh00
jygw7bTcPP4RFC+2AZbBp0I+Zi2wJdGhPqN3sS9wD6Wd5B9dWVUZi6O8PF1n1CRD
VcMd+HaDZ5U1EuErDVvqz2BBX81iMm2v98faB54vZVIoZ3yZFizdJf9AalRd7CvQ
UmijxuOW+YhqMX+TXIXIqdzGQqBTPw/jDJ18hbQlPywUYgEdBe8=
=7Ydu
-----END PGP SIGNATURE-----

--hIO1AjEoFJ7b3ahE--
