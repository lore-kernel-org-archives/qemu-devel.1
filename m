Received: from eggs.gnu.org ([209.51.188.92]:35459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVb-00017P-8v
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVa-0006v4-5f
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:38:59 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:37006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIxVZ-0006ul-TL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:38:58 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 8so7693650pfr.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 08:38:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Apr 2019 08:38:46 -0700
Message-Id: <20190423153853.19790-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/7] tcg: Restart TB generation on overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com

This is for lauchpad 1824853.  The v1 patch set fixed this for
x86 as a host.  This goes further to handle the other cases in
which a TB can become too large, resulting in overflows from
relocations.

Finally, the last two patches take advantage of this.  Since
we now have a reliable way to try again if a relocation overflows,
we can avoid adding extra nops on the off-chance we have to deal
with very large TBs.

There is possibly room for additional work in tcg/riscv, with
respect to its short conditional branches.  But that's probably
best left to someone who can test that properly.


r~


Richard Henderson (7):
  tcg: Hoist max_insns computation to tb_gen_code
  tcg: Restart after TB code generation overflow
  tcg: Restart TB generation after relocation overflow
  tcg: Restart TB generation after constant pool overflow
  tcg: Restart TB generation after out-of-line ldst overflow
  tcg/ppc: Allow the constant pool to overflow at 32k
  tcg/arm: Restrict constant pool displacement to 12 bits

 include/exec/exec-all.h       |  4 +-
 include/exec/translator.h     |  3 +-
 tcg/tcg.h                     | 15 +++----
 accel/tcg/translate-all.c     | 53 +++++++++++++++++++----
 accel/tcg/translator.c        | 15 +------
 target/alpha/translate.c      |  4 +-
 target/arm/translate.c        |  4 +-
 target/cris/translate.c       | 10 +----
 target/hppa/translate.c       |  5 +--
 target/i386/translate.c       |  4 +-
 target/lm32/translate.c       | 10 +----
 target/m68k/translate.c       |  4 +-
 target/microblaze/translate.c | 10 +----
 target/mips/translate.c       |  4 +-
 target/moxie/translate.c      | 11 +----
 target/nios2/translate.c      | 14 +-----
 target/openrisc/translate.c   |  4 +-
 target/ppc/translate.c        |  4 +-
 target/riscv/translate.c      |  4 +-
 target/s390x/translate.c      |  4 +-
 target/sh4/translate.c        |  4 +-
 target/sparc/translate.c      |  4 +-
 target/tilegx/translate.c     | 12 +-----
 target/tricore/translate.c    | 16 +------
 target/unicore32/translate.c  | 10 +----
 target/xtensa/translate.c     |  4 +-
 tcg/aarch64/tcg-target.inc.c  | 16 ++++---
 tcg/arm/tcg-target.inc.c      | 73 ++++++++++++++-----------------
 tcg/i386/tcg-target.inc.c     |  6 ++-
 tcg/mips/tcg-target.inc.c     |  6 ++-
 tcg/ppc/tcg-target.inc.c      | 42 +++++++++---------
 tcg/riscv/tcg-target.inc.c    | 16 +++++--
 tcg/s390/tcg-target.inc.c     | 20 +++++----
 tcg/tcg-ldst.inc.c            | 18 ++++----
 tcg/tcg-pool.inc.c            | 12 +++---
 tcg/tcg.c                     | 81 ++++++++++++++++++-----------------
 36 files changed, 246 insertions(+), 280 deletions(-)

-- 
2.17.1
