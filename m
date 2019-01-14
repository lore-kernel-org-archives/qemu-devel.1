Received: from eggs.gnu.org ([209.51.188.92]:57979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj556-0004Nx-G2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj555-0005iu-Cg
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:27:20 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:26:00 -0600
Message-Id: <20190114162605.5330-16-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/20] nbd: Only require disabled bitmap for
 read-only exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Our initial implementation of x-nbd-server-add-bitmap put
in a restriction because of incremental backups: in that
usage, we are exporting one qcow2 file (the temporary overlay
target of a blockdev-backup sync:none job) and a dirty bitmap
owned by a second qcow2 file (the source of the
blockdev-backup, which is the backing file of the temporary).
While both qcow2 files are still writable (the target in
order to capture copy-on-write of old contents, and the
source in order to track live guest writes in the meantime),
the NBD client expects to see constant data, including the
dirty bitmap.  An enabled bitmap in the source would be
modified by guest writes, which is at odds with the NBD
export being a read-only constant view, hence the initial
code choice of enforcing a disabled bitmap (the intent is
that the exposed bitmap was disabled in the same transaction
that started the blockdev-backup job, although we don't want
to track enough state to actually enforce that).

However, consider the case of a bitmap contained in a read-only
node (including when the bitmap is found in a backing layer of
the active image).  Because the node can't be modified, the
bitmap won't change due to writes, regardless of whether it is
still enabled.  Forbidding the export unless the bitmap is
disabled is awkward, paritcularly since we can't change the
bitmap to be disabled (because the node is read-only).

Alternatively, consider the case of live storage migration,
where management directs the destination to create a writable
NBD server, then performs a drive-mirror from the source to
the target, prior to doing the rest of the live migration.
Since storage migration can be time-consuming, it may be wise
to let the destination include a dirty bitmap to track which
portions it has already received, where even if the migration
is interrupted and restarted, the source can query the
destination block status in order to potentially minimize
re-sending data that has not changed in the meantime on a
second attempt. Such code has not been written, and might not
be trivial (after all, a cluster being marked dirty in the
bitmap does not necessarily guarantee it has the desired
contents), but it makes sense that letting an active dirty
bitmap be exposed and changing alongside writes may prove
useful in the future.

Solve both issues by gating the restriction against a
disabled bitmap to only happen when the caller has requested
a read-only export, and where the BDS that owns the bitmap
(whether or not it is the BDS handed to nbd_export_new() or
from its backing chain) is still writable.  We could drop
the check altogether (if management apps are prepared to
deal with a changing bitmap even on a read-only image), but
for now keeping a check for the read-only case still stands
a chance of preventing management errors.

Update iotest 223 to show the looser behavior by leaving
a bitmap enabled the whole run; note that we have to tear
down and re-export a node when handling an error.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190111194720.15671-4-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c               |  7 +++++--
 tests/qemu-iotests/223     | 10 +++++++---
 tests/qemu-iotests/223.out |  3 ++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 7af0ddffb20..98327088cb4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2456,8 +2456,11 @@ void nbd_export_bitmap(NBDExport *exp, const char =
*bitmap,
         return;
     }

-    if (bdrv_dirty_bitmap_enabled(bm)) {
-        error_setg(errp, "Bitmap '%s' is enabled", bitmap);
+    if ((exp->nbdflags & NBD_FLAG_READ_ONLY) && bdrv_is_writable(bs) &&
+        bdrv_dirty_bitmap_enabled(bm)) {
+        error_setg(errp,
+                   "Enabled bitmap '%s' incompatible with readonly expor=
t",
+                   bitmap);
         return;
     }

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index a4016091b21..f200e313c06 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -61,6 +61,8 @@ echo "=3D=3D=3D Create partially sparse image, then add=
 dirty bitmaps =3D=3D=3D"
 echo

 # Two bitmaps, to contrast granularity issues
+# Also note that b will be disabled, while b2 is left enabled, to
+# check for read-only interactions
 _make_test_img -o cluster_size=3D4k 4M
 $QEMU_IO -c 'w -P 0x11 1M 2M' "$TEST_IMG" | _filter_qemu_io
 run_qemu <<EOF
@@ -134,9 +136,11 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-serve=
r-add-bitmap",
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
-  "arguments":{"name":"n2", "bitmap":"b2"}}' "error" # Attempt enabled b=
itmap
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
-  "arguments":{"node":"n", "name":"b2"}}' "return"
+  "arguments":{"name":"n2", "bitmap":"b2"}}' "error" # Enabled vs. read-=
only
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
+  "arguments":{"name":"n2"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments":{"device":"n", "name":"n2", "writable":true}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
   "arguments":{"name":"n2", "bitmap":"b2"}}' "return"

diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 8a4d63a4fc2..7d147291d48 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -35,7 +35,8 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"error": {"class": "GenericError", "desc": "NBD server already has expo=
rt named 'n'"}}
 {"return": {}}
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Bitmap 'b2' is enabled"}}
+{"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompa=
tible with readonly export"}}
+{"return": {}}
 {"return": {}}
 {"return": {}}

--=20
2.20.1
