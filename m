Received: from eggs.gnu.org ([2001:4830:134:3::10]:55785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ei5Qs-0001SZ-TO
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ei5Qs-0001BD-3V
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:33:10 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ei5Qr-0001Ar-Tv
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:33:10 -0500
Received: by mail-oi0-x244.google.com with SMTP id x21so5582321oie.13
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 13:33:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517324542-6607-5-git-send-email-peter.maydell@linaro.org>
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-5-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 3 Feb 2018 21:32:48 +0000
Message-ID: <CAFEAcA8AoyXwSUkkG+OYG8pbEH00aBktvz2XEh1A-5p-hk4xOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/7] target/arm: Make v7M
 exception entry stack push check MPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 30 January 2018 at 15:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> -static void v7m_push(CPUARMState *env, uint32_t val)
> +static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
> +                            ARMMMUIdx mmu_idx, bool ignfault)
>  {
> -    CPUState *cs = CPU(arm_env_get_cpu(env));
> +    CPUState *cs = CPU(cpu);
> +    CPUARMState *env = &cpu->env;
> +    MemTxAttrs attrs = {};
> +    MemTxResult txres;
> +    target_ulong page_size;
> +    hwaddr physaddr;
> +    int prot;
> +    ARMMMUFaultInfo fi;
> +    bool secure = mmu_idx & ARM_MMU_IDX_M_S;
> +    int exc;
> +    bool exc_secure;
>
> -    env->regs[13] -= 4;
> -    stl_phys(cs->as, env->regs[13], val);
> +    if (get_phys_addr(env, addr, MMU_DATA_STORE, mmu_idx, &physaddr,
> +                      &attrs, &prot, &page_size, &fi, NULL)) {
> +        /* MPU/SAU lookup failed */
> +        if (fi.type == ARMFault_QEMU_SFault) {
> +            qemu_log_mask(CPU_LOG_INT,
> +                          "...SecureFault with SFSR.AUVIOL during stacking\n");
> +            env->v7m.sfsr |= R_V7M_SFSR_AUVIOL_MASK | R_V7M_SFSR_SFARVALID_MASK;
> +            env->v7m.sfar = addr;
> +            exc = ARMV7M_EXCP_SECURE;
> +            exc_secure = true;

I noticed on Friday that this code isn't quite right -- it should be
   exc_secure = false;

This is because SecureFault is not banked, and for non-banked exceptions
we want to always pass false to armv7m_nvic_set_pending{,_derived}().
Otherwise that function will assert().

v7m_stack_read() in a later patch has the same bug.

thanks
-- PMM
