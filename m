Received: from eggs.gnu.org ([2001:4830:134:3::10]:52823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dKiGz-00057m-1z
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dKiGs-0006cV-Sl
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:38:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dKiGs-0006bw-KO
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:37:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORH00DNTC36QV60@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:37:54 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 13 Jun 2017 12:36:32 +0300
Message-id: <1497346593-8791-2-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1497346593-8791-1-git-send-email-a.perevalov@samsung.com>
References: <1497346593-8791-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170613093753eucas1p29b7c5af3605c6d80ca82ef7dadff56da@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v1 1/2] migration: postcopy_place_page
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

Need to mark copied pages as closer as possible to the place where it
tracks down. That will be necessary in futher patch.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 13 ++++++++-----
 migration/postcopy-ram.h |  4 ++--
 migration/ram.c          |  4 ++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9c41887..f6244ee 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -566,9 +566,10 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
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
@@ -597,10 +598,12 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
  * returns 0 on success
  */
 int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
-                             size_t pagesize)
+                             RAMBlock *rb)
 {
+    size_t pagesize;
     trace_postcopy_place_page_zero(host);
 
+    pagesize = qemu_ram_pagesize(rb);
     if (pagesize == getpagesize()) {
         struct uffdio_zeropage zero_struct;
         zero_struct.range.start = (uint64_t)(uintptr_t)host;
@@ -631,7 +634,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
             memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
         }
         return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
-                                   pagesize);
+                                   rb);
     }
 
     return 0;
@@ -694,14 +697,14 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
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
index 52d51e8..78a3591 100644
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
index f387e9c..4ed7c2c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2503,10 +2503,10 @@ static int ram_load_postcopy(QEMUFile *f)
 
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
1.9.1
