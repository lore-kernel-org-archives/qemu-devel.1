Received: from eggs.gnu.org ([2001:4830:134:3::10]:38806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el908-0006fM-BJ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el904-0001o1-MQ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:58:12 -0500
Date: Mon, 12 Feb 2018 18:49:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180212074930.GF11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-11-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eDyw1yV8HuEtd7LH"
Content-Disposition: inline
In-Reply-To: <20180209185142.17151-11-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 10/12] cuda: convert to use the shared
 mos6522 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com


--eDyw1yV8HuEtd7LH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:51:40PM +0000, Mark Cave-Ayland wrote:
> Add the relevant hooks as required for the MacOS timer calibration and de=
layed
> SR interrupt.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/misc/macio/cuda.c | 606 ++++++++++++++-------------------------------=
------
>  hw/ppc/mac.h         |  87 ++++----
>  2 files changed, 204 insertions(+), 489 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index a185252144..54c02aeffb 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -26,15 +26,14 @@
>  #include "hw/hw.h"
>  #include "hw/ppc/mac.h"
>  #include "hw/input/adb.h"
> +#include "hw/misc/mos6522.h"
>  #include "qemu/timer.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
> =20
> -/* XXX: implement all timer modes */
> -
> -/* debug CUDA */
> -//#define DEBUG_CUDA
> +/* debug CUDA packets */
> +//#define DEBUG_CUDA_PACKET
> =20
>  /* debug CUDA packets */
>  //#define DEBUG_CUDA_PACKET
> @@ -47,426 +46,114 @@
>  #endif
> =20
>  /* Bits in B data register: all active low */
> -#define TREQ		0x08		/* Transfer request (input) */
> -#define TACK		0x10		/* Transfer acknowledge (output) */
> -#define TIP		0x20		/* Transfer in progress (output) */
> -
> -/* Bits in ACR */
> -#define SR_CTRL		0x1c		/* Shift register control bits */
> -#define SR_EXT		0x0c		/* Shift on external clock */
> -#define SR_OUT		0x10		/* Shift out if 1 */
> -
> -/* Bits in IFR and IER */
> -#define IER_SET		0x80		/* set bits in IER */
> -#define IER_CLR		0		/* clear bits in IER */
> -#define SR_INT		0x04		/* Shift register full/empty */
> -#define SR_DATA_INT	0x08
> -#define SR_CLOCK_INT	0x10
> -#define T1_INT          0x40            /* Timer 1 interrupt */
> -#define T2_INT          0x20            /* Timer 2 interrupt */
> -
> -/* Bits in ACR */
> -#define T1MODE          0xc0            /* Timer 1 mode */
> -#define T1MODE_CONT     0x40            /*  continuous interrupts */
> +#define TREQ            0x08    /* Transfer request (input) */
> +#define TACK            0x10    /* Transfer acknowledge (output) */
> +#define TIP             0x20    /* Transfer in progress (output) */
> =20
>  /* commands (1st byte) */
> -#define ADB_PACKET	0
> -#define CUDA_PACKET	1
> -#define ERROR_PACKET	2
> -#define TIMER_PACKET	3
> -#define POWER_PACKET	4
> -#define MACIIC_PACKET	5
> -#define PMU_PACKET	6
> -
> -
> -/* CUDA commands (2nd byte) */
> -#define CUDA_WARM_START			0x0
> -#define CUDA_AUTOPOLL			0x1
> -#define CUDA_GET_6805_ADDR		0x2
> -#define CUDA_GET_TIME			0x3
> -#define CUDA_GET_PRAM			0x7
> -#define CUDA_SET_6805_ADDR		0x8
> -#define CUDA_SET_TIME			0x9
> -#define CUDA_POWERDOWN			0xa
> -#define CUDA_POWERUP_TIME		0xb
> -#define CUDA_SET_PRAM			0xc
> -#define CUDA_MS_RESET			0xd
> -#define CUDA_SEND_DFAC			0xe
> -#define CUDA_BATTERY_SWAP_SENSE		0x10
> -#define CUDA_RESET_SYSTEM		0x11
> -#define CUDA_SET_IPL			0x12
> -#define CUDA_FILE_SERVER_FLAG		0x13
> -#define CUDA_SET_AUTO_RATE		0x14
> -#define CUDA_GET_AUTO_RATE		0x16
> -#define CUDA_SET_DEVICE_LIST		0x19
> -#define CUDA_GET_DEVICE_LIST		0x1a
> -#define CUDA_SET_ONE_SECOND_MODE	0x1b
> -#define CUDA_SET_POWER_MESSAGES		0x21
> -#define CUDA_GET_SET_IIC		0x22
> -#define CUDA_WAKEUP			0x23
> -#define CUDA_TIMER_TICKLE		0x24
> -#define CUDA_COMBINED_FORMAT_IIC	0x25
> +#define ADB_PACKET      0
> +#define CUDA_PACKET     1
> +#define ERROR_PACKET    2
> +#define TIMER_PACKET    3
> +#define POWER_PACKET    4
> +#define MACIIC_PACKET   5
> +#define PMU_PACKET      6
> =20
>  #define CUDA_TIMER_FREQ (4700000 / 6)
> =20
>  /* CUDA returns time_t's offset from Jan 1, 1904, not 1970 */
>  #define RTC_OFFSET                      2082844800
> =20
> -/* CUDA registers */
> -#define CUDA_REG_B       0x00
> -#define CUDA_REG_A       0x01
> -#define CUDA_REG_DIRB    0x02
> -#define CUDA_REG_DIRA    0x03
> -#define CUDA_REG_T1CL    0x04
> -#define CUDA_REG_T1CH    0x05
> -#define CUDA_REG_T1LL    0x06
> -#define CUDA_REG_T1LH    0x07
> -#define CUDA_REG_T2CL    0x08
> -#define CUDA_REG_T2CH    0x09
> -#define CUDA_REG_SR      0x0a
> -#define CUDA_REG_ACR     0x0b
> -#define CUDA_REG_PCR     0x0c
> -#define CUDA_REG_IFR     0x0d
> -#define CUDA_REG_IER     0x0e
> -#define CUDA_REG_ANH     0x0f
> -
> -static void cuda_update(CUDAState *s);
>  static void cuda_receive_packet_from_host(CUDAState *s,
>                                            const uint8_t *data, int len);
> -static void cuda_timer_update(CUDAState *s, CUDATimer *ti,
> -                              int64_t current_time);
> =20
> -static void cuda_update_irq(CUDAState *s)
> -{
> -    if (s->ifr & s->ier & (SR_INT | T1_INT | T2_INT)) {
> -        qemu_irq_raise(s->irq);
> -    } else {
> -        qemu_irq_lower(s->irq);
> -    }
> -}
> +/* MacOS uses timer 1 for calibration on startup, so we use
> + * the timebase frequency and cuda_get_counter_value() with
> + * cuda_get_load_time() to steer MacOS to calculate calibrate its timers
> + * correctly for both TCG and KVM (see commit b981289c49 "PPC: Cuda: Use=
 cuda
> + * timer to expose tbfreq to guest" for more information) */
> =20
> -static uint64_t get_counter_value(CUDAState *s, CUDATimer *ti)
> +static uint64_t cuda_get_counter_value(MOS6522State *s, MOS6522Timer *ti)
>  {
> +    MOS6522CUDAState *mcs =3D container_of(s, MOS6522CUDAState, parent_o=
bj);
> +    CUDAState *cs =3D mcs->cuda;
> +
>      /* Reverse of the tb calculation algorithm that Mac OS X uses on boo=
tup */
>      uint64_t tb_diff =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                                s->tb_frequency, NANOSECONDS_PER_SECOND)=
 -
