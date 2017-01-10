Received: from eggs.gnu.org ([2001:4830:134:3::10]:43869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cR1PD-0005r2-Lq
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cR1PC-0002Md-Ok
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:44:23 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jan 2017 18:44:06 +0000
Message-Id: <1484073849-32666-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] target/arm: Support EL1 AArch32 guest
 under AArch64 EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

The GICv3 virt patchset is sufficient to run a 64-bit guest under
a 64-bit host kernel. To run 32-bit guests under the 64-bit host
you need a few more things:
 * data aborts from AArch32 need to provide instruction syndrome info
   to the hypervisor
 * the AArch32 interrupt code needs to handle VIRQ and VFIQ
 * we need a DBGVCR32_EL2 register, because Linux's EL2 code uses
   it to context-switch AArch32 DBGVCR between guests

This patchset sits on top of the gicv3-virt patchset and is
sufficient to run a Linux 32-bit guest under 64-bit Linux host.

Git branch with the whole lot:
 https://git.linaro.org/people/peter.maydell/qemu-arm.git aarch32-guest


Peter Maydell (3):
  target/arm: A32, T32: Create Instruction Syndromes for Data Aborts
  target/arm: Handle VIRQ and VFIQ in arm_cpu_do_interrupt_aarch32()
  target/arm: Implement DBGVCR32_EL2 system register

 target/arm/helper.c    |  21 +++++
 target/arm/translate.c | 213 ++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 178 insertions(+), 56 deletions(-)

-- 
2.7.4
