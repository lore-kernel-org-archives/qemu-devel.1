Received: from eggs.gnu.org ([209.51.188.92]:50212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEbfr-00037D-8n
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEbfn-0002xX-Od
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:31:34 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:36381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEbfm-0002tO-C5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:31:30 -0400
Received: from player711.ha.ovh.net (unknown [10.109.146.1])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id E1FEF4E6B0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 17:31:26 +0200 (CEST)
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-3-joel@jms.id.au>
	<CAFEAcA9G9Xrt5nDRJrSCC1SdeR987YzK+etRLTSyokLE+yyJSw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <feaa1cc3-6bc1-555b-15e1-9c485c0157cb@kaod.org>
Date: Thu, 11 Apr 2019 17:31:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9G9Xrt5nDRJrSCC1SdeR987YzK+etRLTSyokLE+yyJSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/aspeed: Add RTC to SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4/11/19 5:28 PM, Peter Maydell wrote:
> On Thu, 28 Mar 2019 at 06:22, Joel Stanley <joel@jms.id.au> wrote:
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/arm/aspeed_soc.c         | 15 +++++++++++++++
>>  include/hw/arm/aspeed_soc.h |  2 ++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index a27233d4876b..628ec633c91a 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -32,6 +32,7 @@
>>  #define ASPEED_SOC_SDMC_BASE        0x1E6E0000
>>  #define ASPEED_SOC_SCU_BASE         0x1E6E2000
>>  #define ASPEED_SOC_SRAM_BASE        0x1E720000
>> +#define ASPEED_SOC_RTC_BASE         0x1E781000
>>  #define ASPEED_SOC_TIMER_BASE       0x1E782000
>>  #define ASPEED_SOC_WDT_BASE         0x1E785000
>>  #define ASPEED_SOC_I2C_BASE         0x1E78A000
>> @@ -135,6 +136,10 @@ static void aspeed_soc_init(Object *obj)
>>      object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
>>      qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
>>
>> +    object_initialize(&s->rtc, sizeof(s->rtc), TYPE_ASPEED_RTC);
>> +    object_property_add_child(obj, "rtc", OBJECT(&s->rtc), NULL);
>> +    qdev_set_parent_bus(DEVICE(&s->rtc), sysbus_get_default());
>=20
> These three lines should be written
>        sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
>                              TYPE_ASPEED_RTC);
>=20
> which is both shorter and also avoids leaking a reference to
> the child object.
>=20
> (We should also at some point fix the existing uses of this
> pattern in this file.)

yes. and there are a few. I will do that.

Thanks,=20

C.=20
