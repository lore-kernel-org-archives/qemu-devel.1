Received: from eggs.gnu.org ([2001:4830:134:3::10]:45528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAQ-0004AF-5Q
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAO-0006Uj-5I
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canAO-0006TT-0B
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:28 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 308927E9EF
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:33:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  6 Feb 2017 17:33:06 +0000
Message-Id: <20170206173306.20603-17-dgilbert@redhat.com>
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/16] postcopy: Add doc about hugepages and
 postcopy
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

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/migration.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/migration.txt b/docs/migration.txt
index 6503c17..b462ead 100644
--- a/docs/migration.txt
+++ b/docs/migration.txt
@@ -482,3 +482,16 @@ request for a page that has already been sent is ignored.  Duplicate requests
 such as this can happen as a page is sent at about the same time the
 destination accesses it.
 
+=== Postcopy with hugepages ===
+
+Postcopy now works with hugetlbfs backed memory:
+  a) The linux kernel on the destination must support userfault on hugepages.
+  b) The huge-page configuration on the source and destination VMs must be
+     identical; i.e. RAMBlocks on both sides must use the same page size.
+  c) Note that -mem-path /dev/hugepages  will fall back to allocating normal
+     RAM if it doesn't have enough hugepages, triggering (b) to fail.
+     Using -mem-prealloc enforces the allocation using hugepages.
+  d) Care should be taken with the size of hugepage used; postcopy with 2MB
+     hugepages works well, however 1GB hugepages are likely to be problematic
+     since it takes ~1 second to transfer a 1GB hugepage across a 10Gbps link,
+     and until the full page is transferred the destination thread is blocked.
-- 
2.9.3
