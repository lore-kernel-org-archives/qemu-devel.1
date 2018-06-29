Received: from eggs.gnu.org ([2001:4830:134:3::10]:38114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUH-0007hc-D2
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUB-0007F1-DJ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:57 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 29 Jun 2018 15:29:34 +0200
Message-Id: <20180629132954.24269-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/20] arm_gic: add virtualization
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

This patch series add support for the virtualization extensions in the
ARM GICv2 interrupt controller.

The first commit implements two missing registers in the distributor
because they are used by KVM. Commits 2 and 3 do some refactoring to
prepare for the implementation. Commits 3 and 4 adds the virtualization
extensions to the GIC state. Commits 5 to 16 are the actual
implementation. The last commits updates the ZynqMP and virt machine to
support GICv2 virtualization extensions.

The current state allows to boot Xen (tested with 4.8 and 4.10) with
Linux Dom0 guest properly.
It also works fine with a inner Linux guest in an outer simulated
Linux/KVM host uses the GICv2 virtualization extensions (tested with the
virt machine, with a 4.17.3 Linux kernel).=20

I also tested in SMP. It works fine with KVM but not out-of-the-box with
Xen because Xen expects to find CPU IDs in the GIC ITARGETSR0 register.
This behavior is not documented in the GICv2 specification, and is not
implemented in QEMU.  By hacking this register, I was able to get the
whole thing to boot in SMP properly. This hack is not part of those
patches though.

I also tested migration, it works fine AFAIK. I had to add the HYP and
SEC timers in the ARM CPU VMState though (Xen uses the HYP one) (not
part of those patches).

I want to thanks the Xilinx's QEMU team who sponsored this work for
their collaboration.

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

Luc Michel (20):
  intc/arm_gic: Implement write to GICD_ISACTIVERn and GICD_ICACTIVERn
    registers
  intc/arm_gic: Refactor operations on the distributor
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
  intc/arm_gic: Implement virtualization extensions in gic_complete_irq
  intc/arm_gic: Implement virtualization extensions in
    gic_cpu_(read|write)
  intc/arm_gic: Wire the vCPU interface
  intc/arm_gic: Implement the virtual interface registers
  intc/arm_gic: Implement gic_update_virt() function
  intc/arm_gic: Implement maintenance interrupt generation
  intc/arm_gic: Improve traces
  xlnx-zynqmp: Improve GIC wiring and MMIO mapping
  arm/virt: Add support for GICv2 virtualization extensions

 hw/arm/virt-acpi-build.c         |   4 +
 hw/arm/virt.c                    |  50 +-
 hw/arm/xlnx-zynqmp.c             |  92 +++-
 hw/intc/arm_gic.c                | 869 ++++++++++++++++++++++++-------
 hw/intc/arm_gic_common.c         | 154 +++++-
 hw/intc/arm_gic_kvm.c            |  31 +-
 hw/intc/gic_internal.h           | 268 ++++++++--
 hw/intc/trace-events             |  12 +-
 include/hw/arm/virt.h            |   3 +
 include/hw/arm/xlnx-zynqmp.h     |   4 +-
 include/hw/intc/arm_gic_common.h |  43 +-
 include/migration/vmstate.h      |   3 +
 12 files changed, 1262 insertions(+), 271 deletions(-)

--=20
2.17.1
