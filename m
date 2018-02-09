Received: from eggs.gnu.org ([2001:4830:134:3::10]:40896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0A-0003uk-Az
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC09-0007jt-C3
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:18 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 16:57:59 +0000
Message-Id: <20180209165810.6668-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/11] v8m: minor missing regs and bugfixes
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

This patchset is the result of comparing the registers
listed in the v8M Arm ARM against what QEMU was implementing.
It adds a collection of generally unexciting missing registers
(most of which we can simply NOP or make reads-as-written).
There are also a couple of bug fixes in there, of which the
worst is the byte-to-interrupt-number conversions being
completely wrong in several places.

Version 2 adds 3 new patches at the end:
 * we had a couple of things we were forgetting to migrate
 * implementation of MSPLIM and PSPLIM, which were the missing
   special registers

I've updated the cache ID registers patch to use some constants
for register bit fields; otherwise the first 8 patches are the
same as v1. The derived-exceptions patches are in master now,
so this should apply to master.

thanks
-- PMM

Peter Maydell (11):
  hw/intc/armv7m_nvic: Don't hardcode M profile ID registers in NVIC
  hw/intc/armv7m_nvic: Fix ICSR PENDNMISET/CLR handling
  hw/intc/armv7m_nvic: Implement M profile cache maintenance ops
  hw/intc/armv7m_nvic: Implement v8M CPPWR register
  hw/intc/armv7m_nvic: Implement cache ID registers
  hw/intc/armv7m_nvic: Implement SCR
  target/arm: Implement writing to CONTROL_NS for v8M
  hw/intc/armv7m_nvic: Fix byte-to-interrupt number conversions
  target/arm: Add AIRCR to vmstate struct
  target/arm: Migrate v7m.other_sp
  target/arm: Implement v8M MSPLIM and PSPLIM registers

 target/arm/cpu.h      | 35 ++++++++++++++++++
 hw/intc/armv7m_nvic.c | 98 ++++++++++++++++++++++++++++++++++++++-------------
 target/arm/cpu.c      | 28 +++++++++++++++
 target/arm/helper.c   | 56 +++++++++++++++++++++++++++++
 target/arm/machine.c  | 84 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 276 insertions(+), 25 deletions(-)

-- 
2.16.1
