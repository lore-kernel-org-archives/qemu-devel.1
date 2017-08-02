Received: from eggs.gnu.org ([2001:4830:134:3::10]:49699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwlG-0003hm-GZ
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwlF-0004ut-HR
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  2 Aug 2017 17:43:46 +0100
Message-Id: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 00/15] v7M: cleanups and bugfixes prior to v8M
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

(This is 2.11 material, obviously, but it's a coherent and
large enough set of patches that I figured I might as well
push it out for review now.)

This patchset is a collection of cleanups, bugfixes, etc to
the existing v7M code which are either necessary preliminary
to implementing v8M or just things I noticed along the way.
The non-trivial stuff is:
 * migration for M profile is shifted to not use read_cpsr()
   and write_cpsr() which assume A profile semantics
   (back compatibility with old migration state is maintained)
 * we implement the "user accesses should BusFault" behaviour
   for the memory mapped registers in the SCS, though this
   won't actually kick in until we turn MEMTX_ERROR into a
   BusFault (I have patches for that)

thanks
-- PMM

Peter Maydell (15):
  target/arm: Use MMUAccessType enum rather than int
  target/arm: Don't trap WFI/WFE for M profile
  target/arm: Consolidate PMSA handling in get_phys_addr()
  target/arm: Tighten up Thumb decode where new v8M insns will be
  hw/intc/armv7m_nvic.c: Remove out of date comment
  target/arm: Remove incorrect comment about MPU_CTRL
  target/arm: Fix outdated comment about exception exit
  target/arm: Define and use XPSR bit masks
  target/arm: Don't store M profile PRIMASK and FAULTMASK in daif
  target/arm: Don't use cpsr_write/cpsr_read to transfer M profile XPSR
  target/arm: Make arm_cpu_dump_state() handle the M-profile XPSR
  target/arm: Don't calculate lr in arm_v7m_cpu_do_interrupt() until
    needed
  target/arm: Create and use new function arm_v7m_is_handler_mode()
  armv7m_nvic.h: Move from include/hw/arm to include/hw/intc
  nvic: Implement "user accesses BusFault" SCS region behaviour

 hw/intc/armv7m_nvic.c                  |  68 +++++++++++-------
 include/hw/arm/armv7m.h                |   2 +-
 include/hw/{arm => intc}/armv7m_nvic.h |   0
 target/arm/cpu.c                       |   5 --
 target/arm/cpu.h                       |  54 ++++++++++----
 target/arm/helper.c                    | 124 ++++++++++++++++-----------------
 target/arm/internals.h                 |   3 +-
 target/arm/machine.c                   |  54 +++++++++++++-
 target/arm/op_helper.c                 |   5 ++
 target/arm/translate.c                 | 106 +++++++++++++++++++++-------
 10 files changed, 286 insertions(+), 135 deletions(-)
 rename include/hw/{arm => intc}/armv7m_nvic.h (100%)

-- 
2.7.4
