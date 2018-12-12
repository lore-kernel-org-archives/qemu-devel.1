Received: from eggs.gnu.org ([2001:4830:134:3::10]:46784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZI-0003X1-VX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZE-0001mP-Sn
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:52 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:27 +0100
Message-Id: <20181212132735.16080-34-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/41] block: Use bdrv_reopen_set_read_only() in
 the mirror driver
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

The 'block-commit' QMP command is implemented internally using two
different drivers. If the source image is the active layer then the
mirror driver is used (commit_active_start()), otherwise the commit
driver is used (commit_start()).

In both cases the destination image must be put temporarily in
read-write mode. This is done correctly in the latter case, but what
commit_active_start() does is copy all flags instead.

This patch replaces the bdrv_reopen() calls in that function with
bdrv_reopen_set_read_only() so that only the read-only status is
changed.

A similar change is made in mirror_exit(), which is also used by the
'drive-mirror' and 'blockdev-mirror' commands.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 8f52c6215d..628f9e6a0b 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -669,9 +669,10 @@ static int mirror_exit_common(Job *job)
=20
     if (s->should_complete && !abort) {
         BlockDriverState *to_replace =3D s->to_replace ?: src;
+        bool ro =3D bdrv_is_read_only(to_replace);
=20
-        if (bdrv_get_flags(target_bs) !=3D bdrv_get_flags(to_replace)) {
-            bdrv_reopen(target_bs, bdrv_get_flags(to_replace), NULL);
+        if (ro !=3D bdrv_is_read_only(target_bs)) {
+            bdrv_reopen_set_read_only(target_bs, ro, NULL);
         }
=20
         /* The mirror job has no requests in flight any more, but we nee=
d to
@@ -1689,13 +1690,15 @@ void commit_active_start(const char *job_id, Bloc=
kDriverState *bs,
                          BlockCompletionFunc *cb, void *opaque,
                          bool auto_complete, Error **errp)
 {
-    int orig_base_flags;
+    bool base_read_only;
     Error *local_err =3D NULL;
=20
-    orig_base_flags =3D bdrv_get_flags(base);
+    base_read_only =3D bdrv_is_read_only(base);
=20
-    if (bdrv_reopen(base, bs->open_flags, errp)) {
-        return;
+    if (base_read_only) {
+        if (bdrv_reopen_set_read_only(base, false, errp) < 0) {
+            return;
+        }
     }
=20
     mirror_start_job(job_id, bs, creation_flags, base, NULL, speed, 0, 0=
,
@@ -1714,6 +1717,8 @@ void commit_active_start(const char *job_id, BlockD=
riverState *bs,
 error_restore_flags:
     /* ignore error and errp for bdrv_reopen, because we want to propaga=
te
      * the original error */
-    bdrv_reopen(base, orig_base_flags, NULL);
+    if (base_read_only) {
+        bdrv_reopen_set_read_only(base, true, NULL);
+    }
     return;
 }
--=20
2.19.2
