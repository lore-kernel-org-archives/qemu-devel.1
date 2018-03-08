Received: from eggs.gnu.org ([2001:4830:134:3::10]:51139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu3oU-0007w0-0o
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu3oP-0001Nd-0u
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:15:01 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu3oO-0001NJ-MO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:14:56 -0500
Received: by mail-wr0-x243.google.com with SMTP id f14so7199461wre.8
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 14:14:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180305211928.466-1-f4bug@amsat.org>
	<20180305211928.466-22-f4bug@amsat.org>
	<db2026ea-9bfe-b464-6f90-2d1badc08e73@amsat.org>
Message-ID: <5bca4067-cb3b-c63f-a0ee-ffd914829d38@amsat.org>
Date: Thu, 8 Mar 2018 23:14:53 +0100
MIME-Version: 1.0
In-Reply-To: <db2026ea-9bfe-b464-6f90-2d1badc08e73@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 21/22] hw/alpha/dp264: Use the
 TYPE_SMC37C669_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On 03/08/2018 09:39 PM, Philippe Mathieu-Daudé wrote:
> On 03/05/2018 10:19 PM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  default-configs/alpha-softmmu.mak |  3 +++
>>  hw/alpha/dp264.c                  | 10 ++++------
>>  2 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
>> index 3740adc5e9..bbe361f01a 100644
>> --- a/default-configs/alpha-softmmu.mak
>> +++ b/default-configs/alpha-softmmu.mak
>> @@ -7,6 +7,9 @@ CONFIG_SERIAL_ISA=y
>>  CONFIG_I82374=y
>>  CONFIG_I8254=y
>>  CONFIG_I8257=y
>> +CONFIG_PARALLEL=y
>> +CONFIG_PARALLEL_ISA=y
>> +CONFIG_FDC=y
>>  CONFIG_PCKBD=y
>>  CONFIG_VGA_CIRRUS=y
>>  CONFIG_IDE_CORE=y
>> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
>> index ffad678ea7..80b987f7fb 100644
>> --- a/hw/alpha/dp264.c
>> +++ b/hw/alpha/dp264.c
>> @@ -19,8 +19,7 @@
>>  #include "hw/timer/mc146818rtc.h"
>>  #include "hw/ide.h"
>>  #include "hw/timer/i8254.h"
>> -#include "hw/input/i8042.h"
>> -#include "hw/char/serial.h"
>> +#include "hw/isa/superio.h"
>>  #include "hw/dma/i8257.h"
>>  #include "qemu/cutils.h"
>>  
>> @@ -83,14 +82,10 @@ static void clipper_init(MachineState *machine)
>>      mc146818_rtc_init(isa_bus, 1900, rtc_irq);
>>  
>>      i8254_pit_init(isa_bus, 0x40, 0, NULL);
>> -    isa_create_simple(isa_bus, TYPE_I8042);
>>  
>>      /* VGA setup.  Don't bother loading the bios.  */
>>      pci_vga_init(pci_bus);
>>  
>> -    /* Serial code setup.  */
>> -    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
>> -
>>      /* Network setup.  e1000 is good enough, failing Tulip support.  */
>>      for (i = 0; i < nb_nics; i++) {
>>          pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
>> @@ -99,6 +94,9 @@ static void clipper_init(MachineState *machine)
>>      /* 2 82C37 (dma) */
>>      isa_create_simple(isa_bus, "i82374");
>>  
>> +    /* Super I/O */
>> +    isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
>> +
>>      /* IDE disk setup.  */
>>      {
>>          DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>
> 
> Booting linux with:
> 
> qemu-system-alpha -kernel vmlinux-smp -nographic -append 'console=srm
> printk.time=0'
> 
> diffing the console before/after (master/series):
> 
>   platform rtc-alpha: rtc core: registered rtc-alpha as rtc0
>   Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>   serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> + serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
>   serio: i8042 KBD port at 0x60,0x64 irq 1
>   serio: i8042 AUX port at 0x60,0x64 irq 12
>   mousedev: PS/2 mouse device common for all mice
>   input: AT Translated Set 2 keyboard as
> /devices/platform/i8042/serio0/input/input0
> 
> The only diff is the 2nd uart discovered (ttyS1), since the SMC37C669
> provides 2 (everything else is exactly the same - except the RTC time).
> 
> So alpha-softmmu behaves correctly.

And the "info qtree" diff:

   dev: isabus-bridge, id ""
     bus: isa.0
       type ISA
+      dev: i8042, id ""
+        gpio-out "a20" 1
+        isa irqs 1,12
+      dev: isa-fdc, id ""
+        iobase = 1008 (0x3f0)
+        irq = 6 (0x6)
+        dma = 2 (0x2)
+        driveA = ""
+        driveB = ""
+        check_media_rate = true
+        fdtypeA = "auto"
+        fdtypeB = "auto"
+        fallback = "288"
+        isa irq 6
+        bus: floppy-bus.0
+          type floppy-bus
+          dev: floppy, id ""
+            unit = 0 (0x0)
+            drive = "floppy0"
+            logical_block_size = 512 (0x200)
+            physical_block_size = 512 (0x200)
+            min_io_size = 0 (0x0)
+            opt_io_size = 0 (0x0)
+            discard_granularity = 4294967295 (0xffffffff)
+            write-cache = "auto"
+            share-rw = false
+            drive-type = "288"
+      dev: isa-serial, id ""
+        index = 1 (0x1)
+        iobase = 760 (0x2f8)
+        irq = 3 (0x3)
+        chardev = "discarding-serial1"
+        wakeup = 0 (0x0)
+        isa irq 3
       dev: isa-serial, id ""
         index = 0 (0x0)
         iobase = 1016 (0x3f8)
@@ -13,9 +47,25 @@
         chardev = "serial0"
         wakeup = 0 (0x0)
         isa irq 4
-      dev: i8042, id ""
-        gpio-out "a20" 1
-        isa irqs 1,12
+      dev: isa-parallel, id ""
+        index = 0 (0x0)
+        iobase = 956 (0x3bc)
+        irq = 7 (0x7)
+        chardev = "parallel0"
+        isa irq 7
+      dev: smc37c669-superio, id ""
+      dev: i8257, id ""
+        base = 192 (0xc0)
+        page-base = 136 (0x88)
+        pageh-base = 1160 (0x488)
+        dshift = 1 (0x1)
+      dev: i8257, id ""
+        base = 0 (0x0)
+        page-base = 128 (0x80)
+        pageh-base = 1152 (0x480)
+        dshift = 0 (0x0)
+      dev: i82374, id ""
+        iobase = 1024 (0x400)
       dev: isa-pit, id ""
         gpio-in "" 1
         gpio-out "" 1
         ...


and "info mtree":

     00000801b0000000-00000801bfffffff (prio 0, i/o): dchip0
     00000801f8000000-00000801fbffffff (prio 0, i/o): pci0-iack
     00000801fc000000-00000801fdffffff (prio 0, i/o): pci0-io
+      00000801fc000000-00000801fc000007 (prio 0, i/o): dma-chan
+      00000801fc000008-00000801fc00000f (prio 0, i/o): dma-cont
       00000801fc000020-00000801fc000021 (prio 0, i/o): pic
       00000801fc000040-00000801fc000043 (prio 0, i/o): pit
       00000801fc000060-00000801fc000060 (prio 0, i/o): i8042-data
       00000801fc000064-00000801fc000064 (prio 0, i/o): i8042-cmd
       00000801fc000070-00000801fc000071 (prio 0, i/o): rtc
+      00000801fc000081-00000801fc000083 (prio 0, i/o): dma-page
+      00000801fc000087-00000801fc000087 (prio 0, i/o): dma-page
+      00000801fc000089-00000801fc00008b (prio 0, i/o): dma-page
+      00000801fc00008f-00000801fc00008f (prio 0, i/o): dma-page
       00000801fc0000a0-00000801fc0000a1 (prio 0, i/o): pic
+      00000801fc0000c0-00000801fc0000cf (prio 0, i/o): dma-chan
+      00000801fc0000d0-00000801fc0000df (prio 0, i/o): dma-cont
+      00000801fc0002f8-00000801fc0002ff (prio 0, i/o): serial
       00000801fc0003b0-00000801fc0003df (prio 0, i/o): cirrus-io
+      00000801fc0003bc-00000801fc0003c3 (prio 0, i/o): parallel
+      00000801fc0003f1-00000801fc0003f5 (prio 0, i/o): fdc
+      00000801fc0003f7-00000801fc0003f7 (prio 0, i/o): fdc
       00000801fc0003f8-00000801fc0003ff (prio 0, i/o): serial
+      00000801fc00040a-00000801fc00040a (prio 0, i/o): i82374
+      00000801fc000410-00000801fc00043f (prio 0, i/o): i82374
+      00000801fc000481-00000801fc000483 (prio 0, i/o): dma-pageh
+      00000801fc000487-00000801fc000489 (prio 0, i/o): dma-pageh
+      00000801fc000489-00000801fc00048b (prio 0, i/o): dma-pageh
+      00000801fc00048f-00000801fc000491 (prio 0, i/o): dma-pageh
       00000801fc0004d0-00000801fc0004d0 (prio 0, i/o): elcr
       00000801fc0004d1-00000801fc0004d1 (prio 0, i/o): elcr
     00000801fe000000-00000801feffffff (prio 0, i/o): pci0-conf
     ...
