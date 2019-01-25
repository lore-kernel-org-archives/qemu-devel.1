Received: from eggs.gnu.org ([209.51.188.92]:57727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyON-0007Hb-Ju
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOJ-0001RU-H6
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:19 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOJ-0001Pg-89
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id t200so6102549wmt.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:19 +0100
Message-Id: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v5 00/52] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

(I'm only momentarily at the helm and will give control back to Yang after
this iteration.)

This is still RFC mostly because of the lack of documentation, and because
only x86 is fully converted, but it's converging.  Other targets still
enable embedded devices in default-configs/ instead of using "select"
directives.  For many targets, the conversion will be trivial because
they only support one board.  The complex ones are ARM, MIPS and PPC
of course.  s390 as usual is just different in some respects, but all
of its issues are sorted out already in this series and so it's just
yet another single-board target.

It supports defconfig (default-configs file chooses boards only)
and allnoconfig (default-configs file chooses devices too) and builds
all targets.  I haven't yet checked that the configuration is the same
before and after the conversion, but at least device-introspection-test
and other qtests all pass, which did catch some errors.

As mentioned in the previous versions, this is only a replacement
for default-configs, in order to simplify configuration and remove
the need to track dependencies between configuration symbols.  In
fact, even with the current incomplete conversion the diffstat
for default-configs is already

 31 files changed, 108 insertions(+), 241 deletions(-)

Devices can be disabled by adding for example

   CONFIG_HPET=n

to default-configs/i386-softmmu.mak.  If you prefer they can be
listed manually and "make allnoconfig" can be executed before
building.  This probably should become a configure option
"--without-default-devices" instead.

For the previous discussions on the Kconfig design, see
http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02827.html

Patches 1-27 should probably be committed now, so please review!  Yang,
once they are reviewed you can extract them and post them to the
mailing list as non-RFC!

As to the rest, you're welcome to try them, post conversions for the
simple targets, suggest usability improvements, and whatever.  Thanks to
everyone for the work on the previous iterations.  It's great to see
the work on this GSoC project come back to life after five years!

v4->v5: new patches 1, 2, 3, 13, 26, 27, 47, 49, 50, 52
	Removed CONFIG_TYPHOON (patch 20)
	Removed CONFIG_DINO (patch 22)
	ported minikconf to python 3
	improved some minikconf error messages
	added missing symbols in patch 32
	added CONFIG_VHOST_USER and CONFIG_LINUX, made CONFIG_KVM per target (patch 33)
	removed $(...) assignments from default-configs/ (patch 33)
	moved allnoconfig patch earlier, removed allyesconfig/randconfig
	add CONFIG_PCI_EXPRESS to non-x86 targets (patch 36)
	added CONFIG_PCI_DEVICES in patch 37 to support s390x
	virtio-mmio does not support vhost-user yet (patches 40 and 48)
	fix PCSPK for platforms that lack an i8254 (patch 41)
	add "select ISA_BUS" to I82378 and SUN4U (patch 41)
	changed QXL/VTD/AMD_IOMMU from "select" to "default y if ..." (patch 42)
	moved "select PAM" and "select ISA_BUS" from board to device (patch 42)
	brought patch 44 up to date
	fixed MILKYMIST_TMU2 to only apply to MILKYMIST (patch 45)
	new config symbol VIRTIO_INPUT_HOST
	fixed select/depends for virtio (patch 48)
	moved some ACPI dependencies from board to devices (patch 51)

Paolo Bonzini (27):
  arm: disable CONFIG_SERIAL_ISA
  ide: split ioport registration to a separate file
  vfio: move conditional up to hw/Makefile.objs
  build: actually use CONFIG_PAM
  hw/i386/Makefile.objs: Build pc_piix* and pc_q35 boards
  hw/s390/Makefile.objs: Create new CONFIG_* variables for s390x boards and devices
  hw/i2c/Makefile.objs: Create new CONFIG_* variables for EEPROM and ACPI controller
  hw/vfio/Makefile.objs: Create new CONFIG_* variables for VFIO core and PCI
  minikconfig: add parser skeleton
  minikconfig: add AST
  minikconfig: add semantic analysis
  kconfig: introduce kconfig files
  build: switch to Kconfig
  minikconf: implement allnoconfig and defconfig
  ide: express dependencies with Kconfig
  build: convert pci.mak to Kconfig
  build: convert sound.mak to Kconfig
  build: convert usb.mak to Kconfig
  scsi: express dependencies with Kconfig
  isa: express dependencies with kconfig
  i386: express dependencies with Kconfig
  i2c: express dependencies with Kconfig
  ptimer: express dependencies with Kconfig
  vfio: express vfio dependencies with Kconfig
  tpm: express dependencies with Kconfig
  isa: express SuperIO dependencies with Kconfig
  kconfig: introduce CONFIG_TEST_DEVICES

