Received: from eggs.gnu.org ([2001:4830:134:3::10]:39761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ddgHX-0007Eb-EW
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ddgHW-0001V7-3L
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:21:03 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 Aug 2017 18:20:41 +0100
Message-Id: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/8] Implement ARM external abort handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

Following recent list discussion
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00063.html

here's a patchseries which defines a new API for handling CPU memory
transaction failures at the right level in the memory subsystem code,
and implements it for ARM so that we can generate prefetch abort and
data abort exceptions for external aborts.

The first 3 patches here implement the core code support
for the new cpu_transaction_failed_hook.

The next 2 patches add support for turning it off on
a per-board basis, and use that to go back to RAZ/WI
on the legacy ARM board models, because right now we rely
on that so that guest code doesn't blow up when it touches
a device we don't have a model for yet. (We leave the
support enabled for 'virt' and 'mps2'.)

Finally the last 3 patches do some cleanup and then
implement the new hook for ARM.

(I have not as yet audited the target/arm code to check that
we correctly handle failed transactions in all the places
that C code does physical address accesses; but since those
lookups don't generate exceptions today, the series leaves
behaviour there no worse off than they were before.)

thanks
-- PMM

Peter Maydell (8):
  memory.h: Move MemTxResult type to memattrs.h
  cpu: Define new cpu_transaction_failed() hook
  cputlb: Support generating CPU exceptions on memory transaction
    failures
  boards.h: Define new flag ignore_memory_transaction_failures
  hw/arm: Set ignore_memory_transaction_failures for most ARM boards
  target/arm: Factor out fault delivery code
  target/arm: Allow deliver_fault() caller to specify EA bit
  target/arm: Implement new do_transaction_failed hook

 include/exec/memattrs.h |  10 ++++
 include/exec/memory.h   |  10 ----
 include/hw/boards.h     |  11 ++++
 include/qom/cpu.h       |  26 ++++++++
 softmmu_template.h      |   4 +-
 target/arm/internals.h  |  12 ++++
 accel/tcg/cputlb.c      |  32 +++++++++-
 hw/arm/aspeed.c         |   3 +
 hw/arm/collie.c         |   1 +
 hw/arm/cubieboard.c     |   1 +
 hw/arm/digic_boards.c   |   1 +
 hw/arm/exynos4_boards.c |   2 +
 hw/arm/gumstix.c        |   2 +
 hw/arm/highbank.c       |   2 +
 hw/arm/imx25_pdk.c      |   1 +
 hw/arm/integratorcp.c   |   1 +
 hw/arm/kzm.c            |   1 +
 hw/arm/mainstone.c      |   1 +
 hw/arm/musicpal.c       |   1 +
 hw/arm/netduino2.c      |   1 +
 hw/arm/nseries.c        |   2 +
 hw/arm/omap_sx1.c       |   2 +
 hw/arm/palm.c           |   1 +
 hw/arm/raspi.c          |   1 +
 hw/arm/realview.c       |   4 ++
 hw/arm/sabrelite.c      |   1 +
 hw/arm/spitz.c          |   4 ++
 hw/arm/stellaris.c      |   2 +
 hw/arm/tosa.c           |   1 +
 hw/arm/versatilepb.c    |   2 +
 hw/arm/vexpress.c       |   1 +
 hw/arm/xilinx_zynq.c    |   1 +
 hw/arm/xlnx-ep108.c     |   2 +
 hw/arm/z2.c             |   1 +
 qom/cpu.c               |   7 +++
 target/arm/cpu.c        |   1 +
 target/arm/op_helper.c  | 155 +++++++++++++++++++++++++++++++-----------------
 37 files changed, 243 insertions(+), 68 deletions(-)

-- 
2.7.4
