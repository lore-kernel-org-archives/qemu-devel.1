Received: from eggs.gnu.org ([209.51.188.92]:41095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hJWcE-0003fQ-09
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hJWQo-0005ea-Vd
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 00:56:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hJWQo-0005c5-LF
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 00:56:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3P4s84T123403
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 00:56:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s32fbfwgp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 00:56:18 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Thu, 25 Apr 2019 05:56:17 +0100
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591657807.20338.12115795588476734752.stgit@aravinda>
	<20190423064536.GD31496@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2019 10:26:10 +0530
MIME-Version: 1.0
In-Reply-To: <20190423064536.GD31496@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <79e1775f-ff5f-edc4-bd05-e4fd89bd59b5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/6] ppc: spapr: Handle "ibm,
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
Cc: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org, mahesh@linux.vnet.ibm.com



On Tuesday 23 April 2019 12:15 PM, David Gibson wrote:
> On Mon, Apr 22, 2019 at 12:32:58PM +0530, Aravinda Prasad wrote:
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
>> processor that also received a machine check error waits
>> till the first processor is done reading the error log.
>> The first processor issues "ibm,nmi-interlock" call
>> when the error log is consumed. This patch implements the
>> releasing part of the error-log while subsequent patch
>> (which builds error log) handles the locking part.
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Although I wonder if it needs to be moved later in the series to avoid
> advertising the availability of the RTAS calls to the guest before all
> the prereq patches are in place to make them work properly.

Patch 3 and 4 uses "guest_machine_check_addr", which is set in this
patch. If we push this beyond patch 4, then I feel the use of
"guest_machine_check_addr" looks odd in patch 3 and 4.

Regards,
Aravinda

> 
>> ---
>>  hw/ppc/spapr.c         |   18 ++++++++++++++
>>  hw/ppc/spapr_rtas.c    |   61 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |    9 ++++++-
>>  3 files changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index c56939a..6642cb5 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1805,6 +1805,11 @@ static void spapr_machine_reset(void)
>>      first_ppc_cpu->env.gpr[5] = 0;
>>  
>>      spapr->cas_reboot = false;
>> +
>> +    spapr->guest_machine_check_addr = -1;
>> +
>> +    /* Signal all vCPUs waiting on this condition */
>> +    qemu_cond_broadcast(&spapr->mc_delivery_cond);
>>  }
>>  
>>  static void spapr_create_nvram(SpaprMachineState *spapr)
>> @@ -2095,6 +2100,16 @@ static const VMStateDescription vmstate_spapr_dtb = {
>>      },
>>  };
>>  
>> +static const VMStateDescription vmstate_spapr_machine_check = {
>> +    .name = "spapr_machine_check",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>  static const VMStateDescription vmstate_spapr = {
>>      .name = "spapr",
>>      .version_id = 3,
>> @@ -2127,6 +2142,7 @@ static const VMStateDescription vmstate_spapr = {
>>          &vmstate_spapr_dtb,
>>          &vmstate_spapr_cap_large_decr,
>>          &vmstate_spapr_cap_ccf_assist,
>> +        &vmstate_spapr_machine_check,
>>          NULL
>>      }
>>  };
>> @@ -3068,6 +3084,8 @@ static void spapr_machine_init(MachineState *machine)
>>  
>>          kvmppc_spapr_enable_inkernel_multitce();
>>      }
>> +
>> +    qemu_cond_init(&spapr->mc_delivery_cond);
>>  }
>>  
>>  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index ee24212..c2f3991 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -348,6 +348,39 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>      rtas_st(rets, 1, 100);
>>  }
>>  
>> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>> +                                  SpaprMachineState *spapr,
>> +                                  uint32_t token, uint32_t nargs,
>> +                                  target_ulong args,
>> +                                  uint32_t nret, target_ulong rets)
>> +{
>> +    uint64_t rtas_addr = spapr_get_rtas_addr();
>> +
>> +    if (!rtas_addr) {
>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>> +        return;
>> +    }
>> +
>> +    spapr->guest_machine_check_addr = rtas_ld(args, 1);
>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +}
>> +
>> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>> +                                   SpaprMachineState *spapr,
>> +                                   uint32_t token, uint32_t nargs,
>> +                                   target_ulong args,
>> +                                   uint32_t nret, target_ulong rets)
>> +{
>> +    if (!spapr->guest_machine_check_addr) {
>> +        /* NMI register not called */
>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>> +    } else {
>> +        qemu_cond_signal(&spapr->mc_delivery_cond);
>> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +    }
>> +}
>> +
>> +
>>  static struct rtas_call {
>>      const char *name;
>>      spapr_rtas_fn fn;
>> @@ -466,6 +499,30 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr)
>>      }
>>  }
>>  
>> +uint64_t spapr_get_rtas_addr(void)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    int rtas_node;
>> +    const struct fdt_property *rtas_addr_prop;
>> +    void *fdt = spapr->fdt_blob;
>> +    uint32_t rtas_addr;
>> +
>> +    /* fetch rtas addr from fdt */
>> +    rtas_node = fdt_path_offset(fdt, "/rtas");
>> +    if (rtas_node == 0) {
>> +        return 0;
>> +    }
>> +
>> +    rtas_addr_prop = fdt_get_property(fdt, rtas_node, "linux,rtas-base", NULL);
>> +    if (!rtas_addr_prop) {
>> +        return 0;
>> +    }
>> +
>> +    rtas_addr = fdt32_to_cpu(*(uint32_t *)rtas_addr_prop->data);
>> +    return (uint64_t)rtas_addr;
>> +}
>> +
>> +
>>  static void core_rtas_register_types(void)
>>  {
>>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
>> @@ -489,6 +546,10 @@ static void core_rtas_register_types(void)
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
>> index 7e32f30..ec6f33e 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -187,6 +187,10 @@ struct SpaprMachineState {
>>       * occurs during the unplug process. */
>>      QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
>>  
>> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
>> +    target_ulong guest_machine_check_addr;
>> +    QemuCond mc_delivery_cond;
>> +
>>      /*< public >*/
>>      char *kvm_type;
>>      char *host_model;
>> @@ -623,8 +627,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
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
>> @@ -874,4 +880,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
>>  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
>>  
>>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>> +uint64_t spapr_get_rtas_addr(void);
>>  #endif /* HW_SPAPR_H */
>>
> 

-- 
Regards,
Aravinda
