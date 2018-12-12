Received: from eggs.gnu.org ([2001:4830:134:3::10]:46675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZB-0003PF-FG
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZA-0001iJ-Ed
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:24 +0100
Message-Id: <20181212132735.16080-31-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/41] block: Use bdrv_reopen_set_read_only() in
 stream_start/complete()
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

This patch replaces the bdrv_reopen() calls that set and remove the
BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/stream.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 81a7ec8ece..7a49ac0992 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -34,7 +34,7 @@ typedef struct StreamBlockJob {
     BlockDriverState *base;
     BlockdevOnError on_error;
     char *backing_file_str;
-    int bs_flags;
+    bool bs_read_only;
 } StreamBlockJob;
=20
 static int coroutine_fn stream_populate(BlockBackend *blk,
@@ -89,10 +89,10 @@ static void stream_clean(Job *job)
     BlockDriverState *bs =3D blk_bs(bjob->blk);
=20
     /* Reopen the image back in read-only mode if necessary */
-    if (s->bs_flags !=3D bdrv_get_flags(bs)) {
+    if (s->bs_read_only) {
         /* Give up write permissions before making it read-only */
         blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
-        bdrv_reopen(bs, s->bs_flags, NULL);
+        bdrv_reopen_set_read_only(bs, true, NULL);
     }
=20
     g_free(s->backing_file_str);
@@ -226,12 +226,12 @@ void stream_start(const char *job_id, BlockDriverSt=
ate *bs,
 {
     StreamBlockJob *s;
     BlockDriverState *iter;
-    int orig_bs_flags;
+    bool bs_read_only;
=20
     /* Make sure that the image is opened in read-write mode */
-    orig_bs_flags =3D bdrv_get_flags(bs);
-    if (!(orig_bs_flags & BDRV_O_RDWR)) {
-        if (bdrv_reopen(bs, orig_bs_flags | BDRV_O_RDWR, errp) !=3D 0) {
+    bs_read_only =3D bdrv_is_read_only(bs);
+    if (bs_read_only) {
+        if (bdrv_reopen_set_read_only(bs, false, errp) !=3D 0) {
             return;
         }
     }
@@ -261,7 +261,7 @@ void stream_start(const char *job_id, BlockDriverStat=
e *bs,
=20
     s->base =3D base;
     s->backing_file_str =3D g_strdup(backing_file_str);
-    s->bs_flags =3D orig_bs_flags;
+    s->bs_read_only =3D bs_read_only;
=20
     s->on_error =3D on_error;
     trace_stream_start(bs, base, s);
@@ -269,7 +269,7 @@ void stream_start(const char *job_id, BlockDriverStat=
e *bs,
     return;
=20
 fail:
-    if (orig_bs_flags !=3D bdrv_get_flags(bs)) {
-        bdrv_reopen(bs, orig_bs_flags, NULL);
+    if (bs_read_only) {
+        bdrv_reopen_set_read_only(bs, true, NULL);
     }
 }
--=20
2.19.2
