Received: from eggs.gnu.org ([2001:4830:134:3::10]:49951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBC-0004v0-LI
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWB9-00034P-6r
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:54 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDWB8-000333-SR
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:51 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue,  1 May 2018 16:22:10 +0200
Message-Id: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [RFC PATCH 00/12] tests/tcg: Add TriCore tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

Hi Alex,

I finally came around converting some of my TriCore regression tests into actual
tests, that don't require the proprietary Infineon simulator.

These tests are heavily inspired by the riscv-tests [1]. I add macros that
allow easy testing of single asm instructions.

e.g. for add %d1, %d2, %d3 this looks like
          insn test_num res  rs1  rs2
           v      v      v    v    v
TEST_D_DD(add,    1,    0x3, 0x1, 0x2)

Each of the macros generates code that loads the operands into registers,
executes the instruction, and finally checks if the result is as expected.
If the expected result does not match, a guest fail handler is called, that
writes the test_num to a testdev. This testdev takes the test_num and returns it
as an status code using exit(). If all tests pass, we jump to a pass handler,
that writes 0 to the testdev.

Unfortunately, I didn't add any switch to run this automatically on 'make check'
or similar, since there is no obvious way to integrate the tricore-binutils [2].

You can find the full tree here:
https://github.com/bkoppelmann/qemu/tree/tcg-tests-tricore

Cheers,
Bastian

[1] https://github.com/riscv/riscv-tests
[2] https://github.com/bkoppelmann/tricore-binutils

Bastian Koppelmann (12):
  hw/tricore: Add testdevice for tests in tests/tcg/
  tests/tcg/tricore: Add build infrastructure
  tests/tcg/tricore: Add macros to easily create tests and first test
    'abs'
  tests/tcg/tricore: Add bmerge test
  tests/tcg/tricore: Add clz test
  tests/tcg/tricore: Add dvstep test
  tests/tcg/tricore: Add fadd test
  tests/tcg/tricore: Add fmul test
  tests/tcg/tricore: Add ftoi test
  tests/tcg/tricore: Add madd test
  tests/tcg/tricore: Add msub test
  tests/tcg/tricore: Add muls test

 hw/tricore/Makefile.objs                |   1 +
 hw/tricore/tricore_testboard.c          |   8 ++
 hw/tricore/tricore_testdevice.c         |  81 ++++++++++++++++++++
 include/hw/tricore/tricore_testdevice.h |  38 ++++++++++
 tests/tcg/tricore/Makefile              |  41 ++++++++++
 tests/tcg/tricore/link.ld               |  60 +++++++++++++++
 tests/tcg/tricore/macros.h              | 129 ++++++++++++++++++++++++++++++++
 tests/tcg/tricore/test_abs.S            |   8 ++
 tests/tcg/tricore/test_bmerge.S         |   8 ++
 tests/tcg/tricore/test_clz.S            |   9 +++
 tests/tcg/tricore/test_dvstep.S         |  15 ++++
 tests/tcg/tricore/test_fadd.S           |  16 ++++
 tests/tcg/tricore/test_fmul.S           |   8 ++
 tests/tcg/tricore/test_ftoi.S           |  10 +++
 tests/tcg/tricore/test_madd.S           |  11 +++
 tests/tcg/tricore/test_msub.S           |   9 +++
 tests/tcg/tricore/test_muls.S           |   9 +++
 17 files changed, 461 insertions(+)
 create mode 100644 hw/tricore/tricore_testdevice.c
 create mode 100644 include/hw/tricore/tricore_testdevice.h
 create mode 100644 tests/tcg/tricore/Makefile
 create mode 100644 tests/tcg/tricore/link.ld
 create mode 100644 tests/tcg/tricore/macros.h
 create mode 100644 tests/tcg/tricore/test_abs.S
 create mode 100644 tests/tcg/tricore/test_bmerge.S
 create mode 100644 tests/tcg/tricore/test_clz.S
 create mode 100644 tests/tcg/tricore/test_dvstep.S
 create mode 100644 tests/tcg/tricore/test_fadd.S
 create mode 100644 tests/tcg/tricore/test_fmul.S
 create mode 100644 tests/tcg/tricore/test_ftoi.S
 create mode 100644 tests/tcg/tricore/test_madd.S
 create mode 100644 tests/tcg/tricore/test_msub.S
 create mode 100644 tests/tcg/tricore/test_muls.S

--
2.11.0
