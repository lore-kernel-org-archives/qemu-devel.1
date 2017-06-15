Received: from eggs.gnu.org ([2001:4830:134:3::10]:53776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLJSf-0000Gt-Kn
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLJSe-00086n-MI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:20:37 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-6-rth@twiddle.net>
	<20170614203343.GB8420@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f348b0f7-a8ef-0347-2312-93462d8652f6@twiddle.net>
Date: Wed, 14 Jun 2017 18:20:29 -0700
MIME-Version: 1.0
In-Reply-To: <20170614203343.GB8420@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/aarch64: exit to main loop after
 'msr daifclr'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pbonzini@redhat.com, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 06/14/2017 01:33 PM, Emilio G. Cota wrote:
> On Wed, Jun 14, 2017 at 12:48:21 -0700, Richard Henderson wrote:
>> Exit to cpu loop so we reevaluate cpu_arm_hw_interrupts.
>>
>> Cc: qemu-arm@nongnu.org
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>   target/arm/translate-a64.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index 860e279..e55547d 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -1422,7 +1422,9 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
>>           gen_helper_msr_i_pstate(cpu_env, tcg_op, tcg_imm);
>>           tcg_temp_free_i32(tcg_imm);
>>           tcg_temp_free_i32(tcg_op);
>> -        s->is_jmp = DISAS_UPDATE;
>> +        /* For DAIFClear, exit the cpu loop to re-evaluate pending IRQs.  */
>> +        gen_a64_set_pc_im(s->pc);
> 
> For op != 0x1f we end up setting the pc twice (first here, then in
> the switch statement). It's still correct though.

No, that's why I switched to DISAS_JUMP.

> 
>> +        s->is_jmp = (op == 0x1f ? DISAS_EXIT : DISAS_JUMP);
> 
> Could do without the parens.

I think it's clearer.

> +        case DISAS_EXIT:
> +            gen_a64_set_pc_im(dc->pc);
> +            tcg_gen_exit_tb(0);
> +            break;

This gives translate-a64.c and translate.c different semantics for DISAS_EXIT. 
I considered that to be a bad thing.


r~
