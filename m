Received: from eggs.gnu.org ([2001:4830:134:3::10]:54690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVw4-0001GD-Um
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:38:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVw0-0004wE-O7
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:38:21 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:41183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVw0-0004v2-IX
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:38:16 -0500
Received: by mail-qt0-x241.google.com with SMTP id i1so3392038qtj.8
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 04:38:16 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<ba1a251965e9b9ee62d32e8580c7a041fb423c36.1515960078.git.pisa@cmp.felk.cvut.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ed771781-5985-0998-cec2-71bdeccd03d4@amsat.org>
Date: Fri, 19 Jan 2018 09:38:11 -0300
MIME-Version: 1.0
In-Reply-To: <ba1a251965e9b9ee62d32e8580c7a041fb423c36.1515960078.git.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 1/7] CAN bus simple messages transport
 implementation for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pisa@cmp.felk.cvut.cz, qemu-devel@nongnu.org
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 01/14/2018 05:14 PM, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> The CanBusState state structure is created for each
> emulated CAN channel. Individual clients/emulated
> CAN interfaces or host interface connection registers
> to the bus by CanBusClientState structure.
> 
> The CAN core is prepared to support connection to the
> real host CAN bus network. The commit with such support
> for Linux SocketCAN follows.
> 
> Implementation is as simple as possible, no migration,
> messages prioritization and queuing considered for now.
> But it is intended to be extended when need arises.
> 
> Development repository and more documentation at
> 
> https://gitlab.fel.cvut.cz/canbus/qemu-canbus
> 
> The work is based on Jin Yang GSoC 2013 work funded
> by Google and mentored in frame of RTEMS project GSoC
> slot donated to QEMU.
> 
> Rewritten for QEMU-2.0+ versions and architecture cleanup
> by Pavel Pisa (Czech Technical University in Prague).
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  default-configs/pci.mak |   1 +
>  hw/Makefile.objs        |   1 +
>  hw/can/Makefile.objs    |   6 +++
>  hw/can/can_core.c       | 136 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/can/can_host_stub.c  |  36 +++++++++++++
>  include/can/can_emu.h   | 131 ++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 311 insertions(+)
>  create mode 100644 hw/can/Makefile.objs
>  create mode 100644 hw/can/can_core.c
>  create mode 100644 hw/can/can_host_stub.c
>  create mode 100644 include/can/can_emu.h
> 
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index e514bdef42..bbe11887a1 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -31,6 +31,7 @@ CONFIG_ESP_PCI=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y
>  CONFIG_SERIAL_PCI=y
> +CONFIG_CAN_CORE=y

please use CONFIG_CAN_BUS for the 'core' part.
(we also have CONFIG_ISA_BUS)

>  CONFIG_IPACK=y
>  CONFIG_WDT_IB6300ESB=y
>  CONFIG_PCI_TESTDEV=y
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index cf4cb2010b..9d84b8faaa 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -6,6 +6,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += block/
>  devices-dirs-$(CONFIG_SOFTMMU) += bt/
>  devices-dirs-$(CONFIG_SOFTMMU) += char/
>  devices-dirs-$(CONFIG_SOFTMMU) += cpu/
> +devices-dirs-$(CONFIG_SOFTMMU) += can/
>  devices-dirs-$(CONFIG_SOFTMMU) += display/
>  devices-dirs-$(CONFIG_SOFTMMU) += dma/
>  devices-dirs-$(CONFIG_SOFTMMU) += gpio/
> diff --git a/hw/can/Makefile.objs b/hw/can/Makefile.objs
> new file mode 100644
> index 0000000000..1028d7c455
> --- /dev/null
> +++ b/hw/can/Makefile.objs
> @@ -0,0 +1,6 @@
> +# CAN bus interfaces emulation and infrastructure
> +
> +ifeq ($(CONFIG_CAN_CORE),y)
> +common-obj-y += can_core.o

Please follow QEMU style:

common-obj-$(CONFIG_CAN_BUS) += can_core.o

