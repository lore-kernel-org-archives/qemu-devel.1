Received: from eggs.gnu.org ([2001:4830:134:3::10]:43391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dNLf9-0000gA-Kc
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dNLf0-0001X6-6n
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:05:55 -0400
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-2-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <7c20ed8a-10f1-5983-77df-6d44affa9039@redhat.com>
Date: Tue, 20 Jun 2017 18:05:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170620015332.13874-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/5] spapr: Leave DR-indicator
 management to the guest
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
> The DR-indicator is essentially a "virtual LED" attached to a hotpluggable
> device, which the guest can set to various states for the attention of
> the operator or management layers.
> 
> It's mostly guest managed, except that we once-off set it to
> ACTIVE/INACTIVE in the attach/detach path.  While that makes certain sense,
> there's no indication in PAPR that the hypervisor should do this, and the
> drmgr code on the guest side doesn't appear to need it (it will already set
> the indicator to ACTIVE on hotplug, and INACTIVE on remove).
> 
> So, leave the DR-indicator entirely to the guest; the only thing we need
> to do is ensure it's in a sane state on reset.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_drc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index fd9e07d..0bc9046 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -353,8 +353,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>      }
>      g_assert(fdt || coldplug);
>  
> -    drc->dr_indicator = SPAPR_DR_INDICATOR_ACTIVE;
> -
>      drc->dev = d;
>      drc->fdt = fdt;
>      drc->fdt_start_offset = fdt_start_offset;
> @@ -372,8 +370,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>  
>  static void spapr_drc_release(sPAPRDRConnector *drc)
>  {
> -    drc->dr_indicator = SPAPR_DR_INDICATOR_INACTIVE;
> -
>      /* Calling release callbacks based on spapr_drc_type(drc). */
>      switch (spapr_drc_type(drc)) {
>      case SPAPR_DR_CONNECTOR_TYPE_CPU:
> @@ -452,12 +448,14 @@ static void reset(DeviceState *d)
>          if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
>              drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
>          }
> +        drc->dr_indicator = SPAPR_DR_INDICATOR_ACTIVE;
>      } else {
>          /* Otherwise device is absent, but might be hotplugged */
>          drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
>          if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
>              drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
>          }
> +        drc->dr_indicator = SPAPR_DR_INDICATOR_INACTIVE;
>      }
>  }
>  
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
