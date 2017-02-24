Received: from eggs.gnu.org ([2001:4830:134:3::10]:53421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chKbv-0000vL-3O
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chKbu-0007x1-3W
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:28:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1chKbt-0007wm-Tm
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:28:54 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22FBD8123D
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 18:28:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 24 Feb 2017 18:28:33 +0000
Message-Id: <20170224182844.32452-6-dgilbert@redhat.com>
In-Reply-To: <20170224182844.32452-1-dgilbert@redhat.com>
References: <20170224182844.32452-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/16] postcopy: enhance
 ram_block_discard_range for hugepages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Unfortunately madvise DONTNEED doesn't work on hugepagetlb
so use fallocate(FALLOC_FL_PUNCH_HOLE)
qemu_fd_getpagesize only sets the page based off a file
if the file is from hugetlbfs.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 exec.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index ddbc314..ec3a11f 100644
--- a/exec.c
+++ b/exec.c
@@ -46,6 +46,11 @@
 #include "sysemu/xen-mapcache.h"
 #include "trace-root.h"
 
+#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+#include <fcntl.h>
+#include <linux/falloc.h>
+#endif
+
 #endif
 #include "exec/cpu-all.h"
 #include "qemu/rcu_queue.h"
@@ -3320,12 +3325,23 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
 
         errno = ENOTSUP; /* If we are missing MADVISE etc */
 
+        if (rb->page_size == qemu_host_page_size) {
 #if defined(CONFIG_MADVISE)
-        /* Note: We need the madvise MADV_DONTNEED behaviour of definitely
-         * freeing the page.
-         */
-        ret = madvise(host_startaddr, length, MADV_DONTNEED);
+            /* Note: We need the madvise MADV_DONTNEED behaviour of definitely
+             * freeing the page.
+             */
+            ret = madvise(host_startaddr, length, MADV_DONTNEED);
 #endif
+        } else {
+            /* Huge page case  - unfortunately it can't do DONTNEED, but
+             * it can do the equivalent by FALLOC_FL_PUNCH_HOLE in the
+             * huge page file.
+             */
+#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+            ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+                            start, length);
+#endif
+        }
         if (ret) {
             ret = -errno;
             error_report("ram_block_discard_range: Failed to discard range "
-- 
2.9.3
