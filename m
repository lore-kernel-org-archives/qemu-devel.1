Received: from eggs.gnu.org ([2001:4830:134:3::10]:45870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5D-0000vw-QH
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W55-0006uc-Ux
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W53-0006iu-Oz
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W4t-0003ds-Tl
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:31 +0100
Message-Id: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/33] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue: the big things in here are SVE in system
emulation mode, and v8M stack limit checking; there are
also a handful of smaller fixes.

thanks
-- PMM

The following changes since commit 079911cb6e26898e16f5bb56ef4f9d33cf92d32d:

  Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20181005' into staging (2018-10-08 12:44:35 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181008

for you to fetch changes up to 74e2e59b8d0a68be0956310fc349179c89fd7be0:

  hw/display/bcm2835_fb: Silence Coverity warning about multiply overflow (2018-10-08 14:55:05 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: fix error in a code comment
 * virt: Suppress external aborts on virt-2.10 and earlier
 * target/arm: Correct condition for v8M callee stack push
 * target/arm: Don't read r4 from v8M exception stackframe twice
 * target/arm: Support SVE in system emulation mode
 * target/arm: Implement v8M hardware stack limit checking
 * hw/display/bcm2835_fb: Silence Coverity warning about multiply overflow

----------------------------------------------------------------
Dongjiu Geng (1):
      target/arm: fix code comments error

Peter Maydell (17):
      virt: Suppress external aborts on virt-2.10 and earlier
      target/arm: Correct condition for v8M callee stack push
      target/arm: Don't read r4 from v8M exception stackframe twice
      target/arm: Define new TBFLAG for v8M stack checking
      target/arm: Define new EXCP type for v8M stack overflows
      target/arm: Move v7m_using_psp() to internals.h
      target/arm: Add v8M stack checks on ADD/SUB/MOV of SP
      target/arm: Add some comments in Thumb decode
      target/arm: Add v8M stack checks on exception entry
      target/arm: Add v8M stack limit checks on NS function calls
      target/arm: Add v8M stack checks for LDRD/STRD (imm)
      target/arm: Add v8M stack checks for Thumb2 LDM/STM
      target/arm: Add v8M stack checks for T32 load/store single
      target/arm: Add v8M stack checks for Thumb push/pop
      target/arm: Add v8M stack checks for VLDM/VSTM
      target/arm: Add v8M stack checks for MSR to SP_NS
      hw/display/bcm2835_fb: Silence Coverity warning about multiply overflow

Richard Henderson (15):
      target/arm: Define ID_AA64ZFR0_EL1
      target/arm: Adjust sve_exception_el
      target/arm: Pass in current_el to fp and sve_exception_el
      target/arm: Handle SVE vector length changes in system mode
      target/arm: Adjust aarch64_cpu_dump_state for system mode SVE
      target/arm: Clear unused predicate bits for LD1RQ
      target/arm: Rewrite helper_sve_ld1*_r using pages
      target/arm: Rewrite helper_sve_ld[234]*_r
      target/arm: Rewrite helper_sve_st[1234]*_r
      target/arm: Split contiguous loads for endianness
      target/arm: Split contiguous stores for endianness
      target/arm: Rewrite vector gather loads
      target/arm: Rewrite vector gather stores
      target/arm: Rewrite vector gather first-fault loads
      target/arm: Pass TCGMemOpIdx to sve memory helpers

 target/arm/cpu.h           |   17 +
 target/arm/helper-sve.h    |  385 ++++++---
 target/arm/helper.h        |    2 +
 target/arm/internals.h     |   44 +
 target/arm/kvm_arm.h       |    4 +-
 target/arm/translate.h     |    1 +
 hw/arm/virt.c              |    2 +
 hw/display/bcm2835_fb.c    |    2 +-
 target/arm/cpu64.c         |   42 -
 target/arm/helper.c        |  345 +++++---
 target/arm/kvm.c           |    2 +-
 target/arm/op_helper.c     |   24 +-
 target/arm/sve_helper.c    | 1961 ++++++++++++++++++++++++++++++--------------
 target/arm/translate-a64.c |    8 +-
 target/arm/translate-sve.c |  670 ++++++++++-----
 target/arm/translate.c     |  198 ++++-
 16 files changed, 2611 insertions(+), 1096 deletions(-)
