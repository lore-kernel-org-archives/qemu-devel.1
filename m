Received: from eggs.gnu.org ([2001:4830:134:3::10]:56359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFA-0003v8-9e
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvF9-0003Zt-6T
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:52:40 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:34979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHvF9-0003Zh-1s
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:52:39 -0400
Received: by mail-qt0-x233.google.com with SMTP id w1so94275855qtg.2
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 09:52:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  5 Jun 2017 09:52:07 -0700
Message-Id: <20170605165233.4135-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/26] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This contains several patches to fix compilation on ilp32 abis on
64-bit hosts, such as sparcv8plus and x32.  It also contains the
goto_ptr feature proposed by Emilio Cota.


r~


The following changes since commit 199e19ee538eb61fd08b1c1ee5aa838ebdcc968e:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-06-05 15:28:12 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170605

for you to fetch changes up to 2d826cdc8a43ba1817a44f481f8dc8f08668b0a6:

  target/alpha: Use goto_tb for fallthru between TBs (2017-06-05 09:25:42 -0700)

----------------------------------------------------------------
Queued TCG patches

----------------------------------------------------------------
Aurelien Jarno (3):
      tcg/mips: implement goto_ptr
      target/mips: optimize cross-page direct jumps in softmmu
      target/mips: optimize indirect branches

Emilio G. Cota (10):
      tcg: Introduce goto_ptr opcode and tcg_gen_lookup_and_goto_ptr
      tcg/i386: implement goto_ptr
      target/arm: optimize cross-page direct jumps in softmmu
      target/arm: optimize indirect branches
      target/i386: introduce gen_jr helper to generate lookup_and_goto_ptr
      target/i386: optimize cross-page direct jumps in softmmu
      target/i386: optimize indirect branches
      tb-hash: improve tb_jmp_cache hash function in user mode
      target/aarch64: optimize cross-page direct jumps in softmmu
      target/aarch64: optimize indirect branches

Richard Henderson (13):
      target/nios2: Fix 64-bit ilp32 compilation
      tcg/sparc: Use the proper compilation flags for 32-bit
      qemu/atomic: Loosen restrictions for 64-bit ILP32 hosts
      tcg/ppc: Implement goto_ptr
      tcg/aarch64: Implement goto_ptr
      tcg/sparc: Implement goto_ptr
      tcg/s390: Implement goto_ptr
      tcg/arm: Clarify tcg_out_bx for arm4 host
      tcg/arm: Implement goto_ptr
      target/s390: Use tcg_gen_lookup_and_goto_ptr
      target/hppa: Use tcg_gen_lookup_and_goto_ptr
      target/alpha: Implement WTINT inline
      target/alpha: Use goto_tb for fallthru between TBs

 configure                    |  6 ++---
 cpu-exec.c                   |  6 ++---
 include/exec/exec-all.h      |  2 ++
 include/exec/tb-hash.h       | 12 ++++++++++
 include/qemu/atomic.h        | 34 +++++++++++++++++++++-------
 target/alpha/translate.c     | 30 ++++++++++++++++++------
 target/arm/translate-a64.c   |  5 ++--
 target/arm/translate.c       | 21 +++++++++++++----
 target/arm/translate.h       |  4 ++++
 target/hppa/translate.c      |  8 +++----
 target/i386/translate.c      | 43 +++++++++++++++++++++++++++--------
 target/mips/translate.c      |  4 ++--
 target/nios2/translate.c     |  2 +-
 target/s390x/translate.c     | 17 ++++++++++----
 tcg-runtime.c                | 32 ++++++++++++++++++++++++++
 tcg/README                   |  8 +++++++
 tcg/aarch64/tcg-target.h     |  1 +
 tcg/aarch64/tcg-target.inc.c | 22 ++++++++++++++++--
 tcg/arm/tcg-target.h         |  1 +
 tcg/arm/tcg-target.inc.c     | 54 +++++++++++++++++++++++++++++---------------
 tcg/i386/tcg-target.h        |  1 +
 tcg/i386/tcg-target.inc.c    | 24 ++++++++++++++++++--
 tcg/ia64/tcg-target.h        |  1 +
 tcg/mips/tcg-target.h        |  1 +
 tcg/mips/tcg-target.inc.c    | 13 +++++++++++
 tcg/ppc/tcg-target.h         |  1 +
 tcg/ppc/tcg-target.inc.c     |  7 ++++++
 tcg/s390/tcg-target.h        |  1 +
 tcg/s390/tcg-target.inc.c    | 24 +++++++++++++++++---
 tcg/sparc/tcg-target.h       |  1 +
 tcg/sparc/tcg-target.inc.c   | 11 ++++++++-
 tcg/tcg-op.c                 | 12 ++++++++++
 tcg/tcg-op.h                 | 11 +++++++++
 tcg/tcg-opc.h                |  1 +
 tcg/tcg-runtime.h            |  2 ++
 tcg/tcg.c                    |  5 ++++
 tcg/tcg.h                    |  1 +
 tcg/tci/tcg-target.h         |  1 +
 38 files changed, 353 insertions(+), 77 deletions(-)
