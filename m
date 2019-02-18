Received: from eggs.gnu.org ([209.51.188.92]:49755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqLS-0001re-EZ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqLQ-0005bE-AA
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:20:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqLM-0005Xm-7i
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:20:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so481453wmb.3
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:20:46 -0800 (PST)
References: <20190215170029.15641-1-clg@kaod.org>
	<20190215170029.15641-3-clg@kaod.org>
	<20190218064709.GD9345@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8dbdf821-503c-1811-c2ed-90efb8b7cc1b@redhat.com>
Date: Mon, 18 Feb 2019 22:20:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190218064709.GD9345@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/12] target/ppci/mmu: Use LPCR:HR to
 chose radix vs. hash translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

On 2/18/19 7:47 AM, David Gibson wrote:
> On Fri, Feb 15, 2019 at 06:00:19PM +0100, Cédric Le Goater wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>> Now that LPCR:HR is set properly for SPAPR, use it for deciding
>> the translation type, which also works for bare metal

"ppci" -> "ppc" in patch title.

>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
>> ---
>>  target/ppc/mmu-book3s-v3.h | 14 +++++++++-----
>>  target/ppc/mmu-book3s-v3.c | 11 ++++++++++-
>>  target/ppc/mmu_helper.c    |  9 ++-------
>>  3 files changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
>> index fdf80987d7b2..41b77158622a 100644
>> --- a/target/ppc/mmu-book3s-v3.h
>> +++ b/target/ppc/mmu-book3s-v3.h
>> @@ -43,14 +43,18 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)
>>      return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
>>  }
>>  
>> -static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
>> +/*
>> + * The LPCR:HR bit is a shortcut that avoids having to
>> + * dig out the partition table in the fast path. This is
>> + * also how the HW uses it.
>> + */
>> +static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
>>  {
>> -    PPCVirtualHypervisorClass *vhc =
>> -        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>> -
>> -    return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
>> +    return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
>>  }
>>  
>> +hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr);
>> +
>>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>                                int mmu_idx);
>>  
>> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
>> index b60df4408f3b..a174e7efc57c 100644
>> --- a/target/ppc/mmu-book3s-v3.c
>> +++ b/target/ppc/mmu-book3s-v3.c
>> @@ -26,9 +26,18 @@
>>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>                                int mmu_idx)
>>  {
>> -    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
>> +    if (ppc64_v3_radix(cpu)) { /* Guest uses radix */
>>          return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
>>      } else { /* Guest uses hash */
>>          return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
>>      }
>>  }
>> +
>> +hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr)
>> +{
>> +    if (ppc64_v3_radix(cpu)) {
>> +        return ppc_radix64_get_phys_page_debug(cpu, eaddr);
>> +    } else {
>> +        return ppc_hash64_get_phys_page_debug(cpu, eaddr);
>> +    }
>> +}
>> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
>> index cefed34da4f2..ae81ee18ae95 100644
>> --- a/target/ppc/mmu_helper.c
>> +++ b/target/ppc/mmu_helper.c
>> @@ -1342,7 +1342,7 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
>>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>>          break;
>>      case POWERPC_MMU_3_00:
>> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
>> +        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
>>              /* TODO - Unsupported */
>>          } else {
>>              dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>> @@ -1497,12 +1497,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>>      case POWERPC_MMU_2_07:
>>          return ppc_hash64_get_phys_page_debug(cpu, addr);
>>      case POWERPC_MMU_3_00:
>> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
>> -            return ppc_radix64_get_phys_page_debug(cpu, addr);
>> -        } else {
>> -            return ppc_hash64_get_phys_page_debug(cpu, addr);
>> -        }
>> -        break;
>> +        return ppc64_v3_get_phys_page_debug(cpu, addr);
>>  #endif
>>  
>>      case POWERPC_MMU_32B:
> 
