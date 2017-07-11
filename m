Received: from eggs.gnu.org ([2001:4830:134:3::10]:46735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV2OH-00036M-M9
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV2OG-0008M3-OB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:08:17 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
	<20170711175937.23140-5-alex.bennee@linaro.org>
	<d0d0750b-127e-79e8-4307-57e187cd302f@twiddle.net>
	<87fue2aigw.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <99791611-a047-4884-6abc-a84a0183c532@twiddle.net>
Date: Tue, 11 Jul 2017 11:08:01 -1000
MIME-Version: 1.0
In-Reply-To: <87fue2aigw.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/6] target/arm/translate: ensure
 gen_goto_tb sets exit flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On 07/11/2017 09:20 AM, Alex Bennée wrote:
> 
> Richard Henderson <rth@twiddle.net> writes:
> 
>> On 07/11/2017 07:59 AM, Alex Bennée wrote:
>>>        if (use_goto_tb(s, dest)) {
>>>            tcg_gen_goto_tb(n);
>>>            gen_set_pc_im(s, dest);
>>>            tcg_gen_exit_tb((uintptr_t)s->tb + n);
>>> +        s->is_jmp = DISAS_TB_JUMP;
>>>        } else {
>>>            gen_set_pc_im(s, dest);
>>>            gen_goto_ptr();
>>> +        s->is_jmp = DISAS_JUMP;
>>>        }
>>
>> I think DISAS_TB_JUMP is appropriate for both cases.  When not using
>> goto_tb, the jump is still static and we still chain to the next TB
>> via goto_ptr.
> 
> OK - I guess we need to nail down what the essential difference is
> between the two. I understood DISAS_TB_JUMP as a static known PC which
> can be patched in the generated code because we know the two addresses
> are in the same page - whereas DISAS_JUMP is a "computed" jump although
> in this case the PC is already known.
> 
> Does making a distinction between computed and non-computer inter-page
> jumps make any sense anyway?

*shrug* probably not.

Honestly, the only thing that's really interesting here is that is_jmp indicate 
that we have already exited the TB and that all following code is dead.

As a response to one of Lluis' threads, I suggested that the generic term for 
this be DISAS_NORETURN.  Which also covers exiting the TB via calling a helper 
that does not return, e.g. throwing an illegal opcode exception, aka DISAS_EXC 
in the current target/arm sources.


r~
