Received: from eggs.gnu.org ([2001:4830:134:3::10]:49145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1egXQr-0000LC-Uc
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1egXQn-0005dK-Ur
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:02:45 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2018 15:02:15 +0000
Message-Id: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/7] target/arm: Implement M profile derived
 exceptions
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

In the Arm M-profile architecture, the process of taking or
returning from an exception can itself cause an exception
(for instance if there is an MPU permissions fault when
writing or reading the exception stack frame). This is called
a derived exception. Currently we don't implement this at
all in QEMU, instead just doing direct physical address
loads and stores which bypass MPU/SAU checks.

This patchset changes all the loads and stores we do on
exception entry and exit so that they do the MPU and SAU checks
and handle failures in the architecturally required way.

A note for reviewers: the way I've structured handling of
derived exceptions on exception entry diverges a bit from the
structure of the v8M Arm ARM pseudocode. In the pseudocode,
derived exceptions cause the attempt to process the original
exception to be abandoned (either without calling TakeException,
or bailing out of TakeException partway through). Then at the top
level the pseudocode calls DerivedLateArrival to prioritize the
derived exception and call TakeException from there.
For the QEMU implementation, I chose to let the NVIC do the
prioritization and continue forward, so that the call to
v7m_exception_taken() will then take either the original or the
erived exception. The effect is the same, but this structure works
better for QEMU, because we don't have a convenient top level place
to do the abandon-and-retry logic.

(The motivation for filling in this missing bit of functionality
is that the Zephyr RTOS would like to implement stack-overrun
checking on v7M cores using the MPU, so noticing permissions
failures when exceptions frames are written to the stack is
important.)

Peter Maydell (7):
  target/arm: Add armv7m_nvic_set_pending_derived()
  target/arm: Split "get pending exception info" from "acknowledge it"
  target/arm: Add ignore_stackfaults argument to v7m_exception_taken()
  target/arm: Make v7M exception entry stack push check MPU
  target/arm: Make v7m_push_callee_stack() honour MPU
  target/arm: Make exception vector loads honour the SAU
  target/arm: Handle exceptions during exception stack pop

 target/arm/cpu.h      |  32 ++++-
 hw/intc/armv7m_nvic.c |  98 +++++++++++--
 target/arm/helper.c   | 392 ++++++++++++++++++++++++++++++++++++++++----------
 hw/intc/trace-events  |   5 +-
 4 files changed, 435 insertions(+), 92 deletions(-)

-- 
2.7.4
