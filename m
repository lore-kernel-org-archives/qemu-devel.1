Received: from eggs.gnu.org ([2001:4830:134:3::10]:48881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e1MCn-00079O-Ei
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 20:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e1MCm-0007bH-EF
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 20:46:01 -0400
Message-ID: <1507509945.5452.150.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 09 Oct 2017 11:15:45 +1030
In-Reply-To: <20170920070135.31379-5-clg@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-5-clg@kaod.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-7fae1mlNxJg82wabGvuu"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/6] aspeed: Add EEPROM I2C devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--=-7fae1mlNxJg82wabGvuu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-09-20 at 09:01 +0200, C=C3=A9dric Le Goater wrote:
> The Aspeed boards have at least one EEPROM to hold the Vital Product
> Data (VPD).
>=C2=A0
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>=C2=A0
> Changes since v1:
>=C2=A0
> =C2=A0- fixed palmetto EEPROM size
> =C2=A0- used smbus_eeprom_init_one()
>=C2=A0
> hw/arm/aspeed.c | 13 +++++++++++++
> =C2=A01 file changed, 13 insertions(+)
>=C2=A0
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 362b683e9021..462f8008cff5 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -17,6 +17,7 @@
> =C2=A0#include "hw/arm/arm.h"
> =C2=A0#include "hw/arm/aspeed_soc.h"
> =C2=A0#include "hw/boards.h"
> +#include "hw/i2c/smbus.h"
> =C2=A0#include "qemu/log.h"
> =C2=A0#include "sysemu/block-backend.h"
> =C2=A0#include "sysemu/blockdev.h"
> @@ -255,11 +256,15 @@ static void palmetto_bmc_i2c_init(AspeedBoardState =
*bmc)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AspeedSoCState *soc =3D &bmc->soc;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DeviceState *dev;
> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t *eeprom_buf =3D g_malloc0(32 * 1024);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The palmetto platform expects a ds3231 R=
TC but a ds1338 is
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* enough to provide basic RTC feature=
s. Alarms will be missing */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 0), "ds1338", 0x68);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 0), 0x50,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0eeprom_buf);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* add a TMP423 temperature sensor */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev =3D i2c_create_slave(aspeed_i2c_get_bus=
(DEVICE(&soc->i2c), 2),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0"tmp423", 0x4c);
> @@ -297,6 +302,10 @@ static const TypeInfo palmetto_bmc_type =3D {
> =C2=A0static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AspeedSoCState *soc =3D &bmc->soc;
> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t *eeprom_buf =3D g_malloc0(8 * 1024);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 3), 0x50,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0eeprom_buf);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The AST2500 EVB expects a LM75 but a TMP=
105 is compatible */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 7), "tmp105", 0x4d);
> @@ -368,6 +377,7 @@ static const TypeInfo romulus_bmc_type =3D {
> =C2=A0static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AspeedSoCState *soc =3D &bmc->soc;
> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t *eeprom_buf =3D g_malloc0(8 * 1024);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 4), "tmp423", 0x4c);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 5), "tmp423", 0x4c);
> @@ -377,6 +387,9 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState=
 *bmc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The witherspoon board expects Epson RX89=
00 I2C RTC but a ds1338 is
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* good enough */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 11), "ds1338", 0x32);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 11), 0x51,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0eeprom_buf);
> =C2=A0}
> =C2=A0
> =C2=A0static void witherspoon_bmc_init(MachineState *machine)
--=-7fae1mlNxJg82wabGvuu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZ2sa5AAoJEJ0dnzgO5LT5DO4QAIuHGS6YhldhN26HZHf4mogk
GxfdlM26SWTXHj5d3/xKtY1mthOcPJ4RyyPH6V3INB4Ohkyvu4sicKqLhfCptLWE
VTfP+qXl9WH/67J9/Gogr88PxsGeZX0ZxYUQevO9JHs5SIFONWhOITQF42MbEs3/
J2AR2308kVROGOe4Ef1zQNQMf0zv0oHjiOYkuj+zTKTf9u+cJwh/gcjnvUhqQxyn
3yLwhCFK6fwg0C4TMHE1SD/xSJQZncFKyr6VevozsAd48iVyxsTMHw0M6wTs6gX6
wMhh1k5BqCNdkDDYd26TIyYd3F0pBJ5809HsTqLnHP6nLiFxe6vxL31fTHtBKP7G
a8Fb5fOzj2/NT4RTpDTqAxZm5Z4RxDC4nh06+kbmXQwO+4vb+aM014NkE+p6SYjy
uUmX8HiYgiFCWrvmusMwfl7JTuYzW8TO95xRVo9WLX72UH/L1itgjjdC35nCsprb
3udX4OG82mzxg4RKQzUuKAlY8yoOfZb5wr9casFXyQXXAy7/hZp4mvFfrWxuhZjR
tfLvyTDX38GVx98IFbbp9RUPO+4eDU/rsa7kbrwcGdEd3BYJjJIQtQqJaCOTZbJR
QENN2hEYzP4PqW0VO1N1A07QC4ttiwQkX4/oHcy1st2/nEDVpmOvKJ/u+QXyknd7
yW2YMOoBn+AREMP8/lnj
=naae
-----END PGP SIGNATURE-----

--=-7fae1mlNxJg82wabGvuu--
