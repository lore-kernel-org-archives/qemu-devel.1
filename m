Received: from eggs.gnu.org ([2001:4830:134:3::10]:41718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eZwFB-000153-S4
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eZwF8-0006Oo-Jg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:07:25 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:50156
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1eZwF8-0006Mv-4j
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:07:22 -0500
References: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
	<8a8ce751cf399afba6fc522a01d1e0f47303249e.1515260163.git.pisa@cmp.felk.cvut.cz>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <141a9615-7226-ccc0-5041-b053ae676609@adacore.com>
Date: Fri, 12 Jan 2018 11:07:18 +0100
MIME-Version: 1.0
In-Reply-To: <8a8ce751cf399afba6fc522a01d1e0f47303249e.1515260163.git.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] CAN bus simple messages transport
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
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Jan Kiszka <jan.kiszka@siemens.com>

Hi Pavel,

On 01/06/2018 09:47 PM, pisa@cmp.felk.cvut.cz wrote:
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
>   default-configs/pci.mak |   1 +
>   hw/Makefile.objs        |   1 +
>   hw/can/Makefile.objs    |   6 ++
>   hw/can/can_core.c       | 129 +++++++++++++++++++++++++++++++++++++++++++
>   hw/can/can_host_stub.c  |  36 ++++++++++++
>   include/can/can_emu.h   | 143 ++++++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 316 insertions(+)
>   create mode 100644 hw/can/Makefile.objs
>   create mode 100644 hw/can/can_core.c
>   create mode 100644 hw/can/can_host_stub.c
>   create mode 100644 include/can/can_emu.h
> 
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index e514bdef42..bbe11887a1 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -31,6 +31,7 @@ CONFIG_ESP_PCI=y
>   CONFIG_SERIAL=y
>   CONFIG_SERIAL_ISA=y
>   CONFIG_SERIAL_PCI=y
> +CONFIG_CAN_CORE=y
>   CONFIG_IPACK=y
>   CONFIG_WDT_IB6300ESB=y
>   CONFIG_PCI_TESTDEV=y
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index cf4cb2010b..9d84b8faaa 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -6,6 +6,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += block/
>   devices-dirs-$(CONFIG_SOFTMMU) += bt/
>   devices-dirs-$(CONFIG_SOFTMMU) += char/
>   devices-dirs-$(CONFIG_SOFTMMU) += cpu/
> +devices-dirs-$(CONFIG_SOFTMMU) += can/
>   devices-dirs-$(CONFIG_SOFTMMU) += display/
>   devices-dirs-$(CONFIG_SOFTMMU) += dma/
>   devices-dirs-$(CONFIG_SOFTMMU) += gpio/
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
> +common-obj-y += can_host_stub.o
> +endif
> diff --git a/hw/can/can_core.c b/hw/can/can_core.c
> new file mode 100644
> index 0000000000..49ba3c6ef2
> --- /dev/null
> +++ b/hw/can/can_core.c
> @@ -0,0 +1,129 @@
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
> +#ifndef DEBUG_CAN
> +#define DEBUG_CAN 0
> +#endif /*DEBUG_CAN*/

This seems not used?

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
> +int can_bus_client_set_filters(CanBusClientState *client,
> +             const struct qemu_can_filter *filters, size_t filters_cnt)
> +{
> +    return 0;
> +}
> +
> +int can_bus_connect_to_host_device(CanBusState *bus, const char *name)
> +{
> +    if (can_bus_connect_to_host_variant == NULL) {
> +        error_report("CAN bus connect to host device not supported on this system");
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
> index 0000000000..5c149a2ae9
> --- /dev/null
> +++ b/include/can/can_emu.h
> @@ -0,0 +1,143 @@
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
> +#define QEMU_CAN_INV_FILTER 0x20000000U /* to be set in qemu_can_filter.can_id */
> +
> +typedef struct CanBusClientState CanBusClientState;
> +typedef struct CanBusState CanBusState;
> +
> +typedef struct CanBusClientInfo {
> +    /*CanBusClientOptionsKind type;*/

You can drop it.

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
> +    /*CanBusQueue *incoming_queue;*/
> +    char *model;
> +    char *name;
> +    /*unsigned receive_disabled : 1;*/
> +    void (*destructor)(CanBusClientState *);
> +    /*unsigned int queue_index;*/
> +    /*unsigned rxfilter_notify_enabled:1;*/

Same here.

> +};
> +
> +struct CanBusState {
> +    char *name;
> +    QTAILQ_HEAD(, CanBusClientState) clients;
> +    QTAILQ_ENTRY(CanBusState) next;
> +};
> +
> +extern int (*can_bus_connect_to_host_variant)(CanBusState *bus, const char *name);
> +
> +static inline
> +int can_bus_filter_match(struct qemu_can_filter *filter, qemu_canid_t can_id)
> +{
> +    int m;
> +    if (((can_id | filter->can_mask) & QEMU_CAN_ERR_FLAG)) {
> +        return (filter->can_mask & QEMU_CAN_ERR_FLAG) != 0;
> +    }
> +    m = (can_id & filter->can_mask) == (filter->can_id & filter->can_mask);
> +    return filter->can_id & QEMU_CAN_INV_FILTER ? !m : m;
> +}

Is it really required to inline this?

Fred

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
