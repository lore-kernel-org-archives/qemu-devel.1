Received: from eggs.gnu.org ([2001:4830:134:3::10]:40350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gWem3-0003b4-1p
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gWely-0002FV-Tv
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:56:18 -0500
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:57216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gWely-0002CN-Nj
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:56:14 -0500
Received: from player759.ha.ovh.net (unknown [10.109.143.232])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id B82F0D73D3
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 10:56:04 +0100 (CET)
Date: Tue, 11 Dec 2018 10:55:59 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181211105559.76040a70@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <d363fae5-d968-0bfb-0c27-adbbe427f642@ozlabs.ru>
References: <20181108014406.29818-1-aik@ozlabs.ru>
	<20181111191047.7af39551@bahia.lan>
	<efc67974-4118-7877-6f8d-ce0a09cb9999@ozlabs.ru>
	<20181210062043.GS4261@umbus.fritz.box>
	<20181210103032.088de905@bahia.lab.toulouse-stg.fr.ibm.com>
	<d363fae5-d968-0bfb-0c27-adbbe427f642@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] ppc/spapr: Receive and
 store device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Tue, 11 Dec 2018 14:53:32 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 10/12/2018 20:30, Greg Kurz wrote:
> > On Mon, 10 Dec 2018 17:20:43 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> >> On Mon, Nov 12, 2018 at 03:12:26PM +1100, Alexey Kardashevskiy wrote:  
> >>>
> >>>
> >>> On 12/11/2018 05:10, Greg Kurz wrote:    
> >>>> Hi Alexey,
> >>>>
> >>>> Just a few remarks. See below.
> >>>>
> >>>> On Thu,  8 Nov 2018 12:44:06 +1100
> >>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>     
> >>>>> SLOF receives a device tree and updates it with various properties
> >>>>> before switching to the guest kernel and QEMU is not aware of any changes
> >>>>> made by SLOF. Since there is no real RTAS (QEMU implements it), it makes
> >>>>> sense to pass the SLOF final device tree to QEMU to let it implement
> >>>>> RTAS related tasks better, such as PCI host bus adapter hotplug.
> >>>>>
> >>>>> Specifially, now QEMU can find out the actual XICS phandle (for PHB
> >>>>> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> >>>>> assisted NMI - FWNMI).
> >>>>>
> >>>>> This stores the initial DT blob in the sPAPR machine and replaces it
> >>>>> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> >>>>>
> >>>>> This adds an @update_dt_enabled machine property to allow backward
> >>>>> migration.
> >>>>>
> >>>>> SLOF already has a hypercall since
> >>>>> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
> >>>>>
> >>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>> ---
> >>>>>  include/hw/ppc/spapr.h |  7 ++++++-
> >>>>>  hw/ppc/spapr.c         | 29 ++++++++++++++++++++++++++++-
> >>>>>  hw/ppc/spapr_hcall.c   | 32 ++++++++++++++++++++++++++++++++
> >>>>>  hw/ppc/trace-events    |  2 ++
> >>>>>  4 files changed, 68 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >>>>> index ad4d7cfd97..f5dcaf44cb 100644
> >>>>> --- a/include/hw/ppc/spapr.h
> >>>>> +++ b/include/hw/ppc/spapr.h
> >>>>> @@ -100,6 +100,7 @@ struct sPAPRMachineClass {
> >>>>>  
> >>>>>      /*< public >*/
> >>>>>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
> >>>>> +    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
> >>>>>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> >>>>>      bool pre_2_10_has_unused_icps;
> >>>>>      bool legacy_irq_allocation;
> >>>>> @@ -136,6 +137,9 @@ struct sPAPRMachineState {
> >>>>>      int vrma_adjust;
> >>>>>      ssize_t rtas_size;
> >>>>>      void *rtas_blob;
> >>>>> +    uint32_t fdt_size;
> >>>>> +    uint32_t fdt_initial_size;    
> >>>>
> >>>> I don't quite see the purpose of fdt_initial_size... it seems to be only
> >>>> used to print a trace.    
> >>>
> >>>
> >>> Ah, lost in rebase. The purpose was to test if the new device tree has
> >>> not grown too much.
> >>>
> >>>
> >>>     
> >>>>     
> >>>>> +    void *fdt_blob;
> >>>>>      long kernel_size;
> >>>>>      bool kernel_le;
> >>>>>      uint32_t initrd_base;
> >>>>> @@ -462,7 +466,8 @@ struct sPAPRMachineState {
> >>>>>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
> >>>>>  /* Client Architecture support */
> >>>>>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> >>>>> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> >>>>> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> >>>>> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> >>>>>  
> >>>>>  typedef struct sPAPRDeviceTreeUpdateHeader {
> >>>>>      uint32_t version_id;
> >>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>>> index c08130facb..5e2d4d211c 100644
> >>>>> --- a/hw/ppc/spapr.c
> >>>>> +++ b/hw/ppc/spapr.c
> >>>>> @@ -1633,7 +1633,10 @@ static void spapr_machine_reset(void)
> >>>>>      /* Load the fdt */
> >>>>>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> >>>>>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
> >>>>> -    g_free(fdt);
> >>>>> +    g_free(spapr->fdt_blob);
> >>>>> +    spapr->fdt_size = fdt_totalsize(fdt);
> >>>>> +    spapr->fdt_initial_size = spapr->fdt_size;
> >>>>> +    spapr->fdt_blob = fdt;    
> >>>>
> >>>> Hmm... It looks weird to store state in a reset handler. I'd rather zeroe
> >>>> both fdt_blob and fdt_size here.    
> >>>
> >>> The device tree is built from the reset handler and the idea is that we
> >>> want to always have some tree in the machine.    
> >>
> >> Yes, I think the approach here is fine.  Otherwise when we want to
> >> look up the current fdt state in RTAS calls or whatever we'd always
> >> have to do
> >> 	if (fdt_blob)
> >> 		look up that
> >> 	else
> >> 		look up qemu created fdt.
> >>  
> > 
> > No. We only have one fdt blob: the initial one, I'd rather
> > call reset time one, or the updated one.  
> 
> There is one fdt in the machine, always. Either initial or from cas.
> 

Yeah, reset time fdt is either the initial one, either cas... and I'm now
wandering what happens if migration occurs between cas that sets cas_reboot
and the corresponding reset. With the current code base, I have the impression
that the destination will redo the full cas+cas_reboot cycle after restart or
am I missing something ? 

> 
> 
> >> Incidentally 'fdt' and 'fdt_blob' names do a terrible job of
> >> distinguishing what the difference is.  Renaming fdt to fdt_initial
> >> (to match fdt_initial_size) and fdt_blob to fdt should make that
> >> clearer.
> >>  
> > 
> > As mentioned earlier in this thread, spapr->fdt_initial_size is only used
> > for tracing if the received fdt blob fails fdt_check_full()...
> > 
> > $ git grep -H fdt_initial_size
> > hw/ppc/spapr.c:    spapr->fdt_initial_size = spapr->fdt_size;
> > hw/ppc/spapr.c:        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineState),
> > hw/ppc/spapr_hcall.c:        trace_spapr_update_dt_failed(spapr->fdt_initial_size, cb,
> > include/hw/ppc/spapr.h:    uint32_t fdt_initial_size;
> > 
> > Not sure it is helpful, and anyway, it is expected to be the same in source
> > and destination, so why put it in the migration stream ?  
> 
> 
> Well, we do build the fdt anyway even when receive migration but we do
> not have to and yes we can expect the fdt on the destination to be of
> the same size since it is the same command line, it is just guessing and
> expecting vs. knowing and I prefer the latter as the reset time fdt and
> migration source fdt might have different size because of
> host-model/host-serial/slot-label/similar properties.
> 

Right but I still don't see the usefulness of fdt_initial_size...

> 
> > The only case where we want to migrate something is when h_update_dt() has
> > succeeded, ie, the guest passed a valid DT blob. This implies that its
> > size isn't 0, otherwise fdt_check_full() would return -FDT_ERR_TRUNCATED.
> > 
> > I would suggest rather to:
> > 
> > - completely drop spapr->fdt_initial_size
> > - clear spapr->fdt_size at machine reset
> > - migrate if spapr->fdt_size is not zero
> > 
> > Also, I've just realized another problem... nothing prevents a malicious
> > guest to pass an insanely great size to h_update_dt, which would cause
> > g_malloc0() to abort... The passed size should be checked against
> > FDT_MAX_SIZE.  
> 
> Good point. Just noticed - as posted, the checker actually checks the
> reset time tree, not the updated one, my bad :)
> 
> 
> 
