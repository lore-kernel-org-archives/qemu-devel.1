Received: from eggs.gnu.org ([2001:4830:134:3::10]:59325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dO7-0001c9-Kh
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dO6-0001R9-H8
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:07 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:34869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dO6-0001QZ-Bl
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:06 -0400
Received: by mail-qk0-x232.google.com with SMTP id q1so51941517qkd.2
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:35 -0700
Message-Id: <20170502192300.2124-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/25] tcg cross-tb optimizations
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

Changes since v5:
  * MIPS patches from Aurelien.
  * AArch64 patches from Emilio.
  * ARM32 backend support for goto_ptr
  * Alpha frontend patch rewritten; the former patch appears to
    drop clock interrupts, not exiting the kernel's idle loop.
    I never *really* figured out why, since both patches seem
    to annotate the same TBs in the same way.
  * Front end patchs for hppa and s390.


r~


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

Richard Henderson (12):
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
  target/alpha: Use tcg_gen_lookup_and_goto_ptr

 configure                    |  6 ++---
 cpu-exec.c                   |  6 ++---
 include/exec/exec-all.h      |  2 ++
 include/exec/tb-hash.h       | 12 ++++++++++
 include/qemu/atomic.h        | 34 +++++++++++++++++++++-------
 target/alpha/translate.c     | 54 ++++++++++++++++++++++++++++++++++++++------
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
 tcg/tcg-op.c                 | 13 +++++++++++
 tcg/tcg-op.h                 | 11 +++++++++
 tcg/tcg-opc.h                |  1 +
 tcg/tcg-runtime.h            |  2 ++
 tcg/tcg.c                    |  5 ++++
 tcg/tcg.h                    |  1 +
 tcg/tci/tcg-target.h         |  1 +
 38 files changed, 378 insertions(+), 77 deletions(-)

-- 
2.9.3
