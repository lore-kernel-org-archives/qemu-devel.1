Received: from eggs.gnu.org ([2001:4830:134:3::10]:54051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK35-0003U5-3O
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK31-0004tZ-Qd
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:10 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:32992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK31-0004t4-Bs
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id f19-v6so9798029wmb.0
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:46 +0100
Message-Id: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 00/17] tcg: Move softmmu out-of-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

Based on an idea forwarded by Emilio, which suggests a 5-6%
speed gain is possible.  I have not spent too much time
measuring this, as the code size gains are significant.

I believe that I posted an x86_64-only patch some time ago,
but this now includes i386, aarch64 and arm32.  In late
testing I do some failures on i386, for sparc guest.  I'll
follow up on that later.

The main feature here is sharing code to place these out-of-line
thunks.  We want them to be within a direct call.  Once we've
emitted a thunk we remember (at least within a given tcg_region)
reusing it until we find that the relocation is out of range.
At which point we generate another copy.

The second main change is that the entire TCGMemOpIdx is built
into each thunk.  There simply are not enough free registers for
i386 (or arm32 for that matter) to pass in the mmu_idx to the thunk.

For x86, this displacement is 2GB, and we've already constrained
the whole code_gen_buffer to be in range.  For aarch64, this
displacement is 128MB; for arm32 it is 16MB.  In every case,
the range is significant, and for any smp guest may well cover
the entire tcg_region.

Other than these three targets, I have compile-tested the generic
change on ppc64le.  I have not even compile-tested mips, s390x,
or sparc host.


r~


Richard Henderson (17):
  tcg/i386: Add constraints for r8 and r9
  tcg/i386: Return a base register from tcg_out_tlb_load
  tcg/i386: Change TCG_REG_L[01] to not overlap function arguments
  tcg/i386: Force qemu_ld/st arguments into fixed registers
  tcg: Return success from patch_reloc
  tcg: Add TCG_TARGET_NEED_LDST_OOL_LABELS
  tcg/i386: Use TCG_TARGET_NEED_LDST_OOL_LABELS
  tcg/aarch64: Add constraints for x0, x1, x2
  tcg/aarch64: Parameterize the temps for tcg_out_tlb_read
  tcg/aarch64: Parameterize the temp for tcg_out_goto_long
  tcg/aarch64: Use B not BL for tcg_out_goto_long
  tcg/aarch64: Use TCG_TARGET_NEED_LDST_OOL_LABELS
  tcg/arm: Parameterize the temps for tcg_out_tlb_read
  tcg/arm: Add constraints for R0-R5
  tcg/arm: Reduce the number of temps for tcg_out_tlb_read
  tcg/arm: Force qemu_ld/st arguments into fixed registers
  tcg/arm: Use TCG_TARGET_NEED_LDST_OOL_LABELS

 tcg/aarch64/tcg-target.h     |   2 +-
 tcg/arm/tcg-target.h         |   2 +-
 tcg/i386/tcg-target.h        |   2 +-
 tcg/tcg.h                    |   4 +
 tcg/aarch64/tcg-target.inc.c | 318 +++++++++---------
 tcg/arm/tcg-target.inc.c     | 535 +++++++++++++++---------------
 tcg/i386/tcg-target.inc.c    | 611 ++++++++++++++++++++---------------
 tcg/mips/tcg-target.inc.c    |  29 +-
 tcg/ppc/tcg-target.inc.c     |  47 +--
 tcg/s390/tcg-target.inc.c    |  37 ++-
 tcg/sparc/tcg-target.inc.c   |  13 +-
 tcg/tcg-ldst-ool.inc.c       |  94 ++++++
 tcg/tcg-pool.inc.c           |   5 +-
 tcg/tcg.c                    |  28 +-
 tcg/tci/tcg-target.inc.c     |   3 +-
 15 files changed, 974 insertions(+), 756 deletions(-)
 create mode 100644 tcg/tcg-ldst-ool.inc.c

-- 
2.17.2
