Received: from eggs.gnu.org ([2001:4830:134:3::10]:58447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTXNE-00072D-SL
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTXNE-0005Mg-2c
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:49:00 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865776960.17063.4875279139522061160.stgit@frigg.lan>
	<2bfdb883-f19b-7fcf-c28b-7ce39115937e@twiddle.net>
	<87podcebyi.fsf@frigg.lan>
	<3745ae02-3fb0-1503-9c99-98dce369f697@twiddle.net>
	<CAFEAcA_tKBtOOc8XCHYRGFT7qN3FmDD7awfvZrZA+2kbQNp82Q@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cb5ab1b6-e748-c3e7-7691-beea1567b058@twiddle.net>
Date: Fri, 7 Jul 2017 07:48:37 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_tKBtOOc8XCHYRGFT7qN3FmDD7awfvZrZA+2kbQNp82Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 23/29] target/arm: [tcg] Port to
 translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/07/2017 07:33 AM, Peter Maydell wrote:
> On 7 July 2017 at 16:26, Richard Henderson <rth@twiddle.net> wrote:
>> That is the purpose of DISAS_EXC too.  We've called a noreturn helper to
>> raise an exception and all following code is unreached.  If there *was* any
>> code being emitted afterward, that is arguably a bug.
> 
> One exception to that is a conditionally executed
> exception generating exception -- there will in that
> case be a following label for the condfail case to branch
> to and the code for the condfail path.
> 
> The distinction in the case that this code fragment is touching
> is that the cases handled in current master via 'goto
> done_generating' and in Lluis' patch as
> DISAS_SKIP are the "this insn is going to generate an
> exception without even thinking about conditional
> exception" (ie breakpoints, singlestep); DISAS_EXC
> is for "the instruction itself generates an exception,
> so don't bother with emitting too much unreachable
> code to update the PC etc, but we still need to handle
> the usual end-of-insn condfail path".

Ok.

LLuis, this implies that the DISAS_NORETURN that I talked about elsewhere 
should be the thing handled generically, but that target/arm still needs a 
target-specific define for DISAS_EXC so that the conditional execution handler 
can make the distinction.

> We do a few things in the DISAS_EXC codepath
> (like calling gen_set_condexec()) which strictly speaking
> are pointless but which it didn't seem worth trying to
> avoid just to avoid generating a few extra bytes in the
> generated code in a not-terribly-likely case.

Yeah.  We'd probably be better off just adding dead-code removal to TCG. 
Something that used to be difficult but would now be trivial to do.


r~
