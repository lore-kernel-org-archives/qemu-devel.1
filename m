Received: from eggs.gnu.org ([2001:4830:134:3::10]:43235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV0I-0001Yq-D9
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV0F-0002aH-7U
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:24:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cvV0E-0002Zr-U0
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:24:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  4 Apr 2017 17:24:08 -0300
Message-Id: <20170404202429.14643-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/21] qdev/sysbus: Set user_creatable=false
 by default on sysbus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>

Changes v1 -> v2
----------------

* Rewrote series name and cover letter completely to not pretend
  we're fixing the q35 lack-of-sysbus-whitelist bug, and explain
  the motivation for the series.
  * Previous series name was:
    "sysbus: Don't allow -device/device_add by default"
  * Rewrote description of patch 02/21, too
  * (I really hope people read this cover letter before
    commenting on individual patches.)
* Rewrote FIXME comments to make it clear that we just set
  user_creatable=3Dtrue temporarily because we don't know yet if
  the device should be in the q35 whitelist.
* Set user_creatable=3Dtrue on xen-backend also
  (I didn't notice it was missing because I was building QEMU
  without xen support)
  * New patches:
    * "xen-backend: Remove FIXME comment about user_creatable flag"
    * "xen-sysdev: Remove user_creatable flag"
* Patch:
    "s390: Add FIXME for unexplained user_creatable=3Dfalse line"
  replaced with:
    "s390-pcibus: No need to set user_creatable=3Dfalse explicitly"

Description
-----------

This series refactor the cannot_instantiate_with_device_add code
for sysbus. First, the cannot_instantiate_with_device_add field
is replaced by !user_creatable.

Then, we change TYPE_SYS_BUS_DEVICE to set user_creatable=3Dfalse
by default, and we set user_creatable=3Dtrue explicitly only on the
devices that are really supposed to be user-creatable on some
machines.

Motivation
----------

First of all, this makes the code less fragile: setting
user_creatable=3Dfalse or cannot_instantiate_with_device_add=3Dtrue
on all sysbus devices is incorrect, and makes code that looks at
cannot_instantiate_with_device_add/user_creatable easy to break.

This also fixes a regression introduced by commit
33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31, that makes all sysbus
devices appear on "-device help" and lack the "no-user" flag on
"info qdm"[1].

This will also make it possible for automatic test code (like the
device-crash-test.py script I sent a while ago[2]) skip devices
that are not supposed to be user-creatable on any machine.

A note about the lack of sysbus whitelist on q35
------------------------------------------------

This series won't make the per-machine whitelist of sysbus
devices unnecessary, but just makes the user_creatable field
consistent on the sys-bus-device classes. This means q35 and xen
still need to be fixed to implemented a sysbus device whitelist.

However, despite not being strictly necessary for fixing the q35
bug, reducing the list of user_creatable=3Dtrue devices will help
us be more confident when building the q35 whitelist.

Full list of user_creatable=3Dtrue sysbus devices
-----------------------------------------------

In the end of this series, the only remaining sysbus devices with
user_creatable=3Dtrue will be:

* vfio-amd-xgbe (arm)
* vfio-calxeda-xgmac (arm)
* amd-iommu (x86)
* intel-iommu (x86)
* xen-backend (x86)
* spapr-pci-host-bridge (ppc)
* spapr-pci-vfio-host-bridge (ppc)
* eTSEC (ppc)

References/Notes
----------------

[1] For example, before this series, we had 174 sysbus devices
    listed on qemu-system-arm -device help:
      $ qemu-system-arm -machine none -device help 2>&1 | grep 'bus Syste=
m' | wc -l
      174
      $
    after this series, we now have:
      $ ./arm-softmmu/qemu-system-arm -machine none -device help 2>&1 | g=
rep 'bus System'
      name "vfio-amd-xgbe", bus System, desc "VFIO AMD XGBE"
      name "vfio-calxeda-xgmac", bus System, desc "VFIO Calxeda XGMAC"
      $

[2] Subject: [PATCH 0/3] script for crash-testing -device

---
Cc: Alexander Graf <agraf@suse.de>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

Eduardo Habkost (21):
  qdev: Replace cannot_instantiate_with_device_add_yet with
    !user_creatable
  sysbus: Set user_creatable=3Dfalse by default on TYPE_SYS_BUS_DEVICE
  xen-backend: Remove FIXME comment about user_creatable flag
  iommu: Remove FIXME comment about user_creatable=3Dtrue
  fdc: Remove user_creatable flag from sysbus-fdc & SUNW,fdtwo
  pflash_cfi01: Remove user_creatable flag
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
  xen-sysdev: Remove user_creatable flag
  s390-pcibus: No need to set user_creatable=3Dfalse explicitly

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
 hw/i386/amd_iommu.c                 |  2 ++
 hw/i386/intel_iommu.c               |  2 ++
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
 hw/net/fsl_etsec/etsec.c            |  2 ++
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
 hw/ppc/spapr_pci.c                  |  2 ++
 hw/s390x/s390-pci-bus.c             |  1 -
 hw/sd/milkymist-memcard.c           |  2 +-
 hw/sd/pl181.c                       |  2 +-
 hw/sh4/sh_pci.c                     |  2 +-
 hw/timer/i8254_common.c             |  2 +-
 hw/timer/mc146818rtc.c              |  2 +-
 hw/vfio/amd-xgbe.c                  |  2 ++
 hw/vfio/calxeda-xgmac.c             |  2 ++
 hw/xen/xen_backend.c                |  2 ++
 monitor.c                           |  2 +-
 qdev-monitor.c                      |  6 +++---
 qom/cpu.c                           |  2 +-
 target/i386/cpu.c                   |  2 +-
 64 files changed, 95 insertions(+), 70 deletions(-)

--=20
2.11.0.259.g40922b1
