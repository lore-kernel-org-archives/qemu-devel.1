Received: from eggs.gnu.org ([2001:4830:134:3::10]:56537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmnwU-00073X-W4
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmnwR-0002kO-0H
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:21:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dmnwQ-0002jS-QN
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:20:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D78C2C0587D3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 21:20:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 29 Aug 2017 18:20:53 -0300
Message-Id: <20170829212053.6003-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] oslib-posix: Print errors before aborting on
 qemu_alloc_stack()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

If QEMU is running on a system that's out of memory and mmap()
fails, QEMU aborts with no error message at all, making it hard
to debug the reason for the failure.

Add perror() calls that will print error information before
aborting.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 util/oslib-posix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index cacf0ef..80086c5 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -530,6 +530,7 @@ void *qemu_alloc_stack(size_t *sz)
     ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE,
                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
     if (ptr == MAP_FAILED) {
+        perror("failed to allocate memory for stack");
         abort();
     }
 
@@ -544,6 +545,7 @@ void *qemu_alloc_stack(size_t *sz)
     guardpage = ptr;
 #endif
     if (mprotect(guardpage, pagesz, PROT_NONE) != 0) {
+        perror("failed to set up stack guard page");
         abort();
     }
 
-- 
2.9.4
