Received: from eggs.gnu.org ([2001:4830:134:3::10]:43245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU3-00085A-RE
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU1-0000Tt-8r
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:35 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU0-0000TH-U7
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:33 -0500
Received: by mail-wm1-x341.google.com with SMTP id q26so11636786wmf.5
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:32 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:16 +0000
Message-Id: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH  00/13] Enabling tcg/tests for xtensa,
 mips and cris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is very much a work in progress but I'm posting it in the hope of
getting some feedback from the architecture maintainers.

When I originally enabled tcg tests I only enabled linux-user tests for
architectures that had easily available compilers. I also skipped over a
bunch of the tests that were already in the tree but didn't build.

Enabling the building of system tests is actually fairly simple. The
patch introduces the concept of Makefile.softmmu-target so we can keep
the build rules nicely separated from that of linux-user targets.

I've enabled system builds for xtensa, cris and mips64. However they all
have some niggles that need sorting out.

Xtensa

The tests all build and run manually but for some reason running under
make break. I think this is something to do with the monitor being
involved in the semihosting output.

MIPS

The existing mips tests are split between 32 bit which are linux-user
tests. I've enabled a chunk of these but adding the mips32r2 aran into
problems with make which I haven't yet figured out despite having
targets in different build directories. The mipsr5900 build is limited
by the fact that upstream GCC doesn't seem to support the build type.

The 64 bit mips tests are system tests and are built for the
mips64el-softmmu target. Getting them to build has been more problematic
possibly because there is a bunch of target flags I don't understand.
For example why does FLAGS define have -march=mips64r2 for the mip64-dsp
target?

I could do with some guidance from the MIPS guys here about the right
toolchain and build options.

CRIS

Again I've gotten these building. I had to skip a bunch of tests because
it seems the upstream cris compiler:

cris-linux-gnu-gcc (GCC) 7.2.1 20170915 (Red Hat Cross 7.2.1-1)

Can't build all the cris tests because it doesn't support all the
versions of the architecture. Secondly I'm not sure how these tests are
meant to be invoked within QEMU. They originally come from the binutils
simulator (SIM) and are split into ctst (linux-user) and tst (simulator)
tests. As we can only build system tests with the cris cross compiler
I've stuck to those but I'm unsure how they are meant to be invoked.

I actually started down this road to add Stefan's microbit tests to the
build. You can see this commit:

[https://github.com/stsquad/qemu/commit/727e106204e867cc42dc8fa44f84b013c7f7fcb7]

For how easy it was to add. As this is an RFC I've included all the
aspirational work in progress for our more esoteric architectures so
maintainers can have a play. The next iteration of the series will only
include working patches ;-)

Alex Bennée (12):
  tests/tcg: add softmmu awareness to Makefile
  tests: enable tcg tests for softmmu
  tests/tcg: add QEMU_OPT option for test runner
  tests/tcg/mips: enable mips32-dsp/mips32-dspr2/mipsr5900 linux-user
    (WIP)
  tests/tcg/mips: enable mips64 system tests (WIP)
  tests/tcg/xtensa: enable system tests
  tests/docker: add fedora-cris-cross compilers
  tests/tcg: split cris tests into system and user mode
  tests/tcg/cris: cleanup sys.c
  tests/tcg/cris: comment out the ccs test
  tests/tcg/cris: align mul operations
  tests/tcg: enable cris system tests

