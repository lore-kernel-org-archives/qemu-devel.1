Received: from eggs.gnu.org ([2001:4830:134:3::10]:46564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu3PW-0007SI-HN
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 16:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu3PS-0007WU-F8
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 16:49:14 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu3PS-0007T8-3v
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 16:49:10 -0500
Received: by mail-wr0-x244.google.com with SMTP id v65so7139453wrc.11
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 13:49:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180305211928.466-1-f4bug@amsat.org>
	<20180305211928.466-19-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <46445f6b-268e-f325-959e-de68c616fe32@amsat.org>
Date: Thu, 8 Mar 2018 22:49:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180305211928.466-19-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 18/22] hw/isa/vt82c686: Add the
 TYPE_VT82C686B_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On 03/05/2018 10:19 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/isa/vt82c686.h |  2 ++
>  hw/isa/vt82c686.c         | 20 ++++++++++++++++++++
>  hw/mips/mips_fulong2e.c   | 15 +++------------
>  3 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
> index db97c8ed7a..c3c2b6e786 100644
> --- a/include/hw/isa/vt82c686.h
> +++ b/include/hw/isa/vt82c686.h
> @@ -1,6 +1,8 @@
>  #ifndef HW_VT82C686_H
>  #define HW_VT82C686_H
>  
> +#define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
> +
>  /* vt82c686.c */
>  ISABus *vt82c686b_isa_init(PCIBus * bus, int devfn);
>  void vt82c686b_ac97_init(PCIBus *bus, int devfn);
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 7eaf3c7e8f..cff1946232 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -17,6 +17,7 @@
>  #include "hw/i2c/smbus.h"
>  #include "hw/pci/pci.h"
>  #include "hw/isa/isa.h"
> +#include "hw/isa/superio.h"
>  #include "hw/sysbus.h"
>  #include "hw/mips/mips.h"
>  #include "hw/isa/apm.h"
> @@ -519,11 +520,30 @@ static const TypeInfo via_info = {
>      },
>  };
>  
> +static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
> +{
> +    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
> +
> +    sc->serial.count = 2;
> +    sc->parallel.count = 1;
> +    sc->ide.count = 0;
> +    sc->floppy.count = 1;
> +}
> +
> +static const TypeInfo via_superio_info = {
> +    .name          = TYPE_VT82C686B_SUPERIO,
> +    .parent        = TYPE_ISA_SUPERIO,
> +    .instance_size = sizeof(ISASuperIODevice),
> +    .class_size    = sizeof(ISASuperIOClass),
> +    .class_init    = vt82c686b_superio_class_init,
> +};
> +
>  static void vt82c686b_register_types(void)
>  {
>      type_register_static(&via_ac97_info);
>      type_register_static(&via_mc97_info);
>      type_register_static(&via_pm_info);
> +    type_register_static(&via_superio_info);
>      type_register_static(&via_info);
>  }
>  
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 9ebc225d3b..d608f17e1e 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -23,9 +23,7 @@
>  #include "hw/hw.h"
>  #include "hw/i386/pc.h"
>  #include "hw/dma/i8257.h"
> -#include "hw/char/serial.h"
> -#include "hw/char/parallel.h"
> -#include "hw/block/fdc.h"
> +#include "hw/isa/superio.h"
>  #include "net/net.h"
>  #include "hw/boards.h"
>  #include "hw/i2c/smbus.h"
> @@ -34,7 +32,6 @@
>  #include "hw/mips/mips.h"
>  #include "hw/mips/cpudevs.h"
>  #include "hw/pci/pci.h"
> -#include "sysemu/sysemu.h"
>  #include "audio/audio.h"
>  #include "qemu/log.h"
>  #include "hw/loader.h"
> @@ -44,8 +41,6 @@
>  #include "hw/isa/vt82c686.h"
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/timer/i8254.h"
> -#include "hw/input/i8042.h"
> -#include "sysemu/blockdev.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/qtest.h"
>  #include "qemu/error-report.h"
> @@ -250,6 +245,8 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
>      /* init other devices */
>      i8254_pit_init(isa_bus, 0x40, 0, NULL);
>      i8257_dma_init(isa_bus, 0);
> +    /* Super I/O */
> +    isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
>  
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>      vt82c686b_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
> @@ -262,12 +259,6 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
>      /* Audio support */
>      vt82c686b_ac97_init(pci_bus, PCI_DEVFN(slot, 5));
>      vt82c686b_mc97_init(pci_bus, PCI_DEVFN(slot, 6));
> -
> -    /* Super I/O */
> -    isa_create_simple(isa_bus, TYPE_I8042);
> -
> -    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
> -    parallel_hds_isa_init(isa_bus, 1);
>  }
>  
>  /* Network support */

I don't have Fuloong 2e image at hand, but the monitor "info qtree" diff
without/with TYPE_VT82C686B_SUPERIO is:

         bus: isa.0
           type ISA
+          dev: isa-fdc, id ""
+            iobase = 1008 (0x3f0)
+            irq = 6 (0x6)
+            dma = 2 (0x2)
+            driveA = ""
+            driveB = ""
+            check_media_rate = true
+            fdtypeA = "auto"
+            fdtypeB = "auto"
+            fallback = "288"
+            isa irq 6
+            bus: floppy-bus.0
+              type floppy-bus
+              dev: floppy, id ""
+                unit = 0 (0x0)
+                drive = "floppy0"
+                logical_block_size = 512 (0x200)
+                physical_block_size = 512 (0x200)
+                min_io_size = 0 (0x0)
+                opt_io_size = 0 (0x0)
+                discard_granularity = 4294967295 (0xffffffff)
+                write-cache = "auto"
+                share-rw = false
+                drive-type = "288"
+          dev: isa-serial, id ""
+            index = 1 (0x1)
+            iobase = 760 (0x2f8)
+            irq = 3 (0x3)
+            chardev = "discarding-serial1"
+            wakeup = 0 (0x0)
+            isa irq 3
           dev: isa-serial, id ""
             index = 0 (0x0)
             iobase = 1016 (0x3f8)
             irq = 4 (0x4)
             chardev = "serial0"
             wakeup = 0 (0x0)
             isa irq 4
           dev: isa-parallel, id ""
             index = 0 (0x0)
             iobase = 888 (0x378)
             irq = 7 (0x7)
             chardev = "parallel0"
             isa irq 7
+          dev: vt82c686b-superio, id ""

and "info mtree":

     0000000000000170-0000000000000177 (prio 0, i/o): ide
     00000000000001f0-00000000000001f7 (prio 0, i/o): ide
+    00000000000002f8-00000000000002ff (prio 0, i/o): serial
     0000000000000376-0000000000000376 (prio 0, i/o): ide
     0000000000000378-000000000000037f (prio 0, i/o): parallel
     00000000000003f0-00000000000003f1 (prio 0, i/o): superio [disabled]
+    00000000000003f1-00000000000003f5 (prio 0, i/o): fdc
     00000000000003f6-00000000000003f6 (prio 0, i/o): ide
+    00000000000003f7-00000000000003f7 (prio 0, i/o): fdc
     00000000000003f8-00000000000003ff (prio 0, i/o): serial
     00000000000004d0-00000000000004d0 (prio 0, i/o): elcr
     00000000000004d1-00000000000004d1 (prio 0, i/o): elcr
