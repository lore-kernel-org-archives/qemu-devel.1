Received: from eggs.gnu.org ([2001:4830:134:3::10]:32811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eYNz7-0006kh-8g
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 22:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eYNz5-0004T0-2U
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 22:20:25 -0500
Date: Mon, 8 Jan 2018 13:54:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180108025410.GA2131@umbus.fritz.box>
References: <20180108024558.17983-1-f4bug@amsat.org>
	<20180108024558.17983-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20180108024558.17983-6-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 05/29] hw/input/i8042: extract declarations
 from i386/pc.h into input/i8042.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "open list:PReP" <qemu-ppc@nongnu.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2018 at 11:45:34PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/i386/pc.h     |  9 ---------
>  include/hw/input/i8042.h | 25 +++++++++++++++++++++++++
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
>  hw/sparc64/sun4u.c       |  3 ++-
>  hw/unicore32/puv3.c      |  1 +
>  MAINTAINERS              |  1 +
>  15 files changed, 45 insertions(+), 17 deletions(-)
>  create mode 100644 include/hw/input/i8042.h
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 87a377011b..103c7a9916 100644
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
> index 0000000000..15115004a3
> --- /dev/null
> +++ b/include/hw/input/i8042.h
> @@ -0,0 +1,25 @@
> +/*
> + * QEMU PS/2 Controller
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
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
> index e39af3d48c..e5c4e48ebb 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -42,6 +42,7 @@
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
> index cbe159034d..8660d078c8 100644
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
> @@ -365,7 +366,7 @@ static void mips_fulong2e_init(MachineState *machine)
>      i8257_dma_init(isa_bus, 0);
> =20
>      /* Super I/O */
> -    isa_create_simple(isa_bus, "i8042");
> +    isa_create_simple(isa_bus, TYPE_I8042);
> =20
>      mc146818_rtc_init(isa_bus, 2000, NULL);
> =20
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 6ed4b83f40..7a83009059 100644
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
> index 0a9e3dedf4..28cc37ee08 100644
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
> @@ -1214,7 +1215,7 @@ void mips_malta_init(MachineState *machine)
>      i8257_dma_init(isa_bus, 0);
> =20
>      /* Super I/O */
> -    isa_create_simple(isa_bus, "i8042");
> +    isa_create_simple(isa_bus, TYPE_I8042);
> =20
>      mc146818_rtc_init(isa_bus, 2000, NULL);
>      serial_hds_isa_init(isa_bus, 0, 2);
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 244bd41813..92acae149d 100644
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
> @@ -288,7 +289,7 @@ void mips_r4k_init(MachineState *machine)
>                       hd[MAX_IDE_DEVS * i],
>  		     hd[MAX_IDE_DEVS * i + 1]);
> =20
> -    isa_create_simple(isa_bus, "i8042");
> +    isa_create_simple(isa_bus, TYPE_I8042);
>  }
> =20
>  static void mips_machine_init(MachineClass *mc)
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index af08ac319a..4304e93ada 100644
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
> index 135f8088ca..2a60f5c1d6 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -33,6 +33,7 @@
>  #include "hw/char/serial.h"
>  #include "hw/char/parallel.h"
>  #include "hw/timer/m48t59.h"
> +#include "hw/input/i8042.h"
>  #include "hw/block/fdc.h"
>  #include "net/net.h"
>  #include "qemu/timer.h"
> @@ -513,7 +514,7 @@ static void sun4uv_init(MemoryRegion *address_space_m=
em,
>      qdev_init_nofail(&pci_dev->qdev);
>      pci_ide_create_devs(pci_dev, hd);
> =20
> -    isa_create_simple(isa_bus, "i8042");
> +    isa_create_simple(isa_bus, TYPE_I8042);
> =20
>      /* Floppy */
>      for(i =3D 0; i < MAX_FD; i++) {
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
> index 89810df375..7f9e98a046 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -885,6 +885,7 @@ F: include/hw/display/vga.h
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

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpS3VAACgkQbDjKyiDZ
s5K8URAAuEu3dIQcE5CZUe52Lc/1T6F9/PLAZ/FJdt1CBa9B/6sEAjWVEemp0GCC
fRIxDFzk9BV4x762ABiyTSiId8JO+nI4NeS96kYIs0hOjQFtZavOHwb1eIulfEA5
9+KNFQoDxQRkbwcf+CtRb5VB9GZWOFvSwHJxxxsZBOXS1dRdwCcp7HJh/rY/du7R
pMB0rkPq4BMfm48df99d0wEq+WNI+Cy47o27OFtnpCy5yRHGgWTT7LefY0C4Un3u
zUc35mgzk4eZTD6Ce0OOezHMddGgAdImIBoP1aBHnCRQl2BjrQ78mHsZA1q6p+z1
D4yaS+Kn1BtV4bY0btxOGCebBzfXKtlxKz5kLVFha8N1Bub3/Zm6iYbANKCZguTn
nHBfTGBB+ynyO0rkEfMX/8AKavXfzVD25o/ro6TFzc5ypjAZxEVi/nXrlDTw+Kap
/IKXdfNg8FmIh0TL7oQFbAizotIYogHGdBvWBzW0hDn43wTepUcYI0UE5FHnES27
TmuG8zNVVZ6+JUvOgi4pKrs69bN1f74bVdeS8sIpqSUFvnlc5tzu/z4zovNi34nM
gkibGIgi4KGCBXFR9+SR/XhFr6vZqG3Z/O87izU2rB3rANDfAF9NxrT4aSzHa18Z
ODcl05MV8e/WS4z0Bwr692Uma5Y20g9pZdTvyKSxIsMCEqMvWY4=
=1BQP
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
