Received: from eggs.gnu.org ([2001:4830:134:3::10]:55928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgMO4-0004hl-O1
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 23:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgMNz-0007WN-SR
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 23:47:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgMNz-0007VQ-O1
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 23:47:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28F4040122CD
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 03:47:19 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Jul 2018 11:47:13 +0800
Message-Id: <20180720034713.11711-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: fix potential overflow in multifd
 send
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

I would guess it won't happen normally, but this should ease Coverity.

>>>     CID 1394385:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "pages->used * 8192U" with type "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "uint64_t" (64 bits, unsigned).
854         transferred = pages->used * TARGET_PAGE_SIZE + p->packet_len;

Fixes: CID 1394385
CC: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 52dd678092..fdd108475c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -851,7 +851,7 @@ static void multifd_send_pages(void)
     p->pages->block = NULL;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
-    transferred = pages->used * TARGET_PAGE_SIZE + p->packet_len;
+    transferred = ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->packet_len;
     ram_counters.multifd_bytes += transferred;
     ram_counters.transferred += transferred;;
     qemu_mutex_unlock(&p->mutex);
-- 
2.17.1
