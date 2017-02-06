Received: from eggs.gnu.org ([2001:4830:134:3::10]:45410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAH-0003y7-Qy
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAG-0006Qv-03
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canAF-0006Qn-RP
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:19 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C4647E9D7
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:33:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  6 Feb 2017 17:32:59 +0000
Message-Id: <20170206173306.20603-10-dgilbert@redhat.com>
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/16] postcopy: Use temporary for placing
 zero huge pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The kernel can't do UFFDIO_ZEROPAGE for huge pages, so we have
to allocate a temporary (always zero) page and use UFFDIO_COPYPAGE
on it.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  1 +
 migration/postcopy-ram.c      | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index c9c1d5f..bd399fc 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -108,6 +108,7 @@ struct MigrationIncomingState {
     QEMUFile *to_src_file;
     QemuMutex rp_mutex;    /* We send replies from multiple threads */
     void     *postcopy_tmp_page;
+    void     *postcopy_tmp_zero_page;
 
     QEMUBH *bh;
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a8b7fed..4c736d2 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -324,6 +324,10 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
         munmap(mis->postcopy_tmp_page, mis->largest_page_size);
         mis->postcopy_tmp_page = NULL;
     }
+    if (mis->postcopy_tmp_zero_page) {
+        munmap(mis->postcopy_tmp_zero_page, mis->largest_page_size);
+        mis->postcopy_tmp_zero_page = NULL;
+    }
     trace_postcopy_ram_incoming_cleanup_exit();
     return 0;
 }
@@ -593,8 +597,23 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
             return -e;
         }
     } else {
-        /* TODO: The kernel can't use UFFDIO_ZEROPAGE for hugepages */
-        assert(0);
+        /* The kernel can't use UFFDIO_ZEROPAGE for hugepages */
+        if (!mis->postcopy_tmp_zero_page) {
+            mis->postcopy_tmp_zero_page = mmap(NULL, mis->largest_page_size,
+                                               PROT_READ | PROT_WRITE,
+                                               MAP_PRIVATE | MAP_ANONYMOUS,
+                                               -1, 0);
+            if (mis->postcopy_tmp_zero_page == MAP_FAILED) {
+                int e = errno;
+                mis->postcopy_tmp_zero_page = NULL;
+                error_report("%s: %s mapping large zero page",
+                             __func__, strerror(e));
+                return -e;
+            }
+            memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
+        }
+        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
+                                   pagesize);
     }
 
     return 0;
-- 
2.9.3
