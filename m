Received: from eggs.gnu.org ([208.118.235.92]:35064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfQ4b-0001pT-46
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfQ4W-00027q-1k
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:03:39 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:43889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1gfQ4S-0001tP-9Y
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:03:34 -0500
Received: by mail-lf1-x144.google.com with SMTP id u18so25477154lff.10
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 06:03:22 -0800 (PST)
Date: Fri, 4 Jan 2019 15:03:19 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20190104140319.GT1148@toto>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH  00/13] Enabling tcg/tests for xtensa,
 mips and cris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com

On Mon, Dec 10, 2018 at 03:28:16PM +0000, Alex Bennée wrote:
> Hi,
> 
> This is very much a work in progress but I'm posting it in the hope of
> getting some feedback from the architecture maintainers.
> 
> When I originally enabled tcg tests I only enabled linux-user tests for
> architectures that had easily available compilers. I also skipped over a
> bunch of the tests that were already in the tree but didn't build.
> 
> Enabling the building of system tests is actually fairly simple. The
> patch introduces the concept of Makefile.softmmu-target so we can keep
> the build rules nicely separated from that of linux-user targets.
> 
> I've enabled system builds for xtensa, cris and mips64. However they all
> have some niggles that need sorting out.
> 
> Xtensa
> 
> The tests all build and run manually but for some reason running under
> make break. I think this is something to do with the monitor being
> involved in the semihosting output.
> 
> MIPS
> 
> The existing mips tests are split between 32 bit which are linux-user
> tests. I've enabled a chunk of these but adding the mips32r2 aran into
> problems with make which I haven't yet figured out despite having
> targets in different build directories. The mipsr5900 build is limited
> by the fact that upstream GCC doesn't seem to support the build type.
> 
> The 64 bit mips tests are system tests and are built for the
> mips64el-softmmu target. Getting them to build has been more problematic
> possibly because there is a bunch of target flags I don't understand.
> For example why does FLAGS define have -march=mips64r2 for the mip64-dsp
> target?
> 
> I could do with some guidance from the MIPS guys here about the right
> toolchain and build options.
> 
> CRIS
> 
> Again I've gotten these building. I had to skip a bunch of tests because
> it seems the upstream cris compiler:
> 
> cris-linux-gnu-gcc (GCC) 7.2.1 20170915 (Red Hat Cross 7.2.1-1)
> 
> Can't build all the cris tests because it doesn't support all the
> versions of the architecture. Secondly I'm not sure how these tests are
> meant to be invoked within QEMU. They originally come from the binutils
> simulator (SIM) and are split into ctst (linux-user) and tst (simulator)

BTW, IIRC, ctst and tst mainly differ in that ctst test cases need to be
linked against a libc while tst cases don't. They should both run on
linux-user IIRC.

The point is that doing small test-cases for certain instruction patterns
but having to run through glibc initialization before makes things hard
to debug. Small test-cases without libc are easier to trace and debug.

It's been a while since I looked at this though, so I may remember wrongly...

Cheers,
Edgar



