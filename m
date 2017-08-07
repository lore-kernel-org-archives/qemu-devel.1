Received: from eggs.gnu.org ([2001:4830:134:3::10]:48921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ1-0007JL-GE
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIl-0003ry-Je
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:29 +0200
Message-Id: <1502117160-24655-26-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 25/56] block/qcow2: Change
 qcow2_calc_prealloc_size() to uint64_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Change parameter @total_size and return value to uint64_t.  Callers
mix uint64_t and int64_t.  Thus, the commit reduces, but does not
eliminate implicit conversions.

qcow2_create2() passes a (presumably non-negative) int64_t argument,
then passes the result through a local variable to
qemu_opt_set_number().  Change the local variable to uint64_t to avoid
pointless conversions.

qcow2_measure() passes a uint64_t argument, then assigns the result to
int64_t (which the next commit will change to uint64_t).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/qcow2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d7c600b..d96d1f6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2613,13 +2613,13 @@ int64_t qcow2_refcount_metadata_size(int64_t clusters, size_t cluster_size,
  * Returns: Total number of bytes required for the fully allocated image
  * (including metadata).
  */
-static int64_t qcow2_calc_prealloc_size(int64_t total_size,
-                                        size_t cluster_size,
-                                        int refcount_order)
+static uint64_t qcow2_calc_prealloc_size(uint64_t total_size,
+                                         size_t cluster_size,
+                                         int refcount_order)
 {
-    int64_t meta_size = 0;
+    uint64_t meta_size = 0;
     uint64_t nl1e, nl2e;
-    int64_t aligned_total_size = align_offset(total_size, cluster_size);
+    uint64_t aligned_total_size = align_offset(total_size, cluster_size);
 
     /* header: 1 cluster */
     meta_size += cluster_size;
@@ -2729,7 +2729,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     int ret;
 
     if (prealloc == PREALLOC_MODE_FULL || prealloc == PREALLOC_MODE_FALLOC) {
-        int64_t prealloc_size =
+        uint64_t prealloc_size =
             qcow2_calc_prealloc_size(total_size, cluster_size, refcount_order);
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, prealloc_size, &error_abort);
         qemu_opt_set(opts, BLOCK_OPT_PREALLOC, PreallocMode_lookup[prealloc],
-- 
2.7.5
