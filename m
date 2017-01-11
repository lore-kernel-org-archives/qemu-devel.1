Received: from eggs.gnu.org ([2001:4830:134:3::10]:36090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cRO3L-00022t-0O
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cRO3H-0002UG-TU
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:55:19 -0500
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:42206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cRO3H-0002SL-Mi
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:55:15 -0500
Received: from player688.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 63D46648FA
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 19:55:12 +0100 (CET)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-12-git-send-email-clg@kaod.org>
	<b5660d74-0c16-871b-bec0-31a5a6e19f04@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9b1c1700-04cc-9b1e-6fdc-5ac84e5cd42e@kaod.org>
Date: Wed, 11 Jan 2017 19:55:08 +0100
MIME-Version: 1.0
In-Reply-To: <b5660d74-0c16-871b-bec0-31a5a6e19f04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/11] aspeed/smc: handle dummy bytes
 when doing fast reads in command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 01/11/2017 07:20 PM, mar.krzeminski wrote:
> W dniu 09.01.2017 o 17:24, C=C3=A9dric Le Goater pisze:
>> When doing fast read, a certain amount of dummy bytes should be sent
>> before the read. This number is configurable in the controler CE0
>> Control Register and needs to be modeled using fake transfers the
>> flash module.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>> ---
>>  hw/ssi/aspeed_smc.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>>  Changes since v1:
>>
>>  - splitted user mode from command mode support.
>>
>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>> index 28d563a5800f..7a76d3344df2 100644
>> --- a/hw/ssi/aspeed_smc.c
>> +++ b/hw/ssi/aspeed_smc.c
>> @@ -69,7 +69,9 @@
>>  #define R_CTRL0           (0x10 / 4)
>>  #define   CTRL_CMD_SHIFT           16
>>  #define   CTRL_CMD_MASK            0xff
>> +#define   CTRL_DUMMY_HIGH_SHIFT    14
>>  #define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
>> +#define   CTRL_DUMMY_LOW_SHIFT     6 /* 2 bits [7:6] */
>>  #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
>>  #define   CTRL_CMD_MODE_MASK       0x3
>>  #define     CTRL_READMODE          0x0
>> @@ -141,6 +143,7 @@
>> =20
>>  /* Flash opcodes. */
>>  #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) =
*/
>> +#define SPI_OP_READ_FAST  0x0b    /* Read data bytes (high frequency)=
 */
>> =20
>>  /*
>>   * Default segments mapping addresses and size for each slave per
>> @@ -490,10 +493,21 @@ static uint32_t aspeed_smc_check_segment_addr(co=
nst AspeedSMCFlash *fl,
>>      return addr;
>>  }
>> =20
>> +static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
>> +{
>> +    const AspeedSMCState *s =3D fl->controller;
>> +    uint32_t r_ctrl0 =3D s->regs[s->r_ctrl0 + fl->id];
>> +    uint32_t dummy_high =3D (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
>> +    uint32_t dummy_low =3D (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
>> +
>> +    return ((dummy_high << 2) | dummy_low) * 8;
>> +}
>> +
>>  static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t a=
ddr)
>>  {
>>      const AspeedSMCState *s =3D fl->controller;
>>      uint8_t cmd =3D aspeed_smc_flash_cmd(fl);
>> +    int i;
>> =20
>>      /* Flash access can not exceed CS segment */
>>      addr =3D aspeed_smc_check_segment_addr(fl, addr);
>> @@ -506,6 +520,13 @@ static void aspeed_smc_flash_send_addr(AspeedSMCF=
lash *fl, uint32_t addr)
>>      ssi_transfer(s->spi, (addr >> 16) & 0xff);
>>      ssi_transfer(s->spi, (addr >> 8) & 0xff);
>>      ssi_transfer(s->spi, (addr & 0xff));
>> +
>> +    /* Handle dummies in case of fast read */
>> +    if (cmd =3D=3D SPI_OP_READ_FAST) {
> I feel this is wrong. It indicates that the controller knows FAST_READ =
op code.

you are right. I should not be testing the SPI OP command code=20
but the controller mode :

	CTRL_FREADMODE

> I believe controller always try to send dummy cycles, and do not do thi=
s when
> their count is set to 0 (so you do not need above if).

Indeed. I will check If I can just drop the test then.=20

Thanks,

C.=20

> Thanks,
> Marcin
>> +        for (i =3D 0; i < aspeed_smc_flash_dummies(fl); i++) {
>> +            ssi_transfer(fl->controller->spi, 0xFF);
>> +        }
>> +    }
>>  }
>> =20
>>  static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsi=
gned size)
>=20
