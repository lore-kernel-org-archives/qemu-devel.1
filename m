Received: from eggs.gnu.org ([209.51.188.92]:52320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hM2hG-0007eV-9e
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hM2hE-0006Uz-Hh
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:47:46 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:32806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hM2hC-0006NE-MU
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:47:43 -0400
Received: by mail-pg1-x541.google.com with SMTP id k19so432659pgh.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 20:47:39 -0700 (PDT)
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
	<20190501053522.10967-2-sjitindarsingh@gmail.com>
	<11cb0515-7a96-99af-f33b-c752603a189d@ozlabs.ru>
	<20190502004346.GC13618@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c0917aef-79cc-f42c-2f4c-6d26da9657d6@ozlabs.ru>
Date: Thu, 2 May 2019 13:47:32 +1000
MIME-Version: 1.0
In-Reply-To: <20190502004346.GC13618@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] ppc: Add dump-stack implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, dgilbert@redhat.com, armbru@redhat.com



On 02/05/2019 10:43, David Gibson wrote:
> On Wed, May 01, 2019 at 07:48:48PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 01/05/2019 15:35, Suraj Jitindar Singh wrote:
>>> The monitor function dump-stack is used to dump the stack for a cpu.
>>> This can be useful for debugging purposes when the stack cannot be
>>> dumped by another means.
>>>
>>> Add a ppc implementation ppc_cpu_dump_stack().
>>> The stack pointer is stored in R1 with the back pointer at offset 0 and
>>> the link register at offset 2.
>>> Also dump the registers from the stack frame if the marker "regshere" is
>>> found.
>>
>> Is this a Linux only marker? ABI does not mentioned this.
>>
>>> This only dumps the kernel stack, stopping if a non-kernel address is
>>> found in the stack.
>>
>> Why enforce this limit?
> 
> It's also making a Linux specific assumption about addresses.


It does not have to if it used ppc_cpu_get_phys_page_debug(), the only
linux specific left is that "regshere" marker, otherwise it could work
for AIX or FreeBSD (obviously without the exception frame).


