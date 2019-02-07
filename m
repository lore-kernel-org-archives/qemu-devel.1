Received: from eggs.gnu.org ([209.51.188.92]:57312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvs-0001to-K7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvq-0002BU-Pq
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:52 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvm-00024H-U3
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:48 -0500
Received: by mail-wr1-x443.google.com with SMTP id x10so802957wrs.8
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:56:43 +0100
Message-Id: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/51] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com, Aleksandar Markovic <amarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>

Now dropping RFC... Documentation is still lacking, but all targets except
ARM and MIPS are converted.  I'll let the respective maintainers decide what
timeframe they prefer.

defconfig and allnoconfig are supported as configure options, respectively
--with-default-devices (the default) and --without-default-devices.
Optional devices are listed in .mak files as commented-out "#CONFIG_FOO=n"
lines and marked as "imply" directives in Kconfig files.  ("Imply" is
new in this iteration).

For the previous discussions on the Kconfig design, see
http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02827.html

The first part, with the Makefile changes, has already been committed.
This is only the second part therefore, with the conversion.

The last patch is needed for now to support --without-default-devices
builds, but it will go away with the other pending patches to revamp
vhost configuration.

Summary of changes from v5:
- new directive "imply" for soft dependencies (really a "reverse
  default y if ..." that is placed under the condition symbol,
  used for PCI_DEVICES and TEST_DEVICES
- conversion of various boards
- TEST_DEVICES patch moved earlier
- new patches for various subsystems and boards
- tested Xen

I still have _not_ procesed Philippe's review though.

Paolo

Paolo Bonzini (39):
  minikconfig: add parser skeleton
  minikconfig: add AST
  minikconfig: add semantic analysis
  kconfig: introduce kconfig files
  build: switch to Kconfig
  minikconfig: implement allnoconfig and defconfig modes
  kconfig: introduce CONFIG_TEST_DEVICES
  ide: express dependencies with Kconfig
  build: convert pci.mak to Kconfig
  build: convert sound.mak to Kconfig
  build: convert usb.mak to Kconfig
  block: fix recursion in hw/block/dataplane
  scsi: express dependencies with Kconfig
  isa: express dependencies with kconfig
  i386: express dependencies with Kconfig
  i2c: express dependencies with Kconfig
  ptimer: express dependencies with Kconfig
  vfio: express vfio dependencies with Kconfig
  tpm: express dependencies with Kconfig
  isa: express SuperIO dependencies with Kconfig
  ssi: express dependencies with kconfig
  sd: express dependencies with kconfig
  ipmi: express dependencies with kconfig
  alpha-softmmu.mak: express dependencies with Kconfig
  cris-softmmu.mak: express dependencies with Kconfig
  hppa-softmmu.mak: express dependencies with Kconfig
  lm32-softmmu.mak: express dependencies with Kconfig
  m68k-softmmu.mak: express dependencies with Kconfig
  microblaze-softmmu.mak: express dependencies with Kconfig
  moxie-softmmu.mak: express dependencies with Kconfig
  nios2-softmmu.mak: express dependencies with Kconfig
  or1k-softmmu.mak: express dependencies with Kconfig
  sh4-softmmu.mak: express dependencies with Kconfig
  sparc-softmmu.mak: express dependencies with Kconfig
  sparc64-softmmu.mak: express dependencies with Kconfig
  unicore32-softmmu.mak: express dependencies with Kconfig
  xtensa-softmmu.mak: express dependencies with Kconfig
  .travis.yml: test that no-default-device builds do not regress
  FIXME vhost: add more stubs

Thomas Huth (6):
  ppc64: Express dependencies of 'pseries' and 'powernv' machines with
    kconfig
  ppc: Express dependencies of the 'prep' and '40p' machines with
    kconfig
  ppc: Express dependencies of the Mac machines with kconfig
  ppc: Express dependencies of the Sam460EX machines with kconfig
  ppc: Express dependencies of the embedded machines with kconfig
  s390x: express dependencies with Kconfig

Yang Zhong (6):
  hw/display: make edid configurable
  hw/pci/Makefile.objs: make pcie configurable
  display: express dependencies with kconfig
  hyperv: express dependencies with kconfig
  virtio: express virtio dependencies with Kconfig
  i386-softmmu.mak: remove all CONFIG_* except boards definitions

 .travis.yml                             |   6 +
 Kconfig.host                            |  27 ++
 Makefile                                |  25 +-
 Makefile.target                         |   7 +-
 configure                               |  18 +-
 default-configs/alpha-softmmu.mak       |  26 +-
 default-configs/arm-softmmu.mak         |  15 +-
 default-configs/cris-softmmu.mak        |   6 +-
 default-configs/hppa-softmmu.mak        |  20 +-
 default-configs/hyperv.mak              |   2 -
 default-configs/i386-softmmu.mak        |  93 ++---
 default-configs/lm32-softmmu.mak        |  12 +-
 default-configs/m68k-softmmu.mak        |   4 +-
 default-configs/microblaze-softmmu.mak  |  12 +-
 default-configs/mips-softmmu-common.mak |  10 +-
 default-configs/mips64el-softmmu.mak    |   2 +
 default-configs/moxie-softmmu.mak       |   7 +-
 default-configs/nios2-softmmu.mak       |   6 +-
 default-configs/or1k-softmmu.mak        |   5 +-
 default-configs/pci.mak                 |  51 ---
 default-configs/ppc-softmmu.mak         |  60 ---
 default-configs/ppc64-softmmu.mak       |  13 -
 default-configs/riscv32-softmmu.mak     |   6 +-
 default-configs/riscv64-softmmu.mak     |   6 +-
 default-configs/s390x-softmmu.mak       |  23 +-
 default-configs/sh4-softmmu.mak         |  28 +-
 default-configs/sh4eb-softmmu.mak       |  22 +-
 default-configs/sound.mak               |   4 -
 default-configs/sparc-softmmu.mak       |  24 +-
 default-configs/sparc64-softmmu.mak     |  25 +-
 default-configs/unicore32-softmmu.mak   |   6 +-
 default-configs/usb.mak                 |  11 -
 default-configs/virtio.mak              |  15 -
 default-configs/xtensa-softmmu.mak      |   6 +-
 default-configs/xtensaeb-softmmu.mak    |   7 +-
 docs/devel/build-system.txt             |   1 -
 hw/9pfs/Kconfig                         |   6 +
 hw/Kconfig                              |  73 ++++
 hw/Makefile.objs                        |   2 +-
 hw/acpi/Kconfig                         |  29 ++
 hw/adc/Kconfig                          |   2 +
 hw/alpha/Kconfig                        |  12 +
 hw/arm/Kconfig                          | 123 ++++++
 hw/audio/Kconfig                        |  52 +++
 hw/block/Kconfig                        |  39 ++
 hw/block/Makefile.objs                  |   3 +-
 hw/block/dataplane/Makefile.objs        |   2 +-
 hw/bt/Kconfig                           |   2 +
 hw/char/Kconfig                         |  42 ++
 hw/core/Kconfig                         |  11 +
 hw/cpu/Kconfig                          |   8 +
 hw/cris/Kconfig                         |   9 +
 hw/display/Kconfig                      | 108 +++++
 hw/display/Makefile.objs                |   4 +-
 hw/dma/Kconfig                          |  21 +
 hw/gpio/Kconfig                         |   9 +
 hw/hppa/Kconfig                         |  10 +
 hw/hyperv/Kconfig                       |   8 +
 hw/i2c/Kconfig                          |  27 ++
 hw/i2c/Makefile.objs                    |   2 +-
 hw/i386/Kconfig                         | 100 +++++
 hw/i386/Makefile.objs                   |   5 +-
 hw/ide/Kconfig                          |  54 +++
 hw/input/Kconfig                        |  33 ++
 hw/intc/Kconfig                         |  57 +++
 hw/ipack/Kconfig                        |   4 +
 hw/ipmi/Kconfig                         |  22 +
 hw/isa/Kconfig                          |  53 +++
 hw/lm32/Kconfig                         |  13 +
 hw/m68k/Kconfig                         |   9 +
 hw/mem/Kconfig                          |  11 +
 hw/microblaze/Kconfig                   |  20 +
 hw/mips/Kconfig                         |  21 +
 hw/misc/Kconfig                         | 118 ++++++
 hw/misc/macio/Kconfig                   |  11 +
 hw/moxie/Kconfig                        |   3 +
 hw/net/Kconfig                          | 125 ++++++
 hw/nios2/Kconfig                        |   8 +
 hw/nvram/Kconfig                        |   9 +
 hw/openrisc/Kconfig                     |   5 +
 hw/pci-bridge/Kconfig                   |  29 ++
 hw/pci-host/Kconfig                     |  51 +++
 hw/pci/Kconfig                          |   9 +
 hw/pci/Makefile.objs                    |   9 +-
 hw/pcmcia/Kconfig                       |   2 +
 hw/ppc/Kconfig                          | 121 ++++++
 hw/riscv/Kconfig                        |  20 +
 hw/s390x/Kconfig                        |  11 +
 hw/s390x/Makefile.objs                  |   4 +-
 hw/scsi/Kconfig                         |  54 +++
 hw/scsi/Makefile.objs                   |   2 +-
 hw/sd/Kconfig                           |  17 +
 hw/sh4/Kconfig                          |  23 ++
 hw/smbios/Kconfig                       |   2 +
 hw/sparc/Kconfig                        |  26 ++
 hw/sparc64/Kconfig                      |  19 +
 hw/ssi/Kconfig                          |  18 +
 hw/timer/Kconfig                        |  63 +++
 hw/tpm/Kconfig                          |  25 ++
 hw/tricore/Kconfig                      |   2 +
 hw/unicore32/Kconfig                    |   5 +
 hw/usb/Kconfig                          |  91 +++++
 hw/usb/Makefile.objs                    |   2 +-
 hw/vfio/Kconfig                         |  36 ++
 hw/virtio/Kconfig                       |  31 ++
 hw/virtio/vhost-stub.c                  |  58 +++
 hw/watchdog/Kconfig                     |  16 +
 hw/xtensa/Kconfig                       |   8 +
 rules.mak                               |   2 +-
 scripts/make_device_config.sh           |  30 --
 scripts/minikconf.py                    | 700 ++++++++++++++++++++++++++++++++
 111 files changed, 2917 insertions(+), 465 deletions(-)
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
