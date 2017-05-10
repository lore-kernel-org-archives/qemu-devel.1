Received: from eggs.gnu.org ([2001:4830:134:3::10]:52981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8P6x-0002k5-2r
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8P6t-0003S3-6D
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:44:51 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8P6t-0003Rz-1m
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:44:47 -0400
Received: by mail-qk0-x241.google.com with SMTP id k74so4009936qke.2
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 03:44:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1494309644-18743-1-git-send-email-peterx@redhat.com>
	<1494309644-18743-3-git-send-email-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3b81dd1e-7a9b-280f-c915-815c1913a181@amsat.org>
Date: Wed, 10 May 2017 07:44:43 -0300
MIME-Version: 1.0
In-Reply-To: <1494309644-18743-3-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] msix: trace control bit write op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 05/09/2017 03:00 AM, Peter Xu wrote:
> Meanwhile, abstract a function to detect msix masked bit.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
