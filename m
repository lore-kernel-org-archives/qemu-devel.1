Received: from eggs.gnu.org ([2001:4830:134:3::10]:58267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYBId-0006EK-OP
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 08:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYBIZ-00068s-9M
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 08:47:43 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYBIZ-00068S-5P
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 08:47:39 -0500
Received: by mail-qt0-x241.google.com with SMTP id r39so10832221qtr.13
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 05:47:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180107123224.100877-1-marcel@redhat.com>
	<20180107123224.100877-2-marcel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d0cfcb3f-7589-2233-ff76-bd7bb0ea4bfb@amsat.org>
Date: Sun, 7 Jan 2018 10:47:33 -0300
MIME-Version: 1.0
In-Reply-To: <20180107123224.100877-2-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V6 1/5] pci/shpc: Move function to generic
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, cohuck@redhat.com, yuval.shaia@oracle.com, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

Hi Marcel,

On 01/07/2018 09:32 AM, Marcel Apfelbaum wrote:
> From: Yuval Shaia <yuval.shaia@oracle.com>
> 
> This function should be declared in generic header file so we can
> utilize it.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/pci/shpc.c             | 13 ++-----------
>  include/qemu/host-utils.h | 10 ++++++++++
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> index 69fc14b218..a8462d48bb 100644
> --- a/hw/pci/shpc.c
> +++ b/hw/pci/shpc.c
> @@ -1,6 +1,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> +#include "qemu/host-utils.h"
>  #include "qemu/range.h"
>  #include "qemu/error-report.h"
>  #include "hw/pci/shpc.h"
> @@ -122,16 +123,6 @@
>  #define SHPC_PCI_TO_IDX(pci_slot) ((pci_slot) - 1)
>  #define SHPC_IDX_TO_PHYSICAL(slot) ((slot) + 1)
>  
> -static int roundup_pow_of_two(int x)
> -{
> -    x |= (x >> 1);
> -    x |= (x >> 2);
> -    x |= (x >> 4);
> -    x |= (x >> 8);
> -    x |= (x >> 16);
> -    return x + 1;
> -}
> -
>  static uint16_t shpc_get_status(SHPCDevice *shpc, int slot, uint16_t msk)
>  {
>      uint8_t *status = shpc->config + SHPC_SLOT_STATUS(slot);
> @@ -656,7 +647,7 @@ int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar,
>  
>  int shpc_bar_size(PCIDevice *d)
>  {
> -    return roundup_pow_of_two(SHPC_SLOT_REG(SHPC_MAX_SLOTS));
> +    return pow2roundup32(SHPC_SLOT_REG(SHPC_MAX_SLOTS));
>  }
>  
>  void shpc_cleanup(PCIDevice *d, MemoryRegion *bar)
> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> index 5ac621cf1f..9fadb3f1ba 100644
> --- a/include/qemu/host-utils.h
> +++ b/include/qemu/host-utils.h
> @@ -400,6 +400,16 @@ static inline uint64_t pow2ceil(uint64_t value)
>      return 0x8000000000000000ull >> (n - 1);
>  }
>  
> +static inline int pow2roundup32(int x)

Can you change the type?

static inline uint32_t pow2roundup32(uint32_t value)

Then:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +{
> +    x |= (x >> 1);
> +    x |= (x >> 2);
> +    x |= (x >> 4);
> +    x |= (x >> 8);
> +    x |= (x >> 16);
> +    return x + 1;
> +}
> +
>  /**
>   * urshift - 128-bit Unsigned Right Shift.
>   * @plow: in/out - lower 64-bit integer.
> 
