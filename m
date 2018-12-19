Received: from eggs.gnu.org ([2001:4830:134:3::10]:53894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gZeew-0005Cc-UK
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gZeep-0006Ny-5i
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:25:19 -0500
References: <20181218131829.5135-1-lvivier@redhat.com>
	<20181218171032.308026c5@bahia.lan>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <28b963d3-a42e-1f6c-a8b5-34445f4af698@redhat.com>
Date: Wed, 19 Dec 2018 17:25:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181218171032.308026c5@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] spapr: Add H-Call
 H_HOME_NODE_ASSOCIATIVITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 18/12/2018 17:10, Greg Kurz wrote:
> On Tue, 18 Dec 2018 14:18:29 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
> 
>> H_HOME_NODE_ASSOCIATIVITY H-Call returns the associativity domain
>> designation associated with the identifier input parameter
>>
>> This fixes a crash when we try to hotplug a CPU in memory-less and
>> CPU-less numa node. In this case, the kernel tries to online the
>> node, but without the information provided by this h-call, the node id,
>> it cannot and the CPU is started while the node is not onlined.
>>
>> It also removes the warning message from the kernel:
>>   VPHN is not supported. Disabling polling..
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>
>> Notes:
>>     v2:
>>       add hcall-vphn to ibm,hypertas-functions
>>       correctly check flags
>>       return H_FUNCTION rather than H_PARAMETER
>>       update description
>>
>>  hw/ppc/spapr.c         |  1 +
>>  hw/ppc/spapr_hcall.c   | 39 +++++++++++++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |  1 +
>>  3 files changed, 41 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 7a0ab2da54..d961272c8a 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1049,6 +1049,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
>>      add_str(hypertas, "hcall-sprg0");
>>      add_str(hypertas, "hcall-copy");
>>      add_str(hypertas, "hcall-debug");
>> +    add_str(hypertas, "hcall-vphn");
>>      add_str(qemu_hypertas, "hcall-memop1");
>>  
>>      if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 78fecc8fe9..a48adb3cfb 100644
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
>> +    if (flags != 0x1) {
>> +        return H_FUNCTION;
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
> 
> It would be safer to have parens around a and b.

I agree

>> +    args[idx++] = ASSOCIATIVITY(0, 0);
>> +    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
>> +    args[idx++] = ASSOCIATIVITY(procno, -1);
> 
> The returned values are supposed to be a stream of mixed 16-bit and 32-bit
> values, _insanely_ encoded as follows:
> 
> The high order bit of each 2 byte field is a length specifier:
>  1: The associativity domain number is contained in the low order 15 bits of the
>     field,
>  0: The associativity domain number is contained in the low order 15 bits of the
>     current field concatenated with the 16 bits of the next sequential field)
> 
> ie, usable values are either 31-bit, either 15-bit.
> 
> I don't see such an encoding taking place in the code... this may cause
> problems if node_id >= 0x80000000: the guest will only get bits 30:16,
> and consider bits 15:0 to belong to the next field, which may in turn
> be considered as a 15-bit value or combined with the top 16-bits of
> procno to form a bogus 31-bit value... :-\

> I guess it is okay to go with the "long" variant for everyone since you
> only have 5 of them, but you could also use the "short" variant when
> values are < 0x10000.
> 
> And in any case, it seems we have to limit node ids and vcpu ids to be
> 31 bits if we're to support this interface.

>From PowerPCCPU, node_id is an int32_t, vcpu_id is an "int", and node id
 and cpu id cannot be negative, so the value encoded are already 31bit
values. Moreover, in NumaNodeOptions (see qapi/misc.json) nodeid and
cpus are uint16.

So I think we don't have to check the bit 31 of these values.

I don't want to manage the 15bit encoding because the list is hard coded
and I want to keep it simple.

Thanks,
Laurent
