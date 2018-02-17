Received: from eggs.gnu.org ([2001:4830:134:3::10]:42406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1en7Hx-0008D2-A1
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1en7Hv-00062Y-Tm
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:32:45 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180217140051.22731-1-linus.walleij@linaro.org>
	<20180217140051.22731-2-linus.walleij@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eff4f015-38ad-60e1-e1de-886bb4f93328@amsat.org>
Date: Sat, 17 Feb 2018 15:32:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180217140051.22731-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/3] hw/sii9022: Add support for
 Silicon Image SII9022
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Hi Linus,

On 02/17/2018 11:00 AM, Linus Walleij wrote:
> This adds support for emulating the Silicon Image SII9022 DVI/HDMI
> bridge. It's not very clever right now, it just acknowledges
> the switch into DDC I2C mode and back. Combining this with the
> existing DDC I2C emulation gives the right behavior on the Versatile
> Express emulation passing through the QEMU EDID to the emulated
> platform.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  hw/display/Makefile.objs |   1 +
>  hw/display/sii9022.c     | 185 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+)
>  create mode 100644 hw/display/sii9022.c
> 
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index d3a4cb396eb9..3c7c75b94da5 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -3,6 +3,7 @@ common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
>  common-obj-$(CONFIG_G364FB) += g364fb.o
>  common-obj-$(CONFIG_JAZZ_LED) += jazz_led.o
>  common-obj-$(CONFIG_PL110) += pl110.o
> +common-obj-$(CONFIG_SII9022) += sii9022.o
>  common-obj-$(CONFIG_SSD0303) += ssd0303.o
>  common-obj-$(CONFIG_SSD0323) += ssd0323.o
>  common-obj-$(CONFIG_XEN) += xenfb.o
> diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
> new file mode 100644
> index 000000000000..d6f3cdc04293
> --- /dev/null
> +++ b/hw/display/sii9022.c
> @@ -0,0 +1,185 @@
> +/*
> + * Silicon Image SiI9022
> + *
> + * This is a pretty hollow emulation: all we do is acknowledge that we
> + * exist (chip ID) and confirm that we get switched over into DDC mode
> + * so the emulated host can proceed to read out EDID data. All subsequent
> + * set-up of connectors etc will be acknowledged and ignored.
> + *
> + * Copyright (c) 2018 Linus Walleij
> + *
> + * This code is licensed under the GNU GPL v2.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "hw/i2c/i2c.h"
> +
> +#define DEBUG_SII9022 0
> +
> +#define DPRINTF(fmt, ...) \
> +    do { \
> +        if (DEBUG_SII9022) { \
> +            printf("sii9022: " fmt, ## __VA_ARGS__); \
> +        } \
> +    } while (0)

Can you replace DPRINTF() by trace events?

Except that, patch looks fine.

Regards,

Phil.

> +
> +#define SII9022_SYS_CTRL_DATA 0x1a
> +#define SII9022_SYS_CTRL_PWR_DWN 0x10
> +#define SII9022_SYS_CTRL_AV_MUTE 0x08
> +#define SII9022_SYS_CTRL_DDC_BUS_REQ 0x04
> +#define SII9022_SYS_CTRL_DDC_BUS_GRTD 0x02
> +#define SII9022_SYS_CTRL_OUTPUT_MODE 0x01
> +#define SII9022_SYS_CTRL_OUTPUT_HDMI 1
> +#define SII9022_SYS_CTRL_OUTPUT_DVI 0
> +#define SII9022_REG_CHIPID 0x1b
> +#define SII9022_INT_ENABLE 0x3c
> +#define SII9022_INT_STATUS 0x3d
> +#define SII9022_INT_STATUS_HOTPLUG 0x01;
> +#define SII9022_INT_STATUS_PLUGGED 0x04;
> +
> +#define TYPE_SII9022 "sii9022"
> +#define SII9022(obj) OBJECT_CHECK(sii9022_state, (obj), TYPE_SII9022)
> +
> +typedef struct sii9022_state {
> +    I2CSlave parent_obj;
> +    uint8_t ptr;
> +    bool addr_byte;
> +    bool ddc_req;
> +    bool ddc_skip_finish;
> +    bool ddc;
> +} sii9022_state;
> +
> +static const VMStateDescription vmstate_sii9022 = {
> +    .name = "sii9022",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_I2C_SLAVE(parent_obj, sii9022_state),
> +        VMSTATE_UINT8(ptr, sii9022_state),
> +        VMSTATE_BOOL(addr_byte, sii9022_state),
> +        VMSTATE_BOOL(ddc_req, sii9022_state),
> +        VMSTATE_BOOL(ddc_skip_finish, sii9022_state),
> +        VMSTATE_BOOL(ddc, sii9022_state),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int sii9022_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    sii9022_state *s = SII9022(i2c);
> +
> +    switch (event) {
> +    case I2C_START_SEND:
> +        s->addr_byte = true;
> +        break;
> +    case I2C_START_RECV:
> +        break;
> +    case I2C_FINISH:
> +        break;
> +    case I2C_NACK:
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
> +static int sii9022_rx(I2CSlave *i2c)
> +{
> +    sii9022_state *s = SII9022(i2c);
> +    uint8_t res = 0x00;
> +
> +    switch (s->ptr) {
> +    case SII9022_SYS_CTRL_DATA:
> +        if (s->ddc_req) {
> +            /* Acknowledge DDC bus request */
> +            res = SII9022_SYS_CTRL_DDC_BUS_GRTD | SII9022_SYS_CTRL_DDC_BUS_REQ;
> +        }
> +        break;
> +    case SII9022_REG_CHIPID:
> +        res = 0xb0;
> +        break;
> +    case SII9022_INT_STATUS:
> +        /* Something is cold-plugged in, no interrupts */
> +        res = SII9022_INT_STATUS_PLUGGED;
> +        break;
> +    default:
> +        break;
> +    }
> +    DPRINTF("%02x read from %02x\n", res, s->ptr);
> +    s->ptr++;
> +
> +    return res;
> +}
> +
> +static int sii9022_tx(I2CSlave *i2c, uint8_t data)
> +{
> +    sii9022_state *s = SII9022(i2c);
> +
> +    if (s->addr_byte) {
> +        s->ptr = data;
> +        s->addr_byte = false;
> +        return 0;
> +    }
> +
> +    switch (s->ptr) {
> +    case SII9022_SYS_CTRL_DATA:
> +        if (data & SII9022_SYS_CTRL_DDC_BUS_REQ) {
> +            s->ddc_req = true;
> +            if (data & SII9022_SYS_CTRL_DDC_BUS_GRTD) {
> +                s->ddc = true;
> +                /* Skip this finish since we just switched to DDC */
> +                s->ddc_skip_finish = true;
> +                DPRINTF("switched to DDC mode\n");
> +            }
> +        } else {
> +            s->ddc_req = false;
> +            s->ddc = false;
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    DPRINTF("%02x written to %02x\n", data, s->ptr);
> +    s->ptr++;
> +
> +    return 0;
> +}
> +
> +static void sii9022_reset(DeviceState *dev)
> +{
> +    sii9022_state *s = SII9022(dev);
> +
> +    s->ptr = 0;
> +    s->addr_byte = false;
> +}
> +
> +static void sii9022_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +
> +    k->event = sii9022_event;
> +    k->recv = sii9022_rx;
> +    k->send = sii9022_tx;
> +    dc->reset = sii9022_reset;
> +    dc->vmsd = &vmstate_sii9022;
> +}
> +
> +static const TypeInfo sii9022_info = {
> +    .name          = TYPE_SII9022,
> +    .parent        = TYPE_I2C_SLAVE,
> +    .instance_size = sizeof(sii9022_state),
> +    .class_init    = sii9022_class_init,
> +};
> +
> +static void sii9022_register_types(void)
> +{
> +    type_register_static(&sii9022_info);
> +}
> +
> +type_init(sii9022_register_types)
> 
