Received: from eggs.gnu.org ([2001:4830:134:3::10]:57811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2gvx-0005U1-AY
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2gvw-00036i-Cy
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:33:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 17:33:32 +0100
Message-Id: <1493051615-30715-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC 0/3] split core mmu_idx from ARMMMUIdx values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

For M profile, we're eventually going to want some
new MMU index values:
     non secure User
     non secure Privileged
     non secure Privileged, execution priority < 0
     secure User
     secure Privileged
     secure Privileged, execution priority < 0

(currently we have ns User and ns Priv). Although we
can reasonably cleanly think of 4 of those as being
like A profile NS EL0/NS EL1/S EL0/S EL1, the "privileged
and execution priority is < 0" cases are entirely M profile
specific. This gives us two choices of implementation:

(1) Add new ARMMMUIdx values, bringing NB_MMU_MODES up to 9.
This is large enough that it would mean the size of a TLB on
MIPS, PPC and 32-bit ARM hosts would be halved.

(2) Allow A profile and M profile cores to allocate the mmu_idx
values to different semantics, since any particular CPU will
be definitely one kind or the other and doesn't need all 9.

This patchset is an RFC for choice (2), to see whether people
think it looks sufficiently maintainable. The idea is that
rather than just having
  ARMMMUIdx_S12NSE0 = 0,
  ARMMMUIdx_MUser = 0,
and relying on all the target/arm code to remember to disambiguate
(which seemed very error prone to me), we have different values:
    ARMMMUIdx_S12NSE0 = 0 | ARM_MMU_IDX_A,
    ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
so instead of ARMMMUIdx enum values being identical to core QEMU
MMU index values, they are now the core index values with some
high bits set. Any particular CPU always uses the same high
bits. New functions arm_to_core_mmu_idx() and core_to_arm_mmu_idx()
convert between the two.

This means that if a function that does
  switch (mmu_idx) {
  case ARMMMUIdx_S12NSE0:
  ...
  }
is inadvertently called with an M profile mmu index and it wasn't
expecting it, it will at least assert rather than just doing
something odd, and it doesn't have to explicitly look at the
feature bits to make a decision.

In general core index values are stored in 'int' types, and
ARM values are stored in ARMMMUIdx types. QEMU core code,
the TB flags value and the translate.c code which passes
mmu_idx values to gen_qemu_ld/st_* all use core index values,
and the rest uses ARMMMUIdx values.
    

Overall questions:
 * does this look like it's workable enough to justify taking
   it rather than the simple-but-worse-perf-on-some-archs
   option 1 ?
 * this does risk breaking A profile in corner cases, because
   C unfortunately doesn't typecheck int vs enum so if I forgot
   a call to an index conversion function somewhere things will
   break. are we happy the risk isn't too huge?


thanks
-- PMM

Peter Maydell (3):
  arm: Use the mmu_idx we're passed in arm_cpu_do_unaligned_access()
  arm: Add support for M profile CPUs having different MMU index
    semantics
  arm: Use different ARMMMUIdx values for M profile

 target/arm/cpu.h           |  77 ++++++++++++++++++----
 target/arm/translate.h     |   2 +-
 target/arm/helper.c        | 156 ++++++++++++++++++++++++---------------------
 target/arm/op_helper.c     |   3 +-
 target/arm/translate-a64.c |  18 ++++--
 target/arm/translate.c     |  13 ++--
 6 files changed, 171 insertions(+), 98 deletions(-)

-- 
2.7.4
