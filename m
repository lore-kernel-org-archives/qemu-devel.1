Received: from eggs.gnu.org ([2001:4830:134:3::10]:52074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eCM6B-00081A-Ko
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eCM66-00018n-UQ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:52:35 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171107165226.22546-1-alex.bennee@linaro.org>
	<CAFEAcA-E4Tq0gi3q5z+_5JOy0-j0=59p5WiKNFP9qmKG8=r4bg@mail.gmail.com>
	<87r2taq66h.fsf@linaro.org>
	<CAFEAcA_2QhC5BRJX51n4FP7EBOZ2qyq-H3hRhoGRLMTD=gP=Nw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c1ca4ad6-b31f-7c7a-ae43-80eb11b49e1c@twiddle.net>
Date: Wed, 8 Nov 2017 09:52:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2QhC5BRJX51n4FP7EBOZ2qyq-H3hRhoGRLMTD=gP=Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel/tcg/translate-all: expand
 cpu_restore_state retaddr check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 11/07/2017 07:53 PM, Peter Maydell wrote:
>> Then why call cpu_restore_state at all? We should be consistent as there
>> are plenty of places that do things like:
>>
>>     if (pc) {
>>         /* now we have a real cpu fault */
>>         cpu_restore_state(cs, pc);
>>     }
>>
>> I'm happy to make a 0 retaddr officially valid and actually document it
>> in exec-all.h. It's not like most callers even bother checking the
>> return code.

This is exactly the discussion that we had last time, and we did just that.

> Hmm, there's more places than I expected that do that "don't call
> if 0" check than I thought. Overall it seems better to me to officially
> allow the zero, rather than having lots of callsites that all have
> to remember to check.

... what we didn't do is go through and change all of the call sites to remove
the check for zero.

> Incidentally if retaddr is zero then
> (retaddr < (uintptr_t) tcg_init_ctx.code_gen_buffer)
> is always true and you don't need to explicitly check for zero, though
> it might be clearer to do so if we think we might change the rest
> of the condition in future.

Indeed, I was thinking

  retaddr - code_gen_buffer < code_gen_buffer_size

which works well with unsigned arithmetic.  And a large comment re zero.


r~
