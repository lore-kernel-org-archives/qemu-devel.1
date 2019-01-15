Received: from eggs.gnu.org ([209.51.188.92]:37581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPYa-00037A-QF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPRE-00016S-Oj
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:56300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gjPR5-000130-0M
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:26 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Tue, 15 Jan 2019 22:10:31 +0800
Message-Id: <20190115141108.934-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 00/37] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

This Kconfig implementation is rebased from Paolo's branch
https://github.com/bonzini/qemu/commits/kconfig

I rebased most of patches except other ARCHs board definitions
this time.
https://github.com/yangzhon/qemu/commits/topic/upstream/Kconfig

The current RFC patches only support
(*) x86_64 platform build
    Once design is fixed, we can do other archs.

(*) defconfig
    "randconfig" build has some issues, which are mostly related
    with CONFIG* in Kconfig.host abd configure. In randconfig mode,
    some CONFIG* has different setting value in config-host.mak and
    %/config-device.mak, which make QEMU build failure.

(*) Kconfig in hw/ directory

The current configure and build command are same with previous
commands and if we want to disable or enable some features, like
"tcg", we still need add "--enable/--disable-tcg" in configure
command line. If we want to disable one emulation device, we can
disable this in related Kconfig file in hw/ directory.

The current build command:
(*) ./configure --target-list=x86_64-softmmu
(*) make -j8

Since the Kconfig language replace traditional CONFIG_* in
default-config/%-softmmu.mak, the %-softmmu.mak file only
define embeded boards or machines, like 440fx and Q35 in x86_64
platform. The Kconfig has already defined dependency topology
between different Kconfig files, but there are still some issues

(*) Kconfig for configure(config-host.mak)
    Some CONFIG* in configure  need some logic to generate, those
    are hard to input this CONFIG* in Kconfig.host or Kconfig* file.

(*) Kconfig for %config-target.mak
    The CONFIG* in %/config-target.mak file, this is still related
    with configure.

(*) randconfig support issue.

Before this RFC patches, we have talked Kconfig in another thread
http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02827.html

Please give your comments on this RFC thread, many thanks!

Changes in v2:
patch 1:    added "CONFIG_PAM=y" in default-configs/i386-softmmu.mak
            (Thomas Huth)
patch 3~14: added support for other ARCHs configurable(Paolo)
patch 15:   changed the annotate (Paolo)
patch 16:   changed the python code (Paolo)
patch 19:   added other ARCHs Kconfig files(Paolo)
patch 21:   added "select IDE_PCI" for CMD646, PIIX, VIA and SII3112(Thomas Huth)
patch 22:   added new patch for PCIE configurable.
patch 23:   moved "select IDE_PCI" from  CMD646, PIIX, VIA to 21 patch(Thomas Huth)
            added "select CAN_BUS" for net/Kconfig (Thomas Huth)
            added "depends on PCI" for CAN_SJA1000 (Paolo)
            removed CONFIG_PCIE=y and add dependency for pcie(Paolo)
patch 26:   added "depends on PSERIES" for "config SPAPR_VSCSI" (Thomas Huth)
            USB_STORAGE_BOT and USB_STORAGE_UAS must also "select SCSI"(Paolo)
patch 28:   added "select SERIAL" into "config SERIAL_PCI" (Thomas Huth)
            removed "depend on ISA_BUS" from "config VGA_CIRRUS"(Thomas Huth)
patch 30:   "config XLNX_ZYNQMP_ARM" is defined in hw/arm/Kconfig(Thomas Huth)
            CONFIG_AUX should select I2C(Paolo)
patch 33:   depends on HYPERV for HYPERV_TESTDEV(Thomas Huth)
            removed "select HYPERV" and "select HYPERV_TESTDEV" with
            "default y if PC" in "config HYPERV" and "config HYPERV_TESTDEV"(Paolo)
patch 34:   deleted default-configs/virtio.mak(Thomas Huth)
            removed "y" in "config VIRTIO_MMIO"(Thomas Huth)
patch 35:   removed remaining CONFIG_* and removed "select xxxx" from hw/i386/Kconfig
            to other Kconfigs(Paolo)

Paolo Bonzini (18):
  build: actually use CONFIG_PAM
  hw/i386/Makefile.objs: Build pc_piix* and pc_q35 boards
  minikconfig: add parser skeleton
  minikconfig: add AST
  minikconfig: add semantic analysis
  kconfig: introduce kconfig files
  build: switch to Kconfig
  ide: express dependencies with Kconfig
  build: convert pci.mak to Kconfig
  build: convert sound.mak to Kconfig
  build: convert usb.mak to Kconfig
  scsi: express dependencies with Kconfig
  bluetooth: express dependencies with Kconfig
  isa: express dependencies with kconfig
  i386: express dependencies with Kconfig
  i2c: express dependencies with Kconfig
  ptimer: express dependencies with Kconfig
  minikconf: implement allyesconfig, allnoconfig, randconfig, defconfig

