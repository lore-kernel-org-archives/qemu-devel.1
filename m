Received: from eggs.gnu.org ([208.118.235.92]:54666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPG6-0002kw-Nd
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPG0-0003w2-V5
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:57843)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPG0-0003kp-DU
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:00 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:33:54 +0800
Message-Id: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 00/25] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

Happy Christmas && Happy New Year!

This Kconfig implementation is rebased from Paolo's branch
https://github.com/bonzini/qemu/commits/kconfig

I only rebased the x86 platform related arch and extended devices
definitions
https://github.com/yangzhon/qemu/commits/topic/upstream/Kconfig

The current RFC patches only support
(*) x86_64 platform
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

The current build command
(*) ./configure --target-list=x86_64-softmmu
(*) make


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

Yang Zhong (7):
  hw/display: make edid configurable
  edid: express dependencies with kconfig
  hyperv: express dependencies with kconfig
  virtio: make virtio dependencies with Kconfig
  i386-softmmu.mak: remove all CONFIG_* except boards definitions
  x86_64-softmmu.mak: remove i386-softmmu.mak include
  Makefile: only support defconfig

 Kconfig.host                       |  24 +
 Makefile                           |  19 +-
 Makefile.target                    |   7 +-
 default-configs/hyperv.mak         |   2 -
 default-configs/i386-softmmu.mak   |  72 +--
 default-configs/pci.mak            |  49 ---
 default-configs/sound.mak          |   4 -
 default-configs/usb.mak            |  11 -
 default-configs/x86_64-softmmu.mak |   6 +-
 hw/9pfs/Kconfig                    |   4 +
 hw/Kconfig                         |  50 +++
 hw/Makefile.objs                   |   4 +-
 hw/acpi/Kconfig                    |  26 ++
 hw/adc/Kconfig                     |   2 +
 hw/audio/Kconfig                   |  52 +++
 hw/block/Kconfig                   |  37 ++
 hw/bt/Kconfig                      |   2 +
 hw/char/Kconfig                    |  41 ++
 hw/core/Kconfig                    |  11 +
 hw/cpu/Kconfig                     |   8 +
 hw/display/Kconfig                 | 106 +++++
 hw/display/Makefile.objs           |   4 +-
 hw/dma/Kconfig                     |  20 +
 hw/gpio/Kconfig                    |   9 +
 hw/hyperv/Kconfig                  |   6 +
 hw/i2c/Kconfig                     |  27 ++
 hw/i2c/Makefile.objs               |   7 +-
 hw/i386/Kconfig                    |  99 +++++
 hw/i386/Makefile.objs              |   4 +-
 hw/ide/Kconfig                     |  53 +++
 hw/input/Kconfig                   |  28 ++
 hw/intc/Kconfig                    |  55 +++
 hw/ipack/Kconfig                   |   4 +
 hw/ipmi/Kconfig                    |  14 +
 hw/isa/Kconfig                     |  30 ++
 hw/mem/Kconfig                     |   8 +
 hw/misc/Kconfig                    | 106 +++++
 hw/misc/macio/Kconfig              |  11 +
 hw/net/Kconfig                     | 120 +++++
 hw/nvram/Kconfig                   |   8 +
 hw/pci-bridge/Kconfig              |  20 +
 hw/pci-host/Kconfig                |  44 ++
 hw/pci-host/Makefile.objs          |   2 +-
 hw/pci/Kconfig                     |   2 +
 hw/pcmcia/Kconfig                  |   2 +
 hw/scsi/Kconfig                    |  51 +++
 hw/scsi/Makefile.objs              |   2 +-
 hw/sd/Kconfig                      |  14 +
 hw/smbios/Kconfig                  |   2 +
 hw/ssi/Kconfig                     |  14 +
 hw/timer/Kconfig                   |  62 +++
 hw/tpm/Kconfig                     |  20 +
 hw/usb/Kconfig                     |  90 ++++
 hw/vfio/Kconfig                    |  11 +
 hw/virtio/Kconfig                  |  28 ++
 hw/watchdog/Kconfig                |  15 +
 rules.mak                          |   2 +-
 scripts/make_device_config.sh      |  30 --
 scripts/minikconf.py               | 682 +++++++++++++++++++++++++++++
 59 files changed, 2064 insertions(+), 179 deletions(-)
 create mode 100644 Kconfig.host
 delete mode 100644 default-configs/hyperv.mak
 delete mode 100644 default-configs/pci.mak
 delete mode 100644 default-configs/sound.mak
 delete mode 100644 default-configs/usb.mak
 create mode 100644 hw/9pfs/Kconfig
 create mode 100644 hw/Kconfig
 create mode 100644 hw/acpi/Kconfig
 create mode 100644 hw/adc/Kconfig
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
 create mode 100644 hw/mem/Kconfig
 create mode 100644 hw/misc/Kconfig
 create mode 100644 hw/misc/macio/Kconfig
 create mode 100644 hw/net/Kconfig
 create mode 100644 hw/nvram/Kconfig
 create mode 100644 hw/pci-bridge/Kconfig
 create mode 100644 hw/pci-host/Kconfig
 create mode 100644 hw/pci/Kconfig
 create mode 100644 hw/pcmcia/Kconfig
 create mode 100644 hw/scsi/Kconfig
 create mode 100644 hw/sd/Kconfig
 create mode 100644 hw/smbios/Kconfig
 create mode 100644 hw/ssi/Kconfig
 create mode 100644 hw/timer/Kconfig
 create mode 100644 hw/tpm/Kconfig
 create mode 100644 hw/usb/Kconfig
 create mode 100644 hw/vfio/Kconfig
 create mode 100644 hw/virtio/Kconfig
 create mode 100644 hw/watchdog/Kconfig
 delete mode 100644 scripts/make_device_config.sh
 create mode 100644 scripts/minikconf.py

-- 
2.17.1
