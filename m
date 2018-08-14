Received: from eggs.gnu.org ([2001:4830:134:3::10]:42332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fpdOY-0006Fp-MO
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fpdOJ-0002TV-Jl
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:46:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 14 Aug 2018 17:27:33 +0100
Message-Id: <20180814162739.11814-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 0/6] arm: add Cortex M0 CPU model and hex
 file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, joel@jms.id.au, qemu-arm@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>, jim@groklearning.com, Alistair Francis <alistair@alistair23.me>, Steffen Gortz <qemu.ml@steffen-goertz.de>, mail@steffen-goertz.de, Su Hang <suhang16@mails.ucas.ac.cn>, ilg@livius.net, Stefan Hajnoczi <stefanha@redhat.com>

v6:
 * Added comment to hexloader-test.c explaining contents of test.hex file
   [Phil]
v5:
 * Implemented Phil's hex loader suggestions
 * Replaced Su Hang's test hex file with a simple memory test pattern,
   eliminating the need to distribute source [Phil]
v4:
 * Drop ARMv7MState to ARMMProfileState rename because it causes a lot of=
 code
   churn and is incomplete.  Other parts of QEMU (like NVIC emulation) st=
ill
   refer to "v7m" although they apply to other architecture versions too.
   [Peter]
 * Use the generic loader device (-device loader,file=3Dprogram.hex,cpu-n=
um=3D1)
   instead of -kernel.  -kernel is a legacy command-line option that is k=
ept as
   a convenience, but it's not as flexible or predictable as the generic =
loader
   device.  New image formats should be added to the generic loader devic=
e.
   [Peter]
 * Use hex/ASCII literals instead of decimal literals in hexloader-test.c=
.
   This makes the test case slightly easier to understand. [Philippe]
v3:
 * Rename ARMv7MState to ARMMProfileState so a single class can cater for
   ARMv6-M, ARMv7-M, and ARMv8-M [Peter]
 * Make bitbanding optional via a qdev property [Peter]
 * Add hex file loader patches to reduce dependencies in upcoming patch s=
eries
 * Implement rollback if hex file loader fails partway through [Peter]
 * Update hex file loader test case to use an ARMv7-M board since hex fil=
e
   loading is only done for ARM M Profile boards

This series contains the prerequistes for the "microbit" machine type tha=
t Joel
Stanley has written.  I have combined the Cortex M0 CPU model and hex loa=
der
work into one series to reduce the dependencies in upcoming patch series =
from
Joel, Julia, and Steffen.

This patch series:
 * Makes bitbanding optional on ARMv7MState.
 * Adds a "cortex-m0" cpu type which can be used with ARMMProfileState.  =
This
   works thanks to Julia's Cortex M0 emulation patches, which are now all
   merged.
 * Adds Su Hang's Intel HEX file format loader so that micro:bit and othe=
r
   microcontroller firmware images can be run using -kernel.  The micro:b=
it
   development tools typically only emit .hex files and not ELFs.

Stefan Hajnoczi (4):
  hw/arm: make bitbanded IO optional on ARMv7-M
  target/arm: add "cortex-m0" CPU model
  loader: extract rom_free() function
  loader: add rom transaction API

Su Hang (2):
  loader: Implement .hex file loader
  Add QTest testcase for the Intel Hexadecimal

 MAINTAINERS                          |   6 +
 configure                            |   4 +
 tests/Makefile.include               |   2 +
 include/hw/arm/armv7m.h              |   2 +
 include/hw/loader.h                  |  31 +++
 hw/arm/armv7m.c                      |  37 ++--
 hw/arm/mps2.c                        |   1 +
 hw/arm/msf2-soc.c                    |   1 +
 hw/arm/stellaris.c                   |   1 +
 hw/arm/stm32f205_soc.c               |   1 +
 hw/core/generic-loader.c             |   4 +
 hw/core/loader.c                     | 302 ++++++++++++++++++++++++++-
 target/arm/cpu.c                     |  11 +
 tests/hexloader-test.c               |  45 ++++
 tests/hex-loader-check-data/test.hex |  18 ++
 15 files changed, 440 insertions(+), 26 deletions(-)
 create mode 100644 tests/hexloader-test.c
 create mode 100644 tests/hex-loader-check-data/test.hex

--=20
2.17.1
