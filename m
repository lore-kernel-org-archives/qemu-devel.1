Received: from eggs.gnu.org ([2001:4830:134:3::10]:38457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6GKI-0003Al-N5
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6GKE-0007em-5S
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:57:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d6GKD-0007e2-Td
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:57:42 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44Cn1jX140657
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 08:57:40 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a7ux579em-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 08:57:40 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 4 May 2017 09:57:36 -0300
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
	<20170430172547.13415-2-danielhb@linux.vnet.ibm.com>
	<20170504053325.GA14413@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 4 May 2017 09:57:27 -0300
MIME-Version: 1.0
In-Reply-To: <20170504053325.GA14413@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <47da051d-a333-da63-38e7-41ad864eb75f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/5] hw/ppc: setting
 spapr_drc_detach_cb in spapr_dr_connector_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org



On 05/04/2017 02:33 AM, David Gibson wrote:
> On Sun, Apr 30, 2017 at 02:25:43PM -0300, Daniel Henrique Barboza wrote:
>> The idea of moving the detach callback functions to the constructor
>> of the dr_connector is to set them statically at init time, avoiding
>> any post-load hooks to restore it (after a migration, for example).
>>
>> Summary of changes:
>>
>> - hw/ppc/spapr_drc.c and include/hw/ppc/spapr_drc.h:
>>      *  spapr_dr_connector_new() now has an additional parameter,
>> spapr_drc_detach_cb *detach_cb
>>      *  'spapr_drc_detach_cb *detach_cb' parameter was removed of
>> the detach function pointer in sPAPRDRConnectorClass
>>
>> - hw/ppc/spapr_pci.c:
>>      * the callback 'spapr_phb_remove_pci_device_cb' is now passed
>> as a parameter in 'spapr_dr_connector_new' instead of 'drck->detach()'
>>
>> - hw/ppc/spapr.c:
>>      * 'spapr_create_lmb_dr_connectors' now passes the callback
>> 'spapr_lmb_release' to 'spapr_dr_connector_new' instead of 'drck-detach()'
>>      * 'spapr_init_cpus' now passes the callback 'spapr_core_release'
>> to 'spapr_dr_connector_new' instead of 'drck-detach()'
>>      * moved the callback functions up in the code so they can be referenced
>> by 'spapr_create_lmb_dr_connectors' and 'spapr_init_cpus'
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> So, the patch looks correct, but the approach bothers me a bit.  The
> DRC type and the detach callback are essentially redundant information
> - the callback still gets stored in the instance, which doesn't make a
> whole lot of sense.
>
> Ideally we'd use QOM subtypes of the base DRC type and put the
> callback in the drck, but I suspect that will raise some other
> complications, so I'm ok with postponing that.

Interesting.

>
> In the meantime, I think we'd be better of doing an explicit switch on
> the DRC type when we want to call the detach function, rather than
> storing a function pointer at all.  It's kind of ugly, but we already
> have a bunch of nasty switches on the type, so I don't think it's
> really any uglier than what we have.

That sounds reasonable to me. If no one has a strong objection against 
it I'll
add this change in the next version.


Daniel

