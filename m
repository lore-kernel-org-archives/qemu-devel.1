Received: from eggs.gnu.org ([2001:4830:134:3::10]:56585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEH6a-0008Eg-Jm
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEH6W-0002Vd-M3
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:52:28 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cEH6W-0002V3-Eq
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:52:24 -0500
Received: by mail-wm0-f44.google.com with SMTP id f82so128753268wmf.1
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 06:52:24 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  6 Dec 2016 14:51:04 +0000
Message-Id: <20161206145104.16048-1-alex.bennee@linaro.org>
In-Reply-To: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
References: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] exec.c: simplify the breakpoint invalidation
 logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 1647683@bugs.launchpad.net
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, rth@twiddle.net, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:Overall" <qemu-devel@nongnu.org>

A bug (1647683) was reported showing a crash when removing
breakpoints. The reproducer was bisected to 3359baad when tb_flush was
finally made thread safe. While in MTTCG the locking in
breakpoint_invalidate should have prevented any problems currently
tb_lock() is a NOP for system emulation.

On top of it all the invalidation code was special-cased between user
and system emulation which was ugly. As we now have a safe tb_flush()
we might as well use that when breakpoints and added and removed. This
is the same thing we do for single-stepping and as this is during
debugging it isn't a major performance concern.

Reported-by: Julian Brown
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 exec.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/exec.c b/exec.c
index 3d867f1..e991221 100644
--- a/exec.c
+++ b/exec.c
@@ -685,29 +685,6 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 }
 
 #if defined(CONFIG_USER_ONLY)
-static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
-{
-    mmap_lock();
-    tb_lock();
-    tb_invalidate_phys_page_range(pc, pc + 1, 0);
-    tb_unlock();
-    mmap_unlock();
-}
-#else
-static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
-{
-    MemTxAttrs attrs;
-    hwaddr phys = cpu_get_phys_page_attrs_debug(cpu, pc, &attrs);
-    int asidx = cpu_asidx_from_attrs(cpu, attrs);
-    if (phys != -1) {
-        /* Locks grabbed by tb_invalidate_phys_addr */
-        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
-                                phys | (pc & ~TARGET_PAGE_MASK));
-    }
-}
-#endif
-
-#if defined(CONFIG_USER_ONLY)
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
 
 {
@@ -839,7 +816,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
         QTAILQ_INSERT_TAIL(&cpu->breakpoints, bp, entry);
     }
 
-    breakpoint_invalidate(cpu, pc);
+    tb_flush(cpu);
 
     if (breakpoint) {
         *breakpoint = bp;
@@ -855,6 +832,7 @@ int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
     QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
         if (bp->pc == pc && bp->flags == flags) {
             cpu_breakpoint_remove_by_ref(cpu, bp);
+            tb_flush(cpu);
             return 0;
         }
     }
@@ -865,9 +843,6 @@ int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
 void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint)
 {
     QTAILQ_REMOVE(&cpu->breakpoints, breakpoint, entry);
-
-    breakpoint_invalidate(cpu, breakpoint->pc);
-
     g_free(breakpoint);
 }
 
@@ -881,6 +856,8 @@ void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
             cpu_breakpoint_remove_by_ref(cpu, bp);
         }
     }
+
+    tb_flush(cpu);
 }
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
-- 
2.10.2