Yang Zhong (11):
  hw/arm/Makefile.objs: CONFIG_VIRT created for virt board
  hw/nios2/Makefile.objs: Conditionally build nios2
  hw/riscv/Makefile.objs: Create CONFIG_* for riscv boards
  hw/sparc64/Makefile.objs: Create CONFIG_* for sparc64
  hw/display: make edid configurable
  hw/pci/Makefile.objs: make pcie configurable
  edid: express dependencies with kconfig
  hyperv: express dependencies with kconfig
  virtio: make virtio dependencies with Kconfig
  i386-softmmu.mak: remove all CONFIG_* except boards definitions
  Makefile: only support defconfig

Ákos Kovács (8):
  hw/m68k/Makefile.objs: Conditionally build boards
  hw/microblaze/Makefile.objs: Create configs for petalogix and xilinx
    boards
  hw/mips/Makefile.objs: Create CONFIG_* for r4k, malta,mipssim boards
  hw/ppc/Makefile.objs: Build all boards conditinally with CONFIG_*
  hw/sh4/Makefile.objs: New CONFIG_* varibales created for sh4 boards
    and device
  hw/sparc/Makefile.objs: CONFIG_* for sun4m and leon3 created
  hw/lm32/Makefile.objs: Conditionally build lm32 and milkmyst
  hw/xtensa/Makefile.objs: Build xtensa_sim and xtensa_fpga
    conditionally

 Kconfig.host                            |  24 +
 Makefile                                |  19 +-
 Makefile.target                         |   7 +-
 default-configs/alpha-softmmu.mak       |   5 +-
 default-configs/arm-softmmu.mak         |   6 +-
 default-configs/hppa-softmmu.mak        |   3 +-
 default-configs/hyperv.mak              |   2 -
 default-configs/i386-softmmu.mak        |  72 +--
 default-configs/m68k-softmmu.mak        |   3 +
 default-configs/microblaze-softmmu.mak  |   3 +
 default-configs/mips-softmmu-common.mak |   9 +-
 default-configs/mips64el-softmmu.mak    |   1 -
 default-configs/nios2-softmmu.mak       |   1 +
 default-configs/pci.mak                 |  49 --
 default-configs/ppc-softmmu.mak         |  12 +-
 default-configs/riscv32-softmmu.mak     |   9 +-
 default-configs/riscv64-softmmu.mak     |   8 +-
 default-configs/s390x-softmmu.mak       |   1 -
 default-configs/sh4-softmmu.mak         |   6 +-
 default-configs/sh4eb-softmmu.mak       |   6 +-
 default-configs/sound.mak               |   4 -
 default-configs/sparc-softmmu.mak       |   2 +
 default-configs/sparc64-softmmu.mak     |   5 +-
 default-configs/usb.mak                 |  11 -
 default-configs/virtio.mak              |  14 -
 default-configs/xtensa-softmmu.mak      |   3 +
 default-configs/xtensaeb-softmmu.mak    |   3 +
 hw/9pfs/Kconfig                         |   4 +
 hw/Kconfig                              |  62 +++
 hw/Makefile.objs                        |   4 +-
 hw/acpi/Kconfig                         |  30 ++
 hw/adc/Kconfig                          |   2 +
 hw/arm/Kconfig                          |  98 ++++
 hw/arm/Makefile.objs                    |   4 +-
 hw/audio/Kconfig                        |  52 ++
 hw/block/Kconfig                        |  37 ++
 hw/bt/Kconfig                           |   2 +
 hw/char/Kconfig                         |  42 ++
 hw/core/Kconfig                         |  11 +
 hw/cpu/Kconfig                          |   8 +
 hw/display/Kconfig                      | 106 ++++
 hw/display/Makefile.objs                |   4 +-
 hw/dma/Kconfig                          |  20 +
 hw/gpio/Kconfig                         |   9 +
 hw/hyperv/Kconfig                       |   9 +
 hw/i2c/Kconfig                          |  27 +
 hw/i2c/Makefile.objs                    |   7 +-
 hw/i386/Kconfig                         |  87 +++
 hw/i386/Makefile.objs                   |   4 +-
 hw/ide/Kconfig                          |  54 ++
 hw/input/Kconfig                        |  28 +
 hw/intc/Kconfig                         |  55 ++
 hw/ipack/Kconfig                        |   4 +
 hw/ipmi/Kconfig                         |  20 +
 hw/isa/Kconfig                          |  30 ++
 hw/lm32/Kconfig                         |   5 +
 hw/lm32/Makefile.objs                   |   4 +-
 hw/m68k/Kconfig                         |   8 +
 hw/m68k/Makefile.objs                   |   5 +-
 hw/mem/Kconfig                          |  10 +
 hw/microblaze/Kconfig                   |   8 +
 hw/microblaze/Makefile.objs             |   6 +-
 hw/mips/Kconfig                         |  20 +
 hw/mips/Makefile.objs                   |   6 +-
 hw/misc/Kconfig                         | 110 ++++
 hw/misc/macio/Kconfig                   |  11 +
 hw/net/Kconfig                          | 122 +++++
 hw/nios2/Kconfig                        |   2 +
 hw/nios2/Makefile.objs                  |   3 +-
 hw/nvram/Kconfig                        |   8 +
 hw/pci-bridge/Kconfig                   |  25 +
 hw/pci-host/Kconfig                     |  46 ++
 hw/pci-host/Makefile.objs               |   2 +-
 hw/pci/Kconfig                          |   5 +
 hw/pci/Makefile.objs                    |   5 +-
 hw/pcmcia/Kconfig                       |   2 +
 hw/ppc/Kconfig                          |  38 ++
 hw/ppc/Makefile.objs                    |  12 +-
 hw/riscv/Kconfig                        |  14 +
 hw/riscv/Makefile.objs                  |  22 +-
 hw/scsi/Kconfig                         |  52 ++
 hw/scsi/Makefile.objs                   |   2 +-
 hw/sd/Kconfig                           |  14 +
 hw/sh4/Kconfig                          |   8 +
 hw/sh4/Makefile.objs                    |   6 +-
 hw/smbios/Kconfig                       |   2 +
 hw/sparc/Kconfig                        |   5 +
 hw/sparc/Makefile.objs                  |   4 +-
 hw/sparc64/Kconfig                      |   5 +
 hw/sparc64/Makefile.objs                |   6 +-
 hw/ssi/Kconfig                          |  14 +
 hw/timer/Kconfig                        |  63 +++
 hw/tpm/Kconfig                          |  20 +
 hw/usb/Kconfig                          |  92 ++++
 hw/vfio/Kconfig                         |  11 +
 hw/virtio/Kconfig                       |  27 +
 hw/watchdog/Kconfig                     |  15 +
 hw/xtensa/Kconfig                       |   5 +
 hw/xtensa/Makefile.objs                 |   4 +-
 rules.mak                               |   2 +-
 scripts/make_device_config.sh           |  30 --
 scripts/minikconf.py                    | 680 ++++++++++++++++++++++++
 102 files changed, 2414 insertions(+), 260 deletions(-)
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
 create mode 100644 hw/arm/Kconfig
 create mode 100644 hw/audio/Kconfig
 create mode 100644 hw/block/Kconfig
 create mode 100644 hw/bt/Kconfig
 create mode 100644 hw/char/Kconfig
 create mode 100644 hw/core/Kconfig
 create mode 100644 hw/cpu/Kconfig
 create mode 100644 hw/display/Kconfig
 create mode 100644 hw/dma/Kconfig
 create mode 100644 hw/gpio/Kconfig
 create mode 100644 hw/hyperv/Kconfig
 create mode 100644 hw/i2c/Kconfig
 create mode 100644 hw/i386/Kconfig
 create mode 100644 hw/ide/Kconfig
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
 create mode 100644 hw/net/Kconfig
 create mode 100644 hw/nios2/Kconfig
 create mode 100644 hw/nvram/Kconfig
 create mode 100644 hw/pci-bridge/Kconfig
 create mode 100644 hw/pci-host/Kconfig
 create mode 100644 hw/pci/Kconfig
 create mode 100644 hw/pcmcia/Kconfig
 create mode 100644 hw/ppc/Kconfig
 create mode 100644 hw/riscv/Kconfig
 create mode 100644 hw/scsi/Kconfig
 create mode 100644 hw/sd/Kconfig
 create mode 100644 hw/sh4/Kconfig
 create mode 100644 hw/smbios/Kconfig
 create mode 100644 hw/sparc/Kconfig
 create mode 100644 hw/sparc64/Kconfig
 create mode 100644 hw/ssi/Kconfig
 create mode 100644 hw/timer/Kconfig
 create mode 100644 hw/tpm/Kconfig
 create mode 100644 hw/usb/Kconfig
 create mode 100644 hw/vfio/Kconfig
 create mode 100644 hw/virtio/Kconfig
 create mode 100644 hw/watchdog/Kconfig
 create mode 100644 hw/xtensa/Kconfig
 delete mode 100644 scripts/make_device_config.sh
 create mode 100644 scripts/minikconf.py

-- 
2.17.1
