Received: from eggs.gnu.org ([2001:4830:134:3::10]:40172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duHr6-0005vT-DM
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duHr0-0005Wp-M1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:42:24 -0400
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:35687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duHr0-0005Vu-FU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:42:18 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id E844A1595E1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:42:16 +0200 (CEST)
References: <20170919112645.8574-1-clg@kaod.org>
	<20170919112645.8574-4-clg@kaod.org>
	<472ff629-39bd-9fe2-c1f8-a08ba6997b53@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f510d607-b328-90e6-3727-c6f554864e2f@kaod.org>
Date: Tue, 19 Sep 2017 14:42:08 +0200
MIME-Version: 1.0
In-Reply-To: <472ff629-39bd-9fe2-c1f8-a08ba6997b53@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] aspeed: Add EEPROM I2C devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>

On 09/19/2017 02:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi C=C3=A9dric,
>=20
> On 09/19/2017 08:26 AM, C=C3=A9dric Le Goater wrote:
>> The Aspeed boards have at least one EEPROM to hold the Vital Product
>> Data (VPD).
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>> =C2=A0 hw/arm/aspeed.c | 20 ++++++++++++++++++++
>> =C2=A0 1 file changed, 20 insertions(+)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 362b683e9021..3e74970d7ad2 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -251,6 +251,17 @@ static void aspeed_board_init(MachineState *machi=
ne,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm_load_kernel(ARM_CPU(first_cpu), &as=
peed_board_binfo);
>> =C2=A0 }
>> =C2=A0 +static void aspeed_i2c_add_eeprom(I2CBus *bus, uint8_t address=
, size_t size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 uint8_t *eeprom_buf =3D g_malloc0(size);
>> +=C2=A0=C2=A0=C2=A0 DeviceState *dev;
>> +
>> +=C2=A0=C2=A0=C2=A0 dev =3D qdev_create((BusState *) bus, "smbus-eepro=
m");
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint8(dev, "address", address);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_ptr(dev, "data", eeprom_buf);
>> +=C2=A0=C2=A0=C2=A0 qdev_init_nofail(dev);
>=20
> Can you merge this with smbus_eeprom_init() ?
> I think the cleaner way would be add "include/hw/i2c/eeprom.h" defining=
 SMB_EEPROM_TYPE "smbus-eeprom" and declare smbus_eeprom_init() there or =
as inlined.

yes. That would remove some duplicated code.

I will wait for some feedback before doing a resend or a followup.

Thanks,

C.


>=20
>> +}
>> +
>> =C2=A0 static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedSoCState *soc =3D &bmc->soc;
>> @@ -260,6 +271,9 @@ static void palmetto_bmc_i2c_init(AspeedBoardState=
 *bmc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * enough to provide basic RTC fea=
tures. Alarms will be missing */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c_create_slave(aspeed_i2c_get_bus(DEV=
ICE(&soc->i2c), 0), "ds1338", 0x68);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 aspeed_i2c_add_eeprom(aspeed_i2c_get_bus(DE=
VICE(&soc->i2c), 0), 0x50,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 256 * 1024);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* add a TMP423 temperature sensor */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D i2c_create_slave(aspeed_i2c_get=
_bus(DEVICE(&soc->i2c), 2),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "tmp423", 0x4c);
>> @@ -298,6 +312,9 @@ static void ast2500_evb_i2c_init(AspeedBoardState =
*bmc)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedSoCState *soc =3D &bmc->soc;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 aspeed_i2c_add_eeprom(aspeed_i2c_get_bus(DE=
VICE(&soc->i2c), 3), 0x50,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 8 * 1024);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The AST2500 EVB expects a LM75 but a=
 TMP105 is compatible */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c_create_slave(aspeed_i2c_get_bus(DEV=
ICE(&soc->i2c), 7), "tmp105", 0x4d);
>> =C2=A0 @@ -377,6 +394,9 @@ static void witherspoon_bmc_i2c_init(Aspeed=
BoardState *bmc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The witherspoon board expects Epson =
RX8900 I2C RTC but a ds1338 is
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * good enough */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c_create_slave(aspeed_i2c_get_bus(DEV=
ICE(&soc->i2c), 11), "ds1338", 0x32);
>> +
>> +=C2=A0=C2=A0=C2=A0 aspeed_i2c_add_eeprom(aspeed_i2c_get_bus(DEVICE(&s=
oc->i2c), 11), 0x51,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 8 * 1024);
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void witherspoon_bmc_init(MachineState *machine)
>>
