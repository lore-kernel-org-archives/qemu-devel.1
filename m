Received: from eggs.gnu.org ([209.51.188.92]:42541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFT-0000Qa-Gr
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFR-00078G-9P
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:43 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFQ-000747-SP
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id o17so23460273wrw.3
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:40 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:21 +0000
Message-Id: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/16] Enabling tcg/tests for cris and
 system mode xtensa & arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is the second version of my system tests for TCG. We actually
only enable system tests for ARM and Xtensa but the framework is all
there for adding the others. I thought I'd get this out for comment
before starting on some softmmu tests for my demacro series. Also in
this set:

  - add cris linux-user to check-tcg
  - fixup some mips hello-world
  - gdb test runner
  - .travis.yml tweaks

checkpatch complains a bit due to the motion of the cris tests. I
actually clean-up the errors in the next patch but didn't want to
merge them together in-case something got missed in the noise.

The following patches need review
  patch 0004/tests tcg add gdb runner variant.patch
  patch 0005/tests tcg mips fix hello mips compilation.patch
  patch 0007/tests tcg xtensa enable system tests.patch
  patch 0009/tests docker add fedora cris cross compilers.patch
  patch 0010/tests tcg split cris tests into bare and libc dir.patch
  patch 0011/tests tcg cris cleanup sys.c.patch
  patch 0012/tests tcg cris comment out the ccs test.patch
  patch 0013/tests tcg cris align mul operations.patch
  patch 0014/tests tcg enable cris base user mode tests.patch
  patch 0015/.travis.yml separate softfloat from check tcg.patch
  patch 0016/.travis.yml add softmmu check tcg tests.patch

Alex Bennée (14):
  tests/tcg: add softmmu awareness to Makefile
  tests/tcg: enable tcg tests for softmmu
  tests/tcg: add QEMU_OPT option for test runner
  tests/tcg: add gdb runner variant
  tests/tcg/mips: fix hello-mips compilation
  tests/tcg/xtensa: enable system tests
  tests/docker: add fedora-cris-cross compilers
  tests/tcg: split cris tests into bare and libc directories
  tests/tcg/cris: cleanup sys.c
  tests/tcg/cris: comment out the ccs test
  tests/tcg/cris: align mul operations
  tests/tcg: enable cris base user-mode tests
  .travis.yml: separate softfloat from check-tcg
  .travis.yml: add softmmu check-tcg tests

Philippe Mathieu-Daudé (1):
  tests/docker: add debian-xtensa-cross image

