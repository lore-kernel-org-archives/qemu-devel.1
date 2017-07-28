Received: from eggs.gnu.org ([2001:4830:134:3::10]:36562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1db2GP-0002rp-Ki
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1db2GO-0006HW-QO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:12:57 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1db2GO-0006Ft-JL
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:12:56 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 11:12:49 +0100
Message-Id: <1501236769-1766-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.10] exec: Disable "execute from MMIO
 memory region" feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, KONRAD Frederic <frederic.konrad@adacore.com>, Juan Quintela <quintela@redhat.com>

Unfortunately it turns out that the implementation of the "execute
from MMIO memory region" feature does not interact well with
migration: it creates and destroys RAMBlocks on the fly, but
migration assumes that the set of RAMBlocks is fixed while migration
is in progress.  The effect is that migration will either fail (if
the on-the-fly RAMBlock exists already when migration starts) or may
behave strangely (if the RAMBlock is created or destroyed while a
migration is in progress).

This is too complicated to try to fix in 2.10, so for this release,
simply disable the new feature.  We can reenable and fix or redesign
it in 2.11.

This commit simply removes the code in get_page_addr_code() which
would trigger the execute-from-MMIO, and leaves the bulk of the code
(and the implementation of the per-device code in the xilinx-spips
device) in place, unused.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is a very blunt hammer approach to the problem.  There may be
slightly more surgical approaches possible, but we're getting close
to 2.10 release, so this is just the minimal "make sure we don't have
a problem in 2.10" change, so we can do the right thing in 2.11.
If somebody who has a more immediate requirement for the feature
wants to propose something else, that would be OK too, but they
need to write the patch...

 accel/tcg/cputlb.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 85635ae..64f9600 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -858,16 +858,6 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
     mr = iotlb_to_region(cpu, pd, iotlbentry->attrs);
     if (memory_region_is_unassigned(mr)) {
-        qemu_mutex_lock_iothread();
-        if (memory_region_request_mmio_ptr(mr, addr)) {
-            qemu_mutex_unlock_iothread();
-            /* A MemoryRegion is potentially added so re-run the
-             * get_page_addr_code.
-             */
-            return get_page_addr_code(env, addr);
-        }
-        qemu_mutex_unlock_iothread();
-
         cpu_unassigned_access(cpu, addr, false, true, 0, 4);
         /* The CPU's unassigned access hook might have longjumped out
          * with an exception. If it didn't (or there was no hook) then
-- 
2.7.4
