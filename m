Received: from eggs.gnu.org ([2001:4830:134:3::10]:44045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eJgzP-0004ay-7M
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eJgzJ-0003rd-4Y
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:35:59 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eJgzI-0003lI-SZ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:35:53 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 14:35:25 +0000
Message-Id: <1511879725-9576-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1511879725-9576-1-git-send-email-peter.maydell@linaro.org>
References: <1511879725-9576-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] page_unprotect(): handle calls to pages
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
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

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
---
 accel/tcg/translate-all.c | 50 +++++++++++++++++++++++++++++------------------
 accel/tcg/user-exec.c     | 13 +++++++++++-
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index e7f0329..96e68d5 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2182,29 +2182,41 @@ int page_unprotect(target_ulong address, uintptr_t pc)
 
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
index e8f26ff..c973752 100644
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
2.7.4
