Received: from eggs.gnu.org ([209.51.188.92]:50269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjcZ-0007rP-L1
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjcY-0003bx-H9
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:12:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:47058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hFjcY-0003bL-A0
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:12:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id s24so12540190otk.13
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 11:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <91dddf37-77fe-79c6-59f5-4e60d45c3c7e@durchholz.org>
	<CAMo8BfLEEF2_FVU88ydBWVmcRbCJ9T0ULrDEKRa-+hmCYo9cmg@mail.gmail.com>
	<0492144e-fcd1-c013-2211-fbc31a17ce2f@durchholz.org>
In-Reply-To: <0492144e-fcd1-c013-2211-fbc31a17ce2f@durchholz.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Apr 2019 19:12:37 +0100
Message-ID: <CAFEAcA8vUhuEbtLnmOxui3K_UW8eOET3xbWap3E23EWeGzqv7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] How to I trigger a rebuild?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joachim Durchholz <jo@durchholz.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sun, 14 Apr 2019 at 17:08, Joachim Durchholz <jo@durchholz.org> wrote:
>
> Am 14.04.19 um 03:15 schrieb Max Filippov:
> > On Sat, Apr 13, 2019 at 8:28 AM Joachim Durchholz <jo@durchholz.org> wrote:
> >> I did the usual ./configure; make dance.
> >> Then modified a source file (ui/curses.c), called make again, but didn't
> >> see curses.c recompiled, and the change was indeed ineffective.
> >> make clean; make didn't help either.
> >
> > Perhaps you don't have CONFIG_CURSES enabled?
> > Did you call configure with --enable-curses ?
>
> Strange. "make help" tells me that everything is enabled by default if
> possible, and I didn't tell configure to do anything specific.
>
> But I find that curses is disabled indeed.
> Heh. An explicit --enable-curses tells me it was missing the dev version
> of ncurses.

Configure's default behaviour is "enable everything that we can
enable, but don't complain about not enabling optional features
which we can't build (eg because of missing -dev libraries)".
For "insist that foo is built and error out if it can't be done",
use "--enable-foo". For "definitely don't build foo even if we
could", use --disable-foo.

> However... even with curses enabled, "make" does not do anything  after
> modifying ui/curses.c.
> In fact, just "make" tell's me I should have run ./config (WTF I did??),
> and "make all"
> But after ./configure is recompiles everything... nothing of this is
> something that "make" should do, so I'm pretty confused.

This sounds like maybe you got confused somewhere along the line
about whether you'd (re-)run configure or not (or didn't
do a 'make clean' after running configure with the curses
support enabled).

The other thing that might confuse you is that make will try
to spot when it needs to rerun configure and will rerun it
for you.

I recommend doing builds only in a separate directory, by the way:
 mkdir build
 (cd build && ../configure [configure args])
 make -C build -j8

Then you can always just rm -rf the build dir and it doesn't
leave stuff lying around in the source tree. You can also
do multiple different builds with different configure
setups without having to do a complete build from clean.
(If you've previously done an in-source-directory build
you'll need to 'make distclean' it before doing out of tree
builds.)

thanks
-- PMM
