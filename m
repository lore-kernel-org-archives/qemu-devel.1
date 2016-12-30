Received: from eggs.gnu.org ([2001:4830:134:3::10]:38287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMvTC-0003Rr-3H
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 06:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMvTA-0002kj-UV
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 06:35:34 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:32791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cMvTA-0002k4-GS
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 06:35:32 -0500
Received: by mail-ua0-x22d.google.com with SMTP id i68so147015700uad.0
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 03:35:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49b66510-1c3f-64fa-c0b0-125547bed7ca@redhat.com>
References: <CAJ+F1CJXGAZa5_+4jD0rP_zX28RCCu3xmF27ZHpgvhnZz686ug@mail.gmail.com>
	<20161228145344.30819-1-cov@codeaurora.org>
	<2a940dc2-05a0-2e91-afc0-eeb560f6ce32@redhat.com>
	<CAFEAcA_g5Ru2cg-D5JEhpzuUTx7=SwNg=TW3uxs-z_pp2yvqHQ@mail.gmail.com>
	<49b66510-1c3f-64fa-c0b0-125547bed7ca@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Dec 2016 11:35:11 +0000
Message-ID: <CAFEAcA_VN3QS-JnuBML+x+OZBR6c43ZPTko4kQfsvjRTvbWofA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] build: include sys/sysmacros.h for
 major() and minor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Christopher Covington <cov@codeaurora.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

On 29 December 2016 at 13:48, Eric Blake <eblake@redhat.com> wrote:
> On 12/28/2016 11:07 AM, Peter Maydell wrote:
>> Also this seems straightforwardly like a bug in glibc: it shouldn't
>> be making this kind of breaking change. makedev(3) on my Linux box
>> says nothing about needing sysmacros.h for these.
>
> Here's the bug explaining the rationale behind the change:
>
> https://sourceware.org/bugzilla/show_bug.cgi?id=19239
>
> It IS a bug fix, but in the other direction - it is fixing namespace
> pollution that was present in <sys/types.h> and breaking certain
> standard-required idioms.  There HAS been warning, but system man pages
> have not always been updated to track upstream development, and the plan
> was that glibc 2.25 only causes a warning rather than outright failure
> to compile (although with -Werror, you have to adjust right away, rather
> than when the future glibc actually changes <sys/types.h> again to
> completely drop the pollution).
>
> It is CORRECT to fix any software relying on makedev() to use the
> CORRECT headers for that declaration, rather than getting it for free
> from <sys/types.h> pollution - the problem is that makedev() is not
> portable, and therefore the spelling of the correct header is not
> trivial - it requires some configure-time probing.

I checked a FreeBSD manpage and they don't put these macros
in sysmacros.h, they're in sys/types.h. I think the "correct"
header for them is sys/types.h, because that's where they've
always lived and where they've been documented to be. Otherwise
you're breaking API compatibility.

http://minnie.tuhs.org/cgi-bin/utree.pl?file=2.9BSD/usr/include/sys/types.h
shows that sys/types.h is where these macros have lived
way back to 2.9BSD in 1983.

If POSIX requires sys/types.h not to provide these macros
then I think you could argue that that's a bug in the POSIX spec,
because it wasn't supposed to make major existing
implementations like the BSD family non-compliant.

For glibc to move to putting these macros somewhere weird
and different to everything else that implements them
is just forcing all programs that use them to add extra
configure machinery and ifdefs for no good reason.
QEMU now has to work around this glibc infelicity, of
course, but it would be better if it didn't have to.

Breaking existing code that was following the docs
is a big deal, and glibc should basically never do
it in my view.

thanks
-- PMM
