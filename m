Received: from eggs.gnu.org ([2001:4830:134:3::10]:59532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eljWm-0003Mm-5h
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 17:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eljWj-0000RZ-7e
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 17:58:20 -0500
References: <20180126144742.3636-1-lvivier@redhat.com>
	<1ad5086b-1704-0561-2d29-147d3d2ee6d3@ilande.co.uk>
	<3bb55aca-77fa-9ab7-4b13-98698d3c0008@redhat.com>
	<9f0f9819-f608-c326-f975-a3338d6fc24d@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <65da244c-1550-0292-a849-10c0dc1f35b0@ilande.co.uk>
Date: Tue, 13 Feb 2018 22:57:46 +0000
MIME-Version: 1.0
In-Reply-To: <9f0f9819-f608-c326-f975-a3338d6fc24d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/char: remove legacy interface
 escc_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Alexander Graf <agraf@suse.de>

On 13/02/18 13:01, Laurent Vivier wrote:

> Hi,
> 
> can a maintainer of one of the involved parts take this in his
> maintenance branch to have this merged?
> 
> Thanks,
> Laurent
> 
> On 29/01/2018 15:21, Laurent Vivier wrote:
>> Paolo,
>>
>> I forgot to cc: you for the "MAINTAINERS/Character devices/Odd Fixes".
>> Could you take this through your branch?
>>
>> Thanks,
>> Laurent
>>
>> On 26/01/2018 16:41, Mark Cave-Ayland wrote:
>>> On 26/01/18 14:47, Laurent Vivier wrote:
>>>
>>>> Move necessary stuff in escc.h and update type names.
>>>> Remove slavio_serial_ms_kbd_init().
>>>> Fix code style problems reported by checkpatch.pl
>>>> Update mac_newworld, mac_oldworld and sun4m to use directly the
>>>> QDEV interface.
>>>>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>
>>>> Notes:
>>>>       v3: in sun4m, move comments about Slavio TTY
>>>>           above both qdev_create().
>>>>       v2: in sun4m, move comments about Slavio TTY close to
>>>>           their qdev_prop_set_chr()
>>>>
>>>>    hw/char/escc.c         | 208
>>>> ++++++++++++++-----------------------------------
>>>>    hw/ppc/mac_newworld.c  |  19 ++++-
>>>>    hw/ppc/mac_oldworld.c  |  19 ++++-
>>>>    hw/sparc/sun4m.c       |  34 +++++++-
>>>>    include/hw/char/escc.h |  54 +++++++++++--
>>>>    5 files changed, 170 insertions(+), 164 deletions(-)
>>>>
>>>> diff --git a/hw/char/escc.c b/hw/char/escc.c
>>>> index 3ab831a6a7..bb735cc0c8 100644
>>>> --- a/hw/char/escc.c
>>>> +++ b/hw/char/escc.c
>>>> @@ -26,10 +26,7 @@
>>>>    #include "hw/hw.h"
>>>>    #include "hw/sysbus.h"
>>>>    #include "hw/char/escc.h"
>>>> -#include "chardev/char-fe.h"
>>>> -#include "chardev/char-serial.h"
>>>>    #include "ui/console.h"
>>>> -#include "ui/input.h"
>>>>    #include "trace.h"
>>>>      /*
>>>> @@ -64,53 +61,7 @@
>>>>     *  2010-May-23  Artyom Tarasenko:  Reworked IUS logic
>>>>     */
>>>>    -typedef enum {
>>>> -    chn_a, chn_b,
>>>> -} ChnID;
>>>> -
>>>> -#define CHN_C(s) ((s)->chn == chn_b? 'b' : 'a')
>>>> -
>>>> -typedef enum {
>>>> -    ser, kbd, mouse,
>>>> -} ChnType;
>>>> -
>>>> -#define SERIO_QUEUE_SIZE 256
>>>> -
>>>> -typedef struct {
>>>> -    uint8_t data[SERIO_QUEUE_SIZE];
>>>> -    int rptr, wptr, count;
>>>> -} SERIOQueue;
>>>> -
>>>> -#define SERIAL_REGS 16
>>>> -typedef struct ChannelState {
>>>> -    qemu_irq irq;
>>>> -    uint32_t rxint, txint, rxint_under_svc, txint_under_svc;
>>>> -    struct ChannelState *otherchn;
>>>> -    uint32_t reg;
>>>> -    uint8_t wregs[SERIAL_REGS], rregs[SERIAL_REGS];
>>>> -    SERIOQueue queue;
>>>> -    CharBackend chr;
>>>> -    int e0_mode, led_mode, caps_lock_mode, num_lock_mode;
>>>> -    int disabled;
>>>> -    int clock;
>>>> -    uint32_t vmstate_dummy;
>>>> -    ChnID chn; // this channel, A (base+4) or B (base+0)
>>>> -    ChnType type;
>>>> -    uint8_t rx, tx;
>>>> -    QemuInputHandlerState *hs;
>>>> -} ChannelState;
>>>> -
>>>> -#define ESCC(obj) OBJECT_CHECK(ESCCState, (obj), TYPE_ESCC)
>>>> -
>>>> -typedef struct ESCCState {
>>>> -    SysBusDevice parent_obj;
>>>> -
>>>> -    struct ChannelState chn[2];
>>>> -    uint32_t it_shift;
>>>> -    MemoryRegion mmio;
>>>> -    uint32_t disabled;
>>>> -    uint32_t frequency;
>>>> -} ESCCState;
>>>> +#define CHN_C(s) ((s)->chn == escc_chn_b ? 'b' : 'a')
>>>>      #define SERIAL_CTRL 0
>>>>    #define SERIAL_DATA 1
>>>> @@ -214,44 +165,47 @@ typedef struct ESCCState {
>>>>    #define R_MISC1I 14
>>>>    #define R_EXTINT 15
>>>>    -static void handle_kbd_command(ChannelState *s, int val);
>>>> +static void handle_kbd_command(ESCCChannelState *s, int val);
>>>>    static int serial_can_receive(void *opaque);
>>>> -static void serial_receive_byte(ChannelState *s, int ch);
>>>> +static void serial_receive_byte(ESCCChannelState *s, int ch);
>>>>      static void clear_queue(void *opaque)
>>>>    {
>>>> -    ChannelState *s = opaque;
>>>> -    SERIOQueue *q = &s->queue;
>>>> +    ESCCChannelState *s = opaque;
>>>> +    ESCCSERIOQueue *q = &s->queue;
>>>>        q->rptr = q->wptr = q->count = 0;
>>>>    }
>>>>      static void put_queue(void *opaque, int b)
>>>>    {
>>>> -    ChannelState *s = opaque;
>>>> -    SERIOQueue *q = &s->queue;
>>>> +    ESCCChannelState *s = opaque;
>>>> +    ESCCSERIOQueue *q = &s->queue;
>>>>          trace_escc_put_queue(CHN_C(s), b);
>>>> -    if (q->count >= SERIO_QUEUE_SIZE)
>>>> +    if (q->count >= ESCC_SERIO_QUEUE_SIZE) {
>>>>            return;
>>>> +    }
>>>>        q->data[q->wptr] = b;
>>>> -    if (++q->wptr == SERIO_QUEUE_SIZE)
>>>> +    if (++q->wptr == ESCC_SERIO_QUEUE_SIZE) {
>>>>            q->wptr = 0;
>>>> +    }
>>>>        q->count++;
>>>>        serial_receive_byte(s, 0);
>>>>    }
>>>>      static uint32_t get_queue(void *opaque)
>>>>    {
>>>> -    ChannelState *s = opaque;
>>>> -    SERIOQueue *q = &s->queue;
>>>> +    ESCCChannelState *s = opaque;
>>>> +    ESCCSERIOQueue *q = &s->queue;
>>>>        int val;
>>>>          if (q->count == 0) {
>>>>            return 0;
>>>>        } else {
>>>>            val = q->data[q->rptr];
>>>> -        if (++q->rptr == SERIO_QUEUE_SIZE)
>>>> +        if (++q->rptr == ESCC_SERIO_QUEUE_SIZE) {
>>>>                q->rptr = 0;
>>>> +        }
>>>>            q->count--;
>>>>        }
>>>>        trace_escc_get_queue(CHN_C(s), val);
>>>> @@ -260,7 +214,7 @@ static uint32_t get_queue(void *opaque)
>>>>        return val;
>>>>    }
>>>>    -static int escc_update_irq_chn(ChannelState *s)
>>>> +static int escc_update_irq_chn(ESCCChannelState *s)
>>>>    {
>>>>        if ((((s->wregs[W_INTR] & INTR_TXINT) && (s->txint == 1)) ||
>>>>             // tx ints enabled, pending
>>>> @@ -274,7 +228,7 @@ static int escc_update_irq_chn(ChannelState *s)
>>>>        return 0;
>>>>    }
>>>>    -static void escc_update_irq(ChannelState *s)
>>>> +static void escc_update_irq(ESCCChannelState *s)
>>>>    {
>>>>        int irq;
>>>>    @@ -285,12 +239,12 @@ static void escc_update_irq(ChannelState *s)
>>>>        qemu_set_irq(s->irq, irq);
>>>>    }
>>>>    -static void escc_reset_chn(ChannelState *s)
>>>> +static void escc_reset_chn(ESCCChannelState *s)
>>>>    {
>>>>        int i;
>>>>          s->reg = 0;
>>>> -    for (i = 0; i < SERIAL_REGS; i++) {
>>>> +    for (i = 0; i < ESCC_SERIAL_REGS; i++) {
>>>>            s->rregs[i] = 0;
>>>>            s->wregs[i] = 0;
>>>>        }
>>>> @@ -322,13 +276,13 @@ static void escc_reset(DeviceState *d)
>>>>        escc_reset_chn(&s->chn[1]);
>>>>    }
>>>>    -static inline void set_rxint(ChannelState *s)
>>>> +static inline void set_rxint(ESCCChannelState *s)
>>>>    {
>>>>        s->rxint = 1;
>>>> -    /* XXX: missing daisy chainnig: chn_b rx should have a lower
>>>> priority
>>>> +    /* XXX: missing daisy chainnig: escc_chn_b rx should have a lower
>>>> priority
>>>>           than chn_a rx/tx/special_condition service*/
>>>>        s->rxint_under_svc = 1;
>>>> -    if (s->chn == chn_a) {
>>>> +    if (s->chn == escc_chn_a) {
>>>>            s->rregs[R_INTR] |= INTR_RXINTA;
>>>>            if (s->wregs[W_MINTR] & MINTR_STATUSHI)
>>>>                s->otherchn->rregs[R_IVEC] = IVEC_HIRXINTA;
>>>> @@ -344,12 +298,12 @@ static inline void set_rxint(ChannelState *s)
>>>>        escc_update_irq(s);
>>>>    }
>>>>    -static inline void set_txint(ChannelState *s)
>>>> +static inline void set_txint(ESCCChannelState *s)
>>>>    {
>>>>        s->txint = 1;
>>>>        if (!s->rxint_under_svc) {
>>>>            s->txint_under_svc = 1;
>>>> -        if (s->chn == chn_a) {
>>>> +        if (s->chn == escc_chn_a) {
>>>>                if (s->wregs[W_INTR] & INTR_TXINT) {
>>>>                    s->rregs[R_INTR] |= INTR_TXINTA;
>>>>                }
>>>> @@ -367,11 +321,11 @@ static inline void set_txint(ChannelState *s)
>>>>        }
>>>>    }
>>>>    -static inline void clr_rxint(ChannelState *s)
>>>> +static inline void clr_rxint(ESCCChannelState *s)
>>>>    {
>>>>        s->rxint = 0;
>>>>        s->rxint_under_svc = 0;
>>>> -    if (s->chn == chn_a) {
>>>> +    if (s->chn == escc_chn_a) {
>>>>            if (s->wregs[W_MINTR] & MINTR_STATUSHI)
>>>>                s->otherchn->rregs[R_IVEC] = IVEC_HINOINT;
>>>>            else
>>>> @@ -389,11 +343,11 @@ static inline void clr_rxint(ChannelState *s)
>>>>        escc_update_irq(s);
>>>>    }
>>>>    -static inline void clr_txint(ChannelState *s)
>>>> +static inline void clr_txint(ESCCChannelState *s)
>>>>    {
>>>>        s->txint = 0;
>>>>        s->txint_under_svc = 0;
>>>> -    if (s->chn == chn_a) {
>>>> +    if (s->chn == escc_chn_a) {
>>>>            if (s->wregs[W_MINTR] & MINTR_STATUSHI)
>>>>                s->otherchn->rregs[R_IVEC] = IVEC_HINOINT;
>>>>            else
>>>> @@ -412,12 +366,12 @@ static inline void clr_txint(ChannelState *s)
>>>>        escc_update_irq(s);
>>>>    }
>>>>    -static void escc_update_parameters(ChannelState *s)
>>>> +static void escc_update_parameters(ESCCChannelState *s)
>>>>    {
>>>>        int speed, parity, data_bits, stop_bits;
>>>>        QEMUSerialSetParams ssp;
>>>>    -    if (!qemu_chr_fe_backend_connected(&s->chr) || s->type != ser)
>>>> +    if (!qemu_chr_fe_backend_connected(&s->chr) || s->type !=
>>>> escc_serial)
>>>>            return;
>>>>          if (s->wregs[W_TXCTRL1] & TXCTRL1_PAREN) {
>>>> @@ -474,7 +428,7 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>>>>                               uint64_t val, unsigned size)
>>>>    {
>>>>        ESCCState *serial = opaque;
>>>> -    ChannelState *s;
>>>> +    ESCCChannelState *s;
>>>>        uint32_t saddr;
>>>>        int newreg, channel;
>>>>    @@ -561,7 +515,7 @@ static void escc_mem_write(void *opaque, hwaddr
>>>> addr,
>>>>                    /* XXX this blocks entire thread. Rewrite to use
>>>>                     * qemu_chr_fe_write and background I/O callbacks */
>>>>                    qemu_chr_fe_write_all(&s->chr, &s->tx, 1);
>>>> -            } else if (s->type == kbd && !s->disabled) {
>>>> +            } else if (s->type == escc_kbd && !s->disabled) {
>>>>                    handle_kbd_command(s, val);
>>>>                }
>>>>            }
>>>> @@ -578,7 +532,7 @@ static uint64_t escc_mem_read(void *opaque, hwaddr
>>>> addr,
>>>>                                  unsigned size)
>>>>    {
>>>>        ESCCState *serial = opaque;
>>>> -    ChannelState *s;
>>>> +    ESCCChannelState *s;
>>>>        uint32_t saddr;
>>>>        uint32_t ret;
>>>>        int channel;
>>>> @@ -595,10 +549,11 @@ static uint64_t escc_mem_read(void *opaque,
>>>> hwaddr addr,
>>>>        case SERIAL_DATA:
>>>>            s->rregs[R_STATUS] &= ~STATUS_RXAV;
>>>>            clr_rxint(s);
>>>> -        if (s->type == kbd || s->type == mouse)
>>>> +        if (s->type == escc_kbd || s->type == escc_mouse) {
>>>>                ret = get_queue(s);
>>>> -        else
>>>> +        } else {
>>>>                ret = s->rx;
>>>> +        }
>>>>            trace_escc_mem_readb_data(CHN_C(s), ret);
>>>>            qemu_chr_fe_accept_input(&s->chr);
>>>>            return ret;
>>>> @@ -620,7 +575,7 @@ static const MemoryRegionOps escc_mem_ops = {
>>>>      static int serial_can_receive(void *opaque)
>>>>    {
>>>> -    ChannelState *s = opaque;
>>>> +    ESCCChannelState *s = opaque;
>>>>        int ret;
>>>>          if (((s->wregs[W_RXCTRL] & RXCTRL_RXEN) == 0) // Rx not enabled
>>>> @@ -632,7 +587,7 @@ static int serial_can_receive(void *opaque)
>>>>        return ret;
>>>>    }
>>>>    -static void serial_receive_byte(ChannelState *s, int ch)
>>>> +static void serial_receive_byte(ESCCChannelState *s, int ch)
>>>>    {
>>>>        trace_escc_serial_receive_byte(CHN_C(s), ch);
>>>>        s->rregs[R_STATUS] |= STATUS_RXAV;
>>>> @@ -640,7 +595,7 @@ static void serial_receive_byte(ChannelState *s,
>>>> int ch)
>>>>        set_rxint(s);
>>>>    }
>>>>    -static void serial_receive_break(ChannelState *s)
>>>> +static void serial_receive_break(ESCCChannelState *s)
>>>>    {
>>>>        s->rregs[R_STATUS] |= STATUS_BRK;
>>>>        escc_update_irq(s);
>>>> @@ -648,13 +603,13 @@ static void serial_receive_break(ChannelState *s)
>>>>      static void serial_receive1(void *opaque, const uint8_t *buf, int
>>>> size)
>>>>    {
>>>> -    ChannelState *s = opaque;
>>>> +    ESCCChannelState *s = opaque;
>>>>        serial_receive_byte(s, buf[0]);
>>>>    }
>>>>      static void serial_event(void *opaque, int event)
>>>>    {
>>>> -    ChannelState *s = opaque;
>>>> +    ESCCChannelState *s = opaque;
>>>>        if (event == CHR_EVENT_BREAK)
>>>>            serial_receive_break(s);
>>>>    }
>>>> @@ -664,16 +619,16 @@ static const VMStateDescription vmstate_escc_chn
>>>> = {
>>>>        .version_id = 2,
>>>>        .minimum_version_id = 1,
>>>>        .fields = (VMStateField[]) {
>>>> -        VMSTATE_UINT32(vmstate_dummy, ChannelState),
>>>> -        VMSTATE_UINT32(reg, ChannelState),
>>>> -        VMSTATE_UINT32(rxint, ChannelState),
>>>> -        VMSTATE_UINT32(txint, ChannelState),
>>>> -        VMSTATE_UINT32(rxint_under_svc, ChannelState),
>>>> -        VMSTATE_UINT32(txint_under_svc, ChannelState),
>>>> -        VMSTATE_UINT8(rx, ChannelState),
>>>> -        VMSTATE_UINT8(tx, ChannelState),
>>>> -        VMSTATE_BUFFER(wregs, ChannelState),
>>>> -        VMSTATE_BUFFER(rregs, ChannelState),
>>>> +        VMSTATE_UINT32(vmstate_dummy, ESCCChannelState),
>>>> +        VMSTATE_UINT32(reg, ESCCChannelState),
>>>> +        VMSTATE_UINT32(rxint, ESCCChannelState),
>>>> +        VMSTATE_UINT32(txint, ESCCChannelState),
>>>> +        VMSTATE_UINT32(rxint_under_svc, ESCCChannelState),
>>>> +        VMSTATE_UINT32(txint_under_svc, ESCCChannelState),
>>>> +        VMSTATE_UINT8(rx, ESCCChannelState),
>>>> +        VMSTATE_UINT8(tx, ESCCChannelState),
>>>> +        VMSTATE_BUFFER(wregs, ESCCChannelState),
>>>> +        VMSTATE_BUFFER(rregs, ESCCChannelState),
>>>>            VMSTATE_END_OF_LIST()
>>>>        }
>>>>    };
>>>> @@ -684,39 +639,11 @@ static const VMStateDescription vmstate_escc = {
>>>>        .minimum_version_id = 1,
>>>>        .fields = (VMStateField[]) {
>>>>            VMSTATE_STRUCT_ARRAY(chn, ESCCState, 2, 2, vmstate_escc_chn,
>>>> -                             ChannelState),
>>>> +                             ESCCChannelState),
>>>>            VMSTATE_END_OF_LIST()
>>>>        }
>>>>    };
>>>>    -MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
>>>> -              Chardev *chrA, Chardev *chrB,
>>>> -              int clock, int it_shift)
>>>> -{
>>>> -    DeviceState *dev;
>>>> -    SysBusDevice *s;
>>>> -    ESCCState *d;
>>>> -
>>>> -    dev = qdev_create(NULL, TYPE_ESCC);
>>>> -    qdev_prop_set_uint32(dev, "disabled", 0);
>>>> -    qdev_prop_set_uint32(dev, "frequency", clock);
>>>> -    qdev_prop_set_uint32(dev, "it_shift", it_shift);
>>>> -    qdev_prop_set_chr(dev, "chrB", chrB);
>>>> -    qdev_prop_set_chr(dev, "chrA", chrA);
>>>> -    qdev_prop_set_uint32(dev, "chnBtype", ser);
>>>> -    qdev_prop_set_uint32(dev, "chnAtype", ser);
>>>> -    qdev_init_nofail(dev);
>>>> -    s = SYS_BUS_DEVICE(dev);
>>>> -    sysbus_connect_irq(s, 0, irqB);
>>>> -    sysbus_connect_irq(s, 1, irqA);
>>>> -    if (base) {
>>>> -        sysbus_mmio_map(s, 0, base);
>>>> -    }
>>>> -
>>>> -    d = ESCC(s);
>>>> -    return &d->mmio;
>>>> -}
>>>> -
>>>>    static const uint8_t qcode_to_keycode[Q_KEY_CODE__MAX] = {
>>>>        [Q_KEY_CODE_SHIFT]         = 99,
>>>>        [Q_KEY_CODE_SHIFT_R]       = 110,
>>>> @@ -841,7 +768,7 @@ static const uint8_t
>>>> qcode_to_keycode[Q_KEY_CODE__MAX] = {
>>>>    static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
>>>>                                    InputEvent *evt)
>>>>    {
>>>> -    ChannelState *s = (ChannelState *)dev;
>>>> +    ESCCChannelState *s = (ESCCChannelState *)dev;
>>>>        int qcode, keycode;
>>>>        InputKeyEvent *key;
>>>>    @@ -893,7 +820,7 @@ static QemuInputHandler sunkbd_handler = {
>>>>        .event = sunkbd_handle_event,
>>>>    };
>>>>    -static void handle_kbd_command(ChannelState *s, int val)
>>>> +static void handle_kbd_command(ESCCChannelState *s, int val)
>>>>    {
>>>>        trace_escc_kbd_command(val);
>>>>        if (s->led_mode) { // Ignore led byte
>>>> @@ -924,7 +851,7 @@ static void handle_kbd_command(ChannelState *s,
>>>> int val)
>>>>    static void sunmouse_event(void *opaque,
>>>>                                   int dx, int dy, int dz, int
>>>> buttons_state)
>>>>    {
>>>> -    ChannelState *s = opaque;
>>>> +    ESCCChannelState *s = opaque;
>>>>        int ch;
>>>>          trace_escc_sunmouse_event(dx, dy, buttons_state);
>>>> @@ -963,27 +890,6 @@ static void sunmouse_event(void *opaque,
>>>>        put_queue(s, 0);
>>>>    }
>>>>    -void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
>>>> -                               int disabled, int clock, int it_shift)
>>>> -{
>>>> -    DeviceState *dev;
>>>> -    SysBusDevice *s;
>>>> -
>>>> -    dev = qdev_create(NULL, TYPE_ESCC);
>>>> -    qdev_prop_set_uint32(dev, "disabled", disabled);
>>>> -    qdev_prop_set_uint32(dev, "frequency", clock);
>>>> -    qdev_prop_set_uint32(dev, "it_shift", it_shift);
>>>> -    qdev_prop_set_chr(dev, "chrB", NULL);
>>>> -    qdev_prop_set_chr(dev, "chrA", NULL);
>>>> -    qdev_prop_set_uint32(dev, "chnBtype", mouse);
>>>> -    qdev_prop_set_uint32(dev, "chnAtype", kbd);
>>>> -    qdev_init_nofail(dev);
>>>> -    s = SYS_BUS_DEVICE(dev);
>>>> -    sysbus_connect_irq(s, 0, irq);
>>>> -    sysbus_connect_irq(s, 1, irq);
>>>> -    sysbus_mmio_map(s, 0, base);
>>>> -}
>>>> -
>>>>    static void escc_init1(Object *obj)
>>>>    {
>>>>        ESCCState *s = ESCC(obj);
>>>> @@ -1020,11 +926,11 @@ static void escc_realize(DeviceState *dev,
>>>> Error **errp)
>>>>            }
>>>>        }
>>>>    -    if (s->chn[0].type == mouse) {
>>>> +    if (s->chn[0].type == escc_mouse) {
>>>>            qemu_add_mouse_event_handler(sunmouse_event, &s->chn[0], 0,
>>>>                                         "QEMU Sun Mouse");
>>>>        }
>>>> -    if (s->chn[1].type == kbd) {
>>>> +    if (s->chn[1].type == escc_kbd) {
>>>>            s->chn[1].hs = qemu_input_handler_register((DeviceState
>>>> *)(&s->chn[1]),
>>>>                                                       &sunkbd_handler);
>>>>        }
>>>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>>>> index 3fa7c429d5..de061ae76f 100644
>>>> --- a/hw/ppc/mac_newworld.c
>>>> +++ b/hw/ppc/mac_newworld.c
>>>> @@ -369,8 +369,23 @@ static void ppc_core99_init(MachineState *machine)
>>>>        }
>>>>          /* init basic PC hardware */
>>>> -    escc_mem = escc_init(0, pic[0x25], pic[0x24],
>>>> -                         serial_hds[0], serial_hds[1], ESCC_CLOCK, 4);
>>>> +
>>>> +    dev = qdev_create(NULL, TYPE_ESCC);
>>>> +    qdev_prop_set_uint32(dev, "disabled", 0);
>>>> +    qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
>>>> +    qdev_prop_set_uint32(dev, "it_shift", 4);
>>>> +    qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
>>>> +    qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
>>>> +    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
>>>> +    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
>>>> +    qdev_init_nofail(dev);
>>>> +
>>>> +    s = SYS_BUS_DEVICE(dev);
>>>> +    sysbus_connect_irq(s, 0, pic[0x24]);
>>>> +    sysbus_connect_irq(s, 1, pic[0x25]);
>>>> +
>>>> +    escc_mem = &ESCC(s)->mmio;
>>>> +
>>>>        memory_region_init_alias(escc_bar, NULL, "escc-bar",
>>>>                                 escc_mem, 0,
>>>> memory_region_size(escc_mem));
>>>>    diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>>>> index 010ea36bf2..da0106b09d 100644
>>>> --- a/hw/ppc/mac_oldworld.c
>>>> +++ b/hw/ppc/mac_oldworld.c
>>>> @@ -104,6 +104,7 @@ static void ppc_heathrow_init(MachineState *machine)
>>>>        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>>>        void *fw_cfg;
>>>>        uint64_t tbfreq;
>>>> +    SysBusDevice *s;
>>>>          linux_boot = (kernel_filename != NULL);
>>>>    @@ -264,8 +265,22 @@ static void ppc_heathrow_init(MachineState
>>>> *machine)
>>>>                                   get_system_io());
>>>>        pci_vga_init(pci_bus);
>>>>    -    escc_mem = escc_init(0, pic[0x0f], pic[0x10], serial_hds[0],
>>>> -                               serial_hds[1], ESCC_CLOCK, 4);
>>>> +    dev = qdev_create(NULL, TYPE_ESCC);
>>>> +    qdev_prop_set_uint32(dev, "disabled", 0);
>>>> +    qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
>>>> +    qdev_prop_set_uint32(dev, "it_shift", 4);
>>>> +    qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
>>>> +    qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
>>>> +    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
>>>> +    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
>>>> +    qdev_init_nofail(dev);
>>>> +
>>>> +    s = SYS_BUS_DEVICE(dev);
>>>> +    sysbus_connect_irq(s, 0, pic[0x10]);
>>>> +    sysbus_connect_irq(s, 1, pic[0x0f]);
>>>> +
>>>> +    escc_mem = &ESCC(s)->mmio;
>>>> +
>>>>        memory_region_init_alias(escc_bar, NULL, "escc-bar",
>>>>                                 escc_mem, 0,
>>>> memory_region_size(escc_mem));
>>>>    diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>>>> index dd0038095b..0b3911cd65 100644
>>>> --- a/hw/sparc/sun4m.c
>>>> +++ b/hw/sparc/sun4m.c
>>>> @@ -820,6 +820,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef
>>>> *hwdef,
>>>>        DriveInfo *fd[MAX_FD];
>>>>        FWCfgState *fw_cfg;
>>>>        unsigned int num_vsimms;
>>>> +    DeviceState *dev;
>>>> +    SysBusDevice *s;
>>>>          /* init CPUs */
>>>>        for(i = 0; i < smp_cpus; i++) {
>>>> @@ -927,12 +929,36 @@ static void sun4m_hw_init(const struct
>>>> sun4m_hwdef *hwdef,
>>>>          slavio_timer_init_all(hwdef->counter_base, slavio_irq[19],
>>>> slavio_cpu_irq, smp_cpus);
>>>>    -    slavio_serial_ms_kbd_init(hwdef->ms_kb_base, slavio_irq[14],
>>>> -                              !machine->enable_graphics, ESCC_CLOCK, 1);
>>>>        /* Slavio TTYA (base+4, Linux ttyS0) is the first QEMU serial
>>>> device
>>>>           Slavio TTYB (base+0, Linux ttyS1) is the second QEMU serial
>>>> device */
>>>> -    escc_init(hwdef->serial_base, slavio_irq[15], slavio_irq[15],
>>>> -              serial_hds[0], serial_hds[1], ESCC_CLOCK, 1);
>>>> +    dev = qdev_create(NULL, TYPE_ESCC);
>>>> +    qdev_prop_set_uint32(dev, "disabled", !machine->enable_graphics);
>>>> +    qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
>>>> +    qdev_prop_set_uint32(dev, "it_shift", 1);
>>>> +    qdev_prop_set_chr(dev, "chrB", NULL);
>>>> +    qdev_prop_set_chr(dev, "chrA", NULL);
>>>> +    qdev_prop_set_uint32(dev, "chnBtype", escc_mouse);
>>>> +    qdev_prop_set_uint32(dev, "chnAtype", escc_kbd);
>>>> +    qdev_init_nofail(dev);
>>>> +    s = SYS_BUS_DEVICE(dev);
>>>> +    sysbus_connect_irq(s, 0, slavio_irq[14]);
>>>> +    sysbus_connect_irq(s, 1, slavio_irq[14]);
>>>> +    sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
>>>> +
>>>> +    dev = qdev_create(NULL, TYPE_ESCC);
>>>> +    qdev_prop_set_uint32(dev, "disabled", 0);
>>>> +    qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
>>>> +    qdev_prop_set_uint32(dev, "it_shift", 1);
>>>> +    qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
>>>> +    qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
>>>> +    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
>>>> +    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
>>>> +    qdev_init_nofail(dev);
>>>> +
>>>> +    s = SYS_BUS_DEVICE(dev);
>>>> +    sysbus_connect_irq(s, 0, slavio_irq[15]);
>>>> +    sysbus_connect_irq(s, 1,  slavio_irq[15]);
>>>> +    sysbus_mmio_map(s, 0, hwdef->serial_base);
>>>>          if (hwdef->apc_base) {
>>>>            apc_init(hwdef->apc_base, qemu_allocate_irq(cpu_halt_signal,
>>>> NULL, 0));
>>>> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
>>>> index 08ae122386..42aca83611 100644
>>>> --- a/include/hw/char/escc.h
>>>> +++ b/include/hw/char/escc.h
>>>> @@ -1,14 +1,58 @@
>>>>    #ifndef HW_ESCC_H
>>>>    #define HW_ESCC_H
>>>>    +#include "chardev/char-fe.h"
>>>> +#include "chardev/char-serial.h"
>>>> +#include "ui/input.h"
>>>> +
>>>>    /* escc.c */
>>>>    #define TYPE_ESCC "escc"
>>>>    #define ESCC_SIZE 4
>>>> -MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
>>>> -              Chardev *chrA, Chardev *chrB,
>>>> -              int clock, int it_shift);
>>>>    -void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
>>>> -                               int disabled, int clock, int it_shift);
>>>> +#define ESCC(obj) OBJECT_CHECK(ESCCState, (obj), TYPE_ESCC)
>>>> +
>>>> +typedef enum {
>>>> +    escc_chn_a, escc_chn_b,
>>>> +} ESCCChnID;
>>>> +
>>>> +typedef enum {
>>>> +    escc_serial, escc_kbd, escc_mouse,
>>>> +} ESCCChnType;
>>>> +
>>>> +#define ESCC_SERIO_QUEUE_SIZE 256
>>>> +
>>>> +typedef struct {
>>>> +    uint8_t data[ESCC_SERIO_QUEUE_SIZE];
>>>> +    int rptr, wptr, count;
>>>> +} ESCCSERIOQueue;
>>>> +
>>>> +#define ESCC_SERIAL_REGS 16
>>>> +typedef struct ESCCChannelState {
>>>> +    qemu_irq irq;
>>>> +    uint32_t rxint, txint, rxint_under_svc, txint_under_svc;
>>>> +    struct ESCCChannelState *otherchn;
>>>> +    uint32_t reg;
>>>> +    uint8_t wregs[ESCC_SERIAL_REGS], rregs[ESCC_SERIAL_REGS];
>>>> +    ESCCSERIOQueue queue;
>>>> +    CharBackend chr;
>>>> +    int e0_mode, led_mode, caps_lock_mode, num_lock_mode;
>>>> +    int disabled;
>>>> +    int clock;
>>>> +    uint32_t vmstate_dummy;
>>>> +    ESCCChnID chn; /* this channel, A (base+4) or B (base+0) */
>>>> +    ESCCChnType type;
>>>> +    uint8_t rx, tx;
>>>> +    QemuInputHandlerState *hs;
>>>> +} ESCCChannelState;
>>>> +
>>>> +typedef struct ESCCState {
>>>> +    SysBusDevice parent_obj;
>>>> +
>>>> +    struct ESCCChannelState chn[2];
>>>> +    uint32_t it_shift;
>>>> +    MemoryRegion mmio;
>>>> +    uint32_t disabled;
>>>> +    uint32_t frequency;
>>>> +} ESCCState;
>>>>      #endif
>>>
>>> Looks good to me. Note to self: I wonder how easy it would be to split
>>> the sun keyboard/mouse out from here too.
>>>
>>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

I don't have any upcoming branches ready for merge quite yet, but I 
think that it would be good to get this in sooner rather than later.

David, would you be willing to take this via ppc-for-2.12 since it 
covers the ESCC used in the PPC Mac machines?


ATB,

Mark.
