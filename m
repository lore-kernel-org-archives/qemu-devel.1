Received: from eggs.gnu.org ([2001:4830:134:3::10]:41960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFgLB-0001iU-69
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFgLA-0005jc-58
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:38:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180506142005.19580-1-mark.cave-ayland@ilande.co.uk>
	<20180506142005.19580-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <102bdafc-e2ef-cced-536c-e018179d97db@amsat.org>
Date: Mon, 7 May 2018 10:38:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180506142005.19580-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] uninorth: remove token register from
 uninorth device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 05/06/2018 11:20 AM, Mark Cave-Ayland wrote:
> From observation of various OS sources it can be seen that the token register
> introduced in 4e46dcdbd3 "PPC: Newworld: Add uninorth token register" is not
> required, since the only register currently implemented is the uninorth hardware
> version which is read-only.
> 
> Remove the token register implementation and instead return the uninorth
> version corresponding to the hardware.

Thanks for this cleanup :)

> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/uninorth.c         | 11 +++++------
>  include/hw/pci-host/uninorth.h |  4 +++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index a658f9230a..abebfaf755 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -524,19 +524,18 @@ static void unin_write(void *opaque, hwaddr addr, uint64_t value,
>                         unsigned size)
>  {
>      trace_unin_write(addr, value);
> -    if (addr == 0x0) {
> -        *(int *)opaque = value;
> -    }
>  }
>  
>  static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      uint32_t value;
>  
> -    value = 0;
>      switch (addr) {
>      case 0:
> -        value = *(int *)opaque;
> +        value = UNINORTH_VERSION_10A;
> +        break;
> +    default:
> +        value = 0;
>      }
>  
>      trace_unin_read(addr, value);
> @@ -559,7 +558,7 @@ static void unin_init(Object *obj)
>      UNINState *s = UNI_NORTH(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>  
> -    memory_region_init_io(&s->mem, obj, &unin_ops, &s->token, "unin", 0x1000);
> +    memory_region_init_io(&s->mem, obj, &unin_ops, s, "unin", 0x1000);
>  
>      sysbus_init_mmio(sbd, &s->mem);
>  }
> diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
> index f6654bad9b..2a1cf9f284 100644
> --- a/include/hw/pci-host/uninorth.h
> +++ b/include/hw/pci-host/uninorth.h
> @@ -29,6 +29,9 @@
>  
>  #include "hw/ppc/openpic.h"
>  
> +/* UniNorth version */
> +#define UNINORTH_VERSION_10A    0x7
> +
>  #define TYPE_UNI_NORTH_PCI_HOST_BRIDGE "uni-north-pci-pcihost"
>  #define TYPE_UNI_NORTH_AGP_HOST_BRIDGE "uni-north-agp-pcihost"
>  #define TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE "uni-north-internal-pci-pcihost"
> @@ -57,7 +60,6 @@ typedef struct UNINState {
>      SysBusDevice parent_obj;
>  
>      MemoryRegion mem;
> -    int token[1];
>  } UNINState;
>  
>  #define TYPE_UNI_NORTH "uni-north"
> 
