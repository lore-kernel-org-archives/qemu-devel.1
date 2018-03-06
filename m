Received: from eggs.gnu.org ([2001:4830:134:3::10]:38167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et0Bf-0001RS-Jl
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et0Bd-0003BX-IM
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:10:35 -0500
Date: Tue, 6 Mar 2018 11:05:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180306000521.GN2650@umbus.fritz.box>
References: <20180305211928.466-1-f4bug@amsat.org>
	<20180305211928.466-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SqfawxHnX56H7Ukl"
Content-Disposition: inline
In-Reply-To: <20180305211928.466-4-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 03/22] hw/input/i8042: Extract
 declarations from i386/pc.h into input/i8042.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Alexander Graf <agraf@suse.de>, "open list:PReP" <qemu-ppc@nongnu.org>


--SqfawxHnX56H7Ukl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 06:19:09PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

hw/ppc part
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/i386/pc.h     |  9 ---------
>  include/hw/input/i8042.h | 24 ++++++++++++++++++++++++
>  hw/alpha/dp264.c         |  3 ++-
>  hw/i386/pc.c             |  1 +
>  hw/i386/vmmouse.c        |  1 +
>  hw/i386/vmport.c         |  1 +
>  hw/input/pckbd.c         |  2 +-
>  hw/mips/mips_fulong2e.c  |  3 ++-
>  hw/mips/mips_jazz.c      |  1 +
>  hw/mips/mips_malta.c     |  3 ++-
>  hw/mips/mips_r4k.c       |  3 ++-
>  hw/ppc/prep.c            |  5 +++--
>  hw/sparc64/sun4u.c       |  1 +
>  hw/unicore32/puv3.c      |  1 +
>  MAINTAINERS              |  1 +
>  15 files changed, 43 insertions(+), 16 deletions(-)
>  create mode 100644 include/hw/input/i8042.h
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index f1feb18c3c..1638618dfc 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -188,15 +188,6 @@ void vmport_register(unsigned char command, VMPortRe=
adFunc *func, void *opaque);
>  void vmmouse_get_data(uint32_t *data);
>  void vmmouse_set_data(const uint32_t *data);
> =20
> -/* pckbd.c */
> -#define I8042_A20_LINE "a20"
> -
> -void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
> -                   MemoryRegion *region, ram_addr_t size,
> -                   hwaddr mask);
> -void i8042_isa_mouse_fake_event(void *opaque);
> -void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out);
> -
>  /* pc.c */
>  extern int fd_bootchk;
> =20
> diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
> new file mode 100644
> index 0000000000..f6ff146364
> --- /dev/null
> +++ b/include/hw/input/i8042.h
> @@ -0,0 +1,24 @@
> +/*
> + * QEMU PS/2 Controller
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +#ifndef HW_INPUT_I8042_H
> +#define HW_INPUT_I8042_H
> +
> +#include "hw/hw.h"
> +#include "hw/isa/isa.h"
> +
> +#define TYPE_I8042 "i8042"
> +
> +#define I8042_A20_LINE "a20"
> +
> +void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
> +                   MemoryRegion *region, ram_addr_t size,
> +                   hwaddr mask);
> +void i8042_isa_mouse_fake_event(void *opaque);
> +void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out);
> +
> +#endif /* HW_INPUT_I8042_H */
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 766373eec7..e13cb576fd 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -19,6 +19,7 @@
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/ide.h"
>  #include "hw/timer/i8254.h"
> +#include "hw/input/i8042.h"
>  #include "hw/char/serial.h"
>  #include "qemu/cutils.h"
> =20
> @@ -81,7 +82,7 @@ static void clipper_init(MachineState *machine)
>      mc146818_rtc_init(isa_bus, 1900, rtc_irq);
> =20
>      i8254_pit_init(isa_bus, 0x40, 0, NULL);
> -    isa_create_simple(isa_bus, "i8042");
> +    isa_create_simple(isa_bus, TYPE_I8042);
> =20
>      /* VGA setup.  Don't bother loading the bios.  */
>      pci_vga_init(pci_bus);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 95b3fb3523..efb1b3bccf 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -43,6 +43,7 @@
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/dma/i8257.h"
>  #include "hw/timer/i8254.h"
> +#include "hw/input/i8042.h"
>  #include "hw/audio/pcspk.h"
>  #include "hw/pci/msi.h"
>  #include "hw/sysbus.h"
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index 65ef55329e..5d2d278be4 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -25,6 +25,7 @@
>  #include "hw/hw.h"
>  #include "ui/console.h"
>  #include "hw/i386/pc.h"
> +#include "hw/input/i8042.h"
>  #include "hw/qdev.h"
> =20
>  /* debug only vmmouse */
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index 116aa09819..3bf8cfe041 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -25,6 +25,7 @@
>  #include "hw/hw.h"
>  #include "hw/isa/isa.h"
>  #include "hw/i386/pc.h"
> +#include "hw/input/i8042.h"
>  #include "sysemu/hw_accel.h"
>  #include "hw/qdev.h"
>  #include "qemu/log.h"
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index c479f827b6..f17f18e51b 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -26,6 +26,7 @@
>  #include "hw/isa/isa.h"
>  #include "hw/i386/pc.h"
>  #include "hw/input/ps2.h"
> +#include "hw/input/i8042.h"
>  #include "sysemu/sysemu.h"
> =20
>  /* debug PC keyboard */
> @@ -480,7 +481,6 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_i=
rq,
>      qemu_register_reset(kbd_reset, s);
>  }
> =20
> -#define TYPE_I8042 "i8042"
>  #define I8042(obj) OBJECT_CHECK(ISAKBDState, (obj), TYPE_I8042)
> =20
>  typedef struct ISAKBDState {
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 0545fcd899..9339e02120 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -44,6 +44,7 @@
>  #include "hw/isa/vt82c686.h"
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/timer/i8254.h"
> +#include "hw/input/i8042.h"
>  #include "sysemu/blockdev.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/qtest.h"
> @@ -364,7 +365,7 @@ static void mips_fulong2e_init(MachineState *machine)
>      i8257_dma_init(isa_bus, 0);
> =20
>      /* Super I/O */
> -    isa_create_simple(isa_bus, "i8042");
> +    isa_create_simple(isa_bus, TYPE_I8042);
> =20
>      mc146818_rtc_init(isa_bus, 2000, NULL);
> =20
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 827ffdcd4a..5abbe30c21 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -43,6 +43,7 @@
>  #include "hw/timer/i8254.h"
>  #include "hw/display/vga.h"
>  #include "hw/audio/pcspk.h"
> +#include "hw/input/i8042.h"
>  #include "sysemu/block-backend.h"
>  #include "hw/sysbus.h"
>  #include "exec/address-spaces.h"
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 9cb86c432e..cd7bd0eef6 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -47,6 +47,7 @@
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "hw/timer/mc146818rtc.h"
> +#include "hw/input/i8042.h"
>  #include "hw/timer/i8254.h"
>  #include "sysemu/blockdev.h"
>  #include "exec/address-spaces.h"
> @@ -1213,7 +1214,7 @@ void mips_malta_init(MachineState *machine)
>      i8257_dma_init(isa_bus, 0);
> =20
>      /* Super I/O */
> -    isa_create_simple(isa_bus, "i8042");
> +    isa_create_simple(isa_bus, TYPE_I8042);
> =20
>      mc146818_rtc_init(isa_bus, 2000, NULL);
>      serial_hds_isa_init(isa_bus, 0, 2);
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 830ee7732c..aeadc4a340 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -28,6 +28,7 @@
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "hw/timer/mc146818rtc.h"
> +#include "hw/input/i8042.h"
>  #include "hw/timer/i8254.h"
>  #include "sysemu/block-backend.h"
>  #include "exec/address-spaces.h"
> @@ -286,7 +287,7 @@ void mips_r4k_init(MachineState *machine)
>                       hd[MAX_IDE_DEVS * i],
>  		     hd[MAX_IDE_DEVS * i + 1]);
> =20
> -    isa_create_simple(isa_bus, "i8042");
> +    isa_create_simple(isa_bus, TYPE_I8042);
>  }
> =20
>  static void mips_machine_init(MachineClass *mc)
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 096d4d4cfb..ae724b0613 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -41,6 +41,7 @@
>  #include "hw/ide.h"
>  #include "hw/loader.h"
>  #include "hw/timer/mc146818rtc.h"
> +#include "hw/input/i8042.h"
>  #include "hw/isa/pc87312.h"
>  #include "hw/net/ne2000-isa.h"
>  #include "sysemu/block-backend.h"
> @@ -641,7 +642,7 @@ static void ppc_prep_init(MachineState *machine)
>                       hd[2 * i],
>  		     hd[2 * i + 1]);
>      }
> -    isa_create_simple(isa_bus, "i8042");
> +    isa_create_simple(isa_bus, TYPE_I8042);
> =20
>      cpu =3D POWERPC_CPU(first_cpu);
>      sysctrl->reset_irq =3D cpu->env.irq_inputs[PPC6xx_INPUT_HRESET];
> @@ -771,7 +772,7 @@ static void ibm_40p_init(MachineState *machine)
> =20
>      /* add some more devices */
>      if (defaults_enabled()) {
> -        isa_create_simple(isa_bus, "i8042");
> +        isa_create_simple(isa_bus, TYPE_I8042);
>          m48t59 =3D NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
> =20
>          dev =3D DEVICE(isa_create(isa_bus, "cs4231a"));
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 0ca0243821..2044a52ded 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -36,6 +36,7 @@
>  #include "hw/char/serial.h"
>  #include "hw/char/parallel.h"
>  #include "hw/timer/m48t59.h"
> +#include "hw/input/i8042.h"
>  #include "hw/block/fdc.h"
>  #include "net/net.h"
>  #include "qemu/timer.h"
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index db26959a1d..830fe3face 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -20,6 +20,7 @@
> =20
>  #undef DEBUG_PUV3
>  #include "hw/unicore32/puv3.h"
> +#include "hw/input/i8042.h"
> =20
>  #define KERNEL_LOAD_ADDR        0x03000000
>  #define KERNEL_MAX_SIZE         0x00800000 /* Just a guess */
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 335c6c9f65..6622efc1da 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -931,6 +931,7 @@ F: include/hw/display/vga.h
>  F: include/hw/char/parallel.h
>  F: include/hw/dma/i8257.h
>  F: include/hw/i2c/pm_smbus.h
> +F: include/hw/input/i8042.h
>  F: include/hw/timer/hpet.h
>  F: include/hw/timer/i8254*
>  F: include/hw/timer/mc146818rtc*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SqfawxHnX56H7Ukl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqd2z8ACgkQbDjKyiDZ
s5IfKBAA1evh3CRk0yl6PLN6xJqI1YdQzdBW/pEA4SIb1Kn4IXxVoQLG40UtFItY
YQsZniYsnECXN2dta61cXdtrWNuTT3NAFMEUuqP4hWweU0wxbSITM5ksmIknpr1n
mAlk++33LgE/9N5AB3He8oNOR2JeaGIENep81kGKO/yAMyylixEKE5opqPs1RUjc
/lLw951bw+ybnAqKay6MySBmXVu/ea59uEbWa5GtrhrX46UgSiJyAy0yfYnus6Q8
RJxZUqqNOYqPLfLNgTh2BFRWOmHRBRS1jG62+KgZFrMkZabq0cRATMLx06PuaJ55
7Zs0VRqF5PDXMkz2SflPFEksgOH+uJ1XwYVGqcBg2guvjoW5tBV7Q6jKibniJB14
Fdo4fEt0XqCazy+CZae2AQdnes+5kuO6J5VMyYQNZxRp5CZVx1bjzj3ldJeeI0sl
8E5pFe/vP/8FTsWq/P0GDla99doVlCJMy5DdzpgeOVJfEG1ZRQrFe4oyYgaKSHTX
0hFbJ5T1Y7+mOdO2nDW5i72KK5zc5XQlRamD9yEUY8PXYUFZjxZh6hOjney94/S/
P1Nb2pO8slz9AO/wP3cC24Mr8Zjyqx8DwulV6z3cJDPzYO7WBP790oN0DPMT5EfA
sj/ZR3JEZJIyNTJ6IInlwGq+9Ymzvjkw50wKeOWPZov9By3FnA8=
=JH76
-----END PGP SIGNATURE-----

--SqfawxHnX56H7Ukl--
