Received: from eggs.gnu.org ([208.118.235.92]:58605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfPmx-0007vr-V5
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfPmx-0002k3-1J
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:45:27 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfPmw-0002io-Kg
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:45:26 -0500
Received: by mail-ot1-x341.google.com with SMTP id f18so32083923otl.11
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 05:45:25 -0800 (PST)
MIME-Version: 1.0
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
	<42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
	<CAFEAcA9UqiaiKa_4EWfBHbRS0H=trHfJiArHOJkW6=vKoGvRpQ@mail.gmail.com>
	<bc564647-0550-df53-7a17-7760489b8c45@redhat.com>
	<CAFEAcA97LKhk_FxPbPGG3C2FpSRTpVyez77xjCJah6Gqh=bjsg@mail.gmail.com>
In-Reply-To: <CAFEAcA97LKhk_FxPbPGG3C2FpSRTpVyez77xjCJah6Gqh=bjsg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 13:45:13 +0000
Message-ID: <CAFEAcA-wZa6XP-MSPtHr-EwgOR2+CXEpBPYtJpQfVa6=7kFGZg@mail.gmail.com>
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

On Fri, 4 Jan 2019 at 13:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 4 Jan 2019 at 07:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > I don't know... I tried running make check under "strace -e fcntl" and I
> > didn't find any occurrences of fcntl(1, O_SETFL, ...|O_NONBLOCK).
>
> I found this strace command worked to track down some possible
> culprits:
> strace -o /tmp/strace.log -e fcntl,execve,clone -e signal=none -f make
> -C build/x86 V=1 check
>
> Extracts from the logs:
>
> 29251 execve("tests/test-char", ["tests/test-char", "-q", "-p",
> "/char/stdio/subprocess", "--GTestSubprocess", "--GTestLogFD", "4"],
> [/* 66 vars */] <unfinished ...>

This one seems to be ok, because the call to g_test_trap_subprocess()
does not pass any flags arguments, which means the child gets
its stdin/stdout/stderr all set to /dev/null, and the change
to O_NONBLOCK is thus harmless.

> 30300 execve("tests/hexloader-test", ["tests/hexloader-test",
> "--quiet", "--keep-going", "-m
> =quick", "--GTestLogFD=6"], [/* 68 vars */]) = 0

This one on the other hand does seem like it might be an issue.
Removing the "-nographic" from the qtest_initf() command
causes it no longer to mess with the O_NONBLOCK state
of its stdout. I'm just doing a 'while loop' test run to
see if it fixes the problems I was seeing with that.

It seems a touch brittle if a harmless-looking command
line option to QEMU can break test runs, though -- is
there a way we can make this more robust, eg by having
the QEMU process i/o always redirected ?

thanks
-- PMM
