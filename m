Received: from eggs.gnu.org ([2001:4830:134:3::10]:40307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih6I-0000LC-4c
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih6H-0000bp-DF
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih6H-0000bY-79
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:53 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:55 +0000
Message-Id: <20170228124056.5074-27-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 26/27] postcopy: Add doc about hugepages and
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170224182844.32452-16-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/migration.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/migration.txt b/docs/migration.txt
index c8b0304..1b940a8 100644
--- a/docs/migration.txt
+++ b/docs/migration.txt
@@ -540,3 +540,16 @@ request for a page that has already been sent is ignored.  Duplicate requests
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
