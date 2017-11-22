Received: from eggs.gnu.org ([2001:4830:134:3::10]:55957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbjS-0005j7-Co
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbjR-0002Aa-Et
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:34:54 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8CLwzHj9-n+OJKB4GTn1u3D_4secBV_CGdFkR383EAOg@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-11-andrew.smirnov@gmail.com>
	<CAFEAcA8CLwzHj9-n+OJKB4GTn1u3D_4secBV_CGdFkR383EAOg@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 22 Nov 2017 12:34:49 -0800
Message-ID: <CAHQ1cqHe8yXt2Df_Z0fJ8W5z0_ckt7TvSU4T57y+q+bLh-R2rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/30] imx_fec: Reserve full 4K page for
 the register file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Nov 21, 2017 at 9:48 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
>> Some i.MX SoCs (e.g. i.MX7) have FEC registers going as far as offset
>> 0x614, so to avoid getting aborts when accessing those on QEMU, extend
>> the register file to cover 4KB of address space instead of just 1K.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  hw/net/imx_fec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
>> index 48d012cad6..e236bc933c 100644
>> --- a/hw/net/imx_fec.c
>> +++ b/hw/net/imx_fec.c
>> @@ -1252,7 +1252,7 @@ static void imx_eth_realize(DeviceState *dev, Erro=
r **errp)
>>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>>
>>      memory_region_init_io(&s->iomem, OBJECT(dev), &imx_eth_ops, s,
>> -                          TYPE_IMX_FEC, 0x400);
>> +                          TYPE_IMX_FEC, 0x1000);
>>      sysbus_init_mmio(sbd, &s->iomem);
>>      sysbus_init_irq(sbd, &s->irq[0]);
>>      sysbus_init_irq(sbd, &s->irq[1]);
>> --
>
> I notice that we have an unused #define FSL_IMX25_FEC_SIZE 0x4000 in
> fsl-imx25.h, and the Linux device trees for the imx25 define the size
> of the FEC register block as 0x4000. Should this be 0x4000 ?
>

I think the size reserved for that register file differs between
differen SoC. E.g. it's 16K on i.MX25, as you pointed out, but 64K on
i.MX7. It's all the same to me as long as it's greater than 0x1000.
I'll change the code to use FSL_IMX25_FEC_SIZE since it gets rid of a
magic number.

Thanks,
Andrey Smirnov
