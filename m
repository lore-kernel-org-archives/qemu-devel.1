Received: from eggs.gnu.org ([2001:4830:134:3::10]:36596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1euFHA-0003ih-SH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1euFH7-0002LH-Kx
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:29:24 -0500
Received: from chuckie.co.uk ([82.165.15.123]:48737
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1euFH7-0002K3-At
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:29:21 -0500
References: <20180308223946.26784-1-f4bug@amsat.org>
	<20180308223946.26784-2-f4bug@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <19ac97ea-001f-995f-8050-06ac6c32aff3@ilande.co.uk>
Date: Fri, 9 Mar 2018 10:28:56 +0000
MIME-Version: 1.0
In-Reply-To: <20180308223946.26784-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/25] hw/isa: Move parallel_hds_isa_init()
 to hw/char/parallel-isa.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 08/03/18 22:39, Philippe Mathieu-Daudé wrote:

> Again... (after 07dc788054d7 and 9157eee1b1c0).
> 
> We now extract the ISA bus specific helpers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   include/hw/char/parallel.h | 14 ++++++++++++++
>   include/hw/i386/pc.h       |  8 --------
>   hw/char/parallel-isa.c     | 36 ++++++++++++++++++++++++++++++++++++
>   hw/char/parallel.c         |  2 +-
>   hw/i386/pc.c               |  1 +
>   hw/isa/isa-bus.c           | 26 --------------------------
>   hw/mips/mips_fulong2e.c    |  1 +
>   hw/mips/mips_jazz.c        |  1 +
>   hw/mips/mips_malta.c       |  1 +
>   hw/sparc64/sun4u.c         |  1 +
>   MAINTAINERS                |  3 ++-
>   hw/char/Makefile.objs      |  1 +
>   12 files changed, 59 insertions(+), 36 deletions(-)
>   create mode 100644 include/hw/char/parallel.h
>   create mode 100644 hw/char/parallel-isa.c
> 
> diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
> new file mode 100644
> index 0000000000..d6dd62fb9f
> --- /dev/null
> +++ b/include/hw/char/parallel.h
> @@ -0,0 +1,14 @@
> +#ifndef HW_PARALLEL_H
> +#define HW_PARALLEL_H
> +
> +#include "exec/memory.h"
> +#include "hw/isa/isa.h"
> +#include "chardev/char.h"
> +
> +void parallel_hds_isa_init(ISABus *bus, int n);
> +
> +bool parallel_mm_init(MemoryRegion *address_space,
> +                      hwaddr base, int it_shift, qemu_irq irq,
> +                      Chardev *chr);
> +
> +#endif
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index bb49165fe0..f1feb18c3c 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -151,14 +151,6 @@ struct PCMachineClass {
>   #define PC_MACHINE_CLASS(klass) \
>       OBJECT_CLASS_CHECK(PCMachineClass, (klass), TYPE_PC_MACHINE)
>   
> -/* parallel.c */
> -
> -void parallel_hds_isa_init(ISABus *bus, int n);
> -
> -bool parallel_mm_init(MemoryRegion *address_space,
> -                      hwaddr base, int it_shift, qemu_irq irq,
> -                      Chardev *chr);
> -
>   /* i8259.c */
>   
>   extern DeviceState *isa_pic;
> diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
> new file mode 100644
> index 0000000000..639e179585
> --- /dev/null
> +++ b/hw/char/parallel-isa.c
> @@ -0,0 +1,36 @@
> +/*
> + * QEMU Parallel PORT (ISA bus helpers)
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/isa/isa.h"
> +#include "hw/char/parallel.h"
> +
> +static void parallel_init(ISABus *bus, int index, Chardev *chr)
> +{
> +    DeviceState *dev;
> +    ISADevice *isadev;
> +
> +    isadev = isa_create(bus, "isa-parallel");
> +    dev = DEVICE(isadev);
> +    qdev_prop_set_uint32(dev, "index", index);
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +    qdev_init_nofail(dev);
> +}
> +
> +void parallel_hds_isa_init(ISABus *bus, int n)
> +{
> +    int i;
> +
> +    assert(n <= MAX_PARALLEL_PORTS);
> +
> +    for (i = 0; i < n; i++) {
> +        if (parallel_hds[i]) {
> +            parallel_init(bus, i, parallel_hds[i]);
> +        }
> +    }
> +}
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index f79dc76543..1542d62201 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -28,7 +28,7 @@
>   #include "chardev/char-parallel.h"
>   #include "chardev/char-fe.h"
>   #include "hw/isa/isa.h"
> -#include "hw/i386/pc.h"
> +#include "hw/char/parallel.h"
>   #include "sysemu/sysemu.h"
>   
>   //#define DEBUG_PARALLEL
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 35fcb6efdf..81364932d3 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -26,6 +26,7 @@
>   #include "hw/hw.h"
>   #include "hw/i386/pc.h"
>   #include "hw/char/serial.h"
> +#include "hw/char/parallel.h"
>   #include "hw/i386/apic.h"
>   #include "hw/i386/topology.h"
>   #include "sysemu/cpus.h"
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 0f2e426d02..63fa77effc 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -24,7 +24,6 @@
>   #include "hw/sysbus.h"
>   #include "sysemu/sysemu.h"
>   #include "hw/isa/isa.h"
> -#include "hw/i386/pc.h"
>   
>   static ISABus *isabus;
>   
> @@ -288,28 +287,3 @@ MemoryRegion *isa_address_space_io(ISADevice *dev)
>   }
>   
>   type_init(isabus_register_types)
> -
> -static void parallel_init(ISABus *bus, int index, Chardev *chr)
> -{
> -    DeviceState *dev;
> -    ISADevice *isadev;
> -
> -    isadev = isa_create(bus, "isa-parallel");
> -    dev = DEVICE(isadev);
> -    qdev_prop_set_uint32(dev, "index", index);
> -    qdev_prop_set_chr(dev, "chardev", chr);
> -    qdev_init_nofail(dev);
> -}
> -
> -void parallel_hds_isa_init(ISABus *bus, int n)
> -{
> -    int i;
> -
> -    assert(n <= MAX_PARALLEL_PORTS);
> -
> -    for (i = 0; i < n; i++) {
> -        if (parallel_hds[i]) {
> -            parallel_init(bus, i, parallel_hds[i]);
> -        }
> -    }
> -}
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index f68c625666..dc77b55755 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -23,6 +23,7 @@
>   #include "hw/hw.h"
>   #include "hw/i386/pc.h"
>   #include "hw/char/serial.h"
> +#include "hw/char/parallel.h"
>   #include "hw/block/fdc.h"
>   #include "net/net.h"
>   #include "hw/boards.h"
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index b09871a814..b24305b7b4 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -28,6 +28,7 @@
>   #include "hw/mips/cpudevs.h"
>   #include "hw/i386/pc.h"
>   #include "hw/char/serial.h"
> +#include "hw/char/parallel.h"
>   #include "hw/isa/isa.h"
>   #include "hw/block/fdc.h"
>   #include "sysemu/sysemu.h"
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 6f0deb99e7..c74882c7e9 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -28,6 +28,7 @@
>   #include "hw/hw.h"
>   #include "hw/i386/pc.h"
>   #include "hw/char/serial.h"
> +#include "hw/char/parallel.h"
>   #include "hw/block/fdc.h"
>   #include "net/net.h"
>   #include "hw/boards.h"
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index da28ab9413..ceb1ba7eaf 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -34,6 +34,7 @@
>   #include "hw/pci-host/sabre.h"
>   #include "hw/i386/pc.h"
>   #include "hw/char/serial.h"
> +#include "hw/char/parallel.h"
>   #include "hw/timer/m48t59.h"
>   #include "hw/block/fdc.h"
>   #include "net/net.h"
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7c4130388..c0f1620f3a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -913,7 +913,7 @@ M: Michael S. Tsirkin <mst@redhat.com>
>   M: Paolo Bonzini <pbonzini@redhat.com>
>   S: Supported
>   F: hw/char/debugcon.c
> -F: hw/char/parallel.c
> +F: hw/char/parallel*
>   F: hw/char/serial*
>   F: hw/dma/i8257*
>   F: hw/i2c/pm_smbus.c
> @@ -928,6 +928,7 @@ F: hw/timer/i8254*
>   F: hw/timer/mc146818rtc*
>   F: hw/watchdog/wdt_ib700.c
>   F: include/hw/display/vga.h
> +F: include/hw/char/parallel.h
>   F: include/hw/i2c/pm_smbus.h
>   F: include/hw/isa/i8257.h
>   F: include/hw/timer/hpet.h
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 1bcd37e98d..1b979100b7 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -1,6 +1,7 @@
>   common-obj-$(CONFIG_IPACK) += ipoctal232.o
>   common-obj-$(CONFIG_ESCC) += escc.o
>   common-obj-$(CONFIG_PARALLEL) += parallel.o
> +common-obj-$(CONFIG_PARALLEL) += parallel-isa.o
>   common-obj-$(CONFIG_PL011) += pl011.o
>   common-obj-$(CONFIG_SERIAL) += serial.o
>   common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
> 

For sun4u:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
