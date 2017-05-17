Received: from eggs.gnu.org ([2001:4830:134:3::10]:35885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB2HE-0001Cm-0T
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB2HD-0000FD-3q
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:58:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dB2HC-0000F6-V6
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEB3183F46
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:58:17 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 17 May 2017 17:58:10 +0100
Message-Id: <20170517165810.18164-3-dgilbert@redhat.com>
In-Reply-To: <20170517165810.18164-1-dgilbert@redhat.com>
References: <20170517165810.18164-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] postcopy: Require RAMBlocks that are whole
 pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

It turns out that it's legal to create a VM with RAMBlocks that aren't
a multiple of the pagesize in use; e.g. a 1025M main memory using
2M host pages.  That breaks postcopy's atomic placement of pages,
so disallow it.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index cdadaf6578..e8f43e7bd1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -96,14 +96,24 @@ static bool ufd_version_check(int ufd)
 
 /* Callback from postcopy_ram_supported_by_host block iterator.
  */
-static int test_range_shared(const char *block_name, void *host_addr,
+static int test_ramblock_postcopiable(const char *block_name, void *host_addr,
                              ram_addr_t offset, ram_addr_t length, void *opaque)
 {
-    if (qemu_ram_is_shared(qemu_ram_block_by_name(block_name))) {
+    RAMBlock *rb = qemu_ram_block_by_name(block_name);
+    size_t pagesize = qemu_ram_pagesize(rb);
+
+    if (qemu_ram_is_shared(rb)) {
         error_report("Postcopy on shared RAM (%s) is not yet supported",
                      block_name);
         return 1;
     }
+
+    if (length % pagesize) {
+        error_report("Postcopy requires RAM blocks to be a page size multiple,"
+                     " block %s is 0x" RAM_ADDR_FMT " bytes with a "
+                     "page size of 0x%zx", block_name, length, pagesize);
+        return 1;
+    }
     return 0;
 }
 
@@ -140,7 +150,7 @@ bool postcopy_ram_supported_by_host(void)
     }
 
     /* We don't support postcopy with shared RAM yet */
-    if (qemu_ram_foreach_block(test_range_shared, NULL)) {
+    if (qemu_ram_foreach_block(test_ramblock_postcopiable, NULL)) {
         goto out;
     }
 
-- 
2.13.0
