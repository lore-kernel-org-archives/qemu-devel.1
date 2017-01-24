Received: from eggs.gnu.org ([2001:4830:134:3::10]:43832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW40L-00063k-JM
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW40H-0005FU-LF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:31:33 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW40H-0005FA-Ca
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:31:29 -0500
Received: by mail-wm0-x22b.google.com with SMTP id c85so190043352wmi.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 08:31:29 -0800 (PST)
References: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
	<1484937883-1068-3-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1484937883-1068-3-git-send-email-peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 16:31:26 +0000
Message-ID: <87vat4a081.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/6] armv7m: Replace armv7m.hack
 with unassigned_access handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Michael Davidsaver <mdavidsaver@gmail.com>
>
> For v7m we need to catch attempts to execute from special
> addresses at 0xfffffff0 and above. Previously we did this
> with the aid of a hacky special purpose lump of memory
> in the address space and a check in translate.c for whether
> we were translating code at those addresses.
>
> We can implement this more cleanly using a CPU
> unassigned access handler which throws the exception
> if the unassigned access is for one of the special addresses.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> [PMM:
>  * drop the deletion of the "don't interrupt if PC is magic"
>    code in arm_v7m_cpu_exec_interrupt() -- this is still
>    required
>  * don't generate an exception for unassigned accesses
>    which aren't to the magic address -- although doing
>    this is in theory correct in practice it will break
>    currently working guests which rely on the RAZ/WI
>    behaviour when they touch devices which we haven't
>    modelled.
>  * trigger EXCP_EXCEPTION_EXIT on is_exec, not !is_write
> ]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/armv7m.c        |  8 --------
>  target/arm/cpu.c       | 28 ++++++++++++++++++++++++++++
>  target/arm/translate.c | 12 ++++++------
>  3 files changed, 34 insertions(+), 14 deletions(-)
>
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 49d3078..0c9ca7b 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -180,7 +180,6 @@ DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
>      uint64_t entry;
>      uint64_t lowaddr;
>      int big_endian;
> -    MemoryRegion *hack = g_new(MemoryRegion, 1);
>
>      if (cpu_model == NULL) {
>  	cpu_model = "cortex-m3";
> @@ -225,13 +224,6 @@ DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
>          }
>      }
>
> -    /* Hack to map an additional page of ram at the top of the address
> -       space.  This stops qemu complaining about executing code outside RAM
> -       when returning from an exception.  */
> -    memory_region_init_ram(hack, NULL, "armv7m.hack", 0x1000, &error_fatal);
> -    vmstate_register_ram_global(hack);
> -    memory_region_add_subregion(system_memory, 0xfffff000, hack);
> -

What stops a model inadvertently registering a block of memory on-top?
Should we check the memory region really is unassigned?

>      qemu_register_reset(armv7m_reset, cpu);
>      return nvic;
>  }
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 3f2cdb6..47759c9 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -292,6 +292,33 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  }
>
>  #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
> +static void arm_v7m_unassigned_access(CPUState *cpu, hwaddr addr,
> +                                      bool is_write, bool is_exec, int opaque,
> +                                      unsigned size)
> +{
> +    ARMCPU *arm = ARM_CPU(cpu);
> +    CPUARMState *env = &arm->env;
> +
> +    /* ARMv7-M interrupt return works by loading a magic value into the PC.
> +     * On real hardware the load causes the return to occur.  The qemu
> +     * implementation performs the jump normally, then does the exception
> +     * return by throwing a special exception when when the CPU tries to
> +     * execute code at the magic address.
> +     */
> +    if (env->v7m.exception != 0 && addr >= 0xfffffff0 && is_exec) {
> +        cpu->exception_index = EXCP_EXCEPTION_EXIT;
> +        cpu_loop_exit(cpu);
> +    }
> +
> +    /* In real hardware an attempt to access parts of the address space
> +     * with nothing there will usually cause an external abort.
> +     * However our QEMU board models are often missing device models where
> +     * the guest can boot anyway with the default read-as-zero/writes-ignored
> +     * behaviour that you get without a QEMU unassigned_access hook.
> +     * So just return here to retain that default behaviour.
> +     */
> +}
> +
>  static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
>      CPUClass *cc = CPU_GET_CLASS(cs);
> @@ -1016,6 +1043,7 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
>      cc->do_interrupt = arm_v7m_cpu_do_interrupt;
>  #endif
>
> +    cc->do_unassigned_access = arm_v7m_unassigned_access;
>      cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;
>  }
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index c9186b6..a7c2abe 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11719,12 +11719,12 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>              break;
>          }
>  #else
> -        if (dc->pc >= 0xfffffff0 && arm_dc_feature(dc, ARM_FEATURE_M)) {
> -            /* We always get here via a jump, so know we are not in a
> -               conditional execution block.  */
> -            gen_exception_internal(EXCP_EXCEPTION_EXIT);
> -            dc->is_jmp = DISAS_EXC;
> -            break;
> +        if (arm_dc_feature(dc, ARM_FEATURE_M)) {
> +            /* Branches to the magic exception-return addresses should
> +             * already have been caught via the arm_v7m_unassigned_access hook,
> +             * and never get here.
> +             */
> +            assert(dc->pc < 0xfffffff0);
>          }
>  #endif

Otherwise:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
