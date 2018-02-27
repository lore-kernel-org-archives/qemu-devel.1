Received: from eggs.gnu.org ([2001:4830:134:3::10]:35375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqol5-00083q-IR
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqol4-0007uO-Ib
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:34:07 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180227104903.21353-1-linus.walleij@linaro.org>
	<20180227104903.21353-6-linus.walleij@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c1560ce5-4f72-a269-c9dc-334b0ec8d4a5@amsat.org>
Date: Tue, 27 Feb 2018 20:34:00 -0300
MIME-Version: 1.0
In-Reply-To: <20180227104903.21353-6-linus.walleij@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="oOak90MGJvmXcSh9bsIZ44wEsPxbETNIe"
Subject: Re: [Qemu-devel] [PATCH 5/5] arm/vexpress: Add proper display
 connector emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Corey Minyard <cminyard@mvista.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oOak90MGJvmXcSh9bsIZ44wEsPxbETNIe
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Linus Walleij <linus.walleij@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Corey Minyard <cminyard@mvista.com>
Message-ID: <c1560ce5-4f72-a269-c9dc-334b0ec8d4a5@amsat.org>
Subject: Re: [PATCH 5/5] arm/vexpress: Add proper display connector emulation
References: <20180227104903.21353-1-linus.walleij@linaro.org>
 <20180227104903.21353-6-linus.walleij@linaro.org>
In-Reply-To: <20180227104903.21353-6-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2018 07:49 AM, Linus Walleij wrote:
> This adds the SiI9022 and EDID I2C devices to the ARM Versatile
> Express machine, and selects the two I2C devices necessary in the
> arm-softmmy.mak configuration so everything will build smoothly.
>=20
> I am implementing proper handling of the graphics in the Linux
> kernel and adding proper emulation of SiI9022 and EDID makes the
> driver probe as nicely as before, retrieveing the resolutions
> supported by the "QEMU monitor" and overall just working nice.
>=20
> The assignment of the SiI9022 at address 0x39 and the EDID
> DDC I2C at address 0x50 is not strictly correct: the DDC I2C
> is there all the time but in the actual component it only
> appears once activated inside the SiI9022, so ideally it should
> be added and removed to the bus by the SiI9022. However for this
> purpose it works fine to just have it around.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
> ChangeLog v1->v2:
> - Only add the SII9022 now that it will by itself realize
>   the DDCI2C as part of the bridge.
> ---
>  default-configs/arm-softmmu.mak | 2 ++
>  hw/arm/vexpress.c               | 6 +++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-soft=
mmu.mak
> index ca34cf446242..54f855d07206 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -21,6 +21,8 @@ CONFIG_STELLARIS_INPUT=3Dy
>  CONFIG_STELLARIS_ENET=3Dy
>  CONFIG_SSD0303=3Dy
>  CONFIG_SSD0323=3Dy
> +CONFIG_DDC=3Dy
> +CONFIG_SII9022=3Dy
>  CONFIG_ADS7846=3Dy
>  CONFIG_MAX111X=3Dy
>  CONFIG_SSI=3Dy
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index dc5928ae1ab5..9fad79177a19 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -29,6 +29,7 @@
>  #include "hw/arm/arm.h"
>  #include "hw/arm/primecell.h"
>  #include "hw/devices.h"
> +#include "hw/i2c/i2c.h"
>  #include "net/net.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/boards.h"
> @@ -537,6 +538,7 @@ static void vexpress_common_init(MachineState *mach=
ine)
>      uint32_t sys_id;
>      DriveInfo *dinfo;
>      pflash_t *pflash0;
> +    I2CBus *i2c;
>      ram_addr_t vram_size, sram_size;
>      MemoryRegion *sysmem =3D get_system_memory();
>      MemoryRegion *vram =3D g_new(MemoryRegion, 1);
> @@ -628,7 +630,9 @@ static void vexpress_common_init(MachineState *mach=
ine)
>      sysbus_create_simple("sp804", map[VE_TIMER01], pic[2]);
>      sysbus_create_simple("sp804", map[VE_TIMER23], pic[3]);
> =20
> -    /* VE_SERIALDVI: not modelled */
> +    dev =3D sysbus_create_simple("versatile_i2c", map[VE_SERIALDVI], N=
ULL);
> +    i2c =3D (I2CBus *)qdev_get_child_bus(dev, "i2c");
> +    i2c_create_slave(i2c, "sii9022", 0x39);
> =20
>      sysbus_create_simple("pl031", map[VE_RTC], pic[4]); /* RTC */
> =20
>=20


--oOak90MGJvmXcSh9bsIZ44wEsPxbETNIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlqV6ugACgkQ4+MsLN6t
wN6ilw/8DxII22zYaJoVMwzHddUYGFbr5GIILQMu4c2rZFOJbcbA7JdeJD0Ck4vf
X8ESlMdOtZJb+wwnLSRnuOuH+vRgKRyNGNlOMwZ62YMwzYu62qe6vMgvl8e8N/9f
jyV3HAWJQ1ZTNxYLwzzIOpWq9A0nzlLEztjKtrW3M0lRxG1cAo4Yfh5cNBullkyO
eGy3xq1ro5D/S8So57sWVIkDmddE49xcr70aP1NJZwaV6cMGXvKfTFxR32ue5Blh
9pm936t1XM87P2pMfNtH3ao0ygQsDJiFZGOMKtL+xbY1q/HUse+JcsudEVTK7blR
Oa0SiJPk2tbyTK75BwODmH3j8XbMkYCPJ96yaHHcsufj33k9uYzawzrkKHkHENXy
Z+TjNbhC+ECF0PIMROCGFAisf2zqAvYIurastuVeNR5FbJMe5Dx9CmbAoU8hLPL7
pHweadwXZVGgx/WySeTlECYukY4184AMC/5OQ9sT7iei0cFrEgK82x0F8zhE4hto
tY7dTIg82mvIBD5zamZ8WPIygSxYW7nB9JFBDNAMoAv1erRDT3QRqBTTCY6xq8z8
/0t8yL7TsF3466qLJg/cJBxgpXIC86aUuH3ereX+J5va4pgZ9KD1XL8/MN3C8XRg
PVe8MOH0WenOND2a/X9xZNPL2tzbRJc7YX4QJEQKra0G+bVKb78=
=qSw4
-----END PGP SIGNATURE-----

--oOak90MGJvmXcSh9bsIZ44wEsPxbETNIe--
