Received: from eggs.gnu.org ([2001:4830:134:3::10]:54026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctK0n-0006e0-Hk
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctK0i-0007P5-Et
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:16:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctK0i-0007Mw-5D
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:16:04 -0400
Date: Wed, 29 Mar 2017 17:16:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170329201600.GC3709@thinpad.lan.raisama.net>
References: <20170329194148.19015-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170329194148.19015-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 0/9] qom: Make
 object_get_class()/*_GET_CLASS return const pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Juergen Gross <jgross@suse.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Wed, Mar 29, 2017 at 04:41:39PM -0300, Eduardo Habkost wrote:
[...]
> Eduardo Habkost (9):
>   configure: test if _Generic works as expected
>   Simplify code using *MACHINE_GET_CLASS
>   qom: QUALIFIED_CAST helper macro
>   qom: Make object_class_get_parent() const-aware
>   Make class parameter const at some functions
>   Explicitly cast the *_GET_CLASS() value when we break the rules
>   Use const variables for *_GET_CLASS values

In case patch 7/9 never gets delivered to the list because of its
size, below is the commit message, containing a Coccinelle
script.

Git tree is available at:
  git://github.com/ehabkost/qemu-hacks.git work/const-classes


"""
Use const variables for the return value of *_GET_CLASS and
object_get_class(). This will allow us to make *_GET_CLASS and
object_get_class() return const pointers later.

Most of the changes were generated using the following Coccinelle
script, but some additional cases had to be udpated by hand after
running the script.

  @@
  type XClass;
  identifier oc;
  identifier X_GET_CLASS =~ ".*_GET_CLASS|object_get_class";
  @@
  -XClass *oc;
  +const XClass *oc;
   <+...
   oc = X_GET_CLASS(...);
   ...+>

  @@
  type XClass;
  identifier oc;
  identifier X_GET_CLASS =~ ".*_GET_CLASS|object_get_class";
  @@
  +const
   XClass *oc = X_GET_CLASS(...);
"""

>   qom: Make class cast macros/functions const-aware
>   qom: Make object_get_class() return const pointer
> 
>  configure                       | 20 +++++++++
>  include/qom/cpu.h               | 12 +++---
>  include/qom/object.h            | 94 ++++++++++++++++++++++++++++++++++-------
>  target/ppc/mmu-book3s-v3.h      |  2 +-
>  target/ppc/mmu-hash64.h         |  2 +-
>  target/s390x/cpu.h              |  2 +-
>  backends/cryptodev.c            | 10 ++---
>  backends/hostmem.c              |  2 +-
>  backends/rng.c                  |  4 +-
>  backends/tpm.c                  | 28 ++++++------
>  chardev/char-mux.c              |  2 +-
>  chardev/char.c                  | 10 ++---
>  cpu-exec.c                      | 14 +++---
>  device-hotplug.c                |  2 +-
>  disas.c                         |  4 +-
>  exec.c                          |  6 +--
>  gdbstub.c                       | 12 +++---
>  hmp.c                           |  4 +-
>  hw/acpi/acpi_interface.c        |  2 +-
>  hw/acpi/cpu.c                   |  8 ++--
>  hw/acpi/cpu_hotplug.c           |  4 +-
>  hw/acpi/ipmi.c                  |  2 +-
>  hw/acpi/memory_hotplug.c        |  2 +-
>  hw/acpi/nvdimm.c                |  4 +-
>  hw/acpi/pcihp.c                 |  4 +-
>  hw/arm/aspeed.c                 |  2 +-
>  hw/arm/aspeed_soc.c             |  4 +-
>  hw/arm/boot.c                   |  2 +-
>  hw/arm/exynos4_boards.c         |  2 +-
>  hw/arm/vexpress.c               |  2 +-
>  hw/arm/virt-acpi-build.c        |  6 +--
>  hw/arm/virt.c                   |  6 +--
>  hw/audio/cs4231a.c              | 10 ++---
>  hw/audio/gus.c                  |  6 +--
>  hw/audio/intel-hda.c            |  8 ++--
>  hw/audio/sb16.c                 |  6 +--
>  hw/block/dataplane/virtio-blk.c |  6 +--
>  hw/block/fdc.c                  |  8 ++--
>  hw/block/m25p80.c               |  2 +-
>  hw/char/serial-pci.c            |  2 +-
>  hw/char/virtio-console.c        |  6 +--
>  hw/char/virtio-serial-bus.c     | 18 ++++----
>  hw/core/bus.c                   |  4 +-
>  hw/core/fw-path-provider.c      |  2 +-
>  hw/core/generic-loader.c        |  2 +-
>  hw/core/hotplug.c               |  8 ++--
>  hw/core/loader.c                |  4 +-
>  hw/core/machine.c               |  5 +--
>  hw/core/nmi.c                   |  2 +-
>  hw/core/qdev-properties.c       |  4 +-
>  hw/core/qdev.c                  | 32 +++++++-------
>  hw/core/stream.c                |  4 +-
>  hw/core/sysbus.c                |  6 +--
>  hw/display/cirrus_vga.c         |  2 +-
>  hw/i2c/core.c                   | 10 ++---
>  hw/i2c/smbus.c                  |  8 ++--
>  hw/i386/acpi-build.c            | 16 +++----
>  hw/i386/kvm/i8254.c             |  2 +-
>  hw/i386/kvm/i8259.c             |  2 +-
>  hw/i386/pc.c                    | 32 +++++++-------
>  hw/i386/pc_piix.c               |  4 +-
>  hw/i386/pc_q35.c                |  4 +-
>  hw/i386/x86-iommu.c             |  2 +-
>  hw/ide/microdrive.c             |  4 +-
>  hw/ide/qdev.c                   |  2 +-
>  hw/input/adb.c                  |  6 +--
>  hw/input/virtio-input.c         | 12 +++---
>  hw/intc/apic_common.c           | 26 ++++++------
>  hw/intc/arm_gic.c               |  2 +-
>  hw/intc/arm_gic_common.c        |  4 +-
>  hw/intc/arm_gic_kvm.c           |  4 +-
>  hw/intc/arm_gicv3.c             |  2 +-
>  hw/intc/arm_gicv3_common.c      |  4 +-
>  hw/intc/arm_gicv3_its_common.c  |  6 +--
>  hw/intc/arm_gicv3_kvm.c         |  4 +-
>  hw/intc/i8259.c                 |  2 +-
>  hw/intc/i8259_common.c          |  4 +-
>  hw/intc/ioapic_common.c         |  6 +--
>  hw/intc/xics.c                  | 26 ++++++------
>  hw/ipack/ipack.c                |  4 +-
>  hw/ipack/tpci200.c              | 12 +++---
>  hw/ipmi/ipmi_bmc_extern.c       | 12 +++---
>  hw/ipmi/ipmi_bmc_sim.c          | 24 +++++------
>  hw/ipmi/isa_ipmi_bt.c           | 22 +++++-----
>  hw/ipmi/isa_ipmi_kcs.c          | 20 ++++-----
>  hw/mem/pc-dimm.c                | 10 ++---
>  hw/mips/mips_jazz.c             |  2 +-
>  hw/misc/imx_ccm.c               |  2 +-
>  hw/net/e1000.c                  |  2 +-
>  hw/net/vhost_net.c              |  4 +-
>  hw/net/vmxnet3.c                |  2 +-
>  hw/nvram/fw_cfg.c               |  2 +-
>  hw/pci-bridge/pcie_root_port.c  |  8 ++--
>  hw/pci/pci.c                    | 17 ++++----
>  hw/pcmcia/pxa2xx.c              | 16 +++----
>  hw/ppc/pnv.c                    | 14 +++---
>  hw/ppc/pnv_core.c               |  2 +-
>  hw/ppc/pnv_xscom.c              |  6 +--
>  hw/ppc/prep.c                   |  8 ++--
>  hw/ppc/spapr.c                  | 50 +++++++++++-----------
>  hw/ppc/spapr_cpu_core.c         |  4 +-
>  hw/ppc/spapr_drc.c              | 20 ++++-----
>  hw/ppc/spapr_events.c           |  6 +--
>  hw/ppc/spapr_hcall.c            |  2 +-
>  hw/ppc/spapr_pci.c              | 14 +++---
>  hw/ppc/spapr_rtas.c             |  8 ++--
>  hw/ppc/spapr_vio.c              | 12 +++---
>  hw/s390x/css-bridge.c           |  2 +-
>  hw/s390x/css.c                  |  6 +--
>  hw/s390x/event-facility.c       | 14 +++---
>  hw/s390x/s390-skeys-kvm.c       |  2 +-
>  hw/s390x/s390-skeys.c           |  8 ++--
>  hw/s390x/s390-virtio-ccw.c      |  8 ++--
>  hw/s390x/sclp.c                 | 10 ++---
>  hw/s390x/virtio-ccw.c           | 12 +++---
>  hw/scsi/megasas.c               |  8 ++--
>  hw/scsi/mptconfig.c             |  6 +--
>  hw/scsi/scsi-bus.c              |  8 ++--
>  hw/scsi/vhost-scsi.c            |  4 +-
>  hw/scsi/virtio-scsi-dataplane.c |  6 +--
>  hw/scsi/vmw_pvscsi.c            |  2 +-
>  hw/sd/core.c                    | 18 ++++----
>  hw/sh4/sh7750.c                 |  2 +-
>  hw/smbios/smbios_type_38.c      |  2 +-
>  hw/sparc/sun4m.c                |  2 +-
>  hw/sparc64/sun4u.c              |  2 +-
>  hw/ssi/aspeed_smc.c             |  2 +-
>  hw/ssi/ssi.c                    |  8 ++--
>  hw/ssi/xilinx_spips.c           |  2 +-
>  hw/timer/i8254.c                |  2 +-
>  hw/timer/i8254_common.c         | 10 ++---
>  hw/timer/m48t59-isa.c           |  2 +-
>  hw/timer/m48t59.c               |  2 +-
>  hw/usb/bus.c                    | 32 +++++++-------
>  hw/usb/dev-smartcard-reader.c   |  8 ++--
>  hw/usb/hcd-ehci-pci.c           |  2 +-
>  hw/usb/hcd-ehci-sysbus.c        |  2 +-
>  hw/usb/hcd-uhci.c               |  2 +-
>  hw/vfio/amd-xgbe.c              |  2 +-
>  hw/vfio/calxeda-xgmac.c         |  2 +-
>  hw/virtio/vhost-vsock.c         |  4 +-
>  hw/virtio/vhost.c               |  2 +-
>  hw/virtio/virtio-bus.c          | 24 +++++------
>  hw/virtio/virtio-mmio.c         |  2 +-
>  hw/virtio/virtio-pci.c          | 20 ++++-----
>  hw/virtio/virtio.c              | 62 +++++++++++++--------------
>  hw/xen/xen_backend.c            |  3 +-
>  io/channel.c                    | 20 ++++-----
>  kvm-all.c                       |  2 +-
>  migration/migration.c           |  2 +-
>  migration/savevm.c              |  2 +-
>  monitor.c                       |  2 +-
>  net/filter.c                    |  6 +--
>  qdev-monitor.c                  | 12 +++---
>  qmp.c                           |  4 +-
>  qom/cpu.c                       | 26 ++++++------
>  qom/object.c                    | 31 +++++++-------
>  qom/object_interfaces.c         |  4 +-
>  target/alpha/cpu.c              |  2 +-
>  target/arm/cpu.c                |  8 ++--
>  target/arm/kvm.c                |  2 +-
>  target/cris/cpu.c               | 10 ++---
>  target/cris/helper.c            |  2 +-
>  target/hppa/cpu.c               |  2 +-
>  target/i386/cpu.c               | 10 ++---
>  target/i386/kvm.c               |  2 +-
>  target/i386/machine.c           |  3 +-
>  target/lm32/cpu.c               |  4 +-
>  target/lm32/gdbstub.c           |  2 +-
>  target/m68k/cpu.c               |  4 +-
>  target/microblaze/cpu.c         |  4 +-
>  target/microblaze/gdbstub.c     |  2 +-
>  target/mips/cpu.c               |  4 +-
>  target/moxie/cpu.c              |  4 +-
>  target/nios2/cpu.c              |  8 ++--
>  target/openrisc/cpu.c           |  4 +-
>  target/openrisc/gdbstub.c       |  2 +-
>  target/ppc/arch_dump.c          |  2 +-
>  target/ppc/compat.c             |  4 +-
>  target/ppc/excp_helper.c        |  2 +-
>  target/ppc/mmu-hash64.c         |  6 +--
>  target/ppc/mmu_helper.c         |  2 +-
>  target/ppc/translate_init.c     | 14 +++---
>  target/s390x/cpu.c              |  6 +--
>  target/s390x/cpu_models.c       |  4 +-
>  target/s390x/kvm.c              |  4 +-
>  target/s390x/mem_helper.c       |  6 +--
>  target/s390x/misc_helper.c      |  6 +--
>  target/s390x/mmu_helper.c       |  2 +-
>  target/sh4/cpu.c                |  4 +-
>  target/sparc/cpu.c              |  4 +-
>  target/tilegx/cpu.c             |  4 +-
>  target/tricore/cpu.c            |  4 +-
>  target/unicore32/cpu.c          |  2 +-
>  target/xtensa/cpu.c             |  6 +--
>  tests/check-qom-interface.c     |  2 +-
>  user-exec.c                     |  2 +-
>  vl.c                            |  2 +-
>  198 files changed, 800 insertions(+), 721 deletions(-)
> 
> -- 
> 2.11.0.259.g40922b1
> 

-- 
Eduardo
