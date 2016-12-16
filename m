Received: from eggs.gnu.org ([2001:4830:134:3::10]:53405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cHywT-0006oD-GK
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 15:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cHywS-0005Kz-Lk
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 15:17:21 -0500
References: <20161215054812.12602-1-alastair@au1.ibm.com>
	<20161215054812.12602-2-alastair@au1.ibm.com>
	<CAFEAcA9RpMAHTrPb2GNQYh+P-svcpHB90h0qcs27CUBDyY1=Ng@mail.gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <f85d31c0-8cc2-611d-0058-2db4d0d8e943@tribudubois.net>
Date: Fri, 16 Dec 2016 21:17:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9RpMAHTrPb2GNQYh+P-svcpHB90h0qcs27CUBDyY1=Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/8] arm: Uniquely name imx25 I2C buses.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alastair D'Silva <alastair@au1.ibm.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

Le 16/12/2016 à 14:03, Peter Maydell a écrit :
> On 15 December 2016 at 05:48, Alastair D'Silva <alastair@au1.ibm.com> wrote:
>> From: Alastair D'Silva <alastair@d-silva.org>
>>
>> The imx25 chip provides 3 i2c buses, but they have all been named
>> "i2c", which makes it difficult to predict which bus a device will
>> be connected to when specified on the command line.
>>
>> This patch addresses the issue by naming the buses uniquely:
>>    i2c-bus.0 i2c-bus.1 i2c-bus.2
>>
>> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
>> ---
>>   hw/arm/imx25_pdk.c | 2 +-
>>   hw/i2c/imx_i2c.c   | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
>> index 025b608..44e741f 100644
>> --- a/hw/arm/imx25_pdk.c
>> +++ b/hw/arm/imx25_pdk.c
>> @@ -139,7 +139,7 @@ static void imx25_pdk_init(MachineState *machine)
>>            * of simple qtest. See "make check" for details.
>>            */
>>           i2c_create_slave((I2CBus *)qdev_get_child_bus(DEVICE(&s->soc.i2c[0]),
>> -                                                      "i2c"),
>> +                                                      "i2c-bus.0"),
>>                            "ds1338", 0x68);
>>       }
>>   }
>> diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
>> index 37e5a62..6c81b98 100644
>> --- a/hw/i2c/imx_i2c.c
>> +++ b/hw/i2c/imx_i2c.c
>> @@ -310,7 +310,7 @@ static void imx_i2c_realize(DeviceState *dev, Error **errp)
>>                             IMX_I2C_MEM_SIZE);
>>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>>       sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>> -    s->bus = i2c_init_bus(DEVICE(dev), "i2c");
>> +    s->bus = i2c_init_bus(DEVICE(dev), NULL);
>>   }
>>
>>   static void imx_i2c_class_init(ObjectClass *klass, void *data)
> This change looks OK to me, but it is an incompatible change to the
> command line (albeit only one where you couldn't have reliably
> used the command line to start with), so I'm just cc'ing
> Jean-Christophe Dubois, who's been active with the iMX code in the
> past, for a second opinion.

This change seems fine to me too.

JC

>
> We should flag this up in 2.9's Changelog as well.
>
> thanks
> -- PMM
>
