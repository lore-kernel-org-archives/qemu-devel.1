Received: from eggs.gnu.org ([2001:4830:134:3::10]:59353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAiQ-0001Gk-PE
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAiM-0004Ad-Uk
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:00:10 -0500
Date: Thu, 15 Feb 2018 13:40:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180215024042.GC5247@umbus.fritz.box>
References: <20180214063558.27331-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <20180214063558.27331-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] hw/char: remove legacy interface
 escc_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 07:35:58AM +0100, Laurent Vivier wrote:
> Move necessary stuff in escc.h and update type names.
> Remove slavio_serial_ms_kbd_init().
> Fix code style problems reported by checkpatch.pl
> Update mac_newworld, mac_oldworld and sun4m to use directly the
> QDEV interface.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>=20
> Notes:
>     v4: rebase and add Mark's R-b
>     v3: in sun4m, move comments about Slavio TTY
>         above both qdev_create().
>     v2: in sun4m, move comments about Slavio TTY close to
>         their qdev_prop_set_chr()=B2
>=20
>  hw/char/escc.c         | 209 ++++++++++++++-----------------------------=
------
>  hw/ppc/mac_newworld.c  |  19 ++++-
>  hw/ppc/mac_oldworld.c  |  19 ++++-
>  hw/sparc/sun4m.c       |  34 +++++++-
>  include/hw/char/escc.h |  54 +++++++++++--
>  5 files changed, 170 insertions(+), 165 deletions(-)
>=20
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 449bf2fc63..628f5f81f7 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -26,10 +26,7 @@
>  #include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "hw/char/escc.h"
> -#include "chardev/char-fe.h"
> -#include "chardev/char-serial.h"
>  #include "ui/console.h"
> -#include "ui/input.h"
>  #include "trace.h"
> =20
>  /*
> @@ -64,53 +61,7 @@
>   *  2010-May-23  Artyom Tarasenko:  Reworked IUS logic
>   */
> =20
> -typedef enum {
> -    chn_a, chn_b,
> -} ChnID;
> -
> -#define CHN_C(s) ((s)->chn =3D=3D chn_b? 'b' : 'a')
> -
> -typedef enum {
> -    ser, kbd, mouse,
> -} ChnType;
> -
> -#define SERIO_QUEUE_SIZE 256
> -
> -typedef struct {
> -    uint8_t data[SERIO_QUEUE_SIZE];
> -    int rptr, wptr, count;
> -} SERIOQueue;
> -
> -#define SERIAL_REGS 16
> -typedef struct ChannelState {
> -    qemu_irq irq;
> -    uint32_t rxint, txint, rxint_under_svc, txint_under_svc;
> -    struct ChannelState *otherchn;
> -    uint32_t reg;
> -    uint8_t wregs[SERIAL_REGS], rregs[SERIAL_REGS];
> -    SERIOQueue queue;
> -    CharBackend chr;
> -    int e0_mode, led_mode, caps_lock_mode, num_lock_mode;
> -    int disabled;
> -    int clock;
> -    uint32_t vmstate_dummy;
> -    ChnID chn; // this channel, A (base+4) or B (base+0)
> -    ChnType type;
> -    uint8_t rx, tx;
> -    QemuInputHandlerState *hs;
> -} ChannelState;
> -
> -#define ESCC(obj) OBJECT_CHECK(ESCCState, (obj), TYPE_ESCC)
> -
> -typedef struct ESCCState {
> -    SysBusDevice parent_obj;
> -
> -    struct ChannelState chn[2];
> -    uint32_t it_shift;
> -    MemoryRegion mmio;
> -    uint32_t disabled;
> -    uint32_t frequency;
> -} ESCCState;
> +#define CHN_C(s) ((s)->chn =3D=3D escc_chn_b ? 'b' : 'a')
> =20
>  #define SERIAL_CTRL 0
>  #define SERIAL_DATA 1
> @@ -214,44 +165,47 @@ typedef struct ESCCState {
>  #define R_MISC1I 14
>  #define R_EXTINT 15
> =20
> -static void handle_kbd_command(ChannelState *s, int val);
> +static void handle_kbd_command(ESCCChannelState *s, int val);
>  static int serial_can_receive(void *opaque);
> -static void serial_receive_byte(ChannelState *s, int ch);
> +static void serial_receive_byte(ESCCChannelState *s, int ch);
> =20
>  static void clear_queue(void *opaque)
>  {
> -    ChannelState *s =3D opaque;
> -    SERIOQueue *q =3D &s->queue;
> +    ESCCChannelState *s =3D opaque;
> +    ESCCSERIOQueue *q =3D &s->queue;
>      q->rptr =3D q->wptr =3D q->count =3D 0;
>  }
> =20
>  static void put_queue(void *opaque, int b)
>  {
> -    ChannelState *s =3D opaque;
> -    SERIOQueue *q =3D &s->queue;
> +    ESCCChannelState *s =3D opaque;
> +    ESCCSERIOQueue *q =3D &s->queue;
> =20
>      trace_escc_put_queue(CHN_C(s), b);
> -    if (q->count >=3D SERIO_QUEUE_SIZE)
> +    if (q->count >=3D ESCC_SERIO_QUEUE_SIZE) {
>          return;
> +    }
>      q->data[q->wptr] =3D b;
> -    if (++q->wptr =3D=3D SERIO_QUEUE_SIZE)
> +    if (++q->wptr =3D=3D ESCC_SERIO_QUEUE_SIZE) {
>          q->wptr =3D 0;
> +    }
>      q->count++;
>      serial_receive_byte(s, 0);
>  }
> =20
>  static uint32_t get_queue(void *opaque)
>  {
> -    ChannelState *s =3D opaque;
> -    SERIOQueue *q =3D &s->queue;
> +    ESCCChannelState *s =3D opaque;
> +    ESCCSERIOQueue *q =3D &s->queue;
>      int val;
> =20
>      if (q->count =3D=3D 0) {
>          return 0;
>      } else {
>          val =3D q->data[q->rptr];
> -        if (++q->rptr =3D=3D SERIO_QUEUE_SIZE)
> +        if (++q->rptr =3D=3D ESCC_SERIO_QUEUE_SIZE) {
>              q->rptr =3D 0;
> +        }
>          q->count--;
>      }
>      trace_escc_get_queue(CHN_C(s), val);
> @@ -260,7 +214,7 @@ static uint32_t get_queue(void *opaque)
>      return val;
>  }
> =20
> -static int escc_update_irq_chn(ChannelState *s)
> +static int escc_update_irq_chn(ESCCChannelState *s)
>  {
>      if ((((s->wregs[W_INTR] & INTR_TXINT) && (s->txint =3D=3D 1)) ||
>           // tx ints enabled, pending
> @@ -274,7 +228,7 @@ static int escc_update_irq_chn(ChannelState *s)
>      return 0;
>  }
> =20
> -static void escc_update_irq(ChannelState *s)
> +static void escc_update_irq(ESCCChannelState *s)
>  {
>      int irq;
> =20
> @@ -285,12 +239,12 @@ static void escc_update_irq(ChannelState *s)
>      qemu_set_irq(s->irq, irq);
>  }
> =20
> -static void escc_reset_chn(ChannelState *s)
> +static void escc_reset_chn(ESCCChannelState *s)
>  {
>      int i;
> =20
>      s->reg =3D 0;
> -    for (i =3D 0; i < SERIAL_REGS; i++) {
> +    for (i =3D 0; i < ESCC_SERIAL_REGS; i++) {
>          s->rregs[i] =3D 0;
>          s->wregs[i] =3D 0;
>      }
> @@ -322,13 +276,13 @@ static void escc_reset(DeviceState *d)
>      escc_reset_chn(&s->chn[1]);
>  }
> =20
> -static inline void set_rxint(ChannelState *s)
> +static inline void set_rxint(ESCCChannelState *s)
>  {
>      s->rxint =3D 1;
> -    /* XXX: missing daisy chainnig: chn_b rx should have a lower priority
> +    /* XXX: missing daisy chainnig: escc_chn_b rx should have a lower pr=
iority
>         than chn_a rx/tx/special_condition service*/
>      s->rxint_under_svc =3D 1;
> -    if (s->chn =3D=3D chn_a) {
> +    if (s->chn =3D=3D escc_chn_a) {
>          s->rregs[R_INTR] |=3D INTR_RXINTA;
>          if (s->wregs[W_MINTR] & MINTR_STATUSHI)
>              s->otherchn->rregs[R_IVEC] =3D IVEC_HIRXINTA;
> @@ -344,12 +298,12 @@ static inline void set_rxint(ChannelState *s)
>      escc_update_irq(s);
>  }
> =20
> -static inline void set_txint(ChannelState *s)
> +static inline void set_txint(ESCCChannelState *s)
>  {
>      s->txint =3D 1;
>      if (!s->rxint_under_svc) {
>          s->txint_under_svc =3D 1;
> -        if (s->chn =3D=3D chn_a) {
> +        if (s->chn =3D=3D escc_chn_a) {
>              if (s->wregs[W_INTR] & INTR_TXINT) {
>                  s->rregs[R_INTR] |=3D INTR_TXINTA;
>              }
> @@ -367,11 +321,11 @@ static inline void set_txint(ChannelState *s)
>      }
>  }
> =20
> -static inline void clr_rxint(ChannelState *s)
> +static inline void clr_rxint(ESCCChannelState *s)
>  {
>      s->rxint =3D 0;
>      s->rxint_under_svc =3D 0;
> -    if (s->chn =3D=3D chn_a) {
> +    if (s->chn =3D=3D escc_chn_a) {
>          if (s->wregs[W_MINTR] & MINTR_STATUSHI)
>              s->otherchn->rregs[R_IVEC] =3D IVEC_HINOINT;
>          else
> @@ -389,11 +343,11 @@ static inline void clr_rxint(ChannelState *s)
>      escc_update_irq(s);
>  }
> =20
> -static inline void clr_txint(ChannelState *s)
> +static inline void clr_txint(ESCCChannelState *s)
>  {
>      s->txint =3D 0;
>      s->txint_under_svc =3D 0;
> -    if (s->chn =3D=3D chn_a) {
> +    if (s->chn =3D=3D escc_chn_a) {
>          if (s->wregs[W_MINTR] & MINTR_STATUSHI)
>              s->otherchn->rregs[R_IVEC] =3D IVEC_HINOINT;
>          else
> @@ -412,12 +366,12 @@ static inline void clr_txint(ChannelState *s)
>      escc_update_irq(s);
>  }
> =20
> -static void escc_update_parameters(ChannelState *s)
> +static void escc_update_parameters(ESCCChannelState *s)
>  {
>      int speed, parity, data_bits, stop_bits;
>      QEMUSerialSetParams ssp;
> =20
> -    if (!qemu_chr_fe_backend_connected(&s->chr) || s->type !=3D ser)
> +    if (!qemu_chr_fe_backend_connected(&s->chr) || s->type !=3D escc_ser=
ial)
>          return;
> =20
>      if (s->wregs[W_TXCTRL1] & TXCTRL1_PAREN) {
> @@ -474,7 +428,7 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>                             uint64_t val, unsigned size)
>  {
>      ESCCState *serial =3D opaque;
> -    ChannelState *s;
> +    ESCCChannelState *s;
>      uint32_t saddr;
>      int newreg, channel;
> =20
> @@ -561,7 +515,7 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>                  /* XXX this blocks entire thread. Rewrite to use
>                   * qemu_chr_fe_write and background I/O callbacks */
>                  qemu_chr_fe_write_all(&s->chr, &s->tx, 1);
> -            } else if (s->type =3D=3D kbd && !s->disabled) {
> +            } else if (s->type =3D=3D escc_kbd && !s->disabled) {
>                  handle_kbd_command(s, val);
>              }
>          }
> @@ -578,7 +532,7 @@ static uint64_t escc_mem_read(void *opaque, hwaddr ad=
dr,
>                                unsigned size)
>  {
>      ESCCState *serial =3D opaque;
> -    ChannelState *s;
> +    ESCCChannelState *s;
>      uint32_t saddr;
>      uint32_t ret;
>      int channel;
> @@ -595,10 +549,11 @@ static uint64_t escc_mem_read(void *opaque, hwaddr =
addr,
>      case SERIAL_DATA:
>          s->rregs[R_STATUS] &=3D ~STATUS_RXAV;
>          clr_rxint(s);
> -        if (s->type =3D=3D kbd || s->type =3D=3D mouse)
> +        if (s->type =3D=3D escc_kbd || s->type =3D=3D escc_mouse) {
>              ret =3D get_queue(s);
> -        else
> +        } else {
>              ret =3D s->rx;
> +        }
>          trace_escc_mem_readb_data(CHN_C(s), ret);
>          qemu_chr_fe_accept_input(&s->chr);
>          return ret;
> @@ -620,7 +575,7 @@ static const MemoryRegionOps escc_mem_ops =3D {
> =20
>  static int serial_can_receive(void *opaque)
>  {
> -    ChannelState *s =3D opaque;
> +    ESCCChannelState *s =3D opaque;
>      int ret;
> =20
>      if (((s->wregs[W_RXCTRL] & RXCTRL_RXEN) =3D=3D 0) // Rx not enabled
> @@ -632,7 +587,7 @@ static int serial_can_receive(void *opaque)
>      return ret;
>  }
> =20
> -static void serial_receive_byte(ChannelState *s, int ch)
> +static void serial_receive_byte(ESCCChannelState *s, int ch)
>  {
>      trace_escc_serial_receive_byte(CHN_C(s), ch);
>      s->rregs[R_STATUS] |=3D STATUS_RXAV;
> @@ -640,7 +595,7 @@ static void serial_receive_byte(ChannelState *s, int =
ch)
>      set_rxint(s);
>  }
> =20
> -static void serial_receive_break(ChannelState *s)
> +static void serial_receive_break(ESCCChannelState *s)
>  {
>      s->rregs[R_STATUS] |=3D STATUS_BRK;
>      escc_update_irq(s);
> @@ -648,13 +603,13 @@ static void serial_receive_break(ChannelState *s)
> =20
>  static void serial_receive1(void *opaque, const uint8_t *buf, int size)
>  {
> -    ChannelState *s =3D opaque;
> +    ESCCChannelState *s =3D opaque;
>      serial_receive_byte(s, buf[0]);
>  }
> =20
>  static void serial_event(void *opaque, int event)
>  {
> -    ChannelState *s =3D opaque;
> +    ESCCChannelState *s =3D opaque;
>      if (event =3D=3D CHR_EVENT_BREAK)
>          serial_receive_break(s);
>  }
> @@ -664,16 +619,16 @@ static const VMStateDescription vmstate_escc_chn =
=3D {
>      .version_id =3D 2,
>      .minimum_version_id =3D 1,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT32(vmstate_dummy, ChannelState),
> -        VMSTATE_UINT32(reg, ChannelState),
> -        VMSTATE_UINT32(rxint, ChannelState),
> -        VMSTATE_UINT32(txint, ChannelState),
> -        VMSTATE_UINT32(rxint_under_svc, ChannelState),
> -        VMSTATE_UINT32(txint_under_svc, ChannelState),
> -        VMSTATE_UINT8(rx, ChannelState),
> -        VMSTATE_UINT8(tx, ChannelState),
> -        VMSTATE_BUFFER(wregs, ChannelState),
> -        VMSTATE_BUFFER(rregs, ChannelState),
> +        VMSTATE_UINT32(vmstate_dummy, ESCCChannelState),
> +        VMSTATE_UINT32(reg, ESCCChannelState),
> +        VMSTATE_UINT32(rxint, ESCCChannelState),
> +        VMSTATE_UINT32(txint, ESCCChannelState),
> +        VMSTATE_UINT32(rxint_under_svc, ESCCChannelState),
> +        VMSTATE_UINT32(txint_under_svc, ESCCChannelState),
> +        VMSTATE_UINT8(rx, ESCCChannelState),
> +        VMSTATE_UINT8(tx, ESCCChannelState),
> +        VMSTATE_BUFFER(wregs, ESCCChannelState),
> +        VMSTATE_BUFFER(rregs, ESCCChannelState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -684,44 +639,15 @@ static const VMStateDescription vmstate_escc =3D {
>      .minimum_version_id =3D 1,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_STRUCT_ARRAY(chn, ESCCState, 2, 2, vmstate_escc_chn,
> -                             ChannelState),
> +                             ESCCChannelState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> =20
> -MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
> -              Chardev *chrA, Chardev *chrB,
> -              int clock, int it_shift)
> -{
> -    DeviceState *dev;
> -    SysBusDevice *s;
> -    ESCCState *d;
> -
> -    dev =3D qdev_create(NULL, TYPE_ESCC);
> -    qdev_prop_set_uint32(dev, "disabled", 0);
> -    qdev_prop_set_uint32(dev, "frequency", clock);
> -    qdev_prop_set_uint32(dev, "it_shift", it_shift);
> -    qdev_prop_set_chr(dev, "chrB", chrB);
> -    qdev_prop_set_chr(dev, "chrA", chrA);
> -    qdev_prop_set_uint32(dev, "chnBtype", ser);
> -    qdev_prop_set_uint32(dev, "chnAtype", ser);
> -    qdev_init_nofail(dev);
> -    s =3D SYS_BUS_DEVICE(dev);
> -    sysbus_connect_irq(s, 0, irqB);
> -    sysbus_connect_irq(s, 1, irqA);
> -    if (base) {
> -        sysbus_mmio_map(s, 0, base);
> -    }
> -
> -    d =3D ESCC(s);
> -    return &d->mmio;
> -}
> -
> -
>  static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
>                                  InputEvent *evt)
>  {
> -    ChannelState *s =3D (ChannelState *)dev;
> +    ESCCChannelState *s =3D (ESCCChannelState *)dev;
>      int qcode, keycode;
>      InputKeyEvent *key;
> =20
> @@ -777,7 +703,7 @@ static QemuInputHandler sunkbd_handler =3D {
>      .event =3D sunkbd_handle_event,
>  };
> =20
> -static void handle_kbd_command(ChannelState *s, int val)
> +static void handle_kbd_command(ESCCChannelState *s, int val)
>  {
>      trace_escc_kbd_command(val);
>      if (s->led_mode) { // Ignore led byte
> @@ -808,7 +734,7 @@ static void handle_kbd_command(ChannelState *s, int v=
al)
>  static void sunmouse_event(void *opaque,
>                                 int dx, int dy, int dz, int buttons_state)
>  {
> -    ChannelState *s =3D opaque;
> +    ESCCChannelState *s =3D opaque;
>      int ch;
> =20
>      trace_escc_sunmouse_event(dx, dy, buttons_state);
> @@ -847,27 +773,6 @@ static void sunmouse_event(void *opaque,
>      put_queue(s, 0);
>  }
> =20
> -void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
> -                               int disabled, int clock, int it_shift)
> -{
> -    DeviceState *dev;
> -    SysBusDevice *s;
> -
> -    dev =3D qdev_create(NULL, TYPE_ESCC);
> -    qdev_prop_set_uint32(dev, "disabled", disabled);
> -    qdev_prop_set_uint32(dev, "frequency", clock);
> -    qdev_prop_set_uint32(dev, "it_shift", it_shift);
> -    qdev_prop_set_chr(dev, "chrB", NULL);
> -    qdev_prop_set_chr(dev, "chrA", NULL);
> -    qdev_prop_set_uint32(dev, "chnBtype", mouse);
> -    qdev_prop_set_uint32(dev, "chnAtype", kbd);
> -    qdev_init_nofail(dev);
> -    s =3D SYS_BUS_DEVICE(dev);
> -    sysbus_connect_irq(s, 0, irq);
> -    sysbus_connect_irq(s, 1, irq);
> -    sysbus_mmio_map(s, 0, base);
> -}
> -
>  static void escc_init1(Object *obj)
>  {
>      ESCCState *s =3D ESCC(obj);
> @@ -904,11 +809,11 @@ static void escc_realize(DeviceState *dev, Error **=
errp)
>          }
>      }
> =20
> -    if (s->chn[0].type =3D=3D mouse) {
> +    if (s->chn[0].type =3D=3D escc_mouse) {
>          qemu_add_mouse_event_handler(sunmouse_event, &s->chn[0], 0,
>                                       "QEMU Sun Mouse");
>      }
> -    if (s->chn[1].type =3D=3D kbd) {
> +    if (s->chn[1].type =3D=3D escc_kbd) {
>          s->chn[1].hs =3D qemu_input_handler_register((DeviceState *)(&s-=
>chn[1]),
>                                                     &sunkbd_handler);
>      }
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index b832417a56..4e1298ee50 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -369,8 +369,23 @@ static void ppc_core99_init(MachineState *machine)
>      }
> =20
>      /* init basic PC hardware */
> -    escc_mem =3D escc_init(0, pic[0x25], pic[0x24],
> -                         serial_hds[0], serial_hds[1], ESCC_CLOCK, 4);
> +
> +    dev =3D qdev_create(NULL, TYPE_ESCC);
> +    qdev_prop_set_uint32(dev, "disabled", 0);
> +    qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
> +    qdev_prop_set_uint32(dev, "it_shift", 4);
> +    qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
> +    qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
> +    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
> +    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
> +    qdev_init_nofail(dev);
> +
> +    s =3D SYS_BUS_DEVICE(dev);
> +    sysbus_connect_irq(s, 0, pic[0x24]);
> +    sysbus_connect_irq(s, 1, pic[0x25]);
> +
> +    escc_mem =3D &ESCC(s)->mmio;
> +
>      memory_region_init_alias(escc_bar, NULL, "escc-bar",
>                               escc_mem, 0, memory_region_size(escc_mem));
> =20
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index d1f4546613..d0d21d2392 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -104,6 +104,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      void *fw_cfg;
>      uint64_t tbfreq;
> +    SysBusDevice *s;
> =20
>      linux_boot =3D (kernel_filename !=3D NULL);
> =20
> @@ -264,8 +265,22 @@ static void ppc_heathrow_init(MachineState *machine)
>                                 get_system_io());
>      pci_vga_init(pci_bus);
> =20
> -    escc_mem =3D escc_init(0, pic[0x0f], pic[0x10], serial_hds[0],
> -                               serial_hds[1], ESCC_CLOCK, 4);
> +    dev =3D qdev_create(NULL, TYPE_ESCC);
> +    qdev_prop_set_uint32(dev, "disabled", 0);
> +    qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
> +    qdev_prop_set_uint32(dev, "it_shift", 4);
> +    qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
> +    qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
> +    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
> +    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
> +    qdev_init_nofail(dev);
> +
> +    s =3D SYS_BUS_DEVICE(dev);
> +    sysbus_connect_irq(s, 0, pic[0x10]);
> +    sysbus_connect_irq(s, 1, pic[0x0f]);
> +
> +    escc_mem =3D &ESCC(s)->mmio;
> +
>      memory_region_init_alias(escc_bar, NULL, "escc-bar",
>                               escc_mem, 0, memory_region_size(escc_mem));
> =20
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index f9892e38c3..61eb424bbc 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -818,6 +818,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *h=
wdef,
>      DriveInfo *fd[MAX_FD];
>      FWCfgState *fw_cfg;
>      unsigned int num_vsimms;
> +    DeviceState *dev;
> +    SysBusDevice *s;
> =20
>      /* init CPUs */
>      for(i =3D 0; i < smp_cpus; i++) {
> @@ -925,12 +927,36 @@ static void sun4m_hw_init(const struct sun4m_hwdef =
*hwdef,
> =20
>      slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cp=
u_irq, smp_cpus);
> =20
> -    slavio_serial_ms_kbd_init(hwdef->ms_kb_base, slavio_irq[14],
> -                              !machine->enable_graphics, ESCC_CLOCK, 1);
>      /* Slavio TTYA (base+4, Linux ttyS0) is the first QEMU serial device
>         Slavio TTYB (base+0, Linux ttyS1) is the second QEMU serial devic=
e */
> -    escc_init(hwdef->serial_base, slavio_irq[15], slavio_irq[15],
> -              serial_hds[0], serial_hds[1], ESCC_CLOCK, 1);
> +    dev =3D qdev_create(NULL, TYPE_ESCC);
> +    qdev_prop_set_uint32(dev, "disabled", !machine->enable_graphics);
> +    qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
> +    qdev_prop_set_uint32(dev, "it_shift", 1);
> +    qdev_prop_set_chr(dev, "chrB", NULL);
> +    qdev_prop_set_chr(dev, "chrA", NULL);
> +    qdev_prop_set_uint32(dev, "chnBtype", escc_mouse);
> +    qdev_prop_set_uint32(dev, "chnAtype", escc_kbd);
> +    qdev_init_nofail(dev);
> +    s =3D SYS_BUS_DEVICE(dev);
> +    sysbus_connect_irq(s, 0, slavio_irq[14]);
> +    sysbus_connect_irq(s, 1, slavio_irq[14]);
> +    sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
> +
> +    dev =3D qdev_create(NULL, TYPE_ESCC);
> +    qdev_prop_set_uint32(dev, "disabled", 0);
> +    qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
> +    qdev_prop_set_uint32(dev, "it_shift", 1);
> +    qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
> +    qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
> +    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
> +    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
> +    qdev_init_nofail(dev);
> +
> +    s =3D SYS_BUS_DEVICE(dev);
> +    sysbus_connect_irq(s, 0, slavio_irq[15]);
> +    sysbus_connect_irq(s, 1,  slavio_irq[15]);
> +    sysbus_mmio_map(s, 0, hwdef->serial_base);
> =20
>      if (hwdef->apc_base) {
>          apc_init(hwdef->apc_base, qemu_allocate_irq(cpu_halt_signal, NUL=
L, 0));
> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
> index 08ae122386..42aca83611 100644
> --- a/include/hw/char/escc.h
> +++ b/include/hw/char/escc.h
> @@ -1,14 +1,58 @@
>  #ifndef HW_ESCC_H
>  #define HW_ESCC_H
> =20
> +#include "chardev/char-fe.h"
> +#include "chardev/char-serial.h"
> +#include "ui/input.h"
> +
>  /* escc.c */
>  #define TYPE_ESCC "escc"
>  #define ESCC_SIZE 4
> -MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
> -              Chardev *chrA, Chardev *chrB,
> -              int clock, int it_shift);
> =20
> -void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
> -                               int disabled, int clock, int it_shift);
> +#define ESCC(obj) OBJECT_CHECK(ESCCState, (obj), TYPE_ESCC)
> +
> +typedef enum {
> +    escc_chn_a, escc_chn_b,
> +} ESCCChnID;
> +
> +typedef enum {
> +    escc_serial, escc_kbd, escc_mouse,
> +} ESCCChnType;
> +
> +#define ESCC_SERIO_QUEUE_SIZE 256
> +
> +typedef struct {
> +    uint8_t data[ESCC_SERIO_QUEUE_SIZE];
> +    int rptr, wptr, count;
> +} ESCCSERIOQueue;
> +
> +#define ESCC_SERIAL_REGS 16
> +typedef struct ESCCChannelState {
> +    qemu_irq irq;
> +    uint32_t rxint, txint, rxint_under_svc, txint_under_svc;
> +    struct ESCCChannelState *otherchn;
> +    uint32_t reg;
> +    uint8_t wregs[ESCC_SERIAL_REGS], rregs[ESCC_SERIAL_REGS];
> +    ESCCSERIOQueue queue;
> +    CharBackend chr;
> +    int e0_mode, led_mode, caps_lock_mode, num_lock_mode;
> +    int disabled;
> +    int clock;
> +    uint32_t vmstate_dummy;
> +    ESCCChnID chn; /* this channel, A (base+4) or B (base+0) */
> +    ESCCChnType type;
> +    uint8_t rx, tx;
> +    QemuInputHandlerState *hs;
> +} ESCCChannelState;
> +
> +typedef struct ESCCState {
> +    SysBusDevice parent_obj;
> +
> +    struct ESCCChannelState chn[2];
> +    uint32_t it_shift;
> +    MemoryRegion mmio;
> +    uint32_t disabled;
> +    uint32_t frequency;
> +} ESCCState;
> =20
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqE8ycACgkQbDjKyiDZ
s5KNnw//YFCa8RIjmh/Zqtq33TKDDtf1HhxGuWCFs0s6CV5WbnciCGIC5O34BMpA
rZ1CLsT4zDekxsYnigh6fjyPHYFFOEIPS/vCY8z8ogxpw7JLtRmDe+Ew7VaKJsXq
BVjqHVlu0lgbZzQvFNTGrkrUNmSwSqRUUkM8J0yn2yTX/JYqB57BABb0dxIiHf23
nnW0KNQ9DD31rjkm9bOE04AzHQ3Gx43pofkn7tKj3BPAvO75KpY1e3n+vCG9xaju
28EnuOfcjJKZrL4i0eEABTUSQvlLxL3eiA8wUYP48zVHFKx+ZfiUtccq14S+5eVK
VxOEPqwINwxyXbB6Bm8Yf/kJq/p59BJib7iUNNaHLmRpMrl2fNNsCsNudNJAl0+c
oX05UNGgpVEE6VCGlr0JEdX9Hnzn9fWDphI/mUcIyyH89Ub3sqbbK+SY/ES4EF8J
9L1xc8MH6FFBKjsaHQHbPmV19EsFT7FB4ezF62JriaDwN4EioHHHWoPMBAeF+HHP
JYkr99Pw3SAnarDcQ8xppQGoKo9H0Z5kqmKbAcLr8VHZ6Yd7n/ptxTmUqDldGYt+
ljsyNYsvBPsrI98RZa+ixX6zNGR8VGHQN+189X9Tqcl5YDhYD1O8zlx37WHdRgzn
r2/zQdkG+tCFsOwabB7sD36d2wAy09fH0jIkTbGJwAg1B49hvoY=
=V8ub
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
