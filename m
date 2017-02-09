Received: from eggs.gnu.org ([2001:4830:134:3::10]:34880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbwjw-0004AY-61
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbwjv-00051z-5h
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:58:56 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbwju-00050N-Te
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:58:55 -0500
Received: by mail-wr0-x234.google.com with SMTP id o16so93923897wra.1
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 13:58:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9fd4e2f7-c2e3-2354-028e-f7ee6c2801e3@twiddle.net>
References: <1486668676-24680-1-git-send-email-peter.maydell@linaro.org>
	<9fd4e2f7-c2e3-2354-028e-f7ee6c2801e3@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Feb 2017 21:58:31 +0000
Message-ID: <CAFEAcA9VxHUo42n5wojx0yBL_Fj7oz0i_xA-MfYTF9D2ab7nnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] cputlb: Don't assume
 do_unassigned_access() never returns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 9 February 2017 at 20:03, Richard Henderson <rth@twiddle.net> wrote:
> On 02/09/2017 11:31 AM, Peter Maydell wrote:
>> Review from somebody who understands how the unassigned_access
>> hooks are supposed to work appreciated.

> The unassigned_access hook was (unfortunately) designed after the
> unaligned_access hook.  The later *can* usefully return to indicate that the
> cpu bit that enforces alignment traps is off.
>
> Any unassigned_access hook that doesn't longjmp could be
> considered buggy.

I use the M profile unassigned_access hook to implement
the "high addresses are magic, but only if you're in
Handler mode" behaviour. So for Thread mode I want the
default handling. You could argue that this is kind
of abusing the hook, though.

Microblaze returns from the hook in the case where the
processor version register bit says "this CPU doesn't
generate exceptions for instruction/data aborts".
Since it looks like you can have a CPU config that
chooses to generate an exception for insn abort
but not data abort (or vice-versa), this looks like
a valid case for allowing the hook to return (you
need the hook for the case which you want to have
throw exceptions, but it gets called for the other
case too and needs to be able to say "nope" there).

The sparc code is too complicated for me to be able
to judge whether its non-longjmping codepaths are
valid or bugs.

thanks
-- PMM
