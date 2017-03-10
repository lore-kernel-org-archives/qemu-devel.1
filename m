Received: from eggs.gnu.org ([2001:4830:134:3::10]:51331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1cmHSH-0000ac-GE
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1cmHSF-0005vQ-EX
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:07:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170310011328.30719-3-david@gibson.dropbear.id.au>
References: <20170310011328.30719-1-david@gibson.dropbear.id.au>
	<20170310011328.30719-3-david@gibson.dropbear.id.au>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Fri, 10 Mar 2017 15:37:16 +0530
Message-ID: <CAGZKiBpsD56N2o2xD8dpuuxp+isKF-2L0EtioVuo+sCJsxT4tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/5] pseries: Implement HPT
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Sam Bobroff <sam.bobroff@au1.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, sjitindarsingh@gmail.com, Alexander Graf <agraf@suse.de>

On Fri, Mar 10, 2017 at 6:43 AM, David Gibson <david@gibson.dropbear.id.au>
wrote:

> This patch implements hypercalls allowing a PAPR guest to resize its own
> hash page table.  This will eventually allow for more flexible memory
> hotplug.
>
> The implementation is partially asynchronous, handled in a special thread
> running the hpt_prepare_thread() function.  The state of a pending resize
> is stored in SPAPR_MACHINE->pending_hpt.
>
> The H_RESIZE_HPT_PREPARE hypercall will kick off creation of a new HPT, or,
> if one is already in progress, monitor it for completion.  If there is an
> existing HPT resize in progress that doesn't match the size specified in
> the call, it will cancel it, replacing it with a new one matching the
> given size.
>
> The H_RESIZE_HPT_COMMIT completes transition to a resized HPT, and can only
> be called successfully once H_RESIZE_HPT_PREPARE has successfully
> completed initialization of a new HPT.  The guest must ensure that there
> are no concurrent accesses to the existing HPT while this is called (this
> effectively means stop_machine() for Linux guests).
>
> For now H_RESIZE_HPT_COMMIT goes through the whole old HPT, rehashing each
> HPTE into the new HPT.  This can have quite high latency, but it seems to
> be of the order of typical migration downtime latencies for HPTs of size
> up to ~2GiB (which would be used in a 256GiB guest).
>
> In future we probably want to move more of the rehashing to the "prepare"
> phase, by having H_ENTER and other hcalls update both current and
> pending HPTs.  That's a project for another day, but should be possible
> without any changes to the guest interface.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c          |   4 +-
>  hw/ppc/spapr_hcall.c    | 338 ++++++++++++++++++++++++++++++
> +++++++++++++++++-
>  include/hw/ppc/spapr.h  |   6 +
>  target/ppc/mmu-hash64.h |   4 +
>  4 files changed, 346 insertions(+), 6 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 06b436d..bf6ba64 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -94,8 +94,6 @@
>
>  #define PHANDLE_XICP            0x00001111
>
> -#define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> -
>  static int try_create_xics(sPAPRMachineState *spapr, const char
> *type_ics,
>                             const char *type_icp, int nr_servers,
>                             int nr_irqs, Error **errp)
> @@ -1169,7 +1167,7 @@ static void spapr_store_hpte(PPCVirtualHypervisor
> *vhyp, hwaddr ptex,
>      }
>  }
>
> -static int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
> +int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
>  {
>      int shift;
>
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 9f88960..4c0b0fb 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -3,6 +3,7 @@
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/log.h"
> +#include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "helper_regs.h"
> @@ -352,20 +353,316 @@ static target_ulong h_read(PowerPCCPU *cpu,
> sPAPRMachineState *spapr,
>      return H_SUCCESS;
>  }
>
> +struct sPAPRPendingHPT {
> +    /* These fields are read-only after initialization */
> +    int shift;
> +    QemuThread thread;
> +
> +    /* These fields are protected by the BQL */
> +    bool complete;
> +
> +    /* These fields are private to the preparation thread if
> +     * !complete, otherwise protected by the BQL */
> +    int ret;
> +    void *hpt;
> +};
> +
> +static void free_pending_hpt(sPAPRPendingHPT *pending)
> +{
> +    if (pending->hpt) {
> +        qemu_vfree(pending->hpt);
> +    }
> +
> +    g_free(pending);
> +}
> +
> +static void *hpt_prepare_thread(void *opaque)
> +{
> +    sPAPRPendingHPT *pending = opaque;
> +    size_t size = 1ULL << pending->shift;
> +
> +    pending->hpt = qemu_memalign(size, size);
> +    if (pending->hpt) {
> +        memset(pending->hpt, 0, size);
> +        pending->ret = H_SUCCESS;
> +    } else {
> +        pending->ret = H_NO_MEM;
> +    }
> +
> +    qemu_mutex_lock_iothread();
> +
> +    if (SPAPR_MACHINE(qdev_get_machine())->pending_hpt == pending) {
> +        /* Ready to go */
> +        pending->complete = true;
> +    } else {
> +        /* We've been cancelled, clean ourselves up */
> +        free_pending_hpt(pending);
> +    }
> +
> +    qemu_mutex_unlock_iothread();
> +    return NULL;
> +}
> +
> +/* Must be called with BQL held */
> +static void cancel_hpt_prepare(sPAPRMachineState *spapr)
> +{
> +    sPAPRPendingHPT *pending = spapr->pending_hpt;
> +
> +    /* Let the thread know it's cancelled */
> +    spapr->pending_hpt = NULL;
> +
> +    if (!pending) {
> +        /* Nothing to do */
> +        return;
> +    }
> +
> +    if (!pending->complete) {
> +        /* thread will clean itself up */
> +        return;
> +    }
> +
> +    free_pending_hpt(pending);
> +}
> +
> +static int build_dimm_list(Object *obj, void *opaque)
> +{
> +    GSList **list = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
> +        DeviceState *dev = DEVICE(obj);
> +        if (dev->realized) { /* only realized DIMMs matter */
> +            *list = g_slist_prepend(*list, dev);
> +        }
> +    }
> +
> +    object_child_foreach(obj, build_dimm_list, opaque);
> +    return 0;
> +}
> +
> +static ram_addr_t get_current_ram_size(void)
> +{
> +    GSList *list = NULL, *item;
> +    ram_addr_t size = ram_size;
> +
> +    build_dimm_list(qdev_get_machine(), &list);
> +    for (item = list; item; item = g_slist_next(item)) {
> +        Object *obj = OBJECT(item->data);
> +        if (!strcmp(object_get_typename(obj), TYPE_PC_DIMM)) {
> +            size += object_property_get_int(obj, PC_DIMM_SIZE_PROP,
> +                                            &error_abort);
> +        }
> +    }
>

You could use the existing API pc_existing_dimms_capacity() for the above.

Regards,
Bharata.