Philippe Mathieu-Daudé (1):
  tests/docker: add debian-xtensa-cross image

 Makefile.target                               |   2 -
 tests/Makefile.include                        |   7 +-
 tests/docker/Makefile.include                 |   1 +
 .../dockerfiles/debian-xtensa-cross.docker    |  31 ++
 .../dockerfiles/fedora-cris-cross.docker      |   8 +
 tests/tcg/Makefile                            |  21 +-
 tests/tcg/Makefile.include                    |   2 +-
 tests/tcg/cris/Makefile                       | 168 ---------
 tests/tcg/cris/Makefile.include               |   6 +
 tests/tcg/cris/Makefile.softmmu-target        |  50 +++
 tests/tcg/cris/sys.c                          |  59 ---
 tests/tcg/cris/{ => system}/check_addcv17.s   |   0
 tests/tcg/cris/{ => system}/check_addi.s      |   0
 tests/tcg/cris/{ => system}/check_addiv32.s   |   0
 tests/tcg/cris/{ => system}/check_addm.s      |   0
 tests/tcg/cris/{ => system}/check_addq.s      |   0
 tests/tcg/cris/{ => system}/check_addr.s      |   0
 tests/tcg/cris/{ => system}/check_addxc.s     |   0
 tests/tcg/cris/{ => system}/check_addxm.s     |   0
 tests/tcg/cris/{ => system}/check_addxr.s     |   0
 tests/tcg/cris/{ => system}/check_andc.s      |   0
 tests/tcg/cris/{ => system}/check_andm.s      |   0
 tests/tcg/cris/{ => system}/check_andq.s      |   0
 tests/tcg/cris/{ => system}/check_andr.s      |   0
 tests/tcg/cris/{ => system}/check_asr.s       |   0
 tests/tcg/cris/{ => system}/check_ba.s        |   0
 tests/tcg/cris/{ => system}/check_bas.s       |   0
 tests/tcg/cris/{ => system}/check_bcc.s       |   0
 tests/tcg/cris/{ => system}/check_boundc.s    |   0
 tests/tcg/cris/{ => system}/check_boundr.s    |   0
 tests/tcg/cris/{ => system}/check_btst.s      |  14 +-
 tests/tcg/cris/{ => system}/check_clearfv32.s |   0
 tests/tcg/cris/{ => system}/check_clrjmp1.s   |   0
 tests/tcg/cris/{ => system}/check_cmp-2.s     |   0
 tests/tcg/cris/{ => system}/check_cmpc.s      |   0
 tests/tcg/cris/{ => system}/check_cmpm.s      |   0
 tests/tcg/cris/{ => system}/check_cmpq.s      |   0
 tests/tcg/cris/{ => system}/check_cmpr.s      |   0
 tests/tcg/cris/{ => system}/check_cmpxc.s     |   0
 tests/tcg/cris/{ => system}/check_cmpxm.s     |   0
 tests/tcg/cris/{ => system}/check_dstep.s     |   0
 tests/tcg/cris/{ => system}/check_jsr.s       |   0
 tests/tcg/cris/{ => system}/check_lapc.s      |   0
 tests/tcg/cris/{ => system}/check_lsl.s       |   0
 tests/tcg/cris/{ => system}/check_lsr.s       |   0
 tests/tcg/cris/{ => system}/check_mcp.s       |   0
 tests/tcg/cris/{ => system}/check_movdelsr1.s |   0
 tests/tcg/cris/{ => system}/check_movecr.s    |   0
 tests/tcg/cris/{ => system}/check_movei.s     |   0
 tests/tcg/cris/{ => system}/check_movemr.s    |   0
 tests/tcg/cris/{ => system}/check_movemrv32.s |   0
 tests/tcg/cris/{ => system}/check_mover.s     |   0
 tests/tcg/cris/{ => system}/check_moverm.s    |   0
 tests/tcg/cris/{ => system}/check_movmp.s     |   0
 tests/tcg/cris/{ => system}/check_movpmv32.s  |   0
 tests/tcg/cris/{ => system}/check_movpr.s     |   0
 tests/tcg/cris/{ => system}/check_movprv32.s  |   0
 tests/tcg/cris/{ => system}/check_movscr.s    |   0
 tests/tcg/cris/{ => system}/check_movsm.s     |   0
 tests/tcg/cris/{ => system}/check_movsr.s     |   0
 tests/tcg/cris/{ => system}/check_movucr.s    |   0
 tests/tcg/cris/{ => system}/check_movum.s     |   0
 tests/tcg/cris/{ => system}/check_movur.s     |   0
 tests/tcg/cris/{ => system}/check_mulv32.s    |   0
 tests/tcg/cris/{ => system}/check_mulx.s      |  11 +
 tests/tcg/cris/{ => system}/check_neg.s       |   0
 tests/tcg/cris/{ => system}/check_not.s       |   0
 tests/tcg/cris/{ => system}/check_orc.s       |   0
 tests/tcg/cris/{ => system}/check_orm.s       |   0
 tests/tcg/cris/{ => system}/check_orq.s       |   0
 tests/tcg/cris/{ => system}/check_orr.s       |   0
 tests/tcg/cris/{ => system}/check_ret.s       |   0
 tests/tcg/cris/{ => system}/check_scc.s       |   0
 tests/tcg/cris/{ => system}/check_subc.s      |   0
 tests/tcg/cris/{ => system}/check_subm.s      |   0
 tests/tcg/cris/{ => system}/check_subq.s      |   0
 tests/tcg/cris/{ => system}/check_subr.s      |   0
 tests/tcg/cris/{ => system}/check_xarith.s    |   0
 tests/tcg/cris/{ => system}/crt.s             |   0
 tests/tcg/cris/system/sys.c                   |  59 +++
 tests/tcg/cris/{ => system}/testutils.inc     |   0
 tests/tcg/cris/{ => user}/check_abs.c         |   0
 tests/tcg/cris/{ => user}/check_addc.c        |   0
 tests/tcg/cris/{ => user}/check_addcm.c       |   0
 tests/tcg/cris/{ => user}/check_addo.c        |   0
 tests/tcg/cris/{ => user}/check_addoq.c       |   0
 tests/tcg/cris/{ => user}/check_bound.c       |   0
 tests/tcg/cris/{ => user}/check_ftag.c        |   0
 .../{ => user}/check_glibc_kernelversion.c    |   0
 tests/tcg/cris/{ => user}/check_hello.c       |   0
 tests/tcg/cris/{ => user}/check_int64.c       |   0
 tests/tcg/cris/{ => user}/check_lz.c          |   0
 tests/tcg/cris/{ => user}/check_mapbrk.c      |   0
 tests/tcg/cris/{ => user}/check_mmap1.c       |   0
 tests/tcg/cris/{ => user}/check_mmap2.c       |   0
 tests/tcg/cris/{ => user}/check_mmap3.c       |   0
 tests/tcg/cris/{ => user}/check_moveq.c       |   0
 tests/tcg/cris/{ => user}/check_openpf1.c     |   0
 tests/tcg/cris/{ => user}/check_openpf2.c     |   0
 tests/tcg/cris/{ => user}/check_openpf3.c     |   0
 tests/tcg/cris/{ => user}/check_openpf5.c     |   0
 tests/tcg/cris/{ => user}/check_settls1.c     |   0
 tests/tcg/cris/{ => user}/check_sigalrm.c     |   0
 tests/tcg/cris/{ => user}/check_stat1.c       |   0
 tests/tcg/cris/{ => user}/check_stat2.c       |   0
 tests/tcg/cris/{ => user}/check_stat3.c       |   0
 tests/tcg/cris/{ => user}/check_stat4.c       |   0
 tests/tcg/cris/{ => user}/check_swap.c        |   0
 tests/tcg/cris/{ => user}/check_time2.c       |   0
 tests/tcg/cris/{ => user}/crisutils.h         |   0
 tests/tcg/cris/{ => user}/sys.h               |   0
 tests/tcg/mips/Makefile.softmmu-target        |  20 ++
 tests/tcg/mips/Makefile.target                |  15 +-
 tests/tcg/mips/mips32-dsp/Makefile            | 166 ++-------
 tests/tcg/mips/mips32-dspr2/Makefile          |  83 +----
 tests/tcg/mips/mips64-dsp/Makefile            | 336 +++---------------
 tests/tcg/mips/mipsr5900/Makefile             |  40 +--
 tests/tcg/xtensa/Makefile                     |  93 -----
 tests/tcg/xtensa/Makefile.include             |   7 +
 tests/tcg/xtensa/Makefile.softmmu-target      |  43 +++
 120 files changed, 385 insertions(+), 857 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-xtensa-cross.docker
 create mode 100644 tests/docker/dockerfiles/fedora-cris-cross.docker
 delete mode 100644 tests/tcg/cris/Makefile
 create mode 100644 tests/tcg/cris/Makefile.include
 create mode 100644 tests/tcg/cris/Makefile.softmmu-target
 delete mode 100644 tests/tcg/cris/sys.c
 rename tests/tcg/cris/{ => system}/check_addcv17.s (100%)
 rename tests/tcg/cris/{ => system}/check_addi.s (100%)
 rename tests/tcg/cris/{ => system}/check_addiv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_addm.s (100%)
 rename tests/tcg/cris/{ => system}/check_addq.s (100%)
 rename tests/tcg/cris/{ => system}/check_addr.s (100%)
 rename tests/tcg/cris/{ => system}/check_addxc.s (100%)
 rename tests/tcg/cris/{ => system}/check_addxm.s (100%)
 rename tests/tcg/cris/{ => system}/check_addxr.s (100%)
 rename tests/tcg/cris/{ => system}/check_andc.s (100%)
 rename tests/tcg/cris/{ => system}/check_andm.s (100%)
 rename tests/tcg/cris/{ => system}/check_andq.s (100%)
 rename tests/tcg/cris/{ => system}/check_andr.s (100%)
 rename tests/tcg/cris/{ => system}/check_asr.s (100%)
 rename tests/tcg/cris/{ => system}/check_ba.s (100%)
 rename tests/tcg/cris/{ => system}/check_bas.s (100%)
 rename tests/tcg/cris/{ => system}/check_bcc.s (100%)
 rename tests/tcg/cris/{ => system}/check_boundc.s (100%)
 rename tests/tcg/cris/{ => system}/check_boundr.s (100%)
 rename tests/tcg/cris/{ => system}/check_btst.s (89%)
 rename tests/tcg/cris/{ => system}/check_clearfv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_clrjmp1.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmp-2.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpc.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpm.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpq.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpr.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpxc.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpxm.s (100%)
 rename tests/tcg/cris/{ => system}/check_dstep.s (100%)
 rename tests/tcg/cris/{ => system}/check_jsr.s (100%)
 rename tests/tcg/cris/{ => system}/check_lapc.s (100%)
 rename tests/tcg/cris/{ => system}/check_lsl.s (100%)
 rename tests/tcg/cris/{ => system}/check_lsr.s (100%)
 rename tests/tcg/cris/{ => system}/check_mcp.s (100%)
 rename tests/tcg/cris/{ => system}/check_movdelsr1.s (100%)
 rename tests/tcg/cris/{ => system}/check_movecr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movei.s (100%)
 rename tests/tcg/cris/{ => system}/check_movemr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movemrv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_mover.s (100%)
 rename tests/tcg/cris/{ => system}/check_moverm.s (100%)
 rename tests/tcg/cris/{ => system}/check_movmp.s (100%)
 rename tests/tcg/cris/{ => system}/check_movpmv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_movpr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movprv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_movscr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movsm.s (100%)
 rename tests/tcg/cris/{ => system}/check_movsr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movucr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movum.s (100%)
 rename tests/tcg/cris/{ => system}/check_movur.s (100%)
 rename tests/tcg/cris/{ => system}/check_mulv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_mulx.s (98%)
 rename tests/tcg/cris/{ => system}/check_neg.s (100%)
 rename tests/tcg/cris/{ => system}/check_not.s (100%)
 rename tests/tcg/cris/{ => system}/check_orc.s (100%)
 rename tests/tcg/cris/{ => system}/check_orm.s (100%)
 rename tests/tcg/cris/{ => system}/check_orq.s (100%)
 rename tests/tcg/cris/{ => system}/check_orr.s (100%)
 rename tests/tcg/cris/{ => system}/check_ret.s (100%)
 rename tests/tcg/cris/{ => system}/check_scc.s (100%)
 rename tests/tcg/cris/{ => system}/check_subc.s (100%)
 rename tests/tcg/cris/{ => system}/check_subm.s (100%)
 rename tests/tcg/cris/{ => system}/check_subq.s (100%)
 rename tests/tcg/cris/{ => system}/check_subr.s (100%)
 rename tests/tcg/cris/{ => system}/check_xarith.s (100%)
 rename tests/tcg/cris/{ => system}/crt.s (100%)
 create mode 100644 tests/tcg/cris/system/sys.c
 rename tests/tcg/cris/{ => system}/testutils.inc (100%)
 rename tests/tcg/cris/{ => user}/check_abs.c (100%)
 rename tests/tcg/cris/{ => user}/check_addc.c (100%)
 rename tests/tcg/cris/{ => user}/check_addcm.c (100%)
 rename tests/tcg/cris/{ => user}/check_addo.c (100%)
 rename tests/tcg/cris/{ => user}/check_addoq.c (100%)
 rename tests/tcg/cris/{ => user}/check_bound.c (100%)
 rename tests/tcg/cris/{ => user}/check_ftag.c (100%)
 rename tests/tcg/cris/{ => user}/check_glibc_kernelversion.c (100%)
 rename tests/tcg/cris/{ => user}/check_hello.c (100%)
 rename tests/tcg/cris/{ => user}/check_int64.c (100%)
 rename tests/tcg/cris/{ => user}/check_lz.c (100%)
 rename tests/tcg/cris/{ => user}/check_mapbrk.c (100%)
 rename tests/tcg/cris/{ => user}/check_mmap1.c (100%)
 rename tests/tcg/cris/{ => user}/check_mmap2.c (100%)
 rename tests/tcg/cris/{ => user}/check_mmap3.c (100%)
 rename tests/tcg/cris/{ => user}/check_moveq.c (100%)
 rename tests/tcg/cris/{ => user}/check_openpf1.c (100%)
 rename tests/tcg/cris/{ => user}/check_openpf2.c (100%)
 rename tests/tcg/cris/{ => user}/check_openpf3.c (100%)
 rename tests/tcg/cris/{ => user}/check_openpf5.c (100%)
 rename tests/tcg/cris/{ => user}/check_settls1.c (100%)
 rename tests/tcg/cris/{ => user}/check_sigalrm.c (100%)
 rename tests/tcg/cris/{ => user}/check_stat1.c (100%)
 rename tests/tcg/cris/{ => user}/check_stat2.c (100%)
 rename tests/tcg/cris/{ => user}/check_stat3.c (100%)
 rename tests/tcg/cris/{ => user}/check_stat4.c (100%)
 rename tests/tcg/cris/{ => user}/check_swap.c (100%)
 rename tests/tcg/cris/{ => user}/check_time2.c (100%)
 rename tests/tcg/cris/{ => user}/crisutils.h (100%)
 rename tests/tcg/cris/{ => user}/sys.h (100%)
 create mode 100644 tests/tcg/mips/Makefile.softmmu-target
 delete mode 100644 tests/tcg/xtensa/Makefile
 create mode 100644 tests/tcg/xtensa/Makefile.include
 create mode 100644 tests/tcg/xtensa/Makefile.softmmu-target

-- 
2.17.1
