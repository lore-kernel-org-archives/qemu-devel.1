Received: from eggs.gnu.org ([2001:4830:134:3::10]:40610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ48-00046i-1H
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ44-0002gs-TD
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:40:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:39:40 -0300
Message-Id: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/34] remove i386/pc dependency from non-PC
 world (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi,

quite a bunch of patches and files modified, but the diffstat is not that big.

First part is from clean-includes script,
Then comes code movement, about no logical changes.

Now some non-x86 builds and cocci spatch run a bit faster :)

I updated some MAINTAINERS entries while here.

Also I couldn't test the KVM/XEN/HAX part.

Regards,

Phil.

Philippe Mathieu-Daudé (34):
  hw: use "qemu/osdep.h" as first #include in source files
  hw: remove "qemu/osdep.h" from header files
  block: remove "qemu/osdep.h" from header file
  misc: remove headers implicitly included
  misc: remove duplicated includes
  ppc: remove duplicated includes
  i386/hax: remove duplicated includes
  nios2: remove duplicated includes
  misc: avoid "include/" in include path
  amd_iommu: avoid needless includes in header file
  i386/pc: use TYPE_PORT92
  misc: remove old i386 dependency
  hw/ide: remove old i386 dependency
  hw/ipmi: remove old i386 dependency
  hw/i2c: remove old i386 dependency
  hw/tpm: remove old i386 dependency
  hw/virtio-balloon: remove old i386 dependency
  hw/unicore32: restrict hw addr defines to source file
  hw/acpi: ACPI_PM_* defines are not restricted to i386 arch
  hw/timer/i8254: rename pit_init() -> i8254_pit_init()
  hw/display/vga: remove the old i386/pc dependency
  hw/input/i8042: extract API from hw/i386/pc.h
  hw/dma/i8257: rename DMA_init() to i8257_dma_init()
  hw/timer/mc146818: rename rtc_init() -> mc146818_init()
  hw/timer/m48t59: use TYPE_M48T59_ISA, add entries to MAINTAINERS
  hw/net/ne2000: extract ne2k-isa code from i386/pc to ne2000-isa.c
  hw/pci: declare pci_nic_init_nofail() in "hw/net/pci.h"
  hw/net/e1000: use TYPE_PCI_E1000
  hw/net/e1000e: use TYPE_PCI_E1000E
  hw/net/pcnet: use TYPE_PCI_PCNET
  hw/net/rtl8139: use TYPE_PCI_RTL8139
  hw/net/ne2000: use TYPE_PCI_NE2000
  hw/alpha: remove old i386 dependency
  misc: drop old i386 dependency

 block/dmg.h                                 |  1 -
 hw/alpha/alpha_sys.h                        |  2 -
 hw/audio/fmopl.h                            |  1 -
 hw/display/vga_int.h                        |  3 +-
 hw/display/{vga.h => vga_int_regs.h}        |  0
 hw/i386/amd_iommu.h                         |  5 --
 hw/net/ne2000.h                             |  3 ++
 hw/pci/pci_internal.h                       | 16 ++++++
 include/hw/acpi/acpi.h                      | 12 +++++
 include/hw/acpi/ipmi.h                      |  1 -
 include/hw/cpu/core.h                       |  1 -
 include/hw/display/vga.h                    | 25 ++++++++++
 include/hw/{isa/i8257.h => dma/i8257_dma.h} |  6 +++
 include/hw/i2c/ppc4xx_i2c.h                 |  1 -
 include/hw/i386/pc.h                        | 56 ---------------------
 include/hw/input/i8042.h                    | 30 +++++++++++
 include/hw/isa/isa.h                        |  2 -
 include/hw/net/ne2000-isa.h                 | 33 +++++++++++++
 include/hw/net/pci.h                        | 26 ++++++++++
 include/hw/pci/pci.h                        |  4 --
 include/hw/timer/i8254.h                    |  5 +-
 include/hw/timer/i8254_internal.h           |  2 +-
 include/hw/timer/m48t59.h                   |  2 +
 include/hw/timer/mc146818rtc.h              |  3 +-
 include/hw/unicore32/puv3.h                 | 10 ----
 include/sysemu/hax.h                        |  1 -
 target/i386/hax-darwin.h                    |  3 --
 target/i386/hax-windows.h                   |  2 -
 target/nios2/cpu.h                          |  1 -
 accel/tcg/translate-all.c                   |  1 -
 bsd-user/main.c                             |  1 -
 chardev/wctablet.c                          |  4 --
 disas/nios2.c                               |  3 --
 exec.c                                      |  3 --
 hw/acpi/ipmi-stub.c                         |  1 +
 hw/alpha/dp264.c                            | 10 ++--
 hw/alpha/pci.c                              |  2 +
 hw/alpha/typhoon.c                          |  2 +-
 hw/arm/realview.c                           |  3 +-
 hw/arm/spitz.c                              |  1 -
 hw/arm/versatilepb.c                        |  3 +-
 hw/arm/virt.c                               |  1 +
 hw/audio/fmopl.c                            |  1 -
 hw/audio/pcspk.c                            |  1 -
 hw/char/debugcon.c                          |  1 -
 hw/char/xen_console.c                       |  1 -
 hw/core/machine.c                           |  1 -
 hw/cpu/core.c                               |  1 +
 hw/display/vga-isa-mm.c                     |  4 +-
 hw/display/vga-isa.c                        |  2 +-
 hw/display/vga.c                            |  4 +-
 hw/dma/i82374.c                             |  3 +-
 hw/dma/i8257.c                              |  4 +-
 hw/i2c/pm_smbus.c                           |  1 -
 hw/i2c/smbus_ich9.c                         |  1 -
 hw/i386/amd_iommu.c                         |  5 +-
 hw/i386/kvm/pci-assign.c                    |  1 -
 hw/i386/pc.c                                | 18 ++++---
 hw/i386/pci-assign-load-rom.c               |  1 -
 hw/i386/xen/xen_platform.c                  |  1 -
 hw/ide/ahci.c                               |  1 -
 hw/ide/cmd646.c                             |  1 -
 hw/ide/core.c                               |  3 +-
 hw/ide/ich.c                                |  1 -
 hw/ide/isa.c                                |  1 -
 hw/ide/microdrive.c                         |  1 -
 hw/ide/pci.c                                |  1 -
 hw/ide/piix.c                               |  2 +-
 hw/ide/via.c                                |  1 -
 hw/input/adb.c                              |  2 +-
 hw/input/pckbd.c                            |  2 +-
 hw/input/vmmouse.c                          |  3 +-
 hw/intc/lm32_pic.c                          |  1 -
 hw/ipmi/isa_ipmi_bt.c                       |  1 -
 hw/ipmi/isa_ipmi_kcs.c                      |  1 -
 hw/isa/i82378.c                             |  5 +-
 hw/isa/vt82c686.c                           |  1 -
 hw/mips/mips_fulong2e.c                     | 13 +++--
 hw/mips/mips_jazz.c                         |  9 ++--
 hw/mips/mips_malta.c                        | 13 +++--
 hw/mips/mips_r4k.c                          |  8 +--
 hw/misc/ivshmem.c                           |  1 -
 hw/misc/sga.c                               |  1 -
 hw/misc/vmport.c                            |  1 +
 hw/moxie/moxiesim.c                         |  1 -
 hw/net/e1000e.c                             |  6 +--
 hw/net/ne2000-isa.c                         |  6 +--
 hw/net/ne2000.c                             |  5 +-
 hw/net/pcnet-pci.c                          |  3 +-
 hw/net/rtl8139.c                            |  7 ++-
 hw/nios2/boot.c                             |  1 -
 hw/pci-bridge/pci_expander_bridge.c         |  1 -
 hw/pci/pci.c                                | 67 +------------------------
 hw/pci/pci_nic.c                            | 77 +++++++++++++++++++++++++++++
 hw/ppc/e500.c                               |  1 +
 hw/ppc/mac_newworld.c                       |  3 +-
 hw/ppc/mac_oldworld.c                       |  3 +-
 hw/ppc/pnv.c                                |  2 +-
 hw/ppc/ppc440_bamboo.c                      |  3 +-
 hw/ppc/prep.c                               | 13 +++--
 hw/ppc/spapr.c                              |  1 +
 hw/ppc/spapr_cpu_core.c                     |  1 +
 hw/ppc/spapr_hcall.c                        |  1 -
 hw/s390x/css.c                              |  1 -
 hw/scsi/vhost-user-scsi.c                   |  1 -
 hw/sh4/r2d.c                                |  5 +-
 hw/smbios/smbios_type_38-stub.c             |  1 +
 hw/sparc/sun4m.c                            |  5 --
 hw/sparc64/sun4u.c                          | 10 ++--
 hw/ssi/aspeed_smc.c                         |  3 +-
 hw/timer/i8254.c                            |  1 -
 hw/timer/i8254_common.c                     |  1 -
 hw/timer/m48t59-isa.c                       |  2 +-
 hw/timer/mc146818rtc.c                      |  2 +-
 hw/tpm/tpm_passthrough.c                    |  1 -
 hw/tpm/tpm_tis.c                            |  1 -
 hw/unicore32/puv3.c                         | 17 ++++---
 hw/vfio/ccw.c                               |  2 +-
 hw/virtio/vhost-vsock.c                     |  2 +-
 hw/virtio/virtio-balloon.c                  |  2 +-
 hw/watchdog/wdt_ib700.c                     |  1 -
 linux-user/main.c                           |  1 -
 monitor.c                                   |  1 -
 net/colo-compare.c                          |  1 -
 numa.c                                      |  1 -
 target/i386/hax-darwin.c                    |  8 +--
 target/nios2/helper.c                       |  7 +--
 target/nios2/op_helper.c                    |  1 +
 target/nios2/translate.c                    |  1 +
 target/openrisc/exception_helper.c          |  1 -
 target/ppc/kvm.c                            |  3 --
 tests/test-aio-multithread.c                |  1 -
 tests/test-clone-visitor.c                  |  1 -
 tests/vhost-user-test.c                     |  1 -
 tests/vmgenid-test.c                        |  3 --
 util/qemu-sockets.c                         |  1 -
 vl.c                                        |  3 +-
 hw/pci/Makefile.objs                        |  1 +
 MAINTAINERS                                 | 13 ++++-
 139 files changed, 389 insertions(+), 337 deletions(-)
 rename hw/display/{vga.h => vga_int_regs.h} (100%)
 create mode 100644 hw/pci/pci_internal.h
 create mode 100644 include/hw/display/vga.h
 rename include/hw/{isa/i8257.h => dma/i8257_dma.h} (86%)
 create mode 100644 include/hw/input/i8042.h
 create mode 100644 include/hw/net/ne2000-isa.h
 create mode 100644 include/hw/net/pci.h
 create mode 100644 hw/pci/pci_nic.c

-- 
2.14.1
