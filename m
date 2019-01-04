Received: from eggs.gnu.org ([208.118.235.92]:54442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfNhJ-0000SJ-9e
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfNhH-0004d3-6w
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:31:28 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:45978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfNhF-0004Ym-9L
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:31:26 -0500
Received: by mail-oi1-x22c.google.com with SMTP id y1so30132687oie.12
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 03:31:23 -0800 (PST)
MIME-Version: 1.0
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
	<42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
	<CAFEAcA9UqiaiKa_4EWfBHbRS0H=trHfJiArHOJkW6=vKoGvRpQ@mail.gmail.com>
	<bc564647-0550-df53-7a17-7760489b8c45@redhat.com>
	<CAFEAcA9tiqHEiCdUXWcD+SvzUzZPG4sTqiTSR57N=qYM49eykw@mail.gmail.com>
	<d8bb4435-7b69-04e9-2b4a-4cfdd439ecea@redhat.com>
In-Reply-To: <d8bb4435-7b69-04e9-2b4a-4cfdd439ecea@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 11:31:11 +0000
Message-ID: <CAFEAcA9QKYc89Fknmz-MGSGv11eSTuvNYjsf+-sqsAGT=ZYQ3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 00/35] Misc patches for 2018-12-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 4 Jan 2019 at 11:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/01/19 11:06, Peter Maydell wrote:
> > On Fri, 4 Jan 2019 at 07:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> On 03/01/19 19:37, Peter Maydell wrote:
> >>> On Sat, 22 Dec 2018 at 08:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>> Interestingly, I have today run into "make: write error: stdout"
> >>> with the existing make check infrastructure. [...]
> >>> I presume that something in one of the tests we're running,
> >>> likely QEMU itself, ends up setting stdout to non-blocking.
> >>> This while rune *used* to be entirely reliable, so maybe
> >>> something recent has changed ?
> >>
> >> I don't know... I tried running make check under "strace -e fcntl" and I
> >> didn't find any occurrences of fcntl(1, O_SETFL, ...|O_NONBLOCK).
> >> Perhaps you can add a check after every invocation of a test executable.
> >
> >> Are you going to apply the pull request since the bug is preexisting?
> >
> > The pull request takes the problem from "occasionally shows up
> > in by-hand running of make check in a while loop" to "reliably
> > causes my automated tests to fail every time". I can't apply
> > a pullreq that does that, so we need to find at least a workaround.
>
> The certain workaround is to clear O_NONBLOCK before invoking make,
> possibly by placing a wrapper in ~/bin:
>
>     import os
>     from fcntl import *
>     fcntl(1, F_SETFL, fcntl(1, F_GETFL) & ~os.O_NONBLOCK)

I'll give this a go, but I think this will not necessarily be
sufficient if some program invoked by make sets the O_NONBLOCK flag,
and then make later in the same run tries to output and gets EINTR.
Perhaps it would be better to put it in the test harness that
invokes test binaries, so as to clear the flag as soon
as possible? It could also then in theory print a warning
if a test case had put stdin/stdout into non-blocking mode.

(The semantics of O_NONBLOCK here seem to me to be completely
broken. But they are what they are...)

thanks
-- PMM