> 
>>
>>>
>>> Sample output:
>>> (qemu) dump-stack
>>> sp: 0xc00000007bfc5690 lr: 0xc0000000000974b8
>>> sp: 0xc00000007bfc56f0 lr: 0xc00000000065aab4
>>> sp: 0xc00000007bfc5720 lr: 0xc00000000065ab04
>>> sp: 0xc00000007bfc5740 lr: 0xc0000000000c29b8
>>> sp: 0xc00000007bfc57b0 lr: 0xc0000000000bc9e8
>>> sp: 0xc00000007bfc57e0 lr: 0xc0000000000bd584
>>> sp: 0xc00000007bfc5800 lr: 0xc0000000000bee14
>>> sp: 0xc00000007bfc5ac0 lr: 0xc0000000000c2100
>>> sp: 0xc00000007bfc5c60 lr: 0xc000000000029460
>>> sp: 0xc00000007bfc5ca0 lr: 0xc00000000010b5e8
>>> sp: 0xc00000007bfc5d00 lr: 0xc000000000105f34
>>> 	trap : 0x0000000000000700
>>> 	pc   : 0xc000000000104490
>>> 	msr  : 0x9000000002843003
>>> 	lr   : 0xc000000000103ffc
>>> 	gpr 0: 0x0000000000000001
>>> 	gpr 1: 0xc00000005051f530
>>> 	gpr 2: 0xc000000001088200
>>> 	gpr 3: 0x0000000000000001
>>> 	gpr 4: 0xc000000032d60000
>>> 	gpr 5: 0xc0000000014b8f00
>>> 	gpr 6: 0x0000000000c835e0
>>> 	gpr 7: 0x0000000000000000
>>> 	gpr 8: 0x0000000000000000
>>> 	gpr 9: 0xc000000032f00000
>>> 	gpr10: 0x9000000002803033
>>> 	gpr11: 0xc000000000b60f00
>>> 	gpr12: 0x0000000000002000
>>> 	gpr13: 0xc000000001250000
>>> 	gpr14: 0x0000000000000000
>>> 	gpr15: 0x0000000000000008
>>> 	gpr16: 0x0000000000000000
>>> 	gpr17: 0xc00000000114f790
>>> 	gpr18: 0x00000000ffffffff
>>> 	gpr19: 0xc00000005051f8e8
>>> 	gpr20: 0x0000000000000001
>>> 	gpr21: 0x0000000000000000
>>> 	gpr22: 0x0000000000000001
>>> 	gpr23: 0x0000000000000001
>>> 	gpr24: 0x0000000000000001
>>> 	gpr25: 0xc0000000014b8f70
>>> 	gpr26: 0x0000000000000000
>>> 	gpr27: 0x0000000000000001
>>> 	gpr28: 0x0000000000000001
>>> 	gpr29: 0x0000000000000000
>>> 	gpr30: 0xc0000000014b8f00
>>> 	gpr31: 0xc0000000014b8f00
>>
>> Looks bulky, using the "info registers" format would make sense here.
>>
>>
>>> sp: 0xc00000005051f530 lr: 0x0000000000000000
>>> sp: 0xc00000005051f600 lr: 0xc000000000103ffc
>>> sp: 0xc00000005051f670 lr: 0xc0000000000f60a8
>>> sp: 0xc00000005051f850 lr: 0xc0000000000f18c0
>>> sp: 0xc00000005051fa10 lr: 0xc0000000000f5184
>>> sp: 0xc00000005051fae0 lr: 0xc0000000000ddf54
>>> sp: 0xc00000005051fb00 lr: 0xc0000000000dab9c
>>> sp: 0xc00000005051fb90 lr: 0xc0000000000cbf88
>>> sp: 0xc00000005051fd00 lr: 0xc0000000003e7480
>>> sp: 0xc00000005051fdb0 lr: 0xc0000000003e7ce4
>>> sp: 0xc00000005051fe00 lr: 0xc0000000003e7d88
>>> sp: 0xc00000005051fe20 lr: 0xc00000000000b3a4
>>> 	trap : 0x0000000000000c01
>>> 	pc   : 0x00007fffa6c9d8d0
>>> 	msr  : 0x900000000280f033
>>> 	lr   : 0x0000000010090f40
>>> 	gpr 0: 0x0000000000000036
>>> 	gpr 1: 0x00007fffa62fdd70
>>> 	gpr 2: 0x00007fffa6d57300
>>> 	gpr 3: 0x000000000000000d
>>> 	gpr 4: 0x000000002000ae80
>>> 	gpr 5: 0x0000000000000000
>>> 	gpr 6: 0x0000000000000537
>>> 	gpr 7: 0x0000000000000000
>>> 	gpr 8: 0x000000000000000d
>>> 	gpr 9: 0x0000000000000000
>>> 	gpr10: 0x0000000000000000
>>> 	gpr11: 0x0000000000000000
>>> 	gpr12: 0x0000000000000000
>>> 	gpr13: 0x00007fffa6306380
>>> 	gpr14: 0x0000000000000000
>>> 	gpr15: 0x0000000000000001
>>> 	gpr16: 0x0000000039ba6928
>>> 	gpr17: 0x0000000000000000
>>> 	gpr18: 0x0000000000000000
>>> 	gpr19: 0x00007fffa6d702f0
>>> 	gpr20: 0x00007fffa62fddf0
>>> 	gpr21: 0x0000000000000080
>>> 	gpr22: 0x0000000000000004
>>> 	gpr23: 0x0000000000000000
>>> 	gpr24: 0x0000000010ac85c0
>>> 	gpr25: 0x0000000000000008
>>> 	gpr26: 0x00007fffa62fde10
>>> 	gpr27: 0x0000000000000000
>>> 	gpr28: 0x0000000000000002
>>> 	gpr29: 0x0000000000000000
>>> 	gpr30: 0x0000000039ba6900
>>> 	gpr31: 0x0000000010ac85c0
>>> sp: 0x00007fffa62fdd70
>>>
>>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>>> ---
>>>  target/ppc/cpu.h                |  1 +
>>>  target/ppc/translate.c          | 60 +++++++++++++++++++++++++++++++++++++++++
>>>  target/ppc/translate_init.inc.c |  1 +
>>>  3 files changed, 62 insertions(+)
>>>
>>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>>> index 5e7cf54b2f..28c4dffca1 100644
>>> --- a/target/ppc/cpu.h
>>> +++ b/target/ppc/cpu.h
>>> @@ -1284,6 +1284,7 @@ struct PPCVirtualHypervisorClass {
>>>  void ppc_cpu_do_interrupt(CPUState *cpu);
>>>  bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
>>>  void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>>> +void ppc_cpu_dump_stack(CPUState *cpu, FILE *f);
>>>  void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
>>>  hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>>>  int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>> index 8d08625c33..b162998ce7 100644
>>> --- a/target/ppc/translate.c
>>> +++ b/target/ppc/translate.c
>>> @@ -7705,6 +7705,66 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>>>  #undef RFPL
>>>  }
>>>  
>>> +struct ppc_pt_regs {
>>> +        unsigned long gpr[32];
>>> +        unsigned long nip;
>>> +        unsigned long msr;
>>> +        unsigned long orig_gpr3;
>>> +        unsigned long ctr;
>>> +        unsigned long link;
>>> +        unsigned long xer;
>>> +        unsigned long ccr;
>>> +        unsigned long softe;
>>> +        unsigned long trap;
>>> +        unsigned long dar;
>>> +        unsigned long dsisr;
>>> +        unsigned long result;
>>> +};
>>> +
>>> +void ppc_cpu_dump_stack(CPUState *cs, FILE *f)
>>> +{
>>> +#if defined(TARGET_PPC64)
>>> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
>>> +    CPUPPCState *env = &cpu->env;
>>> +    uint64_t sp, next_sp, lr, buf[4];
>>
>> These are hwaddr really.
>>
>>> +
>>> +    /* stack pointer stored in r1 */
>>> +    sp = env->gpr[1];
>>> +
>>> +    while (sp && (sp & (0xCUL << 60))) {
>>> +        uint64_t marker = 0UL;
>>
>> sp = ppc_cpu_get_phys_page_debug(cs, sp) | (sp & ~TARGET_PAGE_MASK);
>>
>> and finish the loop when ppc_cpu_get_phys_page_debug returns -1?
>>
>>> +
>>> +        /* read and print LR */
>>> +        cpu_physical_memory_read(sp & ~(0xCUL << 60), buf, sizeof(*buf) * 4);
>>
>> and s/ & ~(0xCUL << 60)//
>>
>>> +        next_sp = buf[0];
>>> +        lr = buf[2];
>>
>> These two need to be converted from guest endian. For a BE guest, I see:
>>
>> sp: 0x000000007e582ff0 lr: 0xe4e60a00000000c0
>> sp: 0xffffffffffffffff lr: 0x0000600000006000
>> sp: 0x0000600000006000
>>
>>
>>> +        qemu_fprintf(f, "sp: 0x%.16lx lr: 0x%.16lx\n", sp, lr);
>>
>> HWADDR_PRIx. Or at least PRIx64, otherwise it won't compile on 32bit or
>> x86 or somewhere else.
>>
>>
>>> +        sp &= ~(0xCUL << 60);
>>
>> and remove this line. And now you can dump
>>
>>
>>
>>> +
>>> +        /* Does the stackframe contain regs? */
>>> +        cpu_physical_memory_read(sp + 96, &marker, sizeof(marker));
>>
>> I suspect the marker needs byteswap as well.
> 
> Yeah, best to use the cpu_ldl() etc wrappers if possible, which
> include byteswaps.  Urgh... except this depends on the cpu mode which
> complicates things.
> 
>>
>> What is that 96?
>>
>>> +        if (marker == 0x7265677368657265) { /* regshere */
>>> +            struct ppc_pt_regs regs;
>>> +            int i;
>>> +
>>> +            cpu_physical_memory_read(sp + 112, &regs, sizeof(regs));
>>
>> and the regs.
>>
>> What is that 112?
>>
>> I'd copy from arch/powerpc/include/asm/ptrace.h:
>>
>> #define STACK_FRAME_OVERHEAD    112     /* size of minimum stack frame */
>> #define STACK_FRAME_REGS_MARKER ASM_CONST(0x7265677368657265)
>>
>> and whatever that 96 is.
>>
>> Sadly, scripts/update-linux-headers.sh cannot copy
>> arch/powerpc/include/asm/ptrace.h as kernel's "make headers_install"
>> does not install it (it installs the "uapi" header which does not have
>> these symbols) so you'll have to define them.
>>
>>
>>> +
>>> +            qemu_fprintf(f, "\ttrap : 0x%.16lx\n", regs.trap);
>>> +            qemu_fprintf(f, "\tpc   : 0x%.16lx\n", regs.nip);
>>> +            qemu_fprintf(f, "\tmsr  : 0x%.16lx\n", regs.msr);
>>> +            qemu_fprintf(f, "\tlr   : 0x%.16lx\n", regs.link);
>>> +            for (i = 0; i < 32; i++)
>>> +                qemu_fprintf(f, "\tgpr%2d: 0x%.16lx\n", i,
>>> +                            regs.gpr[i]);
>>> +        }
>>> +
>>> +        sp = next_sp;
>>> +    }
>>> +
>>> +    qemu_fprintf(f, "sp: 0x%.16lx\n", sp);
>>
>>
>> and this is "sp: 0x%"HWADDR_PRIx"\n".
>>
>>
>>
>>> +#endif
>>> +}
>>> +
>>>  void ppc_cpu_dump_statistics(CPUState *cs, int flags)
>>>  {
>>>  #if defined(DO_PPC_STATISTICS)
>>> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
>>> index 0394a9ddad..3fd24f85cc 100644
>>> --- a/target/ppc/translate_init.inc.c
>>> +++ b/target/ppc/translate_init.inc.c
>>> @@ -10587,6 +10587,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>>>      cc->do_interrupt = ppc_cpu_do_interrupt;
>>>      cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt;
>>>      cc->dump_state = ppc_cpu_dump_state;
>>> +    cc->dump_stack = ppc_cpu_dump_stack;
>>>      cc->dump_statistics = ppc_cpu_dump_statistics;
>>>      cc->set_pc = ppc_cpu_set_pc;
>>>      cc->gdb_read_register = ppc_cpu_gdb_read_register;
>>>
>>
> 

-- 
Alexey
