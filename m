Received: from eggs.gnu.org ([2001:4830:134:3::10]:34150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbyD0-0008OK-Gt
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbyCv-0001DA-KU
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:33:02 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbyCv-0001Ae-FQ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:32:57 -0500
Received: by mail-pg0-x244.google.com with SMTP id 204so1470920pge.2
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 15:32:55 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1486668676-24680-1-git-send-email-peter.maydell@linaro.org>
	<9fd4e2f7-c2e3-2354-028e-f7ee6c2801e3@twiddle.net>
	<CAFEAcA9VxHUo42n5wojx0yBL_Fj7oz0i_xA-MfYTF9D2ab7nnA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <97ded09a-b55f-778f-f7da-ed1498d42931@twiddle.net>
Date: Fri, 10 Feb 2017 09:32:47 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9VxHUo42n5wojx0yBL_Fj7oz0i_xA-MfYTF9D2ab7nnA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 02/10/2017 07:58 AM, Peter Maydell wrote:
> On 9 February 2017 at 20:03, Richard Henderson <rth@twiddle.net> wrote:
>> On 02/09/2017 11:31 AM, Peter Maydell wrote:
>>> Review from somebody who understands how the unassigned_access
>>> hooks are supposed to work appreciated.
>
>> The unassigned_access hook was (unfortunately) designed after the
>> unaligned_access hook.  The later *can* usefully return to indicate that the
>> cpu bit that enforces alignment traps is off.
>>
>> Any unassigned_access hook that doesn't longjmp could be
>> considered buggy.
>
> I use the M profile unassigned_access hook to implement
> the "high addresses are magic, but only if you're in
> Handler mode" behaviour. So for Thread mode I want the
> default handling. You could argue that this is kind
> of abusing the hook, though.

I'm surprised you don't assign those high addresses to a magic device to handle 
that sort of magic.  Then they wouldn't be "unassigned".

> Microblaze returns from the hook in the case where the
> processor version register bit says "this CPU doesn't
> generate exceptions for instruction/data aborts".
> Since it looks like you can have a CPU config that
> chooses to generate an exception for insn abort
> but not data abort (or vice-versa), this looks like
> a valid case for allowing the hook to return (you
> need the hook for the case which you want to have
> throw exceptions, but it gets called for the other
> case too and needs to be able to say "nope" there).

If the cpu doesn't implement aborts, then the processor must provide some 
default value for the memory return.  But the code path along which a return 
happens does not allow for data to be read.  We would need to expand the hook 
definition for this.

> The sparc code is too complicated for me to be able
> to judge whether its non-longjmping codepaths are
> valid or bugs.

I argued with Artyom that (at least) the sparc64 return code path is wrong. 
But I have no idea what the real cpu does for that case.


r~
