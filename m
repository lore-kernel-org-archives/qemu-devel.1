Received: from eggs.gnu.org ([2001:4830:134:3::10]:46863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZL-0003aY-E2
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZK-0001rj-C7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:30 +0100
Message-Id: <20181212132735.16080-37-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 36/41] block: Clean up reopen_backing_file() in
 block/replication.c
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

This function is used to put the hidden and secondary disks in
read-write mode before launching the backup job, and back in read-only
mode afterwards.

This patch does the following changes:

  - Use an options QDict with the "read-only" option instead of
    passing the changes as flags only.

  - Simplify the code (it was unnecessarily complicated and verbose).

  - Fix a bug due to which the secondary disk was not being put back
    in read-only mode when writable=3Dfalse (because in this case
    orig_secondary_flags always had the BDRV_O_RDWR flag set).

  - Stop clearing the BDRV_O_INACTIVE flag.

The flags parameter to bdrv_reopen_queue() becomes redundant and we'll
be able to get rid of it in a subsequent patch.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/replication.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 0c2989d2cb..af9dba8696 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -20,6 +20,7 @@
 #include "block/block_backup.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "replication.h"
=20
 typedef enum {
@@ -39,8 +40,8 @@ typedef struct BDRVReplicationState {
     char *top_id;
     ReplicationState *rs;
     Error *blocker;
-    int orig_hidden_flags;
-    int orig_secondary_flags;
+    bool orig_hidden_read_only;
+    bool orig_secondary_read_only;
     int error;
 } BDRVReplicationState;
=20
@@ -349,44 +350,40 @@ static void secondary_do_checkpoint(BDRVReplication=
State *s, Error **errp)
     }
 }
=20
+/* This function is supposed to be called twice:
+ * first with writable =3D true, then with writable =3D false.
+ * The first call puts s->hidden_disk and s->secondary_disk in
+ * r/w mode, and the second puts them back in their original state.
+ */
 static void reopen_backing_file(BlockDriverState *bs, bool writable,
                                 Error **errp)
 {
     BDRVReplicationState *s =3D bs->opaque;
     BlockReopenQueue *reopen_queue =3D NULL;
-    int orig_hidden_flags, orig_secondary_flags;
-    int new_hidden_flags, new_secondary_flags;
     Error *local_err =3D NULL;
=20
     if (writable) {
-        orig_hidden_flags =3D s->orig_hidden_flags =3D
-                                bdrv_get_flags(s->hidden_disk->bs);
-        new_hidden_flags =3D (orig_hidden_flags | BDRV_O_RDWR) &
-                                                    ~BDRV_O_INACTIVE;
-        orig_secondary_flags =3D s->orig_secondary_flags =3D
-                                bdrv_get_flags(s->secondary_disk->bs);
-        new_secondary_flags =3D (orig_secondary_flags | BDRV_O_RDWR) &
-                                                     ~BDRV_O_INACTIVE;
-    } else {
-        orig_hidden_flags =3D (s->orig_hidden_flags | BDRV_O_RDWR) &
-                                                    ~BDRV_O_INACTIVE;
-        new_hidden_flags =3D s->orig_hidden_flags;
-        orig_secondary_flags =3D (s->orig_secondary_flags | BDRV_O_RDWR)=
 &
-                                                    ~BDRV_O_INACTIVE;
-        new_secondary_flags =3D s->orig_secondary_flags;
+        s->orig_hidden_read_only =3D bdrv_is_read_only(s->hidden_disk->b=
s);
+        s->orig_secondary_read_only =3D bdrv_is_read_only(s->secondary_d=
isk->bs);
     }
=20
     bdrv_subtree_drained_begin(s->hidden_disk->bs);
     bdrv_subtree_drained_begin(s->secondary_disk->bs);
=20
-    if (orig_hidden_flags !=3D new_hidden_flags) {
-        reopen_queue =3D bdrv_reopen_queue(reopen_queue, s->hidden_disk-=
>bs, NULL,
-                                         new_hidden_flags);
+    if (s->orig_hidden_read_only) {
+        int flags =3D bdrv_get_flags(s->hidden_disk->bs);
+        QDict *opts =3D qdict_new();
+        qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
+        reopen_queue =3D bdrv_reopen_queue(reopen_queue, s->hidden_disk-=
>bs,
+                                         opts, flags);
     }
=20
-    if (!(orig_secondary_flags & BDRV_O_RDWR)) {
+    if (s->orig_secondary_read_only) {
+        int flags =3D bdrv_get_flags(s->secondary_disk->bs);
+        QDict *opts =3D qdict_new();
+        qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
         reopen_queue =3D bdrv_reopen_queue(reopen_queue, s->secondary_di=
sk->bs,
-                                         NULL, new_secondary_flags);
+                                         opts, flags);
     }
=20
     if (reopen_queue) {
--=20
2.19.2
