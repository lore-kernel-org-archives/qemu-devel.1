Received: from eggs.gnu.org ([2001:4830:134:3::10]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTX89-0001KY-47
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTX88-0004v4-0f
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:33:25 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dTX87-0004uQ-RL
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:33:23 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 77so56076914wrb.1
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 10:33:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3745ae02-3fb0-1503-9c99-98dce369f697@twiddle.net>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865776960.17063.4875279139522061160.stgit@frigg.lan>
	<2bfdb883-f19b-7fcf-c28b-7ce39115937e@twiddle.net>
	<87podcebyi.fsf@frigg.lan>
	<3745ae02-3fb0-1503-9c99-98dce369f697@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jul 2017 18:33:00 +0100
Message-ID: <CAFEAcA_tKBtOOc8XCHYRGFT7qN3FmDD7awfvZrZA+2kbQNp82Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 7 July 2017 at 16:26, Richard Henderson <rth@twiddle.net> wrote:
> That is the purpose of DISAS_EXC too.  We've called a noreturn helper to
> raise an exception and all following code is unreached.  If there *was* any
> code being emitted afterward, that is arguably a bug.

One exception to that is a conditionally executed
exception generating exception -- there will in that
case be a following label for the condfail case to branch
to and the code for the condfail path.

The distinction in the case that this code fragment is touching
is that the cases handled in current master via 'goto
done_generating' and in Lluis' patch as
DISAS_SKIP are the "this insn is going to generate an
exception without even thinking about conditional
exception" (ie breakpoints, singlestep); DISAS_EXC
is for "the instruction itself generates an exception,
so don't bother with emitting too much unreachable
code to update the PC etc, but we still need to handle
the usual end-of-insn condfail path".

We do a few things in the DISAS_EXC codepath
(like calling gen_set_condexec()) which strictly speaking
are pointless but which it didn't seem worth trying to
avoid just to avoid generating a few extra bytes in the
generated code in a not-terribly-likely case.

thanks
-- PMM
