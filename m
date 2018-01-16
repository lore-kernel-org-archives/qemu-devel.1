Received: from eggs.gnu.org ([2001:4830:134:3::10]:59502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebI0r-0004l0-NX
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebI0o-000386-K6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:13 -0500
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:45420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebI0o-00037r-DJ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:10 -0500
Received: by mail-pf0-x22d.google.com with SMTP id a88so7487056pfe.12
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:34:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 15 Jan 2018 19:33:38 -0800
Message-Id: <20180116033404.31532-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 00/26] tcg: generic vector operations
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

I think this will be the last revision before queueing for pull.

Peter, the target/arm patches here are primarily for testing,
without having to go all the way through to SVE.  It also shows
how the generic vector interface ought to be used.  I'm happy
to drop the patches from the tcg pull and feed them through
target-arm.next, or keep them here as you wish.


r~


Minor changes since v8:
  * Reduce some code duplication within the patches.
  * Add vector op scalar interface.

Minor changes since v7:
  * Rearranged the patches into groups for readability.
  * Squished the tcg/i386 patches.
  * Fixed an encoding bug for vmovd xmm, reg (Kirill).
  * Fixed expansion bugs for i386 sar, trn.

Minor changes since v6:
  * Two bugs fixed pointed out by Kirill.
  * Allow for 4 and 5 operand operations.


Richard Henderson (26):
  tcg: Allow multiple word entries into the constant pool
  tcg: Add types and basic operations for host vectors
  tcg: Standardize integral arguments to expanders
  tcg: Add generic vector expanders
  tcg: Add generic vector ops for interleave
  tcg: Add generic vector ops for constant shifts
  tcg: Add generic vector ops for comparisons
  tcg: Add generic vector ops for multiplication
  tcg: Add generic vector ops for extension
  tcg: Add generic helpers for saturating arithmetic
  tcg: Loosen vec_gen_op* typecheck rules
  tcg: Add generic vector helpers with a scalar immediate operand
  tcg: Add generic vector helpers with a scalar variable operand
  tcg/optimize: Handle vector opcodes during optimize
  target/arm: Align vector registers
  target/arm: Use vector infrastructure for aa64 add/sub/logic
  target/arm: Use vector infrastructure for aa64 mov/not/neg
  target/arm: Use vector infrastructure for aa64 dup/movi
  target/arm: Use vector infrastructure for aa64 zip/uzp/trn/xtn
  target/arm: Use vector infrastructure for aa64 constant shifts
  target/arm: Use vector infrastructure for aa64 compares
  target/arm: Use vector infrastructure for aa64 multiplies
  target/arm: Use vector infrastructure for aa64 widening shifts
  target/arm: Use vector infrastructure for aa64 orr/bic immediate
  tcg/i386: Add vector operations
  tcg/aarch64: Add vector operations

 Makefile.target              |    4 +-
 accel/tcg/tcg-runtime.h      |  141 +++
 target/arm/cpu.h             |    2 +-
 tcg/aarch64/tcg-target.h     |   30 +-
 tcg/aarch64/tcg-target.opc.h |    3 +
 tcg/i386/tcg-target.h        |   46 +-
 tcg/i386/tcg-target.opc.h    |   13 +
 tcg/tcg-gvec-desc.h          |   49 +
 tcg/tcg-op-gvec.h            |  319 +++++
 tcg/tcg-op.h                 |   67 +-
 tcg/tcg-opc.h                |   59 +
 tcg/tcg.h                    |   84 ++
 accel/tcg/tcg-runtime-gvec.c | 1064 +++++++++++++++++
 target/arm/translate-a64.c   | 1106 ++++++++++++------
 tcg/aarch64/tcg-target.inc.c |  674 ++++++++++-
 tcg/i386/tcg-target.inc.c    | 1331 ++++++++++++++++++++-
 tcg/optimize.c               |  150 +--
 tcg/tcg-op-gvec.c            | 2653 ++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  566 +++++++++
 tcg/tcg-op.c                 |   42 +-
 tcg/tcg-pool.inc.c           |  115 +-
 tcg/tcg.c                    |  144 ++-
 accel/tcg/Makefile.objs      |    2 +-
 tcg/README                   |  148 +++
 24 files changed, 8244 insertions(+), 568 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target.opc.h
 create mode 100644 tcg/i386/tcg-target.opc.h
 create mode 100644 tcg/tcg-gvec-desc.h
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 accel/tcg/tcg-runtime-gvec.c
 create mode 100644 tcg/tcg-op-gvec.c
 create mode 100644 tcg/tcg-op-vec.c

-- 
2.14.3
