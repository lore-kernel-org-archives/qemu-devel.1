Received: from eggs.gnu.org ([209.51.188.92]:38913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gh5Go-0006LE-SE
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gh5Gm-0005gO-PH
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:15:10 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  8 Jan 2019 22:14:49 -0600
Message-Id: <20190109041452.31240-3-eblake@redhat.com>
In-Reply-To: <20190109041452.31240-1-eblake@redhat.com>
References: <20190109041452.31240-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/5] nbd: Allow bitmap export during QMP
 nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

With the experimental x-nbd-server-add-bitmap command, there was
a window of time where a client could see the export but not the
associated dirty bitmap, which can cause a client that planned
on using the dirty bitmap to be forced to treat the entire image
as dirty as a safety fallback.  Furthermore, if the QMP client
successfully exports a disk but then fails to add the bitmap, it
has to take on the burden of removing the export.  Since we don't
allow changing a dirty bitmap once it is exported (whether to a
different bitmap, or removing advertisement of the bitmap), it is
nicer to make the bitmap tied to the export at the time the export
is created, and automatically failing to export if the bitmap is
not available.

Since there is working libvirt demo code that uses both the bitmap
export and the ability to specify an alternative name (rather than
exposing the private-use bitmap that libvirt created to merge in
several persistent bitmaps when doing a differential backup), the
two new parameters do not need to be marked experimental.  See
https://www.redhat.com/archives/libvir-list/2018-October/msg01254.html,
https://kvmforum2018.sched.com/event/FzuB/facilitating-incremental-backup=
-eric-blake-red-hat

This patch focuses on the user interface, and reduces (but does
not completely eliminate) the window where an NBD client can see
the export but not the dirty bitmap.  Later patches will add
further cleanups now that this interface is available.

Update test 223 to use the new interface.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block.json            | 12 +++++++++++-
 blockdev-nbd.c             | 27 ++++++++++++++++++++++++++-
 hmp.c                      |  6 ++++--
 tests/qemu-iotests/223     | 11 ++++-------
 tests/qemu-iotests/223.out |  2 --
 5 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 11f01f28efe..4b336303d21 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -246,6 +246,15 @@
 #
 # @writable: Whether clients should be able to write to the device via t=
he
 #     NBD connection (default false).
+
+# @bitmap: Dirty bitmap to associate with the selected export. The expor=
t
+#          must be read-only, and the given bitmap is locked until the
+#          export is removed. (since 4.0)
+#
+# @bitmap-export-name: How the bitmap will be seen by nbd clients
+#                      (default @bitmap). The NBD client must use
+#                      NBD_OPT_SET_META_CONTEXT with "qemu:dirty-bitmap:=
NAME"
+#                      to access the exposed bitmap. (since 4.0)
 #
 # Returns: error if the server is not running, or export with the same n=
ame
 #          already exists.
@@ -253,7 +262,8 @@
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-add',
-  'data': {'device': 'str', '*name': 'str', '*writable': 'bool'} }
+  'data': {'device': 'str', '*name': 'str', '*writable': 'bool',
+           '*bitmap': 'str', '*bitmap-export-name': 'str' } }

 ##
 # @NbdServerRemoveMode:
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index f5edbc27d88..cae9e802d48 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -140,7 +140,10 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
 }

 void qmp_nbd_server_add(const char *device, bool has_name, const char *n=
ame,
-                        bool has_writable, bool writable, Error **errp)
+                        bool has_writable, bool writable,
+                        bool has_bitmap, const char *bitmap,
+                        bool has_bitmap_export_name,
+                        const char *bitmap_export_name, Error **errp)
 {
     BlockDriverState *bs =3D NULL;
     BlockBackend *on_eject_blk;
@@ -160,6 +163,17 @@ void qmp_nbd_server_add(const char *device, bool has=
_name, const char *name,
         return;
     }

+    if (has_bitmap_export_name && !has_bitmap) {
+        error_setg(errp, "Choosing bitmap export name '%s' requires a bi=
tmap",
+                   bitmap_export_name);
+        return;
+    }
+    if (has_bitmap && writable) {
+        error_setg(errp, "Cannot export bitmap '%s' on writable export",
+                   bitmap);
+        return;
+    }
+
     on_eject_blk =3D blk_by_name(device);

     bs =3D bdrv_lookup_bs(device, device, errp);
@@ -185,6 +199,17 @@ void qmp_nbd_server_add(const char *device, bool has=
_name, const char *name,
      * our only way of accessing it is through nbd_export_find(), so we =
can drop
      * the strong reference that is @exp. */
     nbd_export_put(exp);
+
+    if (has_bitmap) {
+        Error *err =3D NULL;
+        nbd_export_bitmap(exp, bitmap,
+                          has_bitmap_export_name ? bitmap_export_name : =
bitmap,
+                          &err);
+        if (err) {
+            error_propagate(errp, err);
+            nbd_export_remove(exp, NBD_SERVER_REMOVE_MODE_HARD, NULL);
+        }
+    }
 }

 void qmp_nbd_server_remove(const char *name,
diff --git a/hmp.c b/hmp.c
index 80aa5ab504b..484a0000de1 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2326,7 +2326,8 @@ void hmp_nbd_server_start(Monitor *mon, const QDict=
 *qdict)
         }

         qmp_nbd_server_add(info->value->device, false, NULL,
-                           true, writable, &local_err);
+                           true, writable, false, NULL, false, NULL,
+                           &local_err);

         if (local_err !=3D NULL) {
             qmp_nbd_server_stop(NULL);
@@ -2347,7 +2348,8 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *=
qdict)
     bool writable =3D qdict_get_try_bool(qdict, "writable", false);
     Error *local_err =3D NULL;

-    qmp_nbd_server_add(device, !!name, name, true, writable, &local_err)=
;
+    qmp_nbd_server_add(device, !!name, name, true, writable,
+                       false, NULL, false, NULL, &local_err);
     hmp_handle_error(mon, &local_err);
 }

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 5513dc62159..7a92c3018e2 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -120,13 +120,10 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server=
-start",
   "arguments":{"addr":{"type":"unix",
     "data":{"path":"'"$TEST_DIR/nbd"'"}}}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
-  "arguments":{"device":"n"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
-  "arguments":{"name":"n", "bitmap":"b"}}' "return"
+  "arguments":{"device":"n", "bitmap":"b"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
-  "arguments":{"device":"n", "name":"n2"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
-  "arguments":{"name":"n2", "bitmap":"b2"}}' "return"
+  "arguments":{"device":"n", "name":"n2", "bitmap":"b2",
+    "bitmap-export-name":"b3"}}' "return"

 echo
 echo "=3D=3D=3D Contrast normal status to large granularity dirty-bitmap=
 =3D=3D=3D"
@@ -147,7 +144,7 @@ echo

 IMG=3D"driver=3Dnbd,export=3Dn2,server.type=3Dunix,server.path=3D$TEST_D=
IR/nbd"
 $QEMU_IMG map --output=3Djson --image-opts \
-  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b2" | _filter_qemu_img_map
+  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b3" | _filter_qemu_img_map

 echo
 echo "=3D=3D=3D End NBD server =3D=3D=3D"
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 99ca172fbb8..0e467981bb8 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -31,8 +31,6 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": {}}
-{"return": {}}

 =3D=3D=3D Contrast normal status to large granularity dirty-bitmap =3D=3D=
=3D

--=20
2.20.1
