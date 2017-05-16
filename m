Received: from eggs.gnu.org ([2001:4830:134:3::10]:60899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dAcWH-0005Ls-Cx
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dAcWE-0000O2-8U
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:28:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dAcWE-0000Nn-03
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:28:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4GDOj9X113127
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 09:28:04 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2afs4stk16-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 09:28:02 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 16 May 2017 10:27:58 -0300
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-2-danielhb@linux.vnet.ibm.com>
	<20170512060409.GE12908@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 16 May 2017 10:27:54 -0300
MIME-Version: 1.0
In-Reply-To: <20170512060409.GE12908@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <a977f171-495d-43e6-e4aa-ddf061db1b79@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 1/6] hw/ppc/spapr.c: adding
 pending_dimm_unplugs to sPAPRMachineState
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



On 05/12/2017 03:04 AM, David Gibson wrote:
> On Fri, May 05, 2017 at 05:47:41PM -0300, Daniel Henrique Barboza wrote:
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
> Urgh.  Moving this into the machine is really ugly.  Unfortunately, I
> can't quickly see a better way to accomplish what you need.  So I
> guess this approach is ok, with the hope that we can find a better way
> in future.

Agreed.

>
> There are a few more superficial problems to address, though.
>
>> ---
>>   hw/ppc/spapr.c         | 54 ++++++++++++++++++++++++++++++++++++++++++++------
>>   include/hw/ppc/spapr.h | 17 ++++++++++++++++
>>   2 files changed, 65 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 80d12d0..346c827 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2043,6 +2043,7 @@ static void ppc_spapr_init(MachineState *machine)
>>       msi_nonbroken = true;
>>   
>>       QLIST_INIT(&spapr->phbs);
>> +    QTAILQ_INIT(&spapr->pending_dimm_unplugs);
>>   
>>       /* Allocate RMA if necessary */
>>       rma_alloc_size = kvmppc_alloc_rma(&rma);
>> @@ -2596,20 +2597,32 @@ out:
>>       error_propagate(errp, local_err);
>>   }
>>   
>> -typedef struct sPAPRDIMMState {
>> -    uint32_t nr_lmbs;
>> -} sPAPRDIMMState;
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
>>   
> No need for this blank line in the middle of declarations.
>
>> +    uint64_t addr = spapr_dimm_get_address(PC_DIMM(dev));
>> +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, addr);
>> +
>>       if (--ds->nr_lmbs) {
>>           return;
>>       }
>>   
>> -    g_free(ds);
>> +    spapr_pending_dimm_unplugs_remove(spapr, ds);
>>   
>>       /*
>>        * Now that all the LMBs have been removed by the guest, call the
>> @@ -2626,17 +2639,20 @@ static void spapr_del_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
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
>> @@ -3515,3 +3531,29 @@ static void spapr_machine_register_types(void)
>>   }
>>   
>>   type_init(spapr_machine_register_types)
>> +
>> +sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *spapr,
>> +                                                uint64_t addr)
>> +{
>> +    sPAPRDIMMState *dimm_state = NULL;
>> +    QTAILQ_FOREACH(dimm_state, &spapr->pending_dimm_unplugs, next) {
>> +        if (dimm_state->addr == addr) {
>> +            break;
>> +        }
>> +    }
>> +    return dimm_state;
>> +}
>> +
>> +void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
>> +                                   sPAPRDIMMState *dimm_state)
>> +{
>> +    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->addr));
>> +    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
>> +}
>> +
>> +void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
>> +                                      sPAPRDIMMState *dimm_state)
>> +{
>> +    QTAILQ_REMOVE(&spapr->pending_dimm_unplugs, dimm_state, next);
>> +    g_free(dimm_state);
>> +}
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 5802f88..3e2b5ab 100644
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
>> +    QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
>> +
>>       /*< public >*/
>>       char *kvm_type;
>>       MemoryHotplugState hotplug_memory;
>> @@ -646,6 +650,19 @@ struct sPAPRConfigureConnectorState {
>>   
>>   void spapr_ccs_reset_hook(void *opaque);
>>   
>> +struct sPAPRDIMMState {
>> +    uint64_t addr;
>> +    uint32_t nr_lmbs;
>> +    QTAILQ_ENTRY(sPAPRDIMMState) next;
>> +};
>> +
>> +sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *spapr,
>> +                                               uint64_t addr);
>> +void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
>> +                                   sPAPRDIMMState *dimm_state);
>> +void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
>> +                                      sPAPRDIMMState *dimm_state);
>> +
> AFAICT all these new functions are only used in spapr.c, even in the
> rest of the series.  So they should be static, and not in the header
> file.  Likewise the structure definition.
>
>>   void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
>>   int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
>>   
