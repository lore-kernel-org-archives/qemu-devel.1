Received: from eggs.gnu.org ([2001:4830:134:3::10]:50350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVcol-0003Mp-2H
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVcok-00052r-1r
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:06:35 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:06:16 +0100
Message-Id: <20180620130619.11362-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Support M-profile MPU regions smaller than
 1K
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

The Arm M-profile MPU allows the guest to specify access
permissions at a very fine granularity (down to a 32-byte
alignment for region start and and addresses). Currently
we insist that regions are page-aligned because the core
TCG code can't handle anything else.

This patchset relaxes that restriction, so that we can handle
small MPU regions for reading and writing (but not yet for
execution). It does that by  marking the TLB entry for any
page which includes a small region with a flag TLB_RECHECK.
This flag causes us to always take the slow-path for accesses.
In the slow path we can then special case them to always call
tlb_fill() again, so we have the correct information for the
exact address being accessed.

Patch 1 adds support to the accel/tcg code. Patch 2 then
enables using it for the PMSAv7 (v7M) MPU, and patch 3
does the same for the PMSAv8 (v8M) MPU and SAU.
Because we don't yet support execution from small regions,
the PMSA code has some corner cases where it retains the
previous behaviour so we don't break previously-working
guests:
 * if the MPU region is small, we don't mark it PROT_EXEC
   even if the guest asked for it (so execution will cause
   an MPU exception)
 * we ignore the fact that the SAU region might be smaller
   than a page

(Unfortunately the old code *intended* to make small-region
accesses non-executable but due to bugs didn't actually
succeed in doing that, so this might possibly cause some
previously working-by-accident code to break.)
 
I would ideally in future like to add execution support, but
this is somewhat tricky. My rough sketch for it looks like:
 * get_page_addr_code() should return -1 for "not actually
   a full page of RAM" (deleting all the current tricky code
   for trying to handle it being a memory region or unmapped)
 * its callsites in the TB hashtable lookup code should handle
   -1 by returning "no TB found"
 * the weird call to get_page_addr_code() in the xtensa itlb_hit_test
   helper should be replaced by a call to tlb_fill() or some
   xtensa-internal function (I think all it is trying to do is
   cause the exceptions for MMU faults)
 * tb_gen_code() should in this case generate a one-instruction
   TB and tell its caller not to cache it
 * the translate.c code for targets that need this probably needs
   fixing up to make sure it can handle the case of "the load
   code byte/word/etc functions might return failure or cause
   an exception"

This would also have the advantage that it naturally allows
you to execute (slowly) from any MMIO region, and we could drop
the broken request-mmio-pointer machinery.

In any case that is too much for 3.0, I think; I'd like to get this
R/W small-region code into 3.0, though.

thanks
-- PMM

Peter Maydell (3):
  tcg: Support MMU protection regions smaller than TARGET_PAGE_SIZE
  target/arm: Set page (region) size in get_phys_addr_pmsav7()
  target/arm: Handle small regions in get_phys_addr_pmsav8()

 accel/tcg/softmmu_template.h |  24 ++++---
 include/exec/cpu-all.h       |   5 +-
 accel/tcg/cputlb.c           | 131 +++++++++++++++++++++++++++++------
 target/arm/helper.c          | 115 +++++++++++++++++++++---------
 4 files changed, 211 insertions(+), 64 deletions(-)

-- 
2.17.1
