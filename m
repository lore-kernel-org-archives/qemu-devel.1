Received: from eggs.gnu.org ([2001:4830:134:3::10]:51488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7BZ-0004PF-P6
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7BW-0005ln-Nq
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7BW-0005kp-F5
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:05 -0300
Message-Id: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 00/19] sysbus: Don't allow -device/device_add by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

This series refactor the cannot_instantiate_with_device_add code
for sysbus. First, cannot_instantiate_with_device_add is
replaced by !user_creatable. Then, we change TYPE_SYS_BUS_DEVICE
to set user_creatable=false by default, while keeping the
existing devices that are not rejected by -device with
user_creatable=true.

Then, the rest of the series remove user_creatable=true from most
of the device classes, each by a separate patch so the changes on
each device can be reviewed separatedly.

In the end of this series, the only remaining sysbus devices
creatable using -device/device_add will be:

On arm:
* vfio-amd-xgbe
* vfio-calxeda-xgmac
* vfio-amd-xgbe
* vfio-calxeda-xgmac

On x86:
* amd-iommu
* intel-iommu

On ppc:
* spapr-pci-host-bridge
* spapr-pci-vfio-host-bridge
* eTSEC

Cc: Alexander Graf <agraf@suse.de>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

Eduardo Habkost (19):
  qdev: Replace cannot_instantiate_with_device_add_yet with
    !user_creatable
  s390: Add FIXME for unexplained user_creatable=false line
  sysbus: Set user_creatable=false by default on TYPE_SYS_BUS_DEVICE
  fdc: Remove user_creatable flag from sysbus-fdc & SUNW,fdtwo
  pflash_cfi01: Remove user_creatable flag
  iommu: Remove FIXME comment about user_creatable=true
  kvmclock: Remove user_creatable flag
  ioapic: Remove user_creatable flag
  kvmvapic: Remove user_creatable flag
  sysbus-ahci: Remove user_creatable flag
  allwinner-ahci: Remove user_creatable flag
  isabus-bridge: Remove user_creatable flag
  unimplemented-device: Remove user_creatable flag
  fw_cfg: Remove user_creatable flag
  esp: Remove user_creatable flag
  generic-sdhci: Remove user_creatable flag
  hpet: Remove user_creatable flag
  sysbus-ohci: Remove user_creatable flag
  virtio-mmio: Remove user_creatable flag

 include/hw/qdev-core.h              | 10 +++++-----
 include/hw/qdev-properties.h        |  4 ++--
 hw/acpi/piix4.c                     |  2 +-
 hw/arm/spitz.c                      |  2 +-
 hw/audio/marvell_88w8618.c          |  2 +-
 hw/audio/pcspk.c                    |  2 +-
 hw/core/or-irq.c                    |  2 +-
 hw/core/qdev.c                      |  1 +
 hw/core/register.c                  |  2 +-
 hw/core/sysbus.c                    | 11 +++++++++++
 hw/dma/i8257.c                      |  2 +-
 hw/dma/sparc32_dma.c                |  2 +-
 hw/gpio/omap_gpio.c                 |  4 ++--
 hw/i2c/omap_i2c.c                   |  2 +-
 hw/i2c/smbus_eeprom.c               |  2 +-
 hw/i2c/smbus_ich9.c                 |  2 +-
 hw/i386/amd_iommu.c                 |  1 +
 hw/i386/intel_iommu.c               |  1 +
 hw/i386/pc.c                        |  2 +-
 hw/input/vmmouse.c                  |  2 +-
 hw/intc/apic_common.c               |  2 +-
 hw/intc/etraxfs_pic.c               |  2 +-
 hw/intc/grlib_irqmp.c               |  2 +-
 hw/intc/i8259_common.c              |  2 +-
 hw/intc/nios2_iic.c                 |  2 +-
 hw/intc/omap_intc.c                 |  4 ++--
 hw/isa/lpc_ich9.c                   |  2 +-
 hw/isa/piix4.c                      |  2 +-
 hw/isa/vt82c686.c                   |  2 +-
 hw/mips/gt64xxx_pci.c               |  2 +-
 hw/misc/vmport.c                    |  2 +-
 hw/net/dp8393x.c                    |  2 +-
 hw/net/etraxfs_eth.c                |  2 +-
 hw/net/fsl_etsec/etsec.c            |  1 +
 hw/net/lance.c                      |  2 +-
 hw/pci-bridge/dec.c                 |  2 +-
 hw/pci-bridge/pci_expander_bridge.c |  2 +-
 hw/pci-host/apb.c                   |  2 +-
 hw/pci-host/bonito.c                |  2 +-
 hw/pci-host/gpex.c                  |  2 +-
 hw/pci-host/grackle.c               |  2 +-
 hw/pci-host/piix.c                  |  6 +++---
 hw/pci-host/ppce500.c               |  2 +-
 hw/pci-host/prep.c                  |  2 +-
 hw/pci-host/q35.c                   |  4 ++--
 hw/pci-host/uninorth.c              |  8 ++++----
 hw/pci-host/versatile.c             |  2 +-
 hw/pci-host/xilinx-pcie.c           |  2 +-
 hw/ppc/ppc4xx_pci.c                 |  2 +-
 hw/ppc/spapr_drc.c                  |  2 +-
 hw/ppc/spapr_pci.c                  |  1 +
 hw/s390x/s390-pci-bus.c             |  2 +-
 hw/sd/milkymist-memcard.c           |  2 +-
 hw/sd/pl181.c                       |  2 +-
 hw/sh4/sh_pci.c                     |  2 +-
 hw/timer/i8254_common.c             |  2 +-
 hw/timer/mc146818rtc.c              |  2 +-
 hw/vfio/amd-xgbe.c                  |  1 +
 hw/vfio/calxeda-xgmac.c             |  1 +
 monitor.c                           |  2 +-
 qdev-monitor.c                      |  6 +++---
 qom/cpu.c                           |  2 +-
 target/i386/cpu.c                   |  2 +-
 63 files changed, 88 insertions(+), 70 deletions(-)

-- 
2.11.0.259.g40922b1
