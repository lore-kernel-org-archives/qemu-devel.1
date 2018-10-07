Received: from eggs.gnu.org ([2001:4830:134:3::10]:59348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1g9B7s-0003C0-Mx
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 11:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1g9B7r-0004Ff-V6
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 11:37:48 -0400
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:27889
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1g9B7r-0004Bt-N7
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 11:37:47 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 920059843A
	for <qemu-devel@nongnu.org>; Sun,  7 Oct 2018 11:37:24 -0400 (EDT)
Received: from humpty.home.comstyle.com (unknown
	[IPv6:2001:470:c454:100:13af:4407:2bbf:771f])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested) (Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 73E0D98439
	for <qemu-devel@nongnu.org>; Sun,  7 Oct 2018 11:37:24 -0400 (EDT)
Date: Sun, 7 Oct 2018 11:37:31 -0400
From: Brad Smith <brad@comstyle.com>
Message-ID: <20181007153731.GA32288@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
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


diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index fbd0dc8c57..51e9a012c2 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -611,7 +611,11 @@ void *qemu_alloc_stack(size_t *sz)
     *sz += pagesz;
 
     ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE,
-               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+               MAP_PRIVATE | MAP_ANONYMOUS
+#ifdef MAP_STACK
+               | MAP_STACK
+#endif
+               , -1, 0);
     if (ptr == MAP_FAILED) {
         perror("failed to allocate memory for stack");
         abort();
