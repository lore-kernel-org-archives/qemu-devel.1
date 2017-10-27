Received: from eggs.gnu.org ([2001:4830:134:3::10]:32907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e85T8-0000UA-HC
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e85T2-0005Au-KQ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:18:42 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:35875
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1e85T2-00059a-1C
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:18:36 -0400
References: <cover.1508885974.git.pisa@cmp.felk.cvut.cz>
	<28f27d84714abd1e85144a5679eaa3147f4ca023.1508885974.git.pisa@cmp.felk.cvut.cz>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <35454964-58da-e9d1-f960-c7cff8a9e054@adacore.com>
Date: Fri, 27 Oct 2017 16:18:31 +0200
MIME-Version: 1.0
In-Reply-To: <28f27d84714abd1e85144a5679eaa3147f4ca023.1508885974.git.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] CAN bus simple SJA1000 PCI card
 emulation for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pisa@cmp.felk.cvut.cz
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>

Hi Pavel,

On 10/25/2017 01:12 AM, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> The work is based on Jin Yang GSoC 2013 work funded
> by Google and mentored in frame of RTEMS project GSoC
> slot donated to QEMU.
> 
> Rewritten for QEMU-2.0+ versions and architecture cleanup
> by Pavel Pisa (Czech Technical University in Prague).
> 
> The core SJA1000 support is independent of provided
> PCI board. The simple core CAN bus infrastructure
> is independent as well.
> 
> Connection to the real host CAN bus network through
> SocketCAN network interface is available for Linux
> host system as well.
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>   default-configs/pci.mak |   2 +
>   hw/Makefile.objs        |   1 +
>   hw/can/Makefile.objs    |   5 +
>   hw/can/can_core.c       | 374 +++++++++++++++++++

Correct me if I'm wrong but this file above doesn't introduce
SJA1000 PCI board? If not it should be in a separate patch.

>   hw/can/can_pci.c        | 246 +++++++++++++
>   hw/can/can_sja1000.c    | 962 ++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/can/can_sja1000.h    | 173 +++++++++
>   include/can/can_emu.h   | 133 +++++++
>   8 files changed, 1896 insertions(+)
>   create mode 100644 hw/can/Makefile.objs
>   create mode 100644 hw/can/can_core.c
>   create mode 100644 hw/can/can_pci.c
>   create mode 100644 hw/can/can_sja1000.c
>   create mode 100644 hw/can/can_sja1000.h
>   create mode 100644 include/can/can_emu.h
> 
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index e514bdef42..0e18ce3263 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -31,6 +31,8 @@ CONFIG_ESP_PCI=y
>   CONFIG_SERIAL=y
>   CONFIG_SERIAL_ISA=y
>   CONFIG_SERIAL_PCI=y
> +CONFIG_CAN_SJA1000=y
> +CONFIG_CAN_PCI=y
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
> index 0000000000..98ff1e32db
> --- /dev/null
> +++ b/hw/can/Makefile.objs
> @@ -0,0 +1,5 @@
> +# CAN bus interfaces emulation and infrastructure
> +
> +common-obj-$(CONFIG_CAN_SJA1000) += can_core.o
> +common-obj-$(CONFIG_CAN_SJA1000) += can_sja1000.o
> +common-obj-$(CONFIG_CAN_PCI) += can_pci.o
> diff --git a/hw/can/can_core.c b/hw/can/can_core.c
> new file mode 100644
> index 0000000000..b6a43a2e9b
> --- /dev/null
> +++ b/hw/can/can_core.c
> @@ -0,0 +1,374 @@
> +/*
> + * CAN common CAN bus emulation support
> + *
> + * Copyright (c) 2013-2014 Jin Yang
> + * Copyright (c) 2014 Pavel Pisa
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
> +/*
> + * The option to connect individual CAN busses
> + * to the host CAN interface is operating system
> + * and CAN drivers infrastructure specific.
> + *
> + * Linux SocketCAN support is implemented for now.
> + * If more otions are added later, then they can be
> + * moved to separate files.
> + */
> +#ifdef __linux__
> +#include <sys/ioctl.h>
> +#include <net/if.h>
> +#include <linux/can.h>
> +#include <linux/can/raw.h>
> +
> +#define NUM_FILTER        4
> +#define CAN_READ_BUF_LEN  5
> +typedef struct {
> +    CanBusClientState  bus_client;
> +    qemu_can_filter    rfilter[NUM_FILTER];
> +    can_err_mask_t     err_mask;
> +
> +    qemu_can_frame     buf[CAN_READ_BUF_LEN];
> +    int                bufcnt;
> +    int                bufptr;
> +
> +    int                fd;
> +} CanBusHostConnectState;
> +
> +#endif /*__linux__*/ > +
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
> +#ifdef DEBUG_CAN
> +static void can_display_msg(struct qemu_can_frame *msg)
> +{
> +    int i;
> +
> +    printf("%03X [%01d]:", (msg->can_id & 0x1fffffff), msg->can_dlc);
> +    for (i = 0; i < msg->can_dlc; i++) {
> +        printf("  %02X", msg->data[i]);
> +    }
> +    printf("\n");
> +}
> +#endif

This might bitrot, I suggest doing something like

#ifndef DEBUG_CAN
#define DEBUG_CAN 0
#endif /* DEBUG_CAN */

and then

if (DEBUG_CAN) {
   printf(...);
   ...
}

so it's compiled/checked anyway.

Fred

