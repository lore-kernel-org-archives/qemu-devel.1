Received: from eggs.gnu.org ([2001:4830:134:3::10]:44736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV4-0001vl-3n
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV0-00006U-2x
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctJUz-00006G-Qd
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 29 Mar 2017 16:41:39 -0300
Message-Id: <20170329194148.19015-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 0/9] qom: Make object_get_class()/*_GET_CLASS
 return const pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Juergen Gross <jgross@suse.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

The problem
-----------

QOM has a data model where class struct data is static: class
structs are initialized at class_init, and never changed again.

...except for a few rare cases where class data is changed
outside class_init. Those cases are:

  qbus_realize(), code added by:
  commit 61de36761b565a4138d8ad7ec75489ab28fe84b6
  Date:   Thu Feb 6 16:08:15 2014 +0100
      qdev: Keep global allocation counter per bus

  mips_jazz_init(), code added by:
  commit 54e755588cf1e90f0b1460c4e8e6b6a54b6d3a32
  Date:   Mon Nov 4 23:26:17 2013 +0100
      mips jazz: do not raise data bus exception when accessing invalid a=
ddresses

  xen_set_dynamic_sysbus(), code added by:
  commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894
  Date:   Tue Nov 22 07:10:58 2016 +0100
      xen: create qdev for each backend device

  s390_cpu_realizefn(), code added by:
  commit c6644fc88bed1176f67b4b7a9df691bcf25c0c5b
  Date:   Fri Mar 4 12:34:31 2016 -0500
      s390x/cpu: Get rid of side effects when creating a vcpu

I want to prevent that from happening again.

Proposal
--------

I propose we make object_get_class() and *_GET_CLASS macros
return const pointers. This way, anybody willing to change class
structs outside class_init will (hopefully) be aware that they
are doing something unexpected.

This would be very simple and trivial, except that:
* OBJECT_CLASS_CHECK cast its return value to a different
  (non-const) pointer type.
* OBJECT_CLASS_CHECK-based macros are used everywhere to
  cast class pointers to different class types.

I have addressed this problem using C11's _Generic keyword.
_Generic allows us to make OBJECT_CLASS_CHECK and other macros
return a const pointer if its argument is a const pointer, and a
non-const pointer otherwise.

This series changes OBJECT_CLASS, OBJECT_CLASS_CHECK,
object_class_dynamic_cast_assert(), object_class_dynamic_cast(),
and object_class_get_parent() to exhibit this const-aware
behavior.

If the compiler doesn't support _Generic, we keep the old
behavior, and the cast macros will keep returning non-const
pointers.

---
Cc: Alexander Graf <agraf@suse.de>
Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Andreas F=C3=A4rber <afaerber@suse.de>

Eduardo Habkost (9):
  configure: test if _Generic works as expected
  Simplify code using *MACHINE_GET_CLASS
  qom: QUALIFIED_CAST helper macro
  qom: Make object_class_get_parent() const-aware
  Make class parameter const at some functions
  Explicitly cast the *_GET_CLASS() value when we break the rules
  Use const variables for *_GET_CLASS values
  qom: Make class cast macros/functions const-aware
  qom: Make object_get_class() return const pointer

 configure                       | 20 +++++++++
 include/qom/cpu.h               | 12 +++---
 include/qom/object.h            | 94 ++++++++++++++++++++++++++++++++++-=
------
 target/ppc/mmu-book3s-v3.h      |  2 +-
 target/ppc/mmu-hash64.h         |  2 +-
 target/s390x/cpu.h              |  2 +-
 backends/cryptodev.c            | 10 ++---
 backends/hostmem.c              |  2 +-
 backends/rng.c                  |  4 +-
 backends/tpm.c                  | 28 ++++++------
 chardev/char-mux.c              |  2 +-
 chardev/char.c                  | 10 ++---
 cpu-exec.c                      | 14 +++---
 device-hotplug.c                |  2 +-
 disas.c                         |  4 +-
 exec.c                          |  6 +--
 gdbstub.c                       | 12 +++---
 hmp.c                           |  4 +-
 hw/acpi/acpi_interface.c        |  2 +-
 hw/acpi/cpu.c                   |  8 ++--
 hw/acpi/cpu_hotplug.c           |  4 +-
 hw/acpi/ipmi.c                  |  2 +-
 hw/acpi/memory_hotplug.c        |  2 +-
 hw/acpi/nvdimm.c                |  4 +-
 hw/acpi/pcihp.c                 |  4 +-
 hw/arm/aspeed.c                 |  2 +-
 hw/arm/aspeed_soc.c             |  4 +-
 hw/arm/boot.c                   |  2 +-
 hw/arm/exynos4_boards.c         |  2 +-
 hw/arm/vexpress.c               |  2 +-
 hw/arm/virt-acpi-build.c        |  6 +--
 hw/arm/virt.c                   |  6 +--
 hw/audio/cs4231a.c              | 10 ++---
 hw/audio/gus.c                  |  6 +--
 hw/audio/intel-hda.c            |  8 ++--
 hw/audio/sb16.c                 |  6 +--
 hw/block/dataplane/virtio-blk.c |  6 +--
 hw/block/fdc.c                  |  8 ++--
 hw/block/m25p80.c               |  2 +-
 hw/char/serial-pci.c            |  2 +-
 hw/char/virtio-console.c        |  6 +--
 hw/char/virtio-serial-bus.c     | 18 ++++----
 hw/core/bus.c                   |  4 +-
 hw/core/fw-path-provider.c      |  2 +-
 hw/core/generic-loader.c        |  2 +-
 hw/core/hotplug.c               |  8 ++--
 hw/core/loader.c                |  4 +-
 hw/core/machine.c               |  5 +--
 hw/core/nmi.c                   |  2 +-
 hw/core/qdev-properties.c       |  4 +-
 hw/core/qdev.c                  | 32 +++++++-------
 hw/core/stream.c                |  4 +-
 hw/core/sysbus.c                |  6 +--
 hw/display/cirrus_vga.c         |  2 +-
 hw/i2c/core.c                   | 10 ++---
 hw/i2c/smbus.c                  |  8 ++--
 hw/i386/acpi-build.c            | 16 +++----
 hw/i386/kvm/i8254.c             |  2 +-
 hw/i386/kvm/i8259.c             |  2 +-
 hw/i386/pc.c                    | 32 +++++++-------
 hw/i386/pc_piix.c               |  4 +-
 hw/i386/pc_q35.c                |  4 +-
 hw/i386/x86-iommu.c             |  2 +-
 hw/ide/microdrive.c             |  4 +-
 hw/ide/qdev.c                   |  2 +-
 hw/input/adb.c                  |  6 +--
 hw/input/virtio-input.c         | 12 +++---
 hw/intc/apic_common.c           | 26 ++++++------
 hw/intc/arm_gic.c               |  2 +-
 hw/intc/arm_gic_common.c        |  4 +-
 hw/intc/arm_gic_kvm.c           |  4 +-
 hw/intc/arm_gicv3.c             |  2 +-
 hw/intc/arm_gicv3_common.c      |  4 +-
 hw/intc/arm_gicv3_its_common.c  |  6 +--
 hw/intc/arm_gicv3_kvm.c         |  4 +-
 hw/intc/i8259.c                 |  2 +-
 hw/intc/i8259_common.c          |  4 +-
 hw/intc/ioapic_common.c         |  6 +--
 hw/intc/xics.c                  | 26 ++++++------
 hw/ipack/ipack.c                |  4 +-
 hw/ipack/tpci200.c              | 12 +++---
 hw/ipmi/ipmi_bmc_extern.c       | 12 +++---
 hw/ipmi/ipmi_bmc_sim.c          | 24 +++++------
 hw/ipmi/isa_ipmi_bt.c           | 22 +++++-----
 hw/ipmi/isa_ipmi_kcs.c          | 20 ++++-----
 hw/mem/pc-dimm.c                | 10 ++---
 hw/mips/mips_jazz.c             |  2 +-
 hw/misc/imx_ccm.c               |  2 +-
 hw/net/e1000.c                  |  2 +-
 hw/net/vhost_net.c              |  4 +-
 hw/net/vmxnet3.c                |  2 +-
 hw/nvram/fw_cfg.c               |  2 +-
 hw/pci-bridge/pcie_root_port.c  |  8 ++--
 hw/pci/pci.c                    | 17 ++++----
 hw/pcmcia/pxa2xx.c              | 16 +++----
 hw/ppc/pnv.c                    | 14 +++---
 hw/ppc/pnv_core.c               |  2 +-
 hw/ppc/pnv_xscom.c              |  6 +--
 hw/ppc/prep.c                   |  8 ++--
 hw/ppc/spapr.c                  | 50 +++++++++++-----------
 hw/ppc/spapr_cpu_core.c         |  4 +-
 hw/ppc/spapr_drc.c              | 20 ++++-----
 hw/ppc/spapr_events.c           |  6 +--
 hw/ppc/spapr_hcall.c            |  2 +-
 hw/ppc/spapr_pci.c              | 14 +++---
 hw/ppc/spapr_rtas.c             |  8 ++--
 hw/ppc/spapr_vio.c              | 12 +++---
 hw/s390x/css-bridge.c           |  2 +-
 hw/s390x/css.c                  |  6 +--
 hw/s390x/event-facility.c       | 14 +++---
 hw/s390x/s390-skeys-kvm.c       |  2 +-
 hw/s390x/s390-skeys.c           |  8 ++--
 hw/s390x/s390-virtio-ccw.c      |  8 ++--
 hw/s390x/sclp.c                 | 10 ++---
 hw/s390x/virtio-ccw.c           | 12 +++---
 hw/scsi/megasas.c               |  8 ++--
 hw/scsi/mptconfig.c             |  6 +--
 hw/scsi/scsi-bus.c              |  8 ++--
 hw/scsi/vhost-scsi.c            |  4 +-
 hw/scsi/virtio-scsi-dataplane.c |  6 +--
 hw/scsi/vmw_pvscsi.c            |  2 +-
 hw/sd/core.c                    | 18 ++++----
 hw/sh4/sh7750.c                 |  2 +-
 hw/smbios/smbios_type_38.c      |  2 +-
 hw/sparc/sun4m.c                |  2 +-
 hw/sparc64/sun4u.c              |  2 +-
 hw/ssi/aspeed_smc.c             |  2 +-
 hw/ssi/ssi.c                    |  8 ++--
 hw/ssi/xilinx_spips.c           |  2 +-
 hw/timer/i8254.c                |  2 +-
 hw/timer/i8254_common.c         | 10 ++---
 hw/timer/m48t59-isa.c           |  2 +-
 hw/timer/m48t59.c               |  2 +-
 hw/usb/bus.c                    | 32 +++++++-------
 hw/usb/dev-smartcard-reader.c   |  8 ++--
 hw/usb/hcd-ehci-pci.c           |  2 +-
 hw/usb/hcd-ehci-sysbus.c        |  2 +-
 hw/usb/hcd-uhci.c               |  2 +-
 hw/vfio/amd-xgbe.c              |  2 +-
 hw/vfio/calxeda-xgmac.c         |  2 +-
 hw/virtio/vhost-vsock.c         |  4 +-
 hw/virtio/vhost.c               |  2 +-
 hw/virtio/virtio-bus.c          | 24 +++++------
 hw/virtio/virtio-mmio.c         |  2 +-
 hw/virtio/virtio-pci.c          | 20 ++++-----
 hw/virtio/virtio.c              | 62 +++++++++++++--------------
 hw/xen/xen_backend.c            |  3 +-
 io/channel.c                    | 20 ++++-----
 kvm-all.c                       |  2 +-
 migration/migration.c           |  2 +-
 migration/savevm.c              |  2 +-
 monitor.c                       |  2 +-
 net/filter.c                    |  6 +--
 qdev-monitor.c                  | 12 +++---
 qmp.c                           |  4 +-
 qom/cpu.c                       | 26 ++++++------
 qom/object.c                    | 31 +++++++-------
 qom/object_interfaces.c         |  4 +-
 target/alpha/cpu.c              |  2 +-
 target/arm/cpu.c                |  8 ++--
 target/arm/kvm.c                |  2 +-
 target/cris/cpu.c               | 10 ++---
 target/cris/helper.c            |  2 +-
 target/hppa/cpu.c               |  2 +-
 target/i386/cpu.c               | 10 ++---
 target/i386/kvm.c               |  2 +-
 target/i386/machine.c           |  3 +-
 target/lm32/cpu.c               |  4 +-
 target/lm32/gdbstub.c           |  2 +-
 target/m68k/cpu.c               |  4 +-
 target/microblaze/cpu.c         |  4 +-
 target/microblaze/gdbstub.c     |  2 +-
 target/mips/cpu.c               |  4 +-
 target/moxie/cpu.c              |  4 +-
 target/nios2/cpu.c              |  8 ++--
 target/openrisc/cpu.c           |  4 +-
 target/openrisc/gdbstub.c       |  2 +-
 target/ppc/arch_dump.c          |  2 +-
 target/ppc/compat.c             |  4 +-
 target/ppc/excp_helper.c        |  2 +-
 target/ppc/mmu-hash64.c         |  6 +--
 target/ppc/mmu_helper.c         |  2 +-
 target/ppc/translate_init.c     | 14 +++---
 target/s390x/cpu.c              |  6 +--
 target/s390x/cpu_models.c       |  4 +-
 target/s390x/kvm.c              |  4 +-
 target/s390x/mem_helper.c       |  6 +--
 target/s390x/misc_helper.c      |  6 +--
 target/s390x/mmu_helper.c       |  2 +-
 target/sh4/cpu.c                |  4 +-
 target/sparc/cpu.c              |  4 +-
 target/tilegx/cpu.c             |  4 +-
 target/tricore/cpu.c            |  4 +-
 target/unicore32/cpu.c          |  2 +-
 target/xtensa/cpu.c             |  6 +--
 tests/check-qom-interface.c     |  2 +-
 user-exec.c                     |  2 +-
 vl.c                            |  2 +-
 198 files changed, 800 insertions(+), 721 deletions(-)

--=20
2.11.0.259.g40922b1
