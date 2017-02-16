Received: from eggs.gnu.org ([2001:4830:134:3::10]:56451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2i-0008RE-EV
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2h-0007iy-D6
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:28 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 16:35:50 +0000
Message-Id: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/13] Rewrite NVIC to not depend on the GIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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

For testing, I have used the Stellaris image I have to hand:
http://people.linaro.org/~peter.maydell/stellaris.tgz
and also a set of bare-metal test programs also written by
Michael. You can find my slightly tweaked and cleand up
version of those here (a README explains how to run them):
https://git.linaro.org/people/peter.maydell/m-profile-tests.git

Changes v1->v2:
 * clarify a few comments
 * rephrase loops in nvic_sysreg_read() and nvic_sysreg_write()
 * checked RETTOBASE semantics vs various docs; the existing
   code seems to best match, but flipped our choice of behaviour
   in the UNKNOWN "no interrupt" case to match the M3's choice,
   and expanded the comment.
New patches in v2:
 * patches 10, 11 implement the exception return integrity check logic
 * patch 12 fixes a minor bug in reporting attempts to run ARM code
 * Patch 13 implements writing of SHCSR active and pending bits
   (mostly useful for test code that puts the CPU in weird states
   like deactivating the current active interrupt)

Patches needing review: 3, 10, 11, 12, 13.

I've also updated the m-profile-tests test code to add
tests for the exception return integrity checks.

(Next after this I have a dozen or so patches which QOMify
the armv7m container and otherwise bring that code up to
date with how we do objects these days.)

thanks
-- PMM

Michael Davidsaver (5):
  armv7m: Rewrite NVIC to not use any GIC code
  arm: gic: Remove references to NVIC
  armv7m: Escalate exceptions to HardFault if necessary
  armv7m: Simpler and faster exception start
  armv7m: VECTCLRACTIVE and VECTRESET are UNPREDICTABLE

Peter Maydell (8):
  armv7m: Rename nvic_state to NVICState
  armv7m: Implement reading and writing of PRIGROUP
  armv7m: Fix condition check for taking exceptions
  armv7m: Remove unused armv7m_nvic_acknowledge_irq() return value
  armv7m: Extract "exception taken" code into functions
  armv7m: Check exception return consistency
  armv7m: Raise correct kind of UsageFault for attempts to execute ARM
    code
  armv7m: Allow SHCSR writes to change pending and active bits

 hw/intc/gic_internal.h   |   7 +-
 target/arm/cpu.h         |  23 +-
 hw/intc/arm_gic.c        |  31 +-
 hw/intc/arm_gic_common.c |  23 +-
 hw/intc/armv7m_nvic.c    | 885 +++++++++++++++++++++++++++++++++++++----------
 linux-user/main.c        |   1 +
 target/arm/cpu.c         |  16 +-
 target/arm/helper.c      | 245 +++++++++----
 target/arm/translate.c   |   8 +-
 hw/intc/trace-events     |  15 +
 10 files changed, 954 insertions(+), 300 deletions(-)

-- 
2.7.4
