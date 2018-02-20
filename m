Received: from eggs.gnu.org ([2001:4830:134:3::10]:50758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enyc5-0001LL-5Z
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 22:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enyc3-0006TW-A7
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 22:29:05 -0500
Date: Tue, 20 Feb 2018 14:28:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180220032819.GI1109@umbus.fritz.box>
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Content-Disposition: inline
In-Reply-To: <20180219181922.21586-4-mark.cave-ayland@ilande.co.uk>
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


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 06:19:14PM +0000, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/intc/heathrow_pic.c         | 126 +++++++++++++++++++++++------------=
------
>  include/hw/intc/heathrow_pic.h |  49 ++++++++++++++++
>  2 files changed, 119 insertions(+), 56 deletions(-)
>  create mode 100644 include/hw/intc/heathrow_pic.h
>=20
> diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
> index 171f5ed814..7bf44e0d86 100644
> --- a/hw/intc/heathrow_pic.c
> +++ b/hw/intc/heathrow_pic.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
>  #include "hw/ppc/mac.h"
> +#include "hw/intc/heathrow_pic.h"
> =20
>  /* debug PIC */
>  //#define DEBUG_PIC
> @@ -36,39 +37,27 @@
>  #define PIC_DPRINTF(fmt, ...)
>  #endif
> =20
> -typedef struct HeathrowPIC {
> -    uint32_t events;
> -    uint32_t mask;
> -    uint32_t levels;
> -    uint32_t level_triggered;
> -} HeathrowPIC;
> -
> -typedef struct HeathrowPICS {
> -    MemoryRegion mem;
> -    HeathrowPIC pics[2];
> -    qemu_irq *irqs;
> -} HeathrowPICS;
> -
> -static inline int check_irq(HeathrowPIC *pic)
> +static inline int heathrow_check_irq(HeathrowPICState *pic)
>  {
>      return (pic->events | (pic->levels & pic->level_triggered)) & pic->m=
ask;
>  }
> =20
>  /* update the CPU irq state */
> -static void heathrow_pic_update(HeathrowPICS *s)
> +static void heathrow_update_irq(HeathrowState *s)
>  {
> -    if (check_irq(&s->pics[0]) || check_irq(&s->pics[1])) {
> +    if (heathrow_check_irq(&s->pics[0]) ||
> +            heathrow_check_irq(&s->pics[1])) {
>          qemu_irq_raise(s->irqs[0]);
>      } else {
>          qemu_irq_lower(s->irqs[0]);
>      }
>  }
> =20
> -static void pic_write(void *opaque, hwaddr addr,
> -                      uint64_t value, unsigned size)
> +static void heathrow_write(void *opaque, hwaddr addr,
> +                           uint64_t value, unsigned size)
>  {
> -    HeathrowPICS *s =3D opaque;
> -    HeathrowPIC *pic;
> +    HeathrowState *s =3D opaque;
> +    HeathrowPICState *pic;
>      unsigned int n;
> =20
>      n =3D ((addr & 0xfff) - 0x10) >> 4;
> @@ -79,24 +68,24 @@ static void pic_write(void *opaque, hwaddr addr,
>      switch(addr & 0xf) {
>      case 0x04:
>          pic->mask =3D value;
> -        heathrow_pic_update(s);
> +        heathrow_update_irq(s);
>          break;
>      case 0x08:
>          /* do not reset level triggered IRQs */
>          value &=3D ~pic->level_triggered;
>          pic->events &=3D ~value;
> -        heathrow_pic_update(s);
> +        heathrow_update_irq(s);
>          break;
>      default:
>          break;
>      }
>  }
> =20
> -static uint64_t pic_read(void *opaque, hwaddr addr,
> -                         unsigned size)
> +static uint64_t heathrow_read(void *opaque, hwaddr addr,
> +                              unsigned size)
>  {
> -    HeathrowPICS *s =3D opaque;
> -    HeathrowPIC *pic;
> +    HeathrowState *s =3D opaque;
> +    HeathrowPICState *pic;
>      unsigned int n;
>      uint32_t value;
> =20
> @@ -124,16 +113,16 @@ static uint64_t pic_read(void *opaque, hwaddr addr,
>      return value;
>  }
> =20
> -static const MemoryRegionOps heathrow_pic_ops =3D {
> -    .read =3D pic_read,
> -    .write =3D pic_write,
> +static const MemoryRegionOps heathrow_ops =3D {
> +    .read =3D heathrow_read,
> +    .write =3D heathrow_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
> -static void heathrow_pic_set_irq(void *opaque, int num, int level)
> +static void heathrow_set_irq(void *opaque, int num, int level)
>  {
> -    HeathrowPICS *s =3D opaque;
> -    HeathrowPIC *pic;
> +    HeathrowState *s =3D opaque;
> +    HeathrowPICState *pic;
>      unsigned int irq_bit;
> =20
>  #if defined(DEBUG)
> @@ -153,7 +142,7 @@ static void heathrow_pic_set_irq(void *opaque, int nu=
m, int level)
>      } else {
>          pic->levels &=3D ~irq_bit;
>      }
> -    heathrow_pic_update(s);
> +    heathrow_update_irq(s);
>  }
> =20
>  static const VMStateDescription vmstate_heathrow_pic_one =3D {
> @@ -161,54 +150,79 @@ static const VMStateDescription vmstate_heathrow_pi=
c_one =3D {
>      .version_id =3D 0,
>      .minimum_version_id =3D 0,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT32(events, HeathrowPIC),
> -        VMSTATE_UINT32(mask, HeathrowPIC),
> -        VMSTATE_UINT32(levels, HeathrowPIC),
> -        VMSTATE_UINT32(level_triggered, HeathrowPIC),
> +        VMSTATE_UINT32(events, HeathrowPICState),
> +        VMSTATE_UINT32(mask, HeathrowPICState),
> +        VMSTATE_UINT32(levels, HeathrowPICState),
> +        VMSTATE_UINT32(level_triggered, HeathrowPICState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> =20
> -static const VMStateDescription vmstate_heathrow_pic =3D {
> +static const VMStateDescription vmstate_heathrow =3D {
>      .name =3D "heathrow_pic",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_STRUCT_ARRAY(pics, HeathrowPICS, 2, 1,
> -                             vmstate_heathrow_pic_one, HeathrowPIC),
> +        VMSTATE_STRUCT_ARRAY(pics, HeathrowState, 2, 1,
> +                             vmstate_heathrow_pic_one, HeathrowPICState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> =20
> -static void heathrow_pic_reset_one(HeathrowPIC *s)
> +static void heathrow_reset(DeviceState *d)
>  {
> -    memset(s, '\0', sizeof(HeathrowPIC));
> +    HeathrowState *s =3D HEATHROW(d);
> +
> +    s->pics[0].level_triggered =3D 0;
> +    s->pics[1].level_triggered =3D 0x1ff00000;
>  }
> =20
> -static void heathrow_pic_reset(void *opaque)
> +static void heathrow_init(Object *obj)
>  {
> -    HeathrowPICS *s =3D opaque;
> -
> -    heathrow_pic_reset_one(&s->pics[0]);
> -    heathrow_pic_reset_one(&s->pics[1]);
> +    HeathrowState *s =3D HEATHROW(obj);
> =20
> -    s->pics[0].level_triggered =3D 0;
> -    s->pics[1].level_triggered =3D 0x1ff00000;
> +    memory_region_init_io(&s->mem, OBJECT(s), &heathrow_ops, s,
> +                          "heathrow-pic", 0x1000);

IIRC, you generally don't want to create memory regions at instance
init time, but only at realize time.


>  }
> =20
>  qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
>                              int nb_cpus, qemu_irq **irqs)
>  {
> -    HeathrowPICS *s;
> +    DeviceState *d;
> +    HeathrowState *s;
> =20
> -    s =3D g_malloc0(sizeof(HeathrowPICS));
> +    d =3D qdev_create(NULL, TYPE_HEATHROW);
> +    qdev_init_nofail(d);
> +
> +    s =3D HEATHROW(d);
>      /* only 1 CPU */
>      s->irqs =3D irqs[0];
> -    memory_region_init_io(&s->mem, NULL, &heathrow_pic_ops, s,
> -                          "heathrow-pic", 0x1000);
> +
>      *pmem =3D &s->mem;
> =20
> -    vmstate_register(NULL, -1, &vmstate_heathrow_pic, s);
> -    qemu_register_reset(heathrow_pic_reset, s);
> -    return qemu_allocate_irqs(heathrow_pic_set_irq, s, 64);
> +    return qemu_allocate_irqs(heathrow_set_irq, s, HEATHROW_NUM_IRQS);
> +}
> +
> +static void heathrow_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->reset =3D heathrow_reset;
> +    dc->vmsd =3D &vmstate_heathrow;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>  }
> +
> +static const TypeInfo heathrow_type_info =3D {
> +    .name =3D TYPE_HEATHROW,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(HeathrowState),
> +    .instance_init =3D heathrow_init,
> +    .class_init =3D heathrow_class_init,
> +};
> +
> +static void heathrow_register_types(void)
> +{
> +    type_register_static(&heathrow_type_info);
> +}
> +
> +type_init(heathrow_register_types)
> diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pi=
c.h
> new file mode 100644
> index 0000000000..bc3ffaab87
> --- /dev/null
> +++ b/include/hw/intc/heathrow_pic.h
> @@ -0,0 +1,49 @@
> +/*
> + * Heathrow PIC support (OldWorld PowerMac)
> + *
> + * Copyright (c) 2005-2007 Fabrice Bellard
> + * Copyright (c) 2007 Jocelyn Mayer
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
> +#ifndef HEATHROW_H
> +#define HEATHROW_H
> +
> +#define TYPE_HEATHROW "heathrow"
> +#define HEATHROW(obj) OBJECT_CHECK(HeathrowState, (obj), TYPE_HEATHROW)
> +
> +typedef struct HeathrowPICState {
> +    uint32_t events;
> +    uint32_t mask;
> +    uint32_t levels;
> +    uint32_t level_triggered;
> +} HeathrowPICState;
> +
> +typedef struct HeathrowState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mem;
> +    HeathrowPICState pics[2];
> +    qemu_irq *irqs;
> +} HeathrowState;
> +
> +#define HEATHROW_NUM_IRQS 64
> +
> +#endif /* HEATHROW_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqLldEACgkQbDjKyiDZ
s5JpeRAAyggc0P42g6o/boCnlLd70olevYQ9eYrfSPi7BkrpdzqiInl7IhSfhJ3J
ocCBseqDDd2HMrtvVuIUl0Bu6UWf2+AYXQ1B4V1SVnfBQ5ip0qkLJZZXUB6mPbdF
oRdZWHRx83iSQcaGFkF52HRd6Vdfp/2t9wrPFSxSJijOqeh4Ek6fLpP6ks28IQUS
xKHJHKOpuA77I1+ZXGCwYBezKYntCHn+ADHm+eKvhgzDrvv0oS3Ofz1CC4ogJR7G
vay24dssKiT4kM7tjrDPBbIIcJisusl1hOLpwx1uj35HXEqLHEkqBPVwJPqgKphH
6nlk/iuWtzpctM4DqCcxxcYDAprm83rsMQZSQA8TNSLbG/2JZyi4E+lyKZ95lf5F
kyKCaIbHn7jrcgLND+s9req3k8mN2VvImdA7Cj8e3v2FN9sdc78n7TO6eTTFPuFl
1qfm+sqQb+y7jbRDLD1k6H2BMPWSqwNhdiQd4FnjsEhiskeGx8pz2CoOvq+3Y1EG
PkQdAk0bYmpeqavkkUxNQ3Epj0rEjbKj5iYHdGsb+SRlPj9Dwj8WrSVpODP7Fznn
Mb6oKu098RGKUaePWQrkfc39covhHC+e1sXubEgMlXVPfHuuuZfXtmJINHHHPbBm
QtjVWXXaoWfZwlPYpCvT8alN8dO31mINl7PCBOqjyrij0wkqeck=
=0n8r
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
