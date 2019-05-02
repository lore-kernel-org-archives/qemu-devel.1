Received: from eggs.gnu.org ([209.51.188.92]:44792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hMCnB-0003WO-Bi
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hMCn9-0008OT-9N
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:34:33 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:41242)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hMCn7-0008Jh-AM
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:34:29 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu,  2 May 2019 23:33:57 +0900
Message-Id: <20190502143409.59600-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v8 00/12] Add RX archtecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, peter.maydell@linaro.org, richard.henderson@linaro.org

Hello.
This patch series is added Renesas RX target emulation.

It was corrected because the correspondence to registerfield was insufficient.

My git repository is bellow.
git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git

Testing binaries bellow.
u-boot
Download - https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz

starting
$ gzip -d u-boot.bin.gz
$ qemu-system-rx -bios u-boot.bin

linux and pico-root (only sash)
Download - https://osdn.net/users/ysato/pf/qemu/dl/zImage (kernel)
           https://osdn.net/users/ysato/pf/qemu/dl/rx-qemu.dtb (DeviceTree)

starting
$ qemu-system-rx -kernel zImage -dtb rx-qemu.dtb -append "earlycon"

Changes for v7.
Fix bra.l and bsr.l instructions.
Following the fix of the master branch.

Yoshinori Sato (12):
  target/rx: TCG translation
  target/rx: TCG helper
  target/rx: CPU definition
  target/rx: RX disassembler
  target/rx: Miscellaneous files
  hw/intc: RX62N interrupt controller (ICUa)
  hw/timer: RX62N internal timer modules
  hw/char: RX62N serical communication interface (SCI)
  hw/rx: RX Target hardware definition
  Add rx-softmmu
  MAINTAINERS: Add RX
  hw/registerfields.h: Add 8bit and 16bit register macros.

 configure                      |    8 +
 default-configs/rx-softmmu.mak |    7 +
 include/disas/dis-asm.h        |    5 +
 include/hw/char/renesas_sci.h  |   45 +
 include/hw/intc/rx_icu.h       |   49 +
 include/hw/registerfields.h    |   28 +-
 include/hw/rx/rx.h             |    7 +
 include/hw/rx/rx62n.h          |   54 +
 include/hw/timer/renesas_cmt.h |   33 +
 include/hw/timer/renesas_tmr.h |   46 +
 include/sysemu/arch_init.h     |    1 +
 target/rx/cpu-qom.h            |   52 +
 target/rx/cpu.h                |  196 ++++
 target/rx/helper.h             |   31 +
 arch_init.c                    |    2 +
 hw/char/renesas_sci.c          |  341 ++++++
 hw/intc/rx_icu.c               |  373 ++++++
 hw/rx/rx62n.c                  |  226 ++++
 hw/rx/rxqemu.c                 |  100 ++
 hw/timer/renesas_cmt.c         |  277 +++++
 hw/timer/renesas_tmr.c         |  458 ++++++++
 target/rx/cpu.c                |  222 ++++
 target/rx/disas.c              | 1481 ++++++++++++++++++++++++
 target/rx/gdbstub.c            |  112 ++
 target/rx/helper.c             |  148 +++
 target/rx/monitor.c            |   38 +
 target/rx/op_helper.c          |  481 ++++++++
 target/rx/translate.c          | 2433 ++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                    |   19 +
 hw/Kconfig                     |    1 +
 hw/char/Kconfig                |    3 +
 hw/char/Makefile.objs          |    2 +-
 hw/intc/Makefile.objs          |    1 +
 hw/rx/Kconfig                  |    2 +
 hw/rx/Makefile.objs            |    1 +
 hw/timer/Kconfig               |    6 +
 hw/timer/Makefile.objs         |    3 +
 target/rx/Makefile.objs        |   11 +
 target/rx/insns.decode         |  617 ++++++++++
 39 files changed, 7918 insertions(+), 2 deletions(-)
 create mode 100644 default-configs/rx-softmmu.mak
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 include/hw/rx/rx.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 target/rx/cpu-qom.h
 create mode 100644 target/rx/cpu.h
 create mode 100644 target/rx/helper.h
 create mode 100644 hw/char/renesas_sci.c
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 hw/rx/rx62n.c
 create mode 100644 hw/rx/rxqemu.c
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 target/rx/cpu.c
 create mode 100644 target/rx/disas.c
 create mode 100644 target/rx/gdbstub.c
 create mode 100644 target/rx/helper.c
 create mode 100644 target/rx/monitor.c
 create mode 100644 target/rx/op_helper.c
 create mode 100644 target/rx/translate.c
 create mode 100644 hw/rx/Kconfig
 create mode 100644 hw/rx/Makefile.objs
 create mode 100644 target/rx/Makefile.objs
 create mode 100644 target/rx/insns.decode

-- 
2.11.0
