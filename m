Received: from eggs.gnu.org ([2001:4830:134:3::10]:42627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elp9Y-00010L-7s
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elp9U-0001eW-Bf
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:58:44 -0500
Date: Wed, 14 Feb 2018 15:58:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180214045833.GB5247@umbus.fritz.box>
References: <20180126144742.3636-1-lvivier@redhat.com>
	<1ad5086b-1704-0561-2d29-147d3d2ee6d3@ilande.co.uk>
	<3bb55aca-77fa-9ab7-4b13-98698d3c0008@redhat.com>
	<9f0f9819-f608-c326-f975-a3338d6fc24d@redhat.com>
	<65da244c-1550-0292-a849-10c0dc1f35b0@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <65da244c-1550-0292-a849-10c0dc1f35b0@ilande.co.uk>
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Alexander Graf <agraf@suse.de>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 10:57:46PM +0000, Mark Cave-Ayland wrote:
> On 13/02/18 13:01, Laurent Vivier wrote:
>=20
> > Hi,
> >=20
> > can a maintainer of one of the involved parts take this in his
> > maintenance branch to have this merged?
> >=20
> > Thanks,
> > Laurent
> >=20
> > On 29/01/2018 15:21, Laurent Vivier wrote:
> > > Paolo,
> > >=20
> > > I forgot to cc: you for the "MAINTAINERS/Character devices/Odd Fixes".
> > > Could you take this through your branch?
> > >=20
> > > Thanks,
> > > Laurent
> > >=20
> > > On 26/01/2018 16:41, Mark Cave-Ayland wrote:
> > > > On 26/01/18 14:47, Laurent Vivier wrote:
> > > >=20
> > > > > Move necessary stuff in escc.h and update type names.
> > > > > Remove slavio_serial_ms_kbd_init().
> > > > > Fix code style problems reported by checkpatch.pl
> > > > > Update mac_newworld, mac_oldworld and sun4m to use directly the
> > > > > QDEV interface.
> > > > >=20
> > > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > > > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > > > ---
> > > > >=20
> > > > > Notes:
> > > > >  =A0=A0=A0=A0 v3: in sun4m, move comments about Slavio TTY
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0 above both qdev_create().
> > > > >  =A0=A0=A0=A0 v2: in sun4m, move comments about Slavio TTY close =
to
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0 their qdev_prop_set_chr()
> > > > >=20
> > > > >  =A0 hw/char/escc.c=A0=A0=A0=A0=A0=A0=A0=A0 | 208
> > > > > ++++++++++++++-----------------------------------
> > > > >  =A0 hw/ppc/mac_newworld.c=A0 |=A0 19 ++++-
> > > > >  =A0 hw/ppc/mac_oldworld.c=A0 |=A0 19 ++++-
> > > > >  =A0 hw/sparc/sun4m.c=A0=A0=A0=A0=A0=A0 |=A0 34 +++++++-
> > > > >  =A0 include/hw/char/escc.h |=A0 54 +++++++++++--
> > > > >  =A0 5 files changed, 170 insertions(+), 164 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/char/escc.c b/hw/char/escc.c
> > > > > index 3ab831a6a7..bb735cc0c8 100644
> > > > > --- a/hw/char/escc.c
> > > > > +++ b/hw/char/escc.c
> > > > > @@ -26,10 +26,7 @@
> > > > >  =A0 #include "hw/hw.h"
> > > > >  =A0 #include "hw/sysbus.h"
> > > > >  =A0 #include "hw/char/escc.h"
> > > > > -#include "chardev/char-fe.h"
> > > > > -#include "chardev/char-serial.h"
> > > > >  =A0 #include "ui/console.h"
> > > > > -#include "ui/input.h"
> > > > >  =A0 #include "trace.h"
> > > > >  =A0 =A0 /*
> > > > > @@ -64,53 +61,7 @@
> > > > >  =A0=A0 *=A0 2010-May-23=A0 Artyom Tarasenko:=A0 Reworked IUS log=
ic
> > > > >  =A0=A0 */
> > > > >  =A0 -typedef enum {
> > > > > -=A0=A0=A0 chn_a, chn_b,
> > > > > -} ChnID;
> > > > > -
> > > > > -#define CHN_C(s) ((s)->chn =3D=3D chn_b? 'b' : 'a')
> > > > > -
> > > > > -typedef enum {
> > > > > -=A0=A0=A0 ser, kbd, mouse,
> > > > > -} ChnType;
> > > > > -
> > > > > -#define SERIO_QUEUE_SIZE 256
> > > > > -
> > > > > -typedef struct {
> > > > > -=A0=A0=A0 uint8_t data[SERIO_QUEUE_SIZE];
> > > > > -=A0=A0=A0 int rptr, wptr, count;
> > > > > -} SERIOQueue;
> > > > > -
> > > > > -#define SERIAL_REGS 16
> > > > > -typedef struct ChannelState {
> > > > > -=A0=A0=A0 qemu_irq irq;
> > > > > -=A0=A0=A0 uint32_t rxint, txint, rxint_under_svc, txint_under_sv=
c;
> > > > > -=A0=A0=A0 struct ChannelState *otherchn;
> > > > > -=A0=A0=A0 uint32_t reg;
> > > > > -=A0=A0=A0 uint8_t wregs[SERIAL_REGS], rregs[SERIAL_REGS];
> > > > > -=A0=A0=A0 SERIOQueue queue;
> > > > > -=A0=A0=A0 CharBackend chr;
> > > > > -=A0=A0=A0 int e0_mode, led_mode, caps_lock_mode, num_lock_mode;
> > > > > -=A0=A0=A0 int disabled;
> > > > > -=A0=A0=A0 int clock;
> > > > > -=A0=A0=A0 uint32_t vmstate_dummy;
> > > > > -=A0=A0=A0 ChnID chn; // this channel, A (base+4) or B (base+0)
> > > > > -=A0=A0=A0 ChnType type;
> > > > > -=A0=A0=A0 uint8_t rx, tx;
> > > > > -=A0=A0=A0 QemuInputHandlerState *hs;
> > > > > -} ChannelState;
> > > > > -
> > > > > -#define ESCC(obj) OBJECT_CHECK(ESCCState, (obj), TYPE_ESCC)
> > > > > -
> > > > > -typedef struct ESCCState {
> > > > > -=A0=A0=A0 SysBusDevice parent_obj;
> > > > > -
> > > > > -=A0=A0=A0 struct ChannelState chn[2];
> > > > > -=A0=A0=A0 uint32_t it_shift;
> > > > > -=A0=A0=A0 MemoryRegion mmio;
> > > > > -=A0=A0=A0 uint32_t disabled;
> > > > > -=A0=A0=A0 uint32_t frequency;
> > > > > -} ESCCState;
> > > > > +#define CHN_C(s) ((s)->chn =3D=3D escc_chn_b ? 'b' : 'a')
> > > > >  =A0 =A0 #define SERIAL_CTRL 0
> > > > >  =A0 #define SERIAL_DATA 1
> > > > > @@ -214,44 +165,47 @@ typedef struct ESCCState {
> > > > >  =A0 #define R_MISC1I 14
> > > > >  =A0 #define R_EXTINT 15
> > > > >  =A0 -static void handle_kbd_command(ChannelState *s, int val);
> > > > > +static void handle_kbd_command(ESCCChannelState *s, int val);
> > > > >  =A0 static int serial_can_receive(void *opaque);
> > > > > -static void serial_receive_byte(ChannelState *s, int ch);
> > > > > +static void serial_receive_byte(ESCCChannelState *s, int ch);
> > > > >  =A0 =A0 static void clear_queue(void *opaque)
> > > > >  =A0 {
> > > > > -=A0=A0=A0 ChannelState *s =3D opaque;
> > > > > -=A0=A0=A0 SERIOQueue *q =3D &s->queue;
> > > > > +=A0=A0=A0 ESCCChannelState *s =3D opaque;
> > > > > +=A0=A0=A0 ESCCSERIOQueue *q =3D &s->queue;
> > > > >  =A0=A0=A0=A0=A0 q->rptr =3D q->wptr =3D q->count =3D 0;
> > > > >  =A0 }
> > > > >  =A0 =A0 static void put_queue(void *opaque, int b)
> > > > >  =A0 {
> > > > > -=A0=A0=A0 ChannelState *s =3D opaque;
> > > > > -=A0=A0=A0 SERIOQueue *q =3D &s->queue;
> > > > > +=A0=A0=A0 ESCCChannelState *s =3D opaque;
> > > > > +=A0=A0=A0 ESCCSERIOQueue *q =3D &s->queue;
> > > > >  =A0 =A0=A0=A0=A0=A0 trace_escc_put_queue(CHN_C(s), b);
> > > > > -=A0=A0=A0 if (q->count >=3D SERIO_QUEUE_SIZE)
> > > > > +=A0=A0=A0 if (q->count >=3D ESCC_SERIO_QUEUE_SIZE) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > > > > +=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0 q->data[q->wptr] =3D b;
> > > > > -=A0=A0=A0 if (++q->wptr =3D=3D SERIO_QUEUE_SIZE)
> > > > > +=A0=A0=A0 if (++q->wptr =3D=3D ESCC_SERIO_QUEUE_SIZE) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 q->wptr =3D 0;
> > > > > +=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0 q->count++;
> > > > >  =A0=A0=A0=A0=A0 serial_receive_byte(s, 0);
> > > > >  =A0 }
> > > > >  =A0 =A0 static uint32_t get_queue(void *opaque)
> > > > >  =A0 {
> > > > > -=A0=A0=A0 ChannelState *s =3D opaque;
> > > > > -=A0=A0=A0 SERIOQueue *q =3D &s->queue;
> > > > > +=A0=A0=A0 ESCCChannelState *s =3D opaque;
> > > > > +=A0=A0=A0 ESCCSERIOQueue *q =3D &s->queue;
> > > > >  =A0=A0=A0=A0=A0 int val;
> > > > >  =A0 =A0=A0=A0=A0=A0 if (q->count =3D=3D 0) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > >  =A0=A0=A0=A0=A0 } else {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D q->data[q->rptr];
> > > > > -=A0=A0=A0=A0=A0=A0=A0 if (++q->rptr =3D=3D SERIO_QUEUE_SIZE)
> > > > > +=A0=A0=A0=A0=A0=A0=A0 if (++q->rptr =3D=3D ESCC_SERIO_QUEUE_SIZE=
) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 q->rptr =3D 0;
> > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 q->count--;
> > > > >  =A0=A0=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0 trace_escc_get_queue(CHN_C(s), val);
> > > > > @@ -260,7 +214,7 @@ static uint32_t get_queue(void *opaque)
> > > > >  =A0=A0=A0=A0=A0 return val;
> > > > >  =A0 }
> > > > >  =A0 -static int escc_update_irq_chn(ChannelState *s)
> > > > > +static int escc_update_irq_chn(ESCCChannelState *s)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 if ((((s->wregs[W_INTR] & INTR_TXINT) && (s->txi=
nt =3D=3D 1)) ||
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // tx ints enabled, pending
> > > > > @@ -274,7 +228,7 @@ static int escc_update_irq_chn(ChannelState *=
s)
> > > > >  =A0=A0=A0=A0=A0 return 0;
> > > > >  =A0 }
> > > > >  =A0 -static void escc_update_irq(ChannelState *s)
> > > > > +static void escc_update_irq(ESCCChannelState *s)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 int irq;
> > > > >  =A0 @@ -285,12 +239,12 @@ static void escc_update_irq(ChannelSta=
te *s)
> > > > >  =A0=A0=A0=A0=A0 qemu_set_irq(s->irq, irq);
> > > > >  =A0 }
> > > > >  =A0 -static void escc_reset_chn(ChannelState *s)
> > > > > +static void escc_reset_chn(ESCCChannelState *s)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 int i;
> > > > >  =A0 =A0=A0=A0=A0=A0 s->reg =3D 0;
> > > > > -=A0=A0=A0 for (i =3D 0; i < SERIAL_REGS; i++) {
> > > > > +=A0=A0=A0 for (i =3D 0; i < ESCC_SERIAL_REGS; i++) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 s->rregs[i] =3D 0;
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 s->wregs[i] =3D 0;
> > > > >  =A0=A0=A0=A0=A0 }
> > > > > @@ -322,13 +276,13 @@ static void escc_reset(DeviceState *d)
> > > > >  =A0=A0=A0=A0=A0 escc_reset_chn(&s->chn[1]);
> > > > >  =A0 }
> > > > >  =A0 -static inline void set_rxint(ChannelState *s)
> > > > > +static inline void set_rxint(ESCCChannelState *s)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 s->rxint =3D 1;
> > > > > -=A0=A0=A0 /* XXX: missing daisy chainnig: chn_b rx should have a=
 lower
> > > > > priority
> > > > > +=A0=A0=A0 /* XXX: missing daisy chainnig: escc_chn_b rx should h=
ave a lower
> > > > > priority
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0 than chn_a rx/tx/special_condition serv=
ice*/
> > > > >  =A0=A0=A0=A0=A0 s->rxint_under_svc =3D 1;
> > > > > -=A0=A0=A0 if (s->chn =3D=3D chn_a) {
> > > > > +=A0=A0=A0 if (s->chn =3D=3D escc_chn_a) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 s->rregs[R_INTR] |=3D INTR_RXINTA;
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (s->wregs[W_MINTR] & MINTR_STATUS=
HI)
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s->otherchn->rregs[R_IVE=
C] =3D IVEC_HIRXINTA;
> > > > > @@ -344,12 +298,12 @@ static inline void set_rxint(ChannelState *=
s)
> > > > >  =A0=A0=A0=A0=A0 escc_update_irq(s);
> > > > >  =A0 }
> > > > >  =A0 -static inline void set_txint(ChannelState *s)
> > > > > +static inline void set_txint(ESCCChannelState *s)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 s->txint =3D 1;
> > > > >  =A0=A0=A0=A0=A0 if (!s->rxint_under_svc) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 s->txint_under_svc =3D 1;
> > > > > -=A0=A0=A0=A0=A0=A0=A0 if (s->chn =3D=3D chn_a) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0 if (s->chn =3D=3D escc_chn_a) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (s->wregs[W_INTR] & I=
NTR_TXINT) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s->rregs[R_I=
NTR] |=3D INTR_TXINTA;
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > @@ -367,11 +321,11 @@ static inline void set_txint(ChannelState *=
s)
> > > > >  =A0=A0=A0=A0=A0 }
> > > > >  =A0 }
> > > > >  =A0 -static inline void clr_rxint(ChannelState *s)
> > > > > +static inline void clr_rxint(ESCCChannelState *s)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 s->rxint =3D 0;
> > > > >  =A0=A0=A0=A0=A0 s->rxint_under_svc =3D 0;
> > > > > -=A0=A0=A0 if (s->chn =3D=3D chn_a) {
> > > > > +=A0=A0=A0 if (s->chn =3D=3D escc_chn_a) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (s->wregs[W_MINTR] & MINTR_STATUS=
HI)
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s->otherchn->rregs[R_IVE=
C] =3D IVEC_HINOINT;
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 else
> > > > > @@ -389,11 +343,11 @@ static inline void clr_rxint(ChannelState *=
s)
> > > > >  =A0=A0=A0=A0=A0 escc_update_irq(s);
> > > > >  =A0 }
> > > > >  =A0 -static inline void clr_txint(ChannelState *s)
> > > > > +static inline void clr_txint(ESCCChannelState *s)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 s->txint =3D 0;
> > > > >  =A0=A0=A0=A0=A0 s->txint_under_svc =3D 0;
> > > > > -=A0=A0=A0 if (s->chn =3D=3D chn_a) {
> > > > > +=A0=A0=A0 if (s->chn =3D=3D escc_chn_a) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (s->wregs[W_MINTR] & MINTR_STATUS=
HI)
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s->otherchn->rregs[R_IVE=
C] =3D IVEC_HINOINT;
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 else
> > > > > @@ -412,12 +366,12 @@ static inline void clr_txint(ChannelState *=
s)
> > > > >  =A0=A0=A0=A0=A0 escc_update_irq(s);
> > > > >  =A0 }
> > > > >  =A0 -static void escc_update_parameters(ChannelState *s)
> > > > > +static void escc_update_parameters(ESCCChannelState *s)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 int speed, parity, data_bits, stop_bits;
> > > > >  =A0=A0=A0=A0=A0 QEMUSerialSetParams ssp;
> > > > >  =A0 -=A0=A0=A0 if (!qemu_chr_fe_backend_connected(&s->chr) || s-=
>type !=3D ser)
> > > > > +=A0=A0=A0 if (!qemu_chr_fe_backend_connected(&s->chr) || s->type=
 !=3D
> > > > > escc_serial)
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > > > >  =A0 =A0=A0=A0=A0=A0 if (s->wregs[W_TXCTRL1] & TXCTRL1_PAREN) {
> > > > > @@ -474,7 +428,7 @@ static void escc_mem_write(void *opaque, hwad=
dr addr,
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 uint64_t val, unsigned size)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 ESCCState *serial =3D opaque;
> > > > > -=A0=A0=A0 ChannelState *s;
> > > > > +=A0=A0=A0 ESCCChannelState *s;
> > > > >  =A0=A0=A0=A0=A0 uint32_t saddr;
> > > > >  =A0=A0=A0=A0=A0 int newreg, channel;
> > > > >  =A0 @@ -561,7 +515,7 @@ static void escc_mem_write(void *opaque,=
 hwaddr
> > > > > addr,
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* XXX this =
blocks entire thread. Rewrite to use
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * qemu_ch=
r_fe_write and background I/O callbacks */
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_chr_fe_=
write_all(&s->chr, &s->tx, 1);
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (s->type =3D=3D kbd =
&& !s->disabled) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (s->type =3D=3D escc=
_kbd && !s->disabled) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 handle_kbd_c=
ommand(s, val);
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > @@ -578,7 +532,7 @@ static uint64_t escc_mem_read(void *opaque, h=
waddr
> > > > > addr,
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned size)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 ESCCState *serial =3D opaque;
> > > > > -=A0=A0=A0 ChannelState *s;
> > > > > +=A0=A0=A0 ESCCChannelState *s;
> > > > >  =A0=A0=A0=A0=A0 uint32_t saddr;
> > > > >  =A0=A0=A0=A0=A0 uint32_t ret;
> > > > >  =A0=A0=A0=A0=A0 int channel;
> > > > > @@ -595,10 +549,11 @@ static uint64_t escc_mem_read(void *opaque,
> > > > > hwaddr addr,
> > > > >  =A0=A0=A0=A0=A0 case SERIAL_DATA:
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 s->rregs[R_STATUS] &=3D ~STATUS_RXAV;
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 clr_rxint(s);
> > > > > -=A0=A0=A0=A0=A0=A0=A0 if (s->type =3D=3D kbd || s->type =3D=3D m=
ouse)
> > > > > +=A0=A0=A0=A0=A0=A0=A0 if (s->type =3D=3D escc_kbd || s->type =3D=
=3D escc_mouse) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D get_queue(s);
> > > > > -=A0=A0=A0=A0=A0=A0=A0 else
> > > > > +=A0=A0=A0=A0=A0=A0=A0 } else {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D s->rx;
> > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 trace_escc_mem_readb_data(CHN_C(s), =
ret);
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_chr_fe_accept_input(&s->chr);
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > > @@ -620,7 +575,7 @@ static const MemoryRegionOps escc_mem_ops =3D=
 {
> > > > >  =A0 =A0 static int serial_can_receive(void *opaque)
> > > > >  =A0 {
> > > > > -=A0=A0=A0 ChannelState *s =3D opaque;
> > > > > +=A0=A0=A0 ESCCChannelState *s =3D opaque;
> > > > >  =A0=A0=A0=A0=A0 int ret;
> > > > >  =A0 =A0=A0=A0=A0=A0 if (((s->wregs[W_RXCTRL] & RXCTRL_RXEN) =3D=
=3D 0) // Rx not enabled
> > > > > @@ -632,7 +587,7 @@ static int serial_can_receive(void *opaque)
> > > > >  =A0=A0=A0=A0=A0 return ret;
> > > > >  =A0 }
> > > > >  =A0 -static void serial_receive_byte(ChannelState *s, int ch)
> > > > > +static void serial_receive_byte(ESCCChannelState *s, int ch)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 trace_escc_serial_receive_byte(CHN_C(s), ch);
> > > > >  =A0=A0=A0=A0=A0 s->rregs[R_STATUS] |=3D STATUS_RXAV;
> > > > > @@ -640,7 +595,7 @@ static void serial_receive_byte(ChannelState =
*s,
> > > > > int ch)
> > > > >  =A0=A0=A0=A0=A0 set_rxint(s);
> > > > >  =A0 }
> > > > >  =A0 -static void serial_receive_break(ChannelState *s)
> > > > > +static void serial_receive_break(ESCCChannelState *s)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 s->rregs[R_STATUS] |=3D STATUS_BRK;
> > > > >  =A0=A0=A0=A0=A0 escc_update_irq(s);
> > > > > @@ -648,13 +603,13 @@ static void serial_receive_break(ChannelSta=
te *s)
> > > > >  =A0 =A0 static void serial_receive1(void *opaque, const uint8_t =
*buf, int
> > > > > size)
> > > > >  =A0 {
> > > > > -=A0=A0=A0 ChannelState *s =3D opaque;
> > > > > +=A0=A0=A0 ESCCChannelState *s =3D opaque;
> > > > >  =A0=A0=A0=A0=A0 serial_receive_byte(s, buf[0]);
> > > > >  =A0 }
> > > > >  =A0 =A0 static void serial_event(void *opaque, int event)
> > > > >  =A0 {
> > > > > -=A0=A0=A0 ChannelState *s =3D opaque;
> > > > > +=A0=A0=A0 ESCCChannelState *s =3D opaque;
> > > > >  =A0=A0=A0=A0=A0 if (event =3D=3D CHR_EVENT_BREAK)
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 serial_receive_break(s);
> > > > >  =A0 }
> > > > > @@ -664,16 +619,16 @@ static const VMStateDescription vmstate_esc=
c_chn
> > > > > =3D {
> > > > >  =A0=A0=A0=A0=A0 .version_id =3D 2,
> > > > >  =A0=A0=A0=A0=A0 .minimum_version_id =3D 1,
> > > > >  =A0=A0=A0=A0=A0 .fields =3D (VMStateField[]) {
> > > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(vmstate_dummy, ChannelState=
),
> > > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(reg, ChannelState),
> > > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(rxint, ChannelState),
> > > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(txint, ChannelState),
> > > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(rxint_under_svc, ChannelSta=
te),
> > > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(txint_under_svc, ChannelSta=
te),
> > > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(rx, ChannelState),
> > > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(tx, ChannelState),
> > > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_BUFFER(wregs, ChannelState),
> > > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_BUFFER(rregs, ChannelState),
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(vmstate_dummy, ESCCChannelS=
tate),
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(reg, ESCCChannelState),
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(rxint, ESCCChannelState),
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(txint, ESCCChannelState),
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(rxint_under_svc, ESCCChanne=
lState),
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(txint_under_svc, ESCCChanne=
lState),
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(rx, ESCCChannelState),
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(tx, ESCCChannelState),
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_BUFFER(wregs, ESCCChannelState),
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_BUFFER(rregs, ESCCChannelState),
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 VMSTATE_END_OF_LIST()
> > > > >  =A0=A0=A0=A0=A0 }
> > > > >  =A0 };
> > > > > @@ -684,39 +639,11 @@ static const VMStateDescription vmstate_esc=
c =3D {
> > > > >  =A0=A0=A0=A0=A0 .minimum_version_id =3D 1,
> > > > >  =A0=A0=A0=A0=A0 .fields =3D (VMStateField[]) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 VMSTATE_STRUCT_ARRAY(chn, ESCCState,=
 2, 2, vmstate_escc_chn,
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 ChannelState),
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 ESCCChannelState),
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 VMSTATE_END_OF_LIST()
> > > > >  =A0=A0=A0=A0=A0 }
> > > > >  =A0 };
> > > > >  =A0 -MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_ir=
q irqB,
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Chardev *chrA, Chardev *=
chrB,
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int clock, int it_shift)
> > > > > -{
> > > > > -=A0=A0=A0 DeviceState *dev;
> > > > > -=A0=A0=A0 SysBusDevice *s;
> > > > > -=A0=A0=A0 ESCCState *d;
> > > > > -
> > > > > -=A0=A0=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
> > > > > -=A0=A0=A0 qdev_prop_set_uint32(dev, "disabled", 0);
> > > > > -=A0=A0=A0 qdev_prop_set_uint32(dev, "frequency", clock);
> > > > > -=A0=A0=A0 qdev_prop_set_uint32(dev, "it_shift", it_shift);
> > > > > -=A0=A0=A0 qdev_prop_set_chr(dev, "chrB", chrB);
> > > > > -=A0=A0=A0 qdev_prop_set_chr(dev, "chrA", chrA);
> > > > > -=A0=A0=A0 qdev_prop_set_uint32(dev, "chnBtype", ser);
> > > > > -=A0=A0=A0 qdev_prop_set_uint32(dev, "chnAtype", ser);
> > > > > -=A0=A0=A0 qdev_init_nofail(dev);
> > > > > -=A0=A0=A0 s =3D SYS_BUS_DEVICE(dev);
> > > > > -=A0=A0=A0 sysbus_connect_irq(s, 0, irqB);
> > > > > -=A0=A0=A0 sysbus_connect_irq(s, 1, irqA);
> > > > > -=A0=A0=A0 if (base) {
> > > > > -=A0=A0=A0=A0=A0=A0=A0 sysbus_mmio_map(s, 0, base);
> > > > > -=A0=A0=A0 }
> > > > > -
> > > > > -=A0=A0=A0 d =3D ESCC(s);
> > > > > -=A0=A0=A0 return &d->mmio;
> > > > > -}
> > > > > -
> > > > >  =A0 static const uint8_t qcode_to_keycode[Q_KEY_CODE__MAX] =3D {
> > > > >  =A0=A0=A0=A0=A0 [Q_KEY_CODE_SHIFT]=A0=A0=A0=A0=A0=A0=A0=A0 =3D 9=
9,
> > > > >  =A0=A0=A0=A0=A0 [Q_KEY_CODE_SHIFT_R]=A0=A0=A0=A0=A0=A0 =3D 110,
> > > > > @@ -841,7 +768,7 @@ static const uint8_t
> > > > > qcode_to_keycode[Q_KEY_CODE__MAX] =3D {
> > > > >  =A0 static void sunkbd_handle_event(DeviceState *dev, QemuConsol=
e *src,
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 InputEvent *evt)
> > > > >  =A0 {
> > > > > -=A0=A0=A0 ChannelState *s =3D (ChannelState *)dev;
> > > > > +=A0=A0=A0 ESCCChannelState *s =3D (ESCCChannelState *)dev;
> > > > >  =A0=A0=A0=A0=A0 int qcode, keycode;
> > > > >  =A0=A0=A0=A0=A0 InputKeyEvent *key;
> > > > >  =A0 @@ -893,7 +820,7 @@ static QemuInputHandler sunkbd_handler =
=3D {
> > > > >  =A0=A0=A0=A0=A0 .event =3D sunkbd_handle_event,
> > > > >  =A0 };
> > > > >  =A0 -static void handle_kbd_command(ChannelState *s, int val)
> > > > > +static void handle_kbd_command(ESCCChannelState *s, int val)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 trace_escc_kbd_command(val);
> > > > >  =A0=A0=A0=A0=A0 if (s->led_mode) { // Ignore led byte
> > > > > @@ -924,7 +851,7 @@ static void handle_kbd_command(ChannelState *=
s,
> > > > > int val)
> > > > >  =A0 static void sunmouse_event(void *opaque,
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int dx, int dy, int dz, int
> > > > > buttons_state)
> > > > >  =A0 {
> > > > > -=A0=A0=A0 ChannelState *s =3D opaque;
> > > > > +=A0=A0=A0 ESCCChannelState *s =3D opaque;
> > > > >  =A0=A0=A0=A0=A0 int ch;
> > > > >  =A0 =A0=A0=A0=A0=A0 trace_escc_sunmouse_event(dx, dy, buttons_st=
ate);
> > > > > @@ -963,27 +890,6 @@ static void sunmouse_event(void *opaque,
> > > > >  =A0=A0=A0=A0=A0 put_queue(s, 0);
> > > > >  =A0 }
> > > > >  =A0 -void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 int disabled, int clock, int it_shift)
> > > > > -{
> > > > > -=A0=A0=A0 DeviceState *dev;
> > > > > -=A0=A0=A0 SysBusDevice *s;
> > > > > -
> > > > > -=A0=A0=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
> > > > > -=A0=A0=A0 qdev_prop_set_uint32(dev, "disabled", disabled);
> > > > > -=A0=A0=A0 qdev_prop_set_uint32(dev, "frequency", clock);
> > > > > -=A0=A0=A0 qdev_prop_set_uint32(dev, "it_shift", it_shift);
> > > > > -=A0=A0=A0 qdev_prop_set_chr(dev, "chrB", NULL);
> > > > > -=A0=A0=A0 qdev_prop_set_chr(dev, "chrA", NULL);
> > > > > -=A0=A0=A0 qdev_prop_set_uint32(dev, "chnBtype", mouse);
> > > > > -=A0=A0=A0 qdev_prop_set_uint32(dev, "chnAtype", kbd);
> > > > > -=A0=A0=A0 qdev_init_nofail(dev);
> > > > > -=A0=A0=A0 s =3D SYS_BUS_DEVICE(dev);
> > > > > -=A0=A0=A0 sysbus_connect_irq(s, 0, irq);
> > > > > -=A0=A0=A0 sysbus_connect_irq(s, 1, irq);
> > > > > -=A0=A0=A0 sysbus_mmio_map(s, 0, base);
> > > > > -}
> > > > > -
> > > > >  =A0 static void escc_init1(Object *obj)
> > > > >  =A0 {
> > > > >  =A0=A0=A0=A0=A0 ESCCState *s =3D ESCC(obj);
> > > > > @@ -1020,11 +926,11 @@ static void escc_realize(DeviceState *dev,
> > > > > Error **errp)
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0 }
> > > > >  =A0 -=A0=A0=A0 if (s->chn[0].type =3D=3D mouse) {
> > > > > +=A0=A0=A0 if (s->chn[0].type =3D=3D escc_mouse) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_add_mouse_event_handler(sunmous=
e_event, &s->chn[0], 0,
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "QEMU Sun Mouse");
> > > > >  =A0=A0=A0=A0=A0 }
> > > > > -=A0=A0=A0 if (s->chn[1].type =3D=3D kbd) {
> > > > > +=A0=A0=A0 if (s->chn[1].type =3D=3D escc_kbd) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 s->chn[1].hs =3D qemu_input_handler_=
register((DeviceState
> > > > > *)(&s->chn[1]),
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &sunkbd_handler);
> > > > >  =A0=A0=A0=A0=A0 }
> > > > > diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> > > > > index 3fa7c429d5..de061ae76f 100644
> > > > > --- a/hw/ppc/mac_newworld.c
> > > > > +++ b/hw/ppc/mac_newworld.c
> > > > > @@ -369,8 +369,23 @@ static void ppc_core99_init(MachineState *ma=
chine)
> > > > >  =A0=A0=A0=A0=A0 }
> > > > >  =A0 =A0=A0=A0=A0=A0 /* init basic PC hardware */
> > > > > -=A0=A0=A0 escc_mem =3D escc_init(0, pic[0x25], pic[0x24],
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 serial_hds[0], serial_hds[1], ESCC_CLOCK, 4);
> > > > > +
> > > > > +=A0=A0=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "disabled", 0);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "it_shift", 4);
> > > > > +=A0=A0=A0 qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
> > > > > +=A0=A0=A0 qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
> > > > > +=A0=A0=A0 qdev_init_nofail(dev);
> > > > > +
> > > > > +=A0=A0=A0 s =3D SYS_BUS_DEVICE(dev);
> > > > > +=A0=A0=A0 sysbus_connect_irq(s, 0, pic[0x24]);
> > > > > +=A0=A0=A0 sysbus_connect_irq(s, 1, pic[0x25]);
> > > > > +
> > > > > +=A0=A0=A0 escc_mem =3D &ESCC(s)->mmio;
> > > > > +
> > > > >  =A0=A0=A0=A0=A0 memory_region_init_alias(escc_bar, NULL, "escc-b=
ar",
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 escc_mem, 0,
> > > > > memory_region_size(escc_mem));
> > > > >  =A0 diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> > > > > index 010ea36bf2..da0106b09d 100644
> > > > > --- a/hw/ppc/mac_oldworld.c
> > > > > +++ b/hw/ppc/mac_oldworld.c
> > > > > @@ -104,6 +104,7 @@ static void ppc_heathrow_init(MachineState *m=
achine)
> > > > >  =A0=A0=A0=A0=A0 DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> > > > >  =A0=A0=A0=A0=A0 void *fw_cfg;
> > > > >  =A0=A0=A0=A0=A0 uint64_t tbfreq;
> > > > > +=A0=A0=A0 SysBusDevice *s;
> > > > >  =A0 =A0=A0=A0=A0=A0 linux_boot =3D (kernel_filename !=3D NULL);
> > > > >  =A0 @@ -264,8 +265,22 @@ static void ppc_heathrow_init(MachineSt=
ate
> > > > > *machine)
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 get_system_io());
> > > > >  =A0=A0=A0=A0=A0 pci_vga_init(pci_bus);
> > > > >  =A0 -=A0=A0=A0 escc_mem =3D escc_init(0, pic[0x0f], pic[0x10], s=
erial_hds[0],
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 serial_hds[1], ESCC_CLOCK, 4);
> > > > > +=A0=A0=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "disabled", 0);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "it_shift", 4);
> > > > > +=A0=A0=A0 qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
> > > > > +=A0=A0=A0 qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
> > > > > +=A0=A0=A0 qdev_init_nofail(dev);
> > > > > +
> > > > > +=A0=A0=A0 s =3D SYS_BUS_DEVICE(dev);
> > > > > +=A0=A0=A0 sysbus_connect_irq(s, 0, pic[0x10]);
> > > > > +=A0=A0=A0 sysbus_connect_irq(s, 1, pic[0x0f]);
> > > > > +
> > > > > +=A0=A0=A0 escc_mem =3D &ESCC(s)->mmio;
> > > > > +
> > > > >  =A0=A0=A0=A0=A0 memory_region_init_alias(escc_bar, NULL, "escc-b=
ar",
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 escc_mem, 0,
> > > > > memory_region_size(escc_mem));
> > > > >  =A0 diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> > > > > index dd0038095b..0b3911cd65 100644
> > > > > --- a/hw/sparc/sun4m.c
> > > > > +++ b/hw/sparc/sun4m.c
> > > > > @@ -820,6 +820,8 @@ static void sun4m_hw_init(const struct sun4m_=
hwdef
> > > > > *hwdef,
> > > > >  =A0=A0=A0=A0=A0 DriveInfo *fd[MAX_FD];
> > > > >  =A0=A0=A0=A0=A0 FWCfgState *fw_cfg;
> > > > >  =A0=A0=A0=A0=A0 unsigned int num_vsimms;
> > > > > +=A0=A0=A0 DeviceState *dev;
> > > > > +=A0=A0=A0 SysBusDevice *s;
> > > > >  =A0 =A0=A0=A0=A0=A0 /* init CPUs */
> > > > >  =A0=A0=A0=A0=A0 for(i =3D 0; i < smp_cpus; i++) {
> > > > > @@ -927,12 +929,36 @@ static void sun4m_hw_init(const struct
> > > > > sun4m_hwdef *hwdef,
> > > > >  =A0 =A0=A0=A0=A0=A0 slavio_timer_init_all(hwdef->counter_base, s=
lavio_irq[19],
> > > > > slavio_cpu_irq, smp_cpus);
> > > > >  =A0 -=A0=A0=A0 slavio_serial_ms_kbd_init(hwdef->ms_kb_base, slav=
io_irq[14],
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 !machine->enable_graphics, ESCC_CLOCK, 1);
> > > > >  =A0=A0=A0=A0=A0 /* Slavio TTYA (base+4, Linux ttyS0) is the firs=
t QEMU serial
> > > > > device
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0 Slavio TTYB (base+0, Linux ttyS1) is th=
e second QEMU serial
> > > > > device */
> > > > > -=A0=A0=A0 escc_init(hwdef->serial_base, slavio_irq[15], slavio_i=
rq[15],
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serial_hds[0], serial_hd=
s[1], ESCC_CLOCK, 1);
> > > > > +=A0=A0=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "disabled", !machine->enable=
_graphics);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "it_shift", 1);
> > > > > +=A0=A0=A0 qdev_prop_set_chr(dev, "chrB", NULL);
> > > > > +=A0=A0=A0 qdev_prop_set_chr(dev, "chrA", NULL);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "chnBtype", escc_mouse);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "chnAtype", escc_kbd);
> > > > > +=A0=A0=A0 qdev_init_nofail(dev);
> > > > > +=A0=A0=A0 s =3D SYS_BUS_DEVICE(dev);
> > > > > +=A0=A0=A0 sysbus_connect_irq(s, 0, slavio_irq[14]);
> > > > > +=A0=A0=A0 sysbus_connect_irq(s, 1, slavio_irq[14]);
> > > > > +=A0=A0=A0 sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
> > > > > +
> > > > > +=A0=A0=A0 dev =3D qdev_create(NULL, TYPE_ESCC);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "disabled", 0);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "it_shift", 1);
> > > > > +=A0=A0=A0 qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
> > > > > +=A0=A0=A0 qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
> > > > > +=A0=A0=A0 qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
> > > > > +=A0=A0=A0 qdev_init_nofail(dev);
> > > > > +
> > > > > +=A0=A0=A0 s =3D SYS_BUS_DEVICE(dev);
> > > > > +=A0=A0=A0 sysbus_connect_irq(s, 0, slavio_irq[15]);
> > > > > +=A0=A0=A0 sysbus_connect_irq(s, 1,=A0 slavio_irq[15]);
> > > > > +=A0=A0=A0 sysbus_mmio_map(s, 0, hwdef->serial_base);
> > > > >  =A0 =A0=A0=A0=A0=A0 if (hwdef->apc_base) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 apc_init(hwdef->apc_base, qemu_alloc=
ate_irq(cpu_halt_signal,
> > > > > NULL, 0));
> > > > > diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
> > > > > index 08ae122386..42aca83611 100644
> > > > > --- a/include/hw/char/escc.h
> > > > > +++ b/include/hw/char/escc.h
> > > > > @@ -1,14 +1,58 @@
> > > > >  =A0 #ifndef HW_ESCC_H
> > > > >  =A0 #define HW_ESCC_H
> > > > >  =A0 +#include "chardev/char-fe.h"
> > > > > +#include "chardev/char-serial.h"
> > > > > +#include "ui/input.h"
> > > > > +
> > > > >  =A0 /* escc.c */
> > > > >  =A0 #define TYPE_ESCC "escc"
> > > > >  =A0 #define ESCC_SIZE 4
> > > > > -MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irq=
B,
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Chardev *chrA, Chardev *=
chrB,
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int clock, int it_shift);
> > > > >  =A0 -void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 int disabled, int clock, int it_shift);
> > > > > +#define ESCC(obj) OBJECT_CHECK(ESCCState, (obj), TYPE_ESCC)
> > > > > +
> > > > > +typedef enum {
> > > > > +=A0=A0=A0 escc_chn_a, escc_chn_b,
> > > > > +} ESCCChnID;
> > > > > +
> > > > > +typedef enum {
> > > > > +=A0=A0=A0 escc_serial, escc_kbd, escc_mouse,
> > > > > +} ESCCChnType;
> > > > > +
> > > > > +#define ESCC_SERIO_QUEUE_SIZE 256
> > > > > +
> > > > > +typedef struct {
> > > > > +=A0=A0=A0 uint8_t data[ESCC_SERIO_QUEUE_SIZE];
> > > > > +=A0=A0=A0 int rptr, wptr, count;
> > > > > +} ESCCSERIOQueue;
> > > > > +
> > > > > +#define ESCC_SERIAL_REGS 16
> > > > > +typedef struct ESCCChannelState {
> > > > > +=A0=A0=A0 qemu_irq irq;
> > > > > +=A0=A0=A0 uint32_t rxint, txint, rxint_under_svc, txint_under_sv=
c;
> > > > > +=A0=A0=A0 struct ESCCChannelState *otherchn;
> > > > > +=A0=A0=A0 uint32_t reg;
> > > > > +=A0=A0=A0 uint8_t wregs[ESCC_SERIAL_REGS], rregs[ESCC_SERIAL_REG=
S];
> > > > > +=A0=A0=A0 ESCCSERIOQueue queue;
> > > > > +=A0=A0=A0 CharBackend chr;
> > > > > +=A0=A0=A0 int e0_mode, led_mode, caps_lock_mode, num_lock_mode;
> > > > > +=A0=A0=A0 int disabled;
> > > > > +=A0=A0=A0 int clock;
> > > > > +=A0=A0=A0 uint32_t vmstate_dummy;
> > > > > +=A0=A0=A0 ESCCChnID chn; /* this channel, A (base+4) or B (base+=
0) */
> > > > > +=A0=A0=A0 ESCCChnType type;
> > > > > +=A0=A0=A0 uint8_t rx, tx;
> > > > > +=A0=A0=A0 QemuInputHandlerState *hs;
> > > > > +} ESCCChannelState;
> > > > > +
> > > > > +typedef struct ESCCState {
> > > > > +=A0=A0=A0 SysBusDevice parent_obj;
> > > > > +
> > > > > +=A0=A0=A0 struct ESCCChannelState chn[2];
> > > > > +=A0=A0=A0 uint32_t it_shift;
> > > > > +=A0=A0=A0 MemoryRegion mmio;
> > > > > +=A0=A0=A0 uint32_t disabled;
> > > > > +=A0=A0=A0 uint32_t frequency;
> > > > > +} ESCCState;
> > > > >  =A0 =A0 #endif
> > > >=20
> > > > Looks good to me. Note to self: I wonder how easy it would be to sp=
lit
> > > > the sun keyboard/mouse out from here too.
> > > >=20
> > > > Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> I don't have any upcoming branches ready for merge quite yet, but I think
> that it would be good to get this in sooner rather than later.
>=20
> David, would you be willing to take this via ppc-for-2.12 since it covers
> the ESCC used in the PPC Mac machines?

