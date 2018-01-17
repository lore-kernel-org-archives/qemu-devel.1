Received: from eggs.gnu.org ([2001:4830:134:3::10]:36850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqHW-0001dx-7l
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqHT-0001CV-0p
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:09:42 -0500
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:36824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebqHS-0001C7-O2
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:09:38 -0500
Received: by mail-pl0-x22f.google.com with SMTP id q2so9208979pll.3
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 08:09:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 17 Jan 2018 08:09:12 -0800
Message-Id: <20180117160933.28086-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10 00/21] tcg: generic vector operations
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


Richard Henderson (21):
  tcg: Allow multiple word entries into the constant pool
  tcg: Add types and basic operations for host vectors
  tcg: Standardize integral arguments to expanders
  tcg: Add generic vector expanders
  tcg: Loosen vec_gen_op* typecheck rules
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
 tcg/tcg-op-gvec.h            |  297 ++++++
 tcg/tcg-op.h                 |   55 +-
 tcg/tcg-opc.h                |   47 +
 tcg/tcg.h                    |   78 ++
 accel/tcg/tcg-runtime-gvec.c |  997 +++++++++++++++++++
 target/arm/translate-a64.c   |  974 +++++++++++++-----
 tcg/aarch64/tcg-target.inc.c |  607 +++++++++++-
 tcg/i386/tcg-target.inc.c    | 1043 +++++++++++++++++++-
 tcg/optimize.c               |  150 +--
 tcg/tcg-op-gvec.c            | 2226 ++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  474 +++++++++
 tcg/tcg-op.c                 |   42 +-
 tcg/tcg-pool.inc.c           |  115 ++-
 tcg/tcg.c                    |  129 ++-
 accel/tcg/Makefile.objs      |    2 +-
 configure                    |   48 +
 tcg/README                   |   95 ++
 25 files changed, 7151 insertions(+), 483 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target.opc.h
 create mode 100644 tcg/i386/tcg-target.opc.h
 create mode 100644 tcg/tcg-gvec-desc.h
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 accel/tcg/tcg-runtime-gvec.c
 create mode 100644 tcg/tcg-op-gvec.c
 create mode 100644 tcg/tcg-op-vec.c

-- 
2.14.3
