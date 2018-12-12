Received: from eggs.gnu.org ([2001:4830:134:3::10]:46636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZA-0003Ng-6I
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z9-0001gr-6k
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:22 +0100
Message-Id: <20181212132735.16080-29-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/41] block: Use bdrv_reopen_set_read_only() in
 commit_start/complete()
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
 block/commit.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index a2da5740b0..a53c2d04b0 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -38,7 +38,7 @@ typedef struct CommitBlockJob {
     BlockBackend *base;
     BlockDriverState *base_bs;
     BlockdevOnError on_error;
-    int base_flags;
+    bool base_read_only;
     char *backing_file_str;
 } CommitBlockJob;
=20
@@ -124,8 +124,8 @@ static void commit_clean(Job *job)
     /* restore base open flags here if appropriate (e.g., change the bas=
e back
      * to r/o). These reopens do not need to be atomic, since we won't a=
bort
      * even on failure here */
-    if (s->base_flags !=3D bdrv_get_flags(s->base_bs)) {
-        bdrv_reopen(s->base_bs, s->base_flags, NULL);
+    if (s->base_read_only) {
+        bdrv_reopen_set_read_only(s->base_bs, true, NULL);
     }
=20
     g_free(s->backing_file_str);
@@ -264,7 +264,6 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
                   const char *filter_node_name, Error **errp)
 {
     CommitBlockJob *s;
-    int orig_base_flags;
     BlockDriverState *iter;
     BlockDriverState *commit_top_bs =3D NULL;
     Error *local_err =3D NULL;
@@ -283,11 +282,9 @@ void commit_start(const char *job_id, BlockDriverSta=
te *bs,
     }
=20
     /* convert base to r/w, if necessary */
-    orig_base_flags =3D bdrv_get_flags(base);
-    if (!(orig_base_flags & BDRV_O_RDWR)) {
-        bdrv_reopen(base, orig_base_flags | BDRV_O_RDWR, &local_err);
-        if (local_err !=3D NULL) {
-            error_propagate(errp, local_err);
+    s->base_read_only =3D bdrv_is_read_only(base);
+    if (s->base_read_only) {
+        if (bdrv_reopen_set_read_only(base, false, errp) !=3D 0) {
             goto fail;
         }
     }
@@ -363,7 +360,6 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
         goto fail;
     }
=20
-    s->base_flags =3D orig_base_flags;
     s->backing_file_str =3D g_strdup(backing_file_str);
     s->on_error =3D on_error;
=20
--=20
2.19.2
