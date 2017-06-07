Received: from eggs.gnu.org ([2001:4830:134:3::10]:33643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkZ-0005X2-K5
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkY-0005Kx-PQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIXkY-0005Kq-JW
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 855B161D16
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 09:59:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Jun 2017 11:59:23 +0200
Message-Id: <20170607095926.1834-5-quintela@redhat.com>
In-Reply-To: <20170607095926.1834-1-quintela@redhat.com>
References: <20170607095926.1834-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] ram: Move ZERO_TARGET_PAGE inside XBZRLE
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

It was only used by XBZRLE anyways.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 701a1e6..ac30e9e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -69,8 +69,6 @@
 /* 0x80 is reserved in migration.h start with 0x100 next */
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
 
-static uint8_t *ZERO_TARGET_PAGE;
-
 static inline bool is_zero_range(uint8_t *p, uint64_t size)
 {
     return buffer_is_zero(p, size);
@@ -86,6 +84,8 @@ static struct {
     /* Cache for XBZRLE, Protected by lock. */
     PageCache *cache;
     QemuMutex lock;
+    /* it will store a page full of zeros */
+    uint8_t *zero_target_page;
 } XBZRLE;
 
 /* buffer used for XBZRLE decoding */
@@ -512,7 +512,7 @@ static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
 
     /* We don't care if this fails to allocate a new cache page
      * as long as it updated an old one */
-    cache_insert(XBZRLE.cache, current_addr, ZERO_TARGET_PAGE,
+    cache_insert(XBZRLE.cache, current_addr, XBZRLE.zero_target_page,
                  rs->bitmap_sync_count);
 }
 
@@ -1456,10 +1456,11 @@ static void ram_migration_cleanup(void *opaque)
         cache_fini(XBZRLE.cache);
         g_free(XBZRLE.encoded_buf);
         g_free(XBZRLE.current_buf);
-        g_free(ZERO_TARGET_PAGE);
+        g_free(XBZRLE.zero_target_page);
         XBZRLE.cache = NULL;
         XBZRLE.encoded_buf = NULL;
         XBZRLE.current_buf = NULL;
+        XBZRLE.zero_target_page = NULL;
     }
     XBZRLE_cache_unlock();
     migration_page_queue_free(rs);
@@ -1880,7 +1881,7 @@ static int ram_state_init(RAMState *rs)
 
     if (migrate_use_xbzrle()) {
         XBZRLE_cache_lock();
-        ZERO_TARGET_PAGE = g_malloc0(TARGET_PAGE_SIZE);
+        XBZRLE.zero_target_page = g_malloc0(TARGET_PAGE_SIZE);
         XBZRLE.cache = cache_init(migrate_xbzrle_cache_size() /
                                   TARGET_PAGE_SIZE,
                                   TARGET_PAGE_SIZE);
-- 
2.9.4
