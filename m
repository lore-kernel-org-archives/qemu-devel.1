Received: from eggs.gnu.org ([2001:4830:134:3::10]:40301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dzG7Q-00044P-RO
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 01:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dzG7N-00071t-K7
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 01:51:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dzG7N-00071I-Al
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 01:51:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v935nfLE005374
	for <qemu-devel@nongnu.org>; Tue, 3 Oct 2017 01:51:40 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dbtbqua3y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 01:51:39 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Tue, 3 Oct 2017 01:51:38 -0400
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659506894.25889.3558250496380782854.stgit@aravinda>
	<20170929064929.GF7712@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Tue, 3 Oct 2017 11:21:27 +0530
MIME-Version: 1.0
In-Reply-To: <20170929064929.GF7712@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <911fd6ef-8931-aa40-8dbf-1d2dbb9ab800@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/6] ppc: spapr: Handle "ibm,
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



On Friday 29 September 2017 12:19 PM, David Gibson wrote:
> I don't suppose there's a way to stop your mailer from inserting
> spaces after the commas in the subject line,

Not sure how to stop the mailer from doing this as I don't have any
spaces in the subject line of my actual patch.

> 
> 
> On Thu, Sep 28, 2017 at 04:07:48PM +0530, Aravinda Prasad wrote:
>> This patch adds support in QEMU to handle "ibm,nmi-register"
>> and "ibm,nmi-interlock" RTAS calls.
>>
>> The machine check notification address is saved when the
>> OS issues "ibm,nmi-register" RTAS call.
>>
>> This patch also handles the case when multiple processors
>> experience machine check at or about the same time by
>> handling "ibm,nmi-interlock" call. In such cases, as per
>> PAPR, subsequent processors serialize waiting for the first
>> processor to issue the "ibm,nmi-interlock" call. The second
>> processor waits till the first processor, which also
>> received a machine check error, is done reading the error
>> log. The first processor issues "ibm,nmi-interlock" call
>> when the error log is consumed. This patch implements the
>> releasing part of the error-log while subsequent patch
>> (which builds error log) handles the locking part.
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  hw/ppc/spapr.c         |    8 ++++++++
>>  hw/ppc/spapr_rtas.c    |   35 +++++++++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |   11 ++++++++++-
>>  3 files changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 5deae30..d568ea6 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1477,6 +1477,11 @@ static void ppc_spapr_reset(void)
>>      first_ppc_cpu->env.nip = SPAPR_ENTRY_POINT;
>>  
>>      spapr->cas_reboot = false;
>> +
>> +    spapr->mc_status = -1;
>> +    spapr->guest_machine_check_addr = 0;
> 
> You should probably use -1 as the default for this - strictly speaking
> the guest could legitimately choose to have it's machine check
> processing code at 0, though it would be a strange choice.

Sure.

> 
>> +    qemu_cond_destroy(&spapr->mc_delivery_cond);
>> +    qemu_cond_init(&spapr->mc_delivery_cond);
> 
> What will this do if one of the vcpus is waiting on the condition
> variable right now?  I suspect you're going to need to first wake up
> the queue, and marshal any blocked vcpus back into dead mode instead
> of this.

Do we need to wake-up the queue as the system, anyway, is being reset?

> 
>>  }
>>  
>>  static void spapr_create_nvram(sPAPRMachineState *spapr)
>> @@ -2598,6 +2603,9 @@ static void ppc_spapr_init(MachineState *machine)
>>  
>>          kvmppc_spapr_enable_inkernel_multitce();
>>      }
>> +
>> +    spapr->mc_status = -1;
>> +    qemu_cond_init(&spapr->mc_delivery_cond);
>>  }
>>  
>>  static int spapr_kvm_type(const char *vm_type)
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index cdf0b60..08e9a5e 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -348,6 +348,37 @@ static void rtas_get_power_level(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>>      rtas_st(rets, 1, 100);
>>  }
>>  
>> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>> +                                  sPAPRMachineState *spapr,
>> +                                  uint32_t token, uint32_t nargs,
>> +                                  target_ulong args,
>> +                                  uint32_t nret, target_ulong rets)
>> +{
>> +    spapr->guest_machine_check_addr = rtas_ld(args, 1);
>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +}
>> +
>> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>> +                                   sPAPRMachineState *spapr,
>> +                                   uint32_t token, uint32_t nargs,
>> +                                   target_ulong args,
>> +                                   uint32_t nret, target_ulong rets)
>> +{
>> +    if (!spapr->guest_machine_check_addr) {
>> +        /* NMI register not called */
>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>> +    } else {
>> +        /*
>> +         * VCPU issuing "ibm,nmi-interlock" is done with NMI handling,
>> +         * hence unset mc_status.
>> +         */
>> +        spapr->mc_status = -1;
>> +        qemu_cond_signal(&spapr->mc_delivery_cond);
>> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +    }
>> +}
>> +
>> +
>>  static struct rtas_call {
>>      const char *name;
>>      spapr_rtas_fn fn;
>> @@ -489,6 +520,10 @@ static void core_rtas_register_types(void)
>>                          rtas_set_power_level);
>>      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
>>                          rtas_get_power_level);
>> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
>> +                        rtas_ibm_nmi_register);
>> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
>> +                        rtas_ibm_nmi_interlock);
>>  }
>>  
>>  type_init(core_rtas_register_types)
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index b395aa7..28b6e2e 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -124,6 +124,13 @@ struct sPAPRMachineState {
>>       * occurs during the unplug process. */
>>      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
>>  
>> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
>> +    target_ulong guest_machine_check_addr;
> 
> You need to migrate this.  This is separate and simpler from the
> problems of migrating during machine check handling - at the moment if
> the guest calls nmi-register, then you migrate, then a machine check
> is triggered you will have lost the information on how to handle it
> properly.

I missed it. Will include.

Regards,
Aravinda

> 
> 
>> +    /* mc_status is set to -1 if mc is not in progress, else is set to the CPU
>> +     * handling the mc. */
>> +    int mc_status;
>> +    QemuCond mc_delivery_cond;
>> +
>>      /*< public >*/
>>      char *kvm_type;
>>      MemoryHotplugState hotplug_memory;
>> @@ -520,8 +527,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
>>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
>> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
>> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
>>  
>> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
>> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
>>  
>>  /* RTAS ibm,get-system-parameter token values */
>>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
>>
> 

-- 
Regards,
Aravinda
