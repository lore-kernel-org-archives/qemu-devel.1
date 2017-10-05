Received: from eggs.gnu.org ([2001:4830:134:3::10]:35218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1e0460-0001tl-7a
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1e045w-00064V-T4
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:13:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1e045w-00061S-Jf
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:13:36 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Thu, 05 Oct 2017 14:13:18 +0300
Message-id: <1507202000-22469-2-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1507202000-22469-1-git-send-email-a.perevalov@samsung.com>
References: <1507202000-22469-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171005111331eucas1p101ded202416dd25d9246876264938d55@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH v10 1/3] migration: postcopy_place_page
 factoring out
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com

Need to mark copied pages as closer as possible to the place where it
tracks down. That will be necessary in futher patch.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 13 +++++++------
 migration/postcopy-ram.h |  4 ++--
 migration/ram.c          |  4 ++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 0de68e8..d3073b9 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -646,9 +646,10 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
  * returns 0 on success
  */
 int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
-                        size_t pagesize)
+                        RAMBlock *rb)
 {
     struct uffdio_copy copy_struct;
+    size_t pagesize = qemu_ram_pagesize(rb);
 
     copy_struct.dst = (uint64_t)(uintptr_t)host;
     copy_struct.src = (uint64_t)(uintptr_t)from;
@@ -677,11 +678,11 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
  * returns 0 on success
  */
 int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
-                             size_t pagesize)
+                             RAMBlock *rb)
 {
     trace_postcopy_place_page_zero(host);
 
-    if (pagesize == getpagesize()) {
+    if (qemu_ram_pagesize(rb) == getpagesize()) {
         struct uffdio_zeropage zero_struct;
         zero_struct.range.start = (uint64_t)(uintptr_t)host;
         zero_struct.range.len = getpagesize();
@@ -711,7 +712,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
             memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
         }
         return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
-                                   pagesize);
+                                   rb);
     }
 
     return 0;
@@ -774,14 +775,14 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 }
 
 int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
-                        size_t pagesize)
+                        RAMBlock *rb)
 {
     assert(0);
     return -1;
 }
 
 int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
-                        size_t pagesize)
+                        RAMBlock *rb)
 {
     assert(0);
     return -1;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 587a8b8..77ea0fd 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -72,14 +72,14 @@ void postcopy_discard_send_finish(MigrationState *ms,
  * returns 0 on success
  */
 int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
-                        size_t pagesize);
+                        RAMBlock *rb);
 
 /*
  * Place a zero page at (host) atomically
  * returns 0 on success
  */
 int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
-                             size_t pagesize);
+                             RAMBlock *rb);
 
 /* The current postcopy state is read/set by postcopy_state_get/set
  * which update it atomically.
diff --git a/migration/ram.c b/migration/ram.c
index b83f897..304ac59 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2680,10 +2680,10 @@ static int ram_load_postcopy(QEMUFile *f)
 
             if (all_zero) {
                 ret = postcopy_place_page_zero(mis, place_dest,
-                                               block->page_size);
+                                               block);
             } else {
                 ret = postcopy_place_page(mis, place_dest,
-                                          place_source, block->page_size);
+                                          place_source, block);
             }
         }
         if (!ret) {
-- 
2.7.4
