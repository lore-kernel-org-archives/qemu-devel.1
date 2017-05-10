Received: from eggs.gnu.org ([2001:4830:134:3::10]:36113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8WNk-0006oc-Fp
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8WNh-0001TF-DA
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:30:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d8WNh-0001T4-7D
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:30:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17C1E80461
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 18:30:36 +0000 (UTC)
Date: Wed, 10 May 2017 21:30:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170510213008-mutt-send-email-mst@kernel.org>
References: <1494309644-18743-1-git-send-email-peterx@redhat.com>
	<1494309644-18743-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494309644-18743-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] msix: trace control bit write op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, May 09, 2017 at 02:00:43PM +0800, Peter Xu wrote:
> Meanwhile, abstract a function to detect msix masked bit.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  hw/pci/msix.c       | 11 +++++++++--
>  hw/pci/trace-events |  3 +++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index bb54e8b..fc5fe51 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -22,6 +22,7 @@
>  #include "hw/xen/xen.h"
>  #include "qemu/range.h"
>  #include "qapi/error.h"
> +#include "trace.h"
>  
>  #define MSIX_CAP_LENGTH 12
>  
> @@ -130,10 +131,14 @@ static void msix_handle_mask_update(PCIDevice *dev, int vector, bool was_masked)
>      }
>  }
>  
> +static bool msix_masked(PCIDevice *dev)
> +{
> +    return dev->config[dev->msix_cap + MSIX_CONTROL_OFFSET] & MSIX_MASKALL_MASK;
> +}
> +
>  static void msix_update_function_masked(PCIDevice *dev)
>  {
> -    dev->msix_function_masked = !msix_enabled(dev) ||
> -        (dev->config[dev->msix_cap + MSIX_CONTROL_OFFSET] & MSIX_MASKALL_MASK);
> +    dev->msix_function_masked = !msix_enabled(dev) || msix_masked(dev);
>  }
>  
>  /* Handle MSI-X capability config write. */
> @@ -148,6 +153,8 @@ void msix_write_config(PCIDevice *dev, uint32_t addr,
>          return;
>      }
>  
> +    trace_msix_write_config(dev->name, msix_enabled(dev), msix_masked(dev));
> +
>      was_masked = dev->msix_function_masked;
>      msix_update_function_masked(dev);
>  
> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> index 2b9cf24..83c8f5a 100644
> --- a/hw/pci/trace-events
> +++ b/hw/pci/trace-events
> @@ -7,3 +7,6 @@ pci_update_mappings_add(void *d, uint32_t bus, uint32_t slot, uint32_t func, int
>  # hw/pci/pci_host.c
>  pci_cfg_read(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @0x%x -> 0x%x"
>  pci_cfg_write(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @0x%x <- 0x%x"
> +
> +# hw/pci/msix.c
> +msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d masked %d"
> -- 
> 2.7.4
