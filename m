Received: from eggs.gnu.org ([2001:4830:134:3::10]:46152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frm8R-0005TD-Iq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frm8Q-00043u-Tb
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:30:27 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 16:30:14 +0100
Message-Id: <20180820153020.21478-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/6] target/arm: Some pieces of support for
 32-bit Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Luc Michel <luc.michel@greensocs.com>

Now we have virtualization support in the GICv2 emulation,
I thought I'd have a look at how much we were still missing
for being able to enable EL2 support for AArch32.
This set of patches fixes some minor missing pieces:
 * AArch32 HACTLR2
 * AArch32 HCR, HCR2
 * support for taking exceptions to Hyp mode
 * boot AArch32 kernels in Hyp mode where available
and I threw in a trivial bugfix:
 * Clear CPSR.IL and CPSR.J on 32-bit exception entry
since it would otherwise have a conflict with the refactoring
of exception entry.

Changes v1->v2:
 * some patches are now upstream
 * v8-only registers no longer created for v7 CPUs
 * split the "factor out exception-entry code" into
   its own patch
 * new patch: clear CPSR.IL and CPSR.J
 * new patch: boot kernels in Hyp mode if possible

(I still have the same "guest EL0 segv" issue as for v1
if I actually enable the EL2 feature on Cortex-A15.)

thanks
-- PMM

Peter Maydell (6):
  target/arm: Implement RAZ/WI HACTLR2
  target/arm: Implement AArch32 HCR and HCR2
  target/arm: Factor out code for taking an AArch32 exception
  target/arm: Implement support for taking exceptions to Hyp mode
  target/arm: Clear CPSR.IL and CPSR.J on 32-bit exception entry
  hw/arm/boot: AArch32 kernels should be started in Hyp mode if
    available

 hw/arm/boot.c       |  11 +++
 target/arm/helper.c | 212 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 196 insertions(+), 27 deletions(-)

-- 
2.18.0
