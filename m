Received: from eggs.gnu.org ([208.118.235.92]:38115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf7sN-0005EX-OW
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf7sM-00045N-T8
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:37:51 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gf7sM-000445-EZ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:37:50 -0500
Received: by mail-oi1-x242.google.com with SMTP id a77so28450325oii.5
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 10:37:50 -0800 (PST)
MIME-Version: 1.0
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
	<42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
In-Reply-To: <42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jan 2019 18:37:38 +0000
Message-ID: <CAFEAcA9UqiaiKa_4EWfBHbRS0H=trHfJiArHOJkW6=vKoGvRpQ@mail.gmail.com>
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

On Sat, 22 Dec 2018 at 08:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 21/12/18 22:09, Peter Maydell wrote:
> > I don't really understand what's going on here, or why
> > it only happens with this one system (my main x86-64
> > Linux Ubuntu 16.04.5 box) and not the various others I'm
> > running test builds on. But it does seem to be 100%
> > reliable with any of these pullreqs with the new test
> > driver in them :-(
>
> I'm afraid something in your setup is causing make's stdout to have
> O_NONBLOCK set.  Make doesn't use O_NONBLOCK at all, so it must be
> something above it.  I also checked Perl with strace and, at least here,
> it doesn't set O_NONBLOCK.

Interestingly, I have today run into "make: write error: stdout"
with the existing make check infrastructure. It seems to
only happen if I run 'make check' in a loop like this:
  while make -C build/x86 -j8 V=1 check; do true; done
Adding strace to this shows that although the first
invocation of 'make' starts with stdout not O_NONBLOCK,
something in that run results in stdout being set O_NONBLOCK,
and then that persists into the second run of make,
which then may fail as a result. (This is make 4.1, which
will write output with fputs() unless a --sync-output option
is used, and thus doesn't retry on EINTR.) When the 'while'
loop finishes, something in the shell results in stdout
being set back to blocking again.

I presume that something in one of the tests we're running,
likely QEMU itself, ends up setting stdout to non-blocking.
This while rune *used* to be entirely reliable, so maybe
something recent has changed ?

thanks
-- PMM
