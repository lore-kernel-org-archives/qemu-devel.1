Received: from eggs.gnu.org ([2001:4830:134:3::10]:59790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1cgfsr-000055-Ax
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1cgfsq-0007XT-GS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:59:41 -0500
References: <20170222112338.25492-1-clement.deschamps@antfield.fr>
	<20170222112338.25492-4-clement.deschamps@antfield.fr>
	<DM5PR03MB2827C1EEB91C11DEF0FBE9D89E500@DM5PR03MB2827.namprd03.prod.outlook.com>
From: Clement Deschamps <clement.deschamps@antfield.fr>
Message-ID: <fd715c76-862b-2f05-bef7-bdc73275070d@antfield.fr>
Date: Wed, 22 Feb 2017 23:59:37 +0100
MIME-Version: 1.0
In-Reply-To: <DM5PR03MB2827C1EEB91C11DEF0FBE9D89E500@DM5PR03MB2827.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] bcm2835: add sdhost and gpio
 controllers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

Hello,


On 02/22/2017 07:27 PM, Andrew Baumann wrote:
> Hi,
>
>> From: Clement Deschamps [mailto:clement.deschamps@antfield.fr]
>> Sent: Wednesday, 22 February 2017 3:24
>> Subject: [PATCH v2 3/3] bcm2835: add sdhost and gpio controllers
>>
>> This adds the bcm2835_sdhost and bcm2835_gpio to the BCM2835 platform.=

>>
>> The bcm2835_gpio has a link to both the sdhci and sdhost controllers f=
or
>> supporting the alternate function of GPIOs 48-53 (SD controller select=
ion)
>>
>> Signed-off-by: Clement Deschamps <clement.deschamps@antfield.fr>
> [...]
>> +    /* SDHOST */
>> +    object_property_set_bool(OBJECT(&s->sdhost), true, "realized", &e=
rr);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +
>> +    memory_region_add_subregion(&s->peri_mr, MMCI0_OFFSET,
>> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sdhost), 0)=
);
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhost), 0,
>> +        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
>> +                               INTERRUPT_SDIO));
>> +    object_property_add_alias(OBJECT(s), "sd-bus-2", OBJECT(&s->sdhos=
t),
>> +                              "sd-bus", &err);
> Is this alias still meaningful / needed, or is it a relic from the prev=
ious version? Right now it doesn't appear to be used, and I'm thinking th=
at if someone did try to use it (e.g. at the board level by connecting an=
 SD card) then the new GPIO logic would allow swapping the two SD cards b=
etween the two controllers, which doesn't sound like a faithful recreatio=
n of the hardware.
>
> Otherwise,
> Reviewed-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
>
> Cheers,
> Andrew

Thank you Andrew for your review.

You're right, we don't need to expose anymore the sdbus of the sdhost.
We can remove this alias.


Peter, do you agree with the sdcard reparenting function I implemented
in the GPIO controller (following your advices) ?


Best,
Cl=E9ment
