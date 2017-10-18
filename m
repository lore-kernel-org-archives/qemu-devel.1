Received: from eggs.gnu.org ([2001:4830:134:3::10]:36754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e4pGq-0005h4-Ss
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e4pGl-0007hW-80
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:24:32 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:37066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e4pGk-0007fZ-Us
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:24:27 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id CC78AB831B
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 16:24:22 +0200 (CEST)
References: <20171013142852.916-1-clg@kaod.org>
	<20171013142852.916-6-clg@kaod.org>
	<CAFEAcA-Xwz1nrdkvMhK7+uJNpYssvC_juYF6mEviAo_T6ujF7Q@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4ed34c63-6a56-8569-b40a-5f34ad8a9c8e@kaod.org>
Date: Wed, 18 Oct 2017 16:24:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Xwz1nrdkvMhK7+uJNpYssvC_juYF6mEviAo_T6ujF7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/6] misc: add pca9552 LED blinker model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/17/2017 07:13 PM, Peter Maydell wrote:
> On 13 October 2017 at 15:28, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>> Specs are available here :
>>
>>   https://www.nxp.com/docs/en/data-sheet/PCA9552.pdf
>>
>> This is a simple model supporting the basic registers for led and GPIO
>> mode. The device also supports two blinking rates but not the model
>> yet.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Changes since v2:
>>
>>  - removed comments on the I2C buffer size, but kept the array. I did
>>    not want to rewrite the buffer handling
>>
>>  default-configs/arm-softmmu.mak |   1 +
>>  hw/misc/Makefile.objs           |   1 +
>>  hw/misc/pca9552.c               | 212 +++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/misc/pca9552.h       |  32 ++++++
>>  4 files changed, 246 insertions(+)
>>  create mode 100644 hw/misc/pca9552.c
>>  create mode 100644 include/hw/misc/pca9552.h
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak
>> index 5059d134c816..d868d1095a6c 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -16,6 +16,7 @@ CONFIG_TSC2005=3Dy
>>  CONFIG_LM832X=3Dy
>>  CONFIG_TMP105=3Dy
>>  CONFIG_TMP421=3Dy
>> +CONFIG_PCA9552=3Dy
>>  CONFIG_STELLARIS=3Dy
>>  CONFIG_STELLARIS_INPUT=3Dy
>>  CONFIG_STELLARIS_ENET=3Dy
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index e8f0a02f35af..e4e22880dbbc 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -7,6 +7,7 @@ common-obj-$(CONFIG_SGA) +=3D sga.o
>>  common-obj-$(CONFIG_ISA_TESTDEV) +=3D pc-testdev.o
>>  common-obj-$(CONFIG_PCI_TESTDEV) +=3D pci-testdev.o
>>  common-obj-$(CONFIG_EDU) +=3D edu.o
>> +common-obj-$(CONFIG_PCA9552) +=3D pca9552.o
>>
>>  common-obj-y +=3D unimp.o
>>
>> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
>> new file mode 100644
>> index 000000000000..22460f4c14fe
>> --- /dev/null
>> +++ b/hw/misc/pca9552.c
>> @@ -0,0 +1,212 @@
>> +/*
>> + * PCA9552 I2C LED blinker
>> + *
>> + * Copyright (c) 2017, IBM Corporation.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> + * later. See the COPYING file in the top-level directory.
>=20
> Adding the url of the datasheet in the header comment
> would also be useful.

yes.


>=20
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "hw/hw.h"
>> +#include "hw/misc/pca9552.h"
>> +
>> +#define PCA9552_INPUT0   0 /* read only input register 0 */
>> +#define PCA9552_INPUT1   1 /* read only input register 1  */
>> +#define PCA9552_PSC0     2 /* read/write frequency prescaler 0 */
>> +#define PCA9552_PWM0     3 /* read/write PWM register 0 */
>> +#define PCA9552_PSC1     4 /* read/write frequency prescaler 1 */
>> +#define PCA9552_PWM1     5 /* read/write PWM register 1 */
>> +#define PCA9552_LS0      6 /* read/write LED0 to LED3 selector */
>> +#define PCA9552_LS1      7 /* read/write LED4 to LED7 selector */
>> +#define PCA9552_LS2      8 /* read/write LED8 to LED11 selector */
>> +#define PCA9552_LS3      9 /* read/write LED12 to LED15 selector */
>> +
>> +#define PCA9552_LED_ON   0x0
>> +#define PCA9552_LED_OFF  0x1
>> +#define PCA9552_LED_PWM0 0x2
>> +#define PCA9552_LED_PWM1 0x3
>> +
>> +static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
>> +{
>> +    uint8_t reg   =3D PCA9552_LS0 + (pin / 4);
>> +    uint8_t shift =3D (pin % 4) << 1;
>> +
>> +    return (s->regs[reg] >> shift) & 0x3;
>=20
> extract32() is probably more readable than handcoded
> shift-and-mask.
>=20

ok


>> +}
>> +
>> +static void pca9552_update_pin_input(PCA9552State *s)
>> +{
>> +    int i;
>> +
>> +    for (i =3D 0; i < 16; i++) {
>> +        uint8_t input_reg =3D PCA9552_INPUT0 + (i / 8);
>> +        uint8_t input_shift =3D (i % 8);
>> +        uint8_t config =3D pca9552_pin_get_config(s, i);
>> +
>> +        switch (config) {
>> +        case PCA9552_LED_ON:
>> +            s->regs[input_reg] |=3D 1 << input_shift;
>> +            break;
>> +        case PCA9552_LED_OFF:
>> +            s->regs[input_reg] &=3D ~(1 << input_shift);
>> +            break;
>> +        case PCA9552_LED_PWM0:
>> +        case PCA9552_LED_PWM1:
>> +            /* ??? */
>> +        default:
>> +            break;
>> +        }
>> +    }
>> +}
>> +
>> +static void pca9552_read(PCA9552State *s)
>> +{
>> +    uint8_t reg =3D s->pointer & 0xf;
>> +
>> +    s->len =3D 0;
>> +
>> +    switch (reg) {
>> +    case PCA9552_INPUT0:
>> +    case PCA9552_INPUT1:
>> +    case PCA9552_PSC0:
>> +    case PCA9552_PWM0:
>> +    case PCA9552_PSC1:
>> +    case PCA9552_PWM1:
>> +    case PCA9552_LS0:
>> +    case PCA9552_LS1:
>> +    case PCA9552_LS2:
>> +    case PCA9552_LS3:
>> +        s->buf[s->len++] =3D s->regs[reg];
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected read to regist=
er %d\n",
>> +                      __func__, reg);
>> +    }
>> +}
>> +
>> +static void pca9552_write(PCA9552State *s)
>> +{
>> +    uint8_t reg =3D s->pointer & 0xf;
>> +
>> +    switch (reg) {
>> +    case PCA9552_PSC0:
>> +    case PCA9552_PWM0:
>> +    case PCA9552_PSC1:
>> +    case PCA9552_PWM1:
>> +        s->regs[reg] =3D s->buf[0];
>> +        break;
>> +
>> +    case PCA9552_LS0:
>> +    case PCA9552_LS1:
>> +    case PCA9552_LS2:
>> +    case PCA9552_LS3:
>> +        s->regs[reg] =3D s->buf[0];
>> +        pca9552_update_pin_input(s);
>> +        break;
>> +
>> +    case PCA9552_INPUT0:
>> +    case PCA9552_INPUT1:
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected write to regis=
ter %d\n",
>> +                      __func__, reg);
>> +    }
>> +}
>> +
>> +static int pca9552_recv(I2CSlave *i2c)
>> +{
>> +    PCA9552State *s =3D PCA9552(i2c);
>> +
>> +    if (s->len < sizeof(s->buf)) {
>> +        return s->buf[s->len++];
>> +    } else {
>> +        return 0xff;
>> +    }
>> +}
>> +
>> +static int pca9552_send(I2CSlave *i2c, uint8_t data)
>> +{
>> +    PCA9552State *s =3D PCA9552(i2c);
>> +
>> +    if (s->len =3D=3D 0) {
>> +        s->pointer =3D data;
>> +        s->len++;
>> +    } else {
>> +        if (s->len <=3D sizeof(s->buf)) {
>> +            s->buf[s->len - 1] =3D data;
>> +        }
>> +        s->len++;
>> +        pca9552_write(s);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int pca9552_event(I2CSlave *i2c, enum i2c_event event)
>> +{
>> +    PCA9552State *s =3D PCA9552(i2c);
>> +
>> +    if (event =3D=3D I2C_START_RECV) {
>> +        pca9552_read(s);
>> +    }
>> +
>> +    s->len =3D 0;
>> +    return 0;
>> +}
>=20
> Reading the data sheet, it doesn't look like this is
> correctly implementing reads and writes of more than one byte.
> If you look at figures 11, 12 and 13 the guest can:
>  * read or write multiple registers at once with a
>    single transaction with multiple bytes, using the
>    autoincrement (AI) bit in the command byte
>  * read or writes multiple bytes of data from a port
>    configured for GPIO with a single transaction
>    (in this case AI would be clear)

I completely overlooked the AI support but it does not=20
seem too complex to implement.

> There's a clearer description in the application note:
> https://www.nxp.com/docs/en/application-note/AN264.pdf
> (on page 12).

This is a much better document than the one I had found ...

> I think to implement this you don't need buf[] at all
> (and len is only there to distinguish "first byte" from
> "not first byte").
>=20
> Rather than calling pca9552_read() from pca9552_event()
> you should call it from pca9552_recv(), which means that
> it gets called for each byte requested and you don't
> need to stuff the value into buf[] and then fish it
> back out again.
>=20
> Similarly, rather than pca9552_send() writing the data
> into s->buf[] and then pca9552_write() fishing it out,
> you can just pass it directly to pca9552_write().

Yes. These are all good cleanups. I suspect other I2C models
would also benefit from your suggestions. I will take a look
later on.

> In both cases you want to implement the "increment
> pointer as required if AI bit is set" so multibyte
> transfers step through the register set, rolling over
> from 9 to 0.

I will send an updated version with AI support in the next=20
round.=20

> I don't think the Linux driver bothers to use this, but it's
> worth getting it right from the start because it affects how
> we represent the device state and thus migration compat.

yes.

>> +static const VMStateDescription pca9552_vmstate =3D {
>> +    .name =3D "PCA9552",
>> +    .version_id =3D 0,
>> +    .minimum_version_id =3D 0,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_UINT8(len, PCA9552State),
>> +        VMSTATE_UINT8(pointer, PCA9552State),
>> +        VMSTATE_UINT8_ARRAY(buf, PCA9552State, 1),
>> +        VMSTATE_UINT8_ARRAY(regs, PCA9552State, PCA9552_NR_REGS),
>> +        VMSTATE_I2C_SLAVE(i2c, PCA9552State),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void pca9552_reset(DeviceState *dev)
>> +{
>> +    PCA9552State *s =3D PCA9552(dev);
>> +
>> +    s->regs[PCA9552_PSC0] =3D 0xFF;
>> +    s->regs[PCA9552_PWM0] =3D 0x80;
>> +    s->regs[PCA9552_PSC1] =3D 0xFF;
>> +    s->regs[PCA9552_PWM1] =3D 0x80;
>> +    s->regs[PCA9552_LS0] =3D 0x55; /* all OFF */
>> +    s->regs[PCA9552_LS1] =3D 0x55;
>> +    s->regs[PCA9552_LS2] =3D 0x55;
>> +    s->regs[PCA9552_LS3] =3D 0x55;
>> +
>> +    pca9552_update_pin_input(s);
>=20
> Don't we also need to reset the pointer and len fields?
>=20

yes. indeed.

Thanks,

C.=20


> thanks
> -- PMM
>=20
