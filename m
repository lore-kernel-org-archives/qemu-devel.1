Received: from eggs.gnu.org ([209.51.188.92]:44072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hAxXG-0005dr-LG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hAxXF-0000i5-3C
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:03:38 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:55386)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hAxXE-0000fx-OR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:03:37 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon,  1 Apr 2019 23:03:06 +0900
Message-Id: <20190401140318.80498-1-ysato@users.sourceforge.jp>
In-Reply-To: <20190325090047.122981-1-ysato@users.sourceforge.jp>
References: <20190325090047.122981-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v6 00/12] Add RX archtecture support
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

Update review comments.

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

Changes v5.
Fix undocumented instruction behavior.
(PUSHM/POPM/RTSD/MVFC/MVTC)
More useful messages for invalid operands.

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
  include/hw/regiserfields.h: Add 8bit and 16bit registers

 configure                      |    8 +
 default-configs/rx-softmmu.mak |    7 +
 include/disas/bfd.h            |    5 +
 include/hw/char/renesas_sci.h  |   45 +
 include/hw/intc/rx_icu.h       |   49 +
 include/hw/registerfields.h    |   10 +
 include/hw/rx/rx.h             |    7 +
 include/hw/rx/rx62n.h          |   54 +
 include/hw/timer/renesas_cmt.h |   33 +
 include/hw/timer/renesas_tmr.h |   46 +
 include/sysemu/arch_init.h     |    1 +
 target/rx/cpu-qom.h            |   52 +
 target/rx/cpu.h                |  197 ++++
 target/rx/helper.h             |   31 +
 arch_init.c                    |    2 +
 hw/char/renesas_sci.c          |  335 ++++++
 hw/intc/rx_icu.c               |  373 ++++++
 hw/rx/rx62n.c                  |  226 ++++
 hw/rx/rxqemu.c                 |  100 ++
 hw/timer/renesas_cmt.c         |  264 +++++
 hw/timer/renesas_tmr.c         |  438 ++++++++
 target/rx/cpu.c                |  232 ++++
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
 39 files changed, 7873 insertions(+), 1 deletion(-)
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
