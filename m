Received: from eggs.gnu.org ([209.51.188.92]:47287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFcG-0006zi-CZ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFRA-0006AM-VQ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:30 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:44587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goFR9-000693-8O
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:27 -0500
Received: by mail-ot1-x32b.google.com with SMTP id g16so12158035otg.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 14:31:06 -0800
Message-Id: <20190128223118.5255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 00/12] target/arm: Implement ARMv8.5-BTI
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

The branch target identification extension does not yet have
kernel or gcc support.  It should be in shape for developing
those though.

In system mode I do honor the GP bit from the page tables.
In user-only mode, there is a way to pretend that the GP bit
is always set.  Further linux-user changes will have to track
the ABI that gets developed.

In the meantime, provide a statically linable make check-tcg 
test for the functionality.

Changes since v2:
  * Rebase on master.
  * Incorporate feedback from Peter.


r~


Richard Henderson (12):
  target/arm: Introduce isar_feature_aa64_bti
  target/arm: Add PSTATE.BTYPE
  target/arm: Add BT and BTYPE to tb->flags
  exec: Add target-specific tlb bits to MemTxAttrs
  target/arm: Cache the GP bit for a page in MemTxAttrs
  target/arm: Default handling of BTYPE during translation
  target/arm: Reset btype for direct branches
  target/arm: Set btype for indirect branches
  target/arm: Add x-guarded-pages cpu property for user-only
  target/arm: Enable BTI for -cpu max
  linux-user/aarch64: Reset btype for syscalls and signals
  tests/tcg/aarch64: Add bti smoke test

 include/exec/memattrs.h           |  10 ++
 target/arm/cpu.h                  |  24 +++-
 target/arm/internals.h            |   6 +
 target/arm/translate.h            |   9 ++
 linux-user/aarch64/cpu_loop.c     |  15 +++
 target/arm/cpu64.c                |  22 ++++
 target/arm/helper.c               |  28 +++--
 target/arm/translate-a64.c        | 193 +++++++++++++++++++++++++++++-
 tests/tcg/aarch64/bti-1.c         |  61 ++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   |  51 ++++++++
 tests/tcg/aarch64/Makefile.target |   7 +-
 11 files changed, 415 insertions(+), 11 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

-- 
2.17.2
