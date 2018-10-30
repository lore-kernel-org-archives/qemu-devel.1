Received: from eggs.gnu.org ([2001:4830:134:3::10]:35010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHTMA-0004EJ-JB
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHTM7-00036C-Bz
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:42:50 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHTM6-0002gQ-U7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:42:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id k9so10881301otl.10
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 05:42:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f2832be6-83ab-83ac-2063-13bf0b556d80@redhat.com>
References: <20181029232100.8454-1-philmd@redhat.com>
	<20181029232100.8454-3-philmd@redhat.com>
	<CAFEAcA_yde+Ppuqet7KFE-AvZrjnrfYeY=R1aWD86cox+WYsxg@mail.gmail.com>
	<f2832be6-83ab-83ac-2063-13bf0b556d80@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 12:42:06 +0000
Message-ID: <CAFEAcA_6mDdxVU_TY583uOTgAX_eT-s52QRCDWTd0_uCrUTwhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/dma/pl330: Factor out pl330_init()
 from hw/arm/xilinx_zynq.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 30 October 2018 at 11:28, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> On 30/10/18 10:36, Peter Maydell wrote:
>>
>> On 29 October 2018 at 23:20, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
>> wrote:
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>   MAINTAINERS            |  1 +
>>>   hw/arm/xilinx_zynq.c   | 18 ++----------------
>>>   hw/dma/pl330.c         |  2 +-
>>>   include/hw/dma/pl330.h | 41 +++++++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 45 insertions(+), 17 deletions(-)
>>>   create mode 100644 include/hw/dma/pl330.h
>>
>>
>>> +static inline void pl330_init(uint32_t base, qemu_irq irq, int nreq)
>>> +{
>>> +    SysBusDevice *busdev;
>>> +    DeviceState *dev;
>>> +
>>> +    dev =3D qdev_create(NULL, TYPE_PL330);
>>> +    qdev_prop_set_uint8(dev, "num_chnls", 8);
>>> +    qdev_prop_set_uint8(dev, "num_periph_req", nreq);
>>> +    qdev_prop_set_uint8(dev, "num_events", 16);
>>> +    qdev_prop_set_uint8(dev, "data_width", 64);
>>> +    qdev_prop_set_uint8(dev, "wr_cap", 8);
>>> +    qdev_prop_set_uint8(dev, "wr_q_dep", 16);
>>> +    qdev_prop_set_uint8(dev, "rd_cap", 8);
>>> +    qdev_prop_set_uint8(dev, "rd_q_dep", 16);
>>> +    qdev_prop_set_uint16(dev, "data_buffer_dep", 256);
>>> +    qdev_init_nofail(dev);
>>
>>
>> These are the settings the Xilinx board uses, but are
>> they really the settings every SoC that has a PL330 will use ?
>
>
> Except "num_periph_req", all are pl330_properties defaults.

If they're all the device's defaults there's not much point
in setting them by hand. But my point is that the reason they're
properties is that in the real hardware these are configurable
values in the RTL. So any given SoC model needs to be able to
set them appropriately. Having a helper function that doesn't
let you set them makes it too easy for people modelling SoCs
not to think about the question, I think...

thanks
-- PMM
