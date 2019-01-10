Received: from eggs.gnu.org ([209.51.188.92]:35146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghUXE-0000ZN-Mi
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghUXD-0001k8-8i
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:13:48 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Jan 2019 01:13:25 -0600
Message-Id: <20190110071330.28136-2-eblake@redhat.com>
In-Reply-To: <20190110071330.28136-1-eblake@redhat.com>
References: <20190110071330.28136-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/6] nbd: Only require disabled bitmap for
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Our initial implementation of x-nbd-server-add-bitmap put
in a restriction because of incremental backups: in that
usage, we are exporting one qcow2 file (the temporary overlay
target of a blockdev-backup sync:none job) and a dirty bitmap
owned by a second qcow2 file (the source of the
blockdev-backup, which is the backing file of the temporary).
While both qcow2 files are still writable (the target capture
copy-on-write of old contents, the source to track live guest
writes in the meantime), the NBD client expects to see
constant data, including the dirty bitmap.  An enabled bitmap
in the source would be modified by guest writes, which is at
odds with the NBD export being a read-only constant view,
hence the initial code choice of enforcing a disabled bitmap
(the intent is that the exposed bitmap was disabled in the
same transaction that started the blockdev-backup job,
although we don't want to actually track enough state to
actually enforce that).

However, in the case of image migration, where we WANT a
writable export, it makes total sense that the NBD client
could expect writes to change the status visible through
the exposed dirty bitmap, and thus permitting an enabled
bitmap for an export that is not read-only makes sense;
although the current restriction prevents that usage.

Alternatively, consider the case when the active layer does
not contain the bitmap but the backing layer does.  If the
backing layer is read-only (which is different from the
backing layer of a blockdev-backup job being writable),
we know the backing layer cannot be modified, and thus the
bitmap will not change contents even if it is still marked
enabled (for that matter, since the backing file is
read-only, we couldn't change the bitmap to be disabled
in the first place).  Again, the current restriction
prevents this usage.

Solve both issues by gating the restriction against a
disabled bitmap to only happen when the caller has
requested a read-only export, and where the BDS that owns
the bitmap (which might be a backing file of the BDS
handed to nbd_export_new) is still writable.

Update iotest 223 to add some tests of the error paths.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: new patch
---
 nbd/server.c               |  7 +++++--
 tests/qemu-iotests/223     | 14 ++++++++++++--
 tests/qemu-iotests/223.out |  4 ++++
 3 files changed, 21 insertions(+), 4 deletions(-)

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
index 5513dc62159..f1fbb9bc1c6 100755
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
@@ -114,17 +116,23 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-a=
dd",
     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
   "arguments":{"node":"n", "name":"b"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
-  "arguments":{"node":"n", "name":"b2"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
     "data":{"path":"'"$TEST_DIR/nbd"'"}}}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments":{"device":"n"}}' "error"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
   "arguments":{"name":"n", "bitmap":"b"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
+  "arguments":{"name":"n2", "bitmap":"b2"}}' "error"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
+  "arguments":{"name":"n2"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments":{"device":"n", "name":"n2", "writable":true}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
   "arguments":{"name":"n2", "bitmap":"b2"}}' "return"

@@ -157,6 +165,8 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-r=
emove",
   "arguments":{"name":"n"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
+  "arguments":{"name":"n2"}}' "error"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"

diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 99ca172fbb8..5ed2e322e19 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -29,8 +29,11 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"error": {"class": "GenericError", "desc": "NBD server already has expo=
rt named 'n'"}}
 {"return": {}}
 {"return": {}}
+{"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompa=
tible with readonly export"}}
+{"return": {}}
 {"return": {}}
 {"return": {}}

@@ -62,6 +65,7 @@ read 2097152/2097152 bytes at offset 2097152

 {"return": {}}
 {"return": {}}
+{"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
 {"return": {}}
 {"return": {}}
 *** done
--=20
2.20.1
