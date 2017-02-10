Received: from eggs.gnu.org ([2001:4830:134:3::10]:52132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccBMW-0005D7-Ol
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccBMV-00078e-SZ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:35:44 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170210092724.6470-1-lvivier@redhat.com>
	<20170210092724.6470-3-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <25726fc5-e002-90ea-4f7f-6c2ef1085934@amsat.org>
Date: Fri, 10 Feb 2017 10:35:37 -0300
MIME-Version: 1.0
In-Reply-To: <20170210092724.6470-3-lvivier@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] ppc4xx: replace debug printf with
 trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 02/10/2017 06:27 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/ppc4xx_pci.c | 13 +++----------
>  hw/ppc/trace-events |  4 ++++
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index 683218e..dc19682 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -26,13 +26,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_host.h"
>  #include "exec/address-spaces.h"
> -
> -#undef DEBUG
> -#ifdef DEBUG
> -#define DPRINTF(fmt, ...) do { printf(fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...)
> -#endif /* DEBUG */
> +#include "trace.h"
>
>  struct PCIMasterMap {
>      uint32_t la;
> @@ -249,8 +243,7 @@ static int ppc4xx_pci_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
>      int slot = pci_dev->devfn >> 3;
>
> -    DPRINTF("%s: devfn %x irq %d -> %d\n", __func__,
> -            pci_dev->devfn, irq_num, slot);
> +    trace_ppc4xx_pci_map_irq(pci_dev->devfn, irq_num, slot);
>
>      return slot - 1;
>  }
> @@ -259,7 +252,7 @@ static void ppc4xx_pci_set_irq(void *opaque, int irq_num, int level)
>  {
>      qemu_irq *pci_irqs = opaque;
>
> -    DPRINTF("%s: PCI irq %d\n", __func__, irq_num);
> +    trace_ppc4xx_pci_set_irq(irq_num);
>      if (irq_num < 0) {
>          fprintf(stderr, "%s: PCI irq %d\n", __func__, irq_num);
>          return;
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 6122a12..f04bb1d 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -89,3 +89,7 @@ rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
>  # hw/ppc/mac_newworld.c
>  mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
>  mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
> +
> +# hw/ppc/ppc4xx_pci.c
> +ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn %x irq %d -> %d"
> +ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
>