Yang Zhong (17):
  hw/pci-host/Makefile.objs: make CONFIGS clear for PCI EXPRESS
  hw/arm/Makefile.objs: CONFIG_VIRT created for virt board
  hw/nios2/Makefile.objs: Conditionally build nios2
  hw/riscv/Makefile.objs: Create CONFIG_* for riscv boards
  hw/sparc64/Makefile.objs: Create CONFIG_* for sparc64
  hw/alpha/Makefile.objs: Create CONFIG_* for alpha
  hw/cris/Makefile.objs: Create CONFIG_* for cris
  hw/hppa/Makefile.objs: Create CONFIG_* for hppa
  hw/moxie/Makefile.objs: Conditionally build moxie
  hw/openrisc/Makefile.objs: Create CONFIG_* for openrisc
  hw/tricore/Makefile.objs: Create CONFIG_* for tricore
  hw/display: make edid configurable
  hw/pci/Makefile.objs: make pcie configurable
  display: express dependencies with kconfig
  hyperv: express dependencies with kconfig
  virtio: express virtio dependencies with Kconfig
  i386-softmmu.mak: remove all CONFIG_* except boards definitions

Ákos Kovács (8):
  hw/m68k/Makefile.objs: Conditionally build boards
  hw/microblaze/Makefile.objs: Create configs for petalogix and xilinx
    boards
  hw/mips/Makefile.objs: Create CONFIG_* for r4k, malta, mipssim boards
  hw/ppc/Makefile.objs: Build all boards conditinally with CONFIG_*
  hw/sh4/Makefile.objs: New CONFIG_* varibales created for sh4 boards
    and device
  hw/sparc/Makefile.objs: CONFIG_* for sun4m and leon3 created
  hw/lm32/Makefile.objs: Conditionally build lm32 and milkmyst
  hw/xtensa/Makefile.objs: Build xtensa_sim and xtensa_fpga
    conditionally

 Kconfig.host                            |  24 ++
 Makefile                                |  27 +-
 Makefile.target                         |   7 +-
 configure                               |   3 +
 default-configs/alpha-softmmu.mak       |  14 +-
 default-configs/arm-softmmu.mak         |  16 +-
 default-configs/cris-softmmu.mak        |   2 +-
 default-configs/hppa-softmmu.mak        |   6 +-
 default-configs/hyperv.mak              |   2 -
 default-configs/i386-softmmu.mak        |  77 +---
 default-configs/lm32-softmmu.mak        |   2 -
 default-configs/m68k-softmmu.mak        |   3 +-
 default-configs/microblaze-softmmu.mak  |   4 +-
 default-configs/mips-softmmu-common.mak |  13 +-
 default-configs/mips64el-softmmu.mak    |   3 +-
 default-configs/moxie-softmmu.mak       |   1 +
 default-configs/nios2-softmmu.mak       |   2 +-
 default-configs/or1k-softmmu.mak        |   1 +
 default-configs/pci.mak                 |  49 ---
 default-configs/ppc-softmmu.mak         |  28 +-
 default-configs/ppc64-softmmu.mak       |   5 -
 default-configs/riscv32-softmmu.mak     |  15 +-
 default-configs/riscv64-softmmu.mak     |  15 +-
 default-configs/s390x-softmmu.mak       |   9 +-
 default-configs/sh4-softmmu.mak         |  17 +-
 default-configs/sh4eb-softmmu.mak       |  15 +-
 default-configs/sound.mak               |   4 -
 default-configs/sparc-softmmu.mak       |   3 +-
 default-configs/sparc64-softmmu.mak     |   9 +-
 default-configs/tricore-softmmu.mak     |   1 +
 default-configs/unicore32-softmmu.mak   |   1 -
 default-configs/usb.mak                 |  11 -
 default-configs/virtio.mak              |  15 -
 default-configs/xtensa-softmmu.mak      |   3 +
 default-configs/xtensaeb-softmmu.mak    |   3 +
 docs/devel/build-system.txt             |   1 -
 hw/9pfs/Kconfig                         |   6 +
 hw/Kconfig                              |  73 ++++
 hw/Makefile.objs                        |   4 +-
 hw/acpi/Kconfig                         |  29 ++
 hw/adc/Kconfig                          |   2 +
 hw/alpha/Kconfig                        |   2 +
 hw/alpha/Makefile.objs                  |   2 +-
 hw/arm/Kconfig                          | 117 ++++++
 hw/arm/Makefile.objs                    |   3 +-
 hw/audio/Kconfig                        |  52 +++
 hw/block/Kconfig                        |  38 ++
 hw/bt/Kconfig                           |   2 +
 hw/char/Kconfig                         |  42 ++
 hw/core/Kconfig                         |  11 +
 hw/cpu/Kconfig                          |   8 +
 hw/cris/Kconfig                         |   6 +
 hw/cris/Makefile.objs                   |   2 +-
 hw/display/Kconfig                      | 107 +++++
 hw/display/Makefile.objs                |   4 +-
 hw/dma/Kconfig                          |  21 +
 hw/gpio/Kconfig                         |   9 +
 hw/hppa/Kconfig                         |   5 +
 hw/hppa/Makefile.objs                   |   2 +-
 hw/hyperv/Kconfig                       |   9 +
 hw/i2c/Kconfig                          |  27 ++
 hw/i2c/Makefile.objs                    |   7 +-
 hw/i386/Kconfig                         |  88 ++++
 hw/i386/Makefile.objs                   |   4 +-
 hw/ide/Kconfig                          |  54 +++
 hw/ide/Makefile.objs                    |   6 +-
 hw/ide/core.c                           |  25 --
 hw/ide/ioport.c                         |  67 ++++
 hw/input/Kconfig                        |  33 ++
 hw/intc/Kconfig                         |  59 +++
 hw/ipack/Kconfig                        |   4 +
 hw/ipmi/Kconfig                         |  22 +
 hw/isa/Kconfig                          |  53 +++
 hw/lm32/Kconfig                         |   7 +
 hw/lm32/Makefile.objs                   |   4 +-
 hw/m68k/Kconfig                         |  10 +
 hw/m68k/Makefile.objs                   |   4 +-
 hw/mem/Kconfig                          |  10 +
 hw/microblaze/Kconfig                   |   8 +
 hw/microblaze/Makefile.objs             |   6 +-
 hw/mips/Kconfig                         |  21 +
 hw/mips/Makefile.objs                   |   5 +-
 hw/misc/Kconfig                         | 112 ++++++
 hw/misc/macio/Kconfig                   |  11 +
 hw/moxie/Kconfig                        |   2 +
 hw/moxie/Makefile.objs                  |   2 +-
 hw/net/Kconfig                          | 122 ++++++
 hw/net/Makefile.objs                    |   4 +-
 hw/nios2/Kconfig                        |   5 +
 hw/nios2/Makefile.objs                  |   3 +-
 hw/nvram/Kconfig                        |   8 +
 hw/openrisc/Kconfig                     |   2 +
 hw/openrisc/Makefile.objs               |   2 +-
 hw/pci-bridge/Kconfig                   |  29 ++
 hw/pci-host/Kconfig                     |  49 +++
 hw/pci-host/Makefile.objs               |  10 +-
 hw/pci/Kconfig                          |   9 +
 hw/pci/Makefile.objs                    |   9 +-
 hw/pcmcia/Kconfig                       |   2 +
 hw/ppc/Kconfig                          |  60 +++
 hw/ppc/Makefile.objs                    |  11 +-
 hw/riscv/Kconfig                        |  19 +
 hw/riscv/Makefile.objs                  |  22 +-
 hw/s390x/Kconfig                        |   2 +
 hw/s390x/Makefile.objs                  |   2 +
 hw/scsi/Kconfig                         |  54 +++
 hw/scsi/Makefile.objs                   |   2 +-
 hw/sd/Kconfig                           |  14 +
 hw/sh4/Kconfig                          |  12 +
 hw/sh4/Makefile.objs                    |   4 +-
 hw/smbios/Kconfig                       |   2 +
 hw/sparc/Kconfig                        |  13 +
 hw/sparc/Makefile.objs                  |   4 +-
 hw/sparc64/Kconfig                      |   6 +
 hw/sparc64/Makefile.objs                |   6 +-
 hw/ssi/Kconfig                          |  14 +
 hw/timer/Kconfig                        |  63 +++
 hw/tpm/Kconfig                          |  27 ++
 hw/tricore/Kconfig                      |   2 +
 hw/tricore/Makefile.objs                |   2 +-
 hw/unicore32/Kconfig                    |   3 +
 hw/usb/Kconfig                          |  91 +++++
 hw/vfio/Kconfig                         |  36 ++
 hw/vfio/Makefile.objs                   |   9 +-
 hw/virtio/Kconfig                       |  27 ++
 hw/watchdog/Kconfig                     |  16 +
 hw/xtensa/Kconfig                       |   5 +
 hw/xtensa/Makefile.objs                 |   4 +-
 rules.mak                               |   2 +-
 scripts/make_device_config.sh           |  30 --
 scripts/minikconf.py                    | 687 ++++++++++++++++++++++++++++++++
 131 files changed, 2749 insertions(+), 374 deletions(-)
 create mode 100644 Kconfig.host
 delete mode 100644 default-configs/hyperv.mak
 delete mode 100644 default-configs/pci.mak
 delete mode 100644 default-configs/sound.mak
 delete mode 100644 default-configs/usb.mak
 delete mode 100644 default-configs/virtio.mak
 create mode 100644 hw/9pfs/Kconfig
 create mode 100644 hw/Kconfig
 create mode 100644 hw/acpi/Kconfig
 create mode 100644 hw/adc/Kconfig
 create mode 100644 hw/alpha/Kconfig
 create mode 100644 hw/arm/Kconfig
 create mode 100644 hw/audio/Kconfig
 create mode 100644 hw/block/Kconfig
 create mode 100644 hw/bt/Kconfig
 create mode 100644 hw/char/Kconfig
 create mode 100644 hw/core/Kconfig
 create mode 100644 hw/cpu/Kconfig
 create mode 100644 hw/cris/Kconfig
 create mode 100644 hw/display/Kconfig
 create mode 100644 hw/dma/Kconfig
 create mode 100644 hw/gpio/Kconfig
 create mode 100644 hw/hppa/Kconfig
 create mode 100644 hw/hyperv/Kconfig
 create mode 100644 hw/i2c/Kconfig
 create mode 100644 hw/i386/Kconfig
 create mode 100644 hw/ide/Kconfig
 create mode 100644 hw/ide/ioport.c
 create mode 100644 hw/input/Kconfig
 create mode 100644 hw/intc/Kconfig
 create mode 100644 hw/ipack/Kconfig
 create mode 100644 hw/ipmi/Kconfig
 create mode 100644 hw/isa/Kconfig
 create mode 100644 hw/lm32/Kconfig
 create mode 100644 hw/m68k/Kconfig
 create mode 100644 hw/mem/Kconfig
 create mode 100644 hw/microblaze/Kconfig
 create mode 100644 hw/mips/Kconfig
 create mode 100644 hw/misc/Kconfig
 create mode 100644 hw/misc/macio/Kconfig
 create mode 100644 hw/moxie/Kconfig
 create mode 100644 hw/net/Kconfig
 create mode 100644 hw/nios2/Kconfig
 create mode 100644 hw/nvram/Kconfig
 create mode 100644 hw/openrisc/Kconfig
 create mode 100644 hw/pci-bridge/Kconfig
 create mode 100644 hw/pci-host/Kconfig
 create mode 100644 hw/pci/Kconfig
 create mode 100644 hw/pcmcia/Kconfig
 create mode 100644 hw/ppc/Kconfig
 create mode 100644 hw/riscv/Kconfig
 create mode 100644 hw/s390x/Kconfig
 create mode 100644 hw/scsi/Kconfig
 create mode 100644 hw/sd/Kconfig
 create mode 100644 hw/sh4/Kconfig
 create mode 100644 hw/smbios/Kconfig
 create mode 100644 hw/sparc/Kconfig
 create mode 100644 hw/sparc64/Kconfig
 create mode 100644 hw/ssi/Kconfig
 create mode 100644 hw/timer/Kconfig
 create mode 100644 hw/tpm/Kconfig
 create mode 100644 hw/tricore/Kconfig
 create mode 100644 hw/unicore32/Kconfig
 create mode 100644 hw/usb/Kconfig
 create mode 100644 hw/vfio/Kconfig
 create mode 100644 hw/virtio/Kconfig
 create mode 100644 hw/watchdog/Kconfig
 create mode 100644 hw/xtensa/Kconfig
 delete mode 100644 scripts/make_device_config.sh
 create mode 100644 scripts/minikconf.py

-- 
1.8.3.1
