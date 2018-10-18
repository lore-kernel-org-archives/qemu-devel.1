Received: from eggs.gnu.org ([2001:4830:134:3::10]:55593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gDGVM-00018N-6Q
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 18:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gDGVH-0001aA-LQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 18:10:53 -0400
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:16666
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1gDGVD-0001BZ-S8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 18:10:49 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 16E819843A
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 18:10:22 -0400 (EDT)
Received: from humpty.home.comstyle.com (unknown
	[IPv6:2001:470:c454:100:584c:84d6:1353:1133])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested) (Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 64BD598439
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 18:10:21 -0400 (EDT)
Date: Thu, 18 Oct 2018 18:10:28 -0400
From: Brad Smith <brad@comstyle.com>
Message-ID: <20181018221028.GB85911@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2] oslib-posix: Use MAP_STACK in
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

Added to -current and will be in our soon to be 6.4 release.

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

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index fbd0dc8c57..7814e61114 100644
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
@@ -610,8 +611,15 @@ void *qemu_alloc_stack(size_t *sz)
     /* allocate one extra page for the guard page */
     *sz += pagesz;
 
-    ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE,
-               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    flags = MAP_PRIVATE | MAP_ANONYMOUS;
+#if defined(MAP_STACK) && defined(__OpenBSD__)
+    /* Only enable MAP_STACK on OpenBSD. Other OS's such
+       as Linux/FreeBSD/NetBSD have a flag with the same
+       name but have differing functionality. */
+    flags |= MAP_STACK;
+#endif
+
+    ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE, flags, -1, 0);
     if (ptr == MAP_FAILED) {
         perror("failed to allocate memory for stack");
         abort();