> +common-obj-y += can_host_stub.o
> +endif
> diff --git a/hw/can/can_core.c b/hw/can/can_core.c
> new file mode 100644
> index 0000000000..41c458c792
> --- /dev/null
> +++ b/hw/can/can_core.c
> @@ -0,0 +1,136 @@
> +/*
> + * CAN common CAN bus emulation support
> + *
> + * Copyright (c) 2013-2014 Jin Yang
> + * Copyright (c) 2014-2018 Pavel Pisa
> + *
> + * Initial development supported by Google GSoC 2013 from RTEMS project slot
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "chardev/char.h"
> +#include "qemu/sockets.h"
> +#include "qemu/error-report.h"
> +#include "hw/hw.h"
> +#include "can/can_emu.h"
> +
> +static QTAILQ_HEAD(, CanBusState) can_buses =
> +    QTAILQ_HEAD_INITIALIZER(can_buses);
> +
> +CanBusState *can_bus_find_by_name(const char *name, bool create_missing)
> +{
> +    CanBusState *bus;
> +
> +    if (name == NULL) {
> +        name = "canbus0";
> +    }
> +
> +    QTAILQ_FOREACH(bus, &can_buses, next) {
> +        if (!strcmp(bus->name, name)) {
> +            return bus;
> +        }
> +    }
> +
> +    if (!create_missing) {
> +        return 0;
> +    }
> +
> +    bus = g_malloc0(sizeof(*bus));
> +    if (bus == NULL) {
> +        return NULL;
> +    }
> +
> +    QTAILQ_INIT(&bus->clients);
> +
> +    bus->name = g_strdup(name);
> +
> +    QTAILQ_INSERT_TAIL(&can_buses, bus, next);
> +    return bus;
> +}
> +
> +int can_bus_insert_client(CanBusState *bus, CanBusClientState *client)
> +{
> +    client->bus = bus;
> +    QTAILQ_INSERT_TAIL(&bus->clients, client, next);
> +    return 0;
> +}
> +
> +int can_bus_remove_client(CanBusClientState *client)
> +{
> +    CanBusState *bus = client->bus;
> +    if (bus == NULL) {
> +        return 0;
> +    }
> +
> +    QTAILQ_REMOVE(&bus->clients, client, next);
> +    client->bus = NULL;
> +    return 1;
> +}
> +
> +ssize_t can_bus_client_send(CanBusClientState *client,
> +             const struct qemu_can_frame *frames, size_t frames_cnt)
> +{
> +    int ret = 0;
> +    CanBusState *bus = client->bus;
> +    CanBusClientState *peer;
> +    if (bus == NULL) {
> +        return -1;
> +    }
> +
> +    QTAILQ_FOREACH(peer, &bus->clients, next) {
> +        if (peer->info->can_receive(peer)) {
> +            if (peer == client) {
> +                /* No loopback support for now */
> +                continue;
> +            }
> +            if (peer->info->receive(peer, frames, frames_cnt) > 0) {
> +                ret = 1;
> +            }
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +int can_bus_filter_match(struct qemu_can_filter *filter, qemu_canid_t can_id)
> +{
> +    int m;
> +    if (((can_id | filter->can_mask) & QEMU_CAN_ERR_FLAG)) {
> +        return (filter->can_mask & QEMU_CAN_ERR_FLAG) != 0;
> +    }
> +    m = (can_id & filter->can_mask) == (filter->can_id & filter->can_mask);
> +    return filter->can_id & QEMU_CAN_INV_FILTER ? !m : m;
> +}
> +
> +int can_bus_client_set_filters(CanBusClientState *client,
> +             const struct qemu_can_filter *filters, size_t filters_cnt)
> +{
> +    return 0;
> +}
> +
> +int can_bus_connect_to_host_device(CanBusState *bus, const char *name)
> +{
> +    if (can_bus_connect_to_host_variant == NULL) {
> +        error_report("CAN bus connect to host device is not "
> +                     "supported on this system");
> +        exit(1);
> +    }
> +    return can_bus_connect_to_host_variant(bus, name);
> +}
> diff --git a/hw/can/can_host_stub.c b/hw/can/can_host_stub.c
> new file mode 100644
> index 0000000000..748d25f995
> --- /dev/null
> +++ b/hw/can/can_host_stub.c
> @@ -0,0 +1,36 @@
> +/*
> + * CAN stub to connect to host system CAN interface
> + *
> + * Copyright (c) 2013-2014 Jin Yang
> + * Copyright (c) 2014-2018 Pavel Pisa
> + *
> + * Initial development supported by Google GSoC 2013 from RTEMS project slot
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "chardev/char.h"
> +#include "qemu/sockets.h"
> +#include "qemu/error-report.h"
> +#include "hw/hw.h"
> +#include "can/can_emu.h"
> +
> +
> +int (*can_bus_connect_to_host_variant)(CanBusState *bus, const char *name) =
> +        NULL;
> diff --git a/include/can/can_emu.h b/include/can/can_emu.h
> new file mode 100644
> index 0000000000..85237ee3c9
> --- /dev/null
> +++ b/include/can/can_emu.h
> @@ -0,0 +1,131 @@
> +/*
> + * CAN common CAN bus emulation support
> + *
> + * Copyright (c) 2013-2014 Jin Yang
> + * Copyright (c) 2014-2018 Pavel Pisa
> + *
> + * Initial development supported by Google GSoC 2013 from RTEMS project slot
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef NET_CAN_EMU_H
> +#define NET_CAN_EMU_H
> +
> +#include "qemu/queue.h"
> +
> +/* NOTE: the following two structures is copied from <linux/can.h>. */
> +
> +/*
> + * Controller Area Network Identifier structure
> + *
> + * bit 0-28    : CAN identifier (11/29 bit)
> + * bit 29      : error frame flag (0 = data frame, 1 = error frame)
> + * bit 30      : remote transmission request flag (1 = rtr frame)
> + * bit 31      : frame format flag (0 = standard 11 bit, 1 = extended 29 bit)
> + */
> +typedef uint32_t qemu_canid_t;
> +
> +typedef struct qemu_can_frame {
> +    qemu_canid_t    can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> +    uint8_t         can_dlc; /* data length code: 0 .. 8 */
> +    uint8_t         data[8] QEMU_ALIGNED(8);
> +} qemu_can_frame;
> +
> +/* Keep defines for QEMU separate from Linux ones for now */
> +
> +#define QEMU_CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
> +#define QEMU_CAN_RTR_FLAG 0x40000000U /* remote transmission request */
> +#define QEMU_CAN_ERR_FLAG 0x20000000U /* error message frame */
> +
> +#define QEMU_CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
> +#define QEMU_CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
> +
> +/**
> + * struct qemu_can_filter - CAN ID based filter in can_register().
> + * @can_id:   relevant bits of CAN ID which are not masked out.
> + * @can_mask: CAN mask (see description)
> + *
> + * Description:
> + * A filter matches, when
> + *
> + *          <received_can_id> & mask == can_id & mask
> + *
> + * The filter can be inverted (QEMU_CAN_INV_FILTER bit set in can_id) or it can
> + * filter for error message frames (QEMU_CAN_ERR_FLAG bit set in mask).
> + */
> +typedef struct qemu_can_filter {
> +    qemu_canid_t    can_id;
> +    qemu_canid_t    can_mask;
> +} qemu_can_filter;
> +
> +/* QEMU_CAN_INV_FILTER can be set in qemu_can_filter.can_id */
> +#define QEMU_CAN_INV_FILTER 0x20000000U
> +
> +typedef struct CanBusClientState CanBusClientState;
> +typedef struct CanBusState CanBusState;
> +
> +typedef struct CanBusClientInfo {
> +    size_t size;
> +    int (*can_receive)(CanBusClientState *);
> +    ssize_t (*receive)(CanBusClientState *,
> +        const struct qemu_can_frame *frames, size_t frames_cnt);
> +    void (*cleanup) (CanBusClientState *);
> +    void (*poll)(CanBusClientState *, bool enable);
> +} CanBusClientInfo;
> +
> +struct CanBusClientState {
> +    CanBusClientInfo *info;
> +    CanBusState *bus;
> +    int link_down;
> +    QTAILQ_ENTRY(CanBusClientState) next;
> +    CanBusClientState *peer;
> +    char *model;
> +    char *name;
> +    void (*destructor)(CanBusClientState *);
> +};
> +
> +struct CanBusState {
> +    char *name;
> +    QTAILQ_HEAD(, CanBusClientState) clients;
> +    QTAILQ_ENTRY(CanBusState) next;
> +};
> +
> +extern int (*can_bus_connect_to_host_variant)(CanBusState *bus,
> +                                              const char *name);

