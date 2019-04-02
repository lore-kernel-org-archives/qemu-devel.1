Received: from eggs.gnu.org ([209.51.188.92]:59587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIr0-0002Kx-6d
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqz-0003A4-7o
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  2 Apr 2019 14:49:05 +0200
Message-Id: <20190402124907.24421-8-kwolf@redhat.com>
In-Reply-To: <20190402124907.24421-1-kwolf@redhat.com>
References: <20190402124907.24421-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] block: freeze the backing chain earlier in
 stream_start()
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

Commit 6585493369819a48d34a86d57ec6b97cb5cd9bc0 added code to freeze
the backing chain from 'top' to 'base' for the duration of the
block-stream job.

The problem is that the freezing happens too late in stream_start():
during the bdrv_reopen_set_read_only() call earlier in that function
another job can jump in and remove the base image. If that happens we
have an invalid chain and QEMU crashes.

This patch puts the bdrv_freeze_backing_chain() call at the beginning
of the function.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/stream.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 6253c86fae..bfaebb861a 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -238,11 +238,16 @@ void stream_start(const char *job_id, BlockDriverSt=
ate *bs,
     BlockDriverState *iter;
     bool bs_read_only;
=20
+    if (bdrv_freeze_backing_chain(bs, base, errp) < 0) {
+        return;
+    }
+
     /* Make sure that the image is opened in read-write mode */
     bs_read_only =3D bdrv_is_read_only(bs);
     if (bs_read_only) {
         if (bdrv_reopen_set_read_only(bs, false, errp) !=3D 0) {
-            return;
+            bs_read_only =3D false;
+            goto fail;
         }
     }
=20
@@ -269,11 +274,6 @@ void stream_start(const char *job_id, BlockDriverSta=
te *bs,
                            &error_abort);
     }
=20
-    if (bdrv_freeze_backing_chain(bs, base, errp) < 0) {
-        job_early_fail(&s->common.job);
-        goto fail;
-    }
-
     s->base =3D base;
     s->backing_file_str =3D g_strdup(backing_file_str);
     s->bs_read_only =3D bs_read_only;
@@ -288,4 +288,5 @@ fail:
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
+    bdrv_unfreeze_backing_chain(bs, base);
 }
--=20
2.20.1
