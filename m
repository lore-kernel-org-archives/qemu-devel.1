Received: from eggs.gnu.org ([2001:4830:134:3::10]:43775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJW7L-0004gd-B2
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJW7I-0002jI-Ap
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:59:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJW7I-0002j8-4M
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:59:24 -0500
Date: Tue, 28 Nov 2017 10:59:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171128025920.GB3242@lemon>
References: <20171126211356.GA46174@humpty.home.comstyle.com>
	<CAFEAcA_m0KMfsUYWpdg2LL2y5U88d4-LoXZuUXkGUxtGCgD66g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_m0KMfsUYWpdg2LL2y5U88d4-LoXZuUXkGUxtGCgD66g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Fix curses probe for older
 ncurses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Brad Smith <brad@comstyle.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 11/27 13:02, Peter Maydell wrote:
> On 26 November 2017 at 22:13, Brad Smith <brad@comstyle.com> wrote:
> > Fix the curses probe with older ncurses (.e.g. 5.7, as used by OpenBSD).
> >
> > ncurses 5.7 requires _XOPEN_SOURCE_EXTENDED to be defined for WACS_* constants.
> 
> ncurses 5.7 was released in 2008 and is now 9 years old. Why
> is OpenBSD still using such an ancient version?
> 
> > Signed-off-by: Brad Smith <brad@comstyle.com>
> >
> >
> > diff --git a/configure b/configure
> > index 0c6e7572db..9715b9c2cc 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3186,7 +3186,7 @@ EOF
> >    IFS=:
> >    for curses_inc in $curses_inc_list; do
> >      # Make sure we get the wide character prototypes
> > -    curses_inc="-DNCURSES_WIDECHAR $curses_inc"
> > +    curses_inc="-DNCURSES_WIDECHAR -D_XOPEN_SOURCE_EXTENDED $curses_inc"
> 
> I'm a bit wary of this because we've found in the past that
> defining _XOPEN_* defines breaks compilation with some
> C libraries which assume that if you define _XOPEN_whatever
> it means "only that X/Open stuff and no OS-specific extras",
> and we depend on the OS-specific extras.
> 
> That said, I did a test compile on OSX, which was the
> one that had trouble previously, so this may be OK. I think
> I'd rather leave it until after 2.11 releases, though.

One way to contain the effect of this change would be add it to per object
CFLAGS and LIBS, instead of QEMU_CFLAGS and libs_softmmu.

Fam
