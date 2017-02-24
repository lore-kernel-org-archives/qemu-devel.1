Received: from eggs.gnu.org ([2001:4830:134:3::10]:53513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chKc3-00013k-4k
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chKc2-00082r-5q
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:29:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1chKc2-000824-0Z
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:29:02 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33806C05AA53
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 18:29:02 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 24 Feb 2017 18:28:39 +0000
Message-Id: <20170224182844.32452-12-dgilbert@redhat.com>
In-Reply-To: <20170224182844.32452-1-dgilbert@redhat.com>
References: <20170224182844.32452-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/16] postcopy: Send whole huge pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The RAM save code uses ram_save_host_page to send whole
host pages at a time;  change this to use the host page size associated
with the RAM Block which may be a huge page.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 migration/ram.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 9f28da2..719425b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1302,6 +1302,8 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
  *                     offset to point into the middle of a host page
  *                     in which case the remainder of the hostpage is sent.
  *                     Only dirty target pages are sent.
+ *                     Note that the host page size may be a huge page for this
+ *                     block.
  *
  * Returns: Number of pages written.
  *
@@ -1320,6 +1322,8 @@ static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
                               ram_addr_t dirty_ram_abs)
 {
     int tmppages, pages = 0;
+    size_t pagesize = qemu_ram_pagesize(pss->block);
+
     do {
         tmppages = ram_save_target_page(ms, f, pss, last_stage,
                                         bytes_transferred, dirty_ram_abs);
@@ -1330,7 +1334,7 @@ static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
         pages += tmppages;
         pss->offset += TARGET_PAGE_SIZE;
         dirty_ram_abs += TARGET_PAGE_SIZE;
-    } while (pss->offset & (qemu_host_page_size - 1));
+    } while (pss->offset & (pagesize - 1));
 
     /* The offset we leave with is the last one we looked at */
     pss->offset -= TARGET_PAGE_SIZE;
-- 
2.9.3
