Received: from eggs.gnu.org ([2001:4830:134:3::10]:43522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs6-00078R-1Y
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs1-0002Rg-M0
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:22 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:63310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edzs1-0002Qa-Ba
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:17 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 23 Jan 2018 15:48:06 +0100
Message-Id: <20180123144807.5618-13-laurent@vivier.eu>
In-Reply-To: <20180123144807.5618-1-laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 12/13] page_unprotect(): handle calls to pages
 that are PAGE_WRITE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <peter.maydell@linaro.org>

If multiple guest threads in user-mode emulation write to a
page which QEMU has marked read-only because of cached TCG
translations, the threads can race in page_unprotect:

 * threads A & B both try to do a write to a page with code in it at
   the same time (ie which we've made non-writeable, so SEGV)
 * they race into the signal handler with this faulting address
 * thread A happens to get to page_unprotect() first and takes the
   mmap lock, so thread B sits waiting for it to be done
 * A then finds the page, marks it PAGE_WRITE and mprotect()s it writable
 * A can then continue OK (returns from signal handler to retry the
   memory access)
 * ...but when B gets the mmap lock it finds that the page is already
   PAGE_WRITE, and so it exits page_unprotect() via the "not due to
   protected translation" code path, and wrongly delivers the signal
   to the guest rather than just retrying the access

In particular, this meant that trying to run 'javac' in user-mode
emulation would fail with a spurious guest SIGSEGV.

Handle this by making page_unprotect() assume that a call for a page
which is already PAGE_WRITE is due to a race of this sort and return
a "fault handled" indication.

Since this would cause an infinite loop if we ever called
page_unprotect() for some other kind of fault than "write failed due
to bad access permissions", tighten the condition in
handle_cpu_signal() to check the signal number and si_code, and add a
comment so that if somebody does ever find themselves debugging an
infinite loop of faults they have some clue about why.

(The trick for identifying the correct setting for
current_tb_invalidated for thread B (needed to handle the precise-SMC
case) is due to Richard Henderson.  Paolo Bonzini suggested just
relying on si_code rather than trying anything more complicated.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1511879725-9576-3-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 accel/tcg/translate-all.c | 50 +++++++++++++++++++++++++++++------------------
 accel/tcg/user-exec.c     | 13 +++++++++++-
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7736257085..67795cd78c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2181,29 +2181,41 @@ int page_unprotect(target_ulong address, uintptr_t pc)
 
     /* if the page was really writable, then we change its
        protection back to writable */
-    if ((p->flags & PAGE_WRITE_ORG) && !(p->flags & PAGE_WRITE)) {
-        host_start = address & qemu_host_page_mask;
-        host_end = host_start + qemu_host_page_size;
-
-        prot = 0;
+    if (p->flags & PAGE_WRITE_ORG) {
         current_tb_invalidated = false;
-        for (addr = host_start ; addr < host_end ; addr += TARGET_PAGE_SIZE) {
-            p = page_find(addr >> TARGET_PAGE_BITS);
-            p->flags |= PAGE_WRITE;
-            prot |= p->flags;
-
-            /* and since the content will be modified, we must invalidate
-               the corresponding translated code. */
-            current_tb_invalidated |= tb_invalidate_phys_page(addr, pc);
-#ifdef CONFIG_USER_ONLY
-            if (DEBUG_TB_CHECK_GATE) {
-                tb_invalidate_check(addr);
+        if (p->flags & PAGE_WRITE) {
+            /* If the page is actually marked WRITE then assume this is because
+             * this thread raced with another one which got here first and
+             * set the page to PAGE_WRITE and did the TB invalidate for us.
+             */
+#ifdef TARGET_HAS_PRECISE_SMC
+            TranslationBlock *current_tb = tb_find_pc(pc);
+            if (current_tb) {
+                current_tb_invalidated = tb_cflags(current_tb) & CF_INVALID;
             }
 #endif
+        } else {
+            host_start = address & qemu_host_page_mask;
+            host_end = host_start + qemu_host_page_size;
+
+            prot = 0;
+            for (addr = host_start; addr < host_end; addr += TARGET_PAGE_SIZE) {
+                p = page_find(addr >> TARGET_PAGE_BITS);
+                p->flags |= PAGE_WRITE;
+                prot |= p->flags;
+
+                /* and since the content will be modified, we must invalidate
+                   the corresponding translated code. */
+                current_tb_invalidated |= tb_invalidate_phys_page(addr, pc);
+#ifdef CONFIG_USER_ONLY
+                if (DEBUG_TB_CHECK_GATE) {
+                    tb_invalidate_check(addr);
+                }
+#endif
+            }
+            mprotect((void *)g2h(host_start), qemu_host_page_size,
+                     prot & PAGE_BITS);
         }
-        mprotect((void *)g2h(host_start), qemu_host_page_size,
-                 prot & PAGE_BITS);
-
         mmap_unlock();
         /* If current TB was invalidated return to main loop */
         return current_tb_invalidated ? 2 : 1;
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index e8f26ff0cb..c973752562 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -104,7 +104,18 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
            pc, address, is_write, *(unsigned long *)old_set);
 #endif
     /* XXX: locking issue */
-    if (is_write && h2g_valid(address)) {
+    /* Note that it is important that we don't call page_unprotect() unless
+     * this is really a "write to nonwriteable page" fault, because
+     * page_unprotect() assumes that if it is called for an access to
+     * a page that's writeable this means we had two threads racing and
+     * another thread got there first and already made the page writeable;
+     * so we will retry the access. If we were to call page_unprotect()
+     * for some other kind of fault that should really be passed to the
+     * guest, we'd end up in an infinite loop of retrying the faulting
+     * access.
+     */
+    if (is_write && info->si_signo == SIGSEGV && info->si_code == SEGV_ACCERR &&
+        h2g_valid(address)) {
         switch (page_unprotect(h2g(address), pc)) {
         case 0:
             /* Fault not caused by a page marked unwritable to protect
-- 
2.14.3
