Received: from eggs.gnu.org ([2001:4830:134:3::10]:34757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPBmi-00066a-Fj
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPBfW-0002Yy-MT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:26:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPBfU-0002V8-Oa
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:26:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so7874wmi.3
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 11:26:36 -0800 (PST)
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-4-sameo@linux.intel.com>
	<CAFEAcA98so9yyJN=qAhD=Kr6pi1xxfrxt28atqZ8ATVJYXTaMg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a145c571-b5d9-1ef4-de8b-fad7dc7855c7@redhat.com>
Date: Tue, 20 Nov 2018 20:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98so9yyJN=qAhD=Kr6pi1xxfrxt28atqZ8ATVJYXTaMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/13] target: arm: Move all v7m helpers
 into their own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 20/11/18 14:54, Peter Maydell wrote:
> On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
>> In preparation for supporting TCG disablement on ARM, we move all TCG
>> related v7m helpers and APIs into their own file (m_helper.c for all
>> v*-m helpers).
>> arm_v7m_cpu_do_interrupt pulls a large number of static functions
>> out of helper.c into m_helper.c because it is TCG dependent.
>>
>> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
>> ---
>>   target/arm/internals.h   |   37 +
>>   target/arm/helper.c      | 2209 +++-----------------------------------
>>   target/arm/m_helper.c    | 1892 ++++++++++++++++++++++++++++++++
>>   target/arm/Makefile.objs |    2 +-
>>   4 files changed, 2086 insertions(+), 2054 deletions(-)
>>   create mode 100644 target/arm/m_helper.c
> 
>> +/* Function used to synchronize QEMU's AArch64 register set with AArch32
>> + * register set.  This is necessary when switching between AArch32 and AArch64
>> + * execution state.
>> + */
>> +void aarch64_sync_32_to_64(CPUARMState *env)
>>   {
>> -    uint32_t new_ss_msp, new_ss_psp;
>> +    int i;
>> +    uint32_t mode = env->uncached_cpsr & CPSR_M;
>>
>> -    if (env->v7m.secure == new_secstate) {
>> -        return;
>> +    /* We can blanket copy R[0:7] to X[0:7] */
>> +    for (i = 0; i < 8; i++) {
>> +        env->xregs[i] = env->regs[i];
>>       }
>>
>> -    /* All the banked state is accessed by looking at env->v7m.secure
>> -     * except for the stack pointer; rearrange the SP appropriately.
>> +    /* Unless we are in FIQ mode, x8-x12 come from the user registers r8-r12.
>> +     * Otherwise, they come from the banked user regs.
>>        */
>> -    new_ss_msp = env->v7m.other_ss_msp;
>> -    new_ss_psp = env->v7m.other_ss_psp;
>> -
>> -    if (v7m_using_psp(env)) {
>> -        env->v7m.other_ss_psp = env->regs[13];
>> -        env->v7m.other_ss_msp = env->v7m.other_sp;
>> -    } else {
>> -        env->v7m.other_ss_msp = env->regs[13];
>> -        env->v7m.other_ss_psp = env->v7m.other_sp;
>> -    }
>> -
>> -    env->v7m.secure = new_secstate;
>> -
>> -    if (v7m_using_psp(env)) {
>> -        env->regs[13] = new_ss_psp;
>> -        env->v7m.other_sp = new_ss_msp;
>> +    if (mode == ARM_CPU_MODE_FIQ) {
>> +        for (i = 8; i < 13; i++) {
>> +            env->xregs[i] = env->usr_regs[i - 8];
>> +        }
>>       } else {
>> -        env->regs[13] = new_ss_msp;
>> -        env->v7m.other_sp = new_ss_psp;
>> +        for (i = 8; i < 13; i++) {
>> +            env->xregs[i] = env->regs[i];
>> +        }
>>       }
>> -}
>>
>> -void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
>> -{
>> -    /* Handle v7M BXNS:
>> -     *  - if the return value is a magic value, do exception return (like BX)
>> -     *  - otherwise bit 0 of the return value is the target security state
>> +    /* Registers x13-x23 are the various mode SP and FP registers. Registers
>> +     * r13 and r14 are only copied if we are in that mode, otherwise we copy
>> +     * from the mode banked register.
>>        */
>> -    uint32_t min_magic;
>> -
>> -    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
>> -        /* Covers FNC_RETURN and EXC_RETURN magic */
>> -        min_magic = FNC_RETURN_MIN_MAGIC;
>> +    if (mode == ARM_CPU_MODE_USR || mode == ARM_CPU_MODE_SYS) {
>> +        env->xregs[13] = env->regs[13];
>> +        env->xregs[14] = env->regs[14];
>>       } else {
>> -        /* EXC_RETURN magic only */
>> -        min_magic = EXC_RETURN_MIN_MAGIC;
>> +        env->xregs[13] = env->banked_r13[bank_number(ARM_CPU_MODE_USR)];
>> +        /* HYP is an exception in that it is copied from r14 */
>> +        if (mode == ARM_CPU_MODE_HYP) {
>> +            env->xregs[14] = env->regs[14];
>> +        } else {
>> +            env->xregs[14] = env->banked_r14[bank_number(ARM_CPU_MODE_USR)];
>> +        }
>>       }
> 
> This part of the patch is a mess to read. I suspect this is a
> combination of (a) your git not being configured to use a better
> diff algorithm than the default (try "algorithm = histogram"
> in the [diff] section of your .gitconfig), and it doing an effective
> revert of 593cfa2b637b92d37 by accident.

I did the review offline, applying the series then looking at each 
commit with gitk, this is why I did not notice this.

> It's also an absolutely enormous patch, even for a "just
> moving code" patch, which makes it hard to review even
> with diff --color-moved. Maybe it would be better in two
> pieces ("helper routines for various insns" and "exception
> handling functions" seems like a workable split).

Good idea.

Regards,

Phil.
