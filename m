Received: from eggs.gnu.org ([2001:4830:134:3::10]:43553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebb53-0002wN-48
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebb51-0004R0-Pj
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:55:49 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ebb51-0004QK-DI
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:55:47 -0500
Received: by mail-lf0-x241.google.com with SMTP id a204so11308937lfa.2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 15:55:47 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA-ht8NXMhdXdtnJRQFJSiNH4JRAUdygjdCg+Y=U_8_TuA@mail.gmail.com>
References: <cover.1515796549.git.alistair.francis@xilinx.com>
	<5d3528b2428e0eb4ea7a058fbb12b6b1229a496f.1515796549.git.alistair.francis@xilinx.com>
	<CAFEAcA-ht8NXMhdXdtnJRQFJSiNH4JRAUdygjdCg+Y=U_8_TuA@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 16 Jan 2018 15:55:15 -0800
Message-ID: <CAKmqyKMPbLRCc9FbSJN8kjxAHP=wxXXCY4gLx45=C6MYE=h94Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] xlnx-zynqmp-rtc: Initial commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Mon, Jan 15, 2018 at 5:25 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 12 January 2018 at 22:36, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> Initial commit of the ZynqMP RTC device.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>> V2:
>>  - Delete unused realise function
>>  - Remove DB_PRINT()
>>
>>  hw/timer/Makefile.objs             |   1 +
>>  hw/timer/xlnx-zynqmp-rtc.c         | 218 ++++++++++++++++++++++++++++++=
+++++++
>>  include/hw/timer/xlnx-zynqmp-rtc.h |  84 ++++++++++++++
>>  3 files changed, 303 insertions(+)
>>  create mode 100644 hw/timer/xlnx-zynqmp-rtc.c
>>  create mode 100644 include/hw/timer/xlnx-zynqmp-rtc.h
>>
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index 8c19eac3b6..8b27a4b7ef 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -21,6 +21,7 @@ common-obj-$(CONFIG_IMX) +=3D imx_epit.o
>>  common-obj-$(CONFIG_IMX) +=3D imx_gpt.o
>>  common-obj-$(CONFIG_LM32) +=3D lm32_timer.o
>>  common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.o
>> +common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
>>
>>  obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
>>  obj-$(CONFIG_EXYNOS4) +=3D exynos4210_mct.o
>> diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
>> new file mode 100644
>> index 0000000000..ead40fc42d
>> --- /dev/null
>> +++ b/hw/timer/xlnx-zynqmp-rtc.c
>> @@ -0,0 +1,218 @@
>> +/*
>> + * QEMU model of the Xilinx ZynqMP Real Time Clock (RTC).
>> + *
>> + * Copyright (c) 2017 Xilinx Inc.
>> + *
>> + * Written-by: Alistair Francis <alistair.francis@xilinx.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g a copy
>> + * of this software and associated documentation files (the "Software")=
, to deal
>> + * in the Software without restriction, including without limitation th=
e rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or=
 sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be inclu=
ded in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPR=
ESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SH=
ALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR=
 OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARIS=
ING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALIN=
GS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/register.h"
>> +#include "qemu/bitops.h"
>> +#include "qemu/log.h"
>> +#include "hw/timer/xlnx-zynqmp-rtc.h"
>> +
>> +#ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
>> +#define XLNX_ZYNQMP_RTC_ERR_DEBUG 0
>> +#endif
>
> This #define doesn't seem to be used, or have I missed it?

As Philippe said, it is used in the init() function.

>
>> +
>> +static void rtc_int_update_irq(XlnxZynqMPRTC *s)
>> +{
>> +    bool pending =3D s->regs[R_RTC_INT_STATUS] & ~s->regs[R_RTC_INT_MAS=
K];
>> +    qemu_set_irq(s->irq_rtc_int, pending);
>> +}
>> +
>> +static void addr_error_int_update_irq(XlnxZynqMPRTC *s)
>> +{
>> +    bool pending =3D s->regs[R_ADDR_ERROR] & ~s->regs[R_ADDR_ERROR_INT_=
MASK];
>> +    qemu_set_irq(s->irq_addr_error_int, pending);
>> +}
>> +
>> +static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
>> +{
>> +    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
>> +    rtc_int_update_irq(s);
>> +}
>> +
>> +static uint64_t rtc_int_en_prew(RegisterInfo *reg, uint64_t val64)
>> +{
>> +    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
>> +    uint32_t val =3D val64;
>> +
>> +    s->regs[R_RTC_INT_MASK] &=3D ~val;
>> +    rtc_int_update_irq(s);
>> +    return 0;
>> +}
>
> I have to say I find all this pre-write/post-write stuff confusing
> compared to just having a straightforward pair of read and write function=
s
> for the device. Why do we update the interrupt state in a post-write
> for the status register but a pre-write for the int_en register ?

There isn't really a specific reason, I think this is just how it was
auto generated. Would you prefer them all to be post write?

>
>
>
>> +static void rtc_reset(DeviceState *dev)
>> +{
>> +    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(dev);
>> +    unsigned int i;
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(s->regs_info); ++i) {
>> +        register_reset(&s->regs_info[i]);
>> +    }
>> +
>> +    rtc_int_update_irq(s);
>> +    addr_error_int_update_irq(s);
>> +}
>
> Updating irq lines in reset functions is a bit dubious.
> (We really should figure out how to do that properly some day.)

Is there a better way though?

>
>> This email and any attachments are intended for the sole use of the name=
d recipient(s) and contain(s) confidential information that may be propriet=
ary, privileged or copyrighted under applicable law. If you are not the int=
ended recipient, do not read, copy, or forward this email message or any at=
tachments. Delete this email message and any attachments immediately.
>
>
> You probably don't really mean this :-)  Can you fix your email
> config for sending patch mails, please?

Yeah, apparently they re-enabled this. I'll work on getting it
disabled again. Thanks for pointing it out.

Alistair

>
> thanks
> -- PMM
