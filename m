Received: from eggs.gnu.org ([2001:4830:134:3::10]:42982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1egAK4-0003M4-5r
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1egAJx-00086f-Or
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:22:12 -0500
References: <20180126144742.3636-1-lvivier@redhat.com>
	<1ad5086b-1704-0561-2d29-147d3d2ee6d3@ilande.co.uk>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <3bb55aca-77fa-9ab7-4b13-98698d3c0008@redhat.com>
Date: Mon, 29 Jan 2018 15:21:59 +0100
MIME-Version: 1.0
In-Reply-To: <1ad5086b-1704-0561-2d29-147d3d2ee6d3@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Artyom Tarasenko <atar4qemu@gmail.com>

Paolo,

I forgot to cc: you for the "MAINTAINERS/Character devices/Odd Fixes".
Could you take this through your branch?

Thanks,
Laurent

On 26/01/2018 16:41, Mark Cave-Ayland wrote:
> On 26/01/18 14:47, Laurent Vivier wrote:
>=20
>> Move necessary stuff in escc.h and update type names.
>> Remove slavio_serial_ms_kbd_init().
>> Fix code style problems reported by checkpatch.pl
>> Update mac_newworld, mac_oldworld and sun4m to use directly the
>> QDEV interface.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>
>> Notes:
>> =C2=A0=C2=A0=C2=A0=C2=A0 v3: in sun4m, move comments about Slavio TTY
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 above both qdev_creat=
e().
>> =C2=A0=C2=A0=C2=A0=C2=A0 v2: in sun4m, move comments about Slavio TTY =
close to
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 their qdev_prop_set_c=
hr()
>>
>> =C2=A0 hw/char/escc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 208
>> ++++++++++++++-----------------------------------
>> =C2=A0 hw/ppc/mac_newworld.c=C2=A0 |=C2=A0 19 ++++-
>> =C2=A0 hw/ppc/mac_oldworld.c=C2=A0 |=C2=A0 19 ++++-
>> =C2=A0 hw/sparc/sun4m.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 34=
 +++++++-
>> =C2=A0 include/hw/char/escc.h |=C2=A0 54 +++++++++++--
>> =C2=A0 5 files changed, 170 insertions(+), 164 deletions(-)
>>
>> diff --git a/hw/char/escc.c b/hw/char/escc.c
>> index 3ab831a6a7..bb735cc0c8 100644
>> --- a/hw/char/escc.c
>> +++ b/hw/char/escc.c
>> @@ -26,10 +26,7 @@
>> =C2=A0 #include "hw/hw.h"
>> =C2=A0 #include "hw/sysbus.h"
>> =C2=A0 #include "hw/char/escc.h"
>> -#include "chardev/char-fe.h"
>> -#include "chardev/char-serial.h"
>> =C2=A0 #include "ui/console.h"
>> -#include "ui/input.h"
>> =C2=A0 #include "trace.h"
>> =C2=A0 =C2=A0 /*
>> @@ -64,53 +61,7 @@
>> =C2=A0=C2=A0 *=C2=A0 2010-May-23=C2=A0 Artyom Tarasenko:=C2=A0 Reworke=
d IUS logic
>> =C2=A0=C2=A0 */
>> =C2=A0 -typedef enum {
>> -=C2=A0=C2=A0=C2=A0 chn_a, chn_b,
>> -} ChnID;
>> -
>> -#define CHN_C(s) ((s)->chn =3D=3D chn_b? 'b' : 'a')
>> -
>> -typedef enum {
>> -=C2=A0=C2=A0=C2=A0 ser, kbd, mouse,
>> -} ChnType;
>> -
>> -#define SERIO_QUEUE_SIZE 256
>> -
>> -typedef struct {
>> -=C2=A0=C2=A0=C2=A0 uint8_t data[SERIO_QUEUE_SIZE];
>> -=C2=A0=C2=A0=C2=A0 int rptr, wptr, count;
>> -} SERIOQueue;
>> -
>> -#define SERIAL_REGS 16
>> -typedef struct ChannelState {
>> -=C2=A0=C2=A0=C2=A0 qemu_irq irq;
>> -=C2=A0=C2=A0=C2=A0 uint32_t rxint, txint, rxint_under_svc, txint_unde=
r_svc;
>> -=C2=A0=C2=A0=C2=A0 struct ChannelState *otherchn;
>> -=C2=A0=C2=A0=C2=A0 uint32_t reg;
>> -=C2=A0=C2=A0=C2=A0 uint8_t wregs[SERIAL_REGS], rregs[SERIAL_REGS];
>> -=C2=A0=C2=A0=C2=A0 SERIOQueue queue;
>> -=C2=A0=C2=A0=C2=A0 CharBackend chr;
>> -=C2=A0=C2=A0=C2=A0 int e0_mode, led_mode, caps_lock_mode, num_lock_mo=
de;
>> -=C2=A0=C2=A0=C2=A0 int disabled;
>> -=C2=A0=C2=A0=C2=A0 int clock;
>> -=C2=A0=C2=A0=C2=A0 uint32_t vmstate_dummy;
>> -=C2=A0=C2=A0=C2=A0 ChnID chn; // this channel, A (base+4) or B (base+=
0)
>> -=C2=A0=C2=A0=C2=A0 ChnType type;
>> -=C2=A0=C2=A0=C2=A0 uint8_t rx, tx;
>> -=C2=A0=C2=A0=C2=A0 QemuInputHandlerState *hs;
>> -} ChannelState;
>> -
>> -#define ESCC(obj) OBJECT_CHECK(ESCCState, (obj), TYPE_ESCC)
>> -
>> -typedef struct ESCCState {
>> -=C2=A0=C2=A0=C2=A0 SysBusDevice parent_obj;
>> -
>> -=C2=A0=C2=A0=C2=A0 struct ChannelState chn[2];
>> -=C2=A0=C2=A0=C2=A0 uint32_t it_shift;
>> -=C2=A0=C2=A0=C2=A0 MemoryRegion mmio;
>> -=C2=A0=C2=A0=C2=A0 uint32_t disabled;
>> -=C2=A0=C2=A0=C2=A0 uint32_t frequency;
>> -} ESCCState;
>> +#define CHN_C(s) ((s)->chn =3D=3D escc_chn_b ? 'b' : 'a')
>> =C2=A0 =C2=A0 #define SERIAL_CTRL 0
>> =C2=A0 #define SERIAL_DATA 1
>> @@ -214,44 +165,47 @@ typedef struct ESCCState {
>> =C2=A0 #define R_MISC1I 14
>> =C2=A0 #define R_EXTINT 15
>> =C2=A0 -static void handle_kbd_command(ChannelState *s, int val);
>> +static void handle_kbd_command(ESCCChannelState *s, int val);
>> =C2=A0 static int serial_can_receive(void *opaque);
>> -static void serial_receive_byte(ChannelState *s, int ch);
>> +static void serial_receive_byte(ESCCChannelState *s, int ch);
>> =C2=A0 =C2=A0 static void clear_queue(void *opaque)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 ChannelState *s =3D opaque;
>> -=C2=A0=C2=A0=C2=A0 SERIOQueue *q =3D &s->queue;
>> +=C2=A0=C2=A0=C2=A0 ESCCChannelState *s =3D opaque;
>> +=C2=A0=C2=A0=C2=A0 ESCCSERIOQueue *q =3D &s->queue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->rptr =3D q->wptr =3D q->count =3D 0;
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void put_queue(void *opaque, int b)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 ChannelState *s =3D opaque;
>> -=C2=A0=C2=A0=C2=A0 SERIOQueue *q =3D &s->queue;
>> +=C2=A0=C2=A0=C2=A0 ESCCChannelState *s =3D opaque;
>> +=C2=A0=C2=A0=C2=A0 ESCCSERIOQueue *q =3D &s->queue;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_escc_put_queue(CHN_C(s), b=
);
>> -=C2=A0=C2=A0=C2=A0 if (q->count >=3D SERIO_QUEUE_SIZE)
>> +=C2=A0=C2=A0=C2=A0 if (q->count >=3D ESCC_SERIO_QUEUE_SIZE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->data[q->wptr] =3D b;
>> -=C2=A0=C2=A0=C2=A0 if (++q->wptr =3D=3D SERIO_QUEUE_SIZE)
>> +=C2=A0=C2=A0=C2=A0 if (++q->wptr =3D=3D ESCC_SERIO_QUEUE_SIZE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->wptr =3D 0;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->count++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_receive_byte(s, 0);
>> =C2=A0 }
>> =C2=A0 =C2=A0 static uint32_t get_queue(void *opaque)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 ChannelState *s =3D opaque;
>> -=C2=A0=C2=A0=C2=A0 SERIOQueue *q =3D &s->queue;
>> +=C2=A0=C2=A0=C2=A0 ESCCChannelState *s =3D opaque;
>> +=C2=A0=C2=A0=C2=A0 ESCCSERIOQueue *q =3D &s->queue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (q->count =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D q->data=
[q->rptr];
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (++q->rptr =3D=3D SERIO=
_QUEUE_SIZE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (++q->rptr =3D=3D ESCC_=
SERIO_QUEUE_SIZE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 q->rptr =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->count--;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_escc_get_queue(CHN_C(s), val);
>> @@ -260,7 +214,7 @@ static uint32_t get_queue(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return val;
>> =C2=A0 }
>> =C2=A0 -static int escc_update_irq_chn(ChannelState *s)
>> +static int escc_update_irq_chn(ESCCChannelState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((((s->wregs[W_INTR] & INTR_TXINT) &=
& (s->txint =3D=3D 1)) ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // tx int=
s enabled, pending
>> @@ -274,7 +228,7 @@ static int escc_update_irq_chn(ChannelState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -static void escc_update_irq(ChannelState *s)
>> +static void escc_update_irq(ESCCChannelState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int irq;
>> =C2=A0 @@ -285,12 +239,12 @@ static void escc_update_irq(ChannelState =
*s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_irq(s->irq, irq);
>> =C2=A0 }
>> =C2=A0 -static void escc_reset_chn(ChannelState *s)
>> +static void escc_reset_chn(ESCCChannelState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->reg =3D 0;
>> -=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < SERIAL_REGS; i++) {
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ESCC_SERIAL_REGS; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rregs[i] =3D=
 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->wregs[i] =3D=
 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -322,13 +276,13 @@ static void escc_reset(DeviceState *d)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 escc_reset_chn(&s->chn[1]);
>> =C2=A0 }
>> =C2=A0 -static inline void set_rxint(ChannelState *s)
>> +static inline void set_rxint(ESCCChannelState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rxint =3D 1;
>> -=C2=A0=C2=A0=C2=A0 /* XXX: missing daisy chainnig: chn_b rx should ha=
ve a lower
>> priority
>> +=C2=A0=C2=A0=C2=A0 /* XXX: missing daisy chainnig: escc_chn_b rx shou=
ld have a lower
>> priority
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 than chn_a rx/tx/spec=
ial_condition service*/
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rxint_under_svc =3D 1;
>> -=C2=A0=C2=A0=C2=A0 if (s->chn =3D=3D chn_a) {
>> +=C2=A0=C2=A0=C2=A0 if (s->chn =3D=3D escc_chn_a) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rregs[R_INTR=
] |=3D INTR_RXINTA;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->wregs[W_=
MINTR] & MINTR_STATUSHI)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s->otherchn->rregs[R_IVEC] =3D IVEC_HIRXINTA;
>> @@ -344,12 +298,12 @@ static inline void set_rxint(ChannelState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 escc_update_irq(s);
>> =C2=A0 }
>> =C2=A0 -static inline void set_txint(ChannelState *s)
>> +static inline void set_txint(ESCCChannelState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->txint =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->rxint_under_svc) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->txint_under_=
svc =3D 1;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->chn =3D=3D chn_a) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->chn =3D=3D escc_chn=
_a) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (s->wregs[W_INTR] & INTR_TXINT) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rregs[R_INTR] |=3D INTR_TXINTA;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> @@ -367,11 +321,11 @@ static inline void set_txint(ChannelState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 -static inline void clr_rxint(ChannelState *s)
>> +static inline void clr_rxint(ESCCChannelState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rxint =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rxint_under_svc =3D 0;
>> -=C2=A0=C2=A0=C2=A0 if (s->chn =3D=3D chn_a) {
>> +=C2=A0=C2=A0=C2=A0 if (s->chn =3D=3D escc_chn_a) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->wregs[W_=
MINTR] & MINTR_STATUSHI)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s->otherchn->rregs[R_IVEC] =3D IVEC_HINOINT;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> @@ -389,11 +343,11 @@ static inline void clr_rxint(ChannelState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 escc_update_irq(s);
>> =C2=A0 }
>> =C2=A0 -static inline void clr_txint(ChannelState *s)
>> +static inline void clr_txint(ESCCChannelState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->txint =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->txint_under_svc =3D 0;
>> -=C2=A0=C2=A0=C2=A0 if (s->chn =3D=3D chn_a) {
>> +=C2=A0=C2=A0=C2=A0 if (s->chn =3D=3D escc_chn_a) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->wregs[W_=
MINTR] & MINTR_STATUSHI)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s->otherchn->rregs[R_IVEC] =3D IVEC_HINOINT;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> @@ -412,12 +366,12 @@ static inline void clr_txint(ChannelState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 escc_update_irq(s);
>> =C2=A0 }
>> =C2=A0 -static void escc_update_parameters(ChannelState *s)
>> +static void escc_update_parameters(ESCCChannelState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int speed, parity, data_bits, stop_bits=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUSerialSetParams ssp;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!qemu_chr_fe_backend_connected(&s->chr)=
 || s->type !=3D ser)
>> +=C2=A0=C2=A0=C2=A0 if (!qemu_chr_fe_backend_connected(&s->chr) || s->=
type !=3D
>> escc_serial)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->wregs[W_TXCTRL1] & TXCTRL=
1_PAREN) {
>> @@ -474,7 +428,7 @@ static void escc_mem_write(void *opaque, hwaddr ad=
dr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint64_t val, unsigned size)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ESCCState *serial =3D opaque;
>> -=C2=A0=C2=A0=C2=A0 ChannelState *s;
>> +=C2=A0=C2=A0=C2=A0 ESCCChannelState *s;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t saddr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int newreg, channel;
>> =C2=A0 @@ -561,7 +515,7 @@ static void escc_mem_write(void *opaque, hw=
addr
>> addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* XXX this blocks entire thread. Rewrite =
to use
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * qemu_chr_fe_write and background I=
/O callbacks */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_write_all(&s->chr, &s->tx, 1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else if (s->type =3D=3D kbd && !s->disabled) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else if (s->type =3D=3D escc_kbd && !s->disabled) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle_kbd_command(s, val);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -578,7 +532,7 @@ static uint64_t escc_mem_read(void *opaque, hwaddr
>> addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned size)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ESCCState *serial =3D opaque;
>> -=C2=A0=C2=A0=C2=A0 ChannelState *s;
>> +=C2=A0=C2=A0=C2=A0 ESCCChannelState *s;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t saddr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int channel;
>> @@ -595,10 +549,11 @@ static uint64_t escc_mem_read(void *opaque,
>> hwaddr addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SERIAL_DATA:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rregs[R_STAT=
US] &=3D ~STATUS_RXAV;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clr_rxint(s);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->type =3D=3D kbd || =
s->type =3D=3D mouse)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->type =3D=3D escc_kb=
d || s->type =3D=3D escc_mouse) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D get_queue(s);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D s->rx;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_escc_mem_=
readb_data(CHN_C(s), ret);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_acc=
ept_input(&s->chr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> @@ -620,7 +575,7 @@ static const MemoryRegionOps escc_mem_ops =3D {
>> =C2=A0 =C2=A0 static int serial_can_receive(void *opaque)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 ChannelState *s =3D opaque;
>> +=C2=A0=C2=A0=C2=A0 ESCCChannelState *s =3D opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((s->wregs[W_RXCTRL] & RXCTR=
L_RXEN) =3D=3D 0) // Rx not enabled
>> @@ -632,7 +587,7 @@ static int serial_can_receive(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 -static void serial_receive_byte(ChannelState *s, int ch)
>> +static void serial_receive_byte(ESCCChannelState *s, int ch)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_escc_serial_receive_byte(CHN_C(s)=
, ch);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rregs[R_STATUS] |=3D STATUS_RXAV;
>> @@ -640,7 +595,7 @@ static void serial_receive_byte(ChannelState *s,
>> int ch)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_rxint(s);
>> =C2=A0 }
>> =C2=A0 -static void serial_receive_break(ChannelState *s)
>> +static void serial_receive_break(ESCCChannelState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rregs[R_STATUS] |=3D STATUS_BRK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 escc_update_irq(s);
>> @@ -648,13 +603,13 @@ static void serial_receive_break(ChannelState *s=
)
>> =C2=A0 =C2=A0 static void serial_receive1(void *opaque, const uint8_t =
*buf, int
>> size)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 ChannelState *s =3D opaque;
>> +=C2=A0=C2=A0=C2=A0 ESCCChannelState *s =3D opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_receive_byte(s, buf[0]);
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void serial_event(void *opaque, int event)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 ChannelState *s =3D opaque;
>> +=C2=A0=C2=A0=C2=A0 ESCCChannelState *s =3D opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (event =3D=3D CHR_EVENT_BREAK)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_receive_=
break(s);
>> =C2=A0 }
>> @@ -664,16 +619,16 @@ static const VMStateDescription vmstate_escc_chn
>> =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .version_id =3D 2,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 1,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fields =3D (VMStateField[]) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(vmstate_dum=
my, ChannelState),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(reg, Channe=
lState),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(rxint, Chan=
nelState),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(txint, Chan=
nelState),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(rxint_under=
_svc, ChannelState),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(txint_under=
_svc, ChannelState),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(rx, ChannelS=
tate),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(tx, ChannelS=
tate),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BUFFER(wregs, Chan=
nelState),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BUFFER(rregs, Chan=
nelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(vmstate_dum=
my, ESCCChannelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(reg, ESCCCh=
annelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(rxint, ESCC=
ChannelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(txint, ESCC=
ChannelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(rxint_under=
_svc, ESCCChannelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(txint_under=
_svc, ESCCChannelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(rx, ESCCChan=
nelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(tx, ESCCChan=
nelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BUFFER(wregs, ESCC=
ChannelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BUFFER(rregs, ESCC=
ChannelState),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_=
LIST()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 };
>> @@ -684,39 +639,11 @@ static const VMStateDescription vmstate_escc =3D=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 1,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fields =3D (VMStateField[]) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_STRUCT_=
ARRAY(chn, ESCCState, 2, 2, vmstate_escc_chn,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ChannelState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ESCCChannelState),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_=
LIST()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 };
>> =C2=A0 -MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq i=
rqB,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Chardev *chrA, Chardev *chrB,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int clock, int it_shift)
>> -{
>> -=C2=A0=C2=A0=C2=A0 DeviceState *dev;
>> -=C2=A0=C2=A0=C2=A0 SysBusDevice *s;
>> -=C2=A0=C2=A0=C2=A0 ESCCState *d;
>> -
>> -=C2=A0=C2=A0=C2=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "disabled", 0);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "frequency", clock);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "it_shift", it_shift);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrB", chrB);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrA", chrA);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnBtype", ser);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnAtype", ser);
>> -=C2=A0=C2=A0=C2=A0 qdev_init_nofail(dev);
>> -=C2=A0=C2=A0=C2=A0 s =3D SYS_BUS_DEVICE(dev);
>> -=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 0, irqB);
>> -=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 1, irqA);
>> -=C2=A0=C2=A0=C2=A0 if (base) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(s, 0, base=
);
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 d =3D ESCC(s);
>> -=C2=A0=C2=A0=C2=A0 return &d->mmio;
>> -}
>> -
>> =C2=A0 static const uint8_t qcode_to_keycode[Q_KEY_CODE__MAX] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Q_KEY_CODE_SHIFT]=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 99,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Q_KEY_CODE_SHIFT_R]=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D 110,
>> @@ -841,7 +768,7 @@ static const uint8_t
>> qcode_to_keycode[Q_KEY_CODE__MAX] =3D {
>> =C2=A0 static void sunkbd_handle_event(DeviceState *dev, QemuConsole *=
src,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 InputEvent *evt)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 ChannelState *s =3D (ChannelState *)dev;
>> +=C2=A0=C2=A0=C2=A0 ESCCChannelState *s =3D (ESCCChannelState *)dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int qcode, keycode;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 InputKeyEvent *key;
>> =C2=A0 @@ -893,7 +820,7 @@ static QemuInputHandler sunkbd_handler =3D =
{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .event =3D sunkbd_handle_event,
>> =C2=A0 };
>> =C2=A0 -static void handle_kbd_command(ChannelState *s, int val)
>> +static void handle_kbd_command(ESCCChannelState *s, int val)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_escc_kbd_command(val);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->led_mode) { // Ignore led byte
>> @@ -924,7 +851,7 @@ static void handle_kbd_command(ChannelState *s,
>> int val)
>> =C2=A0 static void sunmouse_event(void *opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int dx, int dy, int dz, int
>> buttons_state)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 ChannelState *s =3D opaque;
>> +=C2=A0=C2=A0=C2=A0 ESCCChannelState *s =3D opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ch;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_escc_sunmouse_event(dx, dy=
, buttons_state);
>> @@ -963,27 +890,6 @@ static void sunmouse_event(void *opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_queue(s, 0);
>> =C2=A0 }
>> =C2=A0 -void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int disabled, int clock, int it_shif=
t)
>> -{
>> -=C2=A0=C2=A0=C2=A0 DeviceState *dev;
>> -=C2=A0=C2=A0=C2=A0 SysBusDevice *s;
>> -
>> -=C2=A0=C2=A0=C2=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "disabled", disabled);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "frequency", clock);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "it_shift", it_shift);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrB", NULL);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrA", NULL);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnBtype", mouse);
>> -=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnAtype", kbd);
>> -=C2=A0=C2=A0=C2=A0 qdev_init_nofail(dev);
>> -=C2=A0=C2=A0=C2=A0 s =3D SYS_BUS_DEVICE(dev);
>> -=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 0, irq);
>> -=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 1, irq);
>> -=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(s, 0, base);
>> -}
>> -
>> =C2=A0 static void escc_init1(Object *obj)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ESCCState *s =3D ESCC(obj);
>> @@ -1020,11 +926,11 @@ static void escc_realize(DeviceState *dev,
>> Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (s->chn[0].type =3D=3D mouse) {
>> +=C2=A0=C2=A0=C2=A0 if (s->chn[0].type =3D=3D escc_mouse) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_add_mouse_=
event_handler(sunmouse_event, &s->chn[0], 0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "QEMU Sun Mouse");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (s->chn[1].type =3D=3D kbd) {
>> +=C2=A0=C2=A0=C2=A0 if (s->chn[1].type =3D=3D escc_kbd) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->chn[1].hs =3D=
 qemu_input_handler_register((DeviceState
>> *)(&s->chn[1]),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 &sunkbd_handler);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>> index 3fa7c429d5..de061ae76f 100644
>> --- a/hw/ppc/mac_newworld.c
>> +++ b/hw/ppc/mac_newworld.c
>> @@ -369,8 +369,23 @@ static void ppc_core99_init(MachineState *machine=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* init basic PC hardware */
>> -=C2=A0=C2=A0=C2=A0 escc_mem =3D escc_init(0, pic[0x25], pic[0x24],
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 serial_hds[0], serial_hds[1], ESCC_CLOCK, 4);
>> +
>> +=C2=A0=C2=A0=C2=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "disabled", 0);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK)=
;
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "it_shift", 4);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnAtype", escc_serial)=
;
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnBtype", escc_serial)=
;
>> +=C2=A0=C2=A0=C2=A0 qdev_init_nofail(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 s =3D SYS_BUS_DEVICE(dev);
>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 0, pic[0x24]);
>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 1, pic[0x25]);
>> +
>> +=C2=A0=C2=A0=C2=A0 escc_mem =3D &ESCC(s)->mmio;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_init_alias(escc_bar, NULL=
, "escc-bar",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 escc_mem, 0,
>> memory_region_size(escc_mem));
>> =C2=A0 diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>> index 010ea36bf2..da0106b09d 100644
>> --- a/hw/ppc/mac_oldworld.c
>> +++ b/hw/ppc/mac_oldworld.c
>> @@ -104,6 +104,7 @@ static void ppc_heathrow_init(MachineState *machin=
e)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEV=
S];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *fw_cfg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t tbfreq;
>> +=C2=A0=C2=A0=C2=A0 SysBusDevice *s;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux_boot =3D (kernel_filename =
!=3D NULL);
>> =C2=A0 @@ -264,8 +265,22 @@ static void ppc_heathrow_init(MachineState
>> *machine)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_system_io());
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_vga_init(pci_bus);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 escc_mem =3D escc_init(0, pic[0x0f], pic[0x=
10], serial_hds[0],
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_hds[1], ESCC_CLOCK, 4);
>> +=C2=A0=C2=A0=C2=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "disabled", 0);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK)=
;
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "it_shift", 4);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnBtype", escc_serial)=
;
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnAtype", escc_serial)=
;
>> +=C2=A0=C2=A0=C2=A0 qdev_init_nofail(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 s =3D SYS_BUS_DEVICE(dev);
>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 0, pic[0x10]);
>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 1, pic[0x0f]);
>> +
>> +=C2=A0=C2=A0=C2=A0 escc_mem =3D &ESCC(s)->mmio;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_init_alias(escc_bar, NULL=
, "escc-bar",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 escc_mem, 0,
>> memory_region_size(escc_mem));
>> =C2=A0 diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index dd0038095b..0b3911cd65 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -820,6 +820,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef
>> *hwdef,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DriveInfo *fd[MAX_FD];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWCfgState *fw_cfg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int num_vsimms;
>> +=C2=A0=C2=A0=C2=A0 DeviceState *dev;
>> +=C2=A0=C2=A0=C2=A0 SysBusDevice *s;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* init CPUs */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for(i =3D 0; i < smp_cpus; i++) {
>> @@ -927,12 +929,36 @@ static void sun4m_hw_init(const struct
>> sun4m_hwdef *hwdef,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 slavio_timer_init_all(hwdef->cou=
nter_base, slavio_irq[19],
>> slavio_cpu_irq, smp_cpus);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 slavio_serial_ms_kbd_init(hwdef->ms_kb_base=
, slavio_irq[14],
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !machine->enable_graphics, ESCC_CLOCK, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Slavio TTYA (base+4, Linux ttyS0) is=
 the first QEMU serial
>> device
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Slavio TTYB (base+0, =
Linux ttyS1) is the second QEMU serial
>> device */
>> -=C2=A0=C2=A0=C2=A0 escc_init(hwdef->serial_base, slavio_irq[15], slav=
io_irq[15],
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 serial_hds[0], serial_hds[1], ESCC_CLOCK, 1);
>> +=C2=A0=C2=A0=C2=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "disabled", !machine->en=
able_graphics);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK)=
;
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "it_shift", 1);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrB", NULL);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrA", NULL);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnBtype", escc_mouse);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnAtype", escc_kbd);
>> +=C2=A0=C2=A0=C2=A0 qdev_init_nofail(dev);
>> +=C2=A0=C2=A0=C2=A0 s =3D SYS_BUS_DEVICE(dev);
>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 0, slavio_irq[14]);
>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 1, slavio_irq[14]);
>> +=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
>> +
>> +=C2=A0=C2=A0=C2=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "disabled", 0);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK)=
;
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "it_shift", 1);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnBtype", escc_serial)=
;
>> +=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(dev, "chnAtype", escc_serial)=
;
>> +=C2=A0=C2=A0=C2=A0 qdev_init_nofail(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 s =3D SYS_BUS_DEVICE(dev);
>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 0, slavio_irq[15]);
>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(s, 1,=C2=A0 slavio_irq[15]);
>> +=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(s, 0, hwdef->serial_base);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hwdef->apc_base) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apc_init(hwdef-=
>apc_base, qemu_allocate_irq(cpu_halt_signal,
>> NULL, 0));
>> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
>> index 08ae122386..42aca83611 100644
>> --- a/include/hw/char/escc.h
>> +++ b/include/hw/char/escc.h
>> @@ -1,14 +1,58 @@
>> =C2=A0 #ifndef HW_ESCC_H
>> =C2=A0 #define HW_ESCC_H
>> =C2=A0 +#include "chardev/char-fe.h"
>> +#include "chardev/char-serial.h"
>> +#include "ui/input.h"
>> +
>> =C2=A0 /* escc.c */
>> =C2=A0 #define TYPE_ESCC "escc"
>> =C2=A0 #define ESCC_SIZE 4
>> -MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Chardev *chrA, Chardev *chrB,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int clock, int it_shift);
>> =C2=A0 -void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int disabled, int clock, int it_shif=
t);
>> +#define ESCC(obj) OBJECT_CHECK(ESCCState, (obj), TYPE_ESCC)
>> +
>> +typedef enum {
>> +=C2=A0=C2=A0=C2=A0 escc_chn_a, escc_chn_b,
>> +} ESCCChnID;
>> +
>> +typedef enum {
>> +=C2=A0=C2=A0=C2=A0 escc_serial, escc_kbd, escc_mouse,
>> +} ESCCChnType;
>> +
>> +#define ESCC_SERIO_QUEUE_SIZE 256
>> +
>> +typedef struct {
>> +=C2=A0=C2=A0=C2=A0 uint8_t data[ESCC_SERIO_QUEUE_SIZE];
>> +=C2=A0=C2=A0=C2=A0 int rptr, wptr, count;
>> +} ESCCSERIOQueue;
>> +
>> +#define ESCC_SERIAL_REGS 16
>> +typedef struct ESCCChannelState {
>> +=C2=A0=C2=A0=C2=A0 qemu_irq irq;
>> +=C2=A0=C2=A0=C2=A0 uint32_t rxint, txint, rxint_under_svc, txint_unde=
r_svc;
>> +=C2=A0=C2=A0=C2=A0 struct ESCCChannelState *otherchn;
>> +=C2=A0=C2=A0=C2=A0 uint32_t reg;
>> +=C2=A0=C2=A0=C2=A0 uint8_t wregs[ESCC_SERIAL_REGS], rregs[ESCC_SERIAL=
_REGS];
>> +=C2=A0=C2=A0=C2=A0 ESCCSERIOQueue queue;
>> +=C2=A0=C2=A0=C2=A0 CharBackend chr;
>> +=C2=A0=C2=A0=C2=A0 int e0_mode, led_mode, caps_lock_mode, num_lock_mo=
de;
>> +=C2=A0=C2=A0=C2=A0 int disabled;
>> +=C2=A0=C2=A0=C2=A0 int clock;
>> +=C2=A0=C2=A0=C2=A0 uint32_t vmstate_dummy;
>> +=C2=A0=C2=A0=C2=A0 ESCCChnID chn; /* this channel, A (base+4) or B (b=
ase+0) */
>> +=C2=A0=C2=A0=C2=A0 ESCCChnType type;
>> +=C2=A0=C2=A0=C2=A0 uint8_t rx, tx;
>> +=C2=A0=C2=A0=C2=A0 QemuInputHandlerState *hs;
>> +} ESCCChannelState;
>> +
>> +typedef struct ESCCState {
>> +=C2=A0=C2=A0=C2=A0 SysBusDevice parent_obj;
>> +
>> +=C2=A0=C2=A0=C2=A0 struct ESCCChannelState chn[2];
>> +=C2=A0=C2=A0=C2=A0 uint32_t it_shift;
>> +=C2=A0=C2=A0=C2=A0 MemoryRegion mmio;
>> +=C2=A0=C2=A0=C2=A0 uint32_t disabled;
>> +=C2=A0=C2=A0=C2=A0 uint32_t frequency;
>> +} ESCCState;
>> =C2=A0 =C2=A0 #endif
>=20
> Looks good to me. Note to self: I wonder how easy it would be to split
> the sun keyboard/mouse out from here too.
>=20
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
>=20
> ATB,
>=20
> Mark.
