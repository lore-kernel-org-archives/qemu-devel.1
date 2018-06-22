Received: from eggs.gnu.org ([2001:4830:134:3::10]:35258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWMa4-0003fR-2p
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWMa3-0002an-9Y
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:58:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWMa2-0002ad-W8
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:58:27 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 14:58:23 +0100
Message-Id: <20180622135823.32421-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH] xtensa: Avoid calling get_page_addr_code()
 from helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>

The xtensa frontend calls get_page_addr_code() from its
itlb_hit_test helper function. This function is really part
of the TCG core's internals, and calling it from a target
helper makes it awkward to make changes to that core code.
It also means that we don't pass the correct retaddr to
tlb_fill(), so we won't correctly handle the case where
an exception is generated.

The helper is used for the instructions IHI, IHU and IPFL.

Change it to call cpu_ldb_code_ra() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This retains the current behaviour that all these insns
may cause exceptions both for MMU permissions checks
failures and also for "resulting physaddr doesn't point
at memory".

My reading of the ISA manual is that this isn't strictly
correct for IHI and IHU, which ought to only cause MMU
exceptions but not actually do a memory access. If we
wanted to fix that, the right thing would be to split
them into their own helper function, which could then
just do a tlb_fill().

Tagged as RFC because I don't have any xtensa test images.

My motivation here is that at some point I'd like us to
support execution from arbitrary MMIO/small MPU regions/etc,
for which purpose get_page_addr_code() will change to return
-1 to mean "this isn't RAM, load a single insn into a
throwaway TB and execute it"...

 target/xtensa/op_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 8a8c763c631..34dc1eb68fe 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -465,7 +465,11 @@ void HELPER(check_interrupts)(CPUXtensaState *env)
 
 void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
 {
-    get_page_addr_code(env, vaddr);
+    /*
+     * Attempt the memory load; we don't care about the result but
+     * only the side-effects (ie any MMU or other exception)
+     */
+    cpu_ldub_code_ra(env, vaddr, GETPC());
 }
 
 /*!
-- 
2.17.1
