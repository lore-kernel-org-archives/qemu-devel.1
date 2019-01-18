Received: from eggs.gnu.org ([209.51.188.92]:33455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkV0y-0000vu-20
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkV0w-0006Gn-49
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:20:56 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkV0s-0006AI-KC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:20:53 -0500
Received: by mail-ot1-x342.google.com with SMTP id f18so14460255otl.11
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:20:50 -0800 (PST)
MIME-Version: 1.0
References: <1547732292-14021-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-q4T4B+rxZj+734W6K5R5jHB0AW2rFKDQKgwB_oacmVw@mail.gmail.com>
In-Reply-To: <CAFEAcA-q4T4B+rxZj+734W6K5R5jHB0AW2rFKDQKgwB_oacmVw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:20:38 +0000
Message-ID: <CAFEAcA-xfLEEW6qrcoHPsyxt1QGMwJ7ez_TKTTpUX1LA6zDFOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/28] ivshmem deprecation, qtests,
 typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 18 Jan 2019 at 11:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 17 Jan 2019 at 13:38, Thomas Huth <thuth@redhat.com> wrote:
> >
> >  Hi Peter!
> >
> > The following changes since commit 6f2f34177a25bffd6fd92a05e6e66c8d22d97094:
> >
> >   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-01-15 18:32:57 +0000)
> >
> > are available in the git repository at:
> >
> >   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-17
> >
> > for you to fetch changes up to 3f0832c85380321ef697d64342b389648f8abb1c:
> >
> >   tests/hexloader-test: Don't pass -nographic to the QEMU under test (2019-01-17 14:25:12 +0100)
> >
> > ----------------------------------------------------------------
> > - Remove deprecated "ivshmem" legacy device
> > - Bug fix for vhost-user-test
> > - Use more CONFIG Makefile switches for qtests
> > - Get rid of global_qtests in some more qtests
> > - typedef cleanups
> > - Fixes for compiling with Clang
> > - Force C standard to gnu99
> > ----------------------------------------------------------------
>
> In the netbsd VM, the ipmi-bt-test is consistently failing:
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=i386-softmmu
> /qemu-system-i386 QTEST_QEMU_IMG=qemu-img tests/ipmi-bt-test -m=quick
> -k --tap < /dev/null | ./s
> cripts/tap-driver.pl --test-name="ipmi-bt-test"
> **
> ERROR:tests/ipmi-bt-test.c:319:test_connect: assertion failed: (rv == 1)
> ERROR - too few tests run (expected 4, got 0)
> [1]   Abort trap (core dumped) MALLOC_PERTURB_=... |
>       Done(1)                 ./scripts/tap-dr...
> /var/tmp/qemu-test.7opHvo/tests/Makefile.include:856: recipe for
> target 'check-qtest-i386' faile
> d
> gmake: *** [check-qtest-i386] Error 1
> gmake: *** Waiting for unfinished jobs....
>
>
> This has been kind of intermittent for a while, I've seen
> it on-and-off, but with this pullreq it's failed four times
> in a row, so maybe something in here is making it less
> intermittent.

I tried the "raise the timeout" change you suggested on IRC.
That gave me a pass the first time around but the same failure
second time I tried it:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
QTEST_QEMU_IMG=qemu-img tests/ipmi-bt-test -m=quick -k --tap <
/dev/null | ./scripts/tap-driver.pl --test-name="ipmi-bt-test"
**
ERROR:tests/ipmi-bt-test.c:319:test_connect: assertion failed: (rv == 1)
ERROR - too few tests run (expected 4, got 0)
[1]   Abort trap (core dumped) MALLOC_PERTURB_=... |
      Done(1)                 ./scripts/tap-dr...
/var/tmp/qemu-test.TATvqX/tests/Makefile.include:856: recipe for
target 'check-qtest-i386' failed



thanks
-- PMM