>
>
>> ---
>>   hw/ppc/spapr.c             | 71 +++++++++++++++++++++++-----------------------
>>   hw/ppc/spapr_drc.c         | 17 ++++++-----
>>   hw/ppc/spapr_pci.c         |  5 ++--
>>   include/hw/ppc/spapr_drc.h |  4 +--
>>   4 files changed, 49 insertions(+), 48 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 80d12d0..bc11757 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1887,6 +1887,29 @@ static void spapr_drc_reset(void *opaque)
>>       }
>>   }
>>   
>> +typedef struct sPAPRDIMMState {
>> +    uint32_t nr_lmbs;
>> +} sPAPRDIMMState;
>> +
>> +static void spapr_lmb_release(DeviceState *dev, void *opaque)
>> +{
>> +    sPAPRDIMMState *ds = (sPAPRDIMMState *)opaque;
>> +    HotplugHandler *hotplug_ctrl;
>> +
>> +    if (--ds->nr_lmbs) {
>> +        return;
>> +    }
>> +
>> +    g_free(ds);
>> +
>> +    /*
>> +     * Now that all the LMBs have been removed by the guest, call the
>> +     * pc-dimm unplug handler to cleanup up the pc-dimm device.
>> +     */
>> +    hotplug_ctrl = qdev_get_hotplug_handler(dev);
>> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
>> +}
>> +
>>   static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
>>   {
>>       MachineState *machine = MACHINE(spapr);
>> @@ -1900,7 +1923,7 @@ static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
>>   
>>           addr = i * lmb_size + spapr->hotplug_memory.base;
>>           drc = spapr_dr_connector_new(OBJECT(spapr), SPAPR_DR_CONNECTOR_TYPE_LMB,
>> -                                     addr/lmb_size);
>> +                                     (addr / lmb_size), spapr_lmb_release);
>>           qemu_register_reset(spapr_drc_reset, drc);
>>       }
>>   }
>> @@ -1956,6 +1979,14 @@ static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
>>       return &ms->possible_cpus->cpus[index];
>>   }
>>   
>> +static void spapr_core_release(DeviceState *dev, void *opaque)
>> +{
>> +    HotplugHandler *hotplug_ctrl;
>> +
>> +    hotplug_ctrl = qdev_get_hotplug_handler(dev);
>> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
>> +}
>> +
>>   static void spapr_init_cpus(sPAPRMachineState *spapr)
>>   {
>>       MachineState *machine = MACHINE(spapr);
>> @@ -1998,7 +2029,8 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
>>               sPAPRDRConnector *drc =
>>                   spapr_dr_connector_new(OBJECT(spapr),
>>                                          SPAPR_DR_CONNECTOR_TYPE_CPU,
>> -                                       (core_id / smp_threads) * smt);
>> +                                       (core_id / smp_threads) * smt,
>> +                                       spapr_core_release);
>>   
>>               qemu_register_reset(spapr_drc_reset, drc);
>>           }
>> @@ -2596,29 +2628,6 @@ out:
>>       error_propagate(errp, local_err);
>>   }
>>   
>> -typedef struct sPAPRDIMMState {
>> -    uint32_t nr_lmbs;
>> -} sPAPRDIMMState;
>> -
>> -static void spapr_lmb_release(DeviceState *dev, void *opaque)
>> -{
>> -    sPAPRDIMMState *ds = (sPAPRDIMMState *)opaque;
>> -    HotplugHandler *hotplug_ctrl;
>> -
>> -    if (--ds->nr_lmbs) {
>> -        return;
>> -    }
>> -
>> -    g_free(ds);
>> -
>> -    /*
>> -     * Now that all the LMBs have been removed by the guest, call the
>> -     * pc-dimm unplug handler to cleanup up the pc-dimm device.
>> -     */
>> -    hotplug_ctrl = qdev_get_hotplug_handler(dev);
>> -    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
>> -}
>> -
>>   static void spapr_del_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>>                              Error **errp)
>>   {
>> @@ -2636,7 +2645,7 @@ static void spapr_del_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>>           g_assert(drc);
>>   
>>           drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>> -        drck->detach(drc, dev, spapr_lmb_release, ds, errp);
>> +        drck->detach(drc, dev, ds, errp);
>>           addr += SPAPR_MEMORY_BLOCK_SIZE;
>>       }
>>   
>> @@ -2712,14 +2721,6 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>       object_unparent(OBJECT(dev));
>>   }
>>   
>> -static void spapr_core_release(DeviceState *dev, void *opaque)
>> -{
>> -    HotplugHandler *hotplug_ctrl;
>> -
>> -    hotplug_ctrl = qdev_get_hotplug_handler(dev);
>> -    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
>> -}
>> -
>>   static
>>   void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
>>                                  Error **errp)
>> @@ -2745,7 +2746,7 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
>>       g_assert(drc);
>>   
>>       drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>> -    drck->detach(drc, dev, spapr_core_release, NULL, &local_err);
>> +    drck->detach(drc, dev, NULL, &local_err);
>>       if (local_err) {
>>           error_propagate(errp, local_err);
>>           return;
>> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>> index a1cdc87..afe5d82 100644
>> --- a/hw/ppc/spapr_drc.c
>> +++ b/hw/ppc/spapr_drc.c
>> @@ -99,8 +99,8 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
>>           if (drc->awaiting_release) {
>>               if (drc->configured) {
>>                   trace_spapr_drc_set_isolation_state_finalizing(get_index(drc));
>> -                drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
>> -                             drc->detach_cb_opaque, NULL);
>> +                drck->detach(drc, DEVICE(drc->dev), drc->detach_cb_opaque,
>> +                                         NULL);
>>               } else {
>>                   trace_spapr_drc_set_isolation_state_deferring(get_index(drc));
>>               }
>> @@ -153,8 +153,8 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
>>           if (drc->awaiting_release &&
>>               drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
>>               trace_spapr_drc_set_allocation_state_finalizing(get_index(drc));
>> -            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
>> -                         drc->detach_cb_opaque, NULL);
>> +            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb_opaque,
>> +                         NULL);
>>           } else if (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
>>               drc->awaiting_allocation = false;
>>           }
>> @@ -405,12 +405,10 @@ static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>>   }
>>   
>>   static void detach(sPAPRDRConnector *drc, DeviceState *d,
>> -                   spapr_drc_detach_cb *detach_cb,
>>                      void *detach_cb_opaque, Error **errp)
>>   {
>>       trace_spapr_drc_detach(get_index(drc));
>>   
>> -    drc->detach_cb = detach_cb;
>>       drc->detach_cb_opaque = detach_cb_opaque;
>>   
>>       /* if we've signalled device presence to the guest, or if the guest
>> @@ -498,8 +496,7 @@ static void reset(DeviceState *d)
>>            * force removal if we are
>>            */
>>           if (drc->awaiting_release) {
>> -            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
>> -                         drc->detach_cb_opaque, NULL);
>> +            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb_opaque, NULL);
>>           }
>>   
>>           /* non-PCI devices may be awaiting a transition to UNUSABLE */
>> @@ -566,7 +563,8 @@ static void unrealize(DeviceState *d, Error **errp)
>>   
>>   sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
>>                                            sPAPRDRConnectorType type,
>> -                                         uint32_t id)
>> +                                         uint32_t id,
>> +                                         spapr_drc_detach_cb *detach_cb)
>>   {
>>       sPAPRDRConnector *drc =
>>           SPAPR_DR_CONNECTOR(object_new(TYPE_SPAPR_DR_CONNECTOR));
>> @@ -577,6 +575,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
>>       drc->type = type;
>>       drc->id = id;
>>       drc->owner = owner;
>> +    drc->detach_cb = detach_cb;
>>       prop_name = g_strdup_printf("dr-connector[%"PRIu32"]", get_index(drc));
>>       object_property_add_child(owner, prop_name, OBJECT(drc), NULL);
>>       object_property_set_bool(OBJECT(drc), true, "realized", NULL);
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index e7567e2..935e65e 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -1392,7 +1392,7 @@ static void spapr_phb_remove_pci_device(sPAPRDRConnector *drc,
>>   {
>>       sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>>   
>> -    drck->detach(drc, DEVICE(pdev), spapr_phb_remove_pci_device_cb, phb, errp);
>> +    drck->detach(drc, DEVICE(pdev), phb, errp);
>>   }
>>   
>>   static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
>> @@ -1764,7 +1764,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>>           for (i = 0; i < PCI_SLOT_MAX * 8; i++) {
>>               spapr_dr_connector_new(OBJECT(phb),
>>                                      SPAPR_DR_CONNECTOR_TYPE_PCI,
>> -                                   (sphb->index << 16) | i);
>> +                                   (sphb->index << 16) | i,
>> +                                   spapr_phb_remove_pci_device_cb);
>>           }
>>       }
>>   
>> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
>> index 5524247..0a2c173 100644
>> --- a/include/hw/ppc/spapr_drc.h
>> +++ b/include/hw/ppc/spapr_drc.h
>> @@ -189,7 +189,6 @@ typedef struct sPAPRDRConnectorClass {
>>       void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>>                      int fdt_start_offset, bool coldplug, Error **errp);
>>       void (*detach)(sPAPRDRConnector *drc, DeviceState *d,
>> -                   spapr_drc_detach_cb *detach_cb,
>>                      void *detach_cb_opaque, Error **errp);
>>       bool (*release_pending)(sPAPRDRConnector *drc);
>>       void (*set_signalled)(sPAPRDRConnector *drc);
>> @@ -197,7 +196,8 @@ typedef struct sPAPRDRConnectorClass {
>>   
>>   sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
>>                                            sPAPRDRConnectorType type,
>> -                                         uint32_t id);
>> +                                         uint32_t id,
>> +                                         spapr_drc_detach_cb *detach_cb);
>>   sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index);
>>   sPAPRDRConnector *spapr_dr_connector_by_id(sPAPRDRConnectorType type,
>>                                              uint32_t id);
