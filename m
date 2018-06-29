Received: from eggs.gnu.org ([2001:4830:134:3::10]:36370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrNz-0008Fk-KK
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrNv-00027T-AR
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:19 -0400
Received: from foss.arm.com ([217.140.101.70]:39218)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrNu-000261-Vo
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:15 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Fri, 29 Jun 2018 12:15:20 +0100
Message-Id: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/20] arm64: Dynamic & 52bit IPA support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Suzuki K Poulose <suzuki.poulose@arm.com>


The physical address space size for a VM (IPA size) on arm/arm64 is
limited to a static limit of 40bits. This series adds support for
using an IPA size specific to a VM, allowing to use a limit supported
by the host (based on the host kernel configuration and CPU support).
The default and the minimum size is fixed to 40bits. We also add
support for handling 52bit IPA addresses added by Arm v8.2 extensions.

As mentioned above, the supported IPA size on a host could be different
from the system's PARange indicated by the CPUs (e.g, kernel limit
on the PA size). So we expose the limit via a new system ioctl request
 - KVM_ARM_GET_MAX_VM_PHYS_SHIFT - on arm/arm64. This can then be
passed on to the KVM_CREATE_VM ioctl, encoded in the "type" field.
Bits [7-0] of the type are reserved for the IPA size. This approach
allows simpler management of the stage2 page table and guest memory
slots.

The arm64 page table level helpers are defined based on the page
table levels used by the host VA. So, the accessors may not work
if the guest uses more number of levels in stage2 than the stage1
of the host.  The previous versions (v1 & v2) of this series refactored
the stage1 page table accessors to reuse the low-level accessors for an
independent stage2 table. However, due to the level folding in the
generic code, the types are redefined as well. i.e, if the PUD is
folded, the pud_t could be defined as :

 typedef struct { pgd_t pgd; } pud_t;

similarly for pmd_t.  So, without stage1 independent page table entry
types for stage2, we could be dealing with a different type for level
 0-2 entries. This is practically fine on arm/arm64 as the entries
have similar format and size and we always use the appropriate
accessors to get the raw value (i.e, pud_val/pmd_val etc). But not
ideal for a solution upstream. So, this version caps the stage2 page
table levels to that of the stage1. This has the following impact on
the IPA support for various pagesize/host-va combinations :


x-----------------------------------------------------x
| host\ipa    | 40bit | 42bit | 44bit | 48bit | 52bit |
-------------------------------------------------------
| 39bit-4K    |  y    |   y   |  n    |   n   |  n/a  |
-------------------------------------------------------
| 48bit-4K    |  y    |   y   |  y    |   y   |  n/a  |
-------------------------------------------------------
| 36bit-16K   |  y    |   n   |  n    |   n   |  n/a  |
-------------------------------------------------------
| 47bit-16K   |  y    |   y   |  y    |   y   |  n/a  |
-------------------------------------------------------
| 48bit-4K    |  y    |   y   |  y    |   y   |  n/a  |
-------------------------------------------------------
| 42bit-64K   |  y    |   y   |  y    |   n   |  n    |
-------------------------------------------------------
| 48bit-64K   |  y    |   y   |  y    |   y   |  y    |
x-----------------------------------------------------x

Or the following list shows what cannot be supported :

 39bit-4K host supporting IPA > 43bit (upto 48bit)
 36bit-16K host for IPA > 40bit (upto 48bit)
 42bit-64K host for IPA > 46bit (upto 52bit)

which is not really bad. We can pursue the independent stage2
page table support and lift the restriction once we get there.
Given there is a proposal for new generic page table walker [0],
it would make sense to make our efforts in sync with it to avoid
diverting from a common API.

52bit support is added for VGIC (including ITS emulation) and handling
of PAR, HPFAR registers.

The series applies on 4.18-rc2. A tree is available here:

	 git://linux-arm.org/linux-skp.git ipa52/v3

Tested with
  - Modified kvmtool, which can only be used for (patches included in
    the series for reference / testing):
    * with virtio-pci upto 44bit PA (Due to 4K page size for virtio-pci
      legacy implemented by kvmtool)
    * Upto 48bit PA with virtio-mmio, due to 32bit PFN limitation.
  - Hacked Qemu (boot loader support for highmem, phys-shift support)
    * with virtio-pci GIC-v3 ITS & MSI upto 52bit on Foundation model.
    Also see [1] for Qemu support.

[0] https://lkml.org/lkml/2018/4/24/777
[1] https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05759.html

Changes since V2:
 - Drop "refactoring of host page table helpers" and restrict the IPA siz=
e
   to make sure stage2 doesn't use more page table levels than that of th=
e host.
 - Load VTCR for TLB operations on behalf of the VM (Pointed-by: James Mo=
rse)
 - Split a couple of patches to make them easier to review.
 - Fall back to normal (non-concatenated) entry level page table support =
if
   possible.
 - Bump the IOCTL number