> +
> +#ifdef __linux__
> +
> +static void can_bus_host_read(void *opaque)
> +{
> +    CanBusHostConnectState *c;
> +    c = (CanBusHostConnectState *)opaque;
> +
> +    /* CAN_READ_BUF_LEN for multiple messages syscall is possible for future */
> +    c->bufcnt = read(c->fd, c->buf, sizeof(qemu_can_frame));
> +    if (c->bufcnt < 0) {
> +        perror("CAN bus host read");
> +        return;
> +    }
> +
> +    can_bus_client_send(&c->bus_client, c->buf, 1);
> +
> +#ifdef DEBUG_CAN
> +    can_display_msg(c->buf);/* Just display the first one. */
> +#endif
> +}
> +
> +static int can_bus_host_can_receive(CanBusClientState *client)
> +{
> +    CanBusHostConnectState *c;
> +    c = container_of(client, CanBusHostConnectState, bus_client);
> +
> +    if (c->fd < 0) {
> +        return -1;
> +    }
> +
> +    return 1;
> +}
> +
> +static ssize_t can_bus_host_receive(CanBusClientState *client,
> +                            const qemu_can_frame *frames, size_t frames_cnt)
> +{
> +    CanBusHostConnectState *c;
> +    c = container_of(client, CanBusHostConnectState, bus_client);
> +    size_t len = sizeof(qemu_can_frame);
> +    int res;
> +
> +    if (c->fd < 0) {
> +        return -1;
> +    }
> +
> +    res = write(c->fd, frames, len);
> +
> +    if (!res) {
> +        fprintf(stderr, "CAN bus write to host device zero length\n");
> +        return -1;
> +    }
> +
> +    /* send frame */
> +    if (res != len) {
> +        perror("CAN bus write to host device error");
> +        return -1;
> +    }
> +
> +    return 1;
> +}
> +
> +static void can_bus_host_cleanup(CanBusClientState *client)
> +{
> +    CanBusHostConnectState *c;
> +    c = container_of(client, CanBusHostConnectState, bus_client);
> +
> +    if (c->fd >= 0) {
> +        qemu_set_fd_handler(c->fd, NULL, NULL, c);
> +        close(c->fd);
> +        c->fd = -1;
> +    }
> +}
> +
> +static int can_bus_host_set_filters(CanBusClientState *client,
> +                   const struct qemu_can_filter *filters, size_t filters_cnt)
> +{
> +    CanBusHostConnectState *c;
> +    c = container_of(client, CanBusHostConnectState, bus_client);
> +
> +#ifdef DEBUG_CAN
> +    int i;
> +#endif
> +
> +    if (filters_cnt > 4) {
> +        return -1;
> +    }
> +
> +#ifdef DEBUG_CAN
> +    for (i = 0; i < filters_cnt; i++) {
> +        printf("[%i]  id=0x%08x maks=0x%08x\n",
> +               i, filters[i].can_id, filters[i].can_mask);
> +    }
> +#endif

Same as above.

> +
> +    setsockopt(c->fd, SOL_CAN_RAW, CAN_RAW_FILTER,
> +               filters, filters_cnt * sizeof(qemu_can_filter));
> +
> +    return 0;
> +}
> +
> +static void can_bus_host_update_read_handler(CanBusHostConnectState *c)
> +{
> +    if (c->fd >= 0) {
> +        qemu_set_fd_handler(c->fd, can_bus_host_read, NULL, c);
> +    }
> +}
> +
> +static CanBusClientInfo can_bus_host_bus_client_info = {
> +    .can_receive = can_bus_host_can_receive,
> +    .receive = can_bus_host_receive,
> +    .cleanup = can_bus_host_cleanup,
> +    .poll = NULL
> +};
> + > +static
> +CanBusHostConnectState *can_bus_host_connect_new(const char *host_dev_name)
> +{
> +    int s; /* can raw socket */
> +    CanBusHostConnectState    *c;
> +    struct sockaddr_can addr;
> +    struct ifreq ifr;
> +
> +    c = g_malloc0(sizeof(CanBusHostConnectState));
> +    if (c == NULL) {
> +        goto fail1;
> +    }
> +
> +    c->fd = -1;
> +
> +    /* open socket */
> +    s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
> +    if (s < 0) {
> +        perror("socket");
> +        goto fail;
> +    }
> +
> +    addr.can_family = AF_CAN;
> +    memset(&ifr.ifr_name, 0, sizeof(ifr.ifr_name));
> +    strcpy(ifr.ifr_name, host_dev_name);
> +    if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
> +        perror("SIOCGIFINDEX");
> +        goto fail;
> +    }
> +    addr.can_ifindex = ifr.ifr_ifindex;
> +
> +    c->err_mask = 0xffffffff; /* Receive error frame. */
> +    setsockopt(s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
> +                   &c->err_mask, sizeof(c->err_mask));
> +
> +    /* Receive all data frame. If |= CAN_INV_FILTER no data. */
> +    c->rfilter[0].can_id = 0;
> +    c->rfilter[0].can_mask = 0;
> +    c->rfilter[0].can_mask &= ~CAN_ERR_FLAG;
> +    setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER,
> +                   c->rfilter, sizeof(struct qemu_can_filter));
> +
> +    if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> +        perror("bind");
> +        goto fail;
> +    }
> +
> +    c->fd = s;
> +
> +    c->bus_client.info = &can_bus_host_bus_client_info;
> +
> +    can_bus_host_update_read_handler(c);
> +
> +    return c;
> +
> +fail:
> +    can_bus_host_cleanup(&c->bus_client);
> +    g_free(c);
> +fail1:
> +
> +    return NULL;
> +}
> +
> +int can_bus_connect_to_host_device(CanBusState *bus, const char *host_dev_name)
> +{
> +    CanBusHostConnectState *c;
> +
> +    c = can_bus_host_connect_new(host_dev_name);
> +    if (c == NULL) {
> +        error_report("CAN bus setup of host connect to \"%s\" failed",
> +                      host_dev_name);
> +        exit(1);
> +    }
> +
> +    if (can_bus_insert_client(bus, &c->bus_client) < 0) {
> +        error_report("CAN host device \"%s\" connect to bus \"%s\" failed",
> +                      host_dev_name, bus->name);
> +        exit(1);
> +    }
> +
> +    if (0) {
> +        /*
> +         * Not used there or as a CanBusHostConnectState method
> +         * for now but included there for documentation purposes
> +         * and to suppress warning.
> +         */
> +        can_bus_host_set_filters(&c->bus_client, NULL, 0);
> +    }
> +
> +    return 0;
> +}
> +
> +#else /*__linux__*/
> +int can_bus_connect_to_host_device(CanBusState *bus, const char *name)
> +{
> +    error_report("CAN bus connect to host device not supported on this system");
> +    exit(1);
> +}
> +#endif /*__linux__*/
> diff --git a/hw/can/can_pci.c b/hw/can/can_pci.c
> new file mode 100644
> index 0000000000..a9a502e96f
> --- /dev/null
> +++ b/hw/can/can_pci.c
> @@ -0,0 +1,246 @@
> +/*
> + * PCI CAN device (SJA1000 based) emulation
> + *
> + * Copyright (c) 2013-2014 Jin Yang
> + * Copyright (c) 2014 Pavel Pisa
> + *
> + * Partially based on educational PCIexpress APOHW hardware
> + * emulator used fro class A0B36APO at CTU FEE course by
> + *    Rostislav Lisovy and Pavel Pisa
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
> +#include "qemu/osdep.h"
> +#include "qemu/event_notifier.h"
> +#include "qemu/thread.h"
> +#include "qemu/sockets.h"
> +#include "qemu/error-report.h"
> +#include "chardev/char.h"
> +#include "hw/hw.h"
> +#include "hw/pci/pci.h"
> +#include "can/can_emu.h"
> +
> +#include "can_sja1000.h"
> +
> +#define TYPE_CAN_PCI_DEV "can_pci"
> +
> +#define CAN_PCI_DEV(obj) \
> +    OBJECT_CHECK(CanPCIState, (obj), TYPE_CAN_PCI_DEV)
> +
> +#define PCI_VENDOR_ID_CAN_PCI      PCI_VENDOR_ID_REDHAT
> +#define PCI_DEVICE_ID_CAN_PCI      0xbeef
> +#define PCI_REVISION_ID_CAN_PCI    0x73
> +
> +typedef struct CanPCIState {
> +    /*< private >*/
> +    PCIDevice       dev;
> +    /*< public >*/
> +    MemoryRegion    sja_mmio;
> +    CanSJA1000State sja_state;
> +    qemu_irq        irq;
> +
> +
> +    char            *model; /* The model that support, only SJA1000 now. */
> +    char            *canbus;
> +    char            *host;
> +} CanPCIState;
> +
> +static void can_pci_irq_raise(void *opaque)
> +{
> +    CanPCIState *d = (CanPCIState *)opaque;
> +    qemu_irq_raise(d->irq);
> +}
> +
> +static void can_pci_irq_lower(void *opaque)
> +{
> +    CanPCIState *d = (CanPCIState *)opaque;
> +    qemu_irq_lower(d->irq);
> +}
> +
> +static void
> +can_pci_reset(void *opaque)
> +{
> +    CanPCIState *d = (CanPCIState *)opaque;
> +    CanSJA1000State *s = &d->sja_state;
> +
> +    can_sja_hardware_reset(s);
> +}
> +
> +static uint64_t can_pci_bar0_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    CanPCIState *d = opaque;
> +    CanSJA1000State *s = &d->sja_state;
> +
> +    return can_sja_mem_read(s, addr, size);
> +}
> +
> +static void can_pci_bar0_write(void *opaque, hwaddr addr, uint64_t data,
> +                             unsigned size)
> +{
> +    CanPCIState *d = opaque;
> +    CanSJA1000State *s = &d->sja_state;
> +
> +    can_sja_mem_write(s, addr, data, size);
> +}
> +
> +static const MemoryRegionOps can_pci_bar0_ops = {
> +    .read = can_pci_bar0_read,
> +    .write = can_pci_bar0_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +};
> +
> +static int can_pci_init(PCIDevice *pci_dev)
> +{
> +    CanPCIState *d = CAN_PCI_DEV(pci_dev);
> +    CanSJA1000State *s = &d->sja_state;
> +    uint8_t *pci_conf;
> +    CanBusState *can_bus;
> +
> +    if (d->model) {
> +        if (strncmp(d->model, "SJA1000", 256)) { /* for security reason */
> +            error_report("Can't create CAN device, "
> +                         "the model %s is not supported now.", d->model);
> +            exit(1);
> +        }
> +    }
> +
> +    can_bus = can_bus_find_by_name(d->canbus, true);
> +    if (can_bus == NULL) {
> +        error_report("Cannot create can find/allocate CAN bus");
> +        exit(1);
> +
> +    }
> +
> +    if (d->host != NULL) {
> +        if (can_bus_connect_to_host_device(can_bus, d->host) < 0) {
> +            error_report("Cannot connect CAN bus to host device \"%s\"",
> +                         d->host);
> +            exit(1);
> +        }
> +    }
> +
> +    pci_conf = pci_dev->config;
> +    pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
> +
> +    d->irq = pci_allocate_irq(&d->dev);
> +
> +    can_sja_init(s, can_pci_irq_raise, can_pci_irq_lower, d);
> +
> +    qemu_register_reset(can_pci_reset, d);
> +
> +    if (can_sja_connect_to_bus(s, can_bus) < 0) {
> +        error_report("can_sja_connect_to_bus failed");
> +        exit(1);
> +    }
> +
> +    memory_region_init_io(&d->sja_mmio, OBJECT(d), &can_pci_bar0_ops, d,
> +                          "can_pci-bar0", CAN_SJA_MEM_SIZE);
> +
> +    pci_register_bar(pci_dev, /*BAR*/ 0, PCI_BASE_ADDRESS_SPACE_MEMORY,
> +                     &d->sja_mmio);
> +
> +    return 0;
> +}
> +
> +static void can_pci_exit(PCIDevice *pci_dev)
> +{
> +    CanPCIState *d = CAN_PCI_DEV(pci_dev);
> +    CanSJA1000State *s = &d->sja_state;
> +
> +    can_sja_disconnect(s);
> +
> +    qemu_unregister_reset(can_pci_reset, d);
> +
> +    /* region d->sja_mmio is destroyed by QOM now */
> +    /* memory_region_destroy(&d->sja_mmio); */
> +
> +    can_sja_exit(s);
> +
> +    qemu_free_irq(d->irq);
> +}
> +
> +static const VMStateDescription vmstate_can_pci = {
> +    .name = "can_pci",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .minimum_version_id_old = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(dev, CanPCIState),
> +        VMSTATE_STRUCT(sja_state, CanPCIState, 0, vmstate_can_sja,
> +                       CanSJA1000State),
> +        /*char *model,*/
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void qdev_can_pci_reset(DeviceState *dev)
> +{
> +    CanPCIState *d = CAN_PCI_DEV(dev);
> +    can_pci_reset(d);
> +}
> +
> +static Property can_pci_properties[] = {
> +    DEFINE_PROP_STRING("canbus",   CanPCIState, canbus),
> +    DEFINE_PROP_STRING("host",  CanPCIState, host),
> +    DEFINE_PROP_STRING("model", CanPCIState, model),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void can_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->init = can_pci_init;
> +    k->exit = can_pci_exit;
> +    k->vendor_id = PCI_VENDOR_ID_CAN_PCI;
> +    k->device_id = PCI_DEVICE_ID_CAN_PCI;
> +    k->revision = PCI_REVISION_ID_CAN_PCI;
> +    k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
> +    dc->desc = "CAN PCI SJA1000";
> +    dc->props = can_pci_properties;
> +    dc->vmsd = &vmstate_can_pci;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->reset = qdev_can_pci_reset;
> +}
> +
> +static const TypeInfo can_pci_info = {
> +    .name          = TYPE_CAN_PCI_DEV,
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(CanPCIState),
> +    .class_init    = can_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
> +static void can_pci_register_types(void)
> +{
> +    type_register_static(&can_pci_info);
> +}
> +
> +type_init(can_pci_register_types)
> diff --git a/hw/can/can_sja1000.c b/hw/can/can_sja1000.c
> new file mode 100644
> index 0000000000..75cbb16f48
> --- /dev/null
> +++ b/hw/can/can_sja1000.c
> @@ -0,0 +1,962 @@
> +/*
> + * CAN device - SJA1000 chip emulation for QEMU
> + *
> + * Copyright (c) 2013-2014 Jin Yang
> + * Copyright (c) 2014 Pavel Pisa
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
> +#include "hw/hw.h"
> +#include "can/can_emu.h"
> +
> +#include "can_sja1000.h"
> +
> +// #define DEBUG_FILTER
> +
> +static void can_sja_software_reset(CanSJA1000State *s)
> +{
> +    s->mode        &= ~0x31;
> +    s->mode        |= 0x01;
> +    s->statusP     &= ~0x37;
> +    s->statusP     |= 0x34;
> +
> +    s->rxbuf_start = 0x00;
> +    s->rxmsg_cnt   = 0x00;
> +    s->rx_cnt      = 0x00;
> +}
> +
> +void can_sja_hardware_reset(CanSJA1000State *s)
> +{
> +    /* Reset by hardware, p10 */
> +    s->mode        = 0x01;
> +    s->statusP     = 0x3c;
> +    s->interruptP  = 0x00;
> +    s->clock       = 0x00;
> +    s->rxbuf_start = 0x00;
> +    s->rxmsg_cnt   = 0x00;
> +    s->rx_cnt      = 0x00;
> +
> +    s->control     = 0x01;
> +    s->statusB     = 0x0c;
> +    s->interruptB  = 0x00;
> +
> +    s->irq_lower(s->irq_opaque);
> +}
> +
> +
> +/* Details in DS-p22, what we need to do here is to test the data. */
> +static int can_sja_accept_filter(CanSJA1000State *s,
> +                                 const qemu_can_frame *frame)
> +{
> +    uint8_t tmp1, tmp2;
> +
> +    if (s->clock & 0x80) { /* PeliCAN Mode */
> +        if (s->mode & (1 << 3)) { /* Single mode. */
> +            if (!(frame->can_id & (1 << 31))) { /* SFF */
> +                if (frame->can_id & (1 << 30)) { /* RTR */
> +                    return 1;
> +                }
> +                if (frame->can_dlc == 0) {
> +                    return 1;
> +                }
> +                if (frame->can_dlc == 1) {
> +                    if ((frame->data[0] & ~(s->code_mask[6])) ==
> +                       (s->code_mask[2] & ~(s->code_mask[6]))) {
> +                        return 1;
> +                    }
> +                }
> +                if (frame->can_dlc >= 2) {
> +                    if (((frame->data[0] & ~(s->code_mask[6])) ==
> +                       (s->code_mask[2] & ~(s->code_mask[6]))) &&
> +                       ((frame->data[1] & ~(s->code_mask[7])) ==
> +                       (s->code_mask[3] & ~(s->code_mask[7])))) {
> +                        return 1;
> +                    }
> +                }
> +                return 0;
> +            }
> +        } else { /* Dual mode */
> +            if (!(frame->can_id & (1 << 31))) { /* SFF */
> +                if (((s->code_mask[0] & ~s->code_mask[4]) ==
> +                    (((frame->can_id >> 3) & 0xff) & ~s->code_mask[4])) &&
> +                    (((s->code_mask[1] & ~s->code_mask[5]) & 0xe0) ==
> +                    (((frame->can_id << 5) & ~s->code_mask[5]) & 0xe0))) {
> +                    if (frame->can_dlc == 0) {
> +                        return 1;
> +                    } else {
> +                        tmp1 = ((s->code_mask[1] << 4) & 0xf0) |
> +                              (s->code_mask[2] & 0x0f);
> +                        tmp2 = ((s->code_mask[5] << 4) & 0xf0) |
> +                              (s->code_mask[6] & 0x0f);
> +                        tmp2 = ~tmp2;
> +                        if ((tmp1 & tmp2) == (frame->data[0] & tmp2)) {
> +                            return 1;
> +                        }
> +                        return 0;
> +                    }
> +                }
> +            }
> +        }
> +    }
> +
> +    return 1;
> +}
> +
> +#ifdef DEBUG_FILTER
> +static void can_display_msg(const qemu_can_frame *msg)
> +{
> +    int i;
> +
> +    printf("%03X [%01d] -", (msg->can_id & 0x1fffffff), msg->can_dlc);
> +    if (msg->can_id & (1 << 31)) {
> +        printf("EFF ");
> +    } else {
> +        printf("SFF ");
> +    }
> +    if (msg->can_id & (1 << 30)) {
> +        printf("RTR-");
> +    } else {
> +        printf("DAT-");
> +    }
> +    for (i = 0; i < msg->can_dlc; i++) {
> +        printf("  %02X", msg->data[i]);
> +    }
> +    for (; i < 8; i++) {
> +        printf("    ");
> +    }
> +    fflush(stdout);
> +}
> +#endif
> +static void buff2frameP(const uint8_t *buff, qemu_can_frame *frame)
> +{
> +    uint8_t i;
> +
> +    frame->can_id = 0;
> +    if (buff[0] & 0x40) { /* RTR */
> +        frame->can_id = 0x01 << 30;
> +    }
> +    frame->can_dlc = buff[0] & 0x0f;
> +
> +    if (buff[0] & 0x80) { /* Extended */
> +        frame->can_id |= 0x01 << 31;
> +        frame->can_id |= buff[1] << 21; /* ID.28~ID.21 */
> +        frame->can_id |= buff[2] << 13; /* ID.20~ID.13 */
> +        frame->can_id |= buff[3] << 05;
> +        frame->can_id |= buff[4] >> 03;
> +        for (i = 0; i < frame->can_dlc; i++) {
> +            frame->data[i] = buff[5 + i];
> +        }
> +        for (; i < 8; i++) {
> +            frame->data[i] = 0;
> +        }
> +    } else {
> +        frame->can_id |= buff[1] << 03;
> +        frame->can_id |= buff[2] >> 05;
> +        for (i = 0; i < frame->can_dlc; i++) {
> +            frame->data[i] = buff[3 + i];
> +        }
> +        for (; i < 8; i++) {
> +            frame->data[i] = 0;
> +        }
> +    }
> +}
> +
> +
> +static void buff2frameB(const uint8_t *buff, qemu_can_frame *frame)
> +{
> +    uint8_t i;
> +
> +    frame->can_id = ((buff[0] << 3) & (0xff << 3)) + ((buff[1] >> 5) & 0x07);
> +    if (buff[1] & 0x10) { /* RTR */
> +        frame->can_id = 0x01 << 30;
> +    }
> +    frame->can_dlc = buff[1] & 0x0f;
> +
> +    for (i = 0; i < frame->can_dlc; i++) {
> +        frame->data[i] = buff[2 + i];
> +    }
> +    for (; i < 8; i++) {
> +        frame->data[i] = 0;
> +    }
> +}
> +
> +
> +static int frame2buffP(const qemu_can_frame *frame, uint8_t *buff)
> +{
> +    int i, count = 0;
> +
> +    if (frame->can_id & (1 << 29)) { /* error frame, NOT support now. */
> +        return -1;
> +    }
> +
> +    buff[count] = 0x0f & frame->can_dlc; /* DLC */
> +    if (frame->can_id & (1 << 30)) { /* RTR */
> +        buff[count] |= (1 << 6);
> +    }
> +    if (frame->can_id & (1 << 31)) { /* EFF */
> +        buff[count] |= (1 << 7);
> +        buff[++count] = (frame->can_id >> 21) & 0xff; /* ID.28~ID.21 */
> +        buff[++count] = (frame->can_id >> 13) & 0xff; /* ID.20~ID.13 */
> +        buff[++count] = (frame->can_id >> 05) & 0xff; /* ID.12~ID.05 */
> +        buff[++count] = (frame->can_id << 03) & 0xf8; /* ID.04~ID.00,x,x,x */
> +        for (i = 0; i < frame->can_dlc; i++) {
> +            buff[++count] = frame->data[i];
> +        }
> +
> +        return count + 1;
> +    } else { /* SFF */
> +        buff[++count] = (frame->can_id >> 03) & 0xff; /* ID.10~ID.03 */
> +        buff[++count] = (frame->can_id << 05) & 0xe0; /* ID.02~ID.00,x,x,x,x,x */
> +        for (i = 0; i < frame->can_dlc; i++) {
> +            buff[++count] = frame->data[i];
> +        }
> +
> +        return count + 1;
> +    }
> +
> +    return -1;
> +}
> +
> +static int frame2buffB(const qemu_can_frame *frame, uint8_t *buff)
> +{
> +    int i, count = 0;
> +
> +    if ((frame->can_id & (1 << 31)) || /* EFF, not support for BasicMode. */
> +       (frame->can_id & (1 << 29))) {  /* or Error frame, NOT support now. */
> +        return -1;
> +    }
> +
> +
> +    buff[count++] = 0xff & (frame->can_id >> 3);
> +    buff[count] = 0xe0 & (frame->can_id << 5);
> +    if (frame->can_id & (1 << 30)) { /* RTR */
> +        buff[count] |= (1 << 4);
> +    }
> +    buff[count++] |= frame->can_dlc & 0x0f;
> +    for (i = 0; i < frame->can_dlc; i++) {
> +        buff[count++] = frame->data[i];
> +    }
> +
> +#ifdef DEBUG_FILTER
> +    printf(" ==2==");
> +    for (i = 0; i < count; i++) {
> +        printf(" %02X", buff[i]);
> +    }
> +    for (; i < 10; i++) {
> +        printf("   ");
> +    }
> +#endif
> +    return count;
> +}
> +
> +void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
> +                       unsigned size)
> +{
> +    qemu_can_frame   frame;
> +    uint32_t         tmp;
> +    uint8_t          tmp8, count;
> +
> +
> +    DPRINTF("write 0x%02llx addr 0x%02x\n",
> +            (unsigned long long)val, (unsigned int)addr);
> +
> +    if (addr > CAN_SJA_MEM_SIZE) {
> +        return ;
> +    }
> +
> +    if (s->clock & 0x80) { /* PeliCAN Mode */
> +        switch (addr) {
> +        case SJA_MOD: /* Mode register */
> +            s->mode = 0x1f & val;
> +            if ((s->mode & 0x01) && ((val & 0x01) == 0)) {
> +                /* Go to operation mode from reset mode. */
> +                if (s->mode & (1 << 3)) { /* Single mode. */
> +                    /* For EFF */
> +                    tmp = ((s->code_mask[0] << 21) & (0xff << 21)) |
> +                          ((s->code_mask[1] << 13) & (0xff << 13)) |
> +                          ((s->code_mask[2] <<  5) & (0xff <<  5)) |
> +                          ((s->code_mask[3] >>  3) & 0x1f) |
> +                          (1 << 31);
> +                    s->filter[0].can_id = tmp;
> +
> +                    tmp = ((s->code_mask[4] << 21) & (0xff << 21)) |
> +                          ((s->code_mask[5] << 13) & (0xff << 13)) |
> +                          ((s->code_mask[6] <<  5) & (0xff <<  5)) |
> +                          ((s->code_mask[7] >>  3) & 0x1f) |
> +                          (7 << 29);
> +                    s->filter[0].can_mask = ~tmp | (1 << 31);
> +
> +                    if (s->code_mask[3] & (1 << 2)) { /* RTR */
> +                        s->filter[0].can_id |= (1 << 30);
> +                    }
> +                    if (!(s->code_mask[7] & (1 << 2))) {
> +                        s->filter[0].can_mask |= (1 << 30);
> +                    }
> +
> +                    /* For SFF */
> +                    tmp = ((s->code_mask[0] <<  3) & (0xff <<  3)) |
> +                          ((s->code_mask[1] >>  5) & 0x07);
> +                    s->filter[1].can_id = tmp;
> +
> +                    tmp = ((s->code_mask[4] <<  3) & (0xff <<  3)) |
> +                          ((s->code_mask[5] >>  5) & 0x07) |
> +                          (0xff << 11) | (0xff << 19) | (0x0f << 27);
> +                    s->filter[1].can_mask = ~tmp | (1 << 31);
> +
> +                    if (s->code_mask[1] & (1 << 4)) { /* RTR */
> +                        s->filter[1].can_id |= (1 << 30);
> +                    }
> +                    if (!(s->code_mask[5] & (1 << 4))) {
> +                        s->filter[1].can_mask |= (1 << 30);
> +                    }
> +
> +                    can_bus_client_set_filters(&s->bus_client, s->filter, 2);
> +                } else { /* Dual mode */
> +                    /* For EFF */
> +                    tmp = ((s->code_mask[0] << 21) & (0xff << 21)) |
> +                          ((s->code_mask[1] << 13) & (0xff << 13)) |
> +                          (1 << 31);
> +                    s->filter[0].can_id = tmp;
> +
> +                    tmp = ((s->code_mask[4] << 21) & (0xff << 21)) |
> +                          ((s->code_mask[5] << 13) & (0xff << 13)) |
> +                          (0xff << 5) | (0xff >> 3) |
> +                          (7 << 29);
> +                    s->filter[0].can_mask = ~tmp | (1 << 31);
> +
> +
> +                    tmp = ((s->code_mask[2] << 21) & (0xff << 21)) |
> +                          ((s->code_mask[3] << 13) & (0xff << 13)) |
> +                          (1 << 31);
> +                    s->filter[1].can_id = tmp;
> +
> +                    tmp = ((s->code_mask[6] << 21) & (0xff << 21)) |
> +                          ((s->code_mask[7] << 13) & (0xff << 13)) |
> +                          (0xff << 5) | (0xff >> 3) |
> +                          (7 << 29);
> +                    s->filter[1].can_mask = ~tmp | (1 << 31);
> +
> +                    /* For SFF */
> +                    tmp = ((s->code_mask[0] <<  3) & (0xff <<  3)) |
> +                          ((s->code_mask[1] >>  5) & 0x07);
> +                    s->filter[2].can_id = tmp;
> +
> +                    tmp = ((s->code_mask[4] <<  3) & (0xff <<  3)) |
> +                          ((s->code_mask[5] >>  5) & 0x07) |
> +                          (0xff << 11) | (0xff << 19) | (0x0f << 27);
> +                    s->filter[2].can_mask = ~tmp | (1 << 31);
> +
> +                    if (s->code_mask[1] & (1 << 4)) { /* RTR */
> +                        s->filter[2].can_id |= (1 << 30);
> +                    }
> +                    if (!(s->code_mask[5] & (1 << 4))) {
> +                        s->filter[2].can_mask |= (1 << 30);
> +                    }
> +
> +                    tmp = ((s->code_mask[2] <<  3) & (0xff <<  3)) |
> +                          ((s->code_mask[3] >>  5) & 0x07);
> +                    s->filter[3].can_id = tmp;
> +
> +                    tmp = ((s->code_mask[6] <<  3) & (0xff <<  3)) |
> +                          ((s->code_mask[7] >>  5) & 0x07) |
> +                          (0xff << 11) | (0xff << 19) | (0x0f << 27);
> +                    s->filter[3].can_mask = ~tmp | (1 << 31);
> +
> +                    if (s->code_mask[3] & (1 << 4)) { /* RTR */
> +                        s->filter[3].can_id |= (1 << 30);
> +                    }
> +                    if (!(s->code_mask[7] & (1 << 4))) {
> +                        s->filter[3].can_mask |= (1 << 30);
> +                    }
> +
> +                    can_bus_client_set_filters(&s->bus_client, s->filter, 4);
> +                }
> +
> +                s->rxmsg_cnt = 0;
> +                s->rx_cnt = 0;
> +            }
> +            break;
> +
> +        case SJA_CMR: /* Command register. */
> +            if (0x01 & val) { /* Send transmission request. */
> +                buff2frameP(s->tx_buff, &frame);
> +#ifdef DEBUG_FILTER
> +                can_display_msg(&frame); printf("\n");
> +#endif
> +                /*
> +                 * Clear transmission complete status,
> +                 * and Transmit Buffer Status.
> +                 * write to the backends.
> +                 */
> +                s->statusP &= ~(3 << 2);
> +
> +                can_bus_client_send(&s->bus_client, &frame, 1);
> +                s->statusP |= (3 << 2); /* Set transmission complete status, */
> +                                       /* and Transmit Buffer Status. */
> +                s->statusP &= ~(1 << 5); /* Clear transmit status. */
> +                s->interruptP |= 0x02;
> +                if (s->interrupt_en & 0x02) {
> +                    s->irq_raise(s->irq_opaque);
> +                }
> +            } else if (0x04 & val) { /* Release Receive Buffer */
> +                if (s->rxmsg_cnt <= 0) {
> +                    break;
> +                }
> +
> +                tmp8 = s->rx_buff[s->rxbuf_start]; count = 0;
> +                if (tmp8 & (1 << 7)) { /* EFF */
> +                    count += 2;
> +                }
> +                count += 3;
> +                if (!(tmp8 & (1 << 6))) { /* DATA */
> +                    count += (tmp8 & 0x0f);
> +                }
> +                s->rxbuf_start += count;
> +                s->rxbuf_start %= SJA_RCV_BUF_LEN;
> +
> +                s->rx_cnt -= count;
> +                s->rxmsg_cnt--;
> +                if (s->rxmsg_cnt == 0) {
> +                    s->statusP &= ~(1 << 0);
> +                    s->interruptP &= ~(1 << 0);
> +                }
> +                if ((s->interrupt_en & 0x01) && (s->interruptP == 0)) {
> +                    /* no other interrupts. */
> +                    s->irq_lower(s->irq_opaque);
> +                }
> +            } else if (0x08 & val) { /* Clear data overrun */
> +                s->statusP &= ~(1 << 1);
> +                s->interruptP &= ~(1 << 3);
> +                if ((s->interrupt_en & 0x80) && (s->interruptP == 0)) {
> +                    /* no other interrupts. */
> +                    s->irq_lower(s->irq_opaque);
> +                }
> +            }
> +            break;
> +        case SJA_SR: /* Status register */
> +        case SJA_IR: /* Interrupt register */
> +            break; /* Do nothing */
> +        case SJA_IER: /* Interrupt enable register */
> +            s->interrupt_en = val;
> +            break;
> +        case 16: /* RX frame information addr16-28. */
> +            s->statusP |= (1 << 5); /* Set transmit status. */
> +        case 17:
> +        case 18:
> +        case 19:
> +        case 20:
> +        case 21:
> +        case 22:
> +        case 23:
> +        case 24:
> +        case 25:
> +        case 26:
> +        case 27:
> +        case 28:
> +            if (s->mode & 0x01) { /* Reset mode */
> +                if (addr < 24) {
> +                    s->code_mask[addr - 16] = val;
> +                }
> +            } else { /* Operation mode */
> +                s->tx_buff[addr - 16] = val; /* Store to TX buffer directly. */
> +            }
> +            break;
> +        case SJA_CDR:
> +            s->clock = val;
> +            break;
> +        }
> +    } else { /* Basic Mode */
> +        switch (addr) {
> +        case SJA_BCAN_CTR: /* Control register, addr 0 */
> +            if ((s->control & 0x01) && ((val & 0x01) == 0)) {
> +                /* Go to operation mode from reset mode. */
> +                s->filter[0].can_id = (s->code << 3) & (0xff << 3);
> +                tmp = (~(s->mask << 3)) & (0xff << 3);
> +                tmp |= (1 << 31);/* Only Basic CAN Frame. */
> +                s->filter[0].can_mask = tmp;
> +                can_bus_client_set_filters(&s->bus_client, s->filter, 1);
> +
> +                s->rxmsg_cnt = 0;
> +                s->rx_cnt = 0;
> +            } else if (!(s->control & 0x01) && !(val & 0x01)) {
> +                can_sja_software_reset(s);
> +            }
> +
> +            s->control = 0x1f & val;
> +            break;
> +        case SJA_BCAN_CMR: /* Command register, addr 1 */
> +            if (0x01 & val) { /* Send transmission request. */
> +                buff2frameB(s->tx_buff, &frame);
> +#ifdef DEBUG_FILTER
> +                can_display_msg(&frame); printf("\n");
> +#endif
> +                /*
> +                 * Clear transmission complete status,
> +                 * and Transmit Buffer Status.
> +                 */
> +                s->statusB &= ~(3 << 2);
> +
> +                /* write to the backends. */
> +                can_bus_client_send(&s->bus_client, &frame, 1);
> +                s->statusB |= (3 << 2); /* Set transmission complete status, */
> +                                       /* and Transmit Buffer Status. */
> +                s->statusB &= ~(1 << 5); /* Clear transmit status. */
> +                s->interruptB |= 0x02;
> +                if (s->control & 0x04) {
> +                    s->irq_raise(s->irq_opaque);
> +                }
> +            } else if (0x04 & val) { /* Release Receive Buffer */
> +                if (s->rxmsg_cnt <= 0) {
> +                    break;
> +                }
> +
> +                qemu_mutex_lock(&s->rx_lock);
> +                tmp8 = s->rx_buff[(s->rxbuf_start + 1) % SJA_RCV_BUF_LEN];
> +                count = 2 + (tmp8 & 0x0f);
> +#ifdef DEBUG_FILTER
> +                printf("\nRelease");
> +                for (i = 0; i < count; i++) {
> +                    printf(" %02X", s->rx_buff[(s->rxbuf_start + i) %
> +                                    SJA_RCV_BUF_LEN]);
> +                }
> +                for (; i < 11; i++) {
> +                    printf("   ");
> +                }
> +                printf("==== cnt=%d, count=%d\n", s->rx_cnt, count);
> +#endif
> +                s->rxbuf_start += count;
> +                s->rxbuf_start %= SJA_RCV_BUF_LEN;
> +                s->rx_cnt -= count;
> +                s->rxmsg_cnt--;
> +                qemu_mutex_unlock(&s->rx_lock);
> +
> +                if (s->rxmsg_cnt == 0) {
> +                    s->statusB &= ~(1 << 0);
> +                    s->interruptB &= ~(1 << 0);
> +                }
> +                if ((s->control & 0x02) && (s->interruptB == 0)) {
> +                    /* no other interrupts. */
> +                    s->irq_lower(s->irq_opaque);
> +                }
> +            } else if (0x08 & val) { /* Clear data overrun */
> +                s->statusB &= ~(1 << 1);
> +                s->interruptB &= ~(1 << 3);
> +                if ((s->control & 0x10) && (s->interruptB == 0)) {
> +                    /* no other interrupts. */
> +                    s->irq_lower(s->irq_opaque);
> +                }
> +            }
> +            break;
> +        case 4:
> +            s->code = val;
> +            break;
> +        case 5:
> +            s->mask = val;
> +            break;
> +        case 10:
> +            s->statusB |= (1 << 5); /* Set transmit status. */
> +        case 11:
> +        case 12:
> +        case 13:
> +        case 14:
> +        case 15:
> +        case 16:
> +        case 17:
> +        case 18:
> +        case 19:
> +            if ((s->control & 0x01) == 0) { /* Operation mode */
> +                s->tx_buff[addr - 10] = val; /* Store to TX buffer directly. */
> +            }
> +            break;
> +        case SJA_CDR:
> +            s->clock = val;
> +            break;
> +        }
> +    }
> +}
> +
> +uint64_t can_sja_mem_read(CanSJA1000State *s, hwaddr addr, unsigned size)
> +{
> +    uint64_t temp = 0;
> +
> +    DPRINTF("read addr 0x%x", (unsigned int)addr);
> +
> +    if (addr > CAN_SJA_MEM_SIZE) {
> +        return 0;
> +    }
> +
> +    if (s->clock & 0x80) { /* PeliCAN Mode */
> +        switch (addr) {
> +        case SJA_MOD: /* Mode register, addr 0 */
> +            temp = s->mode;
> +            break;
> +        case SJA_CMR: /* Command register, addr 1 */
> +            temp = 0x00; /* Command register, cannot be read. */
> +            break;
> +        case SJA_SR: /* Status register, addr 2 */
> +            temp = s->statusP;
> +            break;
> +        case SJA_IR: /* Interrupt register, addr 3 */
> +            temp = s->interruptP;
> +            s->interruptP = 0;
> +            if (s->rxmsg_cnt) {
> +                s->interruptP |= (1 << 0); /* Receive interrupt. */
> +                break;
> +            }
> +            s->irq_lower(s->irq_opaque);
> +            break;
> +        case SJA_IER: /* Interrupt enable register, addr 4 */
> +            temp = s->interrupt_en;
> +            break;
> +        case 5: /* Reserved */
> +        case 6: /* Bus timing 0, hardware related, not support now. */
> +        case 7: /* Bus timing 1, hardware related, not support now. */
> +        case 8: /*
> +                 * Output control register, hardware related,
> +                 * not supported for now.
> +                 */
> +        case 9: /* Test. */
> +        case 10: /* Reserved */
> +        case 11:
> +        case 12:
> +        case 13:
> +        case 14:
> +        case 15:
> +            temp = 0x00;
> +            break;
> +
> +        case 16:
> +        case 17:
> +        case 18:
> +        case 19:
> +        case 20:
> +        case 21:
> +        case 22:
> +        case 23:
> +        case 24:
> +        case 25:
> +        case 26:
> +        case 27:
> +        case 28:
> +            if (s->mode & 0x01) { /* Reset mode */
> +                if (addr < 24) {
> +                    temp = s->code_mask[addr - 16];
> +                } else {
> +                    temp = 0x00;
> +                }
> +            } else { /* Operation mode */
> +                temp = s->rx_buff[(s->rxbuf_start + addr - 16) %
> +                       SJA_RCV_BUF_LEN];
> +            }
> +            break;
> +        case SJA_CDR:
> +            temp = s->clock;
> +            break;
> +        default:
> +            temp = 0xff;
> +        }
> +    } else { /* Basic Mode */
> +        switch (addr) {
> +        case SJA_BCAN_CTR: /* Control register, addr 0 */
> +            temp = s->control;
> +            break;
> +        case SJA_BCAN_SR: /* Status register, addr 2 */
> +            temp = s->statusB;
> +            break;
> +        case SJA_BCAN_IR: /* Interrupt register, addr 3 */
> +            temp = s->interruptB;
> +            s->interruptB = 0;
> +            if (s->rxmsg_cnt) {
> +                s->interruptB |= (1 << 0); /* Receive interrupt. */
> +                break;
> +            }
> +            s->irq_lower(s->irq_opaque);
> +            break;
> +        case 4:
> +            temp = s->code;
> +            break;
> +        case 5:
> +            temp = s->mask;
> +            break;
> +        case 20:
> +#ifdef DEBUG_FILTER
> +            printf("Read   ");
> +#endif
> +        case 21:
> +        case 22:
> +        case 23:
> +        case 24:
> +        case 25:
> +        case 26:
> +        case 27:
> +        case 28:
> +        case 29:
> +            temp = s->rx_buff[(s->rxbuf_start + addr - 20) % SJA_RCV_BUF_LEN];
> +#ifdef DEBUG_FILTER
> +            printf(" %02X", (unsigned int)(temp & 0xff));
> +#endif
> +            break;
> +        case 31:
> +            temp = s->clock;
> +            break;
> +        default:
> +            temp = 0xff;
> +            break;
> +        }
> +    }
> +    DPRINTF("     %d bytes of 0x%lx from addr %d\n",
> +            size, (long unsigned int)temp, (int)addr);
> +
> +    return temp;
> +}
> +
> +int can_sja_can_receive(CanBusClientState *client)
> +{
> +    CanSJA1000State *s = container_of(client, CanSJA1000State, bus_client);
> +
> +    if (s->clock & 0x80) { /* PeliCAN Mode */
> +        if (s->mode & 0x01) { /* reset mode. */
> +            return 0;
> +        }
> +    } else { /* BasicCAN mode */
> +        if (s->control & 0x01) {
> +            return 0;
> +        }
> +    }
> +
> +    return 1; /* always return 1, when operation mode */
> +}
> +
> +ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
> +                        size_t frames_cnt)
> +{
> +    CanSJA1000State *s = container_of(client, CanSJA1000State, bus_client);
> +    static uint8_t rcv[SJA_MSG_MAX_LEN];
> +    int i;
> +    int ret = -1;
> +    const qemu_can_frame *frame = frames;
> +
> +    if (frames_cnt <= 0) {
> +        return 0;
> +    }
> +#ifdef DEBUG_FILTER
> +    printf("#################################################\n");
> +    can_display_msg(frame);
> +#endif
> +
> +    qemu_mutex_lock(&s->rx_lock); /* Just do it quickly :) */
> +    if (s->clock & 0x80) { /* PeliCAN Mode */
> +        s->statusP |= (1 << 4); /* the CAN controller is receiving a message */
> +
> +        if (can_sja_accept_filter(s, frame) == 0) {
> +            s->statusP &= ~(1 << 4);
> +#ifdef DEBUG_FILTER
> +            printf("     NOT\n");
> +#endif
> +            goto fail;
> +        }
> +
> +        ret = frame2buffP(frame, rcv);
> +        if (ret < 0) {
> +            s->statusP &= ~(1 << 4);
> +#ifdef DEBUG_FILTER
> +            printf("     ERR\n");
> +#endif
> +            goto fail; /* maybe not support now. */
> +        }
> +
> +        if (s->rx_cnt + ret > SJA_RCV_BUF_LEN) { /* Data overrun. */
> +            s->statusP |= (1 << 1); /* Overrun status */
> +            s->interruptP |= (1 << 3);
> +            if (s->interrupt_en & (1 << 3)) { /* Overrun interrupt enable */
> +                s->irq_raise(s->irq_opaque);
> +            }
> +            s->statusP &= ~(1 << 4);
> +#ifdef DEBUG_FILTER
> +            printf("     OVER\n");
> +#endif
> +            goto fail;
> +        }
> +        s->rx_cnt += ret;
> +        s->rxmsg_cnt++;
> +#ifdef DEBUG_FILTER
> +        printf("     OK\n");
> +#endif
> +
> +        for (i = 0; i < ret; i++) {
> +            s->rx_buff[(s->rx_ptr++) % SJA_RCV_BUF_LEN] = rcv[i];
> +        }
> +        s->rx_ptr %= SJA_RCV_BUF_LEN; /* update the pointer. */
> +
> +        s->statusP |= 0x01; /* Set the Receive Buffer Status. DS-p23 */
> +        s->interruptP |= 0x01;
> +        s->statusP &= ~(1 << 4);
> +        s->statusP |= (1 << 0);
> +        if (s->interrupt_en & 0x01) { /* Receive Interrupt enable. */
> +            s->irq_raise(s->irq_opaque);
> +        }
> +    } else { /* BasicCAN mode */
> +        s->statusB |= (1 << 4); /* the CAN controller is receiving a message */
> +
> +        ret = frame2buffB(frame, rcv);
> +        if (ret < 0) {
> +            s->statusB &= ~(1 << 4);
> +#ifdef DEBUG_FILTER
> +            printf("     NOT\n");
> +#endif
> +            goto fail; /* maybe not support now. */
> +        }
> +
> +        if (s->rx_cnt + ret > SJA_RCV_BUF_LEN) { /* Data overrun. */
> +            s->statusB |= (1 << 1); /* Overrun status */
> +            s->statusB &= ~(1 << 4);
> +            s->interruptB |= (1 << 3);
> +            if (s->control & (1 << 4)) { /* Overrun interrupt enable */
> +                s->irq_raise(s->irq_opaque);
> +            }
> +#ifdef DEBUG_FILTER
> +            printf("     OVER\n");
> +#endif
> +            goto fail;
> +        }
> +        s->rx_cnt += ret;
> +        s->rxmsg_cnt++;
> +#ifdef DEBUG_FILTER
> +        printf("     OK\n");
> +        printf("RCV B ret=%2d, ptr=%2d cnt=%2d msg=%2d\n",
> +               ret, s->rx_ptr, s->rx_cnt, s->rxmsg_cnt);
> +#endif
> +        for (i = 0; i < ret; i++) {
> +            s->rx_buff[(s->rx_ptr++) % SJA_RCV_BUF_LEN] = rcv[i];
> +        }
> +        s->rx_ptr %= SJA_RCV_BUF_LEN; /* update the pointer. */
> +
> +        s->statusB |= 0x01; /* Set the Receive Buffer Status. DS-p15 */
> +        s->statusB &= ~(1 << 4);
> +        s->interruptB |= 0x01;
> +        if (s->control & 0x02) { /* Receive Interrupt enable. */
> +            s->irq_raise(s->irq_opaque);
> +        }
> +    }
> +    ret = 1;
> +fail:
> +    qemu_mutex_unlock(&s->rx_lock);
> +
> +    return ret;
> +}
> +
> +static CanBusClientInfo can_sja_bus_client_info = {
> +    .can_receive = can_sja_can_receive,
> +    .receive = can_sja_receive,
> +    .cleanup = NULL,
> +    .poll = NULL
> +};
> +
> +
> +int can_sja_connect_to_bus(CanSJA1000State *s, CanBusState *bus)
> +{
> +    s->bus_client.info = &can_sja_bus_client_info;
> +
> +    if (can_bus_insert_client(bus, &s->bus_client) < 0) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +void can_sja_disconnect(CanSJA1000State *s)
> +{
> +    can_bus_remove_client(&s->bus_client);
> +}
> +
> +int can_sja_init(CanSJA1000State *s, CanSJAIrqRaiseLower *irq_raise,
> +                 CanSJAIrqRaiseLower *irq_lower, void *irq_opaque)
> +{
> +    qemu_mutex_init(&s->rx_lock);
> +
> +    s->irq_raise = irq_raise;
> +    s->irq_lower = irq_lower;
> +    s->irq_opaque = irq_opaque;
> +
> +    s->irq_lower(s->irq_opaque);
> +
> +    can_sja_hardware_reset(s);
> +
> +    return 0;
> +}
> +
> +void can_sja_exit(CanSJA1000State *s)
> +{
> +    qemu_mutex_destroy(&s->rx_lock);
> +}
> +
> +const VMStateDescription vmstate_qemu_can_filter = {
> +    .name = "qemu_can_filter",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .minimum_version_id_old = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(can_id, qemu_can_filter),
> +        VMSTATE_UINT32(can_mask, qemu_can_filter),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +/* VMState is needed for live migration of QEMU images */
> +const VMStateDescription vmstate_can_sja = {
> +    .name = "can_sja",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .minimum_version_id_old = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(mode, CanSJA1000State),
> +
> +        VMSTATE_UINT8(statusP, CanSJA1000State),
> +        VMSTATE_UINT8(interruptP, CanSJA1000State),
> +        VMSTATE_UINT8(interrupt_en, CanSJA1000State),
> +        VMSTATE_UINT8(rxmsg_cnt, CanSJA1000State),
> +        VMSTATE_UINT8(rxbuf_start, CanSJA1000State),
> +        VMSTATE_UINT8(clock, CanSJA1000State),
> +
> +        VMSTATE_BUFFER(code_mask, CanSJA1000State),
> +        VMSTATE_BUFFER(tx_buff, CanSJA1000State),
> +
> +        VMSTATE_BUFFER(rx_buff, CanSJA1000State),
> +
> +        VMSTATE_UINT32(rx_ptr, CanSJA1000State),
> +        VMSTATE_UINT32(rx_cnt, CanSJA1000State),
> +
> +        VMSTATE_UINT8(control, CanSJA1000State),
> +
> +        VMSTATE_UINT8(statusB, CanSJA1000State),
> +        VMSTATE_UINT8(interruptB, CanSJA1000State),
> +        VMSTATE_UINT8(code, CanSJA1000State),
> +        VMSTATE_UINT8(mask, CanSJA1000State),
> +
> +        VMSTATE_STRUCT_ARRAY(filter, CanSJA1000State, 4, 0,
> +                             vmstate_qemu_can_filter, qemu_can_filter),
> +
> +
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> diff --git a/hw/can/can_sja1000.h b/hw/can/can_sja1000.h
> new file mode 100644
> index 0000000000..725fa2bf78
> --- /dev/null
> +++ b/hw/can/can_sja1000.h
> @@ -0,0 +1,173 @@
> +/*
> + * CAN device - SJA1000 chip emulation for QEMU
> + *
> + * Copyright (c) 2013-2014 Jin Yang
> + * Copyright (c) 2014 Pavel Pisa
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
> +#ifndef HW_CAN_SJA1000_H
> +#define HW_CAN_SJA1000_H
> +
> +#include "can/can_emu.h"
> +
> +#define CAN_SJA_MEM_SIZE      128
> +
> +/* The max size for a message buffer, EFF and DLC=8, DS-p39 */
> +#define SJA_MSG_MAX_LEN       13
> +/* The receive buffer size. */
> +#define SJA_RCV_BUF_LEN       64
> +
> +//#define DEBUG_CAN
> +
> +#ifdef DEBUG_CAN
> +#define DPRINTF(fmt, ...) \
> +    do { fprintf(stderr, "[cansja]: " fmt , ## __VA_ARGS__); } while (0)
> +#else
> +#define DPRINTF(fmt, ...) \
> +    do {} while (0)
> +#endif
> +
> +typedef void (CanSJAIrqRaiseLower)(void *opaque);
> +
> +typedef struct CanSJA1000State {
> +    /* Some registers ... */
> +    uint8_t         mode;          /* PeliCAN, addr 0, Mode register, DS-p26 */
> +                                   /* PeliCAN, addr 1, Command register */
> +    uint8_t         statusP;       /* PeliCAN, addr 2, Status register, p15 */
> +    uint8_t         interruptP;    /* PeliCAN, addr 3, Interrupt register */
> +    uint8_t         interrupt_en;  /* PeliCAN, addr 4, Interrupt Enable register */
> +    uint8_t         rxmsg_cnt;     /* PeliCAN, addr 29, RX message counter. DS-p49 */
> +    uint8_t         rxbuf_start;   /* PeliCAN, addr 30, RX buffer start address, DS-p49 */
> +    uint8_t         clock;         /* PeliCAN, addr 31, Clock Divider register, DS-p55 */
> +
> +    uint8_t         code_mask[8];  /* PeliCAN, addr 16~23 */
> +    uint8_t         tx_buff[13];   /* PeliCAN, addr 96~108, transmit buffer */
> +                                   /* BasicCAN, addr 10~19, transmit buffer */
> +
> +    uint8_t         rx_buff[SJA_RCV_BUF_LEN];  /* 32~95, 64bytes */
> +    uint32_t        rx_ptr;        /* Count by bytes. */
> +    uint32_t        rx_cnt;        /* Count by bytes. */
> +
> +    uint8_t         control;       /* BasicCAN, addr 0, Control register */
> +                                   /* BasicCAN, addr 1, Command register */
> +    uint8_t         statusB;       /* BasicCAN, addr 2, Status register */
> +    uint8_t         interruptB;    /* BasicCAN, addr 3, Interrupt register */
> +    uint8_t         code;          /* BasicCAN, addr 4, Acceptance code register */
> +    uint8_t         mask;          /* BasicCAN, addr 5, Acceptance mask register */
> +
> +    qemu_can_filter filter[4];
> +
> +    QemuMutex       rx_lock;
> +    CanSJAIrqRaiseLower *irq_raise;
> +    CanSJAIrqRaiseLower *irq_lower;
> +    void            *irq_opaque;
> +    CanBusClientState bus_client;
> +} CanSJA1000State;
> +
> +/* PeliCAN mode */
> +enum SJA1000_PeliCAN_regs {
> +        SJA_MOD      = 0x00,
> +/* Command register */
> +        SJA_CMR      = 0x01,
> +/* Status register */
> +        SJA_SR       = 0x02,
> +/* Interrupt register */
> +        SJA_IR       = 0x03,
> +/* Interrupt Enable */
> +        SJA_IER      = 0x04,
> +/* Bus Timing register 0 */
> +        SJA_BTR0     = 0x06,
> +/* Bus Timing register 1 */
> +        SJA_BTR1     = 0x07,
> +/* Output Control register */
> +        SJA_OCR      = 0x08,
> +/* Arbitration Lost Capture */
> +        SJA_ALC      = 0x0b,
> +/* Error Code Capture */
> +        SJA_ECC      = 0x0c,
> +/* Error Warning Limit */
> +        SJA_EWLR     = 0x0d,
> +/* RX Error Counter */
> +        SJA_RXERR    = 0x0e,
> +/* TX Error Counter */
> +        SJA_TXERR0   = 0x0e,
> +        SJA_TXERR1   = 0x0f,
> +/* Rx Message Counter (number of msgs. in RX FIFO */
> +        SJA_RMC      = 0x1d,
> +/* Rx Buffer Start Addr. (address of current MSG) */
> +        SJA_RBSA     = 0x1e,
> +/* Transmit Buffer (write) Receive Buffer (read) Frame Information */
> +        SJA_FRM      = 0x10,
> +/* ID bytes (11 bits in 0 and 1 or 16 bits in 0,1 and 13 bits in 2,3 (extended)) */
> +        SJA_ID0      = 0x11, SJA_ID1 = 0x12,
> +/* ID cont. for extended frames */
> +        SJA_ID2      = 0x13, SJA_ID3 = 0x14,
> +/* Data start standard frame */
> +        SJA_DATS     = 0x13,
> +/* Data start extended frame */
> +        SJA_DATE     = 0x15,
> +/* Acceptance Code (4 bytes) in RESET mode */
> +        SJA_ACR0     = 0x10,
> +/* Acceptance Mask (4 bytes) in RESET mode */
> +        SJA_AMR0     = 0x14,
> +/* 4 bytes */
> +        SJA_PeliCAN_AC_LEN = 4,
> +/* Clock Divider */
> +        SJA_CDR      = 0x1f
> +};
> +
> +
> +/* PeliCAN mode */
> +enum SJA1000_BasicCAN_regs {
> +        SJA_BCAN_CTR = 0x00,
> +/* Command register */
> +        SJA_BCAN_CMR = 0x01,
> +/* Status register */
> +        SJA_BCAN_SR  = 0x02,
> +/* Interrupt register */
> +        SJA_BCAN_IR  = 0x03
> +};
> +
> +void can_sja_hardware_reset(CanSJA1000State *s);
> +
> +void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
> +                       unsigned size);
> +
> +uint64_t can_sja_mem_read(CanSJA1000State *s, hwaddr addr, unsigned size);
> +
> +int can_sja_connect_to_bus(CanSJA1000State *s, CanBusState *bus);
> +
> +void can_sja_disconnect(CanSJA1000State *s);
> +
> +int can_sja_init(CanSJA1000State *s, CanSJAIrqRaiseLower *irq_raise,
> +                 CanSJAIrqRaiseLower *irq_lower, void *irq_opaque);
> +
> +void can_sja_exit(CanSJA1000State *s);
> +
> +int can_sja_can_receive(CanBusClientState *client);
> +
> +ssize_t can_sja_receive(CanBusClientState *client,
> +                        const qemu_can_frame *frames, size_t frames_cnt);
> +
> +extern const VMStateDescription vmstate_can_sja;
> +
> +#endif
> diff --git a/include/can/can_emu.h b/include/can/can_emu.h
> new file mode 100644
> index 0000000000..86b35aef32
> --- /dev/null
> +++ b/include/can/can_emu.h
> @@ -0,0 +1,133 @@
> +/*
> + * CAN common CAN bus emulation support
> + *
> + * Copyright (c) 2013-2014 Jin Yang
> + * Copyright (c) 2014 Pavel Pisa
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
> +#if defined(__GNUC__) || defined(__linux__)
> +    #define QEMU_CAN_FRAME_DATA_ALIGN __attribute__((aligned(8)))
> +#else
> +    #define QEMU_CAN_FRAME_DATA_ALIGN
> +#endif
> +
> +typedef struct qemu_can_frame {
> +    qemu_canid_t    can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> +    uint8_t         can_dlc; /* data length code: 0 .. 8 */
> +    uint8_t         data[8] QEMU_CAN_FRAME_DATA_ALIGN;
> +} qemu_can_frame;
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
> + * The filter can be inverted (CAN_INV_FILTER bit set in can_id) or it can
> + * filter for error message frames (CAN_ERR_FLAG bit set in mask).
> + */
> +typedef struct qemu_can_filter {
> +    qemu_canid_t    can_id;
> +    qemu_canid_t    can_mask;
> +} qemu_can_filter;
> +
> +#define CAN_INV_FILTER 0x20000000U /* to be set in qemu_can_filter.can_id */
> +
> +typedef struct CanBusClientState CanBusClientState;
> +typedef struct CanBusState CanBusState;
> +
> +typedef void (CanBusClientPoll)(CanBusClientState *, bool enable);
> +typedef int (CanBusClientCanReceive)(CanBusClientState *);
> +typedef ssize_t (CanBusClientReceive)(CanBusClientState *,
> +                 const struct qemu_can_frame *frames, size_t frames_cnt);
> +typedef void (CanBusClientCleanup) (CanBusClientState *);
> +typedef void (CanBusClientDestructor)(CanBusClientState *);
> +
> +typedef struct CanBusClientInfo {
> +    /*CanBusClientOptionsKind type;*/
> +    size_t size;
> +    CanBusClientCanReceive *can_receive;
> +    CanBusClientReceive *receive;
> +    CanBusClientCleanup *cleanup;
> +    CanBusClientPoll *poll;
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
> +    CanBusClientDestructor *destructor;
> +    /*unsigned int queue_index;*/
> +    /*unsigned rxfilter_notify_enabled:1;*/
> +};
> +
> +struct CanBusState {
> +    char *name;
> +    QTAILQ_HEAD(, CanBusClientState) clients;
> +    QTAILQ_ENTRY(CanBusState) next;
> +};
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
