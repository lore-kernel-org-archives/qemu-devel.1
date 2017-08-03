Received: from eggs.gnu.org ([2001:4830:134:3::10]:45059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1ddEvq-0008QG-P4
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1ddEvn-0004pn-QE
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:08:50 -0400
References: <1501577097-14248-1-git-send-email-frederic.konrad@adacore.com>
	<abac426c-5db4-7dd7-a727-880b60f5e9be@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <ef01b959-763d-35b0-0aa7-cf16288badb8@adacore.com>
Date: Thu, 3 Aug 2017 14:08:19 +0200
MIME-Version: 1.0
In-Reply-To: <abac426c-5db4-7dd7-a727-880b60f5e9be@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH] booke206: fix MAS update on
 tlb miss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org



On 08/03/2017 01:37 PM, Thomas Huth wrote:
> On 01.08.2017 10:44, KONRAD Frederic wrote:
>> When a tlb instruction miss happen, rw is set to 0 at the bottom
>> of cpu_ppc_handle_mmu_fault which cause the MAS update function to miss
>> the SAS and TS bit in MAS6, MAS1 in booke206_update_mas_tlb_miss.
>>
>> Just calling booke206_update_mas_tlb_miss with rw = 2 solve the issue.
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   target/ppc/mmu_helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
>> index b7b9088..f06b938 100644
>> --- a/target/ppc/mmu_helper.c
>> +++ b/target/ppc/mmu_helper.c
>> @@ -1551,7 +1551,7 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *env, target_ulong address,
>>                       env->spr[SPR_40x_ESR] = 0x00000000;
>>                       break;
>>                   case POWERPC_MMU_BOOKE206:
>> -                    booke206_update_mas_tlb_miss(env, address, rw);
>> +                    booke206_update_mas_tlb_miss(env, address, 2);
> 
Hi Thomas,

> Couldn't that code path be called for normal data read miss (instead of
> instruction miss), too?
> 

I don't think so because we have access_type == ACCESS_CODE and
the code in cpu_ppc_handle_mmu_fault explicitely split the CODE
and DATA cases.

> Anyway, could we please use MMU_INST_FETCH instead of magic values like
> 2 here?

I agree it's not nice to have a magic value like this.. But it's
used all over the code there and david took the patch.

So I suggest I send a second patch to fix all the instances of
that magic value.

Fred

> 
>   Thomas
> 
> 
