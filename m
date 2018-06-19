Received: from eggs.gnu.org ([2001:4830:134:3::10]:38255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fVCzR-0005bJ-69
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fVCzM-0006Kv-9i
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:31:53 -0400
From: luc.michel@greensocs.com
Date: Tue, 19 Jun 2018 11:31:17 +0200
Message-Id: <20180619093124.24011-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/7] arm_gic: add virtualization extensions
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc MICHEL <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

From: Luc MICHEL <luc.michel@greensocs.com>

This patch series add support for the virtualization extensions in the
ARM GICv2 interrupt controller.

The first two commits do some refactoring to prepare for the
implementation. Commits 3 and 4 are the actual implementation. The last
commit updates the ZynqMP implementation to support virtualization.

The current state allows to boot Xen (tested with 4.8 and 4.10) with
Linux Dom0 guest properly.

I also tested in SMP. It does not work directly because Xen expects to
find CPU IDs in the GIC ITARGETSR0 register. This behavior is not
documented in the GICv2 specification, and is not implemented in QEMU.
By hacking this register, I was able to get the whole thing to boot in
SMP properly. This hack is not part of those patches though.

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

Luc MICHEL (7):
  intc/arm_gic: Refactor operations on the distributor
  intc/arm_gic: Remove some dead code and put some functions static
  vmstate.h: Provide VMSTATE_UINT16_SUB_ARRAY
  intc/arm_gic: Add the virtualization extensions to the GIC state
  intc/arm_gic: Add virtualization extensions logic
  intc/arm_gic: Improve traces
  xlnx-zynqmp: Improve GIC wiring and MMIO mapping

 hw/arm/xlnx-zynqmp.c             |  92 +++-
 hw/intc/arm_gic.c                | 790 ++++++++++++++++++++++++-------
 hw/intc/arm_gic_common.c         | 158 +++++--
 hw/intc/arm_gic_kvm.c            |  31 +-
 hw/intc/gic_internal.h           | 258 ++++++++--
 hw/intc/trace-events             |  12 +-
 include/hw/arm/xlnx-zynqmp.h     |   4 +-
 include/hw/intc/arm_gic_common.h |  51 +-
 include/migration/vmstate.h      |   3 +
 9 files changed, 1153 insertions(+), 246 deletions(-)

--=20
2.17.1
