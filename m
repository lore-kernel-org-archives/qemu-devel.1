Received: from eggs.gnu.org ([2001:4830:134:3::10]:44974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLW-00039C-Ek
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLV-0001rj-8L
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e8nLV-0001q3-2Q
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EADE6A7CB
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 13:09:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Sun, 29 Oct 2017 14:09:27 +0100
Message-Id: <20171029130934.4555-3-quintela@redhat.com>
In-Reply-To: <20171029130934.4555-1-quintela@redhat.com>
References: <20171029130934.4555-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] migration: Don't play games with the
 requested cache size
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

Now that we check that the value passed is a power of 2, we don't need
to play games when comparing what is the size that is going to take
the cache.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7f6327f708..42f3b7cb28 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -136,12 +136,14 @@ int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
         return -1;
     }
 
+    if (new_size == migrate_xbzrle_cache_size()) {
+        /* nothing to do */
+        return new_size;
+    }
+
     XBZRLE_cache_lock();
 
     if (XBZRLE.cache != NULL) {
-        if (pow2floor(new_size) == migrate_xbzrle_cache_size()) {
-            goto out_new_size;
-        }
         new_cache = cache_init(new_size, TARGET_PAGE_SIZE, errp);
         if (!new_cache) {
             ret = -1;
@@ -152,8 +154,7 @@ int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
         XBZRLE.cache = new_cache;
     }
 
-out_new_size:
-    ret = pow2floor(new_size);
+    ret = new_size;
 out:
     XBZRLE_cache_unlock();
     return ret;
-- 
2.13.6
