Received: from eggs.gnu.org ([209.51.188.92]:52313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBzMw-0003VX-T2
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBzMv-00035M-NE
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:13:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hBzMv-00032y-Bq
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:13:13 -0400
Date: Thu, 4 Apr 2019 12:13:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190404121308.2509a559@redhat.com>
In-Reply-To: <20190402161900.7374-3-armbru@redhat.com>
References: <20190402161900.7374-1-armbru@redhat.com>
	<20190402161900.7374-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] acpi/pcihp: Convert debug printf()s to
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com

On Tue,  2 Apr 2019 18:18:59 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/pcihp.c      | 25 ++++++++-----------------
>  hw/acpi/trace-events |  9 +++++++++
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 88e4ae1bcd..7729c5338b 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -37,14 +37,7 @@
>  #include "hw/pci/pci_bus.h"
>  #include "qapi/error.h"
>  #include "qom/qom-qobject.h"
> -
> -//#define DEBUG
> -
> -#ifdef DEBUG
> -# define ACPI_PCIHP_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
> -#else
> -# define ACPI_PCIHP_DPRINTF(format, ...)     do { } while (0)
> -#endif
> +#include "trace.h"
>  
>  #define ACPI_PCIHP_ADDR 0xae00
>  #define ACPI_PCIHP_SIZE 0x0014
> @@ -306,23 +299,23 @@ static uint64_t pci_read(void *opaque, hwaddr addr, unsigned int size)
>          if (!s->legacy_piix) {
>              s->acpi_pcihp_pci_status[bsel].up = 0;
>          }
> -        ACPI_PCIHP_DPRINTF("pci_up_read %" PRIu32 "\n", val);
> +        trace_acpi_pci_up_read(val);
>          break;
>      case PCI_DOWN_BASE:
>          val = s->acpi_pcihp_pci_status[bsel].down;
> -        ACPI_PCIHP_DPRINTF("pci_down_read %" PRIu32 "\n", val);
> +        trace_acpi_pci_down_read(val);
>          break;
>      case PCI_EJ_BASE:
>          /* No feature defined yet */
> -        ACPI_PCIHP_DPRINTF("pci_features_read %" PRIu32 "\n", val);
> +        trace_acpi_pci_features_read(val);
>          break;
>      case PCI_RMV_BASE:
>          val = s->acpi_pcihp_pci_status[bsel].hotplug_enable;
> -        ACPI_PCIHP_DPRINTF("pci_rmv_read %" PRIu32 "\n", val);
> +        trace_acpi_pci_rmv_read(val);
>          break;
>      case PCI_SEL_BASE:
>          val = s->hotplug_select;
> -        ACPI_PCIHP_DPRINTF("pci_sel_read %" PRIu32 "\n", val);
> +        trace_acpi_pci_sel_read(val);
>      default:
>          break;
>      }
> @@ -340,13 +333,11 @@ static void pci_write(void *opaque, hwaddr addr, uint64_t data,
>              break;
>          }
>          acpi_pcihp_eject_slot(s, s->hotplug_select, data);
> -        ACPI_PCIHP_DPRINTF("pciej write %" HWADDR_PRIx " <== %" PRIu64 "\n",
> -                      addr, data);
> +        trace_acpi_pci_ej_write(addr, data);
>          break;
>      case PCI_SEL_BASE:
>          s->hotplug_select = s->legacy_piix ? ACPI_PCIHP_BSEL_DEFAULT : data;
> -        ACPI_PCIHP_DPRINTF("pcisel write %" HWADDR_PRIx " <== %" PRIu64 "\n",
> -                      addr, data);
> +        trace_acpi_pci_sel_write(addr, data);
>      default:
>          break;
>      }
> diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
> index 825b25cbb0..98a56baa6f 100644
> --- a/hw/acpi/trace-events
> +++ b/hw/acpi/trace-events
> @@ -31,6 +31,15 @@ cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
>  cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
>  cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
>  
> +# pcihp.c
> +acpi_pci_up_read(uint32_t val) "%" PRIu32
> +acpi_pci_down_read(uint32_t val) "%" PRIu32
> +acpi_pci_features_read(uint32_t val) "%" PRIu32
> +acpi_pci_rmv_read(uint32_t val) "%" PRIu32
> +acpi_pci_sel_read(uint32_t val) "%" PRIu32
> +acpi_pci_ej_write(uint64_t addr, uint64_t data) "0x%" PRIx64 " <== %" PRIu64
> +acpi_pci_sel_write(uint64_t addr, uint64_t data) "0x%" PRIx64 " <== %" PRIu64
> +
>  # piix4.c
>  piix4_gpe_readb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d ==> 0x%" PRIx64
>  piix4_gpe_writeb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d <== 0x%" PRIx64