Short term: Yes, I can stage this.  I've lost track of this thread
though.  Laurent, can you please resend with the various R-bs collated
together.

Long term: I've been thinking for a while that I'm not greatly
qualified to review or test patches for the Macintosh platforms.  And
I've also been thinking for a while that you (Mark) seem the obvious
choice to be sub-maintainer for the ppc based Macintosh machine types
and related device models.  Would you be willing to take that on? =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqDwfcACgkQbDjKyiDZ
s5K3MRAAh3+tGbKAKvq5XwtUgQGcDiL9yESgDJIljKeDOQ2BOtebAbPoDMRyBqv9
jXrT9IrxU/qzq/rG0Olkttqw6K1RH22TQfIshk8ggiePAinqmsFxQ/7poBYZBiVV
IeGUQAcOBoKyma8/K6N6+oxsZccthvZx22dTiOqm5xqkubMS9qcACfbFg4kzKkcA
cZoXqXq56dy9outnBBRc3RxLA1k3uVw0npedHXPpwnkHjf3FFFVgRO9PwgfD7fLx
MifEVOfe4/O8oUJtxMJRAfqWSY6JXZ4OaC2NhoMWA7K7f3ZMfqAeRPPAyAC3hEjt
se0Ck+1ElTh+O1E6CTHeO2lakoTW7p6w+VSxoN2qt3kOeEYuJ6QDGJ+X0fd+JMF+
DzTBJPhRxveejXuEPSM7TM1eiAD4+ivfORfNKKpHyZVAS2QW3ji6/V8leTdvzZO6
e4N0X1ZfcEqgzV7fP+FNQHrGx5fSwUTc+VkSn1J7XWURPXX9ifeIgyU0gLwGUwzy
uT76qf4N8oCei+nsjxgvKJBno4zhrLY+kwxJedgeliFoicL2092P+oJfHtALF4J/
xN4JzRCoVNFax7lpATjzRHlSR0hGWUFx0uI/llD2NrnLdEnUyz+hMx4KuKlg6bUp
GDd1WCJys58OUNlhJgUaaSMbejapGRWynA2+gLmyKT3rdahCPC0=
=lK81
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
