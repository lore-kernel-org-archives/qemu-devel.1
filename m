Received: from eggs.gnu.org ([2001:4830:134:3::10]:53006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmJ-0004Sr-Vc
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmI-0001jH-NQ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:39 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:53 +0200
Message-Id: <20180611142611.6609-12-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 11/29] qcow2: Repair OFLAG_COPIED when fixing
 leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Repairing OFLAG_COPIED is usually safe because it is done after the
refcounts have been repaired.  Therefore, it we did not find anyone else
referencing a data or L2 cluster, it makes no sense to not set
OFLAG_COPIED -- and the other direction (clearing OFLAG_COPIED) is
always safe, anyway, it may just induce leaks.

Furthermore, if OFLAG_COPIED is actually consistent with a wrong (leaky)
refcount, we will decrement the refcount with -r leaks, but OFLAG_COPIED
will then be wrong.  qemu-img check should not produce images that are
more corrupted afterwards then they were before.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1527085
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180509200059.31125-2-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 403236256b..18c729aa27 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1799,6 +1799,19 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
     int ret;
     uint64_t refcount;
     int i, j;
+    bool repair;
+
+    if (fix & BDRV_FIX_ERRORS) {
+        /* Always repair */
+        repair = true;
+    } else if (fix & BDRV_FIX_LEAKS) {
+        /* Repair only if that seems safe: This function is always
+         * called after the refcounts have been fixed, so the refcount
+         * is accurate if that repair was successful */
+        repair = !res->check_errors && !res->corruptions && !res->leaks;
+    } else {
+        repair = false;
+    }
 
     for (i = 0; i < s->l1_size; i++) {
         uint64_t l1_entry = s->l1_table[i];
@@ -1818,10 +1831,8 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
         if ((refcount == 1) != ((l1_entry & QCOW_OFLAG_COPIED) != 0)) {
             fprintf(stderr, "%s OFLAG_COPIED L2 cluster: l1_index=%d "
                     "l1_entry=%" PRIx64 " refcount=%" PRIu64 "\n",
-                    fix & BDRV_FIX_ERRORS ? "Repairing" :
-                                            "ERROR",
-                    i, l1_entry, refcount);
-            if (fix & BDRV_FIX_ERRORS) {
+                    repair ? "Repairing" : "ERROR", i, l1_entry, refcount);
+            if (repair) {
                 s->l1_table[i] = refcount == 1
                                ? l1_entry |  QCOW_OFLAG_COPIED
                                : l1_entry & ~QCOW_OFLAG_COPIED;
@@ -1862,10 +1873,8 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                 if ((refcount == 1) != ((l2_entry & QCOW_OFLAG_COPIED) != 0)) {
                     fprintf(stderr, "%s OFLAG_COPIED data cluster: "
                             "l2_entry=%" PRIx64 " refcount=%" PRIu64 "\n",
-                            fix & BDRV_FIX_ERRORS ? "Repairing" :
-                                                    "ERROR",
-                            l2_entry, refcount);
-                    if (fix & BDRV_FIX_ERRORS) {
+                            repair ? "Repairing" : "ERROR", l2_entry, refcount);
+                    if (repair) {
                         l2_table[j] = cpu_to_be64(refcount == 1
                                     ? l2_entry |  QCOW_OFLAG_COPIED
                                     : l2_entry & ~QCOW_OFLAG_COPIED);
-- 
2.17.1
