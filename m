Received: from eggs.gnu.org ([2001:4830:134:3::10]:51587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBrE6-0001x2-HF
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBrE5-0004OR-JN
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:27:02 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fBrE5-0004O1-Dm
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:27:01 -0400
Received: by mail-pg0-x243.google.com with SMTP id i6-v6so152368pgv.3
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 17:27:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Apr 2018 14:26:42 -1000
Message-Id: <20180427002651.28356-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/9] target/arm: Implement v8.1-Atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

This implements the Atomics extension, which is mandatory for v8.1.
While testing the v8.2-SVE extension, I've run into issues with the
GCC testsuite expecting this to exist.

Missing is the wiring up of the system registers to indicate that
the extension exists, but we have no system CPU model that would
exercise such a setting.


r~


PS: Given the extension is mandatory, it might be better to save
feature bits and file this under ARM_FEATURE_V8_1.  Thoughts?

PPS: Testing for this will proceed overnight.  It takes a while
to run the gcc testsuite and I'm ready to stop for the day.  ;-)


Richard Henderson (9):
  tcg: Introduce helpers for integer min/max
  target/arm: Use new min/max expanders
  target/xtensa: Use new min/max expanders
  tcg: Introduce atomic helpers for integer min/max
  target/riscv: Use new atomic min/max expanders
  target/arm: Introduce ARM_FEATURE_V8_ATOMICS and initial decode
  target/arm: Fill in disas_ldst_atomic
  target/arm: Implement CAS and CASP
  target/arm: Enable ARM_FEATURE_V8_ATOMICS for user-only

 accel/tcg/atomic_template.h |  71 +++++++++
 accel/tcg/tcg-runtime.h     |   8 +
 target/arm/cpu.h            |   1 +
 target/arm/helper-a64.h     |   2 +
 tcg/tcg-op.h                |  50 ++++++
 tcg/tcg.h                   |   8 +
 linux-user/elfload.c        |   1 +
 target/arm/cpu64.c          |   1 +
 target/arm/helper-a64.c     |  43 +++++
 target/arm/translate-a64.c  | 375 +++++++++++++++++++++++++++++++++++---------
 target/riscv/translate.c    |  72 +++------
 target/xtensa/translate.c   |  50 ++++--
 tcg/tcg-op.c                |  48 ++++++
 13 files changed, 583 insertions(+), 147 deletions(-)

-- 
2.14.3
