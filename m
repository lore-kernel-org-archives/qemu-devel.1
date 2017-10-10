Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1e1wM5-00015Q-4g
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1e1wM0-0000VK-Hl
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:22:01 -0400
References: <20171010132159.15787-1-david@gibson.dropbear.id.au>
	<20171010164431.168777e9@bahia.lan>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <955ac977-e20b-4c55-bbaa-a51c41f2bed3@redhat.com>
Date: Tue, 10 Oct 2017 17:21:53 +0200
MIME-Version: 1.0
In-Reply-To: <20171010164431.168777e9@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: Correct RAM size calculation for
 HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 10/10/2017 16:44, Greg Kurz wrote:
> On Wed, 11 Oct 2017 00:21:59 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> In order to prevent the guest from forcing the allocation of large amounts
>> of qemu memory (or host kernel memory, in the case of KVM HV), we limit
>> the size of Hashed Page Table (HPT) it is allowed to allocated, based on
>> its RAM size.
>>
>> However, the current calculation is not correct: it only adds up the size
>> of plugged memory, ignoring the base memory size.  This patch corrects it.
>>
>> While we're there, use get_plugged_memory_size() instead of directly
>> calling pc_existing_dimms_capacity().  The only difference is that it
>> will abort on failure, which is right: a failure here indicates something
>> wrong within qemu.
>>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/ppc/spapr_hcall.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 8d72bb7c1c..06af1b15c0 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -494,7 +494,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
>>          return H_PARAMETER;
>>      }
>>  
>> -    current_ram_size = pc_existing_dimms_capacity(&error_fatal);
>> +    current_ram_size = ram_size + get_plugged_memory_size();
> 
> current_ram_size is initialized earlier in this function:
> 
>     uint64_t current_ram_size = MACHINE(spapr)->ram_size;
> 
> which is is initialized to ram_size in vl.c. Why not doing:
> 
>     current_ram_size += get_plugged_memory_size();
> 
> ?

I agree, it seems like the original intend of the first patch...

Thanks,
Laurent
