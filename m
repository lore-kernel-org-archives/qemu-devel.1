Received: from eggs.gnu.org ([2001:4830:134:3::10]:51458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhvx-0001gJ-Lx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhvr-0002PW-A6
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:40:58 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:22 +0100
Message-Id: <20181105163744.25139-15-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/36] quorum: Remove quorum_err()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This is a static function with only one caller, so there's no need to
keep it. Inlining the code in quorum_compare() makes it much simpler.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/quorum.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index eb526cc0f1..b1b777baef 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -437,23 +437,7 @@ static bool quorum_iovec_compare(QEMUIOVector *a, QE=
MUIOVector *b)
     return true;
 }
=20
-static void GCC_FMT_ATTR(2, 3) quorum_err(QuorumAIOCB *acb,
-                                          const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    fprintf(stderr, "quorum: offset=3D%" PRIu64 " bytes=3D%" PRIu64 " ",
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
+static bool quorum_compare(QuorumAIOCB *acb, QEMUIOVector *a, QEMUIOVect=
or *b)
 {
     BDRVQuorumState *s =3D acb->bs->opaque;
     ssize_t offset;
@@ -462,8 +446,10 @@ static bool quorum_compare(QuorumAIOCB *acb,
     if (s->is_blkverify) {
         offset =3D qemu_iovec_compare(a, b);
         if (offset !=3D -1) {
-            quorum_err(acb, "contents mismatch at offset %" PRIu64,
-                       acb->offset + offset);
+            fprintf(stderr, "quorum: offset=3D%" PRIu64 " bytes=3D%" PRI=
u64
+                    " contents mismatch at offset %" PRIu64 "\n",
+                    acb->offset, acb->bytes, acb->offset + offset);
+            exit(1);
         }
         return true;
     }
--=20
2.19.1
