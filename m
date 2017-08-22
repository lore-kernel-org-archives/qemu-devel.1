Received: from eggs.gnu.org ([2001:4830:134:3::10]:53404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnp-0006Vb-Vx
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnj-00039I-J0
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:13 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:39 +0100
Message-Id: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 00/20] first steps towards v8M support
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

Hi; this patchset is the first slice of work aiming at support
of the ARM v8M architecture. It doesn't do anything by itself
(there's no CPU yet that enables the new feature) and there's
a lot more work still to do to get something actually functional,
but it seems better to push the work out for review a slice
at a time rather than hanging onto it and sending a 100-patch
set at the end.

This patchset sits on top of my target-arm.next tree, which
has the 'preliminary patchset' I sent out a while back in it.

It includes:
 * implementation of PMSAv8
 * banking of most of the main CPU registers which need it
   (the NVIC proper also gets banked exceptions, and the
   systick device is banked, but neither of those are done here)
 * the "let secure access the NS view of the NVIC" alias region
 * an implementation of the BXNS instruction, mostly as the
   simplest thing that needs the banking of stack pointers

We don't yet actually properly swap the stack pointer around
on other kinds of S<->NS transition including exception
entry and exit. I have some patches working in that direction,
so if the BXNS patch doesn't have enough context yet to make
sense I can keep it around and resend it with those later.

Next thing probably will be the NVIC changes, once I've
got my head around the priority related changes v8M brings...

Series available also at 
https://git.linaro.org/people/peter.maydell/qemu-arm.git v8m
(on top of the target-arm.next stuff.)

thanks
-- PMM

Peter Maydell (20):
  target/arm: Implement ARMv8M's PMSAv8 registers
  target/arm: Implement new PMSAv8 behaviour
  target/arm: Add state field, feature bit and migration for v8M secure
    state
  target/arm: Register second AddressSpace for secure v8M CPUs
  target/arm: Add MMU indexes for secure v8M
  target/arm: Make BASEPRI register banked for v8M
  target/arm: Make PRIMASK register banked for v8M
  target/arm: Make FAULTMASK register banked for v8M
  target/arm: Make CONTROL register banked for v8M
  nvic: Add NS alias SCS region
  target/arm: Make VTOR register banked for v8M
  target/arm: Make MPU_MAIR0, MPU_MAIR1 registers banked for v8M
  target/arm: Make MPU_RBAR, MPU_RLAR banked for v8M
  target/arm: Make MPU_RNR register banked for v8M
  target/arm: Make MPU_CTRL register banked for v8M
  target/arm: Make CCR register banked for v8M
  target/arm: Make MMFAR banked for v8M
  target/arm: Make CFSR register banked for v8M
  target/arm: Move regime_is_secure() to target/arm/internals.h
  target/arm: Implement BXNS, and banked stack pointers

 include/hw/intc/armv7m_nvic.h |   1 +
 target/arm/cpu.h              | 100 ++++++++++++--
 target/arm/helper.h           |   2 +
 target/arm/internals.h        |  26 ++++
 target/arm/translate.h        |   1 +
 hw/intc/armv7m_nvic.c         | 294 +++++++++++++++++++++++++++++++++------
 target/arm/cpu.c              |  82 ++++++++---
 target/arm/helper.c           | 315 +++++++++++++++++++++++++++++++++---------
 target/arm/machine.c          | 104 ++++++++++++--
 target/arm/translate.c        |  52 ++++++-
 10 files changed, 820 insertions(+), 157 deletions(-)

-- 
2.7.4
