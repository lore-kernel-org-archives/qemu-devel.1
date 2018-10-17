Received: from eggs.gnu.org ([2001:4830:134:3::10]:52845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCmuJ-0000DB-6F
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCmuF-0006FJ-3R
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:34:43 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 17:33:49 +0300
Message-Id: <efa8a2cd5ef6414103f05307b167a70e34405c13.1539786605.git.berto@igalia.com>
In-Reply-To: <cover.1539786605.git.berto@igalia.com>
References: <cover.1539786605.git.berto@igalia.com>
In-Reply-To: <cover.1539786605.git.berto@igalia.com>
References: <cover.1539786605.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/3] quorum: Remove quorum_err()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is a static function with only one caller, so there's no need to
keep it. Inlining the code in quorum_compare() makes it much simpler.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reported-by: Markus Armbruster <armbru@redhat.com>
---
 block/quorum.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index eb526cc0f1..b1b777baef 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -437,23 +437,7 @@ static bool quorum_iovec_compare(QEMUIOVector *a, QEMUIOVector *b)
     return true;
 }
 
-static void GCC_FMT_ATTR(2, 3) quorum_err(QuorumAIOCB *acb,
-                                          const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    fprintf(stderr, "quorum: offset=%" PRIu64 " bytes=%" PRIu64 " ",
-            acb->offset, acb->bytes);
-    vfprintf(stderr, fmt, ap);
-    fprintf(stderr, "\n");
-    va_end(ap);
-    exit(1);
-}
-
-static bool quorum_compare(QuorumAIOCB *acb,
-                           QEMUIOVector *a,
-                           QEMUIOVector *b)
+static bool quorum_compare(QuorumAIOCB *acb, QEMUIOVector *a, QEMUIOVector *b)
 {
     BDRVQuorumState *s = acb->bs->opaque;
     ssize_t offset;
@@ -462,8 +446,10 @@ static bool quorum_compare(QuorumAIOCB *acb,
     if (s->is_blkverify) {
         offset = qemu_iovec_compare(a, b);
         if (offset != -1) {
-            quorum_err(acb, "contents mismatch at offset %" PRIu64,
-                       acb->offset + offset);
+            fprintf(stderr, "quorum: offset=%" PRIu64 " bytes=%" PRIu64
+                    " contents mismatch at offset %" PRIu64 "\n",
+                    acb->offset, acb->bytes, acb->offset + offset);
+            exit(1);
         }
         return true;
     }
-- 
2.11.0
