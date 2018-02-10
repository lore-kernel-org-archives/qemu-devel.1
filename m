Received: from eggs.gnu.org ([2001:4830:134:3::10]:45638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeXB-0000nv-Qr
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX6-00019a-Vs
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:17 -0500
Date: Sun, 11 Feb 2018 10:20:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210232002.GY11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-10-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2MC+DK0smzICZJ/6"
Content-Disposition: inline
In-Reply-To: <20180209185142.17151-10-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 09/12] misc: introduce new mos6522 VIA
 device and enable it for ppc builds
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


--2MC+DK0smzICZJ/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:51:39PM +0000, Mark Cave-Ayland wrote:
> The MOS6522 VIA forms the bridge part of several Mac devices, including t=
he
> Mac via-cuda and via-pmu devices. Introduce a standard mos6522 device that
> can be shared amongst multiple implementations.
>=20
> This is effectively taking the 6522 parts out of cuda.c and turning them
> into a separate device whilst also applying some style tidy-ups and inclu=
ding
> a conversion to trace-events.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  default-configs/ppc-softmmu.mak |   1 +
>  hw/misc/Makefile.objs           |   3 +
>  hw/misc/mos6522.c               | 505 ++++++++++++++++++++++++++++++++++=
++++++
>  hw/misc/trace-events            |   7 +
>  include/hw/misc/mos6522.h       | 152 ++++++++++++
>  5 files changed, 668 insertions(+)
>  create mode 100644 hw/misc/mos6522.c
>  create mode 100644 include/hw/misc/mos6522.h
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index 65680d85bc..76e29cfa14 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -30,6 +30,7 @@ CONFIG_MAC=3Dy
>  CONFIG_ESCC=3Dy
>  CONFIG_MACIO=3Dy
>  CONFIG_SUNGEM=3Dy
> +CONFIG_MOS6522=3Dy
>  CONFIG_CUDA=3Dy
>  CONFIG_ADB=3Dy
>  CONFIG_MAC_NVRAM=3Dy
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index fce426eb75..f33b37a8e5 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -17,6 +17,9 @@ common-obj-$(CONFIG_INTEGRATOR_DEBUG) +=3D arm_integrat=
or_debug.o
>  common-obj-$(CONFIG_A9SCU) +=3D a9scu.o
>  common-obj-$(CONFIG_ARM11SCU) +=3D arm11scu.o
> =20
> +# Mac devices
> +common-obj-$(CONFIG_MOS6522) +=3D mos6522.o
> +
>  # PKUnity SoC devices
>  common-obj-$(CONFIG_PUV3) +=3D puv3_pm.o
> =20
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> new file mode 100644
> index 0000000000..8ad9fc831e
> --- /dev/null
> +++ b/hw/misc/mos6522.c
> @@ -0,0 +1,505 @@
> +/*
> + * QEMU MOS6522 VIA emulation
> + *
> + * Copyright (c) 2004-2007 Fabrice Bellard
> + * Copyright (c) 2007 Jocelyn Mayer
> + * Copyright (c) 2018 Mark Cave-Ayland
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "hw/hw.h"
> +#include "hw/input/adb.h"
> +#include "hw/misc/mos6522.h"
> +#include "qemu/timer.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/cutils.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +
> +/* XXX: implement all timer modes */
> +
> +static void mos6522_timer_update(MOS6522State *s, MOS6522Timer *ti,
> +                                 int64_t current_time);
> +
> +static void mos6522_update_irq(MOS6522State *s)
> +{
> +    if (s->ifr & s->ier & (SR_INT | T1_INT | T2_INT)) {
> +        qemu_irq_raise(s->irq);
> +    } else {
> +        qemu_irq_lower(s->irq);
> +    }
> +}
> +
> +static uint64_t get_counter_value(MOS6522State *s, MOS6522Timer *ti)
> +{
> +    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(s);
> +
> +    if (ti->index =3D=3D 0) {
> +        return mdc->get_timer1_counter_value(s, ti);
> +    } else {
> +        return mdc->get_timer2_counter_value(s, ti);
> +    }
> +}
> +
> +static uint64_t get_load_time(MOS6522State *s, MOS6522Timer *ti)
> +{
> +    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(s);
> +
> +    if (ti->index =3D=3D 0) {
> +        return mdc->get_timer1_load_time(s, ti);
> +    } else {
> +        return mdc->get_timer2_load_time(s, ti);
> +    }
> +}
> +
> +static unsigned int get_counter(MOS6522State *s, MOS6522Timer *ti)
> +{
> +    int64_t d;
> +    unsigned int counter;
> +
> +    d =3D get_counter_value(s, ti);
> +
> +    if (ti->index =3D=3D 0) {
> +        /* the timer goes down from latch to -1 (period of latch + 2) */
> +        if (d <=3D (ti->counter_value + 1)) {
> +            counter =3D (ti->counter_value - d) & 0xffff;
> +        } else {
> +            counter =3D (d - (ti->counter_value + 1)) % (ti->latch + 2);
> +            counter =3D (ti->latch - counter) & 0xffff;
> +        }
> +    } else {
> +        counter =3D (ti->counter_value - d) & 0xffff;
> +    }
> +    return counter;
> +}
> +
> +static void set_counter(MOS6522State *s, MOS6522Timer *ti, unsigned int =
val)
> +{
> +    trace_mos6522_set_counter(1 + ti->index, val);
> +    ti->load_time =3D get_load_time(s, ti);
> +    ti->counter_value =3D val;
> +    mos6522_timer_update(s, ti, ti->load_time);
> +}
> +
> +static int64_t get_next_irq_time(MOS6522State *s, MOS6522Timer *ti,
> +                                 int64_t current_time)
> +{
> +    int64_t d, next_time;
> +    unsigned int counter;
> +
> +    /* current counter value */
> +    d =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_time,
> +                 ti->frequency, NANOSECONDS_PER_SECOND);
> +
> +    /* the timer goes down from latch to -1 (period of latch + 2) */
> +    if (d <=3D (ti->counter_value + 1)) {
> +        counter =3D (ti->counter_value - d) & 0xffff;
> +    } else {
> +        counter =3D (d - (ti->counter_value + 1)) % (ti->latch + 2);
> +        counter =3D (ti->latch - counter) & 0xffff;
> +    }
> +
> +    /* Note: we consider the irq is raised on 0 */
> +    if (counter =3D=3D 0xffff) {
> +        next_time =3D d + ti->latch + 1;
> +    } else if (counter =3D=3D 0) {
> +        next_time =3D d + ti->latch + 2;
> +    } else {
> +        next_time =3D d + counter;
> +    }
> +    trace_mos6522_get_next_irq_time(ti->latch, d, next_time - d);
> +    next_time =3D muldiv64(next_time, NANOSECONDS_PER_SECOND, ti->freque=
ncy) +
> +                         ti->load_time;
> +    if (next_time <=3D current_time) {
> +        next_time =3D current_time + 1;
> +    }
> +    return next_time;
> +}
> +
> +static void mos6522_timer_update(MOS6522State *s, MOS6522Timer *ti,
> +                                 int64_t current_time)
> +{
> +    if (!ti->timer) {
> +        return;
> +    }
> +    if (ti->index =3D=3D 0 && (s->acr & T1MODE) !=3D T1MODE_CONT) {
> +        timer_del(ti->timer);
> +    } else {
> +        ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
> +        timer_mod(ti->timer, ti->next_irq_time);
> +    }
> +}
> +
> +static void mos6522_timer1(void *opaque)
> +{
> +    MOS6522State *s =3D opaque;
> +    MOS6522Timer *ti =3D &s->timers[0];
> +
> +    mos6522_timer_update(s, ti, ti->next_irq_time);
> +    s->ifr |=3D T1_INT;
> +    mos6522_update_irq(s);
> +}
> +
> +static void mos6522_timer2(void *opaque)
> +{
> +    MOS6522State *s =3D opaque;
> +    MOS6522Timer *ti =3D &s->timers[1];
> +
> +    mos6522_timer_update(s, ti, ti->next_irq_time);
> +    s->ifr |=3D T2_INT;
> +    mos6522_update_irq(s);
> +}
> +
> +static void mos6522_set_sr_int(MOS6522State *s)
> +{
> +    trace_mos6522_set_sr_int();
> +    s->ifr |=3D SR_INT;
> +    mos6522_update_irq(s);
> +}
> +
> +static uint64_t mos6522_get_counter_value(MOS6522State *s, MOS6522Timer =
*ti)
> +{
> +    uint64_t d;
> +
> +    d =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_time,
> +                 ti->frequency, NANOSECONDS_PER_SECOND);
> +
> +    return d;
> +}
> +
> +static uint64_t mos6522_get_load_time(MOS6522State *s, MOS6522Timer *ti)
> +{
> +    uint64_t load_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +    return load_time;
> +}
> +
> +static void mos6522_portA_write(MOS6522State *s)
> +{
> +    qemu_log_mask(LOG_UNIMP, "portA_write unimplemented");
> +}
> +
> +static void mos6522_portB_write(MOS6522State *s)
> +{
> +    qemu_log_mask(LOG_UNIMP, "portB_write unimplemented");
> +}
> +
> +uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    MOS6522State *s =3D opaque;
> +    uint32_t val;
> +
> +    switch (addr) {
> +    case VIA_REG_B:
> +        val =3D s->b;
> +        break;
> +    case VIA_REG_A:
> +        val =3D s->a;
> +        break;
> +    case VIA_REG_DIRB:
> +        val =3D s->dirb;
> +        break;
> +    case VIA_REG_DIRA:
> +        val =3D s->dira;
> +        break;
> +    case VIA_REG_T1CL:
> +        val =3D get_counter(s, &s->timers[0]) & 0xff;
> +        s->ifr &=3D ~T1_INT;
> +        mos6522_update_irq(s);
> +        break;
> +    case VIA_REG_T1CH:
> +        val =3D get_counter(s, &s->timers[0]) >> 8;
> +        mos6522_update_irq(s);
> +        break;
> +    case VIA_REG_T1LL:
> +        val =3D s->timers[0].latch & 0xff;
> +        break;
> +    case VIA_REG_T1LH:
> +        /* XXX: check this */
> +        val =3D (s->timers[0].latch >> 8) & 0xff;
> +        break;
> +    case VIA_REG_T2CL:
> +        val =3D get_counter(s, &s->timers[1]) & 0xff;
> +        s->ifr &=3D ~T2_INT;
> +        mos6522_update_irq(s);
> +        break;
> +    case VIA_REG_T2CH:
> +        val =3D get_counter(s, &s->timers[1]) >> 8;
> +        break;
> +    case VIA_REG_SR:
> +        val =3D s->sr;
> +        s->ifr &=3D ~(SR_INT | CB1_INT | CB2_INT);
> +        mos6522_update_irq(s);
> +        break;
> +    case VIA_REG_ACR:
> +        val =3D s->acr;
> +        break;
> +    case VIA_REG_PCR:
> +        val =3D s->pcr;
> +        break;
> +    case VIA_REG_IFR:
> +        val =3D s->ifr;
> +        if (s->ifr & s->ier) {
> +            val |=3D 0x80;
> +        }
> +        break;
> +    case VIA_REG_IER:
> +        val =3D s->ier | 0x80;
> +        break;
> +    default:
> +    case VIA_REG_ANH:
> +        val =3D s->anh;
> +        break;
> +    }
> +
> +    if (addr !=3D VIA_REG_IFR || val !=3D 0) {
> +        trace_mos6522_read(addr, val);
> +    }
> +
> +    return val;
> +}
> +
> +void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned siz=
e)
> +{
> +    MOS6522State *s =3D opaque;
> +    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(s);
> +
> +    trace_mos6522_write(addr, val);
> +
> +    switch (addr) {
> +    case VIA_REG_B:
> +        s->b =3D (s->b & ~s->dirb) | (val & s->dirb);
> +        mdc->portB_write(s);
> +        break;
> +    case VIA_REG_A:
> +        s->a =3D (s->a & ~s->dira) | (val & s->dira);
> +        mdc->portA_write(s);
> +        break;
> +    case VIA_REG_DIRB:
> +        s->dirb =3D val;
> +        break;
> +    case VIA_REG_DIRA:
> +        s->dira =3D val;
> +        break;
> +    case VIA_REG_T1CL:
> +        s->timers[0].latch =3D (s->timers[0].latch & 0xff00) | val;
> +        mos6522_timer_update(s, &s->timers[0],
> +                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        break;
> +    case VIA_REG_T1CH:
> +        s->timers[0].latch =3D (s->timers[0].latch & 0xff) | (val << 8);
> +        s->ifr &=3D ~T1_INT;
> +        set_counter(s, &s->timers[0], s->timers[0].latch);
> +        break;
> +    case VIA_REG_T1LL:
> +        s->timers[0].latch =3D (s->timers[0].latch & 0xff00) | val;
> +        mos6522_timer_update(s, &s->timers[0],
> +                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        break;
> +    case VIA_REG_T1LH:
> +        s->timers[0].latch =3D (s->timers[0].latch & 0xff) | (val << 8);
> +        s->ifr &=3D ~T1_INT;
> +        mos6522_timer_update(s, &s->timers[0],
> +                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        break;
> +    case VIA_REG_T2CL:
> +        s->timers[1].latch =3D (s->timers[1].latch & 0xff00) | val;
> +        break;
> +    case VIA_REG_T2CH:
> +        /* To ensure T2 generates an interrupt on zero crossing with the
> +           common timer code, write the value directly from the latch to
> +           the counter */
> +        s->timers[1].latch =3D (s->timers[1].latch & 0xff) | (val << 8);
> +        s->ifr &=3D ~T2_INT;
> +        set_counter(s, &s->timers[1], s->timers[1].latch);
> +        break;
> +    case VIA_REG_SR:
> +        s->sr =3D val;
> +        break;
> +    case VIA_REG_ACR:
> +        s->acr =3D val;
> +        mos6522_timer_update(s, &s->timers[0],
> +                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        break;
> +    case VIA_REG_PCR:
> +        s->pcr =3D val;
> +        break;
> +    case VIA_REG_IFR:
> +        /* reset bits */
> +        s->ifr &=3D ~val;
> +        mos6522_update_irq(s);
> +        break;
> +    case VIA_REG_IER:
> +        if (val & IER_SET) {
> +            /* set bits */
> +            s->ier |=3D val & 0x7f;
> +        } else {
> +            /* reset bits */
> +            s->ier &=3D ~val;
> +        }
> +        mos6522_update_irq(s);
> +        break;
> +    default:
> +    case VIA_REG_ANH:
> +        s->anh =3D val;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps mos6522_ops =3D {
> +    .read =3D mos6522_read,
> +    .write =3D mos6522_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +};
> +
> +static bool mos6522_timer_exist(void *opaque, int version_id)
> +{
> +    MOS6522Timer *s =3D opaque;
> +
> +    return s->timer !=3D NULL;
> +}
> +
> +static const VMStateDescription vmstate_mos6522_timer =3D {
> +    .name =3D "mos6522_timer",
> +    .version_id =3D 0,
> +    .minimum_version_id =3D 0,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT16(latch, MOS6522Timer),
> +        VMSTATE_UINT16(counter_value, MOS6522Timer),
> +        VMSTATE_INT64(load_time, MOS6522Timer),
> +        VMSTATE_INT64(next_irq_time, MOS6522Timer),
> +        VMSTATE_TIMER_PTR_TEST(timer, MOS6522Timer, mos6522_timer_exist),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_mos6522 =3D {
> +    .name =3D "mos6522",
> +    .version_id =3D 0,
> +    .minimum_version_id =3D 0,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(a, MOS6522State),
> +        VMSTATE_UINT8(b, MOS6522State),
> +        VMSTATE_UINT8(dira, MOS6522State),
> +        VMSTATE_UINT8(dirb, MOS6522State),
> +        VMSTATE_UINT8(sr, MOS6522State),
> +        VMSTATE_UINT8(acr, MOS6522State),
> +        VMSTATE_UINT8(pcr, MOS6522State),
> +        VMSTATE_UINT8(ifr, MOS6522State),
> +        VMSTATE_UINT8(ier, MOS6522State),
> +        VMSTATE_UINT8(anh, MOS6522State),
> +        VMSTATE_STRUCT_ARRAY(timers, MOS6522State, 2, 1,
> +                             vmstate_mos6522_timer, MOS6522Timer),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void mos6522_reset(DeviceState *dev)
> +{
> +    MOS6522State *s =3D MOS6522(dev);
> +
> +    s->b =3D 0;
> +    s->a =3D 0;
> +    s->dirb =3D 0xff;
> +    s->dira =3D 0;
> +    s->sr =3D 0;
> +    s->acr =3D 0;
> +    s->pcr =3D 0;
> +    s->ifr =3D 0;
> +    s->ier =3D 0;
> +    /* s->ier =3D T1_INT | SR_INT; */
> +    s->anh =3D 0;
> +
> +    s->timers[0].latch =3D 0xffff;
> +    set_counter(s, &s->timers[0], 0xffff);
> +
> +    s->timers[1].latch =3D 0xffff;
> +}
> +
> +static void mos6522_realize(DeviceState *dev, Error **errp)
> +{
> +    MOS6522State *s =3D MOS6522(dev);
> +
> +    s->timers[0].frequency =3D s->frequency;
> +    s->timers[1].frequency =3D s->frequency;
> +}
> +
> +static void mos6522_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    MOS6522State *s =3D MOS6522(obj);
> +    int i;
> +
> +    memory_region_init_io(&s->mem, obj, &mos6522_ops, s, "mos6522", 0x10=
);
> +    sysbus_init_mmio(sbd, &s->mem);
> +    sysbus_init_irq(sbd, &s->irq);
> +
> +    for (i =3D 0; i < ARRAY_SIZE(s->timers); i++) {
> +        s->timers[i].index =3D i;
> +    }
> +
> +    s->timers[0].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_time=
r1, s);
> +    s->timers[1].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_time=
r2, s);
> +}
> +
> +static Property mos6522_properties[] =3D {
> +    DEFINE_PROP_UINT64("frequency", MOS6522State, frequency, 0),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void mos6522_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_CLASS(oc);
> +
> +    dc->realize =3D mos6522_realize;
> +    dc->reset =3D mos6522_reset;
> +    dc->vmsd =3D &vmstate_mos6522;
> +    dc->props =3D mos6522_properties;
> +    mdc->parent_realize =3D dc->realize;
> +    mdc->set_sr_int =3D mos6522_set_sr_int;
> +    mdc->portB_write =3D mos6522_portB_write;
> +    mdc->portA_write =3D mos6522_portA_write;
> +    mdc->get_timer1_counter_value =3D mos6522_get_counter_value;
> +    mdc->get_timer2_counter_value =3D mos6522_get_counter_value;
> +    mdc->get_timer1_load_time =3D mos6522_get_load_time;
> +    mdc->get_timer2_load_time =3D mos6522_get_load_time;
> +}
> +
> +static const TypeInfo mos6522_type_info =3D {
> +    .name =3D TYPE_MOS6522,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(MOS6522State),
> +    .instance_init =3D mos6522_init,
> +    .abstract =3D true,
> +    .class_size =3D sizeof(MOS6522DeviceClass),
> +    .class_init =3D mos6522_class_init,
> +};
> +
> +static void mos6522_register_types(void)
> +{
> +    type_register_static(&mos6522_type_info);
> +}
> +
> +type_init(mos6522_register_types)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index e6070f280d..b340d4e81c 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -70,3 +70,10 @@ msf2_sysreg_write_pll_status(void) "Invalid write to r=
ead only PLL status regist
>  #hw/misc/imx7_gpr.c
>  imx7_gpr_read(uint64_t offset) "addr 0x%08" HWADDR_PRIx
>  imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" HWADDR_PRIx=
 "value 0x%08" HWADDR_PRIx
> +
> +# hw/misc/mos6522.c
> +mos6522_set_counter(int index, unsigned int val) "T%d.counter=3D%d"
> +mos6522_get_next_irq_time(uint16_t latch, int64_t d, int64_t delta) "lat=
ch=3D%d counter=3D0x%"PRId64 " delta_next=3D0x%"PRId64
> +mos6522_set_sr_int(void) "set sr_int"
> +mos6522_write(uint64_t addr, uint64_t val) "reg=3D0x%"PRIx64 " val=3D0x%=
"PRIx64
> +mos6522_read(uint64_t addr, unsigned val) "reg=3D0x%"PRIx64 " val=3D0x%x"
> diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
> new file mode 100644
> index 0000000000..a53c161b00
> --- /dev/null
> +++ b/include/hw/misc/mos6522.h
> @@ -0,0 +1,152 @@
> +/*
> + * QEMU MOS6522 VIA emulation
> + *
> + * Copyright (c) 2004-2007 Fabrice Bellard
> + * Copyright (c) 2007 Jocelyn Mayer
> + * Copyright (c) 2018 Mark Cave-Ayland
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef MOS6522_H
> +#define MOS6522_H
> +
> +#include "exec/memory.h"
> +#include "hw/sysbus.h"
> +#include "hw/ide/internal.h"
> +#include "hw/input/adb.h"
> +
> +/* Bits in ACR */
> +#define SR_CTRL            0x1c    /* Shift register control bits */
> +#define SR_EXT             0x0c    /* Shift on external clock */
> +#define SR_OUT             0x10    /* Shift out if 1 */
> +
> +/* Bits in IFR and IER */
> +#define IER_SET            0x80    /* set bits in IER */
> +#define IER_CLR            0       /* clear bits in IER */
> +
> +#define CA2_INT            0x01
> +#define CA1_INT            0x02
> +#define SR_INT             0x04    /* Shift register full/empty */
> +#define CB2_INT            0x08
> +#define CB1_INT            0x10
> +#define T2_INT             0x20    /* Timer 2 interrupt */
> +#define T1_INT             0x40    /* Timer 1 interrupt */
> +
> +/* Bits in ACR */
> +#define T1MODE             0xc0    /* Timer 1 mode */
> +#define T1MODE_CONT        0x40    /*  continuous interrupts */
> +
> +/* VIA registers */
> +#define VIA_REG_B       0x00
> +#define VIA_REG_A       0x01
> +#define VIA_REG_DIRB    0x02
> +#define VIA_REG_DIRA    0x03
> +#define VIA_REG_T1CL    0x04
> +#define VIA_REG_T1CH    0x05
> +#define VIA_REG_T1LL    0x06
> +#define VIA_REG_T1LH    0x07
> +#define VIA_REG_T2CL    0x08
> +#define VIA_REG_T2CH    0x09
> +#define VIA_REG_SR      0x0a
> +#define VIA_REG_ACR     0x0b
> +#define VIA_REG_PCR     0x0c
> +#define VIA_REG_IFR     0x0d
> +#define VIA_REG_IER     0x0e
> +#define VIA_REG_ANH     0x0f
> +
> +/**
> + * MOS6522Timer:
> + * @counter_value: counter value at load time
> + */
> +typedef struct MOS6522Timer {
> +    int index;
> +    uint16_t latch;
> +    uint16_t counter_value;
> +    int64_t load_time;
> +    int64_t next_irq_time;
> +    uint64_t frequency;
> +    QEMUTimer *timer;
> +} MOS6522Timer;
> +
> +/**
> + * MOS6522State:
> + * @b: B-side data
> + * @a: A-side data
> + * @dirb: B-side direction (1=3Doutput)
> + * @dira: A-side direction (1=3Doutput)
> + * @sr: Shift register
> + * @acr: Auxiliary control register
> + * @pcr: Peripheral control register
> + * @ifr: Interrupt flag register
> + * @ier: Interrupt enable register
> + * @anh: A-side data, no handshake
> + * @last_b: last value of B register
> + * @last_acr: last value of ACR register
> + */
> +typedef struct MOS6522State {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion mem;
> +    /* VIA registers */
> +    uint8_t b;
> +    uint8_t a;
> +    uint8_t dirb;
> +    uint8_t dira;
> +    uint8_t sr;
> +    uint8_t acr;
> +    uint8_t pcr;
> +    uint8_t ifr;
> +    uint8_t ier;
> +    uint8_t anh;
> +
> +    MOS6522Timer timers[2];
> +    uint64_t frequency;
> +
> +    qemu_irq irq;
> +} MOS6522State;
> +
> +#define TYPE_MOS6522 "mos6522"
> +#define MOS6522(obj) OBJECT_CHECK(MOS6522State, (obj), TYPE_MOS6522)
> +
> +typedef struct MOS6522DeviceClass {
> +    DeviceClass parent_class;
> +
> +    DeviceRealize parent_realize;
> +    void (*set_sr_int)(MOS6522State *dev);
> +    void (*portB_write)(MOS6522State *dev);
> +    void (*portA_write)(MOS6522State *dev);
> +    /* These are used to influence the CUDA MacOS timebase calibration */
> +    uint64_t (*get_timer1_counter_value)(MOS6522State *dev, MOS6522Timer=
 *ti);
> +    uint64_t (*get_timer2_counter_value)(MOS6522State *dev, MOS6522Timer=
 *ti);
> +    uint64_t (*get_timer1_load_time)(MOS6522State *dev, MOS6522Timer *ti=
);
> +    uint64_t (*get_timer2_load_time)(MOS6522State *dev, MOS6522Timer *ti=
);
> +} MOS6522DeviceClass;
> +
> +#define MOS6522_DEVICE_CLASS(cls) \
> +    OBJECT_CLASS_CHECK(MOS6522DeviceClass, (cls), TYPE_MOS6522)
> +#define MOS6522_DEVICE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(MOS6522DeviceClass, (obj), TYPE_MOS6522)
> +
> +uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size);
> +void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned siz=
e);
> +
> +#endif /* MOS6522_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2MC+DK0smzICZJ/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp/fiIACgkQbDjKyiDZ
s5JM9hAAiofVexsQzC/mrN+mMkkrpWZoO0bBCCs0bChtUFmCjnM7za3vlwHJ6WCA
hqKs0+PBQI/54tCmJPArHXCdmEDPhjdgP8h4rjrQE0UneqctBVTVK3SrQVG0D/0D
eLVt40VTh0jGMMPTx4TSpMGFAdLm2h+z2IHuQAiXaK2rZb5VJFJQc3x6UQihC6EE
uTsXZIny1Gbb52ok7w/R7YOH9hI51v+LPJ+vtDLhhYq5WDSyj5HwSVCqtzPhNqbk
iLLW+MS5JHl15BYqulmLr3GBt0TCHitEGO1rEvSErjShSCC6s71GrjmCEY1PfmEm
GVhZ76CwsTUqmOYQCrqTa5YLSKdzTm8YLAEwmQ6tacz0nwIBjVMFREZOazTN/kdc
R0bywlAxHg4cQrNitQo7A0WOatRYljqwuoKKuJdvdOp4LF41vgYxWIpCzUU6NamX
QEfYO4Sdm3N7sgufininWlb8gGS2gXETNykpFrwvotnBiIlizan/Hxy6nUuNhGgm
/1syaA43RDax0K+BsvyTO66xENYsKogv7wxx/1qCMTQzF3gUeEezhzN++h0Y6x/2
rzv8shP15pHNZU9Ao2oJAz47vxoCqKjKQAQ3j5qJjqVFgpVS63fymiKuByBpLTax
FnobstyXCluyaHUxSxYn9cxMpmROgY12swKMcRnqz7s9spPa6jQ=
=6AWy
-----END PGP SIGNATURE-----

--2MC+DK0smzICZJ/6--
