Received: from eggs.gnu.org ([2001:4830:134:3::10]:44425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gZA8o-0003kZ-Cl
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gZA8j-0005te-BS
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:50:10 -0500
References: <20181217140055.8545-1-lvivier@redhat.com>
	<20181218042938.GI23604@umbus.fritz.box>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <8cf7e664-27e6-d4f4-ea71-29a61a3122e6@redhat.com>
Date: Tue, 18 Dec 2018 08:50:00 +0100
MIME-Version: 1.0
In-Reply-To: <20181218042938.GI23604@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: Add H-Call H_HOME_NODE_ASSOCIATIVITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 18/12/2018 05:29, David Gibson wrote:
> On Mon, Dec 17, 2018 at 03:00:55PM +0100, Laurent Vivier wrote:
>> H_HOME_NODE_ASSOCIATIVITY H-Call returns the associativity domain
>> designation associated with the identifier input parameter.
>>
>> Remove the warning message from the kernel:
>>   VPHN is not supported. Disabling polling..
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> From the looks of PAPR, I suspect this call isn't of much use outside
> PowerVM guests, though it probably wouldn't do any harm.

This call is used by the kernel to get the node id of a CPU on hotplug
and fixes a crash when we hotplug a CPU in a memory-less/CPU-less node
where this information is missing (not initialized from the device-tree).

> BenH, Paulus, any thoughts?
> 
> One nit in implementation: if you implement this hcall, it's supposed
> to be advertised by adding hcall-vphn to ibm,hypertas-functions.
ok  in v2.

Thanks,
Laurent

>> ---
>> Based-on: <20181213040126.6768-1-david@gibson.dropbear.id.au>
>>           "[PULL 00/27] ppc-for-4.0 queue 20181213"
>>
>>  hw/ppc/spapr_hcall.c   | 39 +++++++++++++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |  1 +
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 78fecc8fe9..454ec594fd 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1663,6 +1663,41 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>      return H_SUCCESS;
>>  }
>>  
>> +static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
>> +                                              sPAPRMachineState *spapr,
>> +                                              target_ulong opcode,
>> +                                              target_ulong *args)
>> +{
>> +    target_ulong flags = args[0];
>> +    target_ulong procno = args[1];
>> +    PowerPCCPU *tcpu;
>> +    int idx;
>> +
>> +    /* only support procno from H_REGISTER_VPA */
>> +    if ((flags & 0x1) == 0) {
>> +        return H_PARAMETER;
>> +    }
>> +
>> +    tcpu = spapr_find_cpu(procno);
>> +    if (tcpu == NULL) {
>> +        return H_P2;
>> +    }
>> +
>> +    /* sequence is the same as in the "ibm,associativity" property */
>> +
>> +    idx = 0;
>> +#define ASSOCIATIVITY(a, b) (((uint64_t)a << 32) | ((uint64_t)b & 0xffffffff))
>> +    args[idx++] = ASSOCIATIVITY(0, 0);
>> +    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
>> +    args[idx++] = ASSOCIATIVITY(procno, -1);
>> +    for ( ; idx < 6; idx++) {
>> +        args[idx] = -1;
>> +    }
>> +#undef ASSOCIATIVITY
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>>  static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>>                                                sPAPRMachineState *spapr,
>>                                                target_ulong opcode,
>> @@ -1864,6 +1899,10 @@ static void hypercall_register_types(void)
>>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
>>  
>>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
>> +
>> +    /* Virtual Processor Home Node */
>> +    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
>> +                             h_home_node_associativity);
>>  }
>>  
>>  type_init(hypercall_register_types)
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index b1a2515107..eb13e2b614 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -447,6 +447,7 @@ struct sPAPRMachineState {
>>  #define H_GET_EM_PARMS          0x2B8
>>  #define H_SET_MPP               0x2D0
>>  #define H_GET_MPP               0x2D4
>> +#define H_HOME_NODE_ASSOCIATIVITY 0x2EC
>>  #define H_XIRR_X                0x2FC
>>  #define H_RANDOM                0x300
>>  #define H_SET_MODE              0x31C
> 
