Received: from eggs.gnu.org ([2001:4830:134:3::10]:45355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAC-0003t7-DG
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAB-0006Pf-DR
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canAB-0006PQ-7O
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:15 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63F2B63144
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:33:15 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  6 Feb 2017 17:32:55 +0000
Message-Id: <20170206173306.20603-6-dgilbert@redhat.com>
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/16] postcopy: enhance
 ram_block_discard_range for hugepages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Unfortunately madvise DONTNEED doesn't work on hugepagetlb
so use fallocate(FALLOC_FL_PUNCH_HOLE)
qemu_fd_getpagesize only sets the page based off a file
if the file is from hugetlbfs.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index e040cdf..c25f6b3 100644
--- a/exec.c
+++ b/exec.c
@@ -3324,9 +3324,20 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
 
         errno = ENOTSUP; /* If we are missing MADVISE etc */
 
+        if (rb->page_size == qemu_host_page_size) {
 #if defined(CONFIG_MADVISE)
-        ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
+            ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
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
