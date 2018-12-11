Received: from eggs.gnu.org ([2001:4830:134:3::10]:46585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gWZ48-0000NF-3n
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gWYqJ-0005ZQ-G2
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:36:22 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gWYqG-0005Xu-Hf
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:36:18 -0500
Received: by mail-pl1-x644.google.com with SMTP id g9so6256181plo.3
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 19:36:14 -0800 (PST)
References: <20181108014406.29818-1-aik@ozlabs.ru>
	<20181111191047.7af39551@bahia.lan>
	<efc67974-4118-7877-6f8d-ce0a09cb9999@ozlabs.ru>
	<20181210062043.GS4261@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <60956124-2f86-0aa6-0dca-ffe0abe26d14@ozlabs.ru>
Date: Tue, 11 Dec 2018 14:36:09 +1100
MIME-Version: 1.0
In-Reply-To: <20181210062043.GS4261@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org



On 10/12/2018 17:20, David Gibson wrote:
> On Mon, Nov 12, 2018 at 03:12:26PM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 12/11/2018 05:10, Greg Kurz wrote:
>>> Hi Alexey,
>>>
>>> Just a few remarks. See below.
>>>
>>> On Thu,  8 Nov 2018 12:44:06 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>
>>>> SLOF receives a device tree and updates it with various properties
>>>> before switching to the guest kernel and QEMU is not aware of any changes
>>>> made by SLOF. Since there is no real RTAS (QEMU implements it), it makes
>>>> sense to pass the SLOF final device tree to QEMU to let it implement
>>>> RTAS related tasks better, such as PCI host bus adapter hotplug.
>>>>
>>>> Specifially, now QEMU can find out the actual XICS phandle (for PHB
>>>> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
>>>> assisted NMI - FWNMI).
>>>>
>>>> This stores the initial DT blob in the sPAPR machine and replaces it
>>>> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
>>>>
>>>> This adds an @update_dt_enabled machine property to allow backward
>>>> migration.
>>>>
>>>> SLOF already has a hypercall since
>>>> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>  include/hw/ppc/spapr.h |  7 ++++++-
>>>>  hw/ppc/spapr.c         | 29 ++++++++++++++++++++++++++++-
>>>>  hw/ppc/spapr_hcall.c   | 32 ++++++++++++++++++++++++++++++++
>>>>  hw/ppc/trace-events    |  2 ++
>>>>  4 files changed, 68 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index ad4d7cfd97..f5dcaf44cb 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -100,6 +100,7 @@ struct sPAPRMachineClass {
>>>>  
>>>>      /*< public >*/
>>>>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
>>>> +    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
>>>>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>>>>      bool pre_2_10_has_unused_icps;
>>>>      bool legacy_irq_allocation;
>>>> @@ -136,6 +137,9 @@ struct sPAPRMachineState {
>>>>      int vrma_adjust;
>>>>      ssize_t rtas_size;
>>>>      void *rtas_blob;
>>>> +    uint32_t fdt_size;
>>>> +    uint32_t fdt_initial_size;
>>>
>>> I don't quite see the purpose of fdt_initial_size... it seems to be only
>>> used to print a trace.
>>
>>
>> Ah, lost in rebase. The purpose was to test if the new device tree has
>> not grown too much.
>>
>>
>>
>>>
>>>> +    void *fdt_blob;
>>>>      long kernel_size;
>>>>      bool kernel_le;
>>>>      uint32_t initrd_base;
>>>> @@ -462,7 +466,8 @@ struct sPAPRMachineState {
>>>>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>>>>  /* Client Architecture support */
>>>>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
>>>> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
>>>> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
>>>> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
>>>>  
>>>>  typedef struct sPAPRDeviceTreeUpdateHeader {
>>>>      uint32_t version_id;
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index c08130facb..5e2d4d211c 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -1633,7 +1633,10 @@ static void spapr_machine_reset(void)
>>>>      /* Load the fdt */
>>>>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>>>>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
>>>> -    g_free(fdt);
>>>> +    g_free(spapr->fdt_blob);
>>>> +    spapr->fdt_size = fdt_totalsize(fdt);
>>>> +    spapr->fdt_initial_size = spapr->fdt_size;
>>>> +    spapr->fdt_blob = fdt;
>>>
>>> Hmm... It looks weird to store state in a reset handler. I'd rather zeroe
>>> both fdt_blob and fdt_size here.
>>
>> The device tree is built from the reset handler and the idea is that we
>> want to always have some tree in the machine.
> 
> Yes, I think the approach here is fine.  Otherwise when we want to
> look up the current fdt state in RTAS calls or whatever we'd always
> have to do
> 	if (fdt_blob)
> 		look up that
> 	else
> 		look up qemu created fdt.
> 
> Incidentally 'fdt' and 'fdt_blob' names do a terrible job of
> distinguishing what the difference is.  Renaming fdt to fdt_initial
> (to match fdt_initial_size) and fdt_blob to fdt should make that
> clearer.

There is just one fdt in sPAPRMachineState - it is fdt_blob as it is
flattened. The "fdt" symbol above is local to spapr_machine_reset() and
when the tree is built - it is stored in fdt_blob.



-- 
Alexey