Stefan Hajnoczi (1):
  tests/tcg/arm: add ARMv6-M UNDEFINED 32-bit instruction test

 .travis.yml                                   |  12 ++
 Makefile.target                               |   2 -
 tests/Makefile.include                        |   9 +-
 tests/docker/Makefile.include                 |   1 +
 .../dockerfiles/debian-xtensa-cross.docker    |  31 ++++
 .../dockerfiles/fedora-cris-cross.docker      |   8 +
 tests/tcg/Makefile                            |  25 ++-
 tests/tcg/Makefile.include                    |   2 +-
 tests/tcg/arm/Makefile.softmmu-target         |  29 +++
 tests/tcg/arm/test-armv6m-undef.S             | 154 ++++++++++++++++
 tests/tcg/arm/test-armv6m-undef.ld            |  21 +++
 tests/tcg/cris/Makefile                       | 168 ------------------
 tests/tcg/cris/Makefile.include               |   6 +
 tests/tcg/cris/Makefile.target                |  58 ++++++
 tests/tcg/cris/{ => bare}/check_addcv17.s     |   0
 tests/tcg/cris/{ => bare}/check_addi.s        |   0
 tests/tcg/cris/{ => bare}/check_addiv32.s     |   0
 tests/tcg/cris/{ => bare}/check_addm.s        |   0
 tests/tcg/cris/{ => bare}/check_addq.s        |   0
 tests/tcg/cris/{ => bare}/check_addr.s        |   0
 tests/tcg/cris/{ => bare}/check_addxc.s       |   0
 tests/tcg/cris/{ => bare}/check_addxm.s       |   0
 tests/tcg/cris/{ => bare}/check_addxr.s       |   0
 tests/tcg/cris/{ => bare}/check_andc.s        |   0
 tests/tcg/cris/{ => bare}/check_andm.s        |   0
 tests/tcg/cris/{ => bare}/check_andq.s        |   0
 tests/tcg/cris/{ => bare}/check_andr.s        |   0
 tests/tcg/cris/{ => bare}/check_asr.s         |   0
 tests/tcg/cris/{ => bare}/check_ba.s          |   0
 tests/tcg/cris/{ => bare}/check_bas.s         |   0
 tests/tcg/cris/{ => bare}/check_bcc.s         |   0
 tests/tcg/cris/{ => bare}/check_boundc.s      |   0
 tests/tcg/cris/{ => bare}/check_boundr.s      |   0
 tests/tcg/cris/{ => bare}/check_btst.s        |  14 +-
 tests/tcg/cris/{ => bare}/check_clearfv32.s   |   0
 tests/tcg/cris/{ => bare}/check_clrjmp1.s     |   0
 tests/tcg/cris/{ => bare}/check_cmp-2.s       |   0
 tests/tcg/cris/{ => bare}/check_cmpc.s        |   0
 tests/tcg/cris/{ => bare}/check_cmpm.s        |   0
 tests/tcg/cris/{ => bare}/check_cmpq.s        |   0
 tests/tcg/cris/{ => bare}/check_cmpr.s        |   0
 tests/tcg/cris/{ => bare}/check_cmpxc.s       |   0
 tests/tcg/cris/{ => bare}/check_cmpxm.s       |   0
 tests/tcg/cris/{ => bare}/check_dstep.s       |   0
 tests/tcg/cris/{ => bare}/check_jsr.s         |   0
 tests/tcg/cris/{ => bare}/check_lapc.s        |   0
 tests/tcg/cris/{ => bare}/check_lsl.s         |   0
 tests/tcg/cris/{ => bare}/check_lsr.s         |   0
 tests/tcg/cris/{ => bare}/check_mcp.s         |   0
 tests/tcg/cris/{ => bare}/check_movdelsr1.s   |   0
 tests/tcg/cris/{ => bare}/check_movecr.s      |   0
 tests/tcg/cris/{ => bare}/check_movei.s       |   0
 tests/tcg/cris/{ => bare}/check_movemr.s      |   0
 tests/tcg/cris/{ => bare}/check_movemrv32.s   |   0
 tests/tcg/cris/{ => bare}/check_mover.s       |   0
 tests/tcg/cris/{ => bare}/check_moverm.s      |   0
 tests/tcg/cris/{ => bare}/check_movmp.s       |   0
 tests/tcg/cris/{ => bare}/check_movpmv32.s    |   0
 tests/tcg/cris/{ => bare}/check_movpr.s       |   0
 tests/tcg/cris/{ => bare}/check_movprv32.s    |   0
 tests/tcg/cris/{ => bare}/check_movscr.s      |   0
 tests/tcg/cris/{ => bare}/check_movsm.s       |   0
 tests/tcg/cris/{ => bare}/check_movsr.s       |   0
 tests/tcg/cris/{ => bare}/check_movucr.s      |   0
 tests/tcg/cris/{ => bare}/check_movum.s       |   0
 tests/tcg/cris/{ => bare}/check_movur.s       |   0
 tests/tcg/cris/{ => bare}/check_mulv32.s      |   0
 tests/tcg/cris/{ => bare}/check_mulx.s        |  11 ++
 tests/tcg/cris/{ => bare}/check_neg.s         |   0
 tests/tcg/cris/{ => bare}/check_not.s         |   0
 tests/tcg/cris/{ => bare}/check_orc.s         |   0
 tests/tcg/cris/{ => bare}/check_orm.s         |   0
 tests/tcg/cris/{ => bare}/check_orq.s         |   0
 tests/tcg/cris/{ => bare}/check_orr.s         |   0
 tests/tcg/cris/{ => bare}/check_ret.s         |   0
 tests/tcg/cris/{ => bare}/check_scc.s         |   0
 tests/tcg/cris/{ => bare}/check_subc.s        |   0
 tests/tcg/cris/{ => bare}/check_subm.s        |   0
 tests/tcg/cris/{ => bare}/check_subq.s        |   0
 tests/tcg/cris/{ => bare}/check_subr.s        |   0
 tests/tcg/cris/{ => bare}/check_xarith.s      |   0
 tests/tcg/cris/{ => bare}/crt.s               |   0
 tests/tcg/cris/bare/sys.c                     |  59 ++++++
 tests/tcg/cris/{ => bare}/testutils.inc       |   0
 tests/tcg/cris/{ => libc}/check_abs.c         |   0
 tests/tcg/cris/{ => libc}/check_addc.c        |   0
 tests/tcg/cris/{ => libc}/check_addcm.c       |   0
 tests/tcg/cris/{ => libc}/check_addo.c        |   0
 tests/tcg/cris/{ => libc}/check_addoq.c       |   0
 tests/tcg/cris/{ => libc}/check_bound.c       |   0
 tests/tcg/cris/{ => libc}/check_ftag.c        |   0
 .../{ => libc}/check_gcctorture_pr28634-1.c   |   0
 .../{ => libc}/check_gcctorture_pr28634.c     |   0
 .../{ => libc}/check_glibc_kernelversion.c    |   0
 tests/tcg/cris/{ => libc}/check_hello.c       |   0
 tests/tcg/cris/{ => libc}/check_int64.c       |   0
 tests/tcg/cris/{ => libc}/check_lz.c          |   0
 tests/tcg/cris/{ => libc}/check_mapbrk.c      |   0
 tests/tcg/cris/{ => libc}/check_mmap1.c       |   0
 tests/tcg/cris/{ => libc}/check_mmap2.c       |   0
 tests/tcg/cris/{ => libc}/check_mmap3.c       |   0
 tests/tcg/cris/{ => libc}/check_moveq.c       |   0
 tests/tcg/cris/{ => libc}/check_openpf1.c     |   0
 tests/tcg/cris/{ => libc}/check_openpf2.c     |   0
 tests/tcg/cris/{ => libc}/check_openpf3.c     |   0
 tests/tcg/cris/{ => libc}/check_openpf5.c     |   0
 tests/tcg/cris/{ => libc}/check_settls1.c     |   0
 tests/tcg/cris/{ => libc}/check_sigalrm.c     |   0
 tests/tcg/cris/{ => libc}/check_stat1.c       |   0
 tests/tcg/cris/{ => libc}/check_stat2.c       |   0
 tests/tcg/cris/{ => libc}/check_stat3.c       |   0
 tests/tcg/cris/{ => libc}/check_stat4.c       |   0
 tests/tcg/cris/{ => libc}/check_swap.c        |   0
 tests/tcg/cris/{ => libc}/check_time2.c       |   0
 tests/tcg/cris/{ => libc}/crisutils.h         |   0
 tests/tcg/cris/{ => libc}/sys.c               |  74 ++++----
 tests/tcg/cris/{ => libc}/sys.h               |   0
 tests/tcg/mips/Makefile.target                |  11 +-
 tests/tcg/mips/hello-mips.c                   |   2 +-
 tests/tcg/xtensa/Makefile                     |  93 ----------
 tests/tcg/xtensa/Makefile.include             |  11 ++
 tests/tcg/xtensa/Makefile.softmmu-target      |  40 +++++
 122 files changed, 520 insertions(+), 321 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-xtensa-cross.docker
 create mode 100644 tests/docker/dockerfiles/fedora-cris-cross.docker
 create mode 100644 tests/tcg/arm/Makefile.softmmu-target
 create mode 100644 tests/tcg/arm/test-armv6m-undef.S
 create mode 100644 tests/tcg/arm/test-armv6m-undef.ld
 delete mode 100644 tests/tcg/cris/Makefile
 create mode 100644 tests/tcg/cris/Makefile.include
 create mode 100644 tests/tcg/cris/Makefile.target
 rename tests/tcg/cris/{ => bare}/check_addcv17.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addi.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addiv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addq.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addxc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addxm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addxr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_andc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_andm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_andq.s (100%)
 rename tests/tcg/cris/{ => bare}/check_andr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_asr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_ba.s (100%)
 rename tests/tcg/cris/{ => bare}/check_bas.s (100%)
 rename tests/tcg/cris/{ => bare}/check_bcc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_boundc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_boundr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_btst.s (89%)
 rename tests/tcg/cris/{ => bare}/check_clearfv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_clrjmp1.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmp-2.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpq.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpxc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpxm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_dstep.s (100%)
 rename tests/tcg/cris/{ => bare}/check_jsr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_lapc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_lsl.s (100%)
 rename tests/tcg/cris/{ => bare}/check_lsr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_mcp.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movdelsr1.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movecr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movei.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movemr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movemrv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_mover.s (100%)
 rename tests/tcg/cris/{ => bare}/check_moverm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movmp.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movpmv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movpr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movprv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movscr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movsm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movsr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movucr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movum.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movur.s (100%)
 rename tests/tcg/cris/{ => bare}/check_mulv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_mulx.s (98%)
 rename tests/tcg/cris/{ => bare}/check_neg.s (100%)
 rename tests/tcg/cris/{ => bare}/check_not.s (100%)
 rename tests/tcg/cris/{ => bare}/check_orc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_orm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_orq.s (100%)
 rename tests/tcg/cris/{ => bare}/check_orr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_ret.s (100%)
 rename tests/tcg/cris/{ => bare}/check_scc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_subc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_subm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_subq.s (100%)
 rename tests/tcg/cris/{ => bare}/check_subr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_xarith.s (100%)
 rename tests/tcg/cris/{ => bare}/crt.s (100%)
 create mode 100644 tests/tcg/cris/bare/sys.c
 rename tests/tcg/cris/{ => bare}/testutils.inc (100%)
 rename tests/tcg/cris/{ => libc}/check_abs.c (100%)
 rename tests/tcg/cris/{ => libc}/check_addc.c (100%)
 rename tests/tcg/cris/{ => libc}/check_addcm.c (100%)
 rename tests/tcg/cris/{ => libc}/check_addo.c (100%)
 rename tests/tcg/cris/{ => libc}/check_addoq.c (100%)
 rename tests/tcg/cris/{ => libc}/check_bound.c (100%)
 rename tests/tcg/cris/{ => libc}/check_ftag.c (100%)
 rename tests/tcg/cris/{ => libc}/check_gcctorture_pr28634-1.c (100%)
 rename tests/tcg/cris/{ => libc}/check_gcctorture_pr28634.c (100%)
 rename tests/tcg/cris/{ => libc}/check_glibc_kernelversion.c (100%)
 rename tests/tcg/cris/{ => libc}/check_hello.c (100%)
 rename tests/tcg/cris/{ => libc}/check_int64.c (100%)
 rename tests/tcg/cris/{ => libc}/check_lz.c (100%)
 rename tests/tcg/cris/{ => libc}/check_mapbrk.c (100%)
 rename tests/tcg/cris/{ => libc}/check_mmap1.c (100%)
 rename tests/tcg/cris/{ => libc}/check_mmap2.c (100%)
 rename tests/tcg/cris/{ => libc}/check_mmap3.c (100%)
 rename tests/tcg/cris/{ => libc}/check_moveq.c (100%)
 rename tests/tcg/cris/{ => libc}/check_openpf1.c (100%)
 rename tests/tcg/cris/{ => libc}/check_openpf2.c (100%)
 rename tests/tcg/cris/{ => libc}/check_openpf3.c (100%)
 rename tests/tcg/cris/{ => libc}/check_openpf5.c (100%)
 rename tests/tcg/cris/{ => libc}/check_settls1.c (100%)
 rename tests/tcg/cris/{ => libc}/check_sigalrm.c (100%)
 rename tests/tcg/cris/{ => libc}/check_stat1.c (100%)
 rename tests/tcg/cris/{ => libc}/check_stat2.c (100%)
 rename tests/tcg/cris/{ => libc}/check_stat3.c (100%)
 rename tests/tcg/cris/{ => libc}/check_stat4.c (100%)
 rename tests/tcg/cris/{ => libc}/check_swap.c (100%)
 rename tests/tcg/cris/{ => libc}/check_time2.c (100%)
 rename tests/tcg/cris/{ => libc}/crisutils.h (100%)
 rename tests/tcg/cris/{ => libc}/sys.c (69%)
 rename tests/tcg/cris/{ => libc}/sys.h (100%)
 delete mode 100644 tests/tcg/xtensa/Makefile
 create mode 100644 tests/tcg/xtensa/Makefile.include
 create mode 100644 tests/tcg/xtensa/Makefile.softmmu-target

-- 
2.20.1