Changes since V1:
 - Change the userspace API for configuring VM to encode the IPA
   size in the VM type.  (suggested by Christoffer)
 - Expose the IPA limit on the host via ioctl on /dev/kvm
 - Handle 52bit addresses in PAR & HPFAR
 - Drop patch changing the life time of stage2 PGD
 - Rename macros for 48-to-52 bit conversion for GIC ITS BASER.
   (suggested by Christoffer)
 - Split virtio PFN check patches and address comments.

Kristina Martsenko (1):
  vgic: Add support for 52bit guest physical address

Suzuki K Poulose (19):
  virtio: mmio-v1: Validate queue PFN
  virtio: pci-legacy: Validate queue pfn
  arm64: Add a helper for PARange to physical shift conversion
  kvm: arm64: Clean up VTCR_EL2 initialisation
  kvm: arm/arm64: Fix stage2_flush_memslot for 4 level page table
  kvm: arm/arm64: Remove spurious WARN_ON
  kvm: arm/arm64: Prepare for VM specific stage2 translations
  kvm: arm/arm64: Abstract stage2 pgd table allocation
  kvm: arm64: Make stage2 page table layout dynamic
  kvm: arm64: Dynamic configuration of VTTBR mask
  kvm: arm64: Helper for computing VTCR_EL2.SL0
  kvm: arm64: Add helper for loading the stage2 setting for a VM
  kvm: arm64: Configure VTCR per VM
  kvm: arm/arm64: Expose supported physical address limit for VM
  kvm: arm/arm64: Allow tuning the physical address size for VM
  kvm: arm64: Switch to per VM IPA limit
  kvm: arm64: Add support for handling 52bit IPA
  kvm: arm64: Allow IPA size supported by the system
  kvm: arm64: Fall back to normal stage2 entry level

 Documentation/virtual/kvm/api.txt             |  15 ++
 arch/arm/include/asm/kvm_arm.h                |   3 +-
 arch/arm/include/asm/kvm_mmu.h                |  28 +++-
 arch/arm/include/asm/stage2_pgtable.h         |  42 ++---
 arch/arm64/include/asm/cpufeature.h           |  13 ++
 arch/arm64/include/asm/kvm_arm.h              | 137 ++++++++++++++---
 arch/arm64/include/asm/kvm_asm.h              |   2 +-
 arch/arm64/include/asm/kvm_host.h             |  19 ++-
 arch/arm64/include/asm/kvm_hyp.h              |  16 ++
 arch/arm64/include/asm/kvm_mmu.h              |  92 ++++++++++-
 arch/arm64/include/asm/stage2_pgtable-nopmd.h |  42 -----
 arch/arm64/include/asm/stage2_pgtable-nopud.h |  39 -----
 arch/arm64/include/asm/stage2_pgtable.h       | 213 +++++++++++++++++++-=
------
 arch/arm64/kvm/guest.c                        |  42 +++++
 arch/arm64/kvm/hyp/s2-setup.c                 |  37 +----
 arch/arm64/kvm/hyp/switch.c                   |   4 +-
 arch/arm64/kvm/hyp/tlb.c                      |   4 +-
 drivers/virtio/virtio_mmio.c                  |  18 ++-
 drivers/virtio/virtio_pci_legacy.c            |  12 +-
 include/linux/irqchip/arm-gic-v3.h            |   5 +
 include/uapi/linux/kvm.h                      |  16 ++
 virt/kvm/arm/arm.c                            |  32 +++-
 virt/kvm/arm/mmu.c                            | 124 ++++++++-------
 virt/kvm/arm/vgic/vgic-its.c                  |  36 ++---
 virt/kvm/arm/vgic/vgic-kvm-device.c           |   2 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c              |   2 -
 26 files changed, 663 insertions(+), 332 deletions(-)
 delete mode 100644 arch/arm64/include/asm/stage2_pgtable-nopmd.h
 delete mode 100644 arch/arm64/include/asm/stage2_pgtable-nopud.h


kvmtool patches :

Suzuki K Poulose (4):
  kvmtool: Allow backends to run checks on the KVM device fd
  kvmtool: arm64: Add support for guest physical address size
  kvmtool: arm64: Switch memory layout
  kvmtool: arm: Add support for creating VM with PA size

 arm/aarch32/include/kvm/kvm-arch.h        |  6 ++++--
 arm/aarch64/include/kvm/kvm-arch.h        | 15 ++++++++++++---
 arm/aarch64/include/kvm/kvm-config-arch.h |  5 ++++-
 arm/include/arm-common/kvm-arch.h         | 17 +++++++++++------
 arm/include/arm-common/kvm-config-arch.h  |  1 +
 arm/kvm.c                                 | 24 +++++++++++++++++++++++-
 include/kvm/kvm.h                         |  4 ++++
 kvm.c                                     |  2 ++
 8 files changed, 61 insertions(+), 13 deletions(-)

--=20
2.7.4
