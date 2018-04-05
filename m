Received: from eggs.gnu.org ([2001:4830:134:3::10]:56283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f44Oq-0006Ft-Nr
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f44Om-0005y0-Of
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:53:56 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:35533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f44Om-0005xg-JE
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:53:52 -0400
Received: by mail-qt0-x22a.google.com with SMTP id s2so26758765qti.2
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 05:53:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180405012241.25714-1-f4bug@amsat.org>
	<20180405012241.25714-2-f4bug@amsat.org>
	<CAFEAcA9Qvjo680JX1yQRKLdqTcL1r7V42adaQrVDh3ne=jt8WQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eabfade9-5ac5-ce1f-8907-96943231c1ec@amsat.org>
Date: Thu, 5 Apr 2018 09:53:48 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Qvjo680JX1yQRKLdqTcL1r7V42adaQrVDh3ne=jt8WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] memory: Avoid to create tiny RAM
 regions, handled as subpages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 04/05/2018 06:27 AM, Peter Maydell wrote:
> On 5 April 2018 at 02:22, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> If an user creates a RAM region smaller than TARGET_PAGE_SIZE,
>> this region will be handled as a subpage.
>> While the subpage behavior can be noticed by an experienced QEMU
>> developper, it might takes hours to a novice to figure it out.
>> To save time to novices, do not allow subpage creation via the
>> memory_region_init_ram_*() functions.
> 
> This commit message doesn't make it clear to me what actually
> goes wrong. Why doesn't the subpage mechanism do the right thing
> here?

Trying to understand a bit more, I think the problem is "you can not
_execute_ from a region smaller than TARGET_PAGE_SIZE", however if this
region is used for I/O this is not a problem (the xilinx-pcie.c case).

In my case I create a 2K SRAM which contains the exception vectors, but
instructions are never fetched because it is handled as I/O.

I suppose my issue is between these two functions:

MemoryRegion *iotlb_to_region(CPUState *cpu, hwaddr index, MemTxAttrs attrs)
{
  int asidx = cpu_asidx_from_attrs(cpu, attrs);
  CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
  AddressSpaceDispatch *d = atomic_rcu_read(&cpuas->memory_dispatch);
  MemoryRegionSection *sections = d->map.sections;

  return sections[index & ~TARGET_PAGE_MASK].mr;
}

tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
{
  int mmu_idx, index, pd;
  void *p;
  MemoryRegion *mr;
  CPUState *cpu = ENV_GET_CPU(env);
  CPUIOTLBEntry *iotlbentry;
  hwaddr physaddr;

  index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
  mmu_idx = cpu_mmu_index(env, true);
  if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
               (addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK)))) {
      if (!VICTIM_TLB_HIT(addr_read, addr)) {
        tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
      }
  }
  iotlbentry = &env->iotlb[mmu_idx][index];
  pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
  mr = iotlb_to_region(cpu, pd, iotlbentry->attrs);
  if (memory_region_is_unassigned(mr)) {
    ...

> 
> Also, a quick grep revealed at least one caller that's currently
> creating a less-than-a-page sized RAM block, in
> hw/pci-host/xilinx-pcie.c. We would need to change all the
> call sites that rely on creating small RAM blocks before we
> could make this throw an error. (Better still would be if we
> could make small lumps of RAM actually work.)
