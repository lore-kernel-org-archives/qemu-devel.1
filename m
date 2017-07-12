Received: from eggs.gnu.org ([2001:4830:134:3::10]:54750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJhY-0004ta-Ns
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVJhV-0006yj-J8
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:37:20 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVJhV-0006xq-BT
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:37:17 -0400
Received: by mail-wr0-f169.google.com with SMTP id k67so38315239wrc.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:37:17 -0700 (PDT)
References: <CGME20170712113922eucas1p1c6588b2e29439254cafd3d8dde5c505c@eucas1p1.samsung.com>
	<001801d2fb03$811079e0$83316da0$@samsung.com>
	<CAFEAcA8FAp6TvY+DBVGzYVizLw9iarPQMLRw3haNxtFeEBYjHg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8FAp6TvY+DBVGzYVizLw9iarPQMLRw3haNxtFeEBYjHg@mail.gmail.com>
Date: Wed, 12 Jul 2017 16:36:14 +0100
Message-ID: <877ezd8y6p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] target/arm: Fix abort on exception return from
 AArch64 to AArch32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jaroslaw Pelczar <j.pelczar@samsung.com>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 12 July 2017 at 12:39, Jaroslaw Pelczar <j.pelczar@samsung.com> wrote:
>> Problem manifests itself when we handle the following sequence:
>>
>> 1. 64-bit Secure EL3 returns to 32-bit Secure EL1
>> 2. 32-bit Secure EL1 performs SMC call to 64-bit Secure EL3
>> 3. 64-bit Secure EL3 performs return ERET to 32-bit Secure EL1]
>> 4. 32-bit Secure EL1 receives prefetch abort
>>
>> If CPU's env->pc is not set to the same value as env->regs[15],
>> during ERET the simulator will try to fetch instruction from EL3's
>> virtual address inside 32-bit Secure EL1 virtual address space.
>> This will cause Prefetch Abort in 32-bit Secure EL1.
>>
>> Problem occurs because of the following code generation scheme:
>>
>> 1. disas_uncond_b_reg will decode ERET
>> 2. gen_helper_exception_return(cpu_env) will generate thunk to
>>    helper_exception_return
>> 3. s->is_jmp is set to DISAS_JUMP
>> 4. gen_intermediate_code_a64 will see dc->is_jmp == DISAS_JUMP
>> 5. tcg_gen_lookup_and_goto_ptr(cpu_pc) will be called which trigger
>>    access cpu->pc to fetch next opcode
>>
>> At this point cpu->pc will have EL3's PC value.
>>
>> Signed-off-by: Jaroslaw Pelczar <j.pelczar@samsung.com>
>> ---
>>  target/arm/op_helper.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
>> index 2a85666..8222c19 100644
>> --- a/target/arm/op_helper.c
>> +++ b/target/arm/op_helper.c
>> @@ -1027,6 +1027,9 @@ void HELPER(exception_return)(CPUARMState *env)
>>          } else {
>>              env->regs[15] = env->elr_el[cur_el] & ~0x3;
>>          }
>> +
>> +        env->pc = env->regs[15];
>> +
>>          qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
>>                        "AArch32 EL%d PC 0x%" PRIx32 "\n",
>>                        cur_el, new_el, env->regs[15]);
>
> Thanks for the bug report. I don't think this is the best
> fix, though. What should happen is that for ERET we do
> not attempt to do a lookup_and_goto_ptr(), we should just
> go back out to the main loop and get the next TB from there.
>
> I think this may be fixed as one of the things Alex's
> recent patchset tackles?

Yes, see:

  https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg02963.html

I'll probably get v4 out tomorrow at which point you can merge it ;-)

>
> thanks
> -- PMM


--
Alex Bennée
