Received: from eggs.gnu.org ([2001:4830:134:3::10]:40379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMDNb-0000LZ-PU
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMDNV-0001Bh-Ut
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:39:55 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMDNU-00019k-84
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:39:48 -0500
Received: by mail-oi1-x242.google.com with SMTP id j202-v6so7308409oih.10
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 06:39:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181019174958.26616-1-peter.maydell@linaro.org>
References: <20181019174958.26616-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 14:39:24 +0000
Message-ID: <CAFEAcA_NV69qFLi07QxJR=pjPG0+vjOmXY_J1NpnzUz-qc6ZiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: Don't call gdb_handlesig
 unnecessarily
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Marek Vasut <marex@denx.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Chris Wulff <crwulff@gmail.com>, "patches@linaro.org" <patches@linaro.org>

Ping? This got reviewed but hasn't made it to master...

thanks
-- PMM

On 19 October 2018 at 18:49, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset fixes a minor bug in our handling of SIGTRAP
> in linux-user.
>
> The CPU main-loop routines for linux-user generally call
> gdb_handlesig() when they're about to queue a SIGTRAP signal.  This
> is wrong, because queue_signal() will cause us to pend a signal, and
> process_pending_signals() will then call gdb_handlesig() itself.  So
> the effect is that we notify gdb of the SIGTRAP, and then if gdb says
> "OK, continue with signal X" we will incorrectly notify gdb of the
> signal X as well.  We don't do this double-notify for anything else,
> only SIGTRAP.
>
> This bug only manifests if the user responds to the reported SIGTRAP
> using "signal SIGFOO" rather than "continue"; since the latter is the
> overwhelmingly common thing to do after a breakpoint most people
> won't have hit this.
>
> Patch 1 fixes this bug for every target except nios2, by
> deleting the incorrect code.
>
> Patch 2 fixes nios2 separately, because it was doing some odd
> things with gdb_handlesig(). This also fixes in passing a Coverity
> issue.
>
> Tested with "make check-tcg", and with some by-hand stepping
> around with an attached gdb. NB that the nios2 patch is only
> compile tested as I don't have a nios2 linux-user environment
> and check-tcg doesn't cover it.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   linux-user: Don't call gdb_handlesig() before queue_signal()
>   linux-user: Clean up nios2 main loop signal handling
>
>  linux-user/aarch64/cpu_loop.c    | 13 +++++--------
>  linux-user/alpha/cpu_loop.c      | 12 ++++--------
>  linux-user/arm/cpu_loop.c        | 16 ++++------------
>  linux-user/cris/cpu_loop.c       | 16 ++++------------
>  linux-user/hppa/cpu_loop.c       | 11 ++++-------
>  linux-user/i386/cpu_loop.c       | 16 ++++------------
>  linux-user/m68k/cpu_loop.c       | 16 ++++------------
>  linux-user/microblaze/cpu_loop.c | 16 ++++------------
>  linux-user/mips/cpu_loop.c       | 16 ++++------------
>  linux-user/nios2/cpu_loop.c      | 14 +++++---------
>  linux-user/openrisc/cpu_loop.c   | 11 ++++-------
>  linux-user/ppc/cpu_loop.c        | 15 +++++----------
>  linux-user/riscv/cpu_loop.c      |  2 +-
>  linux-user/s390x/cpu_loop.c      |  9 +++------
>  linux-user/sh4/cpu_loop.c        | 17 ++++-------------
>  linux-user/sparc/cpu_loop.c      | 16 ++++------------
>  linux-user/xtensa/cpu_loop.c     | 11 ++++-------
>  17 files changed, 67 insertions(+), 160 deletions(-)
