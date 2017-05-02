Received: from eggs.gnu.org ([2001:4830:134:3::10]:41272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1d5OgB-0000NJ-RQ
	for qemu-devel@nongnu.org; Mon, 01 May 2017 23:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1d5Og9-0000FQ-Tz
	for qemu-devel@nongnu.org; Mon, 01 May 2017 23:40:47 -0400
MIME-Version: 1.0
In-Reply-To: <20170430172547.13415-3-danielhb@linux.vnet.ibm.com>
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
	<20170430172547.13415-3-danielhb@linux.vnet.ibm.com>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Tue, 2 May 2017 09:10:44 +0530
Message-ID: <CAGZKiBok2=HRT9BjMiDx+c20YeKhknJ0ZD_GV1Zx=BrbFSmxwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/ppc: removing spapr_drc_detach_cb
 opaques
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Sun, Apr 30, 2017 at 10:55 PM, Daniel Henrique Barboza <
danielhb@linux.vnet.ibm.com> wrote:

> Following up the previous detach_cb change, this patch removes the
> detach_cb_opaque entirely from the code.
>
> The reason is that the drc->detach_cb_opaque object can't be
> restored in the post load of the upcoming DRC migration and no detach
> callbacks actually need this opaque. 'spapr_core_release' is
> receiving it as NULL, 'spapr_phb_remove_pci_device_cb' is receiving
> a phb object as opaque but is't using it. These were trivial removal
> cases.
>
> However, the LM removal callback 'spapr_lmb_release' is receiving
> and using the opaque object, a 'sPAPRDIMMState' struct. This struct
> holds the number of LMBs the DIMM object contains and the callback
> was using this counter as a countdown to check if all LMB DRCs were
> release before proceeding to the DIMM unplug. To remove the need of
> this callback we have choices such as:
>
> - migrate the 'sPAPRDIMMState' struct. This would require creating a
> QTAILQ to store all DIMMStates and an additional 'dimm_id' field to
> associate the DIMMState with the DIMM object. We could attach this
> QTAILQ to the 'sPAPRPHBState' and retrieve it later in the callback.
>
> - fetch the state of the LMB DRCs directly by scanning the state of
> them and, if all of them are released, proceed with the DIMM unplug.
>
> The second approach was chosen. The new 'spapr_all_lmbs_drcs_released'
> function scans all LMBs of a given DIMM device to see if their DRC
> state are inactive. If all of them are inactive return 'true', 'false'
> otherwise. This function is being called inside the 'spapr_lmb_release'
> callback, replacing the role of the 'sPAPRDIMMState' opaque. The
> 'sPAPRDIMMState' struct was removed from the code given that there are
> no more uses for it.
>
> After all these changes, there are no roles left for the 'detach_cb_opaque'
> attribute of the 'sPAPRDRConnector' as well, so we can safely remove
> it from the code too.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c             | 46 ++++++++++++++++++++++++++++++
> +++-------------
>  hw/ppc/spapr_drc.c         | 16 +++++-----------
>  hw/ppc/spapr_pci.c         |  4 ++--
>  include/hw/ppc/spapr_drc.h |  6 ++----
>  4 files changed, 42 insertions(+), 30 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bc11757..8b9a6cf 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1887,21 +1887,43 @@ static void spapr_drc_reset(void *opaque)
>      }
>  }
>
> -typedef struct sPAPRDIMMState {
> -    uint32_t nr_lmbs;
> -} sPAPRDIMMState;
> +static bool spapr_all_lmbs_drcs_released(PCDIMMDevice *dimm)
> +{
> +    Error *local_err = NULL;
> +    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
> +    MemoryRegion *mr = ddc->get_memory_region(dimm);
> +    uint64_t size = memory_region_size(mr);
> +
> +    uint64_t addr;
> +    addr = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> &local_err);
> +    if (local_err) {
> +        error_propagate(&error_abort, local_err);
> +        return false;
> +    }
> +    uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
>
> -static void spapr_lmb_release(DeviceState *dev, void *opaque)
> +    sPAPRDRConnector *drc;
> +    int i = 0;
> +    for (i = 0; i < nr_lmbs; i++) {
> +        drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> +                addr / SPAPR_MEMORY_BLOCK_SIZE);
> +        g_assert(drc);
> +        if (drc->indicator_state != SPAPR_DR_INDICATOR_STATE_INACTIVE) {
> +            return false;
> +        }
> +        addr += SPAPR_MEMORY_BLOCK_SIZE;
> +    }
> +    return true;
> +}
> +
> +static void spapr_lmb_release(DeviceState *dev)
>  {
> -    sPAPRDIMMState *ds = (sPAPRDIMMState *)opaque;
>      HotplugHandler *hotplug_ctrl;
>
> -    if (--ds->nr_lmbs) {
> +    if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
>          return;
>      }
>

I am concerned about the number of times we walk the DRC list corresponding
to each DIMM device. When a DIMM device is being removed,
spapr_lmb_release() will be invoked for each of the LMBs of that DIMM. Now
in this scheme, we end up walking through all the DRC objects of the DIMM
from every LMB's release function.

Regards,
Bharata.
