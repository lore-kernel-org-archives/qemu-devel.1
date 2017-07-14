Received: from eggs.gnu.org ([2001:4830:134:3::10]:48329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW38Z-000257-NZ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW38Y-0001PO-NQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:08:15 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW38Y-0001Oy-GX
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:08:14 -0400
Received: by mail-wr0-x233.google.com with SMTP id v60so3316268wrc.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:08:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgnruibx.fsf@linaro.org>
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
	<1500029487-14822-4-git-send-email-peter.maydell@linaro.org>
	<87lgnruibx.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 17:07:52 +0100
Message-ID: <CAFEAcA--sxG2rOdeTvD=uNsOj=RFW8wFVALSaE1QU92Xzow1wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 3/9] hw/arm/mps2: Add UARTs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>

On 14 July 2017 at 16:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Add the UARTs to the MPS2 board models.
>>
>> Unfortunately the details of the wiring of the interrupts through
>> various OR gates differ between AN511 and AN385 so this can't
>> be purely a data-driven difference.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>  hw/arm/mps2.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 86 insertions(+)
>>
>> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
>> index 3dad02d..180c5d2 100644
>> --- a/hw/arm/mps2.c
>> +++ b/hw/arm/mps2.c
>> @@ -27,9 +27,12 @@
>>  #include "qemu/error-report.h"
>>  #include "hw/arm/arm.h"
>>  #include "hw/arm/armv7m.h"
>> +#include "hw/or-irq.h"
>>  #include "hw/boards.h"
>>  #include "exec/address-spaces.h"
>> +#include "sysemu/sysemu.h"
>>  #include "hw/misc/unimp.h"
>> +#include "hw/char/cmsdk-apb-uart.h"
>>
>>  typedef enum MPS2FPGAType {
>>      FPGA_AN385,
>> @@ -206,6 +209,89 @@ static void mps2_common_init(MachineState *machine)
>>      create_unimplemented_device("Ethernet", 0x40200000, 0x00100000);
>>      create_unimplemented_device("VGA", 0x41000000, 0x0200000);
>>
>> +    switch (mmc->fpga_type) {
>> +    case FPGA_AN385:
>> +    {
>> +        /* The overflow IRQs for UARTs 0, 1 and 2 are ORed together.
>> +         * Overflow for UARTs 4 and 5 doesn't trigger any interrupt.
>> +         */
>> +        Object *orgate;
>> +        DeviceState *orgate_dev;
>> +        int i;
>> +
>> +        orgate =3D object_new(TYPE_OR_IRQ);
>> +        object_property_set_int(orgate, 6, "num-lines", &error_fatal);
>> +        object_property_set_bool(orgate, true, "realized", &error_fatal=
);
>> +        orgate_dev =3D DEVICE(orgate);
>> +        qdev_connect_gpio_out(orgate_dev, 0, qdev_get_gpio_in(armv7m, 1=
2));
>> +
>> +        for (i =3D 0; i < 5; i++) {
>> +            hwaddr uartbase[] =3D {0x40004000, 0x40005000, 0x40006000,
>> +                                 0x40007000, 0x40009000};
>
> I would expect these to be something like:
>
>   static hwaddr an385_uartbase[] =3D {0x40004000, 0x40005000, 0x40006000,
>                                     0x40007000, 0x40009000};
>   static hwaddr an511_uartbase[] =3D {0x40004000, 0x40005000, 0x4002c000,
>                                     0x4002d000, 0x4002e000};
>
> to save the compiler from filling in the table every loop. Not that it
> makes much different for an init routine.

I'm slightly surprised the compiler can't tell that these
are never written and emit the same code for all of them,
but yeah, let's just 'static const' all of them.

thanks
-- PMM
