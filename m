Received: from eggs.gnu.org ([2001:4830:134:3::10]:45023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLY-00039M-0I
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLT-0001o3-KC
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e8nLT-0001mG-EL
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EE9413A97
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 13:09:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Sun, 29 Oct 2017 14:09:26 +0100
Message-Id: <20171029130934.4555-2-quintela@redhat.com>
In-Reply-To: <20171029130934.4555-1-quintela@redhat.com>
References: <20171029130934.4555-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] migration: Make sure that we pass the right
 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Instead of passing silently round down the number of pages, make it an
error that the cache size is not a power of 2.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/page_cache.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/page_cache.c b/migration/page_cache.c
index 9a9d13d6a2..96268c3aea 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -58,6 +58,13 @@ PageCache *cache_init(int64_t new_size, size_t page_size, Error **errp)
         return NULL;
     }
 
+    /* round down to the nearest power of 2 */
+    if (!is_power_of_2(num_pages)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
+                   "is not a power of two number of pages");
+        return NULL;
+    }
+
     /* We prefer not to abort if there is no memory */
     cache = g_try_malloc(sizeof(*cache));
     if (!cache) {
@@ -65,11 +72,6 @@ PageCache *cache_init(int64_t new_size, size_t page_size, Error **errp)
                    "Failed to allocate cache");
         return NULL;
     }
-    /* round down to the nearest power of 2 */
-    if (!is_power_of_2(num_pages)) {
-        num_pages = pow2floor(num_pages);
-        DPRINTF("rounding down to %" PRId64 "\n", num_pages);
-    }
     cache->page_size = page_size;
     cache->num_items = 0;
     cache->max_num_items = num_pages;
-- 
2.13.6
