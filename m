Received: from eggs.gnu.org ([2001:4830:134:3::10]:49210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4liZ-0008GS-9D
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4liY-0005RI-KH
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4liY-0005Qy-Em
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65C6480F95
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 10:36:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 18 Oct 2017 12:36:30 +0200
Message-Id: <20171018103633.5549-8-quintela@redhat.com>
In-Reply-To: <20171018103633.5549-1-quintela@redhat.com>
References: <20171018103633.5549-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/10] migration: Don't play games with the
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
---
 migration/ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 47501460c8..c84f22d759 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -135,12 +135,14 @@ int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
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
@@ -151,8 +153,7 @@ int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
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
