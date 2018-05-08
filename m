Received: from eggs.gnu.org ([2001:4830:134:3::10]:59474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG4KC-0006Xd-UY
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG4K8-00084W-Vd
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:44 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:43440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fG4K8-00083l-OP
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:40 -0400
Received: by mail-pg0-x22c.google.com with SMTP id k11-v6so20197544pgo.10
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:14:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  8 May 2018 08:14:27 -0700
Message-Id: <20180508151437.4232-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 00/10] target/arm: Implement v8.1-Atomics
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

This implements the Atomics extension, which is mandatory for v8.1.
While testing the v8.2-SVE extension, I've run into issues with the
GCC testsuite expecting this to exist.

Missing is the wiring up of the system registers to indicate that
the extension exists, but we have no system CPU model that would
exercise such a setting.

Changes since v3:
  * Patch 8: Do not zero-extend X[s] via the third parameter
    to read_cpu_reg.

Changes since v2:
  * New patch to use a helper macro for opposite-endian
    atomic_fetch_add and atomic_add_fetch, as suggested
    by pm215.
  * Introduce ARM_FEATURE_V8_1 and define ARM_FEATURE_V8_ATOMICS
    in terms of that, reinforcing the mandatory nature of
    the extension.
  * Typo fix in patch 8.


r~


Richard Henderson (10):
  tcg: Introduce helpers for integer min/max
  target/arm: Use new min/max expanders
  target/xtensa: Use new min/max expanders
  tcg: Introduce atomic helpers for integer min/max
  tcg: Use GEN_ATOMIC_HELPER_FN for opposite endian atomic add
  target/riscv: Use new atomic min/max expanders
  target/arm: Introduce ARM_FEATURE_V8_ATOMICS and initial decode
  target/arm: Fill in disas_ldst_atomic
  target/arm: Implement CAS and CASP
  target/arm: Enable ARM_FEATURE_V8_ATOMICS for user-only

 accel/tcg/atomic_template.h | 112 +++++++----
 accel/tcg/tcg-runtime.h     |   8 +
 target/arm/cpu.h            |   2 +
 target/arm/helper-a64.h     |   2 +
 tcg/tcg-op.h                |  50 +++++
 tcg/tcg.h                   |   8 +
 linux-user/elfload.c        |   1 +
 target/arm/cpu64.c          |   1 +
 target/arm/helper-a64.c     |  43 +++++
 target/arm/translate-a64.c  | 375 ++++++++++++++++++++++++++++--------
 target/riscv/translate.c    |  72 ++-----
 target/xtensa/translate.c   |  50 +++--
 tcg/tcg-op.c                |  48 +++++
 13 files changed, 587 insertions(+), 185 deletions(-)

-- 
2.17.0
