Received: from eggs.gnu.org ([2001:4830:134:3::10]:48749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYjgT-0007n8-J2
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 22:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYjgQ-0002x2-3C
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 22:35:09 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:35055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gYjgP-0002uK-IU
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 22:35:06 -0500
Received: by mail-pg1-x534.google.com with SMTP id s198so5423314pgs.2
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 19:35:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 16 Dec 2018 19:35:00 -0800
Message-Id: <20181217033501.18073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/33] tcg patch queue
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

Now include a patch to address

qemu-system-x86_64: /home/pm215/qemu/tcg/sparc/tcg-target.inc.c:319:
patch_reloc: Assertion `check_fit_ptr(value, 13)' failed.

I believe it was the change to bswap64 to use the constant pool more
often that exposed the latent problem.

Only re-posting the new patch.


r~


The following changes since commit 58b1f0f21edcab13f78a376b1d90267626be1275:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-12-16 12:49:06 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20181216

for you to fetch changes up to b7c2cd08a6f68010ad27c9c0bf2fde02fb743a0e:

  xxhash: match output against the original xxhash32 (2018-12-17 06:04:44 +0300)

----------------------------------------------------------------
- Remove retranslation remenents
- Return success from patch_reloc
- Preserve 32-bit values as zero-extended on x86_64
- Make bswap during memory ops as optional
- Cleanup xxhash
- Revert constant pooling for tcg/sparc/

----------------------------------------------------------------
Alistair Francis (1):
      tcg/mips: Improve the add2/sub2 command to use TCG_TARGET_REG_BITS

Emilio G. Cota (5):
      tcg: Drop nargs from tcg_op_insert_{before,after}
      qht-bench: document -p flag
      exec: introduce qemu_xxhash{2,4,5,6,7}
      include: move exec/tb-hash-xx.h to qemu/xxhash.h
      xxhash: match output against the original xxhash32

Richard Henderson (27):
      target/sparc: Remove the constant pool
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
 tcg/sparc/tcg-target.inc.c                   |  58 ++------
 tcg/tcg-op.c                                 | 215 ++++++++++++++++++++-------
 tcg/tcg.c                                    |  18 +--
 tcg/tci/tcg-target.inc.c                     |   3 +-
 tests/qht-bench.c                            |   5 +-
 util/qsp.c                                   |  14 +-
 24 files changed, 460 insertions(+), 400 deletions(-)
 rename include/{exec/tb-hash-xx.h => qemu/xxhash.h} (73%)
