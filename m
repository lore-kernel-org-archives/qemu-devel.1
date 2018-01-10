Received: from eggs.gnu.org ([2001:4830:134:3::10]:40352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnE-00068h-Vv
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnA-0004UT-Ad
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZFnA-0004TJ-5e
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53F1020262
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:47:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Jan 2018 13:47:15 +0100
Message-Id: <20180110124723.11879-7-quintela@redhat.com>
In-Reply-To: <20180110124723.11879-1-quintela@redhat.com>
References: <20180110124723.11879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 06/14] migration: Send the fd number which
 we are going to use for this page
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

We are still sending the page through the main channel, that would
change later in the series

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5d6b46ac23..19c8089c4b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1191,6 +1191,7 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
                             bool last_stage)
 {
     int pages;
+    uint16_t fd_num;
     uint8_t *p;
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
@@ -1202,7 +1203,10 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
         ram_counters.transferred +=
             save_page_header(rs, rs->f, block,
                              offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
-        multifd_send_page(block, offset, rs->migration_dirty_pages == 1);
+        fd_num = multifd_send_page(block, offset,
+                                   rs->migration_dirty_pages == 1);
+        qemu_put_be16(rs->f, fd_num);
+        ram_counters.transferred += 2; /* size of fd_num */
         qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
         ram_counters.transferred += TARGET_PAGE_SIZE;
         pages = 1;
@@ -3040,6 +3044,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
         void *host = NULL;
+        uint16_t fd_num;
         uint8_t ch;
 
         addr = qemu_get_be64(f);
@@ -3151,6 +3156,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;
 
         case RAM_SAVE_FLAG_MULTIFD_PAGE:
+            fd_num = qemu_get_be16(f);
+            if (fd_num != 0) {
+                /* this is yet an unused variable, changed later */
+                fd_num = fd_num;
+            }
             qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;
 
-- 
2.14.3
