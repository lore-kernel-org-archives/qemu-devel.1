Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2K-00048d-N7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzh-0000aG-Jw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzh-0000WQ-BQ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id a12so21813766wrq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 30 Apr 2019 17:52:19 +0100
Message-Id: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 00/15] demacro softmmu (plus tests/coverage)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>


Hi,

This is the latest iteration of the softmmu demacro series. The main
changes from the last submission are some updates from Richard. Some
are merged into the main demacro patch (mostly casting cleanups) and
then a series of 3 patches to out of line some of the less hot code to
keep the main access functions a reasonable size. For example:

  readelf -s aarch64-softmmu/accel/tcg/cputlb.o | ag helper |\
    ag -v atomic | ag mmu | tr -s ' ' | cut -d ' ' -f 4,9 | sort -n

Before:

  16 helper_be_ldsl_mmu
  16 helper_le_ldsl_mmu
  18 helper_be_ldsw_mmu
  18 helper_le_ldsw_mmu
  18 helper_ret_ldsb_mmu
  535 helper_ret_ldub_mmu
  556 helper_ret_ldb_cmmu
  586 helper_ret_stb_mmu
  679 helper_le_ldul_mmu
  681 helper_be_ldul_mmu
  685 helper_le_ldq_mmu
  688 helper_be_ldq_mmu
  688 helper_le_lduw_mmu
  693 helper_le_ldl_cmmu
  701 helper_le_ldq_cmmu
  701 helper_le_ldw_cmmu
  703 helper_be_ldl_cmmu
  704 helper_be_ldq_cmmu
  708 helper_be_lduw_mmu
  713 helper_be_ldw_cmmu
  943 helper_le_stw_mmu
  944 helper_le_stl_mmu
  952 helper_be_stl_mmu
  952 helper_le_stq_mmu
  959 helper_be_stw_mmu
  960 helper_be_stq_mmu

After:

  5 helper_be_ldul_mmu
  5 helper_be_lduw_mmu
  5 helper_le_ldul_mmu
  5 helper_le_lduw_mmu
  5 helper_ret_ldub_mmu
  14 helper_be_ldl_cmmu
  14 helper_be_ldw_cmmu
  14 helper_le_ldl_cmmu
  14 helper_le_ldw_cmmu
  16 helper_be_ldsl_mmu
  16 helper_le_ldsl_mmu
  18 helper_be_ldsw_mmu
  18 helper_le_ldsw_mmu
  18 helper_ret_ldsb_mmu
  783 helper_ret_stb_mmu
  785 helper_ret_ldb_cmmu
  881 helper_be_ldq_mmu
  881 helper_le_ldq_mmu
  889 helper_le_ldq_cmmu
  897 helper_be_ldq_cmmu
  1150 helper_be_stw_mmu
  1150 helper_le_stw_mmu
  1151 helper_be_stq_mmu
  1151 helper_le_stl_mmu
  1151 helper_le_stq_mmu
  1159 helper_be_stl_mmu

I've also moved the existing system memory test and made it multiarch
and added the bootstrapping for aarch64 system tests. I would like to
add support for Big Endian as well but I didn't want to delay the
posting of the series. It would also be nice to exercise the
ioread/write paths and other handling but I leave this as an exercise
for later.

There are also some minor tweaks for the code coverage reports now I'm
running with out-of-tree builds.

Alex Bennée (11):
  tests/tcg/multiarch: add support for multiarch system tests
  tests/tcg/multiarch: add hello world system test
  tests/tcg/aarch64: add system boot.S
  tests/tcg/multiarch: move the system memory test
  tests/tcg/minilib: support %c format char
  tests/tcg/multiarch: expand system memory test to cover more
  accel/tcg: demacro cputlb
  accel/tcg: remove softmmu_template.h
  Makefile: fix coverage-report reference to BUILD_DIR
  Makefile: include per-target build directories in coverage report
  Makefile.target: support per-target coverage reports

Richard Henderson (4):
  cputlb: Move TLB_RECHECK handling into load/store_helper
  cputlb: Drop attribute flatten
  cputlb: Do unaligned load recursion to outermost function
  cputlb: Do unaligned store recursion to outermost function

 Makefile                                      |   4 +-
 Makefile.target                               |  16 +
 accel/tcg/cputlb.c                            | 626 +++++++++++++++---
 accel/tcg/softmmu_template.h                  | 454 -------------
 tests/tcg/Makefile                            |   1 +
 tests/tcg/aarch64/Makefile.softmmu-target     |  32 +
 tests/tcg/aarch64/system/boot.S               | 200 ++++++
 tests/tcg/aarch64/system/kernel.ld            |  22 +
 tests/tcg/i386/Makefile.softmmu-target        |   2 +-
 tests/tcg/i386/system/memory.c                | 243 -------
 tests/tcg/minilib/printf.c                    |   6 +-
 .../multiarch/system/Makefile.softmmu-target  |  14 +
 tests/tcg/{i386 => multiarch}/system/hello.c  |   0
 tests/tcg/multiarch/system/memory.c           | 427 ++++++++++++
 14 files changed, 1267 insertions(+), 780 deletions(-)
 delete mode 100644 accel/tcg/softmmu_template.h
 create mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/aarch64/system/boot.S
 create mode 100644 tests/tcg/aarch64/system/kernel.ld
 delete mode 100644 tests/tcg/i386/system/memory.c
 create mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
 rename tests/tcg/{i386 => multiarch}/system/hello.c (100%)
 create mode 100644 tests/tcg/multiarch/system/memory.c

-- 
2.20.1
