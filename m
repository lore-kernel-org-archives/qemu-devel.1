Received: from eggs.gnu.org ([2001:4830:134:3::10]:48923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBfwr-0003Hv-D6
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBfwo-0000XY-C9
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:19:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dBfwo-0000XO-22
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:19:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JBJbnG020164
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 07:19:52 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahw6vxxbt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 07:19:51 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 19 May 2017 08:19:48 -0300
References: <20170518215416.5613-1-danielhb@linux.vnet.ibm.com>
	<20170518215416.5613-2-danielhb@linux.vnet.ibm.com>
	<20170519042611.GE12284@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 19 May 2017 08:19:41 -0300
MIME-Version: 1.0
In-Reply-To: <20170519042611.GE12284@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <a229357e-d42a-28e3-b118-cc0f4b702e95@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RESEND PATCH v10 1/5] hw/ppc/spapr.c:
 adding pending_dimm_unplugs to sPAPRMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com



On 05/19/2017 01:26 AM, David Gibson wrote:
> On Thu, May 18, 2017 at 06:54:12PM -0300, Daniel Henrique Barboza wrote:
>> The LMB DRC release callback, spapr_lmb_release(), uses an opaque
>> parameter, a sPAPRDIMMState struct that stores the current LMBs that
>> are allocated to a DIMM (nr_lmbs). After each call to this callback,
>> the nr_lmbs is decremented by one and, when it reaches zero, the callback
>> proceeds with the qdev calls to hot unplug the LMB.
>>
>> Using drc->detach_cb_opaque is problematic because it can't be migrated in
>> the future DRC migration work. This patch makes the following changes to
>> eliminate the usage of this opaque callback inside spapr_lmb_release:
>>
>> - sPAPRDIMMState was moved from spapr.c and added to spapr.h. A new
>> attribute called 'addr' was added to it. This is used as an unique
>> identifier to associate a sPAPRDIMMState to a PCDIMM element.
>>
>> - sPAPRMachineState now hosts a new QTAILQ called 'pending_dimm_unplugs'.
>> This queue of sPAPRDIMMState elements will store the DIMM state of DIMMs
>> that are currently going under an unplug process.
>>
>> - spapr_lmb_release() will now retrieve the nr_lmbs value by getting the
>> correspondent sPAPRDIMMState. A helper function called spapr_dimm_get_address
>> was created to fetch the address of a PCDIMM device inside spapr_lmb_release.
>> When nr_lmbs reaches zero and the callback proceeds with the qdev hot unplug
>> calls, the sPAPRDIMMState struct is removed from spapr->pending_dimm_unplugs.
>>
>> After these changes, the opaque argument for spapr_lmb_release is now
>> unused and is passed as NULL inside spapr_del_lmbs. This and the other
>> opaque arguments can now be safely removed from the code.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> ---
>>   hw/ppc/spapr.c         | 57 +++++++++++++++++++++++++++++++++++++++++++++-----
>>   include/hw/ppc/spapr.h |  4 ++++
>>   2 files changed, 56 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 0980d73..b05abe5 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2050,6 +2050,7 @@ static void ppc_spapr_init(MachineState *machine)
>>       msi_nonbroken = true;
>>   
>>       QLIST_INIT(&spapr->phbs);
>> +    QTAILQ_INIT(&spapr->pending_dimm_unplugs);
>>   
>>       /* Allocate RMA if necessary */
>>       rma_alloc_size = kvmppc_alloc_rma(&rma);
>> @@ -2603,20 +2604,63 @@ out:
>>       error_propagate(errp, local_err);
>>   }
>>   
>> -typedef struct sPAPRDIMMState {
>> +struct sPAPRDIMMState {
>> +    uint64_t addr;
> Since you're not trying to migrate this any more, you can index the
> list by an actual PCDIMMDevice *, rather than the base address.
> You're already passing the DeviceState * for the DIMM around, so this
> will actually remove the address parameter from some functions.
Good idea.

>
> I think that could actually be done as a preliminary cleanup.  It also
> probably makes sense to merge spapr_del_lmbs() with
> spapr_memory_unplug_request(), they're both very small.

Ok.

>
>
>>       uint32_t nr_lmbs;
>> -} sPAPRDIMMState;
>> +    QTAILQ_ENTRY(sPAPRDIMMState) next;
>> +};
>> +
>> +static sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *s,
>> +                                                       uint64_t addr)
>> +{
>> +    sPAPRDIMMState *dimm_state = NULL;
>> +    QTAILQ_FOREACH(dimm_state, &s->pending_dimm_unplugs, next) {
>> +        if (dimm_state->addr == addr) {
>> +            break;
>> +        }
>> +    }
>> +    return dimm_state;
>> +}
>> +
>> +static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
>> +                                           sPAPRDIMMState *dimm_state)
>> +{
>> +    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->addr));
>> +    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
>> +}
>> +
>> +static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
>> +                                              sPAPRDIMMState *dimm_state)
>> +{
>> +    QTAILQ_REMOVE(&spapr->pending_dimm_unplugs, dimm_state, next);
>> +    g_free(dimm_state);
>> +}
>> +
>> +static uint64_t spapr_dimm_get_address(PCDIMMDevice *dimm)
>> +{
>> +    Error *local_err = NULL;
>> +    uint64_t addr;
>> +    addr = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP,
>> +                                   &local_err);
>> +    if (local_err) {
>> +        error_propagate(&error_abort, local_err);
>> +        return 0;
>> +    }
>> +    return addr;
>> +}
>>   
>>   static void spapr_lmb_release(DeviceState *dev, void *opaque)
>>   {
>> -    sPAPRDIMMState *ds = (sPAPRDIMMState *)opaque;
>>       HotplugHandler *hotplug_ctrl;
>> +    uint64_t addr = spapr_dimm_get_address(PC_DIMM(dev));
>> +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> I prefer not to access the machine as a global when possible.  I think
> it's preferable to pass down the spapr object from above -
> unplug_request() itself can get it from hotplug_dev.

I see that we have access to the hotplug_dev (HotplugHandler) in the end of
spapr_lmb_release:

     hotplug_ctrl = qdev_get_hotplug_handler(dev);

One alternative would be to move this call up in the function and then
retrieve the machine as unplug_request() does:

     hotplug_ctrl = qdev_get_hotplug_handler(dev);
     sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_ctrl);



