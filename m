Received: from eggs.gnu.org ([2001:4830:134:3::10]:54419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZzGs-0000hH-Jo
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZzGo-0003Hr-K9
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:16:50 -0500
Received: from greensocs.com ([193.104.36.180]:36504)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZzGo-0003Hb-5G
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:16:46 -0500
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
	<1486141597-13941-2-git-send-email-fred.konrad@greensocs.com>
	<20170204113056.GL12995@toto>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <cd45a0e4-6e27-e1a3-a987-81882e3fda78@greensocs.com>
Date: Sat, 4 Feb 2017 13:16:43 +0100
MIME-Version: 1.0
In-Reply-To: <20170204113056.GL12995@toto>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/5] cputlb: cleanup get_page_addr_code to
 use VICTIM_TLB_HIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair.francis@xilinx.com, pbonzini@redhat.com, clg@kaod.org, mark.burton@greensocs.com

On 02/04/2017 12:30 PM, Edgar E. Iglesias wrote:
> On Fri, Feb 03, 2017 at 06:06:33PM +0100, fred.konrad@greensocs.com wrote:
>> From: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> This replaces env1 and page_index variables by env and index
>> so we can use VICTIM_TLB_HIT macro later.
>>
> 
> Hi Fred,
> 
> A question, wouldn't it be more readable to add env and index arguments to VICTIM_TLB_HIT?
> VICTIM_TLB_HIT could perhaps even be made a static inline?
> 
> Cheers,
> Edgar

Hi Edgar,

Well it seems the VICTIM_TLB_HIT macro is just here to hide those
variables actually.

in cputlb.c:
static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx,
                           size_t index, size_t elt_ofs,
                           target_ulong page)

and then:
/* Macro to call the above, with local variables from the use context.  */
#define VICTIM_TLB_HIT(TY, ADDR) \
  victim_tlb_hit(env, mmu_idx, index, offsetof(CPUTLBEntry, TY), \
                 (ADDR) & TARGET_PAGE_MASK)

My point of view is clearly that it makes more difficult to read.
So if everybody agrees I can drop the macro and call directly
victim_tlb_hit.

Fred


> 
> 
>  
>> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>> ---
>>  cputlb.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/cputlb.c b/cputlb.c
>> index 6c39927..665caea 100644
>> --- a/cputlb.c
>> +++ b/cputlb.c
>> @@ -457,21 +457,21 @@ static void report_bad_exec(CPUState *cpu, target_ulong addr)
>>   * is actually a ram_addr_t (in system mode; the user mode emulation
>>   * version of this function returns a guest virtual address).
>>   */
>> -tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
>> +tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>>  {
>> -    int mmu_idx, page_index, pd;
>> +    int mmu_idx, index, pd;
>>      void *p;
>>      MemoryRegion *mr;
>> -    CPUState *cpu = ENV_GET_CPU(env1);
>> +    CPUState *cpu = ENV_GET_CPU(env);
>>      CPUIOTLBEntry *iotlbentry;
>>  
>> -    page_index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>> -    mmu_idx = cpu_mmu_index(env1, true);
>> -    if (unlikely(env1->tlb_table[mmu_idx][page_index].addr_code !=
>> +    index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>> +    mmu_idx = cpu_mmu_index(env, true);
>> +    if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
>>                   (addr & TARGET_PAGE_MASK))) {
>> -        cpu_ldub_code(env1, addr);
>> +        cpu_ldub_code(env, addr);
>>      }
>> -    iotlbentry = &env1->iotlb[mmu_idx][page_index];
>> +    iotlbentry = &env->iotlb[mmu_idx][index];
>>      pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
>>      mr = iotlb_to_region(cpu, pd, iotlbentry->attrs);
>>      if (memory_region_is_unassigned(mr)) {
>> @@ -484,7 +484,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
>>              exit(1);
>>          }
>>      }
>> -    p = (void *)((uintptr_t)addr + env1->tlb_table[mmu_idx][page_index].addend);
>> +    p = (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].addend);
>>      return qemu_ram_addr_from_host_nofail(p);
>>  }
>>  
>> -- 
>> 1.8.3.1
>>