Isn't extern (*func) an anti-pattern?
One might be tempted to call it without checking it is non-NULL...

Please declare it as a function, and using a static pointer, i.e.:

typedef int (*can_bus_connect_to_host_variant_t)(CanBusState *bus,
                                       const char *name);


static can_bus_connect_to_host_variant_t
can_bus_connect_to_host_variant_handler;

void
set_can_bus_connect_to_host_variant(can_bus_connect_to_host_variant_t
handler)
{
    can_bus_connect_to_host_variant_handler = handler;
}

int can_bus_connect_to_host_variant(CanBusState *bus,
                          const char *name)
{
    if (!can_bus_connect_to_host_variant_handler) {
        return ERROR;
    }
    return can_bus_connect_to_host_variant_handler(bus, name);
}

I'm sure we can find nicer/shorter function names ;)

> +
> +int can_bus_filter_match(struct qemu_can_filter *filter, qemu_canid_t can_id);
> +
> +CanBusState *can_bus_find_by_name(const char *name, bool create_missing);
> +
> +int can_bus_insert_client(CanBusState *bus, CanBusClientState *client);
> +
> +int can_bus_remove_client(CanBusClientState *client);
> +
> +ssize_t can_bus_client_send(CanBusClientState *,
> +                            const struct qemu_can_frame *frames,
> +                            size_t frames_cnt);
> +
> +int can_bus_client_set_filters(CanBusClientState *,
> +                               const struct qemu_can_filter *filters,
> +                               size_t filters_cnt);
> +
> +int can_bus_connect_to_host_device(CanBusState *bus, const char *host_dev_name);
> +
> +#endif
> 
