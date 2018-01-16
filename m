Received: from eggs.gnu.org ([2001:4830:134:3::10]:41936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ebGP4-0000WN-F4
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 20:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ebGP3-0004yc-79
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 20:51:06 -0500
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOV7kYBTDmjLaFTtKAF7KyZQ56F2LiwE5D+Hzzh9nvmxA@mail.gmail.com>
References: <20171214151934.3647-1-andrew.smirnov@gmail.com>
	<CAKmqyKOV7kYBTDmjLaFTtKAF7KyZQ56F2LiwE5D+Hzzh9nvmxA@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 15 Jan 2018 17:51:03 -0800
Message-ID: <CAHQ1cqFhHRVNOT4Fo+AbF9CXYn77Npy2g6hzWJ+Lh90aRxT=0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/misc: Add code to emulate Xilinx Slave
 Serial port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Dec 19, 2017 at 4:48 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Thu, Dec 14, 2017 at 7:19 AM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>> Add code to emulate Xilinx Slave Serial FPGA configuration port.
>>
>> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
>> Cc: Alistair Francis <alistair.francis@xilinx.com>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Hey,
>
> Thanks for the patch!
>
> I have some comments inline, if anything is unclear just email me back
> and I can provide more information or help.
>
>> ---
>>
>> Integrating this into a build system via "obj-y" might not be the best
>> way. Does this code need a dedicated CONFIG_ symbol?
>
> You probably don't need a specific one, there are already some Xilinx
> ones in there you can use.
>
> Maybe CONFIG_XILINX or CONFIG_XILINX_AXI
>

OK, will do if I ever re-spin this patch

>>
>> Thanks,
>> Andrey Smirnov
>>
>>
>>  hw/misc/Makefile.objs                 |   1 +
>>  hw/misc/xilinx_slave_serial.c         | 105 ++++++++++++++++++++++++++++++++++
>>  include/hw/misc/xilinx_slave_serial.h |  21 +++++++
>>  3 files changed, 127 insertions(+)
>>  create mode 100644 hw/misc/xilinx_slave_serial.c
>>  create mode 100644 include/hw/misc/xilinx_slave_serial.h
>
> You will need to connect this to a machine as well.
>
>>
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index a68a201083..4599288e55 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -38,6 +38,7 @@ obj-$(CONFIG_IMX) += imx7_ccm.o
>>  obj-$(CONFIG_IMX) += imx2_wdt.o
>>  obj-$(CONFIG_IMX) += imx7_snvs.o
>>  obj-$(CONFIG_IMX) += imx7_gpr.o
>> +obj-y += xilinx_slave_serial.o
>>  obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
>>  obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
>>  obj-$(CONFIG_MAINSTONE) += mst_fpga.o
>> diff --git a/hw/misc/xilinx_slave_serial.c b/hw/misc/xilinx_slave_serial.c
>> new file mode 100644
>> index 0000000000..607674fb60
>> --- /dev/null
>> +++ b/hw/misc/xilinx_slave_serial.c
>> @@ -0,0 +1,105 @@
>> +/*
>> + * Copyright (c) 2017, Impinj, Inc.
>> + *
>> + * Code to emulate programming "port" of Xilinx FPGA in Slave Serial
>> + * configuration connected via SPI, for more deatils see (p. 27):
>> + *
>> + * See https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
>
> Ah, so this is for a Spartan-6 device. We don't have any QEMU support
> for Spartan-6. What are you trying to use this for?
>

The use-case for this patch is to fool FPGA configuration tools
running on the guest into beliving that they successfully configure
Spartan-6 device. I tested this code against
"drivers/fpga/xilinx-spi.c" from Linux kernel.

>> + *
>> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/misc/xilinx_slave_serial.h"
>> +#include "qemu/log.h"
>> +
>> +enum {
>> +    XILINX_SLAVE_SERIAL_STATE_RESET,
>> +    XILINX_SLAVE_SERIAL_STATE_RECONFIGURATION,
>> +    XILINX_SLAVE_SERIAL_STATE_DONE,
>> +};
>> +
>> +static void xilinx_slave_serial_update_outputs(XilinxSlaveSerialState *xlnxss)
>
> For function names try to use xlnx instead of xilinx, it just saves line length.

Will fix if I re-spin this patch.

>
>> +{
>> +    qemu_set_irq(xlnxss->done,
>> +                 xlnxss->state == XILINX_SLAVE_SERIAL_STATE_DONE);
>> +}
>> +
>> +static void xilinx_slave_serial_reset(DeviceState *dev)
>> +{
>> +    XilinxSlaveSerialState *xlnxss = XILINX_SLAVE_SERIAL(dev);
>
> This is generally just called 's'.

OK, will fix if I re-spin this patch

>
>> +
>> +    xlnxss->state = XILINX_SLAVE_SERIAL_STATE_RESET;
>> +
>> +    xilinx_slave_serial_update_outputs(xlnxss);
>> +}
>> +
>> +static void xilinx_slave_serial_prog_b(void *opaque, int n, int level)
>> +{
>> +    XilinxSlaveSerialState *xlnxss = XILINX_SLAVE_SERIAL(opaque);
>> +    assert(n == 0);
>> +
>> +    if (level) {
>> +        xlnxss->state = XILINX_SLAVE_SERIAL_STATE_RECONFIGURATION;
>> +    }
>> +
>> +    xilinx_slave_serial_update_outputs(xlnxss);
>> +}
>> +
>> +static void xilinx_slave_serial_realize(SSISlave *ss, Error **errp)
>> +{
>> +    DeviceState *dev = DEVICE(ss);
>> +    XilinxSlaveSerialState *xlnxss = XILINX_SLAVE_SERIAL(ss);
>> +
>> +    qdev_init_gpio_in_named(dev,
>> +                            xilinx_slave_serial_prog_b,
>> +                            XILINX_SLAVE_SERIAL_GPIO_PROG_B,
>> +                            1);
>> +    qdev_init_gpio_out_named(dev, &xlnxss->done,
>> +                             XILINX_SLAVE_SERIAL_GPIO_DONE, 1);
>> +}
>> +
>> +static uint32_t xilinx_slave_serial_transfer(SSISlave *ss, uint32_t tx)
>> +{
>> +    XilinxSlaveSerialState *xlnxss = XILINX_SLAVE_SERIAL(ss);
>> +
>> +    if (xlnxss->state == XILINX_SLAVE_SERIAL_STATE_RECONFIGURATION) {
>> +        xlnxss->state = XILINX_SLAVE_SERIAL_STATE_DONE;
>> +    }
>> +
>> +    xilinx_slave_serial_update_outputs(xlnxss);
>> +    return 0;
>> +}
>> +
>> +static void xilinx_slave_serial_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass   *dc = DEVICE_CLASS(klass);
>> +    SSISlaveClass *k  = SSI_SLAVE_CLASS(klass);
>> +
>> +    dc->reset      = xilinx_slave_serial_reset;
>> +    dc->desc       = "Xilinx Slave Serial";
>> +    k->realize     = xilinx_slave_serial_realize;
>> +    k->transfer    = xilinx_slave_serial_transfer;
>> +    /*
>> +     * Slave Serial configuration is not technically SPI and there's
>> +     * no CS signal
>> +     */
>> +    k->set_cs      = NULL;
>> +    k->cs_polarity = SSI_CS_NONE;
>> +}
>> +
>> +static const TypeInfo xilinx_slave_serial_info = {
>> +    .name          = TYPE_XILINX_SLAVE_SERIAL,
>> +    .parent        = TYPE_SSI_SLAVE,
>> +    .instance_size = sizeof(XilinxSlaveSerialState),
>> +    .class_init    = xilinx_slave_serial_class_init,
>> +};
>> +
>> +static void xilinx_slave_serial_register_type(void)
>> +{
>> +    type_register_static(&xilinx_slave_serial_info);
>> +}
>> +type_init(xilinx_slave_serial_register_type)
>> diff --git a/include/hw/misc/xilinx_slave_serial.h b/include/hw/misc/xilinx_slave_serial.h
>> new file mode 100644
>> index 0000000000..f7b2e22be3
>> --- /dev/null
>> +++ b/include/hw/misc/xilinx_slave_serial.h
>> @@ -0,0 +1,21 @@
>> +#ifndef XILINX_SLAVE_SERIAL_H
>> +#define XILINX_SLAVE_SERIAL_H
>> +
>> +#include "hw/ssi/ssi.h"
>> +
>> +typedef struct XilinxSlaveSerialState {
>> +    /*< private >*/
>> +    SSISlave parent_obj;
>> +
>> +    qemu_irq done;
>> +    int state;
>> +} XilinxSlaveSerialState;
>> +
>> +#define TYPE_XILINX_SLAVE_SERIAL "xilinx:slave-serial"
>
> Full stop instead of colon.

Good to know, will fix if I re-spin this patch

>
> Overall the model looks fine, I'm just not sure what you are using it
> for as it isn't connected to anything.

I think this patch is similar to another one I submitted
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg02513.html in
a sense that there's no board in upstream codebase that needs this
feature and I am not yet upstreaming the code for the board that I use
it for. Given the situation, I think I'll put this patch on hold until
I have some other code to justify its inclusion.

Thanks,
Andrey Smrinov
