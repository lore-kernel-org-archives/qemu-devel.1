Received: from eggs.gnu.org ([2001:4830:134:3::10]:40177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih65-0008WK-6n
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih62-0000Px-92
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih62-0000PE-0a
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:38 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:48 +0000
Message-Id: <20170228124056.5074-20-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 19/27] postcopy: Use temporary for placing zero
 huge pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The kernel can't do UFFDIO_ZEROPAGE for huge pages, so we have
to allocate a temporary (always zero) page and use UFFDIO_COPYPAGE
on it.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170224182844.32452-9-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h |  1 +
 migration/postcopy-ram.c      | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 08b98e9..5720c88 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -109,6 +109,7 @@ struct MigrationIncomingState {
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