> tests. As we can only build system tests with the cris cross compiler
> I've stuck to those but I'm unsure how they are meant to be invoked.
> 
> I actually started down this road to add Stefan's microbit tests to the
> build. You can see this commit:
> 
> [https://github.com/stsquad/qemu/commit/727e106204e867cc42dc8fa44f84b013c7f7fcb7]
> 
> For how easy it was to add. As this is an RFC I've included all the
> aspirational work in progress for our more esoteric architectures so
> maintainers can have a play. The next iteration of the series will only
> include working patches ;-)
> 
> Alex Bennée (12):
>   tests/tcg: add softmmu awareness to Makefile
>   tests: enable tcg tests for softmmu
>   tests/tcg: add QEMU_OPT option for test runner
>   tests/tcg/mips: enable mips32-dsp/mips32-dspr2/mipsr5900 linux-user
>     (WIP)
>   tests/tcg/mips: enable mips64 system tests (WIP)
>   tests/tcg/xtensa: enable system tests
>   tests/docker: add fedora-cris-cross compilers
>   tests/tcg: split cris tests into system and user mode
>   tests/tcg/cris: cleanup sys.c
>   tests/tcg/cris: comment out the ccs test
>   tests/tcg/cris: align mul operations
>   tests/tcg: enable cris system tests
> 
> Philippe Mathieu-Daudé (1):
>   tests/docker: add debian-xtensa-cross image
> 
>  Makefile.target                               |   2 -
>  tests/Makefile.include                        |   7 +-
>  tests/docker/Makefile.include                 |   1 +
>  .../dockerfiles/debian-xtensa-cross.docker    |  31 ++
>  .../dockerfiles/fedora-cris-cross.docker      |   8 +
>  tests/tcg/Makefile                            |  21 +-
>  tests/tcg/Makefile.include                    |   2 +-
>  tests/tcg/cris/Makefile                       | 168 ---------
>  tests/tcg/cris/Makefile.include               |   6 +
>  tests/tcg/cris/Makefile.softmmu-target        |  50 +++
>  tests/tcg/cris/sys.c                          |  59 ---
>  tests/tcg/cris/{ => system}/check_addcv17.s   |   0
>  tests/tcg/cris/{ => system}/check_addi.s      |   0
>  tests/tcg/cris/{ => system}/check_addiv32.s   |   0
>  tests/tcg/cris/{ => system}/check_addm.s      |   0
>  tests/tcg/cris/{ => system}/check_addq.s      |   0
>  tests/tcg/cris/{ => system}/check_addr.s      |   0
>  tests/tcg/cris/{ => system}/check_addxc.s     |   0
>  tests/tcg/cris/{ => system}/check_addxm.s     |   0
>  tests/tcg/cris/{ => system}/check_addxr.s     |   0
>  tests/tcg/cris/{ => system}/check_andc.s      |   0
>  tests/tcg/cris/{ => system}/check_andm.s      |   0
>  tests/tcg/cris/{ => system}/check_andq.s      |   0
>  tests/tcg/cris/{ => system}/check_andr.s      |   0
>  tests/tcg/cris/{ => system}/check_asr.s       |   0
>  tests/tcg/cris/{ => system}/check_ba.s        |   0
>  tests/tcg/cris/{ => system}/check_bas.s       |   0
>  tests/tcg/cris/{ => system}/check_bcc.s       |   0
>  tests/tcg/cris/{ => system}/check_boundc.s    |   0
>  tests/tcg/cris/{ => system}/check_boundr.s    |   0
>  tests/tcg/cris/{ => system}/check_btst.s      |  14 +-
>  tests/tcg/cris/{ => system}/check_clearfv32.s |   0
>  tests/tcg/cris/{ => system}/check_clrjmp1.s   |   0
>  tests/tcg/cris/{ => system}/check_cmp-2.s     |   0
>  tests/tcg/cris/{ => system}/check_cmpc.s      |   0
>  tests/tcg/cris/{ => system}/check_cmpm.s      |   0
>  tests/tcg/cris/{ => system}/check_cmpq.s      |   0
>  tests/tcg/cris/{ => system}/check_cmpr.s      |   0
>  tests/tcg/cris/{ => system}/check_cmpxc.s     |   0
>  tests/tcg/cris/{ => system}/check_cmpxm.s     |   0
>  tests/tcg/cris/{ => system}/check_dstep.s     |   0
>  tests/tcg/cris/{ => system}/check_jsr.s       |   0
>  tests/tcg/cris/{ => system}/check_lapc.s      |   0
>  tests/tcg/cris/{ => system}/check_lsl.s       |   0
>  tests/tcg/cris/{ => system}/check_lsr.s       |   0
>  tests/tcg/cris/{ => system}/check_mcp.s       |   0
>  tests/tcg/cris/{ => system}/check_movdelsr1.s |   0
>  tests/tcg/cris/{ => system}/check_movecr.s    |   0
>  tests/tcg/cris/{ => system}/check_movei.s     |   0
>  tests/tcg/cris/{ => system}/check_movemr.s    |   0
>  tests/tcg/cris/{ => system}/check_movemrv32.s |   0
>  tests/tcg/cris/{ => system}/check_mover.s     |   0
>  tests/tcg/cris/{ => system}/check_moverm.s    |   0
>  tests/tcg/cris/{ => system}/check_movmp.s     |   0
>  tests/tcg/cris/{ => system}/check_movpmv32.s  |   0
>  tests/tcg/cris/{ => system}/check_movpr.s     |   0
>  tests/tcg/cris/{ => system}/check_movprv32.s  |   0
>  tests/tcg/cris/{ => system}/check_movscr.s    |   0
>  tests/tcg/cris/{ => system}/check_movsm.s     |   0
>  tests/tcg/cris/{ => system}/check_movsr.s     |   0
>  tests/tcg/cris/{ => system}/check_movucr.s    |   0
>  tests/tcg/cris/{ => system}/check_movum.s     |   0
>  tests/tcg/cris/{ => system}/check_movur.s     |   0
>  tests/tcg/cris/{ => system}/check_mulv32.s    |   0
>  tests/tcg/cris/{ => system}/check_mulx.s      |  11 +
>  tests/tcg/cris/{ => system}/check_neg.s       |   0
>  tests/tcg/cris/{ => system}/check_not.s       |   0
>  tests/tcg/cris/{ => system}/check_orc.s       |   0
>  tests/tcg/cris/{ => system}/check_orm.s       |   0
>  tests/tcg/cris/{ => system}/check_orq.s       |   0
>  tests/tcg/cris/{ => system}/check_orr.s       |   0
>  tests/tcg/cris/{ => system}/check_ret.s       |   0
>  tests/tcg/cris/{ => system}/check_scc.s       |   0
>  tests/tcg/cris/{ => system}/check_subc.s      |   0
>  tests/tcg/cris/{ => system}/check_subm.s      |   0
>  tests/tcg/cris/{ => system}/check_subq.s      |   0
>  tests/tcg/cris/{ => system}/check_subr.s      |   0
>  tests/tcg/cris/{ => system}/check_xarith.s    |   0
>  tests/tcg/cris/{ => system}/crt.s             |   0
>  tests/tcg/cris/system/sys.c                   |  59 +++
>  tests/tcg/cris/{ => system}/testutils.inc     |   0
>  tests/tcg/cris/{ => user}/check_abs.c         |   0
>  tests/tcg/cris/{ => user}/check_addc.c        |   0
>  tests/tcg/cris/{ => user}/check_addcm.c       |   0
>  tests/tcg/cris/{ => user}/check_addo.c        |   0
>  tests/tcg/cris/{ => user}/check_addoq.c       |   0
>  tests/tcg/cris/{ => user}/check_bound.c       |   0
>  tests/tcg/cris/{ => user}/check_ftag.c        |   0
>  .../{ => user}/check_glibc_kernelversion.c    |   0
>  tests/tcg/cris/{ => user}/check_hello.c       |   0
>  tests/tcg/cris/{ => user}/check_int64.c       |   0
>  tests/tcg/cris/{ => user}/check_lz.c          |   0
>  tests/tcg/cris/{ => user}/check_mapbrk.c      |   0
>  tests/tcg/cris/{ => user}/check_mmap1.c       |   0
>  tests/tcg/cris/{ => user}/check_mmap2.c       |   0
>  tests/tcg/cris/{ => user}/check_mmap3.c       |   0
>  tests/tcg/cris/{ => user}/check_moveq.c       |   0
>  tests/tcg/cris/{ => user}/check_openpf1.c     |   0
>  tests/tcg/cris/{ => user}/check_openpf2.c     |   0
>  tests/tcg/cris/{ => user}/check_openpf3.c     |   0
>  tests/tcg/cris/{ => user}/check_openpf5.c     |   0
>  tests/tcg/cris/{ => user}/check_settls1.c     |   0
>  tests/tcg/cris/{ => user}/check_sigalrm.c     |   0
>  tests/tcg/cris/{ => user}/check_stat1.c       |   0
>  tests/tcg/cris/{ => user}/check_stat2.c       |   0
>  tests/tcg/cris/{ => user}/check_stat3.c       |   0
>  tests/tcg/cris/{ => user}/check_stat4.c       |   0
>  tests/tcg/cris/{ => user}/check_swap.c        |   0
>  tests/tcg/cris/{ => user}/check_time2.c       |   0
>  tests/tcg/cris/{ => user}/crisutils.h         |   0
>  tests/tcg/cris/{ => user}/sys.h               |   0
>  tests/tcg/mips/Makefile.softmmu-target        |  20 ++
>  tests/tcg/mips/Makefile.target                |  15 +-
>  tests/tcg/mips/mips32-dsp/Makefile            | 166 ++-------
>  tests/tcg/mips/mips32-dspr2/Makefile          |  83 +----
>  tests/tcg/mips/mips64-dsp/Makefile            | 336 +++---------------
>  tests/tcg/mips/mipsr5900/Makefile             |  40 +--
>  tests/tcg/xtensa/Makefile                     |  93 -----
>  tests/tcg/xtensa/Makefile.include             |   7 +
>  tests/tcg/xtensa/Makefile.softmmu-target      |  43 +++
>  120 files changed, 385 insertions(+), 857 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/debian-xtensa-cross.docker
>  create mode 100644 tests/docker/dockerfiles/fedora-cris-cross.docker
>  delete mode 100644 tests/tcg/cris/Makefile
>  create mode 100644 tests/tcg/cris/Makefile.include
>  create mode 100644 tests/tcg/cris/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/cris/sys.c
>  rename tests/tcg/cris/{ => system}/check_addcv17.s (100%)
>  rename tests/tcg/cris/{ => system}/check_addi.s (100%)
>  rename tests/tcg/cris/{ => system}/check_addiv32.s (100%)
>  rename tests/tcg/cris/{ => system}/check_addm.s (100%)
>  rename tests/tcg/cris/{ => system}/check_addq.s (100%)
>  rename tests/tcg/cris/{ => system}/check_addr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_addxc.s (100%)
>  rename tests/tcg/cris/{ => system}/check_addxm.s (100%)
>  rename tests/tcg/cris/{ => system}/check_addxr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_andc.s (100%)
>  rename tests/tcg/cris/{ => system}/check_andm.s (100%)
>  rename tests/tcg/cris/{ => system}/check_andq.s (100%)
>  rename tests/tcg/cris/{ => system}/check_andr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_asr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_ba.s (100%)
>  rename tests/tcg/cris/{ => system}/check_bas.s (100%)
>  rename tests/tcg/cris/{ => system}/check_bcc.s (100%)
>  rename tests/tcg/cris/{ => system}/check_boundc.s (100%)
>  rename tests/tcg/cris/{ => system}/check_boundr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_btst.s (89%)
>  rename tests/tcg/cris/{ => system}/check_clearfv32.s (100%)
>  rename tests/tcg/cris/{ => system}/check_clrjmp1.s (100%)
>  rename tests/tcg/cris/{ => system}/check_cmp-2.s (100%)
>  rename tests/tcg/cris/{ => system}/check_cmpc.s (100%)
>  rename tests/tcg/cris/{ => system}/check_cmpm.s (100%)
>  rename tests/tcg/cris/{ => system}/check_cmpq.s (100%)
>  rename tests/tcg/cris/{ => system}/check_cmpr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_cmpxc.s (100%)
>  rename tests/tcg/cris/{ => system}/check_cmpxm.s (100%)
>  rename tests/tcg/cris/{ => system}/check_dstep.s (100%)
>  rename tests/tcg/cris/{ => system}/check_jsr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_lapc.s (100%)
>  rename tests/tcg/cris/{ => system}/check_lsl.s (100%)
>  rename tests/tcg/cris/{ => system}/check_lsr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_mcp.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movdelsr1.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movecr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movei.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movemr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movemrv32.s (100%)
>  rename tests/tcg/cris/{ => system}/check_mover.s (100%)
>  rename tests/tcg/cris/{ => system}/check_moverm.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movmp.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movpmv32.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movpr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movprv32.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movscr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movsm.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movsr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movucr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movum.s (100%)
>  rename tests/tcg/cris/{ => system}/check_movur.s (100%)
>  rename tests/tcg/cris/{ => system}/check_mulv32.s (100%)
>  rename tests/tcg/cris/{ => system}/check_mulx.s (98%)
>  rename tests/tcg/cris/{ => system}/check_neg.s (100%)
>  rename tests/tcg/cris/{ => system}/check_not.s (100%)
>  rename tests/tcg/cris/{ => system}/check_orc.s (100%)
>  rename tests/tcg/cris/{ => system}/check_orm.s (100%)
>  rename tests/tcg/cris/{ => system}/check_orq.s (100%)
>  rename tests/tcg/cris/{ => system}/check_orr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_ret.s (100%)
>  rename tests/tcg/cris/{ => system}/check_scc.s (100%)
>  rename tests/tcg/cris/{ => system}/check_subc.s (100%)
>  rename tests/tcg/cris/{ => system}/check_subm.s (100%)
>  rename tests/tcg/cris/{ => system}/check_subq.s (100%)
>  rename tests/tcg/cris/{ => system}/check_subr.s (100%)
>  rename tests/tcg/cris/{ => system}/check_xarith.s (100%)
>  rename tests/tcg/cris/{ => system}/crt.s (100%)
>  create mode 100644 tests/tcg/cris/system/sys.c
>  rename tests/tcg/cris/{ => system}/testutils.inc (100%)
>  rename tests/tcg/cris/{ => user}/check_abs.c (100%)
>  rename tests/tcg/cris/{ => user}/check_addc.c (100%)
>  rename tests/tcg/cris/{ => user}/check_addcm.c (100%)
>  rename tests/tcg/cris/{ => user}/check_addo.c (100%)
>  rename tests/tcg/cris/{ => user}/check_addoq.c (100%)
>  rename tests/tcg/cris/{ => user}/check_bound.c (100%)
>  rename tests/tcg/cris/{ => user}/check_ftag.c (100%)
>  rename tests/tcg/cris/{ => user}/check_glibc_kernelversion.c (100%)
>  rename tests/tcg/cris/{ => user}/check_hello.c (100%)
>  rename tests/tcg/cris/{ => user}/check_int64.c (100%)
>  rename tests/tcg/cris/{ => user}/check_lz.c (100%)
>  rename tests/tcg/cris/{ => user}/check_mapbrk.c (100%)
>  rename tests/tcg/cris/{ => user}/check_mmap1.c (100%)
>  rename tests/tcg/cris/{ => user}/check_mmap2.c (100%)
>  rename tests/tcg/cris/{ => user}/check_mmap3.c (100%)
>  rename tests/tcg/cris/{ => user}/check_moveq.c (100%)
>  rename tests/tcg/cris/{ => user}/check_openpf1.c (100%)
>  rename tests/tcg/cris/{ => user}/check_openpf2.c (100%)
>  rename tests/tcg/cris/{ => user}/check_openpf3.c (100%)
>  rename tests/tcg/cris/{ => user}/check_openpf5.c (100%)
>  rename tests/tcg/cris/{ => user}/check_settls1.c (100%)
>  rename tests/tcg/cris/{ => user}/check_sigalrm.c (100%)
>  rename tests/tcg/cris/{ => user}/check_stat1.c (100%)
>  rename tests/tcg/cris/{ => user}/check_stat2.c (100%)
>  rename tests/tcg/cris/{ => user}/check_stat3.c (100%)
>  rename tests/tcg/cris/{ => user}/check_stat4.c (100%)
>  rename tests/tcg/cris/{ => user}/check_swap.c (100%)
>  rename tests/tcg/cris/{ => user}/check_time2.c (100%)
>  rename tests/tcg/cris/{ => user}/crisutils.h (100%)
>  rename tests/tcg/cris/{ => user}/sys.h (100%)
>  create mode 100644 tests/tcg/mips/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/xtensa/Makefile
>  create mode 100644 tests/tcg/xtensa/Makefile.include
>  create mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
> 
> -- 
> 2.17.1
> 
