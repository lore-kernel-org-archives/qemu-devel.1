Received: from eggs.gnu.org ([2001:4830:134:3::10]:58654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0i-0005pY-0l
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0e-0006A4-O3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:31 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:41307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0e-000650-5N
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:28 -0500
Received: by mail-ot1-x32b.google.com with SMTP id u16so4104971otk.8
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:18:50 -0600
Message-Id: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/32] tcg patch queue
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

The following changes since commit 2d894e48362ad2a576fca929dcca1787f43a8af6:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2018-12-13 17:50:45 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20181213

for you to fetch changes up to 99f70ba5b6b4566509b2069a8d29c6686b8115de:

  xxhash: match output against the original xxhash32 (2018-12-13 18:56:11 -0600)

----------------------------------------------------------------
- Remove retranslation remenents
- Return success from patch_reloc
- Preserve 32-bit values as zero-extended on x86_64
- Make bswap during memory ops as optional
- Cleanup xxhash

----------------------------------------------------------------
Alistair Francis (1):
      tcg/mips: Improve the add2/sub2 command to use TCG_TARGET_REG_BITS

Emilio G. Cota (5):
      tcg: Drop nargs from tcg_op_insert_{before,after}
      qht-bench: document -p flag
      exec: introduce qemu_xxhash{2,4,5,6,7}
      include: move exec/tb-hash-xx.h to qemu/xxhash.h
      xxhash: match output against the original xxhash32

Richard Henderson (26):
      tcg/i386: Always use %ebp for TCG_AREG0
      tcg/i386: Move TCG_REG_CALL_STACK from define to enum
      tcg/aarch64: Remove reloc_pc26_atomic
      tcg/aarch64: Fold away "noaddr" branch routines
      tcg/arm: Remove reloc_pc24_atomic
      tcg/arm: Fold away "noaddr" branch routines
      tcg/ppc: Fold away "noaddr" branch routines
      tcg/s390: Remove retranslation code
      tcg/sparc: Remove retranslation code
      tcg/mips: Remove retranslation code
      tcg: Return success from patch_reloc
      tcg/i386: Return false on failure from patch_reloc
      tcg/aarch64: Return false on failure from patch_reloc
      tcg/arm: Return false on failure from patch_reloc
      tcg/ppc: Return false on failure from patch_reloc
      tcg/s390x: Return false on failure from patch_reloc
      tcg/i386: Propagate is64 to tcg_out_qemu_ld_direct
      tcg/i386: Propagate is64 to tcg_out_qemu_ld_slow_path
      tcg/i386: Implement INDEX_op_extr{lh}_i64_i32 for 32-bit guests
      tcg/i386: Assume 32-bit values are zero-extended
      tcg/i386: Precompute all guest_base parameters
      tcg/i386: Add setup_guest_base_seg for FreeBSD
      tcg: Clean up generic bswap32
      tcg: Clean up generic bswap64
      tcg/optimize: Optimize bswap
      tcg: Add TCG_TARGET_HAS_MEMORY_BSWAP

 include/exec/tb-hash.h                       |   4 +-
 include/{exec/tb-hash-xx.h => qemu/xxhash.h} |  47 ++++--
 tcg/aarch64/tcg-target.h                     |   1 +
 tcg/arm/tcg-target.h                         |   1 +
 tcg/i386/tcg-target.h                        |  17 +--
 tcg/mips/tcg-target.h                        |   1 +
 tcg/ppc/tcg-target.h                         |   1 +
 tcg/s390/tcg-target.h                        |   1 +
 tcg/sparc/tcg-target.h                       |   1 +
 tcg/tcg.h                                    |   4 +-
 tcg/tci/tcg-target.h                         |   2 +
 tcg/aarch64/tcg-target.inc.c                 |  71 +++------
 tcg/arm/tcg-target.inc.c                     |  55 +++----
 tcg/i386/tcg-target.inc.c                    | 208 ++++++++++++--------------
 tcg/mips/tcg-target.inc.c                    |  12 +-
 tcg/optimize.c                               |  16 +-
 tcg/ppc/tcg-target.inc.c                     |  60 ++++----
 tcg/s390/tcg-target.inc.c                    |  45 +++---
 tcg/sparc/tcg-target.inc.c                   |  13 +-
 tcg/tcg-op.c                                 | 215 ++++++++++++++++++++-------
 tcg/tcg.c                                    |  18 +--
 tcg/tci/tcg-target.inc.c                     |   3 +-
 tests/qht-bench.c                            |   5 +-
 util/qsp.c                                   |  14 +-
 24 files changed, 452 insertions(+), 363 deletions(-)
 rename include/{exec/tb-hash-xx.h => qemu/xxhash.h} (73%)
