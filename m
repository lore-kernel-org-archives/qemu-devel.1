Received: from eggs.gnu.org ([2001:4830:134:3::10]:42413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1crXRh-0004Yi-2u
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1crXRf-0002tp-FI
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1crXRf-0002tc-5b
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:31 -0400
Date: Fri, 24 Mar 2017 16:12:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170324161228.73f7ac0f@t450s.home>
In-Reply-To: <1490260163-6157-3-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1490260163-6157-3-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] vfio pci: new function to init AER
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, mst@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

On Thu, 23 Mar 2017 17:09:22 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

This is not a sufficiently trivial patch to leave the commit log empty.

> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/vfio/pci.c | 41 ++++++++++++++++++++++++++++++++++++-----
>  hw/vfio/pci.h |  1 +
>  2 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 332f41d..3d0d005 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1855,18 +1855,42 @@ out:
>      return 0;
>  }
>  
> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> +static int vfio_setup_aer(VFIOPCIDevice *vdev, uint8_t cap_ver,
> +                          int pos, uint16_t size, Error **errp)
> +{
> +    PCIDevice *pdev = &vdev->pdev;
> +    uint32_t errcap;
> +
> +    errcap = vfio_pci_read_config(pdev, pos + PCI_ERR_CAP, 4);
> +    /*
> +     * The ability to record multiple headers is depending on
> +     * the state of the Multiple Header Recording Capable bit and
> +     * enabled by the Multiple Header Recording Enable bit.
> +     */
> +    if ((errcap & PCI_ERR_CAP_MHRC) &&
> +        (errcap & PCI_ERR_CAP_MHRE)) {
> +        pdev->exp.aer_log.log_max = PCIE_AER_LOG_MAX_DEFAULT;
> +    } else {
> +        pdev->exp.aer_log.log_max = 0;
> +    }
> +
> +    pcie_cap_deverr_init(pdev);

This assumes we've set exp_cap, perhaps the code should validate this
to avoid corner case configurations where the PCIe cap has been dropped
yet AER is still present.  I'm not sure if it's possible, but I'd
rather test than segfault.

> +    return pcie_aer_init(pdev, cap_ver, pos, size, errp);


I think here too, users may have existing configurations that could
break by suddenly imposing a new topology requirement.


> +}
> +
> +static int vfio_add_ext_cap(VFIOPCIDevice *vdev, Error **errp)
>  {
>      PCIDevice *pdev = &vdev->pdev;
>      uint32_t header;
>      uint16_t cap_id, next, size;
>      uint8_t cap_ver;
>      uint8_t *config;
> +    int ret = 0;
>  
>      /* Only add extended caps if we have them and the guest can see them */
>      if (!pci_is_express(pdev) || !pci_bus_is_express(pdev->bus) ||
>          !pci_get_long(pdev->config + PCI_CONFIG_SPACE_SIZE)) {
> -        return;
> +        return 0;
>      }
>  
>      /*
> @@ -1915,6 +1939,9 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>                                     PCI_EXT_CAP_NEXT_MASK);
>  
>          switch (cap_id) {
> +        case PCI_EXT_CAP_ID_ERR:
> +            ret = vfio_setup_aer(vdev, cap_ver, next, size, errp);
> +            break;
>          case PCI_EXT_CAP_ID_SRIOV: /* Read-only VF BARs confuse OVMF */
>          case PCI_EXT_CAP_ID_ARI: /* XXX Needs next function virtualization */
>              trace_vfio_add_ext_cap_dropped(vdev->vbasedev.name, cap_id, next);
> @@ -1923,6 +1950,9 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>              pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>          }
>  
> +        if (ret) {
> +            goto out;
> +        }
>      }
>  
>      /* Cleanup chain head ID if necessary */
> @@ -1930,8 +1960,9 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>          pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
>      }
>  
> +out:
>      g_free(config);
> -    return;
> +    return ret;
>  }
>  
>  static int vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
> @@ -1949,8 +1980,8 @@ static int vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>          return ret;
>      }
>  
> -    vfio_add_ext_cap(vdev);
> -    return 0;
> +    ret = vfio_add_ext_cap(vdev, errp);
> +    return ret;

return vfio_add_ext_cap(vdev, errp);

>  }
>  
>  static void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a8366bb..34e8b04 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -15,6 +15,7 @@
>  #include "qemu-common.h"
>  #include "exec/memory.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "hw/vfio/vfio-common.h"
>  #include "qemu/event_notifier.h"
>  #include "qemu/queue.h"
