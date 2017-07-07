Received: from eggs.gnu.org ([2001:4830:134:3::10]:52100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dTY0t-0001kR-2e
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dTY0p-0006V5-Rl
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:29:59 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dTY0p-0006Ue-Hh
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:29:55 -0400
Received: by mail-wr0-x22e.google.com with SMTP id k67so57759402wrc.2
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 11:29:55 -0700 (PDT)
References: <20170707161822.29659-1-alex.bennee@linaro.org>
	<87inj49mr1.fsf@linaro.org>
	<CAFEAcA_YvS8OQVTPnvRtWyVuAKO2bccyNALOs1Oq7snTO1WwkA@mail.gmail.com>
	<a391e7e5-0be9-0863-bfb7-88d9168484f3@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <a391e7e5-0be9-0863-bfb7-88d9168484f3@twiddle.net>
Date: Fri, 07 Jul 2017 19:29:52 +0100
Message-ID: <87h8yo9k2n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: ensure eret exits the
 run-loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Etienne Carriere <etienne.carriere@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, "Emilio G . Cota" <cota@braap.org>


Richard Henderson <rth@twiddle.net> writes:

> On 07/07/2017 07:36 AM, Peter Maydell wrote:
>> On 7 July 2017 at 18:32, Alex Bennée <alex.bennee@linaro.org> wrote:
>>> Given the wording of:
>>>
>>> /* is_jmp field values */
>>> #define DISAS_NEXT    0 /* next instruction can be analyzed */
>>> #define DISAS_JUMP    1 /* only pc was modified dynamically */
>>> #define DISAS_UPDATE  2 /* cpu state was modified dynamically */
>>> #define DISAS_TB_JUMP 3 /* only pc was modified statically */
>>>
>>> I'm thinking that really these DISAS_JUMP's should be DISAS_UPDATEs and
>>> we need to disable the TB chaining optimisations for this. I'll prepare
>>> a more comprehensive series next week. However testing this patch for
>>> known failure modes will be useful.
>>
>> The problem I think is that a lot of our current code assumes
>> that DISAS_UPDATE means "go back to the top loop".
>>
>> In any case I think you are right that DISAS_UPDATE should not
>> allow chaining to the next TB, because it implies that perhaps
>> a TB flags bit got changed, so you need to look in the hash
>> table again.
>
> Changes to TB flags are not a problem; helper_lookup_tb does examine
> them, and indeed go back to the hash table.  The only thing it doesn't
> do is re-evaluate the interrupt state.

Last time around we I did have a patch that checked for
cpu->interrupt_request in the lookup helper. Of course this is a bit
blunt because really its a case of is the cpu->interrupt_request live
and the masking has changed to enable things to be run. Unfortunately
the current API of cc->cpu_exec_interrupt() isn't amenable to querying
the state so maybe we should just exit back to the prologue when the
request is up.

> Naming all of these different exit conditions is certainly
> non-trivial.

Given the variation of usage this is something that should probably be
done after Lluís common run loop goes in and we can beef up the
semantics of the various exit conditions.

One thing I have noticed in the ARM translator is DISAS_UPDATE does a:

    gen_a64_set_pc_im(dc->pc);

I think this is to deal with handling exceptions either side of various
instructions. Am I right in thinking this is superfluous now as we can
derive the PC from the translated code address?


>
>
> r~


--
Alex Bennée
