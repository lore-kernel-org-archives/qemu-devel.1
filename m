Received: from eggs.gnu.org ([2001:4830:134:3::10]:57984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYy9B-0008Mb-KD
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYy9A-0003DT-4A
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:29:29 -0400
References: <20180627232951.14725-1-laurent@vivier.eu>
	<20180627232951.14725-3-laurent@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9bc31a5c-aeb8-04c5-dbc8-cb8d2ceaa0dc@ilande.co.uk>
Date: Fri, 29 Jun 2018 19:28:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180627232951.14725-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 02/10] ADB: VIA probes ADB bus when it is
 idle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 28/06/18 00:29, Laurent Vivier wrote:

> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/input/adb-kbd.c        |   4 ++
>   hw/input/adb-mouse.c      |   4 ++
>   hw/input/adb.c            | 115 ++++++++++++++++++++++++++++++++++++++++++++++
>   hw/misc/mac_via.c         |  56 ++++++++++++++++++++++
>   include/hw/input/adb.h    |  10 ++++
>   include/hw/misc/mac_via.h |   1 +
>   6 files changed, 190 insertions(+)
> 
> diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
> index b026e9d49f..f439e106bb 100644
> --- a/hw/input/adb-kbd.c
> +++ b/hw/input/adb-kbd.c
> @@ -195,6 +195,10 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
>       int keycode;
>       int olen;
>   
> +    if (obuf == NULL) {
> +        return s->count;
> +    }
> +
>       olen = 0;
>       if (s->count == 0) {
>           return 0;
> diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
> index 83833b0035..7615c252d5 100644
> --- a/hw/input/adb-mouse.c
> +++ b/hw/input/adb-mouse.c
> @@ -73,6 +73,10 @@ static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
>           return 0;
>       }
>   
> +    if (obuf == NULL) {
> +        return 2;
> +    }
> +
>       dx = s->dx;
>       if (dx < -63) {
>           dx = -63;

I think that these two hunks should be placed in a separate patch as 
they can potentially alter existing behaviour with the PPC Mac machines.

> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index bbb40aeef1..99852879d8 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -25,6 +25,17 @@
>   #include "hw/input/adb.h"
>   #include "adb-internal.h"
>   
> +#define ADB_POLL_FREQ 50
> +
> +/* Apple Macintosh Family Hardware Refenece
> + * Table 19-10 ADB transaction states
> + */
> +
> +#define STATE_NEW       0
> +#define STATE_EVEN      1
> +#define STATE_ODD       2
> +#define STATE_IDLE      3
> +
>   /* error codes */
>   #define ADB_RET_NOTPRESENT (-2)
>   
> @@ -84,6 +95,110 @@ int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
>       return olen;
>   }
>   
> +int adb_via_poll(ADBBusState *adb, int state, uint8_t *data)
> +{
> +    if (state != STATE_IDLE) {
> +        return 0;
> +    }
> +    if (adb->data_in_size < adb->data_in_index) {
> +        return 0;
> +    }
> +    if (adb->data_out_index != 0) {
> +        return 0;
> +    }
> +    adb->data_in_index = 0;
> +    adb->data_out_index = 0;
> +    adb->data_in_size = adb_poll(adb, adb->data_in, 0xffff);
> +    if (adb->data_in_size) {
> +        *data = adb->data_in[adb->data_in_index++];
> +        qemu_irq_raise(adb->data_ready);
> +    }
> +    return adb->data_in_size;
> +}
> +
> +int adb_send(ADBBusState *adb, int state, uint8_t data)
> +{
> +    switch (state) {
> +    case STATE_NEW:
> +        adb->data_out_index = 0;
> +        break;
> +    case STATE_EVEN:
> +        if ((adb->data_out_index & 1) == 0) {
> +            return 0;
> +        }
> +        break;
> +    case STATE_ODD:
> +        if (adb->data_out_index & 1) {
> +            return 0;
> +        }
> +        break;
> +    case STATE_IDLE:
> +        return 0;
> +    }
> +    adb->data_out[adb->data_out_index++] = data;
> +    qemu_irq_raise(adb->data_ready);
> +    return 1;
> +}
> +
> +int adb_receive(ADBBusState *adb, int state, uint8_t *data)
> +{
> +    switch (state) {
> +    case STATE_NEW:
> +        return 0;
> +    case STATE_EVEN:
> +        if (adb->data_in_size <= 0) {
> +            qemu_irq_raise(adb->data_ready);
> +            return 0;
> +        }
> +        if (adb->data_in_index >= adb->data_in_size) {
> +            *data = 0;
> +            qemu_irq_raise(adb->data_ready);
> +            return 1;
> +        }
> +        if ((adb->data_in_index & 1) == 0) {
> +            return 0;
> +        }
> +        break;
> +    case STATE_ODD:
> +        if (adb->data_in_size <= 0) {
> +            qemu_irq_raise(adb->data_ready);
> +            return 0;
> +        }
> +        if (adb->data_in_index >= adb->data_in_size) {
> +            *data = 0;
> +            qemu_irq_raise(adb->data_ready);
> +            return 1;
> +        }
> +        if (adb->data_in_index & 1) {
> +            return 0;
> +        }
> +        break;
> +    case STATE_IDLE:
> +        if (adb->data_out_index == 0) {
> +            return 0;
> +        }
> +        adb->data_in_size = adb_request(adb, adb->data_in,
> +                                        adb->data_out, adb->data_out_index);
> +        adb->data_out_index = 0;
> +        adb->data_in_index = 0;
> +        if (adb->data_in_size < 0) {
> +            *data = 0xff;
> +            qemu_irq_raise(adb->data_ready);
> +            return -1;
> +        }
> +        if (adb->data_in_size == 0) {
> +            return 0;
> +        }
> +        break;
> +    }
> +    *data = adb->data_in[adb->data_in_index++];
> +    qemu_irq_raise(adb->data_ready);
> +    if (*data == 0xff || *data == 0) {
> +        return 0;
> +    }
> +    return 1;
> +}
> +
>   static const TypeInfo adb_bus_type_info = {
>       .name = TYPE_ADB_BUS,
>       .parent = TYPE_BUS,

I'm not convinced that these changes should live in adb.c and would 
prefer them to live in mac_via.c.

For example with the CUDA/PMU PPC VIAs, the data is bit-banged over the 
port B pins and it is the responsibility of the CUDA/PMU device to 
maintain the state of transmission/reception itself and then just call 
adb_request().

I can see there is an argument here that the mac_via states are related 
to ADB physical wire states but my feeling is that this adds too much 
complexity within ADB itself.

Following on from this, I'd say that the comment in adb.c "/* XXX: move 
that to cuda ? */" is probably correct, because each different VIA will 
poll ADB in a slightly different way.

> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 586477ca9e..200121f798 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -424,6 +424,53 @@ static void via1_rtc_update(MacVIAState *m)
>       }
>   }
>   
> +static void via1_adb_update(MacVIAState *m)
> +{
> +    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&m->mos6522_via1);
> +    MOS6522State *s = MOS6522(v1s);
> +    int state;
> +    int ret;
> +
> +    state = (s->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
> +
> +    if (s->acr & VIA1ACR_vShiftOut) {
> +        /* output mode */
> +        ret = adb_send(&m->adb_bus, state, s->sr);
> +        if (ret > 0) {
> +            s->b &= ~VIA1B_vADBInt;
> +        } else {
> +            s->b |= VIA1B_vADBInt;
> +        }
> +    } else {
> +        /* input mode */
> +        ret = adb_receive(&m->adb_bus, state, &s->sr);
> +        if (ret > 0 && s->sr != 0xff) {
> +            s->b &= ~VIA1B_vADBInt;
> +        } else {
> +            s->b |= VIA1B_vADBInt;
> +        }
> +    }
> +}
> +
> +static void via_adb_poll(void *opaque)
> +{
> +    MacVIAState *m = opaque;
> +    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&m->mos6522_via1);
> +    MOS6522State *s = MOS6522(v1s);
> +    int state;
> +
> +    if (s->b & VIA1B_vADBInt) {
> +        state = (s->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
> +        if (adb_via_poll(&m->adb_bus, state, &s->sr)) {
> +            s->b &= ~VIA1B_vADBInt;
> +        }
> +    }
> +
> +    timer_mod(m->adb_poll_timer,
> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
> +}
> +
>   static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
>   {
>       MOS6522Q800VIA1State *s = opaque;
> @@ -486,6 +533,10 @@ static void mac_via_reset(DeviceState *dev)
>   {
>       MacVIAState *m = MAC_VIA(dev);
>   
> +    timer_mod(m->adb_poll_timer,
> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
> +
>       timer_mod(m->VBL_timer, (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 16630)
>                 / 16630 * 16630);
>   
> @@ -504,6 +555,7 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
>   
>       qemu_get_timedate(&tm, 0);
>       m->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
> +    m->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via_adb_poll, m);
>   }
>   
>   static void mac_via_init(Object *obj)
> @@ -553,6 +605,9 @@ static void mac_via_init(Object *obj)
>       /* ADB */
>       qbus_create_inplace((BusState *)&m->adb_bus, sizeof(m->adb_bus),
>                           TYPE_ADB_BUS, DEVICE(obj), "adb.0");
> +
> +    m->adb_bus.data_ready = qdev_get_gpio_in_named(DEVICE(obj), "via1-irq",
> +                                                   VIA1_IRQ_ADB_READY_BIT);
>   }
>   
>   static void mac_via_class_init(ObjectClass *oc, void *data)
> @@ -579,6 +634,7 @@ static void mos6522_q800_via1_portB_write(MOS6522State *s)
>       MacVIAState *m = container_of(v1s, MacVIAState, mos6522_via1);
>   
>       via1_rtc_update(m);
> +    via1_adb_update(m);
>   
>       v1s->last_b = s->b;
>   }
> diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
> index f99d478252..1888c5aab7 100644
> --- a/include/hw/input/adb.h
> +++ b/include/hw/input/adb.h
> @@ -76,6 +76,12 @@ struct ADBBusState {
>       ADBDevice *devices[MAX_ADB_DEVICES];
>       int nb_devices;
>       int poll_index;
> +    qemu_irq data_ready;
> +    int data_in_size;
> +    int data_in_index;
> +    int data_out_index;
> +    uint8_t data_in[128];
> +    uint8_t data_out[16];
>   };
>   
>   int adb_request(ADBBusState *s, uint8_t *buf_out,
> @@ -85,4 +91,8 @@ int adb_poll(ADBBusState *s, uint8_t *buf_out, uint16_t poll_mask);
>   #define TYPE_ADB_KEYBOARD "adb-keyboard"
>   #define TYPE_ADB_MOUSE "adb-mouse"
>   
> +int adb_via_poll(ADBBusState *s, int state, uint8_t *data);
> +int adb_send(ADBBusState *adb, int state, uint8_t data);
> +int adb_receive(ADBBusState *adb, int state, uint8_t *data);
> +
>   #endif /* ADB_H */
> diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
> index a3a972ccc5..85d8715b12 100644
> --- a/include/hw/misc/mac_via.h
> +++ b/include/hw/misc/mac_via.h
> @@ -96,6 +96,7 @@ typedef struct MacVIAState {
>   
>       /* ADB */
>       ADBBusState adb_bus;
> +    QEMUTimer *adb_poll_timer;
>   
>       /* external timers */
>       QEMUTimer *one_second_timer;
> 


ATB,

Mark.
