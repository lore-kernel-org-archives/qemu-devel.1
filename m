Received: from eggs.gnu.org ([2001:4830:134:3::10]:53851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHG4z-0004GW-LW
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHG4w-0007bD-HS
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:41 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:41707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHG4w-0007an-9p
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:38 -0500
Received: by mail-wm0-x22c.google.com with SMTP id b189so6312515wmd.0
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:27:38 -0800 (PST)
Received: from cloudburst.twiddle.net
	(70.red-37-158-60.dynamicip.rima-tde.net. [37.158.60.70])
	by smtp.gmail.com with ESMTPSA id
	e124sm706517wmg.34.2017.11.21.13.27.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 Nov 2017 13:27:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 21 Nov 2017 22:25:08 +0100
Message-Id: <20171121212534.5177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/26] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Quite a lot has changed since last time.

The representation has changed such that the vector length and element
size is stored in the TCGOp structure.  The functions have changed such
that the element size is passed explicitly rather than being encoded in
the function name.

I've added additional operations for multiply, immediate shifts, compares,
element interleaves, and widening.  I believe this is all we'll need for
implementing ARM SVE, so I'll leave off for now.

This has been tested vs aa64 risu on both x86_64 and aa64 hosts.


r~


Richard Henderson (26):
  tcg: Remove TCGV_UNUSED* and TCGV_IS_UNUSED*
  tcg: Dynamically allocate TCGOps
  tcg: Generalize TCGOp parameters
  tcg: Add types and basic operations for host vectors
  tcg: Add generic vector expanders
  tcg: Allow multiple word entries into the constant pool
  tcg: Add tcg_signed_cond
  target/arm: Align vector registers
  target/arm: Use vector infrastructure for aa64 add/sub/logic
  target/arm: Use vector infrastructure for aa64 mov/not/neg
  target/arm: Use vector infrastructure for aa64 dup/movi
  tcg/i386: Add vector operations
  tcg: Add tcg_expand_vec_op and tcg-target.opc.h
  tcg: Add generic vector ops for interleave
  target/arm: Use vector infrastructure for aa64 zip/uzp/trn/xtn
  tcg: Add generic vector ops for constant shifts
  target/arm: Use vector infrastructure for aa64 constant shifts
  tcg: Add generic vector ops for comparisons
  target/arm: Use vector infrastructure for aa64 compares
  tcg/i386: Add vector operations/expansions for shift/cmp/interleave
  tcg: Add generic vector ops for multiplication
  target/arm: Use vector infrastructure for aa64 multiplies
  tcg: Add generic vector ops for extension
  target/arm: Use vector infrastructure for aa64 widening shifts
  tcg/i386: Add vector operations/expansions for mul/extend
  tcg/aarch64: Add vector operations

 Makefile.target               |    4 +-
 accel/tcg/tcg-runtime.h       |  102 +++
 include/exec/gen-icount.h     |    9 +-
 include/qemu/queue.h          |    5 +
 target/arm/cpu.h              |    2 +-
 target/arm/translate.h        |   10 +-
 tcg/aarch64/tcg-target.h      |   30 +-
 tcg/aarch64/tcg-target.opc.h  |    3 +
 tcg/i386/tcg-target.h         |   46 +-
 tcg/i386/tcg-target.opc.h     |   11 +
 tcg/tcg-gvec-desc.h           |   49 +
 tcg/tcg-op-gvec.h             |  219 +++++
 tcg/tcg-op.h                  |   55 +-
 tcg/tcg-opc.h                 |   59 ++
 tcg/tcg.h                     |  135 ++-
 accel/tcg/tcg-runtime-gvec.c  |  616 +++++++++++++
 target/alpha/translate.c      |   22 +-
 target/arm/translate-a64.c    | 1135 ++++++++++++++++-------
 target/arm/translate.c        |   31 +-
 target/cris/translate.c       |    4 +-
 target/hppa/translate.c       |   63 +-
 target/i386/translate.c       |   13 +-
 target/lm32/translate.c       |    2 -
 target/m68k/translate.c       |   14 +-
 target/microblaze/translate.c |    4 -
 target/mips/translate.c       |    2 +-
 target/nios2/translate.c      |    6 +-
 target/ppc/translate.c        |    2 +-
 target/s390x/translate.c      |   42 +-
 target/sh4/translate.c        |    2 +-
 target/sparc/translate.c      |    2 +-
 target/tilegx/translate.c     |   10 +-
 target/unicore32/translate.c  |    4 +-
 tcg/aarch64/tcg-target.inc.c  |  674 +++++++++++++-
 tcg/i386/tcg-target.inc.c     | 1325 +++++++++++++++++++++++++--
 tcg/optimize.c                |   20 +-
 tcg/tcg-op-gvec.c             | 2010 +++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c              |  566 ++++++++++++
 tcg/tcg-op.c                  |   24 -
 tcg/tcg-pool.inc.c            |  115 ++-
 tcg/tcg.c                     |  286 ++++--
 accel/tcg/Makefile.objs       |    2 +-
 tcg/README                    |  148 +++
 43 files changed, 7107 insertions(+), 776 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target.opc.h
 create mode 100644 tcg/i386/tcg-target.opc.h
 create mode 100644 tcg/tcg-gvec-desc.h
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 accel/tcg/tcg-runtime-gvec.c
 create mode 100644 tcg/tcg-op-gvec.c
 create mode 100644 tcg/tcg-op-vec.c

-- 
2.13.6
