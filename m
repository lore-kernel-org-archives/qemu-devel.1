Received: from eggs.gnu.org ([2001:4830:134:3::10]:47732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cEK9A-0001MS-FN
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cEK99-00068M-Ap
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:07:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cEK99-00064f-3f
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:07:19 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Dec 2016 18:07:09 +0000
Message-Id: <1481047629-7763-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.8] exec.c: Fix breakpoint invalidation
 race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Julian Brown <julian@codesourcery.com>

A bug (1647683) was reported showing a crash when removing
breakpoints.  The reproducer was bisected to 3359baad when tb_flush
was finally made thread safe.  While in MTTCG the locking in
breakpoint_invalidate would have prevented any problems, but
currently tb_lock() is a NOP for system emulation.

The race is between a tb_flush from the gdbstub and the
tb_invalidate_phys_addr() in breakpoint_invalidate().

Ideally we'd have actual locking here; for the moment the
simple fix is to do a full tb_flush() for a bp invalidate,
since that is thread-safe even if no lock is taken.

Reported-by: Julian Brown <julian@codesourcery.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is quite similar to Alex's patch
http://patchwork.ozlabs.org/patch/703188/
("exec.c: simplify the breakpoint invalidation logic").
The difference is that this patch doesn't drop the
breakpoint_invalidate() function entirely. I think this
is better both for a future "correct fix" and as a
minimal "just fix this for 2.8 release" change.
---
 exec.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/exec.c b/exec.c
index 3d867f1..08c558e 100644
--- a/exec.c
+++ b/exec.c
@@ -684,28 +684,15 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 #endif
 }
 
-#if defined(CONFIG_USER_ONLY)
-static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
-{
-    mmap_lock();
-    tb_lock();
-    tb_invalidate_phys_page_range(pc, pc + 1, 0);
-    tb_unlock();
-    mmap_unlock();
-}
-#else
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
-    MemTxAttrs attrs;
-    hwaddr phys = cpu_get_phys_page_attrs_debug(cpu, pc, &attrs);
-    int asidx = cpu_asidx_from_attrs(cpu, attrs);
-    if (phys != -1) {
-        /* Locks grabbed by tb_invalidate_phys_addr */
-        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
-                                phys | (pc & ~TARGET_PAGE_MASK));
-    }
+    /* Flush the whole TB as this will not have race conditions
+     * even if we don't have proper locking yet.
+     * Ideally we would just invalidate the TBs for the
+     * specified PC.
+     */
+    tb_flush(cpu);
 }
-#endif
 
 #if defined(CONFIG_USER_ONLY)
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
-- 
2.7.4
