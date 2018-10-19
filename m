Received: from eggs.gnu.org ([2001:4830:134:3::10]:50098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gDUGh-0002Zd-Bq
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gDUGg-0004hA-Ie
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:52:43 -0400
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:5825
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1gDUGg-0004dp-7z
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:52:42 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 5E0B89843A
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 08:52:32 -0400 (EDT)
Received: from humpty.home.comstyle.com (unknown
	[IPv6:2001:470:c454:100:bae4:5a8f:59c0:49f6])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested) (Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 36A1298439
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 08:52:32 -0400 (EDT)
Date: Fri, 19 Oct 2018 08:52:39 -0400
From: Brad Smith <brad@comstyle.com>
Message-ID: <20181019125239.GA13884@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v3] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use MAP_STACK in qemu_alloc_stack() on OpenBSD.

Added to our 6.4 release.

MAP_STACK      Indicate that the mapping is used as a stack.  This
               flag must be used in combination with MAP_ANON and
               MAP_PRIVATE.

Implement MAP_STACK option for mmap().  Synchronous faults (pagefault and
syscall) confirm the stack register points at MAP_STACK memory, otherwise
SIGSEGV is delivered. sigaltstack() and pthread_attr_setstack() are modified
to create a MAP_STACK sub-region which satisfies alignment requirements.
Observe that MAP_STACK can only be set/cleared by mmap(), which zeroes the
contents of the region -- there is no mprotect() equivalent operation, so
there is no MAP_STACK-adding gadget.


Signed-off-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index fbd0dc8c57..c1bee2a581 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -596,6 +596,7 @@ pid_t qemu_fork(Error **errp)
 void *qemu_alloc_stack(size_t *sz)
 {
     void *ptr, *guardpage;
+    int flags;
 #ifdef CONFIG_DEBUG_STACK_USAGE
     void *ptr2;
 #endif
@@ -610,8 +611,18 @@ void *qemu_alloc_stack(size_t *sz)
     /* allocate one extra page for the guard page */
     *sz += pagesz;
 
-    ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE,
-               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    flags = MAP_PRIVATE | MAP_ANONYMOUS;
+#if defined(MAP_STACK) && defined(__OpenBSD__)
+    /* Only enable MAP_STACK on OpenBSD. Other OS's such as
+     * Linux/FreeBSD/NetBSD have a flag with the same name
+     * but have differing functionality. OpenBSD will SEGV
+     * if it spots execution with a stack pointer pointing
+     * at memory that was not allocated with MAP_STACK.
+     */
+    flags |= MAP_STACK;
+#endif
+
+    ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE, flags, -1, 0);
     if (ptr == MAP_FAILED) {
         perror("failed to allocate memory for stack");
         abort();
