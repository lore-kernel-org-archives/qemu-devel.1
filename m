Received: from eggs.gnu.org ([2001:4830:134:3::10]:58986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dNObN-0007hz-N2
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 15:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dNObJ-0006r4-0y
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 15:14:13 -0400
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-4-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <0626525d-c955-fa5f-0a72-aea2b029c4ec@redhat.com>
Date: Tue, 20 Jun 2017 21:14:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170620015332.13874-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/5] spapr: Add DRC release
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com
Cc: sursingh@redhat.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com

On 20/06/2017 03:53, David Gibson wrote:
> At the moment, spapr_drc_release() has an ugly switch on the DRC type to
> call the right, device-specific release function.  This cleans it up by
> doing that via a proper QOM method.
> 
> It's still arguably an abstraction violation for the DRC code to call into
> the specific device code, but one mess at a time.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  hw/ppc/spapr_drc.c         | 22 ++++++----------------
>  include/hw/ppc/spapr_drc.h |  1 +
>  2 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index e5dff16..32e39f2 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -370,22 +370,9 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>  
>  static void spapr_drc_release(sPAPRDRConnector *drc)
>  {
> -    /* Calling release callbacks based on spapr_drc_type(drc). */
> -    switch (spapr_drc_type(drc)) {
> -    case SPAPR_DR_CONNECTOR_TYPE_CPU:
> -        spapr_core_release(drc->dev);
> -        break;
> -    case SPAPR_DR_CONNECTOR_TYPE_PCI:
> -        spapr_phb_remove_pci_device_cb(drc->dev);
> -        break;
> -    case SPAPR_DR_CONNECTOR_TYPE_LMB:
> -        spapr_lmb_release(drc->dev);
> -        break;
> -    case SPAPR_DR_CONNECTOR_TYPE_PHB:
> -    case SPAPR_DR_CONNECTOR_TYPE_VIO:
> -    default:
> -        g_assert(false);
> -    }
> +    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +
> +    drck->release(drc->dev);
>  
>      drc->awaiting_release = false;
>      g_free(drc->fdt);
> @@ -629,6 +616,7 @@ static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
>      drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_CPU;
>      drck->typename = "CPU";
>      drck->drc_name_prefix = "CPU ";
> +    drck->release = spapr_core_release;
>  }
>  
>  static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
> @@ -638,6 +626,7 @@ static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
>      drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI;
>      drck->typename = "28";
>      drck->drc_name_prefix = "C";
> +    drck->release = spapr_phb_remove_pci_device_cb;
>  }
>  
>  static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
> @@ -647,6 +636,7 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
>      drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB;
>      drck->typename = "MEM";
>      drck->drc_name_prefix = "LMB ";
> +    drck->release = spapr_lmb_release;
>  }
>  
>  static const TypeInfo spapr_dr_connector_info = {
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index d9cacb3..6fd84d1 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -217,6 +217,7 @@ typedef struct sPAPRDRConnectorClass {
>      sPAPRDREntitySense (*dr_entity_sense)(sPAPRDRConnector *drc);
>      uint32_t (*isolate)(sPAPRDRConnector *drc);
>      uint32_t (*unisolate)(sPAPRDRConnector *drc);
> +    void (*release)(DeviceState *dev);
>  
>      /* QEMU interfaces for managing hotplug operations */
>      bool (*release_pending)(sPAPRDRConnector *drc);
> 
