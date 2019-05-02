Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACA1C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 03:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68CC2081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 03:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="Jsr37DHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68CC2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44603 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM2i8-000837-Q6
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 23:48:40 -0400
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xBLwgsTvzKg1pQ3lIjRFO8eTyxuFJxzlcUWbkOA3Jx4=;
	b=Jsr37DHs/Ug5RxJKwrtT26xIBUfO5cCVdKxRqWSx7ykGbaiqwRu4Ov4hwtVAvOnD6r
	bYJwkY27fdp/rKPzCOkoxSlwJf8ejCsDjRA9kbme9eu7Gn6nyhCixYQXA+7FczZ4w29o
	QoE5yFPUfEfrwRkcW5RTETOZIozfV5xglLF5F9v5SjEih2NP5VTrchdmCDLzKoJJvbU+
	MfFo/xjoO8olFW3K6rlfjDK4YmpPQM85z/MAJZgDJLQhI3DjK+pezIAWv/b6/AZs4Hn+
	f/xYuVjBfDxXYNSAQYf8d7+JUYNzU2yNGRCZjoaJiJgHRK3qAmXnnpo313330CZgeouw
	w5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=xBLwgsTvzKg1pQ3lIjRFO8eTyxuFJxzlcUWbkOA3Jx4=;
	b=KXnN76AcZvJzV0AGITree6R+uicnXmcBz+Z2iwAoh29tzt+Nqm3YQepsylH03UD1r+
	e2KbdrM6xE+4YdA0gZJb7wz5LhmvUtuELVXwLvVQLvp0teuLY+KreyXy1m2nM2QG5+Nj
	IpdjVCucGw9fA47MdP5SyOVGZHHb48SxMA8OtRZJMS0/0D89jojYv6WqULsCtLHmBdlw
	Hblg7IFPZzMSYIdFT6LIqOFz9tsaLZePZBKLP78EC+9KmCP/JRihL85P6e/JyVY3Zjg1
	0XnOpdVBMXjt8GcHoJ/oL+6tFPlDvCmZm/5DxBJJq+jSuMoqsrtUYC+JkoB8Cjk+lOGu
	JCzw==
X-Gm-Message-State: APjAAAVKcuWLcE2xqOsx2SzvaVfL7qwe+0Bb/XndRPcVARwJneMucyAq
	FxD8lFOmj4+SpRub3Ha1J5zmBg==
X-Google-Smtp-Source: APXvYqwx1DBQH3ciEBOzzoYNqwHzNdEWqTVl/M+plIrvI6TDyRCx7O3cQ3hrVwnO9Y5S2JyqmNgFfw==
X-Received: by 2002:a62:4697:: with SMTP id o23mr1604752pfi.224.1556768858079; 
	Wed, 01 May 2019 20:47:38 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10]) by smtp.gmail.com with ESMTPSA id
	z127sm22262352pfb.53.2019.05.01.20.47.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 20:47:37 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
	<20190501053522.10967-2-sjitindarsingh@gmail.com>
	<11cb0515-7a96-99af-f33b-c752603a189d@ozlabs.ru>
	<20190502004346.GC13618@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
	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
Message-ID: <c0917aef-79cc-f42c-2f4c-6d26da9657d6@ozlabs.ru>
Date: Thu, 2 May 2019 13:47:32 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502004346.GC13618@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 2/2] ppc: Add dump-stack implementation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: armbru@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502034732.GTyA9yJSADPSCHln9vCbprOeyIW21uY2wxbXsEqwOc8@z>



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

