Received: from eggs.gnu.org ([2001:4830:134:3::10]:47577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTPSS-0007WL-Ha
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTPSP-000504-93
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:49:36 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cTPSO-0004zd-VT
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:49:33 -0500
References: <20161231132226.9595-1-marex@denx.de>
	<20161231132226.9595-2-marex@denx.de>
	<37102228-c1e5-e8e5-c4a5-5c9ae186202b@suse.de>
	<15b12846-b83b-6495-af1f-1fd3e41c15bb@denx.de>
	<A8DB00FA-CF30-4C61-B914-3E809AE104B6@suse.de>
From: Marek Vasut <marex@denx.de>
Message-ID: <69104f77-6020-70f0-b544-379161a70b3e@denx.de>
Date: Tue, 17 Jan 2017 09:49:27 +0100
MIME-Version: 1.0
In-Reply-To: <A8DB00FA-CF30-4C61-B914-3E809AE104B6@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 2/7] nios2: Add architecture emulation
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>

On 01/17/2017 09:16 AM, Alexander Graf wrote:
> 
> 
>> Am 17.01.2017 um 01:18 schrieb Marek Vasut <marex@denx.de>:
>>
>>> On 01/16/2017 11:21 PM, Alexander Graf wrote:
>>>
>>>
>>>> On 31/12/2016 14:22, Marek Vasut wrote:
>>>> From: Chris Wulff <crwulff@gmail.com>
>>>>
>>>> Add support for emulating Altera NiosII R1 architecture into qemu.
>>>> This patch is based on previous work by Chris Wulff from 2012 and
>>>> updated to latest mainline QEMU.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> Cc: Chris Wulff <crwulff@gmail.com>
>>>> Cc: Jeff Da Silva <jdasilva@altera.com>
>>>> Cc: Ley Foon Tan <lftan@altera.com>
>>>> Cc: Sandra Loosemore <sandra@codesourcery.com>
>>>> Cc: Yves Vandervennet <yvanderv@altera.com>
>>>> ---
>>>> V3: Thorough cleanup, deal with the review comments all over the place
>>>> V4: - Use extract32()
>>>>    - Fix gen_goto_tb() , suppress tcg_gen_goto_tb()
>>>>    - Clean up gen_check_supervisor() helper
>>>>    - Use TCGMemOp type for flags
>>>>    - Drop jump labels from wrctl/rdctl
>>>>    - More TCG cleanup
>>>> V5: - Simplify load/store handling
>>>>    - Handle loads into R_ZERO from protected page, add comment
>>>> V6: - Fix division opcode handling
>>>>    - Add missing disas handling
>>>>    - V5 review comments cleanup
>>>> V7: - Drop newline at the end of file
>>>> V8: - Rebase on top of qemu/master
>>>>    - Move the target-nios2 to target/nios2
>>>> ---
>>>> target/nios2/Makefile.objs |   4 +
>>>> target/nios2/cpu.c         | 232 +++++++++++
>>>> target/nios2/cpu.h         | 269 +++++++++++++
>>>> target/nios2/helper.c      | 313 +++++++++++++++
>>>> target/nios2/helper.h      |  27 ++
>>>> target/nios2/mmu.c         | 292 ++++++++++++++
>>>> target/nios2/mmu.h         |  54 +++
>>>> target/nios2/monitor.c     |  35 ++
>>>> target/nios2/op_helper.c   |  47 +++
>>>> target/nios2/translate.c   | 953
>>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>> 10 files changed, 2226 insertions(+)
>>>> create mode 100644 target/nios2/Makefile.objs
>>>> create mode 100644 target/nios2/cpu.c
>>>> create mode 100644 target/nios2/cpu.h
>>>> create mode 100644 target/nios2/helper.c
>>>> create mode 100644 target/nios2/helper.h
>>>> create mode 100644 target/nios2/mmu.c
>>>> create mode 100644 target/nios2/mmu.h
>>>> create mode 100644 target/nios2/monitor.c
>>>> create mode 100644 target/nios2/op_helper.c
>>>> create mode 100644 target/nios2/translate.c
>>>>
>>>> diff --git a/target/nios2/Makefile.objs b/target/nios2/Makefile.objs
>>>> new file mode 100644
>>>> index 0000000..2a11c5c
>>>> --- /dev/null
>>>> +++ b/target/nios2/Makefile.objs
>>>> @@ -0,0 +1,4 @@
>>>> +obj-y += translate.o op_helper.o helper.o cpu.o mmu.o
>>>> +obj-$(CONFIG_SOFTMMU) += monitor.o
>>>> +
>>>> +$(obj)/op_helper.o: QEMU_CFLAGS += $(HELPER_CFLAGS)
>>>> diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
>>>> new file mode 100644
>>>> index 0000000..658d684
>>>> --- /dev/null
>>>> +++ b/target/nios2/cpu.c
>>>> @@ -0,0 +1,232 @@
>>>> +/*
>>>> + * QEMU Nios II CPU
>>>> + *
>>>> + * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2.1 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This library is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * Lesser General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU Lesser General Public
>>>> + * License along with this library; if not, see
>>>> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu-common.h"
>>>> +#include "qapi/error.h"
>>>> +#include "cpu.h"
>>>> +#include "exec/log.h"
>>>> +#include "exec/gdbstub.h"
>>>> +#include "hw/qdev-properties.h"
>>>> +
>>>> +static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
>>>> +{
>>>> +    Nios2CPU *cpu = NIOS2_CPU(cs);
>>>> +    CPUNios2State *env = &cpu->env;
>>>> +
>>>> +    env->regs[R_PC] = value;
>>>> +}
>>>> +
>>>> +static bool nios2_cpu_has_work(CPUState *cs)
>>>> +{
>>>> +    return cs->interrupt_request & (CPU_INTERRUPT_HARD |
>>>> CPU_INTERRUPT_NMI);
>>>> +}
>>>> +
>>>> +/* CPUClass::reset() */
>>>> +static void nios2_cpu_reset(CPUState *cs)
>>>> +{
>>>> +    Nios2CPU *cpu = NIOS2_CPU(cs);
>>>> +    Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(cpu);
>>>> +    CPUNios2State *env = &cpu->env;
>>>> +
>>>> +    if (qemu_loglevel_mask(CPU_LOG_RESET)) {
>>>> +        qemu_log("CPU Reset (CPU %d)\n", cs->cpu_index);
>>>> +        log_cpu_state(cs, 0);
>>>> +    }
>>>> +
>>>> +    ncc->parent_reset(cs);
>>>> +
>>>> +    tlb_flush(cs, 1);
>>>> +
>>>> +    memset(env->regs, 0, sizeof(uint32_t) * NUM_CORE_REGS);
>>>> +    env->regs[R_PC] = cpu->reset_addr;
>>>> +
>>>> +#if defined(CONFIG_USER_ONLY)
>>>> +    /* Start in user mode with interrupts enabled. */
>>>> +    env->regs[CR_STATUS] = CR_STATUS_U | CR_STATUS_PIE;
>>>
>>> So what is the value of CR_STATUS after reset in softmmu land then?
>>> Random value from before reset? Probably not what you want :).
>>
>> Dropped, yeah.
> 
> Dropped? That wasn't my intention :).
> 
> I was just too tired to grasp the code. CR_STATUS is 0 for softmmu thanks to the memset, so irqs are disabled. For linux-user, applications expect irqs to work, so it needs to be explicitly set to on.
> 
> The code above is perfectly correct I think.

I ran into an issue booting Linux, so now I'm explicitly initing the
CR_STATUS in both cases. For user case, to the above, otherwise to 0.

-- 
Best regards,
Marek Vasut
