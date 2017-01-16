Received: from eggs.gnu.org ([2001:4830:134:3::10]:43090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTBjc-00063L-NU
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTBjX-0004N5-OZ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:10:24 -0500
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:36095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cTBjX-0004Mw-IF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:10:19 -0500
Received: from player760.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 447256CD8A
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 19:10:18 +0100 (CET)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-9-git-send-email-clg@kaod.org>
	<7df52dde-e4b2-23de-47e7-2e97d5eab4e4@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f4be1b72-eb3e-b91a-16c7-1f7a82fdfb91@kaod.org>
Date: Mon, 16 Jan 2017 19:10:06 +0100
MIME-Version: 1.0
In-Reply-To: <7df52dde-e4b2-23de-47e7-2e97d5eab4e4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/11] aspeed/smc: reset flash after
 each test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcin Krzeminski <marcin.krzeminski@nokia.com>

On 01/16/2017 06:37 PM, mar.krzeminski wrote:
>=20
>=20
> W dniu 09.01.2017 o 17:24, C=C3=A9dric Le Goater pisze:
>> Let's make sure when each test is run that the flash object is in an
>> initial state and did not keep configuration from the previous tests.
> Is there any particukar reason why you do that (bug/side effect/whateve=
r) or you
> just want to be sure what the flash state is?

I want to be sure it is not in 4BYTE mode.

C.=20

>=20
> Thanks,
> Marcin
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>   tests/m25p80-test.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/tests/m25p80-test.c b/tests/m25p80-test.c
>> index cb7ec81f1a6d..8dd550deb95e 100644
>> --- a/tests/m25p80-test.c
>> +++ b/tests/m25p80-test.c
>> @@ -50,6 +50,8 @@ enum {
>>       READ =3D 0x03,
>>       PP =3D 0x02,
>>       WREN =3D 0x6,
>> +    RESET_ENABLE =3D 0x66,
>> +    RESET_MEMORY =3D 0x99,
>>       EN_4BYTE_ADDR =3D 0xB7,
>>       ERASE_SECTOR =3D 0xd8,
>>   };
>> @@ -76,6 +78,14 @@ static void spi_conf(uint32_t value)
>>       writel(ASPEED_FMC_BASE + R_CONF, conf);
>>   }
>>   +static void spi_conf_remove(uint32_t value)
>> +{
>> +    uint32_t conf =3D readl(ASPEED_FMC_BASE + R_CONF);
>> +
>> +    conf &=3D ~value;
>> +    writel(ASPEED_FMC_BASE + R_CONF, conf);
>> +}
>> +
>>   static void spi_ctrl_start_user(void)
>>   {
>>       uint32_t ctrl =3D readl(ASPEED_FMC_BASE + R_CTRL0);
>> @@ -95,6 +105,18 @@ static void spi_ctrl_stop_user(void)
>>       writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
>>   }
>>   +static void flash_reset(void)
>> +{
>> +    spi_conf(CONF_ENABLE_W0);
>> +
>> +    spi_ctrl_start_user();
>> +    writeb(ASPEED_FLASH_BASE, RESET_ENABLE);
>> +    writeb(ASPEED_FLASH_BASE, RESET_MEMORY);
>> +    spi_ctrl_stop_user();
>> +
>> +    spi_conf_remove(CONF_ENABLE_W0);
>> +}
>> +
>>   static void test_read_jedec(void)
>>   {
>>       uint32_t jedec =3D 0x0;
>> @@ -108,6 +130,8 @@ static void test_read_jedec(void)
>>       jedec |=3D readb(ASPEED_FLASH_BASE);
>>       spi_ctrl_stop_user();
>>   +    flash_reset();
>> +
>>       g_assert_cmphex(jedec, =3D=3D, FLASH_JEDEC);
>>   }
>>   @@ -155,6 +179,8 @@ static void test_erase_sector(void)
>>       for (i =3D 0; i < PAGE_SIZE / 4; i++) {
>>           g_assert_cmphex(page[i], =3D=3D, 0xffffffff);
>>       }
>> +
>> +    flash_reset();
>>   }
>>     static void test_erase_all(void)
>> @@ -182,6 +208,8 @@ static void test_erase_all(void)
>>       for (i =3D 0; i < PAGE_SIZE / 4; i++) {
>>           g_assert_cmphex(page[i], =3D=3D, 0xffffffff);
>>       }
>> +
>> +    flash_reset();
>>   }
>>     static void test_write_page(void)
>> @@ -195,6 +223,7 @@ static void test_write_page(void)
>>         spi_ctrl_start_user();
>>       writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
>> +    writeb(ASPEED_FLASH_BASE, WREN);
>>       writeb(ASPEED_FLASH_BASE, PP);
>>       writel(ASPEED_FLASH_BASE, make_be32(my_page_addr));
>>   @@ -215,6 +244,8 @@ static void test_write_page(void)
>>       for (i =3D 0; i < PAGE_SIZE / 4; i++) {
>>           g_assert_cmphex(page[i], =3D=3D, 0xffffffff);
>>       }
>> +
>> +    flash_reset();
>>   }
>>     static char tmp_path[] =3D "/tmp/qtest.m25p80.XXXXXX";
>=20
