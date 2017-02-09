Received: from eggs.gnu.org ([2001:4830:134:3::10]:49713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbuRF-00067j-2J
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 14:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbuRE-0005qE-5b
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 14:31:29 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbuRD-0005kl-Us
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 14:31:28 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  9 Feb 2017 19:31:16 +0000
Message-Id: <1486668676-24680-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] cputlb: Don't assume do_unassigned_access()
 never returns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

In get_page_addr_code(), if the guest PC doesn't correspond to RAM
then we currently run the CPU's do_unassigned_access() hook if it has
one, and otherwise we give up and exit QEMU with a more-or-less
useful message.  This code assumes that the do_unassigned_access hook
will never return, because if it does then we'll plough on attempting
to use a non-RAM TLB entry to get a RAM address and will abort() in
qemu_ram_addr_from_host_nofail().  Unfortunately some CPU
implementations of this hook do return: Microblaze, SPARC and the ARM
v7M.

Change the code to call report_bad_exec() if the hook returns, as
well as if it didn't have one.  This means we can tidy it up to use
the cpu_unassigned_access() function which wraps the "get the CPU
class and call the hook if it has one" work, since we aren't trying
to distinguish "no hook" from "hook existed and returned" any more.

This brings the handling of this hook into line with the handling
used for data accesses, where "hook returned" is treated the
same as "no hook existed" and gets you the default behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Review from somebody who understands how the unassigned_access
hooks are supposed to work appreciated.

 cputlb.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 6c39927..e665193 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -475,14 +475,13 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
     pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
     mr = iotlb_to_region(cpu, pd, iotlbentry->attrs);
     if (memory_region_is_unassigned(mr)) {
-        CPUClass *cc = CPU_GET_CLASS(cpu);
-
-        if (cc->do_unassigned_access) {
-            cc->do_unassigned_access(cpu, addr, false, true, 0, 4);
-        } else {
-            report_bad_exec(cpu, addr);
-            exit(1);
-        }
+        cpu_unassigned_access(cpu, addr, false, true, 0, 4);
+        /* The CPU's unassigned access hook might have longjumped out
+         * with an exception. If it didn't (or there was no hook) then
+         * we can't proceed further.
+         */
+        report_bad_exec(cpu, addr);
+        exit(1);
     }
     p = (void *)((uintptr_t)addr + env1->tlb_table[mmu_idx][page_index].addend);
     return qemu_ram_addr_from_host_nofail(p);
-- 
2.7.4
