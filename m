Received: from eggs.gnu.org ([2001:4830:134:3::10]:60457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZNaY-0000A2-Ds
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZNaX-0007yy-6n
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:02:38 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Feb 2017 20:02:13 +0000
Message-Id: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/9] Rewrite NVIC to not depend on the GIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>

This patchset is the revamp of the NVIC code from Michael
Davidsaver's patchset of a year ago.

Despite some superficial similarities of register layout, the
M-profile NVIC is really very different from the A-profile GIC.  Our
current attempt to reuse the GIC code means that we have significant
bugs in our NVIC.  The series pulls the NVIC apart from the GIC code
(fixing a few accidental bugs in the process), and then once it has a
place to stand, implements a few minor cleanups, a key bugfix
(getting priority calculations and masking right) and a missing
feature (escalation to HardFault).

I've tried to separate things out into their own patches where I
could, but the core 'rewrite NVIC' patch itself is still 592
insertions(+), 144 deletions(-), and there's not much to be done
about that since we don't want to break functionality in the process.

This patch series doesn't include the "check exception return
consistency" changes that Michael's original patch set had, because I
need to do more work on those and there's no need to make this series
any bigger.

I want to pull SysTick out into its own device object, so there are
some foundations for that here (mostly that we leave the container
memory object in place even though it only has one thing inside it
now).

For testing, I have used the Stellaris image I have to hand:
http://people.linaro.org/~peter.maydell/stellaris.tgz
and also a set of bare-metal test programs also written by
Michael. You can find my slightly tweaked and cleand up
version of those here (a README explains how to run them):
https://git.linaro.org/people/peter.maydell/m-profile-tests.git

Further testing welcome.

thanks
-- PMM

Michael Davidsaver (5):
  armv7m: Rewrite NVIC to not use any GIC code
  arm: gic: Remove references to NVIC
  armv7m: Escalate exceptions to HardFault if necessary
  armv7m: Simpler and faster exception start
  armv7m: VECTCLRACTIVE and VECTRESET are UNPREDICTABLE

Peter Maydell (4):
  armv7m: Rename nvic_state to NVICState
  armv7m: Implement reading and writing of PRIGROUP
  armv7m: Fix condition check for taking exceptions
  armv7m: Remove unused armv7m_nvic_acknowledge_irq() return value

 hw/intc/gic_internal.h   |   7 +-
 target/arm/cpu.h         |  10 +-
 hw/intc/arm_gic.c        |  31 +-
 hw/intc/arm_gic_common.c |  23 +-
 hw/intc/armv7m_nvic.c    | 843 +++++++++++++++++++++++++++++++++++++----------
 target/arm/cpu.c         |  16 +-
 target/arm/helper.c      |  17 +-
 hw/intc/trace-events     |  15 +
 8 files changed, 726 insertions(+), 236 deletions(-)

-- 
2.7.4
