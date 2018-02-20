Received: from eggs.gnu.org ([2001:4830:134:3::10]:33214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enzox-0001fb-BJ
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enzot-0000Vs-8N
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:46:27 -0500
Date: Tue, 20 Feb 2018 15:39:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180220043903.GN1109@umbus.fritz.box>
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-4-mark.cave-ayland@ilande.co.uk>
	<20180220032819.GI1109@umbus.fritz.box>
	<ecb06770-1401-4d97-5bf8-9249b1d904d8@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BjavXC7V3ilNTWHC"
Content-Disposition: inline
In-Reply-To: <ecb06770-1401-4d97-5bf8-9249b1d904d8@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 03/11] heathrow: QOMify heathrow PIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--BjavXC7V3ilNTWHC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 04:18:01AM +0000, Mark Cave-Ayland wrote:
> On 20/02/18 03:28, David Gibson wrote:
>=20
> > On Mon, Feb 19, 2018 at 06:19:14PM +0000, Mark Cave-Ayland wrote:
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > ---
> > >   hw/intc/heathrow_pic.c         | 126 +++++++++++++++++++++++-------=
-----------
> > >   include/hw/intc/heathrow_pic.h |  49 ++++++++++++++++
> > >   2 files changed, 119 insertions(+), 56 deletions(-)
> > >   create mode 100644 include/hw/intc/heathrow_pic.h
> > >=20
> > > diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
> > > index 171f5ed814..7bf44e0d86 100644
> > > --- a/hw/intc/heathrow_pic.c
> > > +++ b/hw/intc/heathrow_pic.c
> > > @@ -25,6 +25,7 @@
> > >   #include "qemu/osdep.h"
> > >   #include "hw/hw.h"
> > >   #include "hw/ppc/mac.h"
> > > +#include "hw/intc/heathrow_pic.h"
> > >   /* debug PIC */
> > >   //#define DEBUG_PIC
> > > @@ -36,39 +37,27 @@
> > >   #define PIC_DPRINTF(fmt, ...)
> > >   #endif
> > > -typedef struct HeathrowPIC {
> > > -    uint32_t events;
> > > -    uint32_t mask;
> > > -    uint32_t levels;
> > > -    uint32_t level_triggered;
> > > -} HeathrowPIC;
> > > -
> > > -typedef struct HeathrowPICS {
> > > -    MemoryRegion mem;
> > > -    HeathrowPIC pics[2];
> > > -    qemu_irq *irqs;
> > > -} HeathrowPICS;
> > > -
> > > -static inline int check_irq(HeathrowPIC *pic)
> > > +static inline int heathrow_check_irq(HeathrowPICState *pic)
> > >   {
> > >       return (pic->events | (pic->levels & pic->level_triggered)) & p=
ic->mask;
> > >   }
> > >   /* update the CPU irq state */
> > > -static void heathrow_pic_update(HeathrowPICS *s)
> > > +static void heathrow_update_irq(HeathrowState *s)
> > >   {
> > > -    if (check_irq(&s->pics[0]) || check_irq(&s->pics[1])) {
> > > +    if (heathrow_check_irq(&s->pics[0]) ||
> > > +            heathrow_check_irq(&s->pics[1])) {
> > >           qemu_irq_raise(s->irqs[0]);
> > >       } else {
> > >           qemu_irq_lower(s->irqs[0]);
> > >       }
> > >   }
> > > -static void pic_write(void *opaque, hwaddr addr,
> > > -                      uint64_t value, unsigned size)
> > > +static void heathrow_write(void *opaque, hwaddr addr,
> > > +                           uint64_t value, unsigned size)
> > >   {
> > > -    HeathrowPICS *s =3D opaque;
> > > -    HeathrowPIC *pic;
> > > +    HeathrowState *s =3D opaque;
> > > +    HeathrowPICState *pic;
> > >       unsigned int n;
> > >       n =3D ((addr & 0xfff) - 0x10) >> 4;
> > > @@ -79,24 +68,24 @@ static void pic_write(void *opaque, hwaddr addr,
> > >       switch(addr & 0xf) {
> > >       case 0x04:
> > >           pic->mask =3D value;
> > > -        heathrow_pic_update(s);
> > > +        heathrow_update_irq(s);
> > >           break;
> > >       case 0x08:
> > >           /* do not reset level triggered IRQs */
> > >           value &=3D ~pic->level_triggered;
> > >           pic->events &=3D ~value;
> > > -        heathrow_pic_update(s);
> > > +        heathrow_update_irq(s);
> > >           break;
> > >       default:
> > >           break;
> > >       }
> > >   }
> > > -static uint64_t pic_read(void *opaque, hwaddr addr,
> > > -                         unsigned size)
> > > +static uint64_t heathrow_read(void *opaque, hwaddr addr,
> > > +                              unsigned size)
> > >   {
> > > -    HeathrowPICS *s =3D opaque;
> > > -    HeathrowPIC *pic;
> > > +    HeathrowState *s =3D opaque;
> > > +    HeathrowPICState *pic;
> > >       unsigned int n;
> > >       uint32_t value;
> > > @@ -124,16 +113,16 @@ static uint64_t pic_read(void *opaque, hwaddr a=
ddr,
> > >       return value;
> > >   }
> > > -static const MemoryRegionOps heathrow_pic_ops =3D {
> > > -    .read =3D pic_read,
> > > -    .write =3D pic_write,
> > > +static const MemoryRegionOps heathrow_ops =3D {
> > > +    .read =3D heathrow_read,
> > > +    .write =3D heathrow_write,
> > >       .endianness =3D DEVICE_LITTLE_ENDIAN,
> > >   };
> > > -static void heathrow_pic_set_irq(void *opaque, int num, int level)
> > > +static void heathrow_set_irq(void *opaque, int num, int level)
> > >   {
> > > -    HeathrowPICS *s =3D opaque;
> > > -    HeathrowPIC *pic;
> > > +    HeathrowState *s =3D opaque;
> > > +    HeathrowPICState *pic;
> > >       unsigned int irq_bit;
> > >   #if defined(DEBUG)
> > > @@ -153,7 +142,7 @@ static void heathrow_pic_set_irq(void *opaque, in=
t num, int level)
> > >       } else {
> > >           pic->levels &=3D ~irq_bit;
> > >       }
> > > -    heathrow_pic_update(s);
> > > +    heathrow_update_irq(s);
> > >   }
> > >   static const VMStateDescription vmstate_heathrow_pic_one =3D {
> > > @@ -161,54 +150,79 @@ static const VMStateDescription vmstate_heathro=
w_pic_one =3D {
> > >       .version_id =3D 0,
> > >       .minimum_version_id =3D 0,
> > >       .fields =3D (VMStateField[]) {
> > > -        VMSTATE_UINT32(events, HeathrowPIC),
> > > -        VMSTATE_UINT32(mask, HeathrowPIC),
> > > -        VMSTATE_UINT32(levels, HeathrowPIC),
> > > -        VMSTATE_UINT32(level_triggered, HeathrowPIC),
> > > +        VMSTATE_UINT32(events, HeathrowPICState),
> > > +        VMSTATE_UINT32(mask, HeathrowPICState),
> > > +        VMSTATE_UINT32(levels, HeathrowPICState),
> > > +        VMSTATE_UINT32(level_triggered, HeathrowPICState),
> > >           VMSTATE_END_OF_LIST()
> > >       }
> > >   };
> > > -static const VMStateDescription vmstate_heathrow_pic =3D {
> > > +static const VMStateDescription vmstate_heathrow =3D {
> > >       .name =3D "heathrow_pic",
> > >       .version_id =3D 1,
> > >       .minimum_version_id =3D 1,
> > >       .fields =3D (VMStateField[]) {
> > > -        VMSTATE_STRUCT_ARRAY(pics, HeathrowPICS, 2, 1,
> > > -                             vmstate_heathrow_pic_one, HeathrowPIC),
> > > +        VMSTATE_STRUCT_ARRAY(pics, HeathrowState, 2, 1,
> > > +                             vmstate_heathrow_pic_one, HeathrowPICSt=
ate),
> > >           VMSTATE_END_OF_LIST()
> > >       }
> > >   };
> > > -static void heathrow_pic_reset_one(HeathrowPIC *s)
> > > +static void heathrow_reset(DeviceState *d)
> > >   {
> > > -    memset(s, '\0', sizeof(HeathrowPIC));
> > > +    HeathrowState *s =3D HEATHROW(d);
> > > +
> > > +    s->pics[0].level_triggered =3D 0;
> > > +    s->pics[1].level_triggered =3D 0x1ff00000;
> > >   }
> > > -static void heathrow_pic_reset(void *opaque)
> > > +static void heathrow_init(Object *obj)
> > >   {
> > > -    HeathrowPICS *s =3D opaque;
> > > -
> > > -    heathrow_pic_reset_one(&s->pics[0]);
> > > -    heathrow_pic_reset_one(&s->pics[1]);
> > > +    HeathrowState *s =3D HEATHROW(obj);
> > > -    s->pics[0].level_triggered =3D 0;
> > > -    s->pics[1].level_triggered =3D 0x1ff00000;
> > > +    memory_region_init_io(&s->mem, OBJECT(s), &heathrow_ops, s,
> > > +                          "heathrow-pic", 0x1000);
> >=20
> > IIRC, you generally don't want to create memory regions at instance
> > init time, but only at realize time.
>=20
> I'm not sure that this is still the case? The last time it was explained =
to
> me, my understanding was that initialisation should generally be done at
> init() at time, except when it depends upon a qdev property at which point
> it should be deferred until realize().
>=20
> When I ask these questions I tend to get pointed towards the ARM
> boards/devices for examples of the current best practices for devices, and
> there are definitely multiple examples of this in hw/arm.

Huh, ok.  I guess my info is out of date.  It'd be nice if the QOM
rules were actually written down somewhere.

Ok, well resend with whatever revisions are needed for the later
patches.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BjavXC7V3ilNTWHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqLpmUACgkQbDjKyiDZ
s5LvGQ//arg6h3YGLUjnCx+odb0ofq23nSQrQE+x+4Mwd1g5hygBz6TM+466oM8n
1lPSj8VGFOTOeb7WNVBmM6pn8548m9es9CumKl8/Z796LVSso8bYrW1q5S5z4J0L
AwzyJ3KpvZBths2ML0vLYysFHppSVAZ9z+U64GDBa0JZ3wBGgX9MaXZdBDlD+Cqc
2KGMUB0mAUsiMOlqfnaZAwCQmLzsKIzep5oVEIpgdPqcVaAlpTSnlGFQzIjI2lsT
8s/BqDbrefE2YF1DnygHXyIllzU3h2onycaKX4m/NSB74CfSTJiUBzhx4yPiA7zL
2opuxlBWLZOmMQpqc1cONKtEqz751XORlI44mp0YA4SmN3inxAWYlLGSKSQSnYx0
6Lr9t59E+SpYUc3l3wPzv7CoTSe5TTqDjvc9XXk+MFlKtAqWIJlyeMbVG5VavpLj
zTwNEKV6Ku9X+IjFc6/IR6dRr0zyTOoYTeqGXIWdwp+Lb6jEsCmsWJ7GHjJkNoMJ
JL0H/SxSnmjwJ421OhxuPIHcxq1xUHJjNbMBCjkPswL9YwKPUwvddb1uKjj/RI2y
tk1NNwFsul3d0Tvmg7OP8S4tHOv056MtKosvgF4r6cHZHw9qKjuUPdTTUmZi7LW1
4IYVnN9Uv8qrodJHw3n6bCu6k+adhtc6XmPVJJU9MjW/n/c8+VY=
=J158
-----END PGP SIGNATURE-----

--BjavXC7V3ilNTWHC--
