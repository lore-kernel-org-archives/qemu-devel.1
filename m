Received: from eggs.gnu.org ([2001:4830:134:3::10]:48179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevj-0007Ks-L5
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevf-0004Y4-LG
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:13:55 -0500
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:43875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXevf-0004W4-EN
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:13:51 -0500
Received: by mail-pl0-x22d.google.com with SMTP id z5so4226266plo.10
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:13:51 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.13.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:13:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:23 -0800
Message-Id: <20180106031346.6650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 00/23] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Minor changes since v7:
  * Rearranged the patches into groups for readability.
  * Squished the tcg/i386 patches.
  * Fixed an encoding bug for vmovd xmm, reg (Kirill).
  * Fixed expansion bugs for i386 sar, trn.

Minor changes since v6:
  * Two bugs fixed pointed out by Kirill.
  * Allow for 4 and 5 operand operations.


This has gotten a bit more testing in conjunction with
my ongoing ARM SVE front-end work.


r~


Richard Henderson (23):
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
  tcg: Add generic vector helpers with a scalar immediate operand
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
  tcg/i386: Add vector operations
  tcg/aarch64: Add vector operations

 Makefile.target              |    4 +-
 accel/tcg/tcg-runtime.h      |  136 +++
 target/arm/cpu.h             |    2 +-
 tcg/aarch64/tcg-target.h     |   30 +-
 tcg/aarch64/tcg-target.opc.h |    3 +
 tcg/i386/tcg-target.h        |   46 +-
 tcg/i386/tcg-target.opc.h    |   13 +
 tcg/tcg-gvec-desc.h          |   49 +
 tcg/tcg-op-gvec.h            |  291 +++++
 tcg/tcg-op.h                 |   67 +-
 tcg/tcg-opc.h                |   59 +
 tcg/tcg.h                    |   81 ++
 accel/tcg/tcg-runtime-gvec.c | 1020 ++++++++++++++++
 target/arm/translate-a64.c   | 1100 +++++++++++------
 tcg/aarch64/tcg-target.inc.c |  674 ++++++++++-
 tcg/i386/tcg-target.inc.c    | 1331 ++++++++++++++++++++-
 tcg/optimize.c               |  141 ++-
 tcg/tcg-op-gvec.c            | 2667 ++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  566 +++++++++
 tcg/tcg-op.c                 |   42 +-
 tcg/tcg-pool.inc.c           |  115 +-
 tcg/tcg.c                    |  144 ++-
 accel/tcg/Makefile.objs      |    2 +-
 tcg/README                   |  148 +++
 24 files changed, 8168 insertions(+), 563 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target.opc.h
 create mode 100644 tcg/i386/tcg-target.opc.h
 create mode 100644 tcg/tcg-gvec-desc.h
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 accel/tcg/tcg-runtime-gvec.c
 create mode 100644 tcg/tcg-op-gvec.c
 create mode 100644 tcg/tcg-op-vec.c

-- 
2.14.3
