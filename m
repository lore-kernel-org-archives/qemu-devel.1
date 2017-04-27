Received: from eggs.gnu.org ([2001:4830:134:3::10]:52117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i5s-0003sm-QI
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i5m-0001Lp-U4
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:20 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d3i5m-0001Km-Mj
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:14 -0400
Received: by mail-wm0-x22c.google.com with SMTP id m123so16074735wma.0
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 05:00:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 27 Apr 2017 13:59:47 +0200
Message-Id: <20170427120006.20564-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 00/19] TCG cross-tb optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

Changes since Emilio's v4:
  * Fold tcg/i386 exit_tb 0 to the epilogue we created for goto_ptr.
  * Drop gen_jr in favor of DISAS_EXIT for target/arm.
  * Backend support for ppc, aarch64, sparc, s390.
  * Fix 3 build failures that appear on sparc v8plus (64-bit ilp32).

I attempted to throw together an x32 environment to validate
x86_64 ilp32, which ought to have had the same problems as sparc,
but my patience was exhausted by gentoo misconfigury.  I may try
that again later, but not now.


r~


Emilio G. Cota (11):
  exec-all: export tb_htable_lookup
  tcg-runtime: add lookup_tb_ptr helper
  tcg: introduce goto_ptr opcode
  tcg: export tcg_gen_lookup_and_goto_ptr
  target/arm: optimize cross-page direct jumps in softmmu
  target/arm: optimize indirect branches
  target/i386: introduce gen_jr helper to generate lookup_and_goto_ptr
  target/i386: optimize cross-page direct jumps in softmmu
  target/i386: optimize indirect branches
  tb-hash: improve tb_jmp_cache hash function in user mode
  tcg/i386: implement goto_ptr

Richard Henderson (8):
  target/nios2: Fix 64-bit ilp32 compilation
  tcg/sparc: Use the proper compilation flags for 32-bit
  qemu/atomic: Loosen restrictions for 64-bit ILP32 hosts
  target/alpha: Use tcg_gen_goto_ptr
  tcg/ppc: Implement goto_ptr
  tcg/aarch64: Implement goto_ptr
  tcg/sparc: Implement goto_ptr
  tcg/s390: Implement goto_ptr

 configure                    |  6 +++---
 cpu-exec.c                   |  6 ++----
 include/exec/exec-all.h      |  2 ++
 include/exec/tb-hash.h       | 12 +++++++++++
 include/qemu/atomic.h        | 34 ++++++++++++++++++++++--------
 target/alpha/translate.c     | 49 ++++++++++++++++++++++++++++++++------------
 target/arm/translate.c       | 21 ++++++++++++++-----
 target/arm/translate.h       |  4 ++++
 target/i386/translate.c      | 43 ++++++++++++++++++++++++++++++--------
 target/nios2/translate.c     |  2 +-
 tcg-runtime.c                | 24 ++++++++++++++++++++++
 tcg/README                   |  8 ++++++++
 tcg/aarch64/tcg-target.h     |  1 +
 tcg/aarch64/tcg-target.inc.c | 22 ++++++++++++++++++--
 tcg/arm/tcg-target.h         |  1 +
 tcg/i386/tcg-target.h        |  1 +
 tcg/i386/tcg-target.inc.c    | 24 ++++++++++++++++++++--
 tcg/ia64/tcg-target.h        |  1 +
 tcg/mips/tcg-target.h        |  1 +
 tcg/ppc/tcg-target.h         |  1 +
 tcg/ppc/tcg-target.inc.c     |  7 +++++++
 tcg/s390/tcg-target.h        |  1 +
 tcg/s390/tcg-target.inc.c    | 24 +++++++++++++++++++---
 tcg/sparc/tcg-target.h       |  1 +
 tcg/sparc/tcg-target.inc.c   | 11 +++++++++-
 tcg/tcg-op.c                 | 13 ++++++++++++
 tcg/tcg-op.h                 | 11 ++++++++++
 tcg/tcg-opc.h                |  1 +
 tcg/tcg-runtime.h            |  2 ++
 tcg/tcg.h                    |  1 +
 tcg/tci/tcg-target.h         |  1 +
 31 files changed, 285 insertions(+), 51 deletions(-)

-- 
2.9.3
