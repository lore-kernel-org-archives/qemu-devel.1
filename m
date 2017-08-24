Received: from eggs.gnu.org ([2001:4830:134:3::10]:52950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxpC-0003es-Rs
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxp9-0005cW-OK
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxp9-0005c8-Ih
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:51 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:26 +0100
Message-Id: <20170824192730.8440-29-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 28/32] postcopy: Allow shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Now that we have the mechanisms in here, allow shared memory in a
postcopy.

Note that QEMU can't tell who all the users of shared regions are
and thus can't tell whether all the users of the shared regions
have appropriate support for postcopy.  Those devices that explicitly
support shared memory (e.g. vhost-user) must check, but it doesn't
stop weirder configurations causing problems.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 28791cf1f1..89c3aadda1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -138,12 +138,6 @@ static int test_ramblock_postcopiable(const char *block_name, void *host_addr,
     RAMBlock *rb = qemu_ram_block_by_name(block_name);
     size_t pagesize = qemu_ram_pagesize(rb);
 
-    if (qemu_ram_is_shared(rb)) {
-        error_report("Postcopy on shared RAM (%s) is not yet supported",
-                     block_name);
-        return 1;
-    }
-
     if (length % pagesize) {
         error_report("Postcopy requires RAM blocks to be a page size multiple,"
                      " block %s is 0x" RAM_ADDR_FMT " bytes with a "
-- 
2.13.5
