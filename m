Received: from eggs.gnu.org ([209.51.188.92]:55825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHQ-0004Qa-4a
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHP-0007Sk-Ax
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:48 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghZHO-0007QH-EH
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:47 -0500
Received: by mail-pl1-x642.google.com with SMTP id a14so5099025plm.12
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 04:17:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Jan 2019 23:17:25 +1100
Message-Id: <20190110121736.23448-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/11] target/arm: Implement ARMv8.5-BTI
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


r~


Richard Henderson (11):
  target/arm: Introduce isar_feature_aa64_bti
  target/arm: Add PSTATE.BTYPE
  target/arm: Add BT and BTYPE to tb->flags
  target/arm: Record the GP bit for a page in MemTxAttrs
  target/arm: Default handling of BTYPE during translation
  target/arm: Reset btype for direct branches and syscalls
  target/arm: Set btype for indirect branches
  target/arm: Add guarded_pages cpu property for user-only
  target/arm: Enable BTI for -cpu max
  linux-user/aarch64: Reset btype for signal handlers
  tests/tcg/aarch64: Add bti smoke test

 include/exec/memattrs.h           |   2 +
 target/arm/cpu.h                  |  22 +++-
 target/arm/internals.h            |   6 +
 target/arm/translate.h            |   9 ++
 linux-user/aarch64/signal.c       |   4 +
 target/arm/cpu64.c                |  22 ++++
 target/arm/helper.c               |  28 +++--
 target/arm/translate-a64.c        | 196 +++++++++++++++++++++++++++++-
 tests/tcg/aarch64/bti-1.c         |  61 ++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   |  51 ++++++++
 tests/tcg/aarch64/Makefile.target |   7 +-
 11 files changed, 397 insertions(+), 11 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

-- 
2.17.2
