Received: from eggs.gnu.org ([2001:4830:134:3::10]:34087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA4to-0003J0-OD
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 22:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA4tj-0000pk-Ns
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 22:06:28 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:54513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA4tj-0000pW-IM
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 22:06:23 -0400
Received: by mail-qt0-x236.google.com with SMTP id z19so4994730qtg.11
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 19:06:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1509583771.git.pisa@cmp.felk.cvut.cz>
	<2661b1e6a4518eed929872a2d79f94c352f295a2.1509583771.git.pisa@cmp.felk.cvut.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7fc256b3-cb0f-c8e8-095e-824d749f5a0b@amsat.org>
Date: Wed, 1 Nov 2017 23:06:13 -0300
MIME-Version: 1.0
In-Reply-To: <2661b1e6a4518eed929872a2d79f94c352f295a2.1509583771.git.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] CAN bus simple messages transport
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
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

more comments after reading your next patch.

On 11/01/2017 10:00 PM, pisa@cmp.felk.cvut.cz wrote:
[...]
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

maybe you can import it in include/standard-headers/

(see scripts/update-linux-headers.sh)

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

^ this part should go in "include/hw/can/can.h"

and the following in "include/sysemu/can.h"?

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
