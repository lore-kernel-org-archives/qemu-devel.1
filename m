Received: from eggs.gnu.org ([2001:4830:134:3::10]:40675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDZ2b-0008Q5-5I
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDZ2a-0004Oz-AY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:58:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDZ2a-0004K9-16
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:58:28 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 18:49:56 +0100
Message-Id: <20181019174958.26616-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] linux-user: Don't call gdb_handlesig
 unnecessarily
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

This patchset fixes a minor bug in our handling of SIGTRAP
in linux-user.

The CPU main-loop routines for linux-user generally call
gdb_handlesig() when they're about to queue a SIGTRAP signal.  This
is wrong, because queue_signal() will cause us to pend a signal, and
process_pending_signals() will then call gdb_handlesig() itself.  So
the effect is that we notify gdb of the SIGTRAP, and then if gdb says
"OK, continue with signal X" we will incorrectly notify gdb of the
signal X as well.  We don't do this double-notify for anything else,
only SIGTRAP.

This bug only manifests if the user responds to the reported SIGTRAP
using "signal SIGFOO" rather than "continue"; since the latter is the
overwhelmingly common thing to do after a breakpoint most people
won't have hit this.

Patch 1 fixes this bug for every target except nios2, by
deleting the incorrect code.

Patch 2 fixes nios2 separately, because it was doing some odd
things with gdb_handlesig(). This also fixes in passing a Coverity
issue.

Tested with "make check-tcg", and with some by-hand stepping
around with an attached gdb. NB that the nios2 patch is only
compile tested as I don't have a nios2 linux-user environment
and check-tcg doesn't cover it.

thanks
-- PMM

Peter Maydell (2):
  linux-user: Don't call gdb_handlesig() before queue_signal()
  linux-user: Clean up nios2 main loop signal handling

 linux-user/aarch64/cpu_loop.c    | 13 +++++--------
 linux-user/alpha/cpu_loop.c      | 12 ++++--------
 linux-user/arm/cpu_loop.c        | 16 ++++------------
 linux-user/cris/cpu_loop.c       | 16 ++++------------
 linux-user/hppa/cpu_loop.c       | 11 ++++-------
 linux-user/i386/cpu_loop.c       | 16 ++++------------
 linux-user/m68k/cpu_loop.c       | 16 ++++------------
 linux-user/microblaze/cpu_loop.c | 16 ++++------------
 linux-user/mips/cpu_loop.c       | 16 ++++------------
 linux-user/nios2/cpu_loop.c      | 14 +++++---------
 linux-user/openrisc/cpu_loop.c   | 11 ++++-------
 linux-user/ppc/cpu_loop.c        | 15 +++++----------
 linux-user/riscv/cpu_loop.c      |  2 +-
 linux-user/s390x/cpu_loop.c      |  9 +++------
 linux-user/sh4/cpu_loop.c        | 17 ++++-------------
 linux-user/sparc/cpu_loop.c      | 16 ++++------------
 linux-user/xtensa/cpu_loop.c     | 11 ++++-------
 17 files changed, 67 insertions(+), 160 deletions(-)

-- 
2.19.1
