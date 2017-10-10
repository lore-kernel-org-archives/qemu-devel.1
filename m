Received: from eggs.gnu.org ([2001:4830:134:3::10]:58589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1ucN-0007Kj-P3
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1ucI-0008OR-RW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:30:43 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:50102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e1ucI-0008NR-Hk
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:30:38 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 69EB75A455
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 15:30:30 +0200 (CEST)
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-2-clg@kaod.org>
	<1507507449.5452.147.camel@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <48144f71-c876-0e89-f01e-cbfe87687aee@kaod.org>
Date: Tue, 10 Oct 2017 15:30:22 +0200
MIME-Version: 1.0
In-Reply-To: <1507507449.5452.147.camel@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] aspeed: add support for the
 witherspoon-bmc board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/09/2017 02:04 AM, Andrew Jeffery wrote:
> On Wed, 2017-09-20 at 09:01 +0200, C=C3=A9dric Le Goater wrote:
>> The Witherspoon boards are OpenPOWER system hosting POWER9 Processors.
>> Let's add support for their BMC including a couple of I2C devices as
>> found on real HW.
>> =C2=A0
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>> =C2=A0hw/arm/aspeed.c | 49 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>> =C2=A01 file changed, 49 insertions(+)
>> =C2=A0
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index ab895ad490af..81f522f711ae 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -46,6 +46,7 @@ enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PALMETTO_BMC,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AST2500_EVB,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ROMULUS_BMC,
>> +=C2=A0=C2=A0=C2=A0=C2=A0WITHERSPOON_BMC,
>> =C2=A0};
>> =C2=A0
>> =C2=A0/* Palmetto hardware value: 0x120CE416 */
>> @@ -83,8 +84,12 @@ enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCU_AST2500_HW_S=
TRAP_ACPI_ENABLE |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCU_HW_STRAP_SPI=
_MODE(SCU_HW_STRAP_SPI_MASTER))
>> =C2=A0
>> +/* Witherspoon hardware value: 0xF10AD216 (but use romulus definition=
) */
>> +#define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
>> +
>> =C2=A0static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
>> =C2=A0static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
>> +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc);
>> =C2=A0
>> =C2=A0static const AspeedBoardConfig aspeed_boards[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[PALMETTO_BMC] =3D {
>> @@ -110,6 +115,14 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.spi_model =3D "=
mx66l1g45g",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_cs=C2=A0=C2=
=A0=C2=A0=C2=A0=3D 2,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
>> +=C2=A0=C2=A0=C2=A0=C2=A0[WITHERSPOON_BMC]=C2=A0=C2=A0=3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.soc_name=C2=A0=C2=A0=
=3D "ast2500-a1",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hw_strap1 =3D WITHER=
SPOON_BMC_HW_STRAP1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.fmc_model =3D "mx25l=
25635e",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.spi_model =3D "mx66l=
1g45g",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_cs=C2=A0=C2=A0=C2=
=A0=C2=A0=3D 2,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.i2c_init=C2=A0=C2=A0=
=3D witherspoon_bmc_i2c_init,
>> +=C2=A0=C2=A0=C2=A0=C2=A0},
>> =C2=A0};
>> =C2=A0
>> =C2=A0#define FIRMWARE_ADDR 0x0
>> @@ -337,11 +350,47 @@ static const TypeInfo romulus_bmc_type =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.class_init =3D romulus_bmc_class_init,
>> =C2=A0};
>> =C2=A0
>> +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0AspeedSoCState *soc =3D &bmc->soc;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&s=
oc->i2c), 4), "tmp423", 0x4c);
>> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&s=
oc->i2c), 5), "tmp423", 0x4c);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&s=
oc->i2c), 9), "tmp105", 0x4a);
>=20
> Looks like I need to track down newer versions of the schematics I have=
.

the device on the board is a tmp275 but the tmp105 model is compatible.=20


>> +}
>> +
>> +static void witherspoon_bmc_init(MachineState *machine)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0aspeed_board_init(machine, &aspeed_boards[WIT=
HERSPOON_BMC]);
>> +}
>> +
>> +static void witherspoon_bmc_class_init(ObjectClass *oc, void *data)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0MachineClass *mc =3D MACHINE_CLASS(oc);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0mc->desc =3D "OpenPOWER Witherspoon BMC (ARM1=
176)";
>> +=C2=A0=C2=A0=C2=A0=C2=A0mc->init =3D witherspoon_bmc_init;
>> +=C2=A0=C2=A0=C2=A0=C2=A0mc->max_cpus =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0mc->no_sdcard =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0mc->no_floppy =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0mc->no_cdrom =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0mc->no_parallel =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0mc->ignore_memory_transaction_failures =3D tr=
ue;
>=20
> Aside from the issue with the above as pointed out by Peter,
>=20
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Thanks,

C.=20

>=20
>> +}
>> +
>> +static const TypeInfo witherspoon_bmc_type =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0.name =3D MACHINE_TYPE_NAME("witherspoon-bmc"=
),
>> +=C2=A0=C2=A0=C2=A0=C2=A0.parent =3D TYPE_MACHINE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0.class_init =3D witherspoon_bmc_class_init,
>> +};
>> +
>> =C2=A0static void aspeed_machine_init(void)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0type_register_static(&palmetto_bmc_type)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0type_register_static(&ast2500_evb_type);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0type_register_static(&romulus_bmc_type);
>> +=C2=A0=C2=A0=C2=A0=C2=A0type_register_static(&witherspoon_bmc_type);
>> =C2=A0}
>> =C2=A0
>> =C2=A0type_init(aspeed_machine_init)
