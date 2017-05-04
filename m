Received: from eggs.gnu.org ([2001:4830:134:3::10]:45392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DGB-0008Qh-2h
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DG9-0000tA-Nh
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d6DG9-0000rn-GV
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 716A315D9
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 09:41:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  4 May 2017 11:40:53 +0200
Message-Id: <20170504094053.2329-11-quintela@redhat.com>
In-Reply-To: <20170504094053.2329-1-quintela@redhat.com>
References: <20170504094053.2329-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] migration: Extra tracing
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

A couple more traces that would have made fixing that postcopy
bug a bit easier.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 2 ++
 migration/trace-events | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 4918c11..293d27c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -788,6 +788,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
 
     p = block->host + offset;
+    trace_ram_save_page(block->idstr, (uint64_t)offset, p);
 
     /* In doubt sent page as normal */
     bytes_xmit = 0;
@@ -2550,6 +2551,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                 ret = -EINVAL;
                 break;
             }
+            trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
         }
 
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
diff --git a/migration/trace-events b/migration/trace-events
index b8f01a2..5b8ccf3 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -69,8 +69,10 @@ migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_throttle(void) ""
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
+ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: %" PRIx64 " flags: %x host: %p"
 ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
 ram_postcopy_send_discard_bitmap(void) ""
+ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: %" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %zx len: %zx"
 
 # migration/migration.c
-- 
2.9.3
