Received: from eggs.gnu.org ([2001:4830:134:3::10]:58459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYw9G-0008Ms-3v
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYw9F-0002Dk-9Y
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:21:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYw9F-0002Aa-1V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:21:25 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 17:21:20 +0100
Message-Id: <20180629162122.19376-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] tcg: fix TLB miss check in
 get_page_addr_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

In commit 71b9a45330fe220d1 we changed the condition we use to
determine whether we need to refill the TLB in get_page_addr_code() to
        if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
                     (addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK)))) {

This isn't the right check (it will falsely fail if the
input addr happens to have the low bit corresponding to
TLB_INVALID_MASK set, for instance).

This patchset first factors out the "check for a hit" logic
into some new functions tlb_hit() and tlb_hit_page() (the
latter is for when the address is known to be page-aligned),
uses those functions in the various places that do TLB hit tests,
and then uses tlb_hit() to replace the erroneous code in
get_page_addr_code().

I noticed this while trying to debug Laurent's m68k test case:
it meant that we would come into get_page_addr_code() for a
TLB hit, falsely decide it was a miss, and then fish an
older entry out of the TLB victim cache...


Peter Maydell (2):
  tcg: Define and use new tlb_hit() and tlb_hit_page() functions
  accel/tcg: Correct "is this a TLB miss" check in get_page_addr_code()

 accel/tcg/softmmu_template.h | 16 ++++++----------
 include/exec/cpu-all.h       | 23 +++++++++++++++++++++++
 include/exec/cpu_ldst.h      |  3 +--
 accel/tcg/cputlb.c           | 18 ++++++------------
 4 files changed, 36 insertions(+), 24 deletions(-)

-- 
2.17.1
