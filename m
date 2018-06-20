Received: from eggs.gnu.org ([2001:4830:134:3::10]:47662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVXHj-0001S6-VT
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVXHf-00044b-RV
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:12:07 -0400
Date: Wed, 20 Jun 2018 15:20:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620052044.GA24636@umbus.fritz.box>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<ce619ddd11a875caae4c221c18ebf7c6a6f4bd4f.1529398335.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <ce619ddd11a875caae4c221c18ebf7c6a6f4bd4f.1529398335.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] ppc4xx_i2c: Implement directcntl
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


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
> As well as being able to generate its own i2c transactions, the ppc4xx
> i2c controller has a DIRECTCNTL register which allows explicit control
> of the i2c lines.
>=20
> Using this register an OS can directly bitbang i2c operations. In
> order to let emulated i2c devices respond to this, we need to wire up
> the DIRECTCNTL register to qemu's bitbanged i2c handling code.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v4: Updated commit message and use defined constant where
> appropriate

I'm still don't quite understand your approach to the symbolic
constants here, but I don't care enough to hold this up any further.
So, applied to ppc-for-3.0.


>=20
>  default-configs/ppc-softmmu.mak    |  1 +
>  default-configs/ppcemb-softmmu.mak |  1 +
>  hw/i2c/ppc4xx_i2c.c                | 14 +++++++++++++-
>  include/hw/i2c/ppc4xx_i2c.h        |  4 ++++
>  4 files changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index abeeb04..851b4af 100644
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
> index 4e0aaae..fca80d6 100644
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
> @@ -46,6 +47,11 @@
> =20
>  #define IIC_XTCNTLSS_SRST   (1 << 0)
> =20
> +#define IIC_DIRECTCNTL_SDAC (1 << 3)
> +#define IIC_DIRECTCNTL_SCLC (1 << 2)
> +#define IIC_DIRECTCNTL_MSDA (1 << 1)
> +#define IIC_DIRECTCNTL_MSCL (1 << 0)
> +
>  static void ppc4xx_i2c_reset(DeviceState *s)
>  {
>      PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
> @@ -289,7 +295,12 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr a=
ddr, uint64_t value,
>          i2c->xtcntlss =3D value;
>          break;
>      case 16:
> -        i2c->directcntl =3D value & 0x7;
> +        i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNT=
L_SCLC);
> +        i2c->directcntl |=3D (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
> +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL,
> +                        i2c->directcntl & IIC_DIRECTCNTL_MSCL);
> +        i2c->directcntl |=3D bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_S=
DA,
> +                               (value & IIC_DIRECTCNTL_SDAC) !=3D 0) << =
1;
>          break;
>      default:
>          if (addr < PPC4xx_I2C_MEM_SIZE) {
> @@ -322,6 +333,7 @@ static void ppc4xx_i2c_init(Object *o)
>      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
>      sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
>      s->bus =3D i2c_init_bus(DEVICE(s), "i2c");
> +    s->bitbang =3D bitbang_i2c_init(s->bus);
>  }
> =20
>  static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index e4b6ded..ea6c8e1 100644
> --- a/include/hw/i2c/ppc4xx_i2c.h
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -31,6 +31,9 @@
>  #include "hw/sysbus.h"
>  #include "hw/i2c/i2c.h"
> =20
> +/* from hw/i2c/bitbang_i2c.h */
> +typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> +
>  #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
>  #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_=
I2C)
> =20
> @@ -42,6 +45,7 @@ typedef struct PPC4xxI2CState {
>      I2CBus *bus;
>      qemu_irq irq;
>      MemoryRegion iomem;
> +    bitbang_i2c_interface *bitbang;
>      uint8_t mdata;
>      uint8_t lmadr;
>      uint8_t hmadr;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsp5CoACgkQbDjKyiDZ
s5JD6BAAqspmetBpco+7DB2ZOHoa9fF0dGzHs3BbEMekbmqX1g3Oua/Xv/lAF2GE
jeqUlQ8aEm47zyS/r0v5VWr9hV8upgUlKV/IKRueCb2HBgLkw4IgbYTXFEugcj2i
Yqd0v5BlSf2Cx/eUMmmGfyxlg2Ro4oA2Z0cP1XPoB/ISR/YlwG7bIOSaqvJxn5gu
7h7fyHleqXiJHm5L+H0SMRluLhcJfyhfur7yv3Kxz/KjU1KGHwSytsoVGIp1xS3r
vjzKf8e8JGQvVPfhAuyNmwtg4cDlAf5TSR4Y6Kp2AdTj9bmk7IqnUUISF6AHwS/+
+ur6jTMuVVpBZeJnrtQ41DJFr7ZTPyccvt3UG6EVD7VbUbvb0jImObtpugICJ5xB
TrXQORNbZX8b31o5VN8wfv0AKmkk175U/pTothjgavac7i18k+ZH1spmV1RxXn/P
uWA8DWC1jAJVjTb5DoymLppVQjwnWDMoDWheTdFvZ/yR8UiXCyZ4rUsdxAeKGpkg
50/5zWBo52ZwpK1YfZJ2LqvBPCGHEmWlPGuLCNLXe8wpE4/jxpq4DF951DwkJpc0
Xb5Oaz55ioK+rdJAP/0keQOqaC0grmSNm16rwpnZgmjknM+MRGHcolx49uecCL12
t6oHX3kBpKe81HlsIXDTBoCJdmjXPNxhaCNvSO9a6JQd44dL88o=
=tKaG
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
