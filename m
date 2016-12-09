Received: from eggs.gnu.org ([2001:4830:134:3::10]:49716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cFO4H-0003TC-9R
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cFO4C-0007Yn-V4
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:30:41 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Dec 2016 16:30:16 +0000
Message-Id: <1481301020-21777-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] hw/arm/virt: 2.9 machtype,
 fix timer dt info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

This patchset fixes an error in how we were reporting the
architectural timers in the device tree for the virt board.
Old KVM host kernels (before 4.4) implemented these timers
as edge-triggered, which led us to decide to report them in
the DT as edge triggered. However in newer kernels this
was fixed and they're level triggered as they're architecturally
supposed to be.

Patch 4 fixes up the DT.
Patch 1 adds the 2.9 machine type so we can make the DT
 change only apply to new virt machine types
Patches 2 and 3 are a cleanup, so that we can have
 convenient access to the VirtMachineClass at the point
 in the code where we want to look at it. We collapse the
 VirtBoardInfo struct into the VirtMachineState, since
 the former mostly exists because at the time there was
 no VirtMachineState.

(Most of the diffstat is the result of s/vbi/vms/ on
the file to update variable names.)

Kernel behaviours as far as I know them:
 * host v4.3 and earlier: implemented timers as weird
   sort-of-edge-triggered semantics
 * host v4.4 and later: timers are level triggered
vs
 * guest pre-4.8: ignore the values in the DT, trust
   whatever the GIC's reset values are
 * guest 4.8 before rc6: write the DT values to the
   GIC config registers
 * guest newer than rc6 ignore the DT, and always write
   'level triggered' to the GIC

This combination means that (assuming that post 4.8
guest kernels work at all on pre 4.4 host kernels) I
don't expect this to break anything. Testing would probably
be a good idea, though: I plan to do some more combinations
but kernel builds on my aarch64 system are slow so I
thought I'd send out the patchset before I went home today...

Peter Maydell (4):
  hw/arm/virt: add 2.9 machine type
  hw/arm/virt: Merge VirtBoardInfo and VirtMachineState
  hw/arm/virt: Rename 'vbi' variables to 'vms'
  hw/arm/virt: Don't incorrectly claim architectural timer to be
    edge-triggered

 include/hw/compat.h |   3 +
 hw/arm/virt.c       | 616 +++++++++++++++++++++++++++-------------------------
 2 files changed, 323 insertions(+), 296 deletions(-)

-- 
2.7.4