> +                                cs->tb_frequency, NANOSECONDS_PER_SECOND=
) -
>                             ti->load_time;
> =20
> -    return (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
> +    return (tb_diff * 0xBF401675E5DULL) / (cs->tb_frequency << 24);
>  }
> =20
> -static uint64_t get_counter_load_time(CUDAState *s, CUDATimer *ti)
> +static uint64_t cuda_get_load_time(MOS6522State *s, MOS6522Timer *ti)
>  {
> +    MOS6522CUDAState *mcs =3D container_of(s, MOS6522CUDAState, parent_o=
bj);
> +    CUDAState *cs =3D mcs->cuda;
> +
>      uint64_t load_time =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
),
> -                                  s->tb_frequency, NANOSECONDS_PER_SECON=
D);
> +                                  cs->tb_frequency, NANOSECONDS_PER_SECO=
ND);
>      return load_time;
>  }
> =20
> -static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
> -{
> -    int64_t d;
> -    unsigned int counter;
> -
> -    d =3D get_counter_value(s, ti);
> -
> -    if (ti->index =3D=3D 0) {
> -        /* the timer goes down from latch to -1 (period of latch + 2) */
> -        if (d <=3D (ti->counter_value + 1)) {
> -            counter =3D (ti->counter_value - d) & 0xffff;
> -        } else {
> -            counter =3D (d - (ti->counter_value + 1)) % (ti->latch + 2);
> -            counter =3D (ti->latch - counter) & 0xffff;
> -        }
> -    } else {
> -        counter =3D (ti->counter_value - d) & 0xffff;
> -    }
> -    return counter;
> -}
> -
> -static void set_counter(CUDAState *s, CUDATimer *ti, unsigned int val)
> -{
> -    CUDA_DPRINTF("T%d.counter=3D%d\n", 1 + ti->index, val);
> -    ti->load_time =3D get_counter_load_time(s, ti);
> -    ti->counter_value =3D val;
> -    cuda_timer_update(s, ti, ti->load_time);
> -}
> -
> -static int64_t get_next_irq_time(CUDATimer *ti, int64_t current_time)
> -{
> -    int64_t d, next_time;
> -    unsigned int counter;
> -
> -    /* current counter value */
> -    d =3D muldiv64(current_time - ti->load_time,
> -                 ti->frequency, NANOSECONDS_PER_SECOND);
> -    /* the timer goes down from latch to -1 (period of latch + 2) */
> -    if (d <=3D (ti->counter_value + 1)) {
> -        counter =3D (ti->counter_value - d) & 0xffff;
> -    } else {
> -        counter =3D (d - (ti->counter_value + 1)) % (ti->latch + 2);
> -        counter =3D (ti->latch - counter) & 0xffff;
> -    }
> -
> -    /* Note: we consider the irq is raised on 0 */
> -    if (counter =3D=3D 0xffff) {
> -        next_time =3D d + ti->latch + 1;
> -    } else if (counter =3D=3D 0) {
> -        next_time =3D d + ti->latch + 2;
> -    } else {
> -        next_time =3D d + counter;
> -    }
> -    CUDA_DPRINTF("latch=3D%d counter=3D%" PRId64 " delta_next=3D%" PRId6=
4 "\n",
> -                 ti->latch, d, next_time - d);
> -    next_time =3D muldiv64(next_time, NANOSECONDS_PER_SECOND, ti->freque=
ncy) +
> -                         ti->load_time;
> -    if (next_time <=3D current_time) {
> -        next_time =3D current_time + 1;
> -    }
> -    return next_time;
> -}
> -
> -static void cuda_timer_update(CUDAState *s, CUDATimer *ti,
> -                              int64_t current_time)
> -{
> -    if (!ti->timer)
> -        return;
> -    if (ti->index =3D=3D 0 && (s->acr & T1MODE) !=3D T1MODE_CONT) {
> -        timer_del(ti->timer);
> -    } else {
> -        ti->next_irq_time =3D get_next_irq_time(ti, current_time);
> -        timer_mod(ti->timer, ti->next_irq_time);
> -    }
> -}
> -
> -static void cuda_timer1(void *opaque)
> -{
> -    CUDAState *s =3D opaque;
> -    CUDATimer *ti =3D &s->timers[0];
> -
> -    cuda_timer_update(s, ti, ti->next_irq_time);
> -    s->ifr |=3D T1_INT;
> -    cuda_update_irq(s);
> -}
> -
> -static void cuda_timer2(void *opaque)
> -{
> -    CUDAState *s =3D opaque;
> -    CUDATimer *ti =3D &s->timers[1];
> -
> -    cuda_timer_update(s, ti, ti->next_irq_time);
> -    s->ifr |=3D T2_INT;
> -    cuda_update_irq(s);
> -}
> -
>  static void cuda_set_sr_int(void *opaque)
>  {
>      CUDAState *s =3D opaque;
> +    MOS6522CUDAState *mcs =3D s->mos6522_cuda;
> +    MOS6522State *ms =3D MOS6522(mcs);
> +    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(ms);
> =20
> -    CUDA_DPRINTF("CUDA: %s:%d\n", __func__, __LINE__);
> -    s->ifr |=3D SR_INT;
> -    cuda_update_irq(s);
> +    mdc->set_sr_int(ms);
>  }
> =20
>  static void cuda_delay_set_sr_int(CUDAState *s)
>  {
> +    MOS6522CUDAState *mcs =3D s->mos6522_cuda;
> +    MOS6522State *ms =3D MOS6522(mcs);
> +    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(ms);
>      int64_t expire;
> =20
> -    if (s->dirb =3D=3D 0xff) {
> -        /* Not in Mac OS, fire the IRQ directly */
> -        cuda_set_sr_int(s);
> +    if (ms->dirb =3D=3D 0xff || s->sr_delay_ns =3D=3D 0) {
> +        /* Disabled or not in Mac OS, fire the IRQ directly */
> +        mdc->set_sr_int(ms);
>          return;
>      }
> =20
>      CUDA_DPRINTF("CUDA: %s:%d\n", __func__, __LINE__);
> =20
> -    expire =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 300 * SCALE_US;
> +    expire =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->sr_delay_ns;
>      timer_mod(s->sr_delay_timer, expire);
>  }
> =20
> -static uint64_t cuda_read(void *opaque, hwaddr addr, unsigned size)
> -{
> -    CUDAState *s =3D opaque;
> -    uint32_t val;
> -
> -    addr =3D (addr >> 9) & 0xf;
> -    switch(addr) {
> -    case CUDA_REG_B:
> -        val =3D s->b;
> -        break;
> -    case CUDA_REG_A:
> -        val =3D s->a;
> -        break;
> -    case CUDA_REG_DIRB:
> -        val =3D s->dirb;
> -        break;
> -    case CUDA_REG_DIRA:
> -        val =3D s->dira;
> -        break;
> -    case CUDA_REG_T1CL:
> -        val =3D get_counter(s, &s->timers[0]) & 0xff;
> -        s->ifr &=3D ~T1_INT;
> -        cuda_update_irq(s);
> -        break;
> -    case CUDA_REG_T1CH:
> -        val =3D get_counter(s, &s->timers[0]) >> 8;
> -        cuda_update_irq(s);
> -        break;
> -    case CUDA_REG_T1LL:
> -        val =3D s->timers[0].latch & 0xff;
> -        break;
> -    case CUDA_REG_T1LH:
> -        /* XXX: check this */
> -        val =3D (s->timers[0].latch >> 8) & 0xff;
> -        break;
> -    case CUDA_REG_T2CL:
> -        val =3D get_counter(s, &s->timers[1]) & 0xff;
> -        s->ifr &=3D ~T2_INT;
> -        cuda_update_irq(s);
> -        break;
> -    case CUDA_REG_T2CH:
> -        val =3D get_counter(s, &s->timers[1]) >> 8;
> -        break;
> -    case CUDA_REG_SR:
> -        val =3D s->sr;
> -        s->ifr &=3D ~(SR_INT | SR_CLOCK_INT | SR_DATA_INT);
> -        cuda_update_irq(s);
> -        break;
> -    case CUDA_REG_ACR:
> -        val =3D s->acr;
> -        break;
> -    case CUDA_REG_PCR:
> -        val =3D s->pcr;
> -        break;
> -    case CUDA_REG_IFR:
> -        val =3D s->ifr;
> -        if (s->ifr & s->ier) {
> -            val |=3D 0x80;
> -        }
> -        break;
> -    case CUDA_REG_IER:
> -        val =3D s->ier | 0x80;
> -        break;
> -    default:
> -    case CUDA_REG_ANH:
> -        val =3D s->anh;
> -        break;
> -    }
> -    if (addr !=3D CUDA_REG_IFR || val !=3D 0) {
> -        CUDA_DPRINTF("read: reg=3D0x%x val=3D%02x\n", (int)addr, val);
> -    }
> -
> -    return val;
> -}
> -
> -static void cuda_write(void *opaque, hwaddr addr, uint64_t val, unsigned=
 size)
> -{
> -    CUDAState *s =3D opaque;
> -
> -    addr =3D (addr >> 9) & 0xf;
> -    CUDA_DPRINTF("write: reg=3D0x%x val=3D%02x\n", (int)addr, val);
> -
> -    switch(addr) {
> -    case CUDA_REG_B:
> -        s->b =3D (s->b & ~s->dirb) | (val & s->dirb);
> -        cuda_update(s);
> -        break;
> -    case CUDA_REG_A:
> -        s->a =3D (s->a & ~s->dira) | (val & s->dira);
> -        break;
> -    case CUDA_REG_DIRB:
> -        s->dirb =3D val;
> -        break;
> -    case CUDA_REG_DIRA:
> -        s->dira =3D val;
> -        break;
> -    case CUDA_REG_T1CL:
> -        s->timers[0].latch =3D (s->timers[0].latch & 0xff00) | val;
> -        cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK=
_VIRTUAL));
> -        break;
> -    case CUDA_REG_T1CH:
> -        s->timers[0].latch =3D (s->timers[0].latch & 0xff) | (val << 8);
> -        s->ifr &=3D ~T1_INT;
> -        set_counter(s, &s->timers[0], s->timers[0].latch);
> -        break;
> -    case CUDA_REG_T1LL:
> -        s->timers[0].latch =3D (s->timers[0].latch & 0xff00) | val;
> -        cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK=
_VIRTUAL));
> -        break;
> -    case CUDA_REG_T1LH:
> -        s->timers[0].latch =3D (s->timers[0].latch & 0xff) | (val << 8);
> -        s->ifr &=3D ~T1_INT;
> -        cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK=
_VIRTUAL));
> -        break;
> -    case CUDA_REG_T2CL:
> -        s->timers[1].latch =3D (s->timers[1].latch & 0xff00) | val;
> -        break;
> -    case CUDA_REG_T2CH:
> -        /* To ensure T2 generates an interrupt on zero crossing with the
> -           common timer code, write the value directly from the latch to
> -           the counter */
> -        s->timers[1].latch =3D (s->timers[1].latch & 0xff) | (val << 8);
> -        s->ifr &=3D ~T2_INT;
> -        set_counter(s, &s->timers[1], s->timers[1].latch);
> -        break;
> -    case CUDA_REG_SR:
> -        s->sr =3D val;
> -        break;
> -    case CUDA_REG_ACR:
> -        s->acr =3D val;
> -        cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK=
_VIRTUAL));
> -        break;
> -    case CUDA_REG_PCR:
> -        s->pcr =3D val;
> -        break;
> -    case CUDA_REG_IFR:
> -        /* reset bits */
> -        s->ifr &=3D ~val;
> -        cuda_update_irq(s);
> -        break;
> -    case CUDA_REG_IER:
> -        if (val & IER_SET) {
> -            /* set bits */
> -            s->ier |=3D val & 0x7f;
> -        } else {
> -            /* reset bits */
> -            s->ier &=3D ~val;
> -        }
> -        cuda_update_irq(s);
> -        break;
> -    default:
> -    case CUDA_REG_ANH:
> -        s->anh =3D val;
> -        break;
> -    }
> -}
> -
>  /* NOTE: TIP and TREQ are negated */
>  static void cuda_update(CUDAState *s)
>  {
> +    MOS6522CUDAState *mcs =3D s->mos6522_cuda;
> +    MOS6522State *ms =3D MOS6522(mcs);
>      int packet_received, len;
> =20
>      packet_received =3D 0;
> -    if (!(s->b & TIP)) {
> +    if (!(ms->b & TIP)) {
>          /* transfer requested from host */
> =20
> -        if (s->acr & SR_OUT) {
> +        if (ms->acr & SR_OUT) {
>              /* data output */
> -            if ((s->b & (TACK | TIP)) !=3D (s->last_b & (TACK | TIP))) {
> +            if ((ms->b & (TACK | TIP)) !=3D (s->last_b & (TACK | TIP))) {
>                  if (s->data_out_index < sizeof(s->data_out)) {
> -                    CUDA_DPRINTF("send: %02x\n", s->sr);
> -                    s->data_out[s->data_out_index++] =3D s->sr;
> +                    CUDA_DPRINTF("send: %02x\n", ms->sr);
> +                    s->data_out[s->data_out_index++] =3D ms->sr;
>                      cuda_delay_set_sr_int(s);
>                  }
>              }
>          } else {
>              if (s->data_in_index < s->data_in_size) {
>                  /* data input */
> -                if ((s->b & (TACK | TIP)) !=3D (s->last_b & (TACK | TIP)=
)) {
> -                    s->sr =3D s->data_in[s->data_in_index++];
> -                    CUDA_DPRINTF("recv: %02x\n", s->sr);
> +                if ((ms->b & (TACK | TIP)) !=3D (s->last_b & (TACK | TIP=
))) {
> +                    ms->sr =3D s->data_in[s->data_in_index++];
> +                    CUDA_DPRINTF("recv: %02x\n", ms->sr);
>                      /* indicate end of transfer */
>                      if (s->data_in_index >=3D s->data_in_size) {
> -                        s->b =3D (s->b | TREQ);
> +                        ms->b =3D (ms->b | TREQ);
>                      }
>                      cuda_delay_set_sr_int(s);
>                  }
> @@ -474,12 +161,13 @@ static void cuda_update(CUDAState *s)
>          }
>      } else {
>          /* no transfer requested: handle sync case */
> -        if ((s->last_b & TIP) && (s->b & TACK) !=3D (s->last_b & TACK)) {
> +        if ((s->last_b & TIP) && (ms->b & TACK) !=3D (s->last_b & TACK))=
 {
>              /* update TREQ state each time TACK change state */
> -            if (s->b & TACK)
> -                s->b =3D (s->b | TREQ);
> -            else
> -                s->b =3D (s->b & ~TREQ);
> +            if (ms->b & TACK) {
> +                ms->b =3D (ms->b | TREQ);
> +            } else {
> +                ms->b =3D (ms->b & ~TREQ);
> +            }
>              cuda_delay_set_sr_int(s);
>          } else {
>              if (!(s->last_b & TIP)) {
> @@ -490,13 +178,13 @@ static void cuda_update(CUDAState *s)
>              }
>              /* signal if there is data to read */
>              if (s->data_in_index < s->data_in_size) {
> -                s->b =3D (s->b & ~TREQ);
> +                ms->b =3D (ms->b & ~TREQ);
>              }
>          }
>      }
> =20
> -    s->last_acr =3D s->acr;
> -    s->last_b =3D s->b;
> +    s->last_acr =3D ms->acr;
> +    s->last_b =3D ms->b;
> =20
>      /* NOTE: cuda_receive_packet_from_host() can call cuda_update()
>         recursively */
> @@ -538,9 +226,8 @@ static void cuda_adb_poll(void *opaque)
>          obuf[1] =3D 0x40; /* polled data */
>          cuda_send_packet_to_host(s, obuf, olen + 2);
>      }
> -    timer_mod(s->adb_poll_timer,
> -                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -                   (NANOSECONDS_PER_SECOND / (1000 / s->autopoll_rate_ms=
)));
> +    timer_mod(s->adb_poll_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +              (NANOSECONDS_PER_SECOND / (1000 / s->autopoll_rate_ms)));
>  }
> =20
>  /* description of commands */
> @@ -787,35 +474,35 @@ static void cuda_receive_packet_from_host(CUDAState=
 *s,
>      }
>  }
> =20
> -static const MemoryRegionOps cuda_ops =3D {
> -    .read =3D cuda_read,
> -    .write =3D cuda_write,
> -    .endianness =3D DEVICE_BIG_ENDIAN,
> -    .valid =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 1,
> -    },
> -};
> +static uint64_t mos6522_cuda_read(void *opaque, hwaddr addr, unsigned si=
ze)
> +{
> +    CUDAState *s =3D opaque;
> +    MOS6522CUDAState *mcs =3D s->mos6522_cuda;
> +    MOS6522State *ms =3D MOS6522(mcs);
> =20
> -static bool cuda_timer_exist(void *opaque, int version_id)
> +    addr =3D (addr >> 9) & 0xf;
> +    return mos6522_read(ms, addr, size);
> +}
> +
> +static void mos6522_cuda_write(void *opaque, hwaddr addr, uint64_t val,
> +                               unsigned size)
>  {
> -    CUDATimer *s =3D opaque;
> +    CUDAState *s =3D opaque;
> +    MOS6522CUDAState *mcs =3D s->mos6522_cuda;
> +    MOS6522State *ms =3D MOS6522(mcs);
> =20
> -    return s->timer !=3D NULL;
> +    addr =3D (addr >> 9) & 0xf;
> +    mos6522_write(ms, addr, val, size);
>  }
> =20
> -static const VMStateDescription vmstate_cuda_timer =3D {
> -    .name =3D "cuda_timer",
> -    .version_id =3D 0,
> -    .minimum_version_id =3D 0,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT16(latch, CUDATimer),
> -        VMSTATE_UINT16(counter_value, CUDATimer),
> -        VMSTATE_INT64(load_time, CUDATimer),
> -        VMSTATE_INT64(next_irq_time, CUDATimer),
> -        VMSTATE_TIMER_PTR_TEST(timer, CUDATimer, cuda_timer_exist),
> -        VMSTATE_END_OF_LIST()
> -    }
> +static const MemoryRegionOps mos6522_cuda_ops =3D {
> +    .read =3D mos6522_cuda_read,
> +    .write =3D mos6522_cuda_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
>  };
> =20
>  static const VMStateDescription vmstate_cuda =3D {
> @@ -823,18 +510,8 @@ static const VMStateDescription vmstate_cuda =3D {
>      .version_id =3D 4,
>      .minimum_version_id =3D 4,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT8(a, CUDAState),
> -        VMSTATE_UINT8(b, CUDAState),
>          VMSTATE_UINT8(last_b, CUDAState),
> -        VMSTATE_UINT8(dira, CUDAState),
> -        VMSTATE_UINT8(dirb, CUDAState),
> -        VMSTATE_UINT8(sr, CUDAState),
> -        VMSTATE_UINT8(acr, CUDAState),
>          VMSTATE_UINT8(last_acr, CUDAState),
> -        VMSTATE_UINT8(pcr, CUDAState),
> -        VMSTATE_UINT8(ifr, CUDAState),
> -        VMSTATE_UINT8(ier, CUDAState),
> -        VMSTATE_UINT8(anh, CUDAState),
>          VMSTATE_INT32(data_in_size, CUDAState),
>          VMSTATE_INT32(data_in_index, CUDAState),
>          VMSTATE_INT32(data_out_index, CUDAState),
> @@ -844,8 +521,6 @@ static const VMStateDescription vmstate_cuda =3D {
>          VMSTATE_BUFFER(data_in, CUDAState),
>          VMSTATE_BUFFER(data_out, CUDAState),
>          VMSTATE_UINT32(tick_offset, CUDAState),
> -        VMSTATE_STRUCT_ARRAY(timers, CUDAState, 2, 1,
> -                             vmstate_cuda_timer, CUDATimer),
>          VMSTATE_TIMER_PTR(adb_poll_timer, CUDAState),
>          VMSTATE_TIMER_PTR(sr_delay_timer, CUDAState),
>          VMSTATE_END_OF_LIST()
> @@ -856,61 +531,48 @@ static void cuda_reset(DeviceState *dev)
>  {
>      CUDAState *s =3D CUDA(dev);
> =20
> -    s->b =3D 0;
> -    s->a =3D 0;
> -    s->dirb =3D 0xff;
> -    s->dira =3D 0;
> -    s->sr =3D 0;
> -    s->acr =3D 0;
> -    s->pcr =3D 0;
> -    s->ifr =3D 0;
> -    s->ier =3D 0;
> -    //    s->ier =3D T1_INT | SR_INT;
> -    s->anh =3D 0;
>      s->data_in_size =3D 0;
>      s->data_in_index =3D 0;
>      s->data_out_index =3D 0;
>      s->autopoll =3D 0;
> -
> -    s->timers[0].latch =3D 0xffff;
> -    set_counter(s, &s->timers[0], 0xffff);
> -
> -    s->timers[1].latch =3D 0xffff;
> -
> -    s->sr_delay_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_i=
nt, s);
>  }
> =20
> -static void cuda_realizefn(DeviceState *dev, Error **errp)
> +static void cuda_realize(DeviceState *dev, Error **errp)
>  {
>      CUDAState *s =3D CUDA(dev);
> +    SysBusDevice *sbd;
> +    MOS6522State *ms;
> +    DeviceState *d;
>      struct tm tm;
> =20
> -    s->timers[0].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer1,=
 s);
> -    s->timers[0].frequency =3D CUDA_TIMER_FREQ;
> -    s->timers[1].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer2,=
 s);
> -    s->timers[1].frequency =3D (SCALE_US * 6000) / 4700;
> +    d =3D qdev_create(NULL, TYPE_MOS6522_CUDA);
> +    object_property_set_link(OBJECT(d), OBJECT(s), "cuda", errp);
> +    qdev_init_nofail(d);
> +    s->mos6522_cuda =3D MOS6522_CUDA(d);
> +
> +    /* Pass IRQ from 6522 */
> +    ms =3D MOS6522(d);
> +    sbd =3D SYS_BUS_DEVICE(s);
> +    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
> =20
>      qemu_get_timedate(&tm, 0);
>      s->tick_offset =3D (uint32_t)mktimegm(&tm) + RTC_OFFSET;
> =20
> +    s->sr_delay_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_i=
nt, s);
> +    s->sr_delay_ns =3D 300 * SCALE_US;
> +
>      s->adb_poll_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_adb_poll=
, s);
> -    s->autopoll_rate_ms =3D 20;
>      s->adb_poll_mask =3D 0xffff;
> +    s->autopoll_rate_ms =3D 20;
>  }
> =20
> -static void cuda_initfn(Object *obj)
> +static void cuda_init(Object *obj)
>  {
> -    SysBusDevice *d =3D SYS_BUS_DEVICE(obj);
>      CUDAState *s =3D CUDA(obj);
> -    int i;
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> =20
> -    memory_region_init_io(&s->mem, obj, &cuda_ops, s, "cuda", 0x2000);
> -    sysbus_init_mmio(d, &s->mem);
> -    sysbus_init_irq(d, &s->irq);
> -
> -    for (i =3D 0; i < ARRAY_SIZE(s->timers); i++) {
> -        s->timers[i].index =3D i;
> -    }
> +    memory_region_init_io(&s->mem, obj, &mos6522_cuda_ops, s, "cuda", 0x=
2000);
> +    sysbus_init_mmio(sbd, &s->mem);
> =20
>      qbus_create_inplace(&s->adb_bus, sizeof(s->adb_bus), TYPE_ADB_BUS,
>                          DEVICE(obj), "adb.0");
> @@ -925,7 +587,7 @@ static void cuda_class_init(ObjectClass *oc, void *da=
ta)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> =20
> -    dc->realize =3D cuda_realizefn;
> +    dc->realize =3D cuda_realize;
>      dc->reset =3D cuda_reset;
>      dc->vmsd =3D &vmstate_cuda;
>      dc->props =3D cuda_properties;
> @@ -936,12 +598,62 @@ static const TypeInfo cuda_type_info =3D {
>      .name =3D TYPE_CUDA,
>      .parent =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(CUDAState),
> -    .instance_init =3D cuda_initfn,
> +    .instance_init =3D cuda_init,
>      .class_init =3D cuda_class_init,
>  };
> =20
> +static void mos6522_cuda_portB_write(MOS6522State *s)
> +{
> +    MOS6522CUDAState *mcs =3D container_of(s, MOS6522CUDAState, parent_o=
bj);
> +
> +    cuda_update(mcs->cuda);
> +}
> +
> +static void mos6522_cuda_realize(DeviceState *dev, Error **errp)
> +{
> +    MOS6522State *ms =3D MOS6522(dev);
> +    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(ms);
> +
> +    mdc->parent_realize(dev, errp);
> +
> +    ms->timers[0].frequency =3D CUDA_TIMER_FREQ;
> +    ms->timers[1].frequency =3D (SCALE_US * 6000) / 4700;
> +}
> +
> +static void mos6522_cuda_init(Object *obj)
> +{
> +    MOS6522CUDAState *s =3D MOS6522_CUDA(obj);
> +
> +    object_property_add_link(obj, "cuda", TYPE_CUDA,
> +                             (Object **) &s->cuda,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             0, NULL);
> +}
> +
> +static void mos6522_cuda_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_CLASS(oc);
> +
> +    dc->realize =3D mos6522_cuda_realize;
> +    mdc->portB_write =3D mos6522_cuda_portB_write;
> +    mdc->get_timer1_counter_value =3D cuda_get_counter_value;
> +    mdc->get_timer2_counter_value =3D cuda_get_counter_value;
> +    mdc->get_timer1_load_time =3D cuda_get_load_time;
> +    mdc->get_timer2_load_time =3D cuda_get_load_time;
> +}
> +
> +static const TypeInfo mos6522_cuda_type_info =3D {
> +    .name =3D TYPE_MOS6522_CUDA,
> +    .parent =3D TYPE_MOS6522,
> +    .instance_size =3D sizeof(MOS6522CUDAState),
> +    .instance_init =3D mos6522_cuda_init,
> +    .class_init =3D mos6522_cuda_class_init,
> +};
> +
>  static void cuda_register_types(void)
>  {
> +    type_register_static(&mos6522_cuda_type_info);
>      type_register_static(&cuda_type_info);
>  }
> =20
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index fa78115c95..3e9f13d9b4 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -30,6 +30,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/ide/internal.h"
>  #include "hw/input/adb.h"
> +#include "hw/misc/mos6522.h"
> =20
>  /* SMP is not enabled, for now */
>  #define MAX_CPUS 1
> @@ -44,59 +45,48 @@
> =20
>  #define ESCC_CLOCK 3686400
> =20
> +/* CUDA commands (2nd byte) */
> +#define CUDA_WARM_START                0x0
> +#define CUDA_AUTOPOLL                  0x1
> +#define CUDA_GET_6805_ADDR             0x2
> +#define CUDA_GET_TIME                  0x3
> +#define CUDA_GET_PRAM                  0x7
> +#define CUDA_SET_6805_ADDR             0x8
> +#define CUDA_SET_TIME                  0x9
> +#define CUDA_POWERDOWN                 0xa
> +#define CUDA_POWERUP_TIME              0xb
> +#define CUDA_SET_PRAM                  0xc
> +#define CUDA_MS_RESET                  0xd
> +#define CUDA_SEND_DFAC                 0xe
> +#define CUDA_BATTERY_SWAP_SENSE        0x10
> +#define CUDA_RESET_SYSTEM              0x11
> +#define CUDA_SET_IPL                   0x12
> +#define CUDA_FILE_SERVER_FLAG          0x13
> +#define CUDA_SET_AUTO_RATE             0x14
> +#define CUDA_GET_AUTO_RATE             0x16
> +#define CUDA_SET_DEVICE_LIST           0x19
> +#define CUDA_GET_DEVICE_LIST           0x1a
> +#define CUDA_SET_ONE_SECOND_MODE       0x1b
> +#define CUDA_SET_POWER_MESSAGES        0x21
> +#define CUDA_GET_SET_IIC               0x22
> +#define CUDA_WAKEUP                    0x23
> +#define CUDA_TIMER_TICKLE              0x24
> +#define CUDA_COMBINED_FORMAT_IIC       0x25
> +
>  /* Cuda */
>  #define TYPE_CUDA "cuda"
>  #define CUDA(obj) OBJECT_CHECK(CUDAState, (obj), TYPE_CUDA)
> =20
> -/**
> - * CUDATimer:
> - * @counter_value: counter value at load time
> - */
> -typedef struct CUDATimer {
> -    int index;
> -    uint16_t latch;
> -    uint16_t counter_value;
> -    int64_t load_time;
> -    int64_t next_irq_time;
> -    uint64_t frequency;
> -    QEMUTimer *timer;
> -} CUDATimer;
> -
> -/**
> - * CUDAState:
> - * @b: B-side data
> - * @a: A-side data
> - * @dirb: B-side direction (1=3Doutput)
> - * @dira: A-side direction (1=3Doutput)
> - * @sr: Shift register
> - * @acr: Auxiliary control register
> - * @pcr: Peripheral control register
> - * @ifr: Interrupt flag register
> - * @ier: Interrupt enable register
> - * @anh: A-side data, no handshake
> - * @last_b: last value of B register
> - * @last_acr: last value of ACR register
> - */
> +typedef struct MOS6522CUDAState MOS6522CUDAState;
> +
>  typedef struct CUDAState {
>      /*< private >*/
>      SysBusDevice parent_obj;
>      /*< public >*/
> -
>      MemoryRegion mem;
> -    /* cuda registers */
> -    uint8_t b;
> -    uint8_t a;
> -    uint8_t dirb;
> -    uint8_t dira;
> -    uint8_t sr;
> -    uint8_t acr;
> -    uint8_t pcr;
> -    uint8_t ifr;
> -    uint8_t ier;
> -    uint8_t anh;
> =20
>      ADBBusState adb_bus;
> -    CUDATimer timers[2];
> +    MOS6522CUDAState *mos6522_cuda;
> =20
>      uint32_t tick_offset;
>      uint64_t tb_frequency;
> @@ -105,6 +95,7 @@ typedef struct CUDAState {
>      uint8_t last_acr;
> =20
>      /* MacOS 9 is racy and requires a delay upon setting the SR_INT bit =
*/
> +    uint64_t sr_delay_ns;
>      QEMUTimer *sr_delay_timer;
> =20
>      int data_in_size;
> @@ -120,6 +111,18 @@ typedef struct CUDAState {
>      QEMUTimer *adb_poll_timer;
>  } CUDAState;
> =20
> +/* MOS6522 CUDA */
> +typedef struct MOS6522CUDAState {
> +    /*< private >*/
> +    MOS6522State parent_obj;
> +
> +    CUDAState *cuda;
> +} MOS6522CUDAState;
> +
> +#define TYPE_MOS6522_CUDA "mos6522-cuda"
> +#define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
> +                                       TYPE_MOS6522_CUDA)
> +
>  /* MacIO */
>  #define TYPE_OLDWORLD_MACIO "macio-oldworld"
>  #define TYPE_NEWWORLD_MACIO "macio-newworld"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eDyw1yV8HuEtd7LH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqBRwcACgkQbDjKyiDZ
s5LkIA/+Nog14l1PKux4iqENt7xrkZpk+nuxo2vmQkk+84AgtoXc3cRdydpz50h0
J5YSD9ZGxE5BL/1oulqrdnOpcYrlScfr2dur1KkbRdYiMaTu4wgIHev8P762GrhT
lIdr4yOwdYKnQKk/pRaMhibJpHQ0Rz0WN25SimWiWSesgiW73Fg14CJe+HNT+67B
1r/p3Fg7WN7cB+CsrEuwAj9LFdheQtg4Sfr1DKi35scTEOMo84fKGejQ3uvAy20e
n9ZMEv6TzFHz2xz7nIVLfaB+u7WtOc+/SsdJhnQBVJ3H+vzEOGegSqx6h27pgHxd
FU45lGj7P1p6mTMItjPn+FNmATMja2hQAq3YHU3CAhEK4ivXsITC1bh+tDMPz42H
c3V18WCG9ahYW8VtJu8pdUFP4td/srzmfey3jXPBJ/OnwfPFmVf+1+FKxEV836Rf
ZOLeBopFsB1VpFolVdGSF22ksbTWOawEpfSkKCXxg2OtKrXENbSA3a0Z0Ywejsi5
3QBMViJwqooSX0DJtu04shWnkl5T7Bbu+2fGRUHXRVeu4yJn5qV1FFxOBaEYjPBp
XcyqgFUMUZ3q5KETGjhUvg2ZDrdNhswik2SOn2rE2rHasVfjAkY947QnbvdwC5DS
uAdHiXmRs3pkRkV4EWR/ZsrEtJn9Rufi66uwa+v2P8BtMIhrMwc=
=Fl3e
-----END PGP SIGNATURE-----

--eDyw1yV8HuEtd7LH--
