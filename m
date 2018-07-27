Received: from eggs.gnu.org ([2001:4830:134:3::10]:58280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSi-0003nE-MY
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSf-0006Jm-Ur
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:04 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 27 Jul 2018 11:54:01 +0200
Message-Id: <20180727095421.386-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 00/20] arm_gic: add virtualization
 extensions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

v2:
  - Add VMSTATE_UINT16_SUB_ARRAY to vmstate.h
  - Keep backward compatibility on the GIC VMState by storing vCPUs
    state in the virt VMState subsection.
  - Use h_apr to store APR value for vCPUs, instead of increasing apr 2D
    array. This adds a little complexity to the implementation (a bunch
    of `if (gic_is_vcpu(cpu))'), but avoid ugly VMState description for
    the apr array.

v3:
  - Remove the LR caching mechanism as it is probably not worse it.
  - Remove the forced secure access hack and replace it with a proper
    check (commit 8, function gic_cpu_ns_access()).
  - Split the Implementation patch for easier review.
  - Misc modifications following the review from Peter on v2.
  - Add GICv2 virt extensions support to the arm virt machine.
  - Fix vCPU running prio not being recomputed after a write to H_APR.
  - Fix group0 hw interrupts deactivation request not being forwarded to
    distributor when the GIC is not secure.
  - Implement GICD_ISACTIVERn and GICD_ICACTIVERn because KVM uses them.

v4:
  - Patch 2: check GICD_ISACTIVERn and GICD_ICACTIVERn access (exist
    only in GICv2) [Peter]
  - Patch 2: moved after patch 1 to ensure compilation success across
    patches [Peter]
  - Patch 2: implement GICD_ICACTIVERn reads on GICv2 [Peter]
  - Patch 7: Integrated Peter rational about LRs helpers, added
    comments to explain what's going on [Peter]
  - Patch 9: gic_clear_active(): check that the given PhysicalID is a
    valid IRQ [Peter]
  - Patch 10: refactor to move out the virt cases for more clarity [Peter=
]
  - Patch 12: Add a validity check on the given vIRQ [Peter]
  - Patch 14: Fix a comment on memory region creation [Peter]
  - Patch 14: Fix per-core alias creation, that should target the
    virtual interfaces, and not the vCPU interfaces [Peter]
  - Patch 16: gic_update_internal(): Move the CPU interface enable test
    in gic_irq_signaling_enabled() [Peter]
  - Patch 17: Stylistic [Peter]
  - Patch 20: Rebase onto master
  - Patch 20: Merge the two GIC maintenance IRQ constants into one
    [Peter]
  - Patch 20: Fix Memory region size for GICv2 virtual interface and
    vCPU iface. [Peter]

v5:
  - Patch 7: dropped unreachable 'return NULL' [Peter]
  - Patch 12: reworked the way invalid vIRQ are handled. The
    specification being uncleared, I used real hardware to check our
    previous hypothesises. See commit message for the adopted behaviour.
    The main difference is that when EOIMode is true (EOI split is
    enabled), a write to V_EOIR never increments H_HCR.EOICount. [Peter]
  - Patch 14-15: fixed commit message regarding mirrored regions. [Peter]

Luc Michel (20):
  intc/arm_gic: Refactor operations on the distributor
  intc/arm_gic: Implement GICD_ISACTIVERn and GICD_ICACTIVERn registers
  intc/arm_gic: Remove some dead code and put some functions static
  vmstate.h: Provide VMSTATE_UINT16_SUB_ARRAY
  intc/arm_gic: Add the virtualization extensions to the GIC state
  intc/arm_gic: Add virtual interface register definitions
  intc/arm_gic: Add virtualization extensions helper macros and
    functions
  intc/arm_gic: Refactor secure/ns access check in the CPU interface
  intc/arm_gic: Add virtualization enabled IRQ helper functions
  intc/arm_gic: Implement virtualization extensions in
    gic_(activate_irq|drop_prio)
  intc/arm_gic: Implement virtualization extensions in
    gic_acknowledge_irq
  intc/arm_gic: Implement virtualization extensions in
    gic_(deactivate|complete_irq)
  intc/arm_gic: Implement virtualization extensions in
    gic_cpu_(read|write)
  intc/arm_gic: Wire the vCPU interface
  intc/arm_gic: Implement the virtual interface registers
  intc/arm_gic: Implement gic_update_virt() function
  intc/arm_gic: Implement maintenance interrupt generation
  intc/arm_gic: Improve traces
  xlnx-zynqmp: Improve GIC wiring and MMIO mapping
  arm/virt: Add support for GICv2 virtualization extensions

 hw/arm/virt-acpi-build.c         |   6 +-
 hw/arm/virt.c                    |  52 +-
 hw/arm/xlnx-zynqmp.c             |  92 ++-
 hw/intc/arm_gic.c                | 994 +++++++++++++++++++++++++------
 hw/intc/arm_gic_common.c         | 154 ++++-
 hw/intc/arm_gic_kvm.c            |  31 +-
 hw/intc/gic_internal.h           | 282 ++++++++-
 hw/intc/trace-events             |  12 +-
 include/hw/arm/virt.h            |   4 +-
 include/hw/arm/xlnx-zynqmp.h     |   4 +-
 include/hw/intc/arm_gic_common.h |  43 +-
 include/migration/vmstate.h      |   3 +
 12 files changed, 1393 insertions(+), 284 deletions(-)

--
2.18.0
