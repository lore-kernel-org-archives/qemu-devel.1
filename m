Received: from eggs.gnu.org ([2001:4830:134:3::10]:49290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cc74t-00072M-4B
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cc74s-0000Iw-6Q
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:01:15 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cc74r-0000Ie-U0
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:01:14 -0500
Received: by mail-wm0-x236.google.com with SMTP id c85so253998952wmi.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 01:01:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <97ded09a-b55f-778f-f7da-ed1498d42931@twiddle.net>
References: <1486668676-24680-1-git-send-email-peter.maydell@linaro.org>
	<9fd4e2f7-c2e3-2354-028e-f7ee6c2801e3@twiddle.net>
	<CAFEAcA9VxHUo42n5wojx0yBL_Fj7oz0i_xA-MfYTF9D2ab7nnA@mail.gmail.com>
	<97ded09a-b55f-778f-f7da-ed1498d42931@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 09:00:52 +0000
Message-ID: <CAFEAcA-=PiW9pSsL9RnXJ5uJittt79TNtUGmMGuLoZgnm6mKmg@mail.gmail.com>
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

On 9 February 2017 at 23:32, Richard Henderson <rth@twiddle.net> wrote:
> On 02/10/2017 07:58 AM, Peter Maydell wrote:
>> I use the M profile unassigned_access hook to implement
>> the "high addresses are magic, but only if you're in
>> Handler mode" behaviour. So for Thread mode I want the
>> default handling. You could argue that this is kind
>> of abusing the hook, though.
>
>
> I'm surprised you don't assign those high addresses to a magic device to
> handle that sort of magic.  Then they wouldn't be "unassigned".

We used to do that, but removed it in commit 542b3478a0 recently,
because it's a nasty hack. There really isn't a device there
(let alone a block of RAM). Among other things, reads and
writes aren't supposed to be magic, only executes and only
if the CPU is in a particular state. At least using the
unassigned_access hook keeps weird CPU behaviour in the
CPU and doesn't let it leak out into the system model.

(The proper non-hacky approach to this would be to do what
the spec says we should and make the branch instruction
itself behave differently if the register being branched to
has the magic value. But that would slow down branches
generally.)

>> Microblaze returns from the hook in the case where the
>> processor version register bit says "this CPU doesn't
>> generate exceptions for instruction/data aborts".
>> Since it looks like you can have a CPU config that
>> chooses to generate an exception for insn abort
>> but not data abort (or vice-versa), this looks like
>> a valid case for allowing the hook to return (you
>> need the hook for the case which you want to have
>> throw exceptions, but it gets called for the other
>> case too and needs to be able to say "nope" there).
>
>
> If the cpu doesn't implement aborts, then the processor must provide some
> default value for the memory return.  But the code path along which a return
> happens does not allow for data to be read.  We would need to expand the
> hook definition for this.

Yeah; at the moment the assumption is the cpu is ok with
qemu's generic default of RAZ/WI.

thanks
-- PMM
