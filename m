Received: from eggs.gnu.org ([208.118.235.92]:56570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfMNC-0005YF-GY
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfMNB-0002DJ-NC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:06:38 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:36899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfMNB-0002D3-9Z
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:06:37 -0500
Received: by mail-oi1-x234.google.com with SMTP id y23so29970450oia.4
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 02:06:37 -0800 (PST)
MIME-Version: 1.0
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
	<42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
	<CAFEAcA9UqiaiKa_4EWfBHbRS0H=trHfJiArHOJkW6=vKoGvRpQ@mail.gmail.com>
	<bc564647-0550-df53-7a17-7760489b8c45@redhat.com>
In-Reply-To: <bc564647-0550-df53-7a17-7760489b8c45@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 10:06:25 +0000
Message-ID: <CAFEAcA9tiqHEiCdUXWcD+SvzUzZPG4sTqiTSR57N=qYM49eykw@mail.gmail.com>
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

On Fri, 4 Jan 2019 at 07:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/01/19 19:37, Peter Maydell wrote:
> > On Sat, 22 Dec 2018 at 08:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Interestingly, I have today run into "make: write error: stdout"
> > with the existing make check infrastructure. [...]
> > I presume that something in one of the tests we're running,
> > likely QEMU itself, ends up setting stdout to non-blocking.
> > This while rune *used* to be entirely reliable, so maybe
> > something recent has changed ?
>
> I don't know... I tried running make check under "strace -e fcntl" and I
> didn't find any occurrences of fcntl(1, O_SETFL, ...|O_NONBLOCK).
> Perhaps you can add a check after every invocation of a test executable.

> Are you going to apply the pull request since the bug is preexisting?

The pull request takes the problem from "occasionally shows up
in by-hand running of make check in a while loop" to "reliably
causes my automated tests to fail every time". I can't apply
a pullreq that does that, so we need to find at least a workaround.
I'm not sure why your test harness makes it much more likely
that the problem manifests.

(The shell will typically clear the O_NONBLOCK flag on its terminal
before waiting for interactive input, which is why this is a
problem when running make check inside a while loop or in my
pull test script which runs make check for several trees in
succession, but not an issue for individual runs on the command line.)

thanks
-- PMM
