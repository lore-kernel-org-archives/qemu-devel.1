Received: from eggs.gnu.org ([2001:4830:134:3::10]:54600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVi-000483-KJ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVf-0000tq-Ua
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:64129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIVVf-0000sV-OQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR600GH42G7KQ80@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:36:07 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 07 Jun 2017 10:35:28 +0300
Message-id: <1496820931-27416-9-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
References: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607073605eucas1p23406b53a5ee9282d8440dae03ecc5273@eucas1p2.samsung.com>
Subject: [Qemu-devel] [[PATCH V7] 08/11] migration: postcopy_place_page
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, dgilbert@redhat.com, i.maximets@samsung.com, peterx@redhat.com

Need to set copied bitmap as closer as possible to mark_postcopy_blocktime_end.
So postcopy_place_page is proper place. RAMBlock argument here could avoid
additional RAMBlock lookup as well as reduce number of arguments
(no need to pass pointer to copied bitmap).

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 13 ++++++++-----
 migration/postcopy-ram.h |  4 ++--
 migration/ram.c          |  4 ++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index ade7f1c..62a272a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -713,9 +713,10 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
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
@@ -744,10 +745,12 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
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
@@ -778,7 +781,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
             memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
         }
         return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
-                                   pagesize);
+                                   rb);
     }
 
     return 0;
@@ -841,14 +844,14 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
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
index a7c0db4..a791d40 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2524,10 +2524,10 @@ static int ram_load_postcopy(QEMUFile *f)
 
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
