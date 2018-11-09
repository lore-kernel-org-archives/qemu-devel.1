Received: from eggs.gnu.org ([2001:4830:134:3::10]:37688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gL78h-0001Pp-85
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gL78e-0007xU-Be
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:47:58 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Nov 2018 13:47:28 +0000
Message-Id: <20181109134731.11605-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-v3.1 0/3] Fix handling of HCR.VI and VF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Adam Lackorzynski <adam.lackorzynski@kernkonzept.com>

This patchset reverts commit 8a0fc3a29fc2315325400, which tried
to implement HCR.VI and VF, and then reimplements it correctly.

The implementation of HCR.VI and VF in that commit is not
correct -- they do not track the overall "is there a pending
VIRQ or VFIQ" status, but whether there is a pending interrupt
due to "this mechanism", ie the hypervisor having set the VI/VF
bits. The overall pending state for VIRQ and VFIQ is effectively
the logical OR of the inbound lines from the GIC with the
VI and VF bits. Commit 8a0fc3a29fc231 would result in pending
VIRQ/VFIQ possibly being lost when the hypervisor wrote to HCR.

Patch 1 reverts the broken implementation.
Patch 2 adds tracking of the state of the input lines from the
GIC (most of the complexity here is from having to handle
inbound migration from older QEMU versions).
Patch 3 implements HCR.{VI,VF} correctly.

I plan to put the revert into rc1 at least, because it
fixes a regression.

thanks
-- PMM

Peter Maydell (3):
  Revert "target/arm: Implement HCR.VI and VF"
  target/arm: Track the state of our irq lines from the GIC explicitly
  target/arm: Correctly implement handling of HCR_EL2.{VI,VF}

 target/arm/cpu.h       |  3 ++
 target/arm/internals.h | 18 ++++++++++++
 target/arm/cpu.c       | 64 +++++++++++++++++++++++++++++++++++++++++-
 target/arm/helper.c    | 57 +++++++++++--------------------------
 target/arm/machine.c   | 51 +++++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+), 41 deletions(-)

-- 
2.19.1
