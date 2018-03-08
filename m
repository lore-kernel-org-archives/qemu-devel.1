Received: from eggs.gnu.org ([2001:4830:134:3::10]:33230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu2KW-0002Vc-G7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu2KT-00070O-A7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:40:00 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu2KT-00070E-2J
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:39:57 -0500
Received: by mail-wr0-x243.google.com with SMTP id v18so6998964wrv.0
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 12:39:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180305211928.466-1-f4bug@amsat.org>
	<20180305211928.466-22-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db2026ea-9bfe-b464-6f90-2d1badc08e73@amsat.org>
Date: Thu, 8 Mar 2018 21:39:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180305211928.466-22-f4bug@amsat.org>
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

On 03/05/2018 10:19 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  default-configs/alpha-softmmu.mak |  3 +++
>  hw/alpha/dp264.c                  | 10 ++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
> index 3740adc5e9..bbe361f01a 100644
> --- a/default-configs/alpha-softmmu.mak
> +++ b/default-configs/alpha-softmmu.mak
> @@ -7,6 +7,9 @@ CONFIG_SERIAL_ISA=y
>  CONFIG_I82374=y
>  CONFIG_I8254=y
>  CONFIG_I8257=y
> +CONFIG_PARALLEL=y
> +CONFIG_PARALLEL_ISA=y
> +CONFIG_FDC=y
>  CONFIG_PCKBD=y
>  CONFIG_VGA_CIRRUS=y
>  CONFIG_IDE_CORE=y
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index ffad678ea7..80b987f7fb 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -19,8 +19,7 @@
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/ide.h"
>  #include "hw/timer/i8254.h"
> -#include "hw/input/i8042.h"
> -#include "hw/char/serial.h"
> +#include "hw/isa/superio.h"
>  #include "hw/dma/i8257.h"
>  #include "qemu/cutils.h"
>  
> @@ -83,14 +82,10 @@ static void clipper_init(MachineState *machine)
>      mc146818_rtc_init(isa_bus, 1900, rtc_irq);
>  
>      i8254_pit_init(isa_bus, 0x40, 0, NULL);
> -    isa_create_simple(isa_bus, TYPE_I8042);
>  
>      /* VGA setup.  Don't bother loading the bios.  */
>      pci_vga_init(pci_bus);
>  
> -    /* Serial code setup.  */
> -    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
> -
>      /* Network setup.  e1000 is good enough, failing Tulip support.  */
>      for (i = 0; i < nb_nics; i++) {
>          pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
> @@ -99,6 +94,9 @@ static void clipper_init(MachineState *machine)
>      /* 2 82C37 (dma) */
>      isa_create_simple(isa_bus, "i82374");
>  
> +    /* Super I/O */
> +    isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
> +
>      /* IDE disk setup.  */
>      {
>          DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> 

Booting linux with:

qemu-system-alpha -kernel vmlinux-smp -nographic -append 'console=srm
printk.time=0'

diffing the console before/after (master/series):

  platform rtc-alpha: rtc core: registered rtc-alpha as rtc0
  Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
  serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
+ serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
  serio: i8042 KBD port at 0x60,0x64 irq 1
  serio: i8042 AUX port at 0x60,0x64 irq 12
  mousedev: PS/2 mouse device common for all mice
  input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0

The only diff is the 2nd uart discovered (ttyS1), since the SMC37C669
provides 2 (everything else is exactly the same - except the RTC time).

So alpha-softmmu behaves correctly.
