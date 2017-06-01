Received: from eggs.gnu.org ([2001:4830:134:3::10]:50585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dGRmk-0006sj-En
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dGRmh-00041V-At
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:13:14 -0400
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601015218.9299-4-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <9cfc59ea-fa21-69e4-e6e3-58a7d8c8d76a@redhat.com>
Date: Thu, 1 Jun 2017 17:13:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170601015218.9299-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] spapr: Abolish DRC set_configured
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
Cc: nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com

On 01/06/2017 03:52, David Gibson wrote:
> DRConnectorClass has a set_configured method, however:
>   * There is only one implementation, and only ever likely to be one
>   * There's exactly one caller, and that's (now) local
>   * The implementation is very straightforward
> 
> So abolish the method entirely, and just open-code what we need.  We also
> remove the tracepoints associated with it, since they don't look to be
> terribly useful.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  hw/ppc/spapr_drc.c         | 20 ++++----------------
>  hw/ppc/trace-events        |  2 --
>  include/hw/ppc/spapr_drc.h |  3 ---
>  3 files changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index f5b7b68..025453b 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -199,18 +199,6 @@ static const char *get_name(sPAPRDRConnector *drc)
>      return drc->name;
>  }
>  
> -static void set_configured(sPAPRDRConnector *drc)
> -{
> -    trace_spapr_drc_set_configured(get_index(drc));
> -
> -    if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
> -        /* guest should be not configuring an isolated device */
> -        trace_spapr_drc_set_configured_skipping(get_index(drc));
> -        return;
> -    }
> -    drc->configured = true;
> -}
> -
>  /* has the guest been notified of device attachment? */
>  static void set_signalled(sPAPRDRConnector *drc)
>  {
> @@ -745,7 +733,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
>      drck->get_index = get_index;
>      drck->get_type = get_type;
>      drck->get_name = get_name;
> -    drck->set_configured = set_configured;
>      drck->entity_sense = entity_sense;
>      drck->attach = attach;
>      drck->detach = detach;
> @@ -1113,7 +1100,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
>      uint64_t wa_offset;
>      uint32_t drc_index;
>      sPAPRDRConnector *drc;
> -    sPAPRDRConnectorClass *drck;
>      sPAPRConfigureConnectorState *ccs;
>      sPAPRDRCCResponse resp = SPAPR_DR_CC_RESPONSE_CONTINUE;
>      int rc;
> @@ -1133,7 +1119,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
>          goto out;
>      }
>  
> -    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>      if (!drc->fdt) {
>          trace_spapr_rtas_ibm_configure_connector_missing_fdt(drc_index);
>          rc = SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
> @@ -1170,10 +1155,13 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
>          case FDT_END_NODE:
>              ccs->fdt_depth--;
>              if (ccs->fdt_depth == 0) {
> +                sPAPRDRIsolationState state = drc->isolation_state;
>                  /* done sending the device tree, don't need to track
>                   * the state anymore
>                   */
> -                drck->set_configured(drc);
> +                if (state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
> +                    drc->configured = true;
> +                }
>                  spapr_ccs_remove(spapr, ccs);
>                  ccs = NULL;
>                  resp = SPAPR_DR_CC_RESPONSE_SUCCESS;
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 43d265f..96ffc02 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -42,8 +42,6 @@ spapr_drc_set_isolation_state_deferring(uint32_t index) "drc: 0x%"PRIx32
>  spapr_drc_set_indicator_state(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%x"
>  spapr_drc_set_allocation_state(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%x"
>  spapr_drc_set_allocation_state_finalizing(uint32_t index) "drc: 0x%"PRIx32
> -spapr_drc_set_configured(uint32_t index) "drc: 0x%"PRIx32
> -spapr_drc_set_configured_skipping(uint32_t index) "drc: 0x%"PRIx32", isolated device"
>  spapr_drc_entity_sense(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%x"
>  spapr_drc_attach(uint32_t index) "drc: 0x%"PRIx32
>  spapr_drc_detach(uint32_t index) "drc: 0x%"PRIx32
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 80db955..90f4953 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -177,9 +177,6 @@ typedef struct sPAPRDRConnectorClass {
>  
>      uint32_t (*entity_sense)(sPAPRDRConnector *drc, sPAPRDREntitySense *state);
>  
> -    /* QEMU interfaces for managing FDT/configure-connector */
> -    void (*set_configured)(sPAPRDRConnector *drc);
> -
>      /* QEMU interfaces for managing hotplug operations */
>      void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>                     int fdt_start_offset, bool coldplug, Error **errp);
> 
