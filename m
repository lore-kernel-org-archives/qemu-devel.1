Received: from eggs.gnu.org ([2001:4830:134:3::10]:60343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5uqZ-000343-NL
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5uqV-0005Si-4V
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:01:39 -0400
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
	<20170430172547.13415-2-danielhb@linux.vnet.ibm.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f2218e34-3860-e14f-91f2-4bf019cac966@redhat.com>
Date: Wed, 3 May 2017 16:01:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170430172547.13415-2-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/ppc: setting spapr_drc_detach_cb in
 spapr_dr_connector_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 30/04/2017 19:25, Daniel Henrique Barboza wrote:
> The idea of moving the detach callback functions to the constructor
> of the dr_connector is to set them statically at init time, avoiding
> any post-load hooks to restore it (after a migration, for example).
> 
> Summary of changes:
> 
> - hw/ppc/spapr_drc.c and include/hw/ppc/spapr_drc.h:
>     *  spapr_dr_connector_new() now has an additional parameter,
> spapr_drc_detach_cb *detach_cb
>     *  'spapr_drc_detach_cb *detach_cb' parameter was removed of
> the detach function pointer in sPAPRDRConnectorClass
> 
> - hw/ppc/spapr_pci.c:
>     * the callback 'spapr_phb_remove_pci_device_cb' is now passed
> as a parameter in 'spapr_dr_connector_new' instead of 'drck->detach()'
> 
> - hw/ppc/spapr.c:
>     * 'spapr_create_lmb_dr_connectors' now passes the callback
> 'spapr_lmb_release' to 'spapr_dr_connector_new' instead of 'drck-detach()'
>     * 'spapr_init_cpus' now passes the callback 'spapr_core_release'
> to 'spapr_dr_connector_new' instead of 'drck-detach()'
>     * moved the callback functions up in the code so they can be referenced
> by 'spapr_create_lmb_dr_connectors' and 'spapr_init_cpus'
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c             | 71 +++++++++++++++++++++++-----------------------
>  hw/ppc/spapr_drc.c         | 17 ++++++-----
>  hw/ppc/spapr_pci.c         |  5 ++--
>  include/hw/ppc/spapr_drc.h |  4 +--
>  4 files changed, 49 insertions(+), 48 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 80d12d0..bc11757 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1887,6 +1887,29 @@ static void spapr_drc_reset(void *opaque)
>      }
>  }
>  
> +typedef struct sPAPRDIMMState {
> +    uint32_t nr_lmbs;
> +} sPAPRDIMMState;
> +
> +static void spapr_lmb_release(DeviceState *dev, void *opaque)
> +{
> +    sPAPRDIMMState *ds = (sPAPRDIMMState *)opaque;
> +    HotplugHandler *hotplug_ctrl;
> +
> +    if (--ds->nr_lmbs) {
> +        return;
> +    }
> +
> +    g_free(ds);
> +
> +    /*
> +     * Now that all the LMBs have been removed by the guest, call the
> +     * pc-dimm unplug handler to cleanup up the pc-dimm device.
> +     */
> +    hotplug_ctrl = qdev_get_hotplug_handler(dev);
> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> +}
> +
>  static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
>  {
>      MachineState *machine = MACHINE(spapr);
> @@ -1900,7 +1923,7 @@ static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
>  
>          addr = i * lmb_size + spapr->hotplug_memory.base;
>          drc = spapr_dr_connector_new(OBJECT(spapr), SPAPR_DR_CONNECTOR_TYPE_LMB,
> -                                     addr/lmb_size);
> +                                     (addr / lmb_size), spapr_lmb_release);

You have added useless parenthesis around "addr / lmb_size".

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
