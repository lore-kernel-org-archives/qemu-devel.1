Received: from eggs.gnu.org ([2001:4830:134:3::10]:60340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fs6hw-0005r8-4E
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fs6hu-0003b0-NU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:28:27 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 14:28:02 +0100
Message-Id: <20180821132811.17675-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/9] arm: Wire up GICv2 virt support on A15/A7
 boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Luc Michel <luc.michel@greensocs.com>

This patchset wires up the GICv2 virtualization support
on all our Cortex-A15 and Cortex-A7 boards.

These boards fall into various categories:
 * virt: already done in master
 * highbank, imx6, imx7: the CPU is configured to always
   have EL3, so we unconditionally allow EL2 to be enabled too
   and just need to wire up the GIC VIRQ/VFIQ lines
 * raspi2: has a non-standard interrupt controller, not a GIC,
   so we enable EL2 but there's no wiring to be done
 * vexpress-a15: is configurable to have EL3 or not; we add
   extra configuration so the user can add EL2 or not, using
   a machine property "virtualization", paralleling the
   existing "secure" property.

In all cases, most of the handling of mapping extra register
ranges into the address space and wiring up the maintenance
irq is dealt with by the a15mpcore container object.

Adding EL2 support has the potential to confuse older guests,
because it will mean that we'll boot into Hyp mode by default
if we're booting the kernel non-secure. But the Linux kernel
booting specification has required that for a long time now.

I had to fix one issue with an oversized memory region in
the GIC; there's also a documentation-comment patch in there
which records some stuff I had to figure out in trying to
map the right memory regions in the right places.

None of this code actually does anything (except provide a
property that doesn't do anything on vexpress-a15) until we
actually set the ARM_FEATURE_EL2 bit for A15 and A7.

thanks
-- PMM


Peter Maydell (9):
  hw/intc/arm_gic: Document QEMU interface
  hw/intc/arm_gic: Make per-cpu GICH memory regions 0x200 bytes large
  hw/arm/vexpress: Connect VIRQ and VFIQ
  hw/arm/highbank: Connect VIRQ and VFIQ
  hw/arm/fsl-imx6ul: Connect VIRQ and VFIQ
  hw/arm/fsl-imx6ul: Connect VIRQ and VFIQ
  hw/cpu/a15mpcore: If CPU has EL2, enable it on the GIC and wire it up
  hw/arm/vexpress: Don't set info->secure_boot if CPU doesn't have EL3
  hw/arm/vexpress: Add "virtualization" property controlling presence of
    EL2

 include/hw/intc/arm_gic.h | 35 +++++++++++++++++++++
 hw/arm/fsl-imx6ul.c       |  4 +++
 hw/arm/fsl-imx7.c         |  4 +++
 hw/arm/highbank.c         |  6 ++++
 hw/arm/vexpress.c         | 64 ++++++++++++++++++++++++++++++++++++---
 hw/cpu/a15mpcore.c        | 31 +++++++++++++++++--
 hw/intc/arm_gic.c         |  2 +-
 7 files changed, 137 insertions(+), 9 deletions(-)

-- 
2.18.0
