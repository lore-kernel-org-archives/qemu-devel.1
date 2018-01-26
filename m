Received: from eggs.gnu.org ([2001:4830:134:3::10]:60130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eexao-0006d1-3P
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 01:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eexal-0000cU-0R
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 01:34:30 -0500
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:39293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eexak-0000cE-Rn
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 01:34:26 -0500
Received: by mail-pf0-x22e.google.com with SMTP id e11so7645149pff.6
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 22:34:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 25 Jan 2018 20:57:22 -0800
Message-Id: <20180126045742.5487-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 00/20] tcg: generic vector operations
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

Changes since v11:
  * Use dup_const more.
  * Cleanup some gvec 2i and 2s routines.
  * Use more helpers and less gotos in target/arm/translate-a64.c.

Changes since v10:
  * Squashed a fixup patch which escaped my attention while preparing
    the patch set.  Ho hum.

Changes since v9:
  * Detect whether __attribute__((vector_size(16))) operations are
    supported by the host compiler.  This includes the case affecting
    ppc64 where gcc-4.8.5 crashes.  Note that gcc-7.2 does pass the
    test on ppc64.

  * Dropped support for vector interleaves and element size changes.
    My target/arm patches were failing RISU checks on a big-endian host.
    I need to re-think what to do about host endianness and target
    representation of vector operations crossing lanes.  For now, only
    support generic vector operations that are agnostic to element order.


r~


Richard Henderson (20):
  tcg: Allow multiple word entries into the constant pool
  tcg: Add types and basic operations for host vectors
  tcg: Standardize integral arguments to expanders
  tcg: Add generic vector expanders
  tcg: Add generic vector ops for constant shifts
  tcg: Add generic vector ops for comparisons
  tcg: Add generic vector ops for multiplication
  tcg: Add generic helpers for saturating arithmetic
  tcg: Add generic vector helpers with a scalar operand
  tcg/optimize: Handle vector opcodes during optimize
  target/arm: Align vector registers
  target/arm: Use vector infrastructure for aa64 add/sub/logic
  target/arm: Use vector infrastructure for aa64 mov/not/neg
  target/arm: Use vector infrastructure for aa64 dup/movi
  target/arm: Use vector infrastructure for aa64 constant shifts
  target/arm: Use vector infrastructure for aa64 compares
  target/arm: Use vector infrastructure for aa64 multiplies
  target/arm: Use vector infrastructure for aa64 orr/bic immediate
  tcg/i386: Add vector operations
  tcg/aarch64: Add vector operations

 Makefile.target              |    4 +-
 accel/tcg/tcg-runtime.h      |  118 +++
 target/arm/cpu.h             |    2 +-
 tcg/aarch64/tcg-target.h     |   25 +-
 tcg/aarch64/tcg-target.opc.h |    3 +
 tcg/i386/tcg-target.h        |   41 +-
 tcg/i386/tcg-target.opc.h    |   13 +
 tcg/tcg-gvec-desc.h          |   49 +
 tcg/tcg-op-gvec.h            |  306 ++++++
 tcg/tcg-op.h                 |   52 +-
 tcg/tcg-opc.h                |   46 +
 tcg/tcg.h                    |   87 ++
 accel/tcg/tcg-runtime-gvec.c |  997 +++++++++++++++++++
 target/arm/translate-a64.c   |  979 ++++++++++++++-----
 tcg/aarch64/tcg-target.inc.c |  588 ++++++++++-
 tcg/i386/tcg-target.inc.c    |  987 ++++++++++++++++++-
 tcg/optimize.c               |  150 +--
 tcg/tcg-op-gvec.c            | 2215 ++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  389 ++++++++
 tcg/tcg-op.c                 |   42 +-
 tcg/tcg-pool.inc.c           |  115 ++-
 tcg/tcg.c                    |  125 ++-
 accel/tcg/Makefile.objs      |    2 +-
 configure                    |   48 +
 tcg/README                   |   86 ++
 25 files changed, 6973 insertions(+), 496 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target.opc.h
 create mode 100644 tcg/i386/tcg-target.opc.h
 create mode 100644 tcg/tcg-gvec-desc.h
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 accel/tcg/tcg-runtime-gvec.c
 create mode 100644 tcg/tcg-op-gvec.c
 create mode 100644 tcg/tcg-op-vec.c

-- 
2.14.3