>
>> +    sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, addr);
>>   
>>       if (--ds->nr_lmbs) {
>>           return;
>>       }
>>   
>> -    g_free(ds);
>> +    spapr_pending_dimm_unplugs_remove(spapr, ds);
>>   
>>       /*
>>        * Now that all the LMBs have been removed by the guest, call the
>> @@ -2633,17 +2677,20 @@ static void spapr_del_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>>       sPAPRDRConnectorClass *drck;
>>       uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
>>       int i;
>> +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>       sPAPRDIMMState *ds = g_malloc0(sizeof(sPAPRDIMMState));
>>       uint64_t addr = addr_start;
>>   
>>       ds->nr_lmbs = nr_lmbs;
>> +    ds->addr = addr_start;
>> +    spapr_pending_dimm_unplugs_add(spapr, ds);
>>       for (i = 0; i < nr_lmbs; i++) {
>>           drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
>>                   addr / SPAPR_MEMORY_BLOCK_SIZE);
>>           g_assert(drc);
>>   
>>           drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>> -        drck->detach(drc, dev, spapr_lmb_release, ds, errp);
>> +        drck->detach(drc, dev, spapr_lmb_release, NULL, errp);
>>           addr += SPAPR_MEMORY_BLOCK_SIZE;
>>       }
>>   
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 5802f88..9823296 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -32,6 +32,7 @@ struct sPAPRRTCState {
>>       int64_t ns_offset;
>>   };
>>   
>> +typedef struct sPAPRDIMMState sPAPRDIMMState;
>>   typedef struct sPAPRMachineClass sPAPRMachineClass;
>>   
>>   #define TYPE_SPAPR_MACHINE      "spapr-machine"
>> @@ -104,6 +105,9 @@ struct sPAPRMachineState {
>>       /* RTAS state */
>>       QTAILQ_HEAD(, sPAPRConfigureConnectorState) ccs_list;
>>   
>> +    /* pending DIMM unplug queue */
> Perhaps update this to mention that it's a cache which can be
> regenerated when necessary.
Ok.
>
>> +    QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
>> +
>>       /*< public >*/
>>       char *kvm_type;
>>       MemoryHotplugState hotplug_memory;
