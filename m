Received: from eggs.gnu.org ([2001:4830:134:3::10]:55234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeJ-0007xJ-MR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeI-0002oR-Pn
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 15:42:25 +0100
Message-Id: <20181012144235.19646-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/10] target/arm: more HCR bits,
 improve syndrome reporting
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

I'm currently trying to track down why my AArch32 Hyp mode
test images don't work, and thought I'd start by patching
a few of the holes we have in our implementation. (Haven't
found the problem yet, sadly.)

This patchset:
 * implements HCR.{FB,DC,VI,VF,PTW}
 * fixes ISR_EL1 in the virtual-interrupts case
 * fixes some syndrome reporting corner cases where AArch32
   or v7 differ from AArch64/v8
 * throws in a couple of minor code cleanups

The remaining unimplemented HCR trap bits (as of v8.0) are:
 * TID0 TID1 TID2 TID3 TIDCP TAC TSW TPC TPU TTLB TVM TRVM TDZ
   -- these are all "trap on various system register accesses"
 * AMO VA
   -- these require support for presenting the guest with a
      virtual asynchronous abort/SError

(We also don't yet implement HCR.TASE, which is interesting
because it requires trapping ASIMD-but-not-FP, which we don't
currently have support for in translate.c. This would also
be needed for CPACR.ASEDIS.)

thanks
-- PMM

Peter Maydell (10):
  target/arm: Improve debug logging of AArch32 exception return
  target/arm: Make switch_mode() file-local
  target/arm: Implement HCR.FB
  target/arm: Implement HCR.DC
  target/arm: ISR_EL1 bits track virtual interrupts if IMO/FMO set
  target/arm: Implement HCR.VI and VF
  target/arm: Implement HCR.PTW
  target/arm: New utility function to extract EC from syndrome
  target/arm: Get IL bit correct for v7 syndrome values
  target/arm: Report correct syndrome for FP/SIMD traps to Hyp mode

 target/arm/internals.h |  45 +++++-
 target/arm/helper.c    | 347 ++++++++++++++++++++++++++++++-----------
 target/arm/kvm64.c     |   2 +-
 target/arm/op_helper.c |   2 +-
 target/arm/translate.c |  15 +-
 5 files changed, 302 insertions(+), 109 deletions(-)

-- 
2.19.0
