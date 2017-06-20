Received: from eggs.gnu.org ([2001:4830:134:3::10]:58730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dNOaD-0006r1-Ks
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 15:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dNOa8-0005lb-UQ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 15:13:01 -0400
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-3-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <25d055be-ae3e-3407-7b61-d6bfe265f24f@redhat.com>
Date: Tue, 20 Jun 2017 21:12:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170620015332.13874-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/5] spapr: Uniform DRC reset
 paths
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
> DRC objects have a regular device reset method.  However, it only gets
> called in the usual way for PCI DRCs.  Because of where CPU and LMB DRCs
> are in the QOM tree, their device reset method isn't automatically called.
> So, the machine manually registers reset handlers to call device_reset().
> 
> This patch removes the device reset method, and instead always explicitly
> registers the reset handler from realize().  This means the callers don't
> have to worry about the two cases, and we always get proper resets.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  hw/ppc/spapr.c     | 31 ++++---------------------------
>  hw/ppc/spapr_drc.c |  6 +++---
>  2 files changed, 7 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8a0c247..f12bc4d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1967,24 +1967,6 @@ static void spapr_boot_set(void *opaque, const char *boot_device,
>      machine->boot_order = g_strdup(boot_device);
>  }
>  
> -/*
> - * Reset routine for LMB DR devices.
> - *
> - * Unlike PCI DR devices, LMB DR devices explicitly register this reset
> - * routine. Reset for PCI DR devices will be handled by PHB reset routine
> - * when it walks all its children devices. LMB devices reset occurs
> - * as part of spapr_ppc_reset().
> - */
> -static void spapr_drc_reset(void *opaque)
> -{
> -    sPAPRDRConnector *drc = opaque;
> -    DeviceState *d = DEVICE(drc);
> -
> -    if (d) {
> -        device_reset(d);
> -    }
> -}
> -
>  static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
>  {
>      MachineState *machine = MACHINE(spapr);
> @@ -1993,13 +1975,11 @@ static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
>      int i;
>  
>      for (i = 0; i < nr_lmbs; i++) {
> -        sPAPRDRConnector *drc;
>          uint64_t addr;
>  
>          addr = i * lmb_size + spapr->hotplug_memory.base;
> -        drc = spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_LMB,
> -                                     addr/lmb_size);
> -        qemu_register_reset(spapr_drc_reset, drc);
> +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_LMB,
> +                               addr / lmb_size);
>      }
>  }
>  
> @@ -2093,11 +2073,8 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
>          int core_id = i * smp_threads;
>  
>          if (mc->has_hotpluggable_cpus) {
> -            sPAPRDRConnector *drc =
> -                spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
> -                                       (core_id / smp_threads) * smt);
> -
> -            qemu_register_reset(spapr_drc_reset, drc);
> +            spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
> +                                   (core_id / smp_threads) * smt);
>          }
>  
>          if (i < boot_cores_nr) {
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 0bc9046..e5dff16 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -426,9 +426,9 @@ static bool release_pending(sPAPRDRConnector *drc)
>      return drc->awaiting_release;
>  }
>  
> -static void reset(DeviceState *d)
> +static void drc_reset(void *opaque)
>  {
> -    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
> +    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(opaque);
>  
>      trace_spapr_drc_reset(spapr_drc_index(drc));
>  
> @@ -536,6 +536,7 @@ static void realize(DeviceState *d, Error **errp)
>      g_free(child_name);
>      vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_drc,
>                       drc);
> +    qemu_register_reset(drc_reset, drc);
>      trace_spapr_drc_realize_complete(spapr_drc_index(drc));
>  }
>  
> @@ -594,7 +595,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
>      DeviceClass *dk = DEVICE_CLASS(k);
>      sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
>  
> -    dk->reset = reset;
>      dk->realize = realize;
>      dk->unrealize = unrealize;
>      drck->release_pending = release_pending;
> 
