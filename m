Received: from eggs.gnu.org ([209.51.188.92]:45243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3RI-0000Td-7c
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3RG-0006Gw-Vn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:58:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3RG-0006Ci-OE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:58:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so3172028wmf.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 14:58:53 -0700 (PDT)
References: <20180106153730.30313-1-hpoussin@reactos.org>
	<20180106153730.30313-13-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f6179552-cc21-0935-ddea-7bbdeecddac3@redhat.com>
Date: Tue, 23 Apr 2019 23:58:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180106153730.30313-13-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 12/16] piix4: add a mc146818rtc
 controller as specified in datasheet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

Hi Hervé,

I haven't forgot this series (still 15 months passed...) and it is now
integrated in a bigger one. While retesting the whole previous to post,
I noticed an error...

On 1/6/18 4:37 PM, Hervé Poussineau wrote:
> Remove mc146818rtc instanciated in malta board, to not have it twice.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  hw/isa/piix4.c       | 12 ++++++++++++
>  hw/mips/mips_malta.c |  5 -----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 7a13e83270..0d68fcb193 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -31,6 +31,7 @@
>  #include "hw/char/isa.h"
>  #include "hw/sysbus.h"
>  #include "hw/timer/i8254.h"
> +#include "hw/timer/mc146818rtc.h"
>  #include "qapi/error.h"
>  
>  PCIDevice *piix4_dev;
> @@ -43,6 +44,7 @@ typedef struct PIIX4State {
>      FDCtrlISABus floppy;
>      ISASerialState serial[2];
>      ISAParallelState parallel;
> +    RTCState rtc;
>  
>      /* Reset Control Register */
>      MemoryRegion rcr_mem;
> @@ -217,6 +219,15 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
>          return;
>      }
>  
> +    /* timer */
> +    qdev_set_parent_bus(DEVICE(&s->rtc), BUS(isa_bus));

... here. You don't set the "base_year" property.
If unset, the default of 1980 is used.
However ...

> +    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    isa_init_irq(ISA_DEVICE(&s->rtc), &s->rtc.irq, RTC_ISA_IRQ);
> +
>      piix4_dev = pci_dev;
>      qemu_register_reset(piix4_reset, s);
>  }
> @@ -231,6 +242,7 @@ static void piix4_init(Object *obj)
>          object_initialize(&s->serial[i], sizeof(s->serial[i]), TYPE_ISA_SERIAL);
>      }
>      object_initialize(&s->parallel, sizeof(s->parallel), TYPE_ISA_PARALLEL);
> +    object_initialize(&s->rtc, sizeof(s->rtc), TYPE_MC146818_RTC);
>  
>      object_property_add_alias(obj, "floppy", OBJECT(&s->floppy), "driveA",
>                                &error_abort);
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 30fb30fc0e..3d304a6e0a 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -995,7 +995,6 @@ void mips_malta_init(MachineState *machine)
>      uint8_t *smbus_eeprom_buf = g_malloc0(smbus_eeprom_size);
>      int64_t kernel_entry, bootloader_run_addr;
>      PCIBus *pci_bus;
> -    ISABus *isa_bus;
>      qemu_irq cbus_irq, i8259_irq;
>      PCIDevice *pci;
>      int piix4_devfn;
> @@ -1197,7 +1196,6 @@ void mips_malta_init(MachineState *machine)
>      qdev_prop_set_chr(dev, "parallel", parallel_hds[0]);
>  
>      qdev_init_nofail(dev);
> -    isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>      piix4_devfn = pci->devfn;
>  
>      /* Interrupt controller */
> @@ -1213,9 +1211,6 @@ void mips_malta_init(MachineState *machine)
>      smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
>      g_free(smbus_eeprom_buf);
>  
> -    /* Super I/O */
> -    mc146818_rtc_init(isa_bus, 2000, NULL);

... here it is set to 2000.
The same value is used in the PC machine (which uses the PIIX3).

> -
>      /* Network card */
>      network_init(pci_bus);
>  
> 

I'll amend this snippet to your patch:

-- >8 --
     /* RTC */
     qdev_set_parent_bus(DEVICE(&s->rtc), BUS(isa_bus));
+    qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
     object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
--

Paolo/Michael: I'll keep your Acked-by, I hope you are OK with that.

Regards,

Phil.
