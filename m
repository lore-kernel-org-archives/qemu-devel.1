Received: from eggs.gnu.org ([2001:4830:134:3::10]:43608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d3QVM-00027H-W5
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d3QVM-0000Nz-5o
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:13:28 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 18:13:09 +0100
Message-Id: <1493226792-3237-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] gicv3: Correct mishandling of NS BPR1
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

I happened to be looking at the GICv3 spec and our implementation,
and I realized that we don't correctly calculate the mask values
to get group priorities based on BPR values if the NS BPR1 is
being used. This BPR, unlike the S BPR1 or the BPR0, has
off-by-one semantics, so instead of "use bits [7:1]" being
bpr == 0, it is bpr == 1, and so on, with an NS BPR1 value of
0 being impossible.

Patch 3 in this set fixes this error, and fixes the comments
so they're actually accurate. Patches 1 and 2 are preliminary
bug fixes which ensure that the NS BPR1 values are actually
constrained to be greater than 0, so that the assert()s added
in patch 3 can't fire.

I'm sending this as the last thing before I head out of the
door, so will respond to review comments in June...

thanks
-- PMM


Peter Maydell (3):
  hw/intc/arm_gicv3_cpuif: Fix reset value for VMCR_EL2.VBPR1
  hw/intc/arm_gicv3_cpuif: Don't let BPR be set below its minimum
  hw/intc/arm_gicv3_cpuif: Fix priority masking for NS BPR1

 hw/intc/arm_gicv3_cpuif.c | 49 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

-- 
2.7.4
