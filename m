Received: from eggs.gnu.org ([2001:4830:134:3::10]:53849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1duxU0-0000lm-Un
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1duxTx-0004Xp-OG
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:09:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48298
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1duxTx-0004XM-Hp
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:09:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8L98gFQ110242
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:09:16 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d462fc8h8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:09:16 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 05:09:15 -0400
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287474187.9760.12052550430995757993.stgit@aravinda>
	<20170817013934.GC5509@umbus.fritz.box>
	<555e187e-38af-d897-85b7-f08364b264fd@linux.vnet.ibm.com>
	<20170822020854.GY12356@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 14:39:06 +0530
MIME-Version: 1.0
In-Reply-To: <20170822020854.GY12356@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <98ef38a4-9c09-adec-6f0c-b280e5349d64@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com



On Tuesday 22 August 2017 07:38 AM, David Gibson wrote:

[ . . . ]

>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index 46012b3..eee8d33 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -123,6 +123,12 @@ struct sPAPRMachineState {
>>>>       * occurs during the unplug process. */
>>>>      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
>>>>  
>>>> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
>>>> +    target_ulong guest_machine_check_addr;
>>>> +    bool mc_in_progress;
>>>> +    int mc_cpu;
>>>
>>> mc_cpu isn't actually used yet in this patch.  In any case it and
>>> mc_in_progress could probably be folded together, no?
>>
>> It is possible to fold mc_cpu and mc_in_progress together with the
>> convention that if it is set to -1 mc is not in progress otherwise it is
>> set to the CPU handling the mc.
>>
>>>
>>> These values will also need to be migrated, AFAICT.
>>
>> I am thinking of how to handle the migration when machine check handling
>> is in progress. Probably wait for machine check handling to complete
>> before migrating as the error could be irrelevant once migrated to a new
>> hardware. If that is the case we don't need to migrate these values.
> 
> Ok.

This is what I think about handling machine check during migration based
on my understanding of the VM migration code.

There are two possibilities here. First, migration can be initiated
while the machine check handling is in progress. Second, A machine check
error can happen when the migration is in progress.

To handle the first case we can add migrate_add_blocker() call when we
start handling the machine check error and issue migrate_del_blocker()
when done. I think this should solve the issue.

The second case is bit tricky. The migration has already started and
hence migrate_add_blocker() call will fail. We also cannot wait till the
completion of the migration to handle machine check error as the VM's
data could be corrupt.

Machine check errors should not be an issue when the migration is in the
RAM copy phase as VM is still active with vCPUs running. The problem is
when we hit a machine check when the migration is about to complete. For
example,

1. vCPU2 hits a machine check error during migration.

2. KVM causes VM exit on vCPU2 and the NIP of vCPU2 is changed to the
guest registered machine check handler.

3. The migration_completion() issues vm_stop() and hence either vCPU2 is
never scheduled again on the source hardware or vCPU2 is preempted while
executing the machine check handler.

4. vCPU2 is resumed on the target hardware and either starts or
continues processing the machine check error. This could be a problem as
these errors are specific to the source hardware. For instance, when the
the guest issues memory poisoning upon such error, a clean page on the
target hardware is poisoned while the corrupt page on source hardware is
not poisoned.

The second case of hitting machine check during the final phase of
migration is rare but wanted to check what others think about it.

Regards,
Aravinda

> 
>>
>> Regards,
>> Aravinda
>>
>>>
>>>> +    QemuCond mc_delivery_cond;
>>>> +
>>>>      /*< public >*/
>>>>      char *kvm_type;
>>>>      MemoryHotplugState hotplug_memory;
>>>> @@ -519,8 +525,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>>>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
>>>>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>>>>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
>>>> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
>>>> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
>>>>  
>>>> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
>>>> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
>>>>  
>>>>  /* RTAS ibm,get-system-parameter token values */
>>>>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
>>>>
>>>
>>
> 

-- 
Regards,
Aravinda
