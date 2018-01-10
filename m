Received: from eggs.gnu.org ([2001:4830:134:3::10]:56632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1eZCt3-0001fT-EF
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1eZCt2-0007cN-IF
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:41:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 10 Jan 2018 10:41:24 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <CAAdtpL7bno=1yrRYK6zt4pgDsa8N-8d291pzX0rhNBVqgkKi4g@mail.gmail.com>
References: <20180103162400.10396-1-f4bug@amsat.org>
	<20180103162400.10396-3-f4bug@amsat.org>
	<60c89dbec86c14e2f0883d121872d0f6@walle.cc>
	<CAAdtpL7bno=1yrRYK6zt4pgDsa8N-8d291pzX0rhNBVqgkKi4g@mail.gmail.com>
Message-ID: <a06fcf38a03e63ffda2baa50f01e0769@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] hw/sd/milkymist-memcard: split
 realize() out of SysBusDevice init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Xiaoqiang Zhao <zxq_yx_007@163.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E .
	Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, philippe.mathieu.daude@gmail.com

Hi Philippe,

Am 2018-01-09 19:16, schrieb Philippe Mathieu-Daud=C3=A9:
> Hi Michael,
>=20
>> Am 2018-01-03 17:23, schrieb Philippe Mathieu-Daud=C3=A9:
>>>=20
>>> Create the SDCard in the realize() function.
>>>=20
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/sd/milkymist-memcard.c | 24 +++++++++++++++---------
>>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>>=20
>>> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
>>> index 5de3e00e2f..5df3a0f815 100644
>>> --- a/hw/sd/milkymist-memcard.c
>>> +++ b/hw/sd/milkymist-memcard.c
>>> @@ -255,24 +255,29 @@ static void milkymist_memcard_reset(DeviceState=
=20
>>> *d)
>>>  static int milkymist_memcard_init(SysBusDevice *dev)
>>>  {
>>>      MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
>>> -    DriveInfo *dinfo;
>>> +
>>> +    memory_region_init_io(&s->regs_region, OBJECT(s),=20
>>> &memcard_mmio_ops,
>>> s,
>>> +            "milkymist-memcard", R_MAX * 4);
>>> +    sysbus_init_mmio(dev, &s->regs_region);
>>> +
>>> +    return 0;
>>> +}
>>=20
>>=20
>> Creating the device (milkymist_memcard_create()) fails with an=20
>> assertion:
>>   sysbus_mmio_map_common: Assertion `n >=3D 0 && n < dev->num_mmio'=20
>> failed.
>=20
> Thanks for trying this.
>=20
> Odd 'make check-qtest-lm32' didn't catch this...
>=20
>> because dev->num_mmio is still 0. Seems that sysbus_init_mmio() hasn't=
=20
>> been
>> called yet. Do we have to move the milkymist_memcard_init() to
>> .instance_init?
>=20
> Your patch seems correct :)
>=20
> Do you have some milky one prebuilt image that I can use for testing?

You can use this one:
   http://milkymist.walle.cc/updates/2012-03-01/flickernoise

http://milkymist.walle.cc/README.qemu

-michael
