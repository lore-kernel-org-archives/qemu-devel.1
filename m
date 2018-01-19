Received: from eggs.gnu.org ([2001:4830:134:3::10]:36364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecfRX-0007bY-DW
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecfRV-0008OJ-Mg
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:47:27 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:38695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ecfRV-0008La-BY
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:47:25 -0500
Received: by mail-lf0-x241.google.com with SMTP id g72so3879489lfg.5
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 14:47:25 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1aa0e97b-d3f7-6d91-1b43-25ccac8ddae4@amsat.org>
References: <cover.1516386853.git.alistair.francis@xilinx.com>
	<9915a5663505d53a142c263b471142af29d2d7d8.1516386853.git.alistair.francis@xilinx.com>
	<1aa0e97b-d3f7-6d91-1b43-25ccac8ddae4@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 19 Jan 2018 14:46:53 -0800
Message-ID: <CAKmqyKM4k-yj_EwDDLds3L+BPcv7ykWczmceScr3H2SMY+ah5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] xlnx-zynqmp-rtc: Initial commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>

On Fri, Jan 19, 2018 at 11:22 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Hi Alistair,
>
> On 01/19/2018 03:35 PM, Alistair Francis wrote:
>> Initial commit of the ZynqMP RTC device.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>> V2:
>>  - Delete unused realise function
>>  - Remove DB_PRINT()
>>
>>  include/hw/timer/xlnx-zynqmp-rtc.h |  84 ++++++++++++++
>>  hw/timer/xlnx-zynqmp-rtc.c         | 218 ++++++++++++++++++++++++++++++=
+++++++
>>  hw/timer/Makefile.objs             |   1 +
>>  3 files changed, 303 insertions(+)
>>  create mode 100644 include/hw/timer/xlnx-zynqmp-rtc.h
>>  create mode 100644 hw/timer/xlnx-zynqmp-rtc.c
>>
>> diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-=
zynqmp-rtc.h
>> new file mode 100644
>> index 0000000000..87649836cc
>> --- /dev/null
>> +++ b/include/hw/timer/xlnx-zynqmp-rtc.h
>> @@ -0,0 +1,84 @@
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
>> +#include "hw/register.h"
>> +
>> +#define TYPE_XLNX_ZYNQMP_RTC "xlnx-zynmp.rtc"
>> +
>> +#define XLNX_ZYNQMP_RTC(obj) \
>> +     OBJECT_CHECK(XlnxZynqMPRTC, (obj), TYPE_XLNX_ZYNQMP_RTC)
>> +
>> +REG32(SET_TIME_WRITE, 0x0)
>> +REG32(SET_TIME_READ, 0x4)
>> +REG32(CALIB_WRITE, 0x8)
>> +    FIELD(CALIB_WRITE, FRACTION_EN, 20, 1)
>> +    FIELD(CALIB_WRITE, FRACTION_DATA, 16, 4)
>> +    FIELD(CALIB_WRITE, MAX_TICK, 0, 16)
>> +REG32(CALIB_READ, 0xc)
>> +    FIELD(CALIB_READ, FRACTION_EN, 20, 1)
>> +    FIELD(CALIB_READ, FRACTION_DATA, 16, 4)
>> +    FIELD(CALIB_READ, MAX_TICK, 0, 16)
>> +REG32(CURRENT_TIME, 0x10)
>> +REG32(CURRENT_TICK, 0x14)
>> +    FIELD(CURRENT_TICK, VALUE, 0, 16)
>> +REG32(ALARM, 0x18)
>> +REG32(RTC_INT_STATUS, 0x20)
>> +    FIELD(RTC_INT_STATUS, ALARM, 1, 1)
>> +    FIELD(RTC_INT_STATUS, SECONDS, 0, 1)
>> +REG32(RTC_INT_MASK, 0x24)
>> +    FIELD(RTC_INT_MASK, ALARM, 1, 1)
>> +    FIELD(RTC_INT_MASK, SECONDS, 0, 1)
>> +REG32(RTC_INT_EN, 0x28)
>> +    FIELD(RTC_INT_EN, ALARM, 1, 1)
>> +    FIELD(RTC_INT_EN, SECONDS, 0, 1)
>> +REG32(RTC_INT_DIS, 0x2c)
>> +    FIELD(RTC_INT_DIS, ALARM, 1, 1)
>> +    FIELD(RTC_INT_DIS, SECONDS, 0, 1)
>> +REG32(ADDR_ERROR, 0x30)
>> +    FIELD(ADDR_ERROR, STATUS, 0, 1)
>> +REG32(ADDR_ERROR_INT_MASK, 0x34)
>> +    FIELD(ADDR_ERROR_INT_MASK, MASK, 0, 1)
>> +REG32(ADDR_ERROR_INT_EN, 0x38)
>> +    FIELD(ADDR_ERROR_INT_EN, MASK, 0, 1)
>> +REG32(ADDR_ERROR_INT_DIS, 0x3c)
>> +    FIELD(ADDR_ERROR_INT_DIS, MASK, 0, 1)
>> +REG32(CONTROL, 0x40)
>> +    FIELD(CONTROL, BATTERY_DISABLE, 31, 1)
>> +    FIELD(CONTROL, OSC_CNTRL, 24, 4)
>> +    FIELD(CONTROL, SLVERR_ENABLE, 0, 1)
>> +REG32(SAFETY_CHK, 0x50)
>> +
>> +#define XLNX_ZYNQMP_RTC_R_MAX (R_SAFETY_CHK + 1)
>> +
>> +typedef struct XlnxZynqMPRTC {
>> +    SysBusDevice parent_obj;
>> +    MemoryRegion iomem;
>> +    qemu_irq irq_rtc_int;
>> +    qemu_irq irq_addr_error_int;
>> +
>> +    uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
>> +    RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
>> +} XlnxZynqMPRTC;
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
>
> Why is this intermediate variable necessary?
>
>> +
>> +    s->regs[R_RTC_INT_MASK] &=3D ~val;
>> +    rtc_int_update_irq(s);
>> +    return 0;
>> +}
>> +
>> +static uint64_t rtc_int_dis_prew(RegisterInfo *reg, uint64_t val64)
>> +{
>> +    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
>> +    uint32_t val =3D val64;
>
> ditto,
>
>> +
>> +    s->regs[R_RTC_INT_MASK] |=3D val;
>> +    rtc_int_update_irq(s);
>> +    return 0;
>> +}
>> +
>> +static void addr_error_postw(RegisterInfo *reg, uint64_t val64)
>> +{
>> +    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
>> +    addr_error_int_update_irq(s);
>> +}
>> +
>> +static uint64_t addr_error_int_en_prew(RegisterInfo *reg, uint64_t val6=
4)
>> +{
>> +    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
>> +    uint32_t val =3D val64;
>
> ditto,
>
>> +
>> +    s->regs[R_ADDR_ERROR_INT_MASK] &=3D ~val;
>> +    addr_error_int_update_irq(s);
>> +    return 0;
>> +}
>> +
>> +static uint64_t addr_error_int_dis_prew(RegisterInfo *reg, uint64_t val=
64)
>> +{
>> +    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
>> +    uint32_t val =3D val64;
>
> ditto.
>
> I find this clearer to review:
>
>        s->regs[R_ADDR_ERROR_INT_MASK] |=3D (uint32_t)val64;

Fixed!

Alistair

>
> Anyway:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
