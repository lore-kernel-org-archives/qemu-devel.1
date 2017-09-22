Received: from eggs.gnu.org ([2001:4830:134:3::10]:46834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQV-0007sX-1l
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQU-000415-B0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:35 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 15:59:47 +0100
Message-Id: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 00/20] ARM v8M: exception entry,
 exit and security
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

Another week, another set of v8M patches.
This lot adds:
 * v8M and security extension changes in exception entry and exit
 * the Security Attribution Unit
 * SG and BLXNS instructions
 * secure function return
 * and a couple of fixes for bugs in already-in-master changes

Most of this is just plodding through fairly obvious implementation,
but the handling of the SG instruction is a bit funky (see commit
messages in those patches for detail).

This is very nearly enough to get the mbed uvisor example
running (on a hacked-up mps2 setup): I think the main missing
piece for that is that it expects the banked systick device,
which we haven't implemented yet. (There are also various
missing things that I don't think the uvisor exercises.)

thanks
-- PMM

Peter Maydell (20):
  nvic: Clear the vector arrays and prigroup on reset
  target/arm: Don't switch to target stack early in v7M exception return
  target/arm: Prepare for CONTROL.SPSEL being nonzero in Handler mode
  target/arm: Restore security state on exception return
  target/arm: Restore SPSEL to correct CONTROL register on exception
    return
  target/arm: Check for xPSR mismatch usage faults earlier for v8M
  target/arm: Warn about restoring to unaligned stack
  target/arm: Don't warn about exception return with PC low bit set for
    v8M
  target/arm: Add new-in-v8M SFSR and SFAR
  target/arm: Update excret sanity checks for v8M
  target/arm: Add support for restoring v8M additional state context
  target/arm: Add v8M support to exception entry code
  nvic: Implement Security Attribution Unit registers
  target/arm: Implement security attribute lookups for memory accesses
  target/arm: Fix calculation of secure mm_idx values
  target/arm: Factor out "get mmuidx for specified security state"
  target/arm: Implement SG instruction
  target/arm: Implement BLXNS
  target/arm: Implement secure function return
  nvic: Add missing code for writing SHCSR.HARDFAULTPENDED bit

 target/arm/cpu.h       |  60 ++-
 target/arm/helper.h    |   1 +
 target/arm/internals.h |  23 ++
 hw/intc/armv7m_nvic.c  | 158 +++++++-
 target/arm/cpu.c       |  27 ++
 target/arm/helper.c    | 970 ++++++++++++++++++++++++++++++++++++++++++++-----
 target/arm/machine.c   |  16 +
 target/arm/translate.c |  31 +-
 8 files changed, 1181 insertions(+), 105 deletions(-)

-- 
2.7.4
